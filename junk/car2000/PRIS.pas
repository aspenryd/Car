{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Pris.pas
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
{ $Log:  13088: PRIS.pas 
{
{   Rev 1.8    2004-08-13 09:11:34  pb64
}
{
{   Rev 1.7    2004-08-10 10:45:38  pb64
}
{
{   Rev 1.6    2004-05-11 11:02:52  peter
}
{
{   Rev 1.5    2003-12-29 15:14:32  peter
{ Ny rutin som kollar om Enummer har konterats.
}
{
{   Rev 1.4    2003-11-27 13:49:26  peter
{ Bokningsgraf bokning sedan dubbelklick gav fel.
{ Fix av delbetalar kontroll
{ Fix av ett fel inträffar + avrundning av moms i prisberäkning.
}
{
{   Rev 1.3    2003-08-26 12:45:48  peter
}
{
{   Rev 1.2    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.1    2003-06-10 13:31:42  hasp
}
{
{   Rev 1.0    2003-03-20 14:00:28  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:26  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
//  Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
//  Skapad: 1997-02-07 10:59:49                                   //
//                                                                //
// Noteringar :                                                   //
//                                                                //
//                                                                //
// Historia :                                                     //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////
unit pris;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls, ImgList, moneycomp, Menus, activeX, db,
  adodb;

type

  TDelCost = record
    namn: string;
    value: real;
    percent: real;
    byValue: boolean;
    vat: real;
  end;

  TDelbet = record
    namn: string;
    kostnader: array of TDelCost;
    Sum: real;
    Hyr: real;
    Moms: real;
    MomsPer: real;
    MomsStat: integer; //0 = Egen moms, 1 = Moms % efter total, 2 = Moms % efter egen summa, 9 = värde
    Dep: real;
    Tot: real;
  end;

  TKostnad = record
    namn: string;
    kostnader: array of TDelCost;
    Sum: real;
    Hyr: real;
    Moms: real;
    Dep: real;
    Tot: real;
  end;

  TfrmPris = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    Splitter3: TSplitter;
    ImageList2: TImageList;
    PageControl2: TPageControl;
    tabCost1: TTabSheet;
    pnlCost: TPanel;
    ScrollBox2: TScrollBox;
    Panel4: TPanel;
    Bevel1: TBevel;
    mpTotTot: TMoneyPanel;
    mpTotDep: TMoneyPanel;
    mpTotMoms: TMoneyPanel;
    mpTotHyr: TMoneyPanel;
    mpTotSum: TMoneyPanel;
    tabDelbet1: TTabSheet;
    ScrollBox1: TScrollBox;
    pnlDelTot: TPanel;
    Bevel3: TBevel;
    mpDelTot: TMoneyPanel;
    mpDelDep: TMoneyPanel;
    mpDelMoms: TMoneyPanel;
    mpDelHyr: TMoneyPanel;
    mpDelSum: TMoneyPanel;
    pnlDelBet: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Edit4Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure PageControl2Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure PageControl1Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    MoneyPanels: array of TMoneyPanel;
    CostPanels: array of TMoneyPanel;
    CostNames: array of string;
    procedure UpdateTot;
    procedure LoadDelBet(delno: integer);
    procedure SaveDelBet(delno: integer);
    procedure MPDelExit(Sender: TObject);
    procedure AddDelPage(namn: string);
    procedure AddCostPage(namn: string);
    procedure AddCostName(namn: string);
    procedure MPCostExit(Sender: TObject);
    procedure LoadDelCost(delcost: integer);
    procedure SaveDelCost(delcost: integer);
    function CountTotalCost(index: integer): real;
    procedure RecountDelBet;
    procedure ClearAll;
    Function IsInternKundBaz(txt:String):Boolean;
    { Private declarations }
  public
    MomsStatus: integer;
    MomsValue: real;
    MomsPercent: real;
    procedure UpdateAll;
    procedure UpdateCostTot;
    procedure AddDeposit(value: real);
    procedure AddCostsToPrice(costpart: integer; name: string; value, vat: real);
    function AddOtherCostsToPrice(name: string): integer;
    procedure AddObjektCostToPrice(Name: string; Days, KM, XDays,
      XKm, SRisk: currency; sriskVAT : boolean = true);
    function AddPartPayer(namn: string): integer;
    procedure UpdateCosts;
    procedure ChangePartPayer(pp: integer; Procent: Boolean; Hyrdel,
      KmDel, MomsDel: integer);
    { Public declarations }
  end;

Procedure MoveData(subid : Integer);
Procedure DelFakturera(subid : Integer);

function DoesEnummerExist(Enr : Integer):Boolean;
Procedure SetDS(Var ds:TADOQuery; SQL : String);
Function CreateDS(SQL : String):TADOQuery;
Function ExecDS(ds:TADOQuery):Integer;
Procedure FreeDS(ds:TADOQuery);



var
  frmPris: TfrmPris;
  Offertdlg: Boolean;
  VATFromTotal: boolean;
  delbetalare: array of TDelBet;
  delkostnader: array of TKostnad;
  MomsCountConst: smallint; //1 = Moms % efter total, 2 = Moms % efter egen summa

implementation

uses Search, Datamodule, Kontrakt, tmpdata, Main, Greg, Funcs, DataSession;

{$R *.DFM}

function DoesEnummerExist(Enr : Integer):Boolean;
var
  ds : TADOQuery;
begin
  ds := CreateDS('SELECT COUNT(*) FROM LOGGTABELL WHERE NUMMER='+IntToStr(Enr));
  try
    ds.Open;
    Result := ds.Fields[0].AsInteger>0;
  except
    Result := False;
  end;
  FreeDS(ds);
end;

Procedure SetDS(Var ds:TADOQuery; SQL : String);
begin
  ds.Active := False;
  ds.SQL.Clear;
  ds.SQL.Add(SQL);
end;

Function CreateDS(SQL : String):TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  TADOQuery(Result).ConnectionString := dmSession.ADOConnection1.ConnectionString;
  TADOQuery(Result).Connection :=  dmSession.ADOConnection1;
  SetDS(Result,SQL);
end;

Function ExecDS(ds:TADOQuery):Integer;
begin
  TADOQuery(ds).ExecSQL;
  Result := TADOQuery(ds).RowsAffected;
end;

Procedure FreeDS(ds:TADOQuery);
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
  ds := Nil;
end;

procedure SkapaKontrRadPost( ds :TADOQuery; typ, nr, konto, kstalle: integer; debet,kredit: Double);
begin
  if (debet = 0) and (kredit = 0) then
    exit;
  if Debet<0 then
  begin
    Kredit := Kredit-Debet;
    Debet := 0;
  end;
  if Kredit<0 then
  begin
    Debet  := Debet-Kredit;
    Kredit := 0;
  end;
  SetDS(ds,'SELECT * FROM KNTERRAD WHERE NRTyp='+IntToStr(typ)+' AND NUMMER='+IntToStr(Nr)+' AND KONTO='+IntToStr(Konto)+' AND KSTALLE='+IntToStr(kstalle));
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


procedure KonteraData(InternalFaktnr : Integer);
var
  q : TADOQuery;
  qFaktHead : TADOQuery;
  qFaktRad : TADOQuery;
  qParam : TADOQuery;
  qtmpData : TADOQuery;
  utData : TADOQuery;
  kstalle : Integer;
  kStalle_Debet,kStalle_Kredit : Integer;
  Koncern : Boolean;

function GetKstalle(styr,def_Konto,InternKonto,KoncernKonto,Def_Kstalle,Kundnr:Integer):Integer;
begin
   Result := 0;
   Case styr of
     0: begin
          if Koncern then
             Result := KoncernKonto
          else
             Result := def_Konto;
          kstalle := 0;
        end;
     1: begin
          q := CreateDS('SELECT IKonto,IKstalle FROM CUSTOMER WHERE Cust_Id='+IntToStr(Kundnr));
          q.Open;
          if q.FieldByName('IKONTO').AsInteger>0 then
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
          if qFaktHead.FieldByName('PAYMENT').AsString='I' then
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
  Koncern:= False;
  qFaktHead := CreateDS('SELECT * FROM FAKTHEAD WHERE FAKTNR='+IntToStr(InternalFaktnr));

  qFaktRad := CreateDS('SELECT rad,SUMMA,SUMMA_SEK,Kontonr,KStalleStyrning, InternKontoNr, KoncernKontoNr '+
        'FROM FAKTRAD INNER JOIN Kontering ON FAKTRAD.RAD=Kontering.Konteringsid '+
        'WHERE FAKTNR='+IntToStr(InternalFaktNr)+' AND RAD<6 and summa<>0 '+
        'union '+
        'SELECT rad,SUMMA,SUMMA_SEK,Acc_code,Acc_center, InternKontoNr, KoncernKontoNr '+
        'FROM FAKTRAD INNER JOIN Costs ON FAKTRAD.TEXT=Costs.Costname '+
        'WHERE FAKTNR='+IntToStr(InternalFaktNr)+' AND RAD>5 and summa<>0 '+
        'order by 1');

  qParam := CreateDS('SELECT * FROM PARAM');
  qParam.Open;
  kStalle_Debet := qParam.FieldByName('kstalle_debet').AsInteger;
  kStalle_Kredit := qParam.FieldByName('kstalle_Kredit').AsInteger;
  qParam.Active := False;
  qFaktHead.Open;
  if Not qFaktHead.IsEmpty then
  begin
    kStalle := 0;
    utData := CreateDS('SELECT Cust_Koncern from Customer where Cust_Id='+qFaktHead.FieldByName('Kundnr').AsString);
    utData.Open;
    Koncern := UtData.FieldByName('Cust_Koncern').AsBoolean;
    utData.Active := False;

    qTmpData := CreateDS('');
    // Kontera Kundfordringskonto Obs Ej KStalle + Intern Eller Koncern
    if qFaktHead.FieldByName('FAKTSUM').AsFloat<>0 then
    begin
      SetDS(qTmpData,'SELECT Kontonr, KStalleStyrning, InternKontoNr, KoncernKontoNr '+
          'FROM Betst INNER JOIN Kontering ON Betst.Konto = Kontering.Konteringsid '+
          ' WHERE Kod='''+qFaktHead.FieldByName('Payment').AsString+'''');
      qTmpData.Open;
      SkapaKontrRadPost(utData,1,InternalFaktnr,
        GetKstalle(qTmpData.FieldByName('KstalleStyrning').AsInteger,
        qTmpData.FieldByName('KontoNr').AsInteger,
        qTmpData.FieldByName('InternKontoNr').AsInteger,
        qTmpData.FieldByName('KoncernKontoNr').AsInteger,
        kStalle_Debet,qFaktHead.FieldByName('Kundnr').AsInteger)
        ,kStalle,qFaktHead.FieldByName('FAKTSUM').AsFloat,0);
    end;

    // Kontera Momskonto
    if qFaktHead.FieldByName('MOMSSUM').AsFloat<>0 then
    begin
      SetDS(qTmpdata,'SELECT Kontonr, KStalleStyrning, InternKontoNr, KoncernKontoNr '+
          'FROM Kontering,Param Where Param.Momskonto=Kontering.Konteringsid ');
      qTmpData.Open;
      SkapaKontrRadPost(utData,1,InternalFaktnr,qTmpData.FieldByName('KontoNr').AsInteger,0,0,qFaktHead.FieldByName('MOMSSUM').AsFloat);
    end;

    // Kontera Deposition
    if qFaktHead.FieldByName('DEP').AsFloat<>0 then
    begin
      SetDS(qTmpdata,'SELECT Kontonr, KStalleStyrning, InternKontoNr, KoncernKontoNr '+
          'FROM Kontering,Param Where Param.Dep_Konto=Kontering.Konteringsid ');
      qTmpData.Open;
      SkapaKontrRadPost(utData,1,InternalFaktnr,qTmpData.FieldByName('KontoNr').AsInteger,0,qFaktHead.FieldByName('DEP').AsFloat,0);
    end;

    // Kontera Avrundning
    if qFaktHead.FieldByName('AVRUNDNING').AsFloat<>0 then
    begin
      SetDS(qTmpdata,'SELECT AvrKonto ,AvrKstalle FROM Param ');
      qTmpData.Open;
      SkapaKontrRadPost(utData,1,InternalFaktnr,qTmpData.Fields[0].AsInteger,qTmpData.Fields[1].AsInteger,0,qFaktHead.FieldByName('AVRUNDNING').AsFloat);
    end;
    qFaktRad.Open;
    While Not qFaktRad.Eof do
    begin
      SkapaKontrRadPost(utData,1,InternalFaktnr,
        GetKstalle(98,
        qFaktRad.FieldByName('KontoNr').AsInteger,
        qFaktRad.FieldByName('InternKontoNr').AsInteger,
        qFaktRad.FieldByName('KoncernKontoNr').AsInteger,
        kStalle_Debet,0),kstalle,0,qFaktRad.FieldByName('SUMMA').AsFloat);
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

function MinSubid(Koref : Integer):Integer;
var
  ds2 : TADOQuery;
begin
  Result := 0;
  ds2 := CreateDS('SELECT MIN(SUBID) FROM CONTR_SUB WHERE CONTRID='+IntToStr(Koref));
  try
    ds2.Open;
    Result := ds2.Fields[0].AsInteger;
    ds2.Close;
  except
  end;
  FreeDS(ds2);
end;

Procedure MoveData(subid : Integer);
var
  InData : TADOQuery;
  utData : TADOQuery;
  tmpData : TADOQuery;
  NextFaktnr : Integer;
  VVarde : Real;
begin
  tmpData := CreateDS('SELECT MAX(FAKTNR) FROM FAKTHEAD');
  tmpData.Open;
  if tmpData.IsEmpty then
    NextFaktNr := 1
  else
    NextFaktnr := tmpData.Fields[0].AsInteger+1;
  tmpData.Close;
  utData := CreateDS('');

  inData :=CreateDS(
'SELECT contr_sub.SubId, contr_sub.ENummer, contr_sub.Print_Date, contr_sub.ForfalloDat-contr_sub.Terms_Pay AS FaktDat, contr_sub.ForfalloDat,contr_insur.INumber, contr_sub.Payment,'+
'contr_sub.ContrId, contr_sub.SpRule_Rent, contr_sub.SpRule_KM, contr_sub.SpRule_Vat, betalare.Cust_Id, betalare.Name as BetName, betalare.Co_Adr, '+
'betalare.Adress,betalare.Postal_Name,betalare.Country, betalare.Org_No,signr.NAMN,customer.Name As CustName,driver.Name As DriverName,'+
'contr_base.Referens,contr_base.Dep_Amount, contr_not.Cnot1, contr_not.Cnot2 ,Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL,'+
'contr_objt.Frm_Time, contr_objt.To_Time, contr_objt.OId, contr_objt.ObTypId,contr_objt.KM_In, contr_objt.KM_Out,objects.Model,objtype.Type, contr_subnot.faktnot1, contr_subnot.faktnot2 '+
'FROM Contr_Sub contr_sub LEFT OUTER JOIN Customer betalare ON contr_sub.SubCustId = betalare.Cust_Id INNER JOIN '+
'Contr_Base contr_base ON contr_base.ContrId = contr_sub.ContrId INNER JOIN Signr signr ON contr_base.Sign = signr.SIGN INNER JOIN '+
'Customer customer ON customer.Cust_Id = contr_base.CustID LEFT OUTER JOIN Customer driver ON contr_base.DriveId = driver.Cust_Id LEFT OUTER JOIN '+
'Contr_Not contr_not ON contr_base.ContrId = contr_not.Contrid INNER JOIN Contr_ObjT contr_objt ON contr_base.ContrId = contr_objt.ContrId INNER JOIN '+
'Objects objects ON contr_objt.OId = objects.Reg_No INNER JOIN ObjType objtype ON objects.Type = objtype.ID LEFT OUTER JOIN '+
'Contr_SubCost ON Contr_SubCost.SubId = contr_sub.SubId LEFT JOIN '+
'contr_insur ON Contr_Sub.SubId = contr_insur.SubId LEFT JOIN '+
'contr_subnot ON Contr_Sub.SubId = contr_subnot.SubId '+
'WHERE contr_sub.SubId='+IntToStr(subId)
);

  Indata.Open;

  if Not Indata.IsEmpty then
  begin
    SetDS(UtData,'SELECT * FROM FAKTHEAD WHERE KOREF='+InData.FieldByName('ContrId').AsString+' AND KUNDNR='+InData.FieldByName('Cust_Id').AsString+' ORDER BY FAKTNR DESC');
    UtData.Open;

    if utData.FieldByName('FAKTNR').AsInteger>0 then
    begin
      SetDS(tmpData,'SELECT * FROM LOGGTABELL WHERE NUMMER='+IntToStr(UtData.FieldByName('FAKTNR').AsInteger));
      tmpData.Open;
      if tmpData.IsEmpty then
      begin
        NextFaktNr := UtData.FieldByName('FAKTNR').AsInteger;
        DmSession.ADOConnection1.Execute('DELETE FAKTRAD WHERE FAKTNR='+IntToStr(NextFaktnr));
        DmSession.ADOConnection1.Execute('DELETE KNTERRAD WHERE NUMMER='+IntToStr(NextFaktnr));
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
    if UtData.FieldByName('UTSKRDAT').AsDateTime < 1.0 then
       UtData.FieldByName('UTSKRDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('FAKTDAT').AsDateTime := InData.FieldByName('FaktDat').AsDateTime;
    if UtData.FieldByName('FAKTDAT').AsDateTime < 1.0 then
       UtData.FieldByName('FAKTDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('FORFDAT').AsDateTime := InData.FieldByName('Forfallodat').AsDateTime;
    if UtData.FieldByName('FORFDAT').AsDateTime < 1.0 then
       UtData.FieldByName('FORFDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('KUNDNR').AsInteger := InData.FieldByName('Cust_Id').AsInteger;
    UtData.FieldByName('FAKTURAADRSTR').AsString :=InData.FieldByName('BetName').AsString + '#13'+
          InData.FieldByName('Co_Adr').AsString + '#13'+
          InData.FieldByName('Adress').AsString + '#13'+
          InData.FieldByName('Postal_Name').AsString + '#13'+
          InData.FieldByName('Country').AsString;

    UtData.FieldByName('KUNDVATNR').AsString := InData.FieldByName('Org_No').AsString;
    UtData.FieldByName('KOREF').AsInteger := InData.FieldByName('ContrId').AsInteger;
    UtData.FieldByName('FULLSIGN').AsString := InData.FieldByName('NAMN').AsString;
    UtData.FieldByName('HYRESMAN').AsString := InData.FieldByName('CustName').AsString;
    UtData.FieldByName('DRIVER').AsString := InData.FieldByName('DriverName').AsString;
    UtData.FieldByName('COMMENT').AsString := InData.FieldByName('FaktNot1').AsString+'#13'+InData.FieldByName('FaktNot2').AsString;
    UtData.FieldByName('REF').AsString := InData.FieldByName('Referens').AsString;
    UtData.FieldByName('NOTE').AsString := InData.FieldByName('CNot1').AsString+'#13'+InData.FieldByName('CNot2').AsString;
    UtData.FieldByName('INUMBER').AsString := InData.FieldByName('INumber').AsString;
    if MinSubId(InData.FieldByName('ContrId').AsInteger)=Subid then
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
    UtData.FieldByName('LANGUAGE').AsString := 'SE';
    UtData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
    UtData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
    UtData.FieldByName('ANDRATAV').AsString := 'IMP';

    tmpData.Close;
    SetDS(tmpData,'SELECT * FROM FAKTRAD WHERE FAKTNR='+IntToStr(NextFaktNr));
    tmpData.Open;
    VVarde := 0;
    InData.Close;
    SetDS(InData,'SELECT * FROM CONTR_SUBCOSTROW WHERE SUBID='+IntToStr(SubId));
    InData.Open;
    if Not InData.IsEmpty then
    begin
      While Not InData.Eof do
      begin
        tmpData.Append;
        tmpData.FieldByName('FAKTNR').AsInteger := NextFaktnr;
        tmpData.FieldByName('RAD').AsInteger := InData.FieldByName('RowNumb').AsInteger;
        tmpData.FieldByName('TEXT').AsString := InData.FieldByName('RowText').AsString;
        tmpData.FieldByName('ANTAL').AsFloat := 1;
        tmpData.FieldByName('A_PRIS').AsFloat := Round(InData.FieldByName('Value').AsFloat*100)/100.00;
        tmpData.FieldByName('A_PRIS_SEK').AsFloat := Round(InData.FieldByName('Value').AsFloat*100)/100.00;
        tmpData.FieldByName('RABATT').AsFloat := 0;
        tmpData.FieldByName('RABATT_SEK').AsFloat := 0;
        tmpData.FieldByName('SUMMA').AsFloat := Round(InData.FieldByName('Value').AsFloat*100)/100.00;
        tmpData.FieldByName('SUMMA_SEK').AsFloat := Round(InData.FieldByName('Value').AsFloat*100)/100.00;
        tmpData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
        tmpData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
        tmpData.FieldByName('ANDRATAV').AsString := 'IMP';
        VVarde := VVarde + Round(InData.FieldByName('Value').AsFloat*100)/100.00;
        tmpData.Post;
        InData.Next;
      end;
    end;

    UtData.FieldByName('VARUVARDE').AsFloat := VVarde;
    UtData.FieldByName('FAKTSUM').AsFloat := Round(UtData.FieldByName('VARUVARDE').AsFloat+UtData.FieldByName('MOMSSUM').AsFloat);
    UtData.FieldByName('AVRUNDNING').AsFloat := UtData.FieldByName('FAKTSUM').AsFloat - (UtData.FieldByName('VARUVARDE').AsFloat+UtData.FieldByName('MOMSSUM').AsFloat);
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

Procedure CheckHowToinvoice(InData : TADOQuery;StartDatum : TDateTime; Var NoOfMonth : Integer;Var Price : Real);
var
  SlutDatum : TDateTime;
  y,m,d,y2,m2,d2 : Word;
begin
  SlutDatum := inData.FieldByName('DF_SLUTDATUM').AsDateTime;
  if SlutDatum<StartDatum then
    SlutDatum:=trunc(now);
  if Slutdatum>Trunc(now) then
    SlutDatum:=trunc(now);
  NoOfMonth := 0;
  if StartDatum<inData.FieldByName('DF_FAKT2DATUM').AsDateTime then
    StartDatum := inData.FieldByName('DF_FAKT2DATUM').AsDateTime;
  if StartDatum<inData.FieldByName('DF_STARTDATUM').AsDateTime then
    StartDatum := inData.FieldByName('DF_STARTDATUM').AsDateTime;

  While (StartDatum<SlutDatum) do
  begin
     inc(NoOfMonth);
     StartDatum := StartDatum + 30;
  end;
  Price := NoOfMonth * inData.FieldByName('DF_BELOPP').AsFloat;
  InData.Edit;
  inData.FieldByName('DF_FAKT2DATUM').AsDateTime := StartDatum;
  InData.Post;
end;

Procedure DelFakturera(Subid : Integer);
var
  InData : TADOQuery;
  utData : TADOQuery;
  tmpData : TADOQuery;
  NextFaktnr : Integer;
  VVarde,Price : Real;
  NoOfMonth : Integer;
begin
  tmpData := CreateDS('SELECT MAX(FAKTNR) FROM FAKTHEAD');
  tmpData.Open;
  if tmpData.IsEmpty then
    NextFaktNr := 1
  else
    NextFaktnr := tmpData.Fields[0].AsInteger+1;
  tmpData.Close;
  utData := CreateDS('');

  inData :=CreateDS(
'SELECT contr_sub.SubId, 0 AS ENummer, GETDATE() AS Print_Date, GETDATE() AS FaktDat, GETDATE()+contr_sub.Terms_Pay AS ForfalloDat,contr_insur.INumber, contr_sub.Payment,'+
'contr_sub.ContrId, contr_sub.SpRule_Rent, contr_sub.SpRule_KM, contr_sub.SpRule_Vat, betalare.Cust_Id, betalare.Name as BetName, betalare.Co_Adr, '+
'betalare.Adress,betalare.Postal_Name,betalare.Country, betalare.Org_No,signr.NAMN,customer.Name As CustName,driver.Name As DriverName,'+
'contr_base.Referens,0 AS Dep_Amount, contr_not.Cnot1, contr_not.Cnot2 ,0 AS DSUM, Contr_base.DF_BELOPP*0.25 AS DMOMS, Contr_base.DF_BELOPP*1.25 AS DTOTAL,'+
'contr_objt.Frm_Time, contr_objt.To_Time, contr_objt.OId, contr_objt.ObTypId,contr_objt.KM_In, contr_objt.KM_Out,objects.Model,objtype.Type, contr_subnot.faktnot1, contr_subnot.faktnot2 '+
'FROM Contr_Sub contr_sub LEFT OUTER JOIN Customer betalare ON contr_sub.SubCustId = betalare.Cust_Id INNER JOIN '+
'Contr_Base contr_base ON contr_base.ContrId = contr_sub.ContrId INNER JOIN Signr signr ON contr_base.Sign = signr.SIGN INNER JOIN '+
'Customer customer ON customer.Cust_Id = contr_base.CustID LEFT OUTER JOIN Customer driver ON contr_base.DriveId = driver.Cust_Id LEFT OUTER JOIN '+
'Contr_Not contr_not ON contr_base.ContrId = contr_not.Contrid INNER JOIN Contr_ObjT contr_objt ON contr_base.ContrId = contr_objt.ContrId INNER JOIN '+
'Objects objects ON contr_objt.OId = objects.Reg_No INNER JOIN ObjType objtype ON objects.Type = objtype.ID LEFT OUTER JOIN '+
'contr_insur ON Contr_Sub.SubId = contr_insur.SubId LEFT JOIN '+
'contr_subnot ON Contr_Sub.SubId = contr_subnot.SubId '+
'WHERE contr_sub.SubId='+IntToStr(subId)
);

  Indata.Open;

  if Not Indata.IsEmpty then
  begin
    SetDS(UtData,'SELECT * FROM FAKTHEAD WHERE KOREF='+InData.FieldByName('ContrId').AsString+' AND KUNDNR='+InData.FieldByName('Cust_Id').AsString+' ORDER BY FAKTNR DESC');
    UtData.Open;

    if utData.FieldByName('FAKTNR').AsInteger>0 then
    begin
      SetDS(tmpData,'SELECT * FROM LOGGTABELL WHERE NUMMER='+IntToStr(UtData.FieldByName('FAKTNR').AsInteger));
      tmpData.Open;
      if tmpData.IsEmpty then
      begin
        NextFaktNr := UtData.FieldByName('FAKTNR').AsInteger;
        DmSession.ADOConnection1.Execute('DELETE FAKTRAD WHERE FAKTNR='+IntToStr(NextFaktnr));
        DmSession.ADOConnection1.Execute('DELETE KNTERRAD WHERE NUMMER='+IntToStr(NextFaktnr));
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
    UtData.FieldByName('UTSKRDAT').AsDateTime := Trunc(InData.FieldByName('Print_Date').AsDateTime);
    if UtData.FieldByName('UTSKRDAT').AsDateTime < 1.0 then
       UtData.FieldByName('UTSKRDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('FAKTDAT').AsDateTime := Trunc(InData.FieldByName('FaktDat').AsDateTime);
    if UtData.FieldByName('FAKTDAT').AsDateTime < 1.0 then
       UtData.FieldByName('FAKTDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('FORFDAT').AsDateTime := Trunc(InData.FieldByName('Forfallodat').AsDateTime);
    if UtData.FieldByName('FORFDAT').AsDateTime < 1.0 then
       UtData.FieldByName('FORFDAT').AsDateTime := Trunc(Now);
    UtData.FieldByName('KUNDNR').AsInteger := InData.FieldByName('Cust_Id').AsInteger;
    UtData.FieldByName('FAKTURAADRSTR').AsString :=InData.FieldByName('BetName').AsString + '#13'+
          InData.FieldByName('Co_Adr').AsString + '#13'+
          InData.FieldByName('Adress').AsString + '#13'+
          InData.FieldByName('Postal_Name').AsString + '#13'+
          InData.FieldByName('Country').AsString;

    UtData.FieldByName('KUNDVATNR').AsString := InData.FieldByName('Org_No').AsString;
    UtData.FieldByName('KOREF').AsInteger := InData.FieldByName('ContrId').AsInteger;
    UtData.FieldByName('FULLSIGN').AsString := InData.FieldByName('NAMN').AsString;
    UtData.FieldByName('HYRESMAN').AsString := InData.FieldByName('CustName').AsString;
    UtData.FieldByName('DRIVER').AsString := InData.FieldByName('DriverName').AsString;
    UtData.FieldByName('COMMENT').AsString := InData.FieldByName('FaktNot1').AsString+'#13'+InData.FieldByName('FaktNot2').AsString;
    UtData.FieldByName('REF').AsString := InData.FieldByName('Referens').AsString;
    UtData.FieldByName('NOTE').AsString := InData.FieldByName('CNot1').AsString+'#13'+InData.FieldByName('CNot2').AsString;
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
    UtData.FieldByName('KM_IN').AsInteger := InData.FieldByName('KM_OUT').AsInteger;
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
    SetDS(tmpData,'SELECT * FROM FAKTRAD WHERE FAKTNR='+IntToStr(NextFaktNr));
    tmpData.Open;
    VVarde := 0;
    InData.Close;
    SetDS(InData,'SELECT CONTR_BASE.* FROM CONTR_BASE WHERE CONTRID='+UtData.FieldByName('KOREF').AsString);
    InData.Open;
    if Not InData.IsEmpty then
    begin

      CheckHowToinvoice(InData,UtData.FieldByName('FRM_TIME').AsDateTime,NoOfMonth,Price);

      tmpData.Append;
      tmpData.FieldByName('FAKTNR').AsInteger := NextFaktnr;
      tmpData.FieldByName('RAD').AsInteger := 99;
      tmpData.FieldByName('TEXT').AsString := 'Delfaktura fram till '+ inData.FieldByName('DF_FAKT2DATUM').AsString;
      tmpData.FieldByName('ANTAL').AsFloat := 1;
      tmpData.FieldByName('A_PRIS').AsFloat := Round(Price*100)/100.00;
      tmpData.FieldByName('A_PRIS_SEK').AsFloat := Round(Price*100)/100.00;
      tmpData.FieldByName('RABATT').AsFloat := 0;
      tmpData.FieldByName('RABATT_SEK').AsFloat := 0;
      tmpData.FieldByName('SUMMA').AsFloat := Round(Price*100)/100.00;
      tmpData.FieldByName('SUMMA_SEK').AsFloat := Round(Price*100)/100.00;
      tmpData.FieldByName('REGTIDPUNKT').AsDateTime := Now;
      tmpData.FieldByName('ANDRATTIDPUNKT').AsDateTime := Now;
      tmpData.FieldByName('ANDRATAV').AsString := 'IMP';
      VVarde := VVarde + Round(InData.FieldByName('DF_BELOPP').AsFloat*100)/100.00;
      tmpData.Post;
    end;

    UtData.FieldByName('VARUVARDE').AsFloat := VVarde;
    UtData.FieldByName('FAKTSUM').AsFloat := Round(UtData.FieldByName('VARUVARDE').AsFloat+UtData.FieldByName('MOMSSUM').AsFloat);
    UtData.FieldByName('AVRUNDNING').AsFloat := UtData.FieldByName('FAKTSUM').AsFloat - (UtData.FieldByName('VARUVARDE').AsFloat+UtData.FieldByName('MOMSSUM').AsFloat);
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
//  KonteraData(NextFaktnr);
try
  FreeDS(UtData);
  FreeDS(InData);
  FreeDS(tmpData);
except
      ShowMessage('Fel vid plats #10');
end;
end;



procedure TfrmPris.UpdateTot;
var
  I: Integer;
  vat, sum: real;
begin
  sum := 0;
  vat := 0;
  for I := 0 to 3 do
  begin
    sum := sum + RoundValue (MoneyPanels[i].MoneyValue);
    vat := vat + RoundValue(RoundValue(MoneyPanels[i].MoneyValue) * delbetalare[0].kostnader[i].vat);
  end;
  mpDelHyr.MoneyValue := sum;
  for I := 4 to length(MoneyPanels) - 1 do
  begin
    sum := sum + RoundValue(MoneyPanels[i].MoneyValue);
    vat := vat + RoundValue(RoundValue(MoneyPanels[i].MoneyValue) * delbetalare[0].kostnader[i].vat);
  end;
  mpDelSum.MoneyValue := sum;
  mpDelMoms.MoneyTotals := mpTotMoms.MoneyValue;
  //Lägg in kod för hantering av momssplittning
  case MomsStatus of
    0: //0 = Egen moms
      begin
        mpDelMoms.ByValue := true;
        mpDelMoms.MoneyValue := RoundValue(vat);
      end;
    1: //1 = Moms % efter total
      begin
        mpDelMoms.ByValue := false;
        mpDelMoms.MoneyPercent := MomsPercent;
      end;
    2: //2 = Moms % efter egen summa
      begin
        mpDelMoms.MoneyTotals := vat;
        mpDelMoms.ByValue := false;
        mpDelMoms.MoneyPercent := MomsPercent;
      end;
    9: //9 = Fast värde
      begin
        mpDelMoms.ByValue := true;
        mpDelMoms.MoneyValue := RoundValue(MomsValue);
      end;
  end;

  mpDelTot.MoneyValue := sum + RoundValue(mpDelMoms.MoneyValue) - mpDelDep.MoneyValue;
end;

procedure TfrmPris.Edit4Exit(Sender: TObject);
begin
//  MoneyEditUpdate(Edit3,strtoint(Edit4.text));
end;

procedure TfrmPris.PageControl1Change(Sender: TObject);
begin
  pnlDelbet.parent := PageControl1.ActivePage;
  LoadDelBet(PageControl1.ActivePage.PageIndex);
  if PageControl1.ActivePage.TabIndex = 0 then
  begin
    pnlDelbet.Enabled := false;
//    pnlDelTot.Enabled := false;
  end
  else
  begin
    pnlDelbet.Enabled := true;
//    pnlDelTot.Enabled := true;
  end;
end;

procedure TfrmPris.LoadDelBet(delno: integer);
var
  I, J: Integer;
  sum, moms: real;
  delbet: TDelBet;
  Test:String;
begin
  delbet := delbetalare[delno];

  if delno = 0 then //Huvudbetalare
  begin
    for I := 0 to length(MoneyPanels) - 1 do
    begin
      sum := 0;
      for J := 1 to length(delbetalare) - 1 do
        sum := sum + delbetalare[J].kostnader[I].value;
      MoneyPanels[i].Caption := delbet.kostnader[I].namn;
      MoneyPanels[i].ByValue := true;
      MoneyPanels[i].MoneyValue := MoneyPanels[i].MoneyTotals - sum;
    end;
    moms := 0;
    for J := 1 to length(delbetalare) - 1 do
      moms := moms + delbetalare[J].Moms;
    mpDelMoms.MoneyValue := mpTotMoms.MoneyValue - moms;
    MomsStatus := -1;
  end
  else
  begin
    for I := 0 to length(MoneyPanels) - 1 do
    begin
      MoneyPanels[i].Caption := delbet.kostnader[I].namn;
      MoneyPanels[i].ByValue := delbet.kostnader[I].byValue;
      if MoneyPanels[i].ByValue then
        MoneyPanels[i].MoneyValue := delbet.kostnader[I].value
      else
        MoneyPanels[i].MoneyPercent := delbet.kostnader[I].percent;
    end;
    MomsStatus := delbet.MomsStat;
    MomsValue := delbet.Moms;
    MomsPercent := delbet.MomsPer;
  end;
  mpDelDep.MoneyValue := delbet.dep;
  UpdateTot;
end;

procedure TfrmPris.SaveDelBet(delno: integer);
var
  I: Integer;
begin
  for I := 0 to length(delbetalare[delno].kostnader) - 1 do
  begin
    delbetalare[delno].kostnader[I].byValue := MoneyPanels[I].ByValue;
    delbetalare[delno].kostnader[I].value := MoneyPanels[I].MoneyValue;
    delbetalare[delno].kostnader[I].percent := MoneyPanels[I].Moneypercent;
  end;
  delbetalare[delno].Moms := mpDelMoms.MoneyValue;
  delbetalare[delno].MomsPer := mpDelMoms.MoneyPercent;
  if mpDelMoms.ByValue then
    delbetalare[delno].MomsStat := 9
  else
    delbetalare[delno].MomsStat := MomsCountConst;
  delbetalare[delno].Sum := mpDelSum.MoneyValue;
  delbetalare[delno].Hyr := mpDelHyr.MoneyValue;
  delbetalare[delno].Dep := mpDelDep.MoneyValue;
  delbetalare[delno].Tot := mpDelTot.MoneyValue;
end;

procedure TfrmPris.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if pnlDelbet.enabled then
    pnlDelbet.SetFocus;
  SaveDelBet(PageControl1.ActivePage.PageIndex);
end;

procedure TfrmPris.AddDelPage(namn: string);
begin
  with TTabSheet.Create(Self) do
  begin
    PageControl := PageControl1;
    if length(namn) > 12 then
      Caption := Copy(namn, 1, 12) + '...'
    else
      Caption := namn;
  end;
end;

procedure TfrmPris.AddCostPage(namn: string);
begin
  with TTabSheet.Create(Self) do
  begin
    PageControl := PageControl2;
    Caption := namn;
  end;
end;

procedure TfrmPris.AddCostName(namn: string);
var I: Integer;
begin
  for I := 0 to length(CostNames) - 1 do
    if CostNames[i] = namn then
      exit;
  SetLength(CostNames, length(CostNames) + 1);
  CostNames[length(CostNames) - 1] := namn;
end;

procedure TfrmPris.AddObjektCostToPrice(Name: string; Days, KM, XDays, XKm, SRisk: currency; sriskVAT : boolean = true);
var I, BennyMoms: Integer;
begin
  BennyMoms := dmod.paramT.fieldbyname('Moms').asinteger;
  I := length(delkostnader);
  SetLength(delkostnader, I + 1);
  delkostnader[I].namn := Name;
  setlength(delkostnader[I].kostnader, 5);
  with delkostnader[I] do
  begin
//!    kostnader[0].namn := 'Dygn';
    kostnader[0].namn := frmsearch.mintidtext;
    kostnader[0].byValue := true;
    kostnader[0].value := Days;
    kostnader[0].vat := BennyMoms / 100; //!0.25;
    kostnader[1].namn := 'Kilometer';
    kostnader[1].byValue := true;
    kostnader[1].value := Km;
    kostnader[1].vat := BennyMoms / 100; //!0.25;
    kostnader[2].namn := 'Överdygn';
    kostnader[2].byValue := true;
    kostnader[2].value := XDays;
    kostnader[2].vat := BennyMoms / 100; //!0.25;
    kostnader[3].namn := 'Överkilometer';
    kostnader[3].byValue := true;
    kostnader[3].value := XKm;
    kostnader[3].vat := BennyMoms / 100; //!0.25;
    kostnader[4].namn := 'Självrisk reducering';
    kostnader[4].byValue := true;
    kostnader[4].value := SRisk;
    if sriskVAT then
      kostnader[4].vat := BennyMoms / 100    //!0.25;
    else
      kostnader[4].vat := 0;
  end;
end;

function TfrmPris.AddOtherCostsToPrice(name: string): integer;
var
  I: Integer;
begin
  I := length(delkostnader);
  SetLength(delkostnader, I + 1);
  delkostnader[I].namn := Name;
  setlength(delkostnader[I].kostnader, 0);
  result := I;
end;

procedure TfrmPris.AddCostsToPrice(costpart: integer; name: string; value, vat: real);
var I: Integer;
begin
  I := length(delkostnader[costpart].kostnader);
  setlength(delkostnader[costpart].kostnader, I + 1);
  with delkostnader[costpart] do
  begin
    kostnader[I].namn := name;
    kostnader[I].byValue := true;
    kostnader[I].value := value;
    kostnader[I].vat := vat;
  end;
end;

procedure TfrmPris.ClearAll;
begin
  SetLength(delkostnader, 0);
  SetLength(delbetalare, 0);
end;

procedure TfrmPris.FormCreate(Sender: TObject);
begin
  ClearAll;
  AddObjektCostToPrice('Total', 0, 0, 0, 0, 0);
end;

function TfrmPris.AddPartPayer(namn: string): integer;
var I, J, BMoms: Integer;
begin
  bmoms := dmod.paramT.fieldbyname('Moms').asinteger;
  I := length(delbetalare);
  SetLength(delbetalare, I + 1);
  delbetalare[i].namn := namn;
  if I > 0 then
    AddDelPage(namn)
  else
    tabDelbet1.Caption := namn;
  SetLength(delbetalare[I].kostnader, length(costNames));
  for J := 0 to length(delbetalare[I].kostnader) - 1 do
  begin
    delbetalare[I].kostnader[J].byValue := true;
    delbetalare[I].kostnader[J].vat := bmoms / 100; //!0.25;
    delbetalare[I].kostnader[J].namn := CostNames[J];
  end;
  if I = 0 then
    delbetalare[I].Dep := mpTotDep.MoneyValue;
  result := I;
end;

procedure TfrmPris.UpdateCosts;
var I, J: Integer;
begin
  for I := 1 to length(delkostnader) - 1 do
    for J := 0 to length(delkostnader[i].kostnader) - 1 do
      AddCostName(delkostnader[i].kostnader[j].namn);

  SetLength(delkostnader[0].kostnader, length(CostNames));
  for I := 0 to length(CostNames) - 1 do
    delkostnader[0].kostnader[i].namn := CostNames[i];

  tabCost1.Caption := delkostnader[0].namn;
  for I := 1 to length(delkostnader) - 1 do
  begin
    AddCostPage(delkostnader[I].namn);
  end;
end;

procedure TfrmPris.MPCostExit(Sender: TObject);
var
  cost: TKostnad;
  I: Integer;
begin
  cost := Delkostnader[PageControl2.ActivePage.Tabindex];
  for I := 0 to length(cost.kostnader) - 1 do
    if (Sender as TMoneyPanel).caption = cost.kostnader[I].namn then
      cost.kostnader[I].value := (Sender as TMoneyPanel).MoneyValue;
  UpdateCostTot;
  SaveDelBet(PageControl1.ActivePage.PageIndex); //!Benny
end;

procedure TfrmPris.UpdateAll;
var I: Integer;
begin
  SetLength(Costpanels, length(CostNames));
  for I := 0 to length(CostPanels) - 1 do
  begin
    CostPanels[i] := TMoneyPanel.Create(self);
    CostPanels[i].parent := ScrollBox2;
    CostPanels[i].Align := alTop;
    CostPanels[i].OnExit := MPCostExit;
    CostPanels[i].Caption := CostNames[i];
    CostPanels[i].Decimals := 4;
  end;

  SetLength(Moneypanels, length(CostNames));
  for I := 0 to length(MoneyPanels) - 1 do
  begin
    MoneyPanels[i] := TMoneyPanel.Create(self);
    MoneyPanels[i].parent := ScrollBox1;
    MoneyPanels[i].Align := alTop;
    MoneyPanels[i].OnExit := MPDelExit;
    MoneyPanels[i].ImageList := ImageList2;
    MoneyPanels[i].Caption := CostNames[i];
    MoneyPanels[i].ShowPercent := true;
    MoneyPanels[i].Decimals := 4;
  end;
  for I := 1 to length(delkostnader) - 1 do
    LoadDelCost(I);

end;

procedure TfrmPris.FormActivate(Sender: TObject);
begin
  LoadDelCost(0);
  UpdateCostTot;
  RecountDelBet;
  PageControl1Change(nil);
  if length(delbetalare) > 1 then
  begin
    GroupBox2.visible := true;
    GroupBox1.align := alLeft;
  end
  else
  begin
    GroupBox2.visible := false;
    GroupBox1.align := alClient;
    width := width div 2;
  end;
  bitbtn1.SetFocus;
end;

procedure TfrmPris.RecountDelBet;
var I: Integer;
begin
  for I := length(delbetalare) - 1 downto 1 do
  begin
    LoadDelBet(I);
    SaveDelBet(I);
  end;
  LoadDelBet(0);
  SaveDelBet(0);
end;

procedure TfrmPris.MPDelExit(Sender: TObject);
begin
  UpdateTot;
end;

function TfrmPris.CountTotalCost(index: integer): real;
var I, J: Integer;
begin
  result := 0;
  for I := 1 to length(delkostnader) - 1 do
    for J := 0 to length(delkostnader[I].kostnader) - 1 do
      if delkostnader[I].kostnader[J].namn = costpanels[index].caption then
        result := result + delkostnader[I].kostnader[J].value;
end;

procedure TfrmPris.UpdateCostTot;
var
  hsum, sum, vat: real;
  I: Integer;
begin
  sum := 0;
  vat := 0;
  hsum := 0;
  for I := 0 to length(MoneyPanels) - 1 do
  begin
    MoneyPanels[I].MoneyTotals := CountTotalCost(I);
    if CostPanels[I].visible then
    begin
      if I < 4 then
        hsum := hsum + CostPanels[I].MoneyValue;
      sum := sum + CostPanels[I].MoneyValue;
      vat := vat + (round(CostPanels[I].MoneyValue * CostPanels[I].vat * 100.0)/100.0)
    end;
  end;
  //! Här ska noll i Vat om det är en internKund
  //! Moms på Interna i Norge
  if (tmpdata.InternKund = True) and (intmoms = False)
    then Vat := 0;
  mpTotSum.MoneyValue := sum;
  mpTotHyr.MoneyValue := hsum;
  mpTotMoms.MoneyValue := vat;
//  mpTotDep.MoneyValue := 0;
  mpTotTot.MoneyValue := sum + vat - mpTotDep.MoneyValue;
  mpDelSum.MoneyTotals := mpTotSum.MoneyValue;
  mpDelHyr.MoneyTotals := mpTotHyr.MoneyValue;
  mpDelMoms.MoneyTotals := mpTotMoms.MoneyValue;
  mpDelDep.MoneyTotals := mpTotDep.MoneyValue;
  mpDelTot.MoneyTotals := mpTotTot.MoneyValue;
  PageControl1Change(nil);
end;

procedure TfrmPris.LoadDelCost(delcost: integer);
var
  I, J, L: Integer;
  cost: TKostnad;
  iscool: boolean;
begin
  cost := delkostnader[delcost];
  L := -1;

  for I := 0 to length(costpanels) - 1 do
    CostPanels[i].visible := true;

  if delcost = 0 then //Total
  begin
    for I := 0 to length(cost.kostnader) - 1 do
    begin
      CostPanels[i].top := I * CostPanels[i].height;
      CostPanels[i].ByValue := true;
      CostPanels[i].MoneyValue := CountTotalCost(I);
    end;
  end
  else
  begin
    for J := 0 to length(CostPanels) - 1 do
    begin
      iscool := false;
      for I := 0 to length(cost.kostnader) - 1 do
        if CostPanels[J].caption = cost.kostnader[I].namn then
        begin
          L := I;
          iscool := true;
        end;
      if iscool then
      begin
        CostPanels[J].visible := true;
        CostPanels[J].top := L * CostPanels[J].height;
        CostPanels[J].ByValue := true;
        CostPanels[J].MoneyValue := cost.kostnader[L].value;
        CostPanels[J].vat := cost.kostnader[L].vat;
      end
      else
        CostPanels[J].visible := false
    end;
  end;
end;

procedure TfrmPris.SaveDelCost(delcost: integer);
var
  I, J: Integer;
  cost: TKostnad;
begin
  cost := delkostnader[delcost];

  if delcost > 0 then //Total
    for J := 0 to length(CostPanels) - 1 do
    begin
      if Costpanels[J].visible = true then
        for I := 0 to length(cost.kostnader) - 1 do
          if CostPanels[J].caption = cost.kostnader[I].namn then
          begin
            cost.kostnader[I].value := CostPanels[J].MoneyValue;
          end;
    end;
end;

procedure TfrmPris.PageControl2Change(Sender: TObject);
begin
  LoadDelCost(PageControl2.ActivePage.TabIndex);
  if PageControl2.ActivePage.TabIndex = 0 then
    pnlCost.Enabled := false
  else
    pnlCost.Enabled := true;
  pnlCost.parent := PageControl2.ActivePage;
  UpdateCostTot;
end;

procedure TfrmPris.PageControl2Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  PageControl2.SetFocus;
  SaveDelCost(PageControl2.ActivePage.TabIndex);
end;

procedure TfrmPris.ChangePartPayer(pp: integer; Procent: Boolean; Hyrdel, KmDel, MomsDel: integer);
begin
  if length(delbetalare[pp].kostnader) > 4 then
  begin
    if Procent then
    begin
      if HyrDel > 0 then
      begin
        delbetalare[pp].kostnader[0].byValue := not Procent;
        delbetalare[pp].kostnader[0].percent := Hyrdel;
        delbetalare[pp].kostnader[2].byValue := not Procent;
        delbetalare[pp].kostnader[2].percent := Hyrdel;
      end;
      if KmDel > 0 then
      begin
        delbetalare[pp].kostnader[1].byValue := not Procent;
        delbetalare[pp].kostnader[1].percent := Kmdel;
        delbetalare[pp].kostnader[3].byValue := not Procent;
        delbetalare[pp].kostnader[3].percent := Kmdel;
      end;
      if MomsDel >= 0 then
      begin
        if MomsDel = 0 then //!=999
        begin
          delbetalare[pp].MomsStat := 9; //!momsstat:=0
          delbetalare[pp].MomsPer := 100;
        end
        else
        begin
          delbetalare[pp].MomsStat := MomsCountConst;
          delbetalare[pp].MomsPer := MomsDel;
        end;
      end;
    end
    else
    begin
      if HyrDel > 0 then
      begin
        delbetalare[pp].kostnader[0].byValue := not Procent;
        delbetalare[pp].kostnader[0].value := Hyrdel;
      end;
      if KmDel > 0 then
      begin
        delbetalare[pp].kostnader[1].byValue := not Procent;
        delbetalare[pp].kostnader[1].value := Kmdel;
      end;

      delbetalare[pp].Moms := MomsDel;
      delbetalare[pp].MomsStat := 9;
    end;
  end;
end;

procedure TfrmPris.PageControl1Exit(Sender: TObject);
begin
  SaveDelBet(PageControl1.ActivePage.PageIndex);

end;

procedure TfrmPris.AddDeposit(value: real);
begin
  mpTotDep.MoneyValue := value;
end;

procedure TfrmPris.BitBtn1Click(Sender: TObject);
begin
 PageControl2.ActivePageIndex :=0;
 PageControl1.ActivePageIndex :=0;

  BTMoms := mptotMoms.MoneyValue;
  BtSum := mptottot.moneyvalue;
end;

function TfrmPris.IsInternKundBaz(txt: String): Boolean;
begin
 if frmGReg.CustomerT.Locate('Name',txt,[LoCaseInSensitive]) then
  result:=frmgreg.CustomerT.FieldByName('int_cust').AsBoolean ;
end;

end.

