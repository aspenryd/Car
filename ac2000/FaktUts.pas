{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     FaktUts.pas
}

{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13006: FaktUts.pas
{
{   Rev 1.6    2006-02-18 13:33:18  pb64
}
{
{   Rev 1.5    2005-04-28 16:01:06  pb64
{ Lagt till hantering av kredit samt rutiner för att sätta loggnummer på
{ kreditfaktura,delfaktura.
}
{
{   Rev 1.4    2005-02-07 13:15:46  pb64
}
{
{   Rev 1.3    2004-12-07 16:37:46  pb64
{ Fixat kontering vid deposition.
}
{
{   Rev 1.2    2004-01-28 14:40:20  peter
}
{
{   Rev 1.1    2003-12-30 11:18:12  peter
}
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:06  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:06  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit FaktUts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, CheckLst, Buttons, db, ComCtrls, Grids, DBGrids, Variants, adodb;

const
  STAT_FAKTURA = 0;
  STAT_DELFAKTURA = 1;
  STAT_DEPOSITION = 2;
  STAT_KREDIT = 3;


type
  TFrmFaktUts = class(TForm)
    Panel2: TPanel;
    RG1: TRadioGroup;
    RBAlla: TRadioButton;
    RBEgna: TRadioButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    EdtNamn: TEdit;
    Label5: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    DT: TDateTimePicker;
    Label6: TLabel;
    CBIntExt: TComboBox;
    Label1: TLabel;
    EdtSum: TEdit;
    SpeedButton3: TSpeedButton;
    btnEDIFact: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RBAllaClick(Sender: TObject);
    procedure RBEgnaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FillCBL;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FillDBGRid;
    procedure HideCols;
    procedure SpeedButton3Click(Sender: TObject);
    procedure EdtNamnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEDIFactClick(Sender: TObject);
  private
    { Private declarations }
    subnr: Integer;
    procedure CreatePathIfNecessary(path: string);
    function ConvertOrgNr2VAT(orgnr: string): string;
    function GetCityFromPoAdr(PoAdr: string): string;
    function GetZipcodeFromPoAdr(PoAdr: string): string;
  public
    { Public declarations }
  end;

procedure KonteraData(InternalFaktnr: Integer);
function KrediteraFaktura(fnr: integer): Integer;
procedure MoveData(subid: Integer);
procedure SkapaLoggTabell(LoggNr, LoggTyp, Nummer: Integer; date: string);
function GetValueFromInit(prog, sign, code: string; defStr: string = ''): string;
procedure SetValueToInit(prog, signStr, code, CodeValue: string);
procedure SetDS(var ds: TADOQuery; SQL: string);
function CreateDS(SQL: string): TADOQuery;
function ExecDS(ds: TADOQuery): Integer;
procedure FreeDS(ds: TADOQuery);

var
  FrmFaktUts: TFrmFaktUts;

implementation

uses Dmod, Main, eqprn, DmSession, DateUtil, EDIFactClasses, EDIFactUtils,
  StrUtils; //Crystal;

{$R *.DFM}


procedure SetDS(var ds: TADOQuery; SQL: string);
begin
  if 'MYSQL' = 'DB' then
  begin
    SQL := StringReplace(SQL, 'GETDATE()', 'CURRENT_TIMESTAMP', [rfReplaceAll, rfIgnoreCase]);
    SQL := StringReplace(SQL, ' TOP 1 ', '', [rfReplaceAll, rfIgnoreCase]);
  end;
  ds.Active := False;
  ds.SQL.Clear;
  ds.SQL.Add(SQL);
end;

function CreateDS(SQL: string): TADOQuery;
begin
  if 'MYSQL' = 'DB' then
  begin
    SQL := StringReplace(SQL, 'GETDATE()', 'CURRENT_TIMESTAMP', [rfReplaceAll, rfIgnoreCase]);
    SQL := StringReplace(SQL, ' TOP 1 ', '', [rfReplaceAll, rfIgnoreCase]);
  end;
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
        ShowMessage('Fel vid plats #3');
      end;
    end;
  end;
  TADOQuery(ds).Free;
  ds := nil;
end;

function GetValueFromInit(prog, sign, code: string; defStr: string = ''): string;
var
  Q: TADOQuery;
begin
  Result := DefStr;
  Q := CreateDS(format('SELECT CODEVALUE FROM INITIERING WHERE PROG=''%s'' AND SIGN=''%s'' AND CODE=''%s''', [Prog, Sign, Code]));
  try
    Q.Open;
    if not Q.Isempty then
      Result := Q.Fields[0].AsString;
    if Result = '' then
      Result := DefStr;
  except
  end;
  FreeDS(Q);
end;

procedure SetValueToInit(prog, signStr, code, CodeValue: string);
var
  Q: TADOQuery;
  i: Integer;
begin
  Q := CreateDS(format('UPDATE INITIERING SET CODEVALUE=''%s'', ANDRATAV=''%s'',ANDRATTIDPUNKT=GETDATE() WHERE PROG=''%s'' AND SIGN=''%s'' AND CODE=''%s''', [CodeValue, frmMain.sign, Prog, SignStr, Code]));
  try
    i := Q.ExecSQL;
    if i = 0 then
    begin
      SetDS(Q, format('INSERT INTO INITIERING (PROG,SIGN,CODE,CODEVALUE,ANDRATAV) VALUES (''%s'',''%s'',''%s'',''%s'',''%s'')', [Prog, SignStr, Code, CodeValue, frmMain.sign]));
      Q.ExecSQL;
    end;
  except
  end;
  FreeDS(Q);
end;


function GetNextCounter(fname: string): Integer;
var
  ds: TADOQuery;
begin
  ds := CreateDS('UPDATE PARAM SET ' + FNAME + '=' + FNAME + '+1');
  ExecDS(ds);
  SetDS(ds, 'SELECT ' + FNAME + ' FROM PARAM');
  ds.Open;
  Result := ds.Fields[0].AsInteger;
  ds.Close;
  ds.Free;
end;

function GetEnr(BSatt: string): Integer;
begin
  if BSatt = 'K' then Result := GetNextCounter('Knotenr');
  if BSatt = 'O' then Result := GetNextCounter('FBolagNr');
  if BSatt = 'F' then Result := GetNextCounter('FaktNr');
  if BSatt = 'I' then Result := GetNextCounter('InternNr');
end;



procedure SkapaLoggTabell(LoggNr, LoggTyp, Nummer: Integer; date: string);
var
  qLogg: TADOQuery;
begin
  qLogg := CreateDS('SELECT * FROM LOGGTABELL WHERE NUMMER=' + intToStr(Nummer) + ' AND NRTYP=1');
  qLogg.Open;
  if qLogg.isEmpty then
  begin
    qLogg.Append;
    qLogg.FieldByname('LoggNR').asinteger := LoggNr;
    qLogg.FieldByname('NrTyp').asinteger := 1;
    qLogg.FieldByname('Nummer').asinteger := Nummer;
    qLogg.FieldByName('Bokf_dag').AsString := date;
    qLogg.Post;
  end
  else
  begin
  end;
  FreeDS(qLogg);
end;


procedure SkapaKonteringar(ds: TADOQuery; typ, nr, konto, kstalle: integer; debet, kredit: Double);
begin
  debet := round(debet * 100) / 100;
  Kredit := round(Kredit * 100) / 100;
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
            ShowMessage('Fel vid plats #4');
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
  dmod1.ADOConnection1.Execute('DELETE KNTERRAD WHERE NUMMER=' + IntToStr(InternalFaktnr));

  Koncern := False;
  qFaktHead := CreateDS('SELECT * FROM FAKTHEAD WHERE FAKTNR=' + IntToStr(InternalFaktnr));

  qFaktRad := CreateDS('SELECT rad,SUMMA,SUMMA_SEK,Kontonr,KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
    'FROM FAKTRAD INNER JOIN Kontering ON FAKTRAD.RAD=Kontering.Konteringsid ' +
    'WHERE FAKTNR=' + IntToStr(InternalFaktNr) + ' AND RAD<6 and summa<>0 ' +
    'union ' +
    'SELECT rad,SUMMA,SUMMA_SEK,Acc_code,Acc_center, InternKontoNr, KoncernKontoNr ' +
    'FROM FAKTRAD INNER JOIN Costs ON FAKTRAD.TEXT=Costs.Costname ' +
    'WHERE FAKTNR=' + IntToStr(InternalFaktNr) + ' AND RAD>5 AND RAD<999 and summa<>0 ' +
    'union ' +
    'SELECT rad,SUMMA,SUMMA_SEK,Kontonr,KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
    'FROM FAKTRAD INNER JOIN Kontering ON 1=Kontering.Konteringsid ' +
    'WHERE FAKTNR=' + IntToStr(InternalFaktNr) + ' AND RAD=999 and summa<>0 ' +
    'union ' +
    'SELECT rad,SUMMA,SUMMA_SEK,Kontonr,KStalleStyrning, InternKontoNr, KoncernKontoNr ' +
    'FROM FAKTRAD, PARAM INNER JOIN Kontering ON PARAM.Dep_Konto=Kontering.Konteringsid ' +
    'WHERE FAKTRAD.FAKTNR=' + IntToStr(InternalFaktNr) + ' AND RAD=1000 and summa<>0 ' +
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
    if (qFaktHead.FieldByName('FAKTSUM').AsFloat - qFaktHead.FieldByName('DEP').AsFloat) <> 0 then
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
        , kStalle, qFaktHead.FieldByName('FAKTSUM').AsFloat - qFaktHead.FieldByName('DEP').AsFloat, 0);
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
      SkapaKonteringar(utData, 1, InternalFaktnr,
        GetKstalle(qTmpData.FieldByName('KstalleStyrning').AsInteger,
        qTmpData.FieldByName('KontoNr').AsInteger,
        qTmpData.FieldByName('InternKontoNr').AsInteger,
        qTmpData.FieldByName('KoncernKontoNr').AsInteger,
        kStalle_Debet, qFaktHead.FieldByName('Kundnr').AsInteger),
        kstalle, qFaktHead.FieldByName('DEP').AsFloat, 0);
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
      ShowMessage('Fel vid plats #1');
    end;
  end;
  try
    FreeDS(qParam);
    FreeDS(qFaktRad);
    FreeDS(qFaktHead);
  except
    ShowMessage('Fel vid plats #2');
  end;
end;

function MinSubid(Koref: Integer): Integer;
var
  ds2: TADOQuery;
begin
  Result := 0;
  ds2 := CreateDS('SELECT MIN(SUBID) FROM CONTR_SUB WHERE CONTRID=' + IntToStr(Koref));
  try
    ds2.Open;
    Result := ds2.Fields[0].AsInteger;
    ds2.Close;
  except
  end;
  FreeDS(ds2);
end;

function SumFaktFromKoref(Koref: Integer; StatTp: Integer = 1): Real;
var
  ds2: TADOQuery;
begin
  Result := 0;
  ds2 := CreateDS('SELECT SUM(VARUVARDE) FROM FAKTHEAD WHERE KOREF=' + IntToStr(Koref) + ' AND STATUS=' + IntToStr(StatTp));
  try
    ds2.Open;
    Result := ds2.Fields[0].AsFloat;
    ds2.Close;
  except
  end;
  FreeDS(ds2);
end;

procedure MoveData(subid: Integer);
var
  InData: TADOQuery;
  utData: TADOQuery;
  tmpData: TADOQuery;
  NextFaktnr: Integer;
  VVarde, delfakt, DelKred: Real;
  MainPayer: Boolean;
begin
  tmpData := CreateDS('SELECT MAX(FAKTNR) FROM FAKTHEAD');
  tmpData.Open;
  if tmpData.IsEmpty then
    NextFaktNr := 1
  else
    NextFaktnr := tmpData.Fields[0].AsInteger + 1;
  tmpData.Close;
  utData := CreateDS('');

  inData := CreateDS(
    'SELECT contr_sub.SubId, contr_sub.ENummer, contr_sub.Print_Date, contr_sub.ForfalloDat-contr_sub.Terms_Pay AS FaktDat, contr_sub.ForfalloDat,contr_insur.INumber, contr_sub.Payment,' +
    'contr_sub.ContrId, contr_sub.SpRule_Rent, contr_sub.SpRule_KM, contr_sub.SpRule_Vat, betalare.Cust_Id, betalare.Name as BetName, betalare.Co_Adr, ' +
    'betalare.Adress,betalare.Postal_Name,betalare.Country, betalare.Org_No,signr.NAMN,customer.Name As CustName,driver.Name As DriverName,' +
    'contr_base.Referens,contr_base.Dep_Amount, contr_not.Cnot1, contr_not.Cnot2 ,Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL,' +
    'contr_objt.Frm_Time, contr_objt.To_Time, contr_objt.OId, contr_objt.ObTypId,contr_objt.KM_In, contr_objt.KM_Out,objects.Model,objtype.Type, betalare.Lang ' +
    'FROM Contr_Sub contr_sub LEFT OUTER JOIN Customer betalare ON contr_sub.SubCustId = betalare.Cust_Id INNER JOIN ' +
    'Contr_Base contr_base ON contr_base.ContrId = contr_sub.ContrId INNER JOIN Signr signr ON contr_base.Sign = signr.SIGN INNER JOIN ' +
    'Customer customer ON customer.Cust_Id = contr_base.CustID LEFT OUTER JOIN Customer driver ON contr_base.DriveId = driver.Cust_Id LEFT OUTER JOIN ' +
    'Contr_Not contr_not ON contr_base.ContrId = contr_not.Contrid INNER JOIN Contr_ObjT contr_objt ON contr_base.ContrId = contr_objt.ContrId INNER JOIN ' +
    'Objects objects ON contr_objt.OId = objects.Reg_No INNER JOIN ObjType objtype ON objects.Type = objtype.ID LEFT OUTER JOIN ' +
    'Contr_SubCost ON Contr_SubCost.SubId = contr_sub.SubId LEFT JOIN ' +
    'contr_insur ON Contr_Sub.SubId = contr_insur.SubId ' +
    'WHERE contr_sub.SubId=' + IntToStr(subId)
    );

  Indata.Open;

  if not Indata.IsEmpty then
  begin
    SetDS(UtData, 'SELECT * FROM FAKTHEAD WHERE KOREF=' + InData.FieldByName('ContrId').AsString + ' AND KUNDNR=' + InData.FieldByName('Cust_Id').AsString + ' ORDER BY FAKTNR DESC');
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


    MainPayer := MinSubId(InData.FieldByName('ContrId').AsInteger) = Subid;
    if MainPayer then
      UtData.FieldByName('DEP').AsFloat := InData.FieldByName('Dep_Amount').AsFloat
    else
      UtData.FieldByName('DEP').AsFloat := 0;


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
    UtData.FieldByName('LANGUAGE').AsString := InData.FieldByName('LANG').AsString;
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

    if MainPayer then
    begin
      delfakt := 0;
      DelFakt := SumFaktFromKoref(UtData.FieldByName('KOREF').AsInteger, STAT_DELFAKTURA);
      if DelFakt <> 0 then
      begin
        DelKred := SumFaktFromKoref(UtData.FieldByName('KOREF').AsInteger, STAT_KREDIT);
        if DelKred <> 0 then
          Delfakt := Delfakt + DelKred;
      end;
      if DelFakt <> 0 then
      begin
        DelFakt := 0 - delfakt;
        tmpData.Append;
        tmpData.FieldByName('FAKTNR').AsInteger := NextFaktnr;
        tmpData.FieldByName('RAD').AsInteger := 999;
        tmpData.FieldByName('TEXT').AsString := 'Avgår delbetalt';
        tmpData.FieldByName('ANTAL').AsFloat := 1;
        tmpData.FieldByName('A_PRIS').AsFloat := Round(DelFakt * 100) / 100.00;
        tmpData.FieldByName('A_PRIS_SEK').AsFloat := Round(DelFakt * 100) / 100.00;
        tmpData.FieldByName('RABATT').AsFloat := 0;
        tmpData.FieldByName('RABATT_SEK').AsFloat := 0;
        tmpData.FieldByName('SUMMA').AsFloat := Round(DelFakt * 100) / 100.00;
        tmpData.FieldByName('SUMMA_SEK').AsFloat := Round(DelFakt * 100) / 100.00;
        tmpData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
        tmpData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
        tmpData.FieldByName('ANDRATAV').AsString := 'IMP';
        UtData.FieldByName('MOMSSUM').AsFloat := UtData.FieldByName('MOMSSUM').AsFloat + Round(DelFakt * 25) / 100.00;
        UtData.FieldByName('MOMSSUM_SEK').AsFloat := UtData.FieldByName('MOMSSUM_SEK').AsFloat + Round(DelFakt * 25) / 100.00;

        VVarde := VVarde + Round(DelFakt * 100) / 100.00;
        tmpData.Post;
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
      ShowMessage('Fel vid plats #6');
    end;
  end;
  try
    InData.Active := False;
    tmpData.Active := False;
  except
    ShowMessage('Fel vid plats #9');
  end;
  KonteraData(NextFaktnr);
  try
    FreeDS(UtData);
    FreeDS(InData);
    FreeDS(tmpData);
  except
    ShowMessage('Fel vid plats #10');
  end;
end;


function KrediteraFaktura(fnr: integer): Integer;
var
  InData: TADOQuery;
  utData: TADOQuery;
  tmpData: TADOQuery;
  NextFaktnr, i, InternalFaktnr: Integer;
  VVarde: Real;
  PayStr: string;
begin
  Result := -1;
  tmpData := CreateDS('SELECT MAX(FAKTNR) FROM FAKTHEAD');
  tmpData.Open;
  if tmpData.IsEmpty then
    NextFaktNr := 1
  else
    NextFaktnr := tmpData.Fields[0].AsInteger + 1;
  tmpData.Close;
  utData := CreateDS('');

  inData := CreateDS('SELECT * FROM FAKTHEAD WHERE E_FAKTNR=' + IntToStr(fnr));
  Indata.Open;

  if not Indata.IsEmpty then
  begin
    SetDS(UtData, 'SELECT * FROM FAKTHEAD WHERE 1=2');
    UtData.Open;
    UtData.Append;

    InternalFaktnr := inData.FieldByName('FAKTNR').AsInteger;

    UtData.FieldByName('FAKTNR').AsInteger := NextFaktnr;

    for i := 1 to indata.FieldCount - 1 do
    begin
      utdata.Fields[i].AsVariant := indata.Fields[i].AsVariant;
    end;
    UtData.FieldByName('FAKTNR').AsInteger := NextFaktnr;

    PayStr := InData.FieldByName('PAYMENT').AsString;
    Result := GetEnr(PayStr);
    UtData.FieldByName('E_FAKTNR').AsInteger := Result;

    UtData.FieldByName('VARUVARDE').AsFloat := 0 - InData.FieldByName('VARUVARDE').AsFloat;
    UtData.FieldByName('AVRUNDNING').AsFloat := 0 - InData.FieldByName('AVRUNDNING').AsFloat;
    UtData.FieldByName('RABATT').AsFloat := 0 - InData.FieldByName('RABATT').AsFloat;
    UtData.FieldByName('MOMSSUM').AsFloat := 0 - InData.FieldByName('MOMSSUM').AsFloat;
    UtData.FieldByName('FAKTSUM').AsFloat := 0 - InData.FieldByName('FAKTSUM').AsFloat;

    UtData.FieldByName('AVRUNDNING_SEK').AsFloat := 0 - InData.FieldByName('AVRUNDNING_SEK').AsFloat;
    UtData.FieldByName('RABATT_SEK').AsFloat := 0 - InData.FieldByName('RABATT_SEK').AsFloat;
    UtData.FieldByName('MOMSSUM_SEK').AsFloat := 0 - InData.FieldByName('MOMSSUM_SEK').AsFloat;
    UtData.FieldByName('FAKTSUM_SEK').AsFloat := 0 - InData.FieldByName('FAKTSUM_SEK').AsFloat;


    UtData.FieldByName('RUBRIK').AsString := 'FAKTURA';
    UtData.FieldByName('UTSKRDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('FAKTDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('FORFDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('STATUS').AsInteger := STAT_KREDIT;
    UtData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
    UtData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
    UtData.FieldByName('ANDRATAV').AsString := 'IMP';
    UtData.Post;


    tmpData.Close;
    SetDS(tmpData, 'SELECT * FROM FAKTRAD WHERE FAKTNR=' + IntToStr(NextFaktNr));
    tmpData.Open;
    VVarde := 0;
    InData.Close;
    SetDS(InData, 'SELECT * FROM FAKTRAD WHERE FAKTNR=' + IntToStr(InternalFaktnr));
    InData.Open;
    if not InData.IsEmpty then
    begin
      tmpData.Append;
      tmpData.FieldByName('FAKTNR').AsInteger := NextFaktnr;
{        tmpData.FieldByName('RAD').AsVariant := indata.FieldByName('RAD').AsVariant;
        tmpData.FieldByName('TEXT').AsVariant := indata.FieldByName('TEXT').AsVariant;
        tmpData.FieldByName('ANTAL').AsVariant := indata.FieldByName('ANTAL').AsVariant;
        tmpData.FieldByName('A_PRIS').AsFloat := 0-indata.FieldByName('A_PRIS').AsFloat;
        tmpData.FieldByName('RABATT').AsFloat := 0-indata.FieldByName('RABATT').AsFloat;
        tmpData.FieldByName('SUMMA').AsFloat := 0-InData.FieldByName('SUMMA').AsFloat;
        tmpData.FieldByName('A_PRIS_SEK').AsFloat := 0-indata.FieldByName('A_PRIS_SEK').AsFloat;
        tmpData.FieldByName('RABATT_SEK').AsFloat := 0-indata.FieldByName('RABATT_SEK').AsFloat;
        tmpData.FieldByName('SUMMA_SEK').AsFloat := 0-indata.FieldByName('SUMMA_SEK').AsFloat;  }

      tmpData.FieldByName('RAD').AsInteger := 1;
      tmpData.FieldByName('TEXT').AsString := 'Kredit av faktura ' + IntToStr(fnr);
      tmpData.FieldByName('ANTAL').AsVariant := 1;
      tmpData.FieldByName('A_PRIS').AsFloat := UtData.FieldByName('VARUVARDE').AsFloat;
      tmpData.FieldByName('RABATT').AsFloat := 0;
      tmpData.FieldByName('SUMMA').AsFloat := UtData.FieldByName('VARUVARDE').AsFloat;
      tmpData.FieldByName('A_PRIS_SEK').AsFloat := UtData.FieldByName('VARUVARDE').AsFloat;
      tmpData.FieldByName('RABATT_SEK').AsFloat := 0;
      tmpData.FieldByName('SUMMA_SEK').AsFloat := UtData.FieldByName('VARUVARDE').AsFloat;


      tmpData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
      tmpData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
      tmpData.FieldByName('ANDRATAV').AsString := 'IMP';
      tmpData.Post;
    end;



    SetDS(tmpData, 'SELECT * FROM KNTERRAD WHERE NRTyp=1 AND NUMMER=' + IntToStr(NextFaktnr));
    tmpData.Open;
    SetDS(InData, 'SELECT * FROM KNTERRAD WHERE NRTyp=1 AND NUMMER=' + IntToStr(InternalFaktnr));
    InData.Open;
    if not InData.IsEmpty then
    begin
      while not InData.Eof do
      begin
        tmpData.Append;
        for i := 1 to tmpData.FieldCount - 1 do
        begin
          tmpData.Fields[i].AsVariant := indata.Fields[i].AsVariant;
        end;
        tmpData.FieldByName('NUMMER').AsInteger := NextFaktnr;
        tmpData.FieldByName('DEBET').AsFloat := indata.FieldByName('KREDIT').AsFloat;
        tmpData.FieldByName('KREDIT').AsFloat := indata.FieldByName('DEBET').AsFloat;
        tmpData.Post;
        InData.Next;
      end;
    end;
    SkapaLoggTabell(0, 1, Result, VisibleDateToStr(now));
  end;
  try
    FreeDS(UtData);
    FreeDS(InData);
    FreeDS(tmpData);
  except
    ShowMessage('Fel vid plats #10');
  end;
end;




procedure TFrmFaktUts.FormCreate(Sender: TObject);
var CBObj: string;
begin
  dt.DateTime := now - dmod2.ParamT.fieldbyname('SDate').asinteger;
  FillDbGrid;
  Caption := 'Journalhantering';
  dmod2.BetstT.first;
  while not dmod2.BetstT.Eof do
  begin
    cbintext.Items.Add(dmod2.BetstT.FieldByName('Kod').asstring + ' ' + dmod2.BetstT.FieldByName('Namn').asstring);
    dmod2.BetstT.Next;
  end;
  dmod2.q1.filtered := False;
end;

procedure TFrmFaktUts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeandNil(frmfaktuts);
  FrmMain.Panel1.Visible := True;
end;

procedure TFrmFaktUts.RBAllaClick(Sender: TObject);
var i: integer;
begin
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    dbgrid1.SelectedRows.CurrentRowSelected := True;
    dbgrid1.DataSource.DataSet.Next;
  end;
  label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
  HideCols;
end;

procedure TFrmFaktUts.RBEgnaClick(Sender: TObject);
var i: Integer;
begin
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    dbgrid1.SelectedRows.CurrentRowSelected := False;
    dbgrid1.DataSource.DataSet.Next;
  end;
  label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
  dbgrid1.DataSource.DataSet.First;
  HideCols;
end;

procedure TFrmFaktUts.SpeedButton1Click(Sender: TObject);
begin
  dmod2.q1.filtered := False;
  FilldbGrid;
  HIdeCols;
  EdtSum.Text := '';
  edtnamn.text := '';
  cbintext.Text := '';
  speedbutton1.Enabled := False;
  edit1.text := '';
end;

procedure TFrmFaktUts.FillCBL;
var i: Integer;
begin

end;

procedure TFrmFaktUts.SpeedButton2Click(Sender: TObject);
var i, NoOfdays: Integer;
  ENummer: Integer;
  KontrId: string;
  Namn: string;
  List: TStringList;
//!  NOw:TDate;
begin
  dbgrid1.Visible := False;
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    if dbgrid1.SelectedRows.CurrentRowSelected then
    begin
      //!Läs in Contr_id och SubName till Variabler
      KontrId := dbgrid1.Columns[0].Field.AsSTRING;
      Namn := dbgrid1.Columns[1].Field.AsString;
        //!Höj status i Basen till 10
      dmod2.Contr_BaseT.Locate('ContrId', dbgrid1.Columns[0].Field.AsString, [loCaseInsensitive]);
      dmod2.Contr_BaseT.Edit;
      dmod2.Contr_BaseT.FieldByName('Status').asinteger := 10;
      dmod2.Contr_BaseT.Post;
        //! Släng in PrintDatum i subben
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayof([KontrId, Namn]), [loCaseInsensitive]);
      dmod2.Contr_SubT.Edit;
      dmod2.Contr_SubT.FieldByName('Print_Date').asstring := InternalDateToStr(date);
      NoOfDays := dmod2.ParamT.Fieldbyname('FaktDagar').asinteger;
      if not dmod2.Contr_SubT.FieldByName('Terms_Pay').IsNull then
        NoOfDays := dmod2.Contr_SubT.FieldByName('Terms_Pay').AsInteger;
      dmod2.Contr_SubT.FieldByName('ForfalloDat').asstring := internalDateToStr(date + NoOfDays);
      dmod2.Contr_SubT.FieldByName('Status').asinteger := 10;
      dmod2.Contr_SubT.Post;
      //!Finns det ett enummer använd det
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayOf([KontrId, Namn]), [loCaseInsensitive]);
      if dmod2.Contr_SubT.FieldByName('Enummer').asinteger > 1 then
        enummer := dmod2.Contr_SubT.fieldbyname('ENummer').asinteger
      //!Annars hämta ett nytt...
      else
      begin
        if dbgrid1.Columns[7].Field.AsString = 'K' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('KNOTENR').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('KNOTENR').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'O' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('FBolagNR').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('FBolagNR').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'I' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('InternNr').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('InternNr').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'F' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('FaktNr').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('FaktNr').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
      end;
      //! Släng in ett ENummer
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayOf([KontrId, Namn]), [loCaseInsensitive]);
      dmod2.Contr_SubT.Edit;
      dmod2.Contr_SubT.FieldByName('ENummer').asinteger := Enummer;
      dmod2.Contr_SubT.Post;
      MoveData(dmod2.Contr_SubT.FieldByName('SUBID').AsInteger);
      SkapaLoggTabell(0, 1, Enummer, VisibleDateToStr(now));
    end;
    dbgrid1.DataSource.DataSet.Next;
  end;
//!Avsluta pros med att visa DbGriden och SKRIV UT!!!
  FilldbGrid;
  dbgrid1.Visible := True;
//  List := TStringList.Create;
//  List.Add(DateToStr(Date));
//  eqprn.PrintReportParams('journal.ini', 1, frmMain.preview, List);
//  List.Free;
  Speedbutton1.Click;
end;

procedure TFrmFaktUts.FillDBGrid;
begin
  dmod2.q1.close;
  dmod2.q1.sql.Text := 'SELECT Contr_Base.ContrId, Contr_Sub.SubName, Contr_ObjT.OId, Contr_ObjT.Ret_Time, Contr_SubCost.DTOTAL, Contr_Base.Status, Contr_Sub.SubId, Contr_Sub.Payment';
  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' FROM (Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId) INNER JOIN (Contr_Sub LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) ON Contr_Base.ContrId = Contr_Sub.ContrId';
  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' WHERE (Contr_Base.Status=9) or ((Contr_Base.Status=10) and (contr_sub.status is null)) ';
  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' ORDER BY Contr_Base.ContrId, Contr_Sub.SubId ';
//  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' UNION ';
//  dmod2.q1.sql.Text := dmod2.q1.sql.Text + 'SELECT KOREF, CAST(SUBSTRING(FAKTURAADRSTR, 1, CHARINDEX(''#13'', FAKTURAADRSTR) - 1) AS VARCHAR(50)), OId, TO_Time, FAKTSUM, Status, 0 AS SUBID, Payment ';
//  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' FROM FAKTHEAD INNER JOIN LOGGTABELL ON ((LOGGTABELL.NUMMER=FAKTHEAD.E_FAKTNR) AND (LOGGTABELL.NRTYP=1) AND (LOGGTABELL.LOGGNR=0))';
  dmod2.Q1.Open;

//! dbgrid1.Columns[3].:=False;
//! dbgrid1.Columns[5].:=False;
  rbegna.checked := True;
  dbgrid1.DataSource.DataSet.First;
  label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
end;

procedure TFrmFaktUts.HideCols;
begin
  dbgrid1.Columns[3].visible := False;
  dbgrid1.Columns[5].visible := False;
  dbgrid1.Columns[6].visible := False;
end;

procedure TFrmFaktUts.SpeedButton3Click(Sender: TObject);
var a, b, c, d, e: string;
begin
  if (cbintExt.Text > '!') and (edtSum.text > '!') then
  begin
    dmod2.q1.filter := 'Ret_time <= ''' + InternalDateToStr(dt.date) + ''' AND Payment = ''' + cbintext.Text[1] + ''' AND DTotal >''' + EdtSum.Text + ''''; //!
    dmod2.q1.filtered := True;
    label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
    speedbutton1.Enabled := True;
  end
  else
    showmessage('Du måste fylla i "Betal sätt" och "Summa större än"');
end;

procedure TFrmFaktUts.EdtNamnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_F2 then
  begin
    dmod2.q1.filter := 'Subname like ''' + Edtnamn.Text + '%''';
    dmod2.q1.filtered := True;
    label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
    speedbutton1.Enabled := True;
  end;
end;

procedure TFrmFaktUts.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_F2 then
  begin
    dmod2.q1.filter := 'OID like ''' + Edit1.Text + '%''';
    dmod2.q1.filtered := True;
    label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
    speedbutton1.Enabled := True;
  end;
end;

function TFrmFaktUts.ConvertOrgNr2VAT(orgnr : string) :string;
begin
  orgnr := AnsiReplaceStr(orgnr, '-', '');
  result := 'SE'+ orgnr + '01';
end;


function TFrmFaktUts.GetZipcodeFromPoAdr(PoAdr : string) : string;
begin
  result := Copy(PoAdr, 1, 6);
end;

function TFrmFaktUts.GetCityFromPoAdr(PoAdr : string) :string;
begin
  result := Copy(PoAdr, 8, length(PoAdr)-7);
end;


procedure TFrmFaktUts.btnEDIFactClick(Sender: TObject);
var
  ee : TEdiFactEngine;
  sl : TStringList;
  KontrId, Namn : string;
  NoOfDays, enummer : integer;
  City, Zipcode : string;
begin
  dbgrid1.Visible := False;
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    if dbgrid1.SelectedRows.CurrentRowSelected then
    begin

      //!Läs in Contr_id och SubName till Variabler
      KontrId := dbgrid1.Columns[0].Field.AsSTRING;
      Namn := dbgrid1.Columns[1].Field.AsString;
        //!Höj status i Basen till 10
      dmod2.Contr_BaseT.Locate('ContrId', dbgrid1.Columns[0].Field.AsString, [loCaseInsensitive]);
      dmod2.Contr_BaseT.Edit;
      dmod2.Contr_BaseT.FieldByName('Status').asinteger := 10;
      dmod2.Contr_BaseT.Post;
        //! Släng in PrintDatum i subben
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayof([KontrId, Namn]), [loCaseInsensitive]);
      dmod2.Contr_SubT.Edit;
      dmod2.Contr_SubT.FieldByName('Print_Date').asstring := InternalDateToStr(date);
      NoOfDays := dmod2.ParamT.Fieldbyname('FaktDagar').asinteger;
      if not dmod2.Contr_SubT.FieldByName('Terms_Pay').IsNull then
        NoOfDays := dmod2.Contr_SubT.FieldByName('Terms_Pay').AsInteger;
      dmod2.Contr_SubT.FieldByName('ForfalloDat').asstring := internalDateToStr(date + NoOfDays);
      dmod2.Contr_SubT.FieldByName('Status').asinteger := 10;
      dmod2.Contr_SubT.Post;

      //!Finns det ett enummer använd det
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayOf([KontrId, Namn]), [loCaseInsensitive]);
      if dmod2.Contr_SubT.FieldByName('Enummer').asinteger > 1 then
        enummer := dmod2.Contr_SubT.fieldbyname('ENummer').asinteger
      //!Annars hämta ett nytt...
      else
      begin
        if dbgrid1.Columns[7].Field.AsString = 'K' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('KNOTENR').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('KNOTENR').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'O' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('FBolagNR').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('FBolagNR').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'I' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('InternNr').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('InternNr').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'F' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('FaktNr').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('FaktNr').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
      end;
      //! Släng in ett ENummer
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayOf([KontrId, Namn]), [loCaseInsensitive]);
      dmod2.Contr_SubT.Edit;
      dmod2.Contr_SubT.FieldByName('ENummer').asinteger := Enummer;
      dmod2.Contr_SubT.Post;
      MoveData(dmod2.Contr_SubT.FieldByName('SUBID').AsInteger);
      SkapaLoggTabell(0, 1, Enummer, VisibleDateToStr(now));


      //Generera E-fakturaunderlag
      ee := TEdiFactEngine.create;
      try
        dmod2.Contr_BaseT.Locate('ContrId', dbgrid1.Columns[0].Field.AsString, [loCaseInsensitive]);
        dmod2.CustomerT.Locate('Cust_id', dmod2.Contr_BaseT.FieldByName('CustId').asinteger, [loCaseInsensitive]);
        dmod2.EdiBaseT.First;
        dmod2.CompanyT.First;
        //AddTestSupplierInfo(ee.EdiFactInfo.Supplier);
        with ee.EdiFactInfo do
        begin
          City := GetCityFromPoAdr(dmod2.CompanyT.FieldByName('PoAdr').asstring);
          ZipCode := GetZipcodeFromPoAdr(dmod2.CompanyT.FieldByName('PoAdr').asstring);
          Supplier.Name := dmod2.CompanyT.FieldByName('Company').asstring;
          Supplier.SupplierID := dmod2.EdiBaseT.FieldByName('VATNumber').asstring;
          Supplier.LogicalAddress := dmod2.EdiBaseT.FieldByName('LogicalAddress').asstring;
          Supplier.Qualifier := dmod2.EdiBaseT.FieldByName('Qualifier').asstring;
          Supplier.InternalAddress := dmod2.EdiBaseT.FieldByName('InternalAddress').asstring;
          Supplier.City := City;
          Supplier.Street := dmod2.CompanyT.FieldByName('Adr').asstring;
          Supplier.ZipCode := zipCode;
          Supplier.CountryCode := dmod2.CompanyT.FieldByName('Country').asstring;
          Supplier.VATNumber := dmod2.EdiBaseT.FieldByName('VATNumber').asstring;
          Supplier.AccountsReceivable.Name := 'Matias Öberg';
          Supplier.AccountsReceivable.Department := 'IT';
          Supplier.AccountsReceivable.ContactInfo := 'matias@volvo.se';
          Supplier.AccountsReceivable.CommunicationCode := 'EM';
          Supplier.SalesRep.Name := 'Matias Öberg';
          Supplier.SalesRep.Department := 'IT';
          Supplier.SalesRep.ContactInfo := 'matias@volvo.se';
          Supplier.SalesRep.CommunicationCode := 'EM';
        end;

        with ee.EdiFactInfo do
        begin

          //Customer Info
          Volvo.LogicalAddress := '094200005560139700';
          Volvo.Qualifier := '30';
          Volvo.InternalAddress := '001001';
//          Volvo.LogicalAddress := dmod2.EDIBaseT.FieldByName('LogicalAddress').AsString; //'094200005560139700';
//          Volvo.Qualifier := dmod2.EDIBaseT.FieldByName('Qualifier').AsString;
//          Volvo.InternalAddress := dmod2.EDIBaseT.FieldByName('InternalAddress').AsString;
          Volvo.City := dmod2.EdiCustT.FieldByName('City').AsString;
          Volvo.Street := dmod2.EdiCustT.FieldByName('Street').AsString;
          Volvo.ZipCode := dmod2.EdiCustT.FieldByName('ZipCode').AsString;
          Volvo.CountryCode := dmod2.EdiCustT.FieldByName('CountryCode').AsString;
          Volvo.VATNumber := ConvertOrgNr2VAT(dmod2.CustomerT.FieldByName('Org_No').AsString);
          Volvo.VolvoUnit := dmod2.CustomerT.FieldByName('Name').AsString;

          //Driver info
          dmod2.CustomerT.Locate('Cust_id', dmod2.Contr_BaseT.FieldByName('DriveId').asinteger, [loCaseInsensitive]);
          Volvo.ReferencePerson.Name := dmod2.CustomerT.FieldByName('Name').AsString;
          Volvo.ReferencePerson.Department := dmod2.CustomerT.FieldByName('co_adr').AsString;
          if dmod2.CustomerT.FieldByName('Mailadress').AsString > '' then
          begin
            Volvo.ReferencePerson.ContactInfo := dmod2.CustomerT.FieldByName('Mailadress').AsString;
            Volvo.ReferencePerson.CommunicationCode := 'EM';
          end;
          if dmod2.CustomerT.FieldByName('Tel_Nr_1').AsString > '' then
          begin
            Volvo.ReferencePerson.ContactInfo := AnsiReplaceStr(dmod2.CustomerT.FieldByName('Tel_Nr_1').AsString, ' ', '');
            Volvo.ReferencePerson.CommunicationCode := 'TE';
          end;
        end;


        //AddTestPayeeInfo(ee.EdiFactInfo.Payee);
        with ee.EdiFactInfo do
        begin
          Payee.Name := dmod2.EdiCustT.FieldByName('Name').AsString;
          Payee.AccountNumber := dmod2.EdiCustT.FieldByName('AccountNumber').AsString;
          Payee.AccountHolder := dmod2.EdiCustT.FieldByName('AccountHolder').AsString;
          Payee.Bank := dmod2.EdiCustT.FieldByName('Bank').AsString;
          Payee.ParmaNumber := dmod2.EdiCustT.FieldByName('ParmaHolder').AsString;
          Payee.City := dmod2.EdiCustT.FieldByName('City').AsString;
          Payee.Street := dmod2.EdiCustT.FieldByName('Street').AsString;
          Payee.ZipCode := dmod2.EdiCustT.FieldByName('ZipCode').AsString;
          Payee.CountryCode := dmod2.EdiCustT.FieldByName('CountryCode').AsString;
        end;

        dmod2.FaktHeadT.Locate('Koref', dmod2.Contr_BaseT.FieldByName('ContrId').asinteger, [loCaseInsensitive]);
        dmod2.FaktRadT.Locate('FaktNr', dmod2.FaktHeadT.FieldByName('FaktNr').asinteger, [loCaseInsensitive]);

        //AddTestEdiFactInfo(ee.EdiFactInfo);
        with ee do
        begin
          EdiFactInfo.TimeStamp := now;
          dmod2.EdiBaseT.Edit;
          dmod2.EdiBaseT.FieldByName('ReferenceNumber').Value := dmod2.EdiBaseT.FieldByName('ReferenceNumber').Value +1;
          EdiFactInfo.ReferenceNumber := dmod2.EdiBaseT.FieldByName('ReferenceNumber').AsString;
          dmod2.EdiBaseT.Post;
          EdiFactInfo.IsTest := dmod2.EdiBaseT.FieldByName('IsTest').Value;
          EdiFactInfo.VATNumber := dmod2.EdiBaseT.FieldByName('VATNumber').AsString;
        end;

        with ee.EdiFactInfo do
        begin
          ReferenceNumber := dmod2.Contr_BaseT.FieldByName('ContrId').AsString;

          Invoice.ReferenceNumber := dmod2.FaktHeadT.FieldByName('KOREF').AsString;
          Invoice.InvoiceNumber := dmod2.FaktHeadT.FieldByName('E_FaktNr').AsString;
          Invoice.InvoiceDate := Date;
          Invoice.Currency := 'SEK';
          Invoice.HomeCurrency := 'SEK';
          Invoice.ExchangeRate := '1';

          while dmod2.FaktRadT.FieldByName('FaktNr').AsInteger = dmod2.FaktHeadT.FieldByName('FaktNr').asinteger do
          begin

            with Invoice.InvoiceItems.Add do
            begin
              VolvoItemNumber := 1;
              SupplierItemNumber := 1;
              Description := dmod2.FaktRadT.FieldByName('Text').AsString;
              LangCode :=  'SE';
              Amount := dmod2.FaktRadT.FieldByName('A_Pris').AsCurrency;
              Quantity := dmod2.FaktRadT.FieldByName('Antal').AsInteger;
              VATRate := '25';
              AGrossPrice := dmod2.FaktRadT.FieldByName('A_Pris').AsCurrency;;
              VATCategoryCode := 'S';
              VATAmount := dmod2.FaktRadT.FieldByName('A_Pris').AsCurrency * 0.25;
              VolvoOrderNumber := dmod2.FaktHeadT.FieldByName('E_FaktNr').AsString;
              VolvoOrderLineNumber := dmod2.FaktRadT.FieldByName('RAD').AsInteger;
            end;
            dmod2.FaktRadT.Next;
          end;
          Invoice.TotalInvoiceAmount := dmod2.FaktHeadT.FieldByName('FaktSum').AsCurrency;
          Invoice.TotalTaxableAmount := dmod2.FaktHeadT.FieldByName('FaktSum').AsCurrency - dmod2.FaktHeadT.FieldByName('MomsSum').AsCurrency;
          Invoice.TotalTaxAmount := dmod2.FaktHeadT.FieldByName('MomsSum').AsCurrency;
          Invoice.TotalItemsAmount := dmod2.FaktHeadT.FieldByName('VaruVarde').AsCurrency;
        end;

        sl := TStringList.Create;
        try
          sl.Text := ee.GetEdiFactText;
          CreatePathIfNecessary(ExtractFilePath(Application.ExeName)+'edifakturor\');
          sl.SaveToFile(format('%sContrNr_%s.edi',[ExtractFilePath(Application.ExeName)+'edifakturor\',dbgrid1.Columns[0].Field.AsString]));
        finally
          sl.free;
        end;
      finally
        ee.free;
      end;

    end;
    dbgrid1.DataSource.DataSet.Next;
  end;

end;

procedure TFrmFaktUts.CreatePathIfNecessary(path : string);
begin
  if not DirectoryExists(path) then
    CreateDir(path);
end;


end.

