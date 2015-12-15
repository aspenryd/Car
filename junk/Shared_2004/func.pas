{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13816: func.pas 
{
{   Rev 1.0    2004-01-30 14:44:22  peter
{ Fixat journal + kontering + + + +
}
unit func;

interface

uses
  ADODB, Classes;

procedure SetDS(var ds: TADOQuery; SQL: string);
function CreateDS(SQL: string): TADOQuery;
function ExecDS(ds: TADOQuery): Integer;
procedure FreeDS(ds: TADOQuery);
procedure WriteDebug(Level, s: string);
procedure FreeListOfObjects(l: Tlist);
function GetNextNumberFromParam(CounterName: string): Integer;

procedure MoveCSub2Faktura(subid: Integer);



var
  tmpDs: TADOQuery;

implementation

uses
  DmSession, SysUtils;

procedure SetDS(var ds: TADOQuery; SQL: string);
begin
  ds.Active := False;
  ds.SQL.Clear;
  ds.SQL.Add(SQL);
end;

function CreateDS(SQL: string): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  TADOQuery(Result).ConnectionString := dmod1.ADOConnection1.ConnectionString;
  TADOQuery(Result).Connection := dmod1.ADOConnection1;
  SetDS(Result, SQL);
end;

function ExecDS(ds: TADOQuery): Integer;
begin
  TADOQuery(ds).ExecSQL;
  Result := TADOQuery(ds).RowsAffected;
end;

procedure FreeDS(ds: TADOQuery);
begin
  if not assigned(ds) then
    exit;
  try
    TADOQuery(ds).Active := False;
  except
    try
      TADOQuery(ds).Active := False;
    except
      try
        TADOQuery(ds).Active := False;
      except
        WriteDebug('System', 'Fel i FreeDS')
      end;
    end;
  end;
  TADOQuery(ds).Free;
  ds := nil;
end;

procedure WriteDebug(Level, s: string);
begin

end;

procedure FreeListOfObjects(l: Tlist);
var
  i: Integer;
begin
  i := l.Count - 1;
  while i > 0 do
  begin
    TComponent(l[i]).Free;
    l.Delete(i);
    dec(i);
  end;
end;

function GetNextNumberFromParam(CounterName: string): Integer;
begin
  if not Assigned(tmpDS) then
    tmpDs := CreateDS('');
  SetDS(tmpDs, Format('UPDATE PARAM SET %s=%s+1'#13'SELECT %s FROM PARAM', [CounterName, CounterName, CounterName]));
  tmpDs.Open;
  Result := tmpDs.Fields[0].AsInteger;
  tmpDs.Close;
end;


procedure SkapaKonteringar(ds: TADOQuery; typ, nr, konto, kstalle: integer; debet, kredit: Double);
begin
  if (debet = 0) and (kredit = 0) then
    exit;

  if Debet < 0 then
  begin
    Kredit := Kredit - Debet;
    Debet := 0;
  end;
  if Kredit < 0 then
  begin
    Debet := Debet - Kredit;
    Kredit := 0;
  end;
  SetDS(ds, 'SELECT * FROM KNTERRAD WHERE NRTyp=' + IntToStr(typ) + ' AND NUMMER=' + IntToStr(Nr) + ' AND KONTO=' + IntToStr(Konto) + ' AND KSTALLE=' + IntToStr(kstalle));
  ds.Open;
  if ds.IsEmpty then
    ds.Append
  else
    ds.Edit;
  ds.FieldByName('NRTyp').AsInteger := typ;
  ds.FieldByName('Nummer').AsInteger := Nr;
  ds.FieldByName('Konto').AsInteger := konto;
  ds.FieldByName('Debet').AsCurrency := ds.FieldByName('Debet').AsCurrency + debet; //!AsCurrency
  ds.FieldByName('Kredit').AsCurrency := ds.FieldByName('Kredit').AsCurrency + kredit; //!AsCurrency
  ds.FieldByName('KStalle').AsInteger := kstalle;
  ds.Post;
  ds.Active := False;
end;


procedure KonteraData(InternalFaktnr: Integer);
var
  q: TADOQuery;
  qFaktHead: TADOQuery;
  qFaktRad: TADOQuery;
  qParam: TADOQuery;
  qtmpData: TADOQuery;
  utData: TADOQuery;
  kstalle: Integer;
  kStalle_Debet, kStalle_Kredit: Integer;
  Koncern: Boolean;

  function GetKstalle(styr, def_Konto, InternKonto, KoncernKonto, Def_Kstalle, Kundnr: Integer): Integer;
  begin
    Result := 0;
    case styr of
      0: begin
          if Koncern then
            Result := KoncernKonto
          else
            Result := def_Konto;
          kstalle := 0;
        end;
      1: begin
          q := CreateDS('SELECT IKonto,IKstalle FROM CUSTOMER WHERE Cust_Id=' + IntToStr(Kundnr));
          q.Open;
          if q.FieldByName('IKONTO').AsInteger > 0 then
          begin
            Result := q.FieldByName('IKonto').AsInteger;
            kStalle := q.FieldByName('IKstalle').AsInteger;
          end
          else
          begin
            Result := InternKonto;
            kStalle := def_Kstalle;
          end;
          try
            FreeDS(q);
          except
            WriteDebug('FAKTURA','Fel vid plats #4');
          end;
        end;
      3: begin
          if Koncern then
            Result := KoncernKonto
          else
            Result := def_Konto;
          kStalle := def_Kstalle;
        end;
      4: begin
          if Koncern then
            Result := KoncernKonto
          else
            Result := def_Konto;
          kStalle := def_Kstalle;
        end;
      98: begin
          if qFaktHead.FieldByName('PAYMENT').AsString = 'I' then
            Result := InternKonto
          else
            Result := def_Konto;
          if Koncern then
            Result := KoncernKonto;
          kStalle := def_Kstalle;
        end;
      99: begin
          Result := KoncernKonto;
          kStalle := def_Kstalle;
        end;
    end;
  end;


begin
  Koncern := False;
  qFaktHead := CreateDS('SELECT * FROM FAKTHEAD WHERE FAKTNR=' + IntToStr(InternalFaktnr));

  qFaktRad := CreateDS('SELECT rad,SUMMA,SUMMA_SEK,Kontonr,KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
    'FROM FAKTRAD INNER JOIN Kontering ON FAKTRAD.RAD=Kontering.Konteringsid ' +
    'WHERE FAKTNR=' + IntToStr(InternalFaktNr) + ' AND RAD<6 and summa<>0 ' +
    'union ' +
    'SELECT rad,SUMMA,SUMMA_SEK,Acc_code,Acc_center,InternKontoNr, KoncernKontoNr ' +
    'FROM FAKTRAD INNER JOIN Costs ON FAKTRAD.TEXT=Costs.Costname ' +
    'WHERE FAKTNR=' + IntToStr(InternalFaktNr) + ' AND RAD>5 and summa<>0 ' +
    'order by 1');

  qParam := CreateDS('SELECT * FROM PARAM');
  qParam.Open;
  kStalle_Debet := qParam.FieldByName('kstalle_debet').AsInteger;
  kStalle_Kredit := qParam.FieldByName('kstalle_Kredit').AsInteger;
  qParam.Active := False;
  qFaktHead.Open;
  if not qFaktHead.IsEmpty then
  begin
    kStalle := 0;
    utData := CreateDS('SELECT Cust_Koncern from Customer where Cust_Id=' + qFaktHead.FieldByName('Kundnr').AsString);
    utData.Open;
    Koncern := UtData.FieldByName('Cust_Koncern').AsBoolean;
    utData.Active := False;
    qTmpData := CreateDS('');

    // Kontera Kundfordringskonto Obs Ej KStalle + Intern Eller Koncern
    if qFaktHead.FieldByName('FAKTSUM').AsFloat <> 0 then
    begin
      SetDS(qTmpData, 'SELECT Kontonr, KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
        'FROM Betst INNER JOIN Kontering ON Betst.Konto = Kontering.Konteringsid ' +
        ' WHERE Kod=''' + qFaktHead.FieldByName('Payment').AsString + '''');
      qTmpData.Open;
      SkapaKonteringar(utData, 1, InternalFaktnr,
        GetKstalle(qTmpData.FieldByName('KstalleStyrning').AsInteger,
        qTmpData.FieldByName('KontoNr').AsInteger,
        qTmpData.FieldByName('InternKontoNr').AsInteger,
        qTmpData.FieldByName('KoncernKontoNr').AsInteger,
        kStalle_Debet, qFaktHead.FieldByName('Kundnr').AsInteger)
        , kStalle, qFaktHead.FieldByName('FAKTSUM').AsFloat, 0);
    end;

    // Kontera Momskonto
    if qFaktHead.FieldByName('MOMSSUM').AsFloat <> 0 then
    begin
      SetDS(qTmpdata, 'SELECT Kontonr, KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
        'FROM Kontering,Param Where Param.Momskonto=Kontering.Konteringsid ');
      qTmpData.Open;
      SkapaKonteringar(utData, 1, InternalFaktnr, qTmpData.FieldByName('KontoNr').AsInteger, 0, 0, qFaktHead.FieldByName('MOMSSUM').AsFloat);
    end;

    // Kontera Deposition
    if qFaktHead.FieldByName('DEP').AsFloat <> 0 then
    begin
      SetDS(qTmpdata, 'SELECT Kontonr, KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
        'FROM Kontering,Param Where Param.Dep_Konto=Kontering.Konteringsid ');
      qTmpData.Open;
      SkapaKonteringar(utData, 1, InternalFaktnr, qTmpData.FieldByName('KontoNr').AsInteger, 0, qFaktHead.FieldByName('DEP').AsFloat, 0);
    end;

    // Kontera Avrundning
    if qFaktHead.FieldByName('AVRUNDNING').AsFloat <> 0 then
    begin
      SetDS(qTmpdata, 'SELECT AvrKonto ,AvrKstalle FROM Param ');
      qTmpData.Open;
      SkapaKonteringar(utData, 1, InternalFaktnr, qTmpData.Fields[0].AsInteger, qTmpData.Fields[1].AsInteger, 0, qFaktHead.FieldByName('AVRUNDNING').AsFloat);
    end;
    qFaktRad.Open;
    while not qFaktRad.Eof do
    begin
      SkapaKonteringar(utData, 1, InternalFaktnr,
        GetKstalle(98,
        qFaktRad.FieldByName('KontoNr').AsInteger,
        qFaktRad.FieldByName('InternKontoNr').AsInteger,
        qFaktRad.FieldByName('KoncernKontoNr').AsInteger,
        kStalle_Debet, 0), kstalle, 0, qFaktRad.FieldByName('SUMMA').AsFloat);
      qFaktRad.Next;
    end;
    try
      FreeDS(qtmpData);
      FreeDS(utData);
    except
      WriteDebug('FAKTURA','Fel vid plats #1');
    end;
  end;
  try
    FreeDS(qParam);
    FreeDS(qFaktRad);
    FreeDS(qFaktHead);
  except
    WriteDebug('FAKTURA','Fel vid plats #2');
  end;
end;

procedure MoveCSub2Faktura(subid: Integer);
var
  InData: TADOQuery;
  utData: TADOQuery;
  tmpData: TADOQuery;
  NextFaktnr: Integer;
  VVarde: Real;
begin
  tmpData := CreateDS('SELECT MAX(FAKTNR) FROM FAKTHEAD');
  try
    tmpData.Open;
    if tmpData.IsEmpty then
      NextFaktNr := 1
    else
      NextFaktnr := tmpData.Fields[0].AsInteger + 1;
    tmpData.Close;
    utData := CreateDS('');
    try
      inData := CreateDS(
        'SELECT contr_sub.SubId, contr_sub.ENummer, contr_sub.Print_Date, contr_sub.ForfalloDat-contr_sub.Terms_Pay AS FaktDat, contr_sub.ForfalloDat,contr_insur.INumber, contr_sub.Payment,' +
        'contr_sub.ContrId, contr_sub.SpRule_Rent, contr_sub.SpRule_KM, contr_sub.SpRule_Vat, betalare.Cust_Id, betalare.Name as BetName, betalare.Co_Adr, ' +
        'betalare.Adress,betalare.Postal_Name,betalare.Country, betalare.Org_No,signr.NAMN,customer.Name As CustName,driver.Name As DriverName,' +
        'contr_base.Referens,contr_base.Dep_Amount, contr_not.Cnot1, contr_not.Cnot2 ,Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL,' +
        'contr_objt.Frm_Time, contr_objt.To_Time, contr_objt.OId, contr_objt.ObTypId,contr_objt.KM_In, contr_objt.KM_Out,objects.Model,objtype.Type ' +
        'FROM Contr_Sub contr_sub LEFT OUTER JOIN Customer betalare ON contr_sub.SubCustId = betalare.Cust_Id INNER JOIN ' +
        'Contr_Base contr_base ON contr_base.ContrId = contr_sub.ContrId INNER JOIN Signr signr ON contr_base.Sign = signr.SIGN INNER JOIN ' +
        'Customer customer ON customer.Cust_Id = contr_base.CustID LEFT OUTER JOIN Customer driver ON contr_base.DriveId = driver.Cust_Id LEFT OUTER JOIN ' +
        'Contr_Not contr_not ON contr_base.ContrId = contr_not.Contrid INNER JOIN Contr_ObjT contr_objt ON contr_base.ContrId = contr_objt.ContrId INNER JOIN ' +
        'Objects objects ON contr_objt.OId = objects.Reg_No INNER JOIN ObjType objtype ON objects.Type = objtype.ID LEFT OUTER JOIN ' +
        'Contr_SubCost ON Contr_SubCost.SubId = contr_sub.SubId LEFT JOIN ' +
        'contr_insur ON Contr_Sub.SubId = contr_insur.SubId ' +
        'WHERE contr_sub.SubId=' + IntToStr(subId)
        );
      try

        Indata.Open;

        if not Indata.IsEmpty then
        begin
          SetDS(UtData, 'SELECT * FROM FAKTHEAD WHERE KOREF=' + InData.FieldByName('ContrId').AsString + ' AND KUNDNR=' + InData.FieldByName('Cust_Id').AsString + ' AND STATUS=0 ORDER BY FAKTNR DESC');
          UtData.Open;

          if utData.FieldByName('FAKTNR').AsInteger > 0 then
          begin
            SetDS(tmpData, 'SELECT * FROM LOGGTABELL WHERE NUMMER=' + IntToStr(UtData.FieldByName('FAKTNR').AsInteger));
            tmpData.Open;
            if tmpData.IsEmpty then
            begin
              NextFaktNr := UtData.FieldByName('FAKTNR').AsInteger;
              dmod1.ADOConnection1.Execute('DELETE FAKTRAD WHERE FAKTNR=' + IntToStr(NextFaktnr));
              dmod1.ADOConnection1.Execute('DELETE KNTERRAD WHERE NUMMER=' + IntToStr(NextFaktnr));
              Utdata.Edit;
            end
            else
            begin
//              KrediteraFaktnr(UtData.FieldByName('FAKTNR').AsInteger);
              UtData.Append;
            end;
            tmpData.Close;
          end
          else
          begin
            UtData.Append;
          end;

          UtData.FieldByName('FAKTNR').AsInteger := NextFaktnr;
          UtData.FieldByName('E_FAKTNR').AsString := InData.FieldByName('ENummer').AsString;
          UtData.FieldByName('PAYMENT').AsString := InData.FieldByName('PAYMENT').AsString;
          UtData.FieldByName('RUBRIK').AsString := 'FAKTURA';
          UtData.FieldByName('UTSKRDAT').AsDateTime := InData.FieldByName('Print_Date').AsDateTime;
          UtData.FieldByName('FAKTDAT').AsDateTime := InData.FieldByName('FaktDat').AsDateTime;
          UtData.FieldByName('FORFDAT').AsDateTime := InData.FieldByName('Forfallodat').AsDateTime;
          UtData.FieldByName('KUNDNR').AsInteger := InData.FieldByName('Cust_Id').AsInteger;
          UtData.FieldByName('FAKTURAADRSTR').AsString := InData.FieldByName('BetName').AsString + '#13' +
            InData.FieldByName('Co_Adr').AsString + '#13' +
            InData.FieldByName('Adress').AsString + '#13' +
            InData.FieldByName('Postal_Name').AsString + '#13' +
            InData.FieldByName('Country').AsString;

          UtData.FieldByName('KUNDVATNR').AsString := InData.FieldByName('Org_No').AsString;
          UtData.FieldByName('KOREF').AsInteger := InData.FieldByName('ContrId').AsInteger;
          UtData.FieldByName('FULLSIGN').AsString := InData.FieldByName('NAMN').AsString;
          UtData.FieldByName('HYRESMAN').AsString := InData.FieldByName('CustName').AsString;
          UtData.FieldByName('DRIVER').AsString := InData.FieldByName('DriverName').AsString;
          UtData.FieldByName('COMMENT').AsString := '';
          UtData.FieldByName('REF').AsString := InData.FieldByName('Referens').AsString;
          UtData.FieldByName('NOTE').AsString := InData.FieldByName('CNot1').AsString + '#13' + InData.FieldByName('CNot2').AsString; ;
          UtData.FieldByName('INUMBER').AsString := InData.FieldByName('INumber').AsString;
          UtData.FieldByName('DEP').AsFloat := InData.FieldByName('Dep_Amount').AsFloat;
          UtData.FieldByName('VARUVARDE').AsFloat := 0;
          UtData.FieldByName('AVRUNDNING').AsFloat := 0;
          UtData.FieldByName('RABATT').AsFloat := 0;
          UtData.FieldByName('MOMSSUM').AsFloat := InData.FieldByName('DMOMS').AsFloat;
          UtData.FieldByName('FAKTSUM').AsFloat := InData.FieldByName('DTOTAL').AsFloat;
          UtData.FieldByName('BOKADKURS').AsFloat := 1;
          UtData.FieldByName('VALUTAKOD').AsString := 'SEK';
          UtData.FieldByName('AVRUNDNING_SEK').AsFloat := 0;
          UtData.FieldByName('RABATT_SEK').AsFloat := 0;
          UtData.FieldByName('MOMSSUM_SEK').AsFloat := InData.FieldByName('DMOMS').AsFloat;
          UtData.FieldByName('FAKTSUM_SEK').AsFloat := InData.FieldByName('DTOTAL').AsFloat;
          UtData.FieldByName('FRM_TIME').AsDateTime := InData.FieldByName('FRM_TIME').AsDateTime;
          UtData.FieldByName('TO_TIME').AsDateTime := InData.FieldByName('TO_TIME').AsDateTime;
          UtData.FieldByName('OID').AsString := InData.FieldByName('OID').AsString;
          UtData.FieldByName('OBTYPID').AsString := InData.FieldByName('OBTYPID').AsString;
          UtData.FieldByName('MODEL').AsString := InData.FieldByName('MODEL').AsString;
          UtData.FieldByName('OTYPE').AsString := InData.FieldByName('TYPE').AsString;
          UtData.FieldByName('KM_IN').AsInteger := InData.FieldByName('KM_IN').AsInteger;
          UtData.FieldByName('KM_OUT').AsInteger := InData.FieldByName('KM_OUT').AsInteger;
          UtData.FieldByName('SPRULE_RENT').AsInteger := InData.FieldByName('SPRULE_RENT').AsInteger;
          UtData.FieldByName('SPRULE_KM').AsInteger := InData.FieldByName('SPRULE_KM').AsInteger;
          UtData.FieldByName('SPRULE_VAT').AsInteger := InData.FieldByName('SPRULE_VAT').AsInteger;
          UtData.FieldByName('STATUS').AsInteger := 0;
          UtData.FieldByName('LANGUAGE').AsString := 'SE';
          UtData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
          UtData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
          UtData.FieldByName('ANDRATAV').AsString := 'IMP';

          tmpData.Close;
          SetDS(tmpData, 'SELECT * FROM FAKTRAD WHERE FAKTNR=' + IntToStr(NextFaktNr));
          tmpData.Open;

          VVarde := 0;
          InData.Close;
          SetDS(InData, 'SELECT * FROM CONTR_SUBCOSTROW WHERE SUBID=' + IntToStr(SubId));
          InData.Open;
          if not InData.IsEmpty then
          begin
            while not InData.Eof do
            begin
              tmpData.Append;
              tmpData.FieldByName('FAKTNR').AsInteger := NextFaktnr;
              tmpData.FieldByName('RAD').AsInteger := InData.FieldByName('RowNumb').AsInteger;
              tmpData.FieldByName('TEXT').AsString := InData.FieldByName('RowText').AsString;
              tmpData.FieldByName('ANTAL').AsFloat := 1;
              tmpData.FieldByName('A_PRIS').AsFloat := Round(InData.FieldByName('Value').AsFloat * 100) / 100.00;
              tmpData.FieldByName('A_PRIS_SEK').AsFloat := Round(InData.FieldByName('Value').AsFloat * 100) / 100.00;
              tmpData.FieldByName('RABATT').AsFloat := 0;
              tmpData.FieldByName('RABATT_SEK').AsFloat := 0;
              tmpData.FieldByName('SUMMA').AsFloat := Round(InData.FieldByName('Value').AsFloat * 100) / 100.00;
              tmpData.FieldByName('SUMMA_SEK').AsFloat := Round(InData.FieldByName('Value').AsFloat * 100) / 100.00;
              tmpData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
              tmpData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
              tmpData.FieldByName('ANDRATAV').AsString := 'IMP';
              VVarde := VVarde + Round(InData.FieldByName('Value').AsFloat * 100) / 100.00;
              tmpData.Post;
              InData.Next;
            end;
          end;

          UtData.FieldByName('VARUVARDE').AsFloat := VVarde;
          UtData.FieldByName('FAKTSUM').AsFloat := Round(UtData.FieldByName('VARUVARDE').AsFloat + UtData.FieldByName('MOMSSUM').AsFloat);
          UtData.FieldByName('AVRUNDNING').AsFloat := UtData.FieldByName('FAKTSUM').AsFloat - (UtData.FieldByName('VARUVARDE').AsFloat + UtData.FieldByName('MOMSSUM').AsFloat);
          UtData.FieldByName('AVRUNDNING_SEK').AsFloat := UtData.FieldByName('AVRUNDNING').AsFloat;
          UtData.FieldByName('FAKTSUM_SEK').AsFloat := UtData.FieldByName('FAKTSUM').AsFloat;

          UtData.Post;
          try
            UtData.Active := False;
          except
            WriteDebug('FAKTURA', 'Fel vid plats #6');
          end;
        end;
        try
          InData.Active := False;
          tmpData.Active := False;
        except
          WriteDebug('FAKTURA', 'Fel vid plats #9');
        end;
        KonteraData(NextFaktnr);
      except
      end;
    except
    end;
  except
  end;
  try
    FreeDS(UtData);
    FreeDS(InData);
    FreeDS(tmpData);
  except
    WriteDebug('FAKTURA', 'Fel vid plats #10');
  end;
end;







end.

