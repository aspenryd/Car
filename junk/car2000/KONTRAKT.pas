{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Kontrakt.pas
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
{ $Log:  13074: KONTRAKT.pas
{
{   Rev 1.19    2004-12-09 13:43:02  pb64
}
{
{   Rev 1.17.1.0    2004-08-10 10:45:34  pb64
}
{
{   Rev 1.17    2004-05-11 13:51:00  peter
}
{
{   Rev 1.16    2004-05-11 11:02:48  peter
}
{
{   Rev 1.15    2004-01-27 12:18:42  peter
{ Popup "Hyresman är ett företag" skall styras av parameter.
{ + Parameter dg_timer i ini. <0=Visar ej, >0 visar i x sekunder, 0=visar
{
{ Pristyp från kund slår inte igenom vid nytt kontrakt/Bokning.
{ + Fixat 26/1-04
{
{ Bilägarnummer sökning på reg.nummer via F6 (Kontroll att det finns).
{ + Fungerar
{
{ Concatenerad info bör innehålla pristyp,prisklass och KM_Ut + Km_In.
{
{ Vid enter på km_in (återlämning) fungerar detta inte.
{ + Fixat
{ + Fixat bug vid felmeddelande access violation..
}
{
{   Rev 1.14    2004-01-15 14:26:26  peter
{ Formaterat koden
}
{
{   Rev 1.13    2003-12-30 16:45:20  hasp
}
{
{   Rev 1.12    2003-12-29 15:42:38  hasp
}
{
{   Rev 1.11    2003-12-29 15:34:02  peter
{ Tillåter ej förändring till överförda kontrakt
}
{
{   Rev 1.10    2003-12-29 13:17:46  peter
{ Fixat bug där enkel betalare ej flyttade över uppgifter till fakthead vid
{ återlämning.
}
{
{   Rev 1.9    2003-12-29 00:44:02  hasp
}
{
{   Rev 1.8    2003-11-27 13:49:24  peter
{ Bokningsgraf bokning sedan dubbelklick gav fel.
{ Fix av delbetalar kontroll
{ Fix av ett fel inträffar + avrundning av moms i prisberäkning.
}
{
{   Rev 1.7    2003-10-14 11:35:24  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.6    2003-10-08 11:56:52  peter
{ Genomgång kontroll av laddning av objekt.
}
{
{   Rev 1.5    2003-09-16 13:59:08  peter
}
{
{   Rev 1.4    2003-09-16 13:38:10  peter
{ Fixat längd spärr på vissa fält (notering mm)
}
{
{   Rev 1.3    2003-08-28 13:46:26  peter
}
{
{   Rev 1.2    2003-08-26 12:45:58  peter
}
{
{   Rev 1.1    2003-06-10 13:31:40  hasp
}
{
{   Rev 1.0    2003-03-20 14:00:26  peter
}
{
{   Rev 1.0    2003-03-17 14:41:40  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:54  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:24  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
// Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
// Skapad: 1999-01-01 10:59:16                                   //
// Noteringar :                                                   //
// Historia :                                                     //
// Uppföljd 0003 Benny Lauridsen                                  //
////////////////////////////////////////////////////////////////////

unit Kontrakt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ComCtrls, Buttons, ExtCtrls, DB, DBTables,
  Grids, comp2000, ActnList, tmpData, eqprn, divutils, EQFormatEdit,
  EQDateEdit;

type
  TCustomerType = (Customer, Driver, PartPayer);
  EUserError = class(Exception)
  private
    FCompSetFocus: TWinControl;
    procedure SetCompSetFocus(const Value: TWinControl);
  public
    property CompSetFocus: TWinControl read FCompSetFocus write SetCompSetFocus;
    constructor create(const Msg: string; Comp: TWinControl);
  end;

  EUserObjError = class(EUserError)
  public
    FObjNum: Integer;
    constructor create(const Msg: string; Comp: TWinControl; ObjNum: integer);
  end;

  EUserPaymentError = class(EUserError)
  public
    FTabIndexNumber: Integer;
    constructor create(const Msg: string; Comp: TWinControl; TabIndex: integer);
  end;

  ViewForm = (booking, contract, checkin, return, price);
  TFrmKontrakt = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    btnContract: TBitBtn;
    StatusBar1: TStatusBar;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn4: TBitBtn;
    btnReturn: TBitBtn;
    btnCheckIn: TBitBtn;
    btnBook: TBitBtn;
    ScrollBox1: TScrollBox;
    PageControl1: TPageControl;
    tabPayment: TTabSheet;
    GroupBox7: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    CheckDelad: TCheckBox;
    cbBetalning: TComboBox;
    tabNotes: TTabSheet;
    GroupBox6: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    edtKnot1: TEdit;
    edtKnot2: TEdit;
    edtInot1: TEdit;
    edtInot2: TEdit;
    tabCosts: TTabSheet;
    cbCost1: TComboBox;
    edtCost1: TEdit;
    edtCost2: TEdit;
    edtCost3: TEdit;
    edtCost4: TEdit;
    tabCard: TTabSheet;
    GroupBox5: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    checkSparr: TCheckBox;
    edtCardNr: TEdit;
    edtSparrNr: TEdit;
    cbCard: TComboBox;
    tabDelbet: TTabSheet;
    StringGrid1: TStringGrid;
    btnNewDel: TButton;
    btnChangeDel: TButton;
    btnDeleteDel: TButton;
    tabInvoice: TTabSheet;
    Label17: TLabel;
    Label21: TLabel;
    Label18: TLabel;
    Label26: TLabel;
    Label33: TLabel;
    edtAtt: TEdit;
    edtFaktnot1: TEdit;
    edtFaktnot2: TEdit;
    cbFaktKid: TComboBox;
    DriverSGB1: TShrinkGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtFNamn: TEdit;
    edtFAdress1: TEdit;
    edtFAdress2: TEdit;
    edtFpnum: TEdit;
    edtFtel: TEdit;
    CustomerSGB1: TShrinkGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtHNamn: TEdit;
    edtHadress1: TEdit;
    edtHadress2: TEdit;
    edtHpnum: TEdit;
    edtHtel: TEdit;
    objPanel: TPanel;
    Label7: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label15: TLabel;
    Label34: TLabel;
    Label27: TLabel;
    edtObjId: TEdit;
    edtKM_UT: TEdit;
    edtPKlass: TEdit;
    cbObjtyp: TComboBox;
    edtKM_IN: TEdit;
    edtKM_KORT: TEdit;
    edtDragBil: TEdit;
    DTVFrom: TDateTimeViewer;
    DTVTo: TDateTimeViewer;
    DTVOut: TDateTimeViewer;
    DTVReturn: TDateTimeViewer;
    BitBtn1: TBitBtn;
    edtCost5: TEdit;
    edtCost6: TEdit;
    edtCost7: TEdit;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    sgCost: TStringGrid;
    pnlBetvillkor: TPanel;
    SpeedButton1: TSpeedButton;
    ActionList1: TActionList;
    OK: TAction;
    NyttObj: TAction;
    RaderaObj: TAction;
    FetchCont: TAction;
    DelCont: TAction;
    lblPTyp: TLabel;
    cbPristyp: TComboBox;
    edtRef: TEdit;
    BitBtn8: TBitBtn;
    Label10: TLabel;
    edtKM_BER: TEdit;
    Pris: TAction;
    chSRRed: TCheckBox;
    lblDeposit: TLabel;
    edtDeposit: TEdit;
    EdtCardExp: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    RGMoms: TRadioGroup;
    RBEgenMOms: TRadioButton;
    RBTotalMOms: TRadioButton;
    checkDelfakt: TCheckBox;
    tabDelFakt: TTabSheet;
    GroupBox1: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label30: TLabel;
    edDF_StartDatum: TEQDateEdit;
    Label31: TLabel;
    edDF_SlutDatum: TEQDateEdit;
    edDF_BELOPP: TEQFormatEdit;
    edDF_ACKBelopp: TEQFormatEdit;
    edDF_Fakt2Datum: TEdit;
    function GetEnum(Txt: string; Val: Boolean): integer;
    procedure edtHNamnChange(Sender: TObject);
    procedure edtFNamnChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbObjtypChange(Sender: TObject);
    procedure ShowObj(PClass, PType, SRRed, DragBil, KM: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure DTVFromChange(Sender: TObject);
    procedure DTVToChange(Sender: TObject);
    procedure edtObjIdChange(Sender: TObject);
    procedure DTVOutChange(Sender: TObject);
    procedure DTVReturnChange(Sender: TObject);
    procedure CheckDeladClick(Sender: TObject);
    procedure cbBetalningClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure objPanelClick(Sender: TObject);
    procedure cbCost1Click(Sender: TObject);
    procedure edtCost1Change(Sender: TObject);
    procedure edtCost5Change(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtObjIdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtHNamnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFNamnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnContractClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure OKExecute(Sender: TObject);
    procedure NyttObjExecute(Sender: TObject);
    procedure RaderaObjExecute(Sender: TObject);
    procedure FetchContExecute(Sender: TObject);
    procedure DelContExecute(Sender: TObject);
    procedure edtPKlassChange(Sender: TObject);
    procedure edtKM_INChange(Sender: TObject);
    procedure btnNewDelClick(Sender: TObject);
    procedure btnChangeDelClick(Sender: TObject);
    procedure btnDeleteDelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbBetalningKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtObjIdExit(Sender: TObject);
    procedure edtCost4Change(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure edtHpnumExit(Sender: TObject);
    procedure edtHadress2Change(Sender: TObject);
    procedure edtFAdress2Change(Sender: TObject);
    procedure CustomerSGB1Click(Sender: TObject);
    procedure DriverSGB1Click(Sender: TObject);
    procedure cbBetalningExit(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure cbFaktKidClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edtKM_INKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DTVToExit(Sender: TObject);
    procedure RBEgenMOmsClick(Sender: TObject);
    procedure RBTotalMOmsClick(Sender: TObject);
    procedure edtHNamnEnter(Sender: TObject);
    procedure edtHNamnExit(Sender: TObject);
    procedure edtHadress1Exit(Sender: TObject);
    procedure edtHadress1Enter(Sender: TObject);
    procedure edtHpnumEnter(Sender: TObject);
    procedure edtHtelEnter(Sender: TObject);
    procedure edtHtelExit(Sender: TObject);
    procedure edtFpnumEnter(Sender: TObject);
    procedure edtFtelEnter(Sender: TObject);
    procedure edtFtelExit(Sender: TObject);
    procedure edtFNamnExit(Sender: TObject);
    procedure edtFNamnEnter(Sender: TObject);
    procedure edtFAdress1Enter(Sender: TObject);
    procedure edtFAdress1Exit(Sender: TObject);
    procedure edtRefEnter(Sender: TObject);
    procedure edtRefExit(Sender: TObject);
    procedure cbBetalningEnter(Sender: TObject);
    procedure CheckDeladEnter(Sender: TObject);
    procedure CheckDeladExit(Sender: TObject);
    procedure edtDepositEnter(Sender: TObject);
    procedure edtDepositExit(Sender: TObject);
    procedure cbObjtypEnter(Sender: TObject);
    procedure cbObjtypExit(Sender: TObject);
    procedure DTVFromEnter(Sender: TObject);
    procedure DTVFromExit(Sender: TObject);
    procedure DTVToEnter(Sender: TObject);
    procedure edtObjIdEnter(Sender: TObject);
    procedure edtDragBilEnter(Sender: TObject);
    procedure edtDragBilExit(Sender: TObject);
    procedure edtPKlassEnter(Sender: TObject);
    procedure edtPKlassExit(Sender: TObject);
    procedure edtKM_INEnter(Sender: TObject);
    procedure edtKM_INExit(Sender: TObject);
    procedure cbPristypEnter(Sender: TObject);
    procedure cbPristypExit(Sender: TObject);
    procedure edtKM_KORTEnter(Sender: TObject);
    procedure edtKM_KORTExit(Sender: TObject);
    procedure edtKM_BEREnter(Sender: TObject);
    procedure edtKM_BERExit(Sender: TObject);
    procedure chSRRedEnter(Sender: TObject);
    procedure chSRRedExit(Sender: TObject);
    procedure DTVOutEnter(Sender: TObject);
    procedure DTVOutExit(Sender: TObject);
    procedure DTVReturnEnter(Sender: TObject);
    procedure DTVReturnExit(Sender: TObject);
    procedure edtKnot1Enter(Sender: TObject);
    procedure edtKnot1Exit(Sender: TObject);
    procedure edtInot1Exit(Sender: TObject);
    procedure edtInot1Enter(Sender: TObject);
    procedure edtInot2Enter(Sender: TObject);
    procedure edtInot2Exit(Sender: TObject);
    procedure checkDelfaktEnter(Sender: TObject);
    procedure checkDelfaktExit(Sender: TObject);
    procedure checkDelfaktClick(Sender: TObject);
    procedure edDF_StartDatumKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    ObjChanged: boolean;
    objarr: array[1..9] of TSGBObject;
    FaktIndex: Integer;
    invoiceArr: array of TFakturanotering;
    procedure SetObjSummary;
    procedure ClearAll;
    procedure ChangeObject(obj: TSGBObject);
    procedure ReadFromObject(obj: TSGBObject);
    procedure WriteToObject(obj: TSGBObject);
    procedure CreateObj(I: Integer);
    function GetTimeNow: TDateTime;
    procedure LoadCosts;
    procedure cbEnter(sender: TObject);
    procedure objOpen(sender: TObject);
    procedure SearchObject(obtyp: string);
    function GetObjTypNr(objtyp: string): string;
    function GetObjNumber: Integer;
    procedure CreateDel;
    procedure DestroyDel;
    procedure RecountDel;
    procedure UpdateGrid;
    procedure FillDelbetalare(Delbetalare: TDelBetalare);
    procedure SparaDelbetalare(var Delbetalare: TDelBetalare);
    function GetObjRegNo(ObjNum: string): string;
    function GetObjectsType(Reg_No: string): integer;
    procedure EditCustomer(str: string);
    procedure EditDriver(str: string);
    procedure EditObject(str: string);
    function PriceNameInList(name: string): boolean;
    function SaveCustomer(CType: TCustomerType): boolean;
    procedure ClearObject;
    procedure GetPrintRules(PayCode: string; var Copies: integer; var PrintText: string);
    function AskToSaveCustomerInfo: boolean;
    function AskToSaveDriverInfo: boolean;
    procedure UpdateInvoicePayer(SubId: integer; Kid, KNamn, FNamn, Att, Kom1, kom2: string);
    procedure FaktNotClick(Sender: TObject);
    procedure FaktNotToKontr;
    procedure SparaFaktNot;
    procedure VisaFaktNot(inKid: string);
    procedure KontrToFaktNot(ContrId: integer);
    procedure UpdateCbFaktDelId;
    procedure DeleteInvoicePayer(Kid: string);
    procedure UpdateKidFaktNot(KID: integer; Betkod: string);
    procedure ChangeDelbetBaz(delid, Kontridbaz: string);
    function GetSRiskVAT: boolean;
    { Private declarations }
  public
    { Public declarations }
    CurrentView: ViewForm;
    ListNumber: integer;
    ContrID, CustId, DriverId: Integer;
    SRRed, Loading: Boolean;
    procedure GetCdrDef;
    function IsInternKund(CuiD: integer; var Konto, KStalle: integer): boolean;
    procedure LoadCustomer(cuId: string);
    procedure LoadDriver(custId: string);
    procedure LoadObject(OID: string);
    function LoadContract(ContId: integer): boolean;
    procedure AddCostRow;
    procedure UpdateViewType(view: ViewForm);
    function CheckAllCorrect(view: ViewForm): boolean;
    procedure DrvMCount(Regnr: string);
    function SearchDriver(str: string): boolean;
  end;

function MakeInt(str: string): integer;
function MakeFloat(str: string): real;
function MakeCurr(str: string): currency;
function AdjustAndSigns(str: string): string;
function ConcatCustInfo(PNum, Namn, Adress1, Adress2, Tel: string): string;
function SearchCustomer(str: string): boolean;

const
  SQLobj = 'Select type, REG_NO, Priceclass, MODEL, Accesories , Color , KM_N , ([n_service]-[km_n]) AS Service, ObjNum, VStat from objects'; //! Benny Lagt tyill Vstat

var
  FrmKontrakt: TFrmKontrakt;
  BetSattChange, NoActivate, NewCont, StopHere: Boolean;
  DelBetVilkor: Integer;
//!  stdDays:Integer;
  ShowFreeOnly: boolean;
  CustNoteStr : String;
  stdDays : Integer;

implementation

uses
  Main, vclFuncs, Login, Search, GReg, Bgmain, pris, history, Funcs, Delbet, BetVilk,
  Datamodule, DataSession, spin, UtskriftsDialog, Dlg_Hyresman,
  Dlg_ObjService, ADODB;
//!, ServFunc, CARLocServ_TLB

{$R *.DFM}

procedure TFrmKontrakt.ClearAll;
var I: Integer;
  ds : TADOQuery;
begin
  //Generic
  Loading := false;
  //Object
  ContrId := 0;
  DriverId := 0;
  CustId := 0;
  CustomerSGB1.IsOpen := false;
  DriverSGB1.IsOpen := false;
  objPanel.Parent := Scrollbox1;
  for I := 1 to 9 do
    if assigned(objArr[I]) then
    begin
      (objArr[I] as TSGBObject).free;
      objArr[I] := nil;
    end;
  cbObjtyp.clear;
  for I := 0 to length(Objtypes) - 1 do
    cbObjtyp.Items.add(Objtypes[i].ObTyp);
  cbObjTyp.Itemindex := 0;
  edtObjId.Clear;
  edtPKlass.clear;
  // MBH
  GetPriceTypes(PriceLists[0].PClass, cbPristyp.Items, DTVFrom.DatePicker.DateTime, false);
  cbPristyp.Itemindex := 0;
  edtDragbil.clear;
  edtKM_UT.clear;
  edtKM_IN.clear;
  edtKM_KORT.text := '0';
  edtKM_BER.text := '0';
  SRRed := frmMain.DefaultCDR;
  chSRRed.checked := SRRed;
  //Hyresman
  EdtHNamn.clear;
  EdtHAdress1.clear;
  EdtHAdress2.clear;
  EdtHpnum.clear;
  EdtHtel.clear;
  CustomerSGB1.SummaryText := 'Ingen kund vald';
  //Förare
  EdtFNamn.clear;
  EdtFAdress1.clear;
  EdtFAdress2.clear;
  EdtFpnum.clear;
  EdtFtel.clear;
  DriverSGB1.SummaryText := 'Ingen förare vald';
  //Betalnings flik
  PageControl1.ActivePage := tabPayment;
  edtRef.clear;
  cbBetalning.clear;
  for I := 0 to length(PayAlts) - 1 do
    cbBetalning.Items.add(PayAlts[i].Name);
  cbBetalning.Itemindex := GetBetIndex(DefBetSt);
  cbBetalningClick(nil);

  CheckDelad.checked := false;


  ds := CreateDS('SELECT FAKTDAGAR FROM PARAM');
  try
     ds.Open;
     stdDays := ds.FieldByName('FAKTDAGAR').AsInteger;
  except
     stdDays := 21;
  end;
  FreeDS(ds);

  pnlBetVillkor.Caption := inttostr(stdDays);
  pnlBetVillkor.visible := false;
  edtDeposit.text := '0';
  //Noterings flik
  edtKnot1.Clear;
  edtKnot2.Clear;
  edtInot1.Clear;
  edtInot2.Clear;
  //Tilläggskostnader flik
  sgCost.RowCount := 2;
  DeleteRow(sgCost, 1, false);
  sgCost.Cells[0, 0] := 'Kostnad';
  sgCost.Cells[1, 0] := 'Antal';
  sgCost.Cells[2, 0] := 'Pris';
  sgCost.Cells[3, 0] := 'Exkl.';
  sgCost.Cells[4, 0] := 'Inkl.';
  sgCost.Cells[5, 0] := 'Moms';
  sgCost.Cells[6, 0] := 'Konto';
  sgCost.Cells[7, 0] := 'K-ställe';

  cbCost1.Text := '';
  edtCost1.Clear;
  edtCost2.Clear;
  edtCost3.Clear;
  edtCost4.Clear;
  edtCost5.Clear;
  edtCost6.Clear;
  edtCost7.Clear;
  //Kontokorts flik
  cbCard.Clear;
  for I := 0 to length(CCards) - 1 do
    cbCard.Items.add(CCards[i].Name);
  cbCard.Itemindex := 0;
  edtCardNr.clear;
  edtSparrNr.clear;
  checkSparr.checked := false;
  //Deladbetalnings flik
  SetLength(DelLista, 0);
  ContrId := 0;
  //Faktura flik
  cbFaktKId.Text := '';
  edtAtt.clear;
  edtFaktnot1.clear;
  edtFaktnot2.clear;
  // Delfaktureringsflik

  edDF_StartDatum.Clear;
  edDF_SlutDatum.Clear;
  edDF_BELOPP.Text := '0';
  edDF_ACKBelopp.Text := '0';
  edDF_Fakt2Datum.Clear;
  checkDelfakt.Checked := False;
//  tabDelFakt.TabVisible := False;

end;

procedure TFrmKontrakt.UpdateViewType(view: ViewForm);
var i, j: Integer;
  x: string;
begin
  case view of
    booking:
      begin
        caption := 'Bokning';
        btnBook.Visible := true;
        btnContract.Visible := false;
        btnReturn.Visible := false;
        btnCheckin.Visible := false;
        pageControl1.visible := false or frmMain.PaymentOnBooking;
        //!pageControl1.visible := True;//Benny Ändrat
        DTVOut.Visible := false;
        DTVReturn.Visible := false;
        frmmain.SpeedButton1.Flat := True; //! För att se om det är Bokning öppen
      end;
    contract:
      begin
        caption := 'Kontrakt';
        btnBook.Visible := false;
        btnContract.Visible := true;
        btnReturn.Visible := false;
        btnCheckin.Visible := false;
        pageControl1.visible := true;
        DTVOut.Visible := false;
        DTVReturn.Visible := false;
        frmmain.SpeedButton2.Flat := True; //! För att se om det är Kontrakt öppen
      end;
    return:
      begin
        caption := 'Återlämning';
        btnBook.Visible := false;
        btnContract.Visible := false;
        btnReturn.Visible := true;
        btnCheckin.Visible := true;
        pageControl1.visible := true;
        DTVOut.Visible := true;
        DTVReturn.Visible := true;
        frmmain.SpeedButton3.Flat := True; //! För att se om det är Återlämning öppen
      end;
  end;
  CurrentView := view;
end;

function AdjustAndSigns(str: string): string;
var I: Integer;
begin
  try
    result := '';
    for I := 1 to length(str) do
    begin
      if (str[i] = '&') and (str[i + 1] <> '&') and (str[i - 1] <> '&') then
        result := result + Str[i] + '&'
      else
        result := result + Str[i];
    end;
  except
    result := str;
  end;
end;

function ConcatCustInfo(PNum, Namn, Adress1, Adress2, Tel: string): string;
begin
  result := '';
  if PNum > '' then
    result := result + PNum;
  if Namn > '' then
  begin
    if result > '' then
      result := result + ', ';
    result := result + Namn;
  end;
  if Adress1 > '' then
  begin
    if result > '' then
      result := result + ', ';
    result := result + Adress1;
  end;
  if Adress2 > '' then
  begin
    if result > '' then
      result := result + ', ';
    result := result + Adress2;
  end;
  if tel > '' then
  begin
    if result > '' then
      result := result + ', ';
    result := result + tel;
  end;
  result := AdjustAndSigns(result);
end;

procedure TFrmKontrakt.edtHNamnChange(Sender: TObject);
begin
  CustomerSGB1.Summarytext := edtHpnum.text;
  CustomerSGB1.Summarytext := ConcatCustInfo(edtHpnum.text, edtHNamn.text, edtHAdress1.text, edtHAdress2.text, edtHTel.text);
  if sender = edtHPnum then
    if edtHPnum.text < '!' then
    begin
      CustId := 0;
      edtHNamn.text := '';
      edtHAdress1.text := '';
      edtHAdress2.text := '';
      edtHTel.text := '';
    end;
end;

procedure TFrmKontrakt.edtFNamnChange(Sender: TObject);
begin
  DriverSGB1.Summarytext := edtFpnum.text;
  DriverSGB1.Summarytext := ConcatCustInfo(edtFpnum.text, edtFNamn.text, edtFAdress1.text, edtFAdress2.text, edtFTel.text);
  if sender = edtFPnum then
    if edtFPnum.text < '!' then
    begin
      DriverId := 0;
      edtFNamn.text := '';
      edtFAdress1.text := '';
      edtFAdress2.text := '';
      edtFTel.text := '';
    end;
end;

procedure TFrmKontrakt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
  frmMain.frmKontraktLista[ListNumber] := nil;
  case listnumber of
    1: frmmain.SpeedButton1.Flat := False;
    2: frmmain.SpeedButton2.Flat := False;
    3: frmmain.SpeedButton3.Flat := False;
  end;
end;

procedure TFrmKontrakt.SetObjSummary;
begin
  if objPanel.parent is TSGBObject then
  begin
    (objPanel.parent as TSGBObject).Summarytext := cbObjtyp.text + '   ' + EdtObjId.Text
      + {#13 +} '  Från: ' + FormatDateTime('yyyy-mm-dd hh:nn', DTVFrom.DateTime)
      + ', Till: ' + FormatDateTime('yyyy-mm-dd hh:nn', DTVTo.DateTime)
      + ', Pris: ' + edtPKlass.Text + ' ' + cbPristyp.Text;
    if chSRRed.Checked then
      (objPanel.parent as TSGBObject).Summarytext :=
        (objPanel.parent as TSGBObject).Summarytext + ', CDR ';
    case CurrentView of
      Return:
        (objPanel.parent as TSGBObject).Summarytext :=
          (objPanel.parent as TSGBObject).Summarytext
          + ', Kört: ' + edtKM_KORT.Text;
    end;
  end;
end;

procedure TFrmKontrakt.cbObjtypChange(Sender: TObject);
var
//  I : Integer;
  dep: currency;
begin
  with Objtypes[cbObjTyp.ItemIndex] do
    ShowObj(ShowPClass, ShowPType, ShowPType, ShowDragbil, ShowKM);
  if not Loading then
  begin

//!Benny tagit bort för att inte skriva över obj prisklass
//!    edtPKlass.text := Objtypes[cbObjTyp.ItemIndex].ObId;

//    dep := 0;
//    For I := 1 to 9 do
//      if assigned(objArr[I]) then
//        dep := dep + Objtypes[objArr[I].FcbObjId].DefDep;
    if CurrentView = return then
      dep := 0
    else
      dep := Objtypes[cbObjTyp.Itemindex].DefDep;
    edtDeposit.text := FormatFloat('0', dep);
  end;

  SetObjSummary;
end;

procedure TFrmKontrakt.ShowObj(PClass, PType, SRRed, DragBil, KM: Boolean);
begin
  //PrisKlass
  EdtPKlass.visible := PClass;
  Label25.visible := PClass;
  //PrisTyp
  cbPrisTyp.visible := PType;
  lblPTyp.visible := PType;
  //Självrisk
  chSrred.visible := Srred;
  //Dragbil
  EdtDragbil.visible := DragBil;
  Label27.visible := DragBil;
  //KM UT
  EdtKM_UT.visible := KM;
  Label24.visible := KM;
  //Km in
  edtKM_IN.visible := KM and (CurrentView = return);
  Label15.visible := KM and (CurrentView = return);
  //KM Kört
  Label34.visible := KM and (CurrentView = return);
  edtKM_KORT.visible := KM and (CurrentView = return);
  //KM Beräknat
  Label10.visible := KM and not Label34.visible;
  edtKM_BER.visible := KM and not edtKM_KORT.visible;
  //Utlämnad
  DTVOut.visible := (CurrentView = return);
  //Återlämnad
  DTVReturn.visible := (CurrentView = return);
end;

procedure TFrmKontrakt.FormActivate(Sender: TObject);
begin
//  cbObjTyp.SetFocus;
//!dmod.Q1.Active :=False;
//!dmod.q1.SQL.Clear ;
//!dmod.q1.sql.Text :='Select Faktdagar from param';
//!dmod.q1.Active :=True;

//!while not dmod.q1.Eof do
//!begin
//! stddays :=dmod.q1.fieldbyname('Faktdagar').AsInteger;
//! dmod.q1.next;
//!end;
//! dmod.q1.Active :=False;
//! dmod.q1.SQL.Clear;
end;

procedure TFrmKontrakt.LoadCosts;
var I: Integer;
begin
  cbCost1.clear;
  for I := 0 to length(costs) - 1 do
    cbCost1.items.add(Costs[I].FName);
end;

procedure TFrmKontrakt.DTVFromChange(Sender: TObject);
begin
  if DTVFrom.Datetime > DTVTo.DateTime then
    DTVTo.Datetime := DTVFrom.DateTime;
  DTVOut.Datetime := DTVFrom.DateTime;
  SetObjSummary;
  // MBH
  if edtPKlass.text = '' then
    GetPriceTypes(PriceLists[0].PClass, cbPristyp.Items, DTVFrom.DatePicker.DateTime, true)
  else
    GetPriceTypes(edtPKlass.text, cbPristyp.Items, DTVFrom.DatePicker.DateTime, true);
  cbPristyp.ItemIndex := 0;
//!  ClearObject;
end;

procedure TFrmKontrakt.DTVToChange(Sender: TObject);
begin
//!  if DTVFrom.Datetime > DTVTo.DateTime then
//!    DTVFrom.Datetime := DTVTo.DateTime;
  DTVReturn.Datetime := DTVTo.DateTime;
  SetObjSummary;
  edtObjId.Font.color := clRed;
end;

procedure TFrmKontrakt.edtObjIdChange(Sender: TObject);
begin
  ObjChanged := true;
  edtObjId.Font.color := clRed;
  edtKM_IN.text := '0';
  SetObjSummary;

end;

procedure TFrmKontrakt.DTVOutChange(Sender: TObject);
begin
  if DTVOut.Datetime > DTVReturn.DateTime then
    DTVReturn.Datetime := DTVOut.DateTime;
  SetObjSummary;
end;

procedure TFrmKontrakt.DTVReturnChange(Sender: TObject);
begin
  if DTVOut.Datetime > DTVReturn.DateTime then
    DTVOut.Datetime := DTVReturn.DateTime;
  SetObjSummary;
end;

procedure TFrmKontrakt.CheckDeladClick(Sender: TObject);
begin
//  tabDelbet.TabVisible := checkDelad.Checked;
  if checkDelad.Checked then
  begin
    CreateDel;
    case MomsCountConst of
      1: rbtotalmoms.Checked := True;
      2: rbEgenmoms.checked := True;
    end;
  end
  else
    DestroyDel;

end;

procedure TFrmKontrakt.cbBetalningClick(Sender: TObject);
begin
  tabCard.TabVisible := cbBetalning.Itemindex = 1;
  pnlBetVillkor.Visible := (cbBetalning.Itemindex = 2) or (cbBetalning.Itemindex = 3);
  edtDeposit.Visible := (PayAlts[cbBetalning.Itemindex].Code = 'K') or (PayAlts[cbBetalning.Itemindex].Code = 'O');
  lblDeposit.visible := edtDeposit.Visible;
  UpdateKidFaktNot(CustID, PayAlts[cbBetalning.Itemindex].Code);
end;

procedure TFrmKontrakt.PageControl1Change(Sender: TObject);
begin
  PageControl1.SetFocus;
  if PageControl1.ActivePage = tabCosts then
    cbCost1.SetFocus;
end;

procedure TFrmKontrakt.BitBtn3Click(Sender: TObject);
begin
  close;
end;

procedure TFrmKontrakt.FormCreate(Sender: TObject);
begin
  internkund := False;
  screen.cursor := crHourglass;
  ClearAll;
  CreateObj(1);
  cbObjtyp.Itemindex := 0;
  cbObjtypChange(nil);
  LoadCosts;
    //! 2 rader för språk
  frmmain.CheckLanguage;
  if frmmain.language > '!' then
    frmmain.UpdateLang(Self, frmmain.Language);
  screen.cursor := crDefault;
end;

procedure TFrmKontrakt.ChangeObject(obj: TSGBObject);
begin
  if (objPanel.parent is TSGBObject) then
  begin
    objPanel.visible := false;
    WriteToObject(objPanel.parent as TSGBObject);
  end;


  try
    objPanel.parent := obj;
  except
  end;

{ Ja jag vet att detta är knäppt. Men det löser ett problem med stora
  teckensnitt. Visst är det roligt att programmera.}

  try
    objPanel.parent := obj;
  except
  end;

  objPanel.top := 38;
  objPanel.left := 5;
//  objPanel.align := albottom;
  objPanel.visible := true;

  if obj.IsOpen then
  begin
    ReadFromObject(obj);

    try
      if assigned(frmKontrakt) then
        cbObjTyp.SetFocus;
    except
    end;
  end;
end;

function TFrmKontrakt.GetTimeNow: TDateTime;
var
  h, m, s, ms: word;
  d: TDateTime;
begin
  DecodeTime(time, h, m, s, ms);
  if m < 30 then
  begin
    m := 30;
    d := date + encodeTime(h, m, 0, 0)
  end
  else
  begin
    m := 0;
    d := date + encodeTime(h, m, 0, 0);
    d := d + 1 / 24;
  end;
  result := d;
end;

function TFrmKontrakt.GetObjNumber: Integer;
var
  I: Integer;
begin
  I := 1;
  while assigned(objArr[i]) and (I <= 9) do
    inc(I);
  result := I;
end;

procedure TFrmKontrakt.CreateObj(I: Integer);
var
  obj: TSGBObject;
begin
  obj := TSGBObject.create(self);
  objArr[i] := obj;
  try
    ChangeObject(obj);
  except
  end;
  obj.tag := I;
  obj.MaxHeight := 175;
  obj.MinHeight := 38;
  obj.OnOpen := objOpen;
  obj.caption := 'Hyresobjekt &' + inttostr(I);
  obj.parent := Scrollbox1;
  obj.align := alTop;
  obj.Top := 0;
  obj.TabOrder := 0;
  obj.TabStop := true;
//  obj.Open;
  obj.Close;
  obj.FDTVFrom := GetTimeNow;
  obj.FDTVTo := obj.FDTVFrom;
  obj.FDTVOut := obj.FDTVFrom;
  obj.FDTVReturn := obj.FDTVFrom;
  with TCheckBox.Create(obj) do
  begin
    parent := obj;
    taborder := 0;
    Top := -50;
    OnEnter := cbEnter;
  end;
  ReadFromObject(obj);
  SetObjSummary;
end;

procedure TFrmKontrakt.cbEnter(sender: TObject);
begin
  if ((Sender as TCheckbox).parent as TSGBObject).IsOpen then
    ActiveControl := FindNextControl(ActiveControl, false, true, false);
end;

procedure TFrmKontrakt.objOpen(sender: TObject);
begin
  if sender is TSGBObject then
    if (sender <> objPanel.Parent) then
      ChangeObject(sender as TSGBObject);
  try
    if cbObjTyp.visible and cbObjTyp.enabled then
      cbObjTyp.SetFocus;
    //!
  except

  end;
end;

procedure TFrmKontrakt.ReadFromObject(obj: TSGBObject);
begin
  cbObjTyp.ItemIndex := obj.FcbObjId;
  cbObjtypChange(nil);
  DTVFrom.DateTime := obj.FDTVFrom;
  DTVTO.DateTime := obj.FDTVTO;
  DTVOut.DateTime := obj.FDTVOut;
  DTVReturn.DateTime := obj.FDTVReturn;
  edtObjId.text := obj.FedtObjId;
  edtPKlass.text := obj.FedtPKlass;
  cbPrisTyp.text := GetPriceName(obj.FedtPKlass, obj.FcbPType);
  chSRRed.checked := obj.FchSRRed;
  edtDragbil.text := obj.FedtDragbil;
  edtKM_UT.text := obj.FedtKM_UT;
  edtKM_IN.text := obj.FedtKM_IN;
  edtKM_KORT.text := obj.FedtKM_KORT;
  if CurrentView in [booking, contract] then
    edtKM_BER.text := obj.FedtKM_KORT;
  ObjChanged := false;
  edtObjId.Font.color := clBlack;
end;

procedure TFrmKontrakt.WriteToObject(obj: TSGBObject);
begin
  obj.FcbObjId := cbObjTyp.ItemIndex;
  obj.FDTVFrom := DTVFrom.DateTime;
  obj.FDTVTO := DTVTO.DateTime;
  obj.FDTVOut := DTVOut.DateTime;
  obj.FDTVReturn := DTVReturn.DateTime;
  obj.FedtObjId := edtObjId.text;
  obj.FedtPKlass := edtPKlass.text;
  obj.FcbPType := GetPriceType(obj.FedtPKlass, cbPrisTyp.text);
  obj.FchSRRed := chSRRed.checked;
  obj.FedtDragbil := edtDragbil.text;
  obj.FedtKM_UT := edtKM_UT.text;
  obj.FedtKM_IN := edtKM_IN.text;
  obj.FedtKM_BER := edtKM_BER.text;
  if CurrentView in [booking, contract] then
    obj.FedtKM_KORT := edtKM_BER.text
  else
    obj.FedtKM_KORT := edtKM_KORT.text;
end;

procedure TFrmKontrakt.objPanelClick(Sender: TObject);
begin
  if assigned(objPanel.parent) and (objPanel.parent is TSGBObject) then
    (objPanel.parent as TSGBObject).Click;
end;

procedure TFrmKontrakt.cbCost1Click(Sender: TObject);
begin
  if cbCost1.itemindex >= 0 then
  begin
    edtCost1.text := inttostr(costs[cbCost1.itemindex].FNumb);
    edtCost2.text := formatFloat('0.00', costs[cbCost1.itemindex].FPrice);
    edtCost5.text := formatFloat('0.#', costs[cbCost1.itemindex].FMoms * 100);
    edtCost6.text := costs[cbCost1.itemindex].FKonto;
    edtCost7.text := costs[cbCost1.itemindex].FKStalle;
  end;
end;

procedure TFrmKontrakt.edtCost1Change(Sender: TObject);
begin
  try
    if ActiveControl <> edtCost3 then
      if (edtCost1.text > '') and (edtCost2.text > '') then
//!        edtCost3.Text := formatfloat('0.00',strtoint(edtCost1.Text) * strtofloat(edtCost2.Text));
        edtCost3.Text := formatfloat('0.00', strtoFloat(edtCost1.Text) * strtofloat(edtCost2.Text));
  except
    edtCost3.Text := '';
  end;
end;

procedure TFrmKontrakt.edtCost5Change(Sender: TObject);
begin
  try
    if ActiveControl <> edtCost4 then
      if (edtCost3.text > '') and (edtCost5.text > '') then
        edtCost4.Text := formatfloat('0.00', strtofloat(edtCost3.Text) * (strtofloat(edtCost5.Text) / 100 + 1));
    if ActiveControl = edtCost3 then
      if edtCost2.text <> formatfloat('0.00', strtofloat(edtCost3.Text) / (strtofloat(edtCost1.Text))) then
        edtCost2.text := formatfloat('0.00', strtofloat(edtCost3.Text) / (strtofloat(edtCost1.Text)));
  except
    edtCost4.Text := '';
  end;
end;

procedure TFrmKontrakt.BitBtn5Click(Sender: TObject);
begin
  if SGCost.Cells[0, SGCost.Selection.Top] > '' then
    if SGCost.Rowcount > 2 then
      DeleteRow(SGCost, SGCost.Selection.Top, true)
    else
      DeleteRow(SGCost, SGCost.Selection.Top, false)
end;

procedure TFrmKontrakt.AddCostRow;
var
  I, row: integer;
begin
  row := -1;
  //See if post exists
  for I := 0 to SGCost.RowCount - 1 do
    if sgCost.cells[0, I] = cbCost1.Text then
      row := I;

  if row < 0 then
  begin
    //if row doesn't exist add row or get last row
    if (sgCost.RowCount > 2) or (SGCost.Cells[0, 1] > '') then
      sgCost.RowCount := sgCost.RowCount + 1;
    row := sgCost.RowCount - 1;
  end;

  sgCost.cells[0, row] := cbCost1.Text;
  sgCost.cells[1, row] := edtCost1.Text;
  sgCost.cells[2, row] := edtCost2.Text;
  sgCost.cells[3, row] := edtCost3.Text;
  sgCost.cells[4, row] := edtCost4.Text;
  sgCost.cells[5, row] := edtCost5.Text;
  sgCost.cells[6, row] := edtCost6.Text;
  sgCost.cells[7, row] := edtCost7.Text;
end;

procedure TFrmKontrakt.BitBtn2Click(Sender: TObject);
begin
//! För att lägga in Kostnader för Kontering
  if not frmgreg.CostsT.Locate('costname', cbcost1.Text, [locaseinsensitive]) then
  begin
    frmgreg.CostsT.Insert;
    frmgreg.costsT.FieldByName('Costname').asstring := cbcost1.Text;
    frmgreg.costsT.FieldByName('No').AsInteger := 1;
    frmgreg.costsT.FieldByName('Price').asstring := edtcost2.Text;
    frmgreg.costsT.FieldByName('Vat').asstring := edtCost5.Text;
    frmgreg.costsT.FieldByName('Acc_Code').asstring := edtcost6.Text;
    frmgreg.costsT.FieldByName('Acc_Center').asstring := edtcost7.Text;
    frmgreg.costsT.FieldByName('InternKontoNr').asstring := edtcost6.Text;
    frmgreg.costsT.FieldByName('KoncernKontoNr').asstring := edtcost6.Text;
    frmgreg.CostsT.Post;
  end;
//!Hit
  AddCostRow;
  cbCost1.Setfocus;
end;

procedure TFrmKontrakt.SpeedButton1Click(Sender: TObject);
var
  days: integer;
begin
  days := ShowDlgBetVillkor(strtoint(pnlBetVillkor.Caption));
  if days > 0 then
  begin
    pnlBetVillkor.Caption := IntToStr(days);
  end;
end;

procedure TFrmKontrakt.edtObjIdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if KEY = VK_F5 then
  begin
    ShowFreeOnly := not (ssAlt in Shift);
    SearchObject(cbObjTyp.text);
  end;

  if key = VK_F8 then
  begin
    edtObjId.text := GetObjRegNo(edtObjId.text);
    EditObject((Sender as TEdit).text);
  end;

  if KEY = VK_RETURN then
  begin
    edtObjId.text := GetObjRegNo(edtObjId.text);
    if ObjChanged then
    begin
      LoadObject(edtObjId.Text);
      cbObjtypChange(nil);
    end;
  end;
end;

function TFrmKontrakt.GetObjTypNr(objtyp: string): string;
begin
  result := '!';
  frmSearch.GSQLString := 'Select ObjType.Id, ObjType.Type from Objtype Where ObjType.Type = ''' + objtyp + '''';
  if frmSearch.GetSearchResult then
    result := frmSearch.GSearchCDS.fieldbyname('ID').AsString;

end;

procedure TFrmKontrakt.SearchObject(obtyp: string);
var
  Obnr: string;
  ObjStr: string;
  PB_FIX: Boolean;
begin
  ObNr := GetObjTypNr(obtyp);
  frmSearch.SSQLString := SQLObj;
  if edtObjId.text > '' then
    if edtObjId.text[1] > '9' then
      objStr := '(REG_NO >= ''' + edtObjId.text + '*'')'
    else
      objStr := '(ObjNum >= ''' + edtObjId.text + '*'')';
  if not (obNR = '!') then
  begin
    frmSearch.SSQLString := frmSearch.SSQLString + ' WHERE (TYPE = ''' + obnr + ''')' + 'AND (VStat <= 2)'; //! Benny Lagt till ALlt efter plus
    if edtObjId.text > '' then
      frmSearch.SSQLString := frmSearch.SSQLString + ' AND ' + objStr;
  end
  else
    if edtObjId.text > '' then
      frmSearch.SSQLString := frmSearch.SSQLString + ' WHERE ' + objstr;

  if ShowFreeOnly and not (obNR = '!') then
  begin
    frmSearch.GSQLString := frmSearch.SSQLString;

    if frmSearch.GetSearchResult then
    begin
      frmSearch.GSearchCDS.First;
      while not frmSearch.GSearchCDS.EOF do
      begin

//!          LocalServer.CheckObjFree(frmSearch.GSearchCDS.Fieldbyname('REG_NO').AsString,DTVFrom.DateTime,DTVTo.DateTime,ContrID,true);
        PB_FIX := FrmSearch.CheckObjFree(frmSearch.GSearchCDS.Fieldbyname('REG_NO').AsString, DTVFrom.DateTime, DTVTo.DateTime, ContrID, true); //!Benny lagt till

        frmSearch.GSearchCDS.Next;
      end;
      frmSearch.SSQLString := frmSearch.SSQLString + ' AND (STATUS = 0) ';
    end;

  end;

  frmSearch.SSQLString := frmSearch.SSQLString + ' ORDER BY objects.TYPE,  objects.MODEL, objects.REG_NO';
  frmSearch.caption := 'Sökresultat objekt';


  if frmSearch.ShowSearchResult then
  begin
    LoadObject(frmSearch.SSearchCDS.fieldbyname('REG_NO').AsString);
    cbObjtypChange(nil);
  end;

end;

procedure TFrmKontrakt.LoadObject(OID: string);
var
  I: Integer;
  tmpstr1, tmpstr2, tmpstr3: string;
begin
  frmSearch.GSQLString := 'Select Objects.Reg_no, Objects.PriceClass, Objects.KM_N, Objects.TYPE from Objects Where REG_NO = ''' + OID + '''';

  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      tmpstr1 := trim(fieldbyname('Reg_no').AsString);
      tmpstr2 := fieldbyname('PriceClass').AsString;
      tmpstr3 := fieldbyname('KM_N').AsString;
      frmSearch.GSQLString := 'Select * from ObjType Where ID = ''' + fieldbyname('TYPE').AsString + '''';

      if frmSearch.GetSearchResult then
        for I := 0 to cbObjtyp.items.count - 1 do
          if cbObjtyp.items[I] = fieldbyname('TYPE').AsString then
          begin
            cbObjtyp.ItemIndex := I;
            cbObjtypChange(nil);
          end;

      edtObjId.text := tmpstr1;
      edtPKlass.text := tmpstr2;
      if btnBook.Visible then
        edtKM_UT.text := '0'
      else
        edtKM_UT.text := tmpstr3;
      //!GetCdrDef;//!Benny lagt till för hämtning av Cdr Deafault
      chSRRed.checked := SRRed;
      ObjChanged := false;

        //! för att få upp att bilen skall på Service
      if Km_Kontr = true then
      begin
        frmgreg.ObjectsT.Locate('Reg_No', edtObjId.text, [LoCaseInsensitive]);
        if edtKm_Ut.Text > '!' then
        begin
          if strtoint(edtKM_ut.Text) > (frmgreg.ObjectsT.FieldByName('N_Service').asinteger - 500) then
          begin
            if (frmgreg.ObjectsT.FieldByName('N_Service').asinteger - strtoint(edtKM_ut.Text)) < 0 then
              FrmDg_ObjService.Label1.Font.Color := ClRed
            else
              FrmDg_ObjService.Label1.Font.Color := ClBlack;
            FrmDg_ObjService.Label1.Caption := 'Det är nu ' + inttostr(frmgreg.ObjectsT.FieldByName('N_Service').asinteger - strtoint(edtKM_ut.Text)) + ' km till nästa service';
            FrmDg_ObjService.ShowModal;
          end;
        end;
      end;

    end;

end;

procedure TFrmKontrakt.ClearObject;
begin
  edtObjId.Font.color := clRed;
//  edtPKlass.text := '';
  edtKM_UT.text := '';
end;

procedure TFrmKontrakt.LoadCustomer(cuId: string);
var
  ptyp, payment, KTyp, KNr, Kortexp: string;
  pterms, i: integer;
  Utl : Boolean;
begin
  CustNoteStr:='';
//frmSearch.GSQLString := 'Select Customer.name, Customer.Adress, Customer.Postal_name, Customer.Tel_nr_1, Customer.Org_no, Customer.KTyp, Customer.KontoNr, Customer.PTyp, Customer.Payment, Customer.Terms_pay,'+
//                        ' Customer.KExp, Customer.Driver,[Customer.not] as Note from Customer Where Cust_id = ' + cuid;
  frmSearch.GSQLString := 'Select * from Customer Where Cust_id = ' + cuid;
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      if fieldbyname('Driver').asboolean = True then
      begin
        showmessage('Endast Förare');
        EdtHpNum.clear;
        EdtHpNum.SetFocus;
      end
      else
      begin
        CustNoteStr := fieldbyname('not').AsString;
        CustID := strtoint(Cuid);
        edtHNamn.text := fieldbyname('name').AsString;
        edtHAdress1.text := fieldbyname('Adress').AsString;
        edtHAdress2.text := fieldbyname('Postal_name').AsString;
        edtHTel.text := fieldbyname('Tel_nr_1').AsString;
        edtHPnum.text := fieldbyname('Org_no').AsString;
        ptyp := FieldbyName('PTyp').AsString;
        payment := FieldbyName('Payment').AsString;
        pterms := FieldbyName('Terms_pay').AsInteger;
        KTyp := FieldbyName('KTyp').AsString;
        KNr := FieldbyName('KontoNr').AsString;
        kortexp := Fieldbyname('KExp').asstring;
        Utl := Fieldbyname('utlandsk').AsBoolean;
        if utl then edtHpnum.Tag:=1 else edtHpnum.Tag:=0;
        if PayAlts[cbBetalning.Itemindex].Code = 'O' then
          edtCardNr.Text := Knr;
        if not Loading then
        begin
          if ptyp > '' then
          begin
            i := cbPristyp.Items.IndexOf(GetPriceName(edtPklass.text, ptyp));
            if i > -1 then
            begin
              cbPristyp.ItemIndex := i;
              SetObjSummary;
            end
            else
            begin
              ShowMessage('INFO! Kunden har en egen pristyp denna finns ej på detta objekt');
            end;
//            cbPrisTyp.text := GetPriceName(edtPklass.text, ptyp);
          end;
          if payment > '' then
          begin
            cbBetalning.itemindex := GetBetIndex(payment);
            cbCard.itemindex := GetCCIndex(KTyp, '');
            edtCardNr.text := KNr;
            edtcardExp.Text := Kortexp;
            cbBetalningClick(nil);
            if payment='F' then
            begin
              if utl then
              begin
                ShowMessage('INFO! Fakturakund kan inte vara markerad som utländsk!');
              end
              else
              begin
                if Not PNummerOK(edtHpnum.Text) then
                  ShowMessage('INFO! Kundens Pers/Org nr är inte korrekt för att vara fakturakund!');
              end;
            end;

          end;
          if pterms > 0 then
            pnlBetVillkor.Caption := inttostr(pterms);
        end;
      end;
//! för att hämta upp KreditKortsNummer
      if pagecontrol1.Pages[4].Showing then
        EdtCardNr.Text := Knr;
//!hit
    end;
end;

procedure TFrmKontrakt.LoadDriver(custId: string);
begin
  CustNoteStr:='';
//  frmSearch.GSQLString := 'Select Customer.name, Customer.Adress, Customer.Postal_name, Customer.Tel_nr_1, Customer.Org_no, [Customer.not] as Note from Customer Where Cust_id = ' + custid;
  frmSearch.GSQLString := 'Select * from Customer Where Cust_id = ' + custid;
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      CustNoteStr := fieldbyname('not').AsString;
      DriverID := strtoint(Custid);
      edtFNamn.text := fieldbyname('name').AsString;
      edtFAdress1.text := fieldbyname('Adress').AsString;
      edtFAdress2.text := fieldbyname('Postal_name').AsString;
      edtFTel.text := fieldbyname('Tel_nr_1').AsString;
      edtFPnum.text := fieldbyname('Org_no').AsString;
    end;
end;

function TFrmKontrakt.LoadContract(ContId: integer): boolean;
var
  I, sub, status, tmpInt: Integer;
  NewObjects: array of string;
  tmpBetIndex: integer;
  tmpBetVilkor: string;
  BilNr: string;
  ds: tAdoQuery;
begin
  result := false;
  Scrollbox1.visible := false;
  ClearAll;
  frmSearch.GSQLString := 'Select * from [Contr_Base] Where Contrid = ' + inttostr(ContId);
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      if not EOF then
      begin
        ContrId := ContId;
        status := fieldbyname('Status').AsInteger;
        CustID := fieldbyname('CustId').AsInteger;
        edtRef.text := fieldbyname('Referens').AsString;
        tmpBetIndex := GetBetIndex(fieldbyname('Payment').AsString);
        tmpBetVilkor := fieldbyname('Pay-fact').AsString;

        checkDelfakt.Checked := fieldbyname('DF').AsInteger = 1;
        edDF_StartDatum.Text := fieldbyname('DF_STARTDATUM').AsString;
        edDF_SlutDatum.Text := fieldbyname('DF_SLUTDATUM').AsString;
        edDF_BELOPP.Text := fieldbyname('DF_BELOPP').AsString;
        edDF_ACKBelopp.Text := fieldbyname('DF_ACKBELOPP').AsString;
        edDF_Fakt2Datum.Text := fieldbyname('DF_FAKT2DATUM').AsString;

//!        if CustId > 0 then
//!          LoadCustomer(inttostr(CustId));
//!010214        cbBetalning.itemindex := tmpBetIndex;
//!010214        pnlBetVillkor.caption := tmpBetVilkor;
//!010214        cbBetalningClick(nil);
        result := true;
//!BEnny Flyttat 2 rader
        if CustId > 0 then
        begin
          ds := CreateDS('SELECT PCLASS FROM CONTR_OBJT WHERE CONTRID='+IntToStr(ContrId));
          try
            ds.Open;
            edtPKLASS.Text := ds.fieldbyname('PClass').AsString;
            ds.Close;
          except
          end;
          FreeDS(ds);
          LoadCustomer(inttostr(CustId));
        end;
//!Hit uppifrån
//!010214
        cbBetalning.itemindex := tmpBetIndex;
        pnlBetVillkor.caption := tmpBetVilkor;
        cbBetalningClick(nil);
//!0214
      end;
    end;
  if result then
  begin
    frmSearch.GSQLString := 'Select * from [Contr_ObjT] Where Contrid = ' + inttostr(ContrId);
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
      begin
        first;
        setlength(NewObjects, 0);
        while not EOF do
        begin
          setlength(NewObjects, length(NewObjects) + 1);

          I := GetObjNumber;
          if I < 10 then
          begin
            CreateObj(I);
            objPanel.parent := ObjArr[i];
            cbObjTyp.ItemIndex := 0;

            cbObjTyp.ItemIndex := GetObjTypIndex(fieldbyname('ObTypId').AsString, cbObjTyp.items);
            edtObjId.Text := fieldbyname('OID').AsString;
//!Benny
            BilNr := fieldbyname('OID').AsString;
//!Hit
            DTVFrom.DateTime := fieldbyname('Frm_time').AsDateTime;
            DTVTo.DateTime := fieldbyname('To_time').AsDateTime;
            DTVOut.DateTime := fieldbyname('Out_time').AsDateTime;
            DTVReturn.DateTime := fieldbyname('Ret_time').AsDateTime;
            edtKM_ut.Text := fieldbyname('KM_Out').AsString;
            edtKM_In.Text := fieldbyname('KM_In').AsString;
            if currentview in [Booking, Contract] then
            begin
              edtKM_BER.text := fieldbyname('KM_Ber').AsString; //!lagt till ;
              if ((edtKM_ut.Text = '0') or (edtKM_ut.Text = '')) and (CurrentView <> Booking) then
              begin
                ds := CreateDS('Select Objects.KM_N from Objects Where REG_NO = ''' + edtObjId.Text + '''');
                try
                  ds.Active := True;
                  edtKM_UT.text := ds.fieldbyname('KM_N').AsString;
                  ds.Active := False;
                except
                end;
                FreeDS(ds);
              end;
              if fieldbyname('KM_In').AsString > '0' then
                edtKM_INChange(nil)
              else
                edtKM_KORT.text := fieldbyname('KM_Ber').AsString;
            end; //! benny
            edtPKLASS.Text := fieldbyname('PClass').AsString;
// pb           cbPrisTyp.Text := GetPriceName(edtPKLASS.Text, fieldbyname('PType').AsString);
            tmpInt := cbPristyp.Items.IndexOf(GetPriceName(edtPKLASS.Text, fieldbyname('PType').AsString));
            if TmpInt >= 0 then cbPristyp.ItemIndex := tmpInt;
// pb  snabb fix.

            chSRRed.checked := fieldbyname('SRRed').AsBoolean;
            edtDragBil.Text := fieldbyname('CarryCar').AsString;
            WriteToObject(ObjArr[i]);
            cbObjtypChange(nil);
            ObjChanged := false;
          end;
          next;
        end;
      end;
//!    frmSearch.GSQLString := 'Select * from [Contr_Comp] Where Contrid = '+ inttostr(ContrId);
    frmSearch.GSQLString := 'SELECT Contr_Base.ContrId, Contr_Base.DriveId, Contr_Base.SRiskreduc, Contr_Base.SR_Dygnspremie, Contr_Base.Deposit, Contr_Base.Dep_Amount FROM Contr_Base Where Contrid = ' + inttostr(ContrId);
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
      begin
        if not EOF then
        begin
          DriverID := fieldbyname('DriveId').AsInteger;
          SRRed := fieldbyname('SRiskreduc').AsBoolean;
          edtDeposit.text := FormatFloat('0', fieldbyname('Dep_amount').AsInteger);
          if DriverID > 0 then
            LoadDriver(inttostr(DriverId));
        end;
      end;

    frmSearch.GSQLString := 'Select * from [Contr_Not] Where Contrid = ' + inttostr(ContrId);
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
      begin
        if not EOF then
        begin
          edtKNot1.Text := fieldbyname('CNot1').AsString;
          edtKNot2.Text := fieldbyname('CNot2').AsString;
          edtINot1.Text := fieldbyname('INot1').AsString;
          edtINot2.Text := fieldbyname('INot2').AsString;
        end;
      end;

    frmSearch.GSQLString := 'Select * from [Contr_Costs] Where Contrid = ' + inttostr(ContrId);
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
      begin
        first;
        while not EOF do
        begin
          cbCost1.text := fieldbyname('CostName').AsString;
          edtCost1.text := fieldbyname('No').AsString;
          edtCost2.text := fieldbyname('Price').AsString;
          edtCost5.text := fieldbyname('VAT').AsString;
          edtCost6.text := fieldbyname('Acc_Code').AsString;
          edtCost7.text := fieldbyname('Acc_center').AsString;
          AddCostRow;
          next;
        end;
      end;

    btnReturn.Enabled := true;
    // tillåt bara ½ checkin innan återlämning har gjorts
    if status < 10 then
      btnCheckIn.Enabled := true
    else
      btnCheckIn.Enabled := false;


    //Delbetalare
    frmSearch.GSQLString := 'Select * from [Contr_Sub] Where Contrid = ' + inttostr(ContrId) + ' ORDER BY SUBID';
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
      begin
        first;
        next;
        while not EOF do
        begin
          checkDelad.Checked := true;
          I := AddDelBetalare;

          // Hantering för att göra så att konterade kontrakt inte kan återlämnas på nytt
          if CurrentView = Return then
            if FieldbyName('enummer').AsInteger > 0 then
              if DoesEnummerExist(FieldbyName('enummer').AsInteger) then
              begin
                btnReturn.Enabled := False;
                btnCheckIn.Enabled := False;
              end;

          with DelLista[i] do
          begin
            FKID := FieldbyName('SubCustId').AsInteger;
            FNamn := FieldbyName('SubName').AsString;
            FKontaktID := FieldbyName('Contact').AsString;
            FBetsatt := FieldbyName('Payment').AsString;
            FBetVilkor := FieldbyName('Terms_pay').AsInteger;
            FHyrDel := FieldbyName('SpRule_Rent').Asinteger;
            FKmDel := FieldbyName('SpRule_Km').AsInteger;
            FMomsDel := FieldbyName('SpRule_Vat').AsInteger;
            FProcent := FieldbyName('SpPercent').AsBoolean;
            sub := FieldbyName('SubId').AsInteger;

            FForsakring := false;
            ds := CreateDS('Select * from [Contr_Insur] Where SubId = ' + inttostr(sub));
            ds.Active := True;
            if not ds.EOF then
            begin
              FForsakring := true;
              if FForsakring then
              begin
                FForsKod := ds.FieldbyName('ICode').AsString;
                FForsKlass := ds.FieldbyName('IClass').AsString;
                FSkadeDat := ds.FieldbyName('IDate').AsDateTime;
                FSkadeNr := ds.FieldbyName('INumber').AsString;
                FFoRegNr := ds.FieldbyName('FRegNr').AsString;
                FMpRegNr := ds.FieldbyName('MpRegNr').AsString;
              end;
            end;
            FreeDS(ds);
            UpdateKidFaktNot(FKid, FBetsatt);
          end;
          next;
        end;
        if length(DelLista) > 0 then
        begin
          RecountDel;
          UpdateGrid;
        end;
      end;
    KontrToFaktNot(ContrId);

//!    LocalServer.SaveContrHist(0,ContrID,'Öppnad','Kontrakts status = '+inttostr(Status),frmMain.sign,status);
    FrmSearch.SaveContrHist(0, ContrID, 'Öppnad', 'Kontrakts status = ' + inttostr(Status), frmMain.sign, status);

  end;
  Scrollbox1.visible := true;
//!Benny Testar lite...
  if edtkm_in.visible then
  begin
    edtkm_in.setfocus;
    DTVTo.datepicker.setfocus;
  end;
//!Hit
end;

procedure TFrmKontrakt.edtHNamnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var PNumR: string;
  ds: TADOQuery;
begin
  if key = VK_F5 then
    if SearchCustomer((Sender as TEdit).text) then
    begin
      LoadCustomer(frmSearch.SSearchCDS.fieldbyname('Cust_id').AsString);
      if (ShowCustNote>0) and (CustNoteStr<>'') then
         ShowMessage(CustNoteStr);
    end;
//! För bilregistret CBR???
  if (key = VK_F6) and (sdbway > '!') then
  begin
    PNumR := '';
    dmsession.SDb.close;
    dmsession.SDb.LoginPrompt := False;
    dmsession.SDb.ConnectionString := SDBWay;
    dmsession.SDb.connected := true;
    ds := CreateDS('SELECT * FROM ANSWER WHERE REGNR=''' + edtHpnum.Text + '''');
    ds.ConnectionString := SDBWay;
    ds.Connection := DmSession.SDb;
    ds.Open;
    if not ds.IsEmpty then
    begin
//!    PNumR:=Copy(dmsession.SDbAnswerT.fieldbyname('KundNr').asString,1,6);
//!    PNumR:=PNumR+'-'+Copy(dmsession.SDbAnswerT.fieldbyname('KundNr').asString,7,4);
      PNUMR := Antispin(ds.fieldbyname('KundNr').AsString);
      if edtRef.Text<>'' then
        edtRef.Text := edtRef.Text + ' ' + edtHpnum.Text
      else
        edtRef.Text := edtHpnum.Text;
      if frmgreg.customerT.Locate('Org_No', PNumR, [lopartialkey]) then
      begin
        Showmessage('Kund fanns redan');
        LoadCustomer(frmgreg.customerT.fieldbyname('Cust_Id').asstring);
        if (ShowCustNote>0) and (CustNoteStr<>'') then
          ShowMessage(CustNoteStr);
      end
      else
      begin
        frmgreg.CustomerT.Append;
        Frmgreg.customerT.FieldByname('Cust_Id').asinteger := frmsearch.GetNewCustomerId;
        frmgreg.CustomerT.fieldbyname('Org_No').AsString := PNumR;
        frmgreg.CustomerT.fieldbyname('Name').AsString := trim(ds.fieldbyname('ENamn_CBR').asstring) + ', ' + trim(ds.fieldbyname('FNamn_CBR').asstring);
        frmgreg.CustomerT.fieldbyname('Adress').AsString := ds.fieldbyname('Uadr_CBR').asString;
        frmgreg.CustomerT.fieldbyname('Postal_Name').AsString := copy(ds.fieldbyname('PostNR_CBR').asstring, 1, 3) + ' ' + copy(ds.fieldbyname('PostNR_CBR').asstring, 4, 2) + '  ' + ds.fieldbyname('Ort_CBR').asstring;
        frmgreg.CustomerT.fieldbyname('Tel_1').AsString := 'B';
        frmgreg.CustomerT.fieldbyname('Tel_NR_1').AsString := ds.fieldbyname('Tel_Bost').asstring;
        frmgreg.customerT.edit;
        frmgreg.tab1.ActivePageIndex := 0;
        if frmGreg.ShowModal = mrOK then
        begin
          LoadCustomer(frmgreg.customerT.fieldbyname('Cust_Id').asstring);
          if (ShowCustNote>0) and (CustNoteStr<>'') then
            ShowMessage(CustNoteStr);
        end;
      end;
    end
    else
    begin
      Showmessage('Uppgifter saknas på ' + AnsiUpperCase(edthpnum.text));
      edthpnum.text := '';
      edthpnum.SetFocus;
    end;
    FreeDS(ds);
    dmsession.SDb.connected := False;
  end;

  if key = VK_F8 then
    EditCustomer((Sender as TEdit).text);
end;

procedure TFrmKontrakt.EditCustomer(str: string);
begin
  SaveCustomer(Customer);
  if (CustID > 0) then
  begin
    frmGreg.GetCustomer(CustId);
    if frmGreg.ShowModal = mrOK then
      LoadCustomer(inttostr(CustId));
  end;
end;

procedure TFrmKontrakt.EditDriver(str: string);
begin
  SaveCustomer(Driver);
  if (DriverID > 0) then
  begin
    frmGreg.GetCustomer(DriverId);
    if frmGreg.ShowModal = mrOK then
      LoadDriver(inttostr(DriverId));
  end;
end;

procedure TFrmKontrakt.EditObject(str: string);
begin
  if (str > '') then
  begin
    frmGreg.GetObject(str);
    if frmGreg.ShowModal = mrOK then
      LoadObject(str);
  end;
end;

function SearchCustomer(str: string): boolean;
var test, SeekStr: string;
begin
  Test := '%';
  result := false;
  if length(str) > 1 then
  begin
    str := AnsiUppercase(str);
    frmSearch.SSQLString := SQLKunder;
    seekstr := stringreplace(str, '*', '%', [rfReplaceAll]);
    if (str[2] >= '0') and (str[2] <= '9') then
    begin
      frmSearch.caption := 'Sökresultat Pers/Org Nr';
      frmSearch.SSQLString := frmSearch.SSQLString + ' And org_no like ''' + seekstr + '%''';
      frmSearch.SSQLString := frmSearch.SSQLString + ' ORDER BY org_no';

    end
    else
    begin
      frmSearch.caption := 'Sökresultat Namn';
      frmSearch.SSQLString := frmSearch.SSQLString + ' And name like ''' + seekstr + '%''';
//!      frmSearch.SSQLString := frmSearch.SSQLString + ' where name >= ''' + str + '*''';
//      frmSearch.SSQLString := frmSearch.SSQLString + ' where name like ''' + str + '*'' order by name';
      frmSearch.SSQLString := frmSearch.SSQLString + ' ORDER BY name';
    end;
    result := frmSearch.ShowSearchResult;
  end
  else
  begin
//!    ShowMessage('Skriv namn eller kundid (minst 2 tecken)');
    frmSearch.SSQLString := SQLKunder;
    frmSearch.caption := 'Sökresultat KundNr';
    frmSearch.SSQLString := frmSearch.SSQLString + ' And name like ''' + test + '%''';
    result := frmSearch.ShowSearchResult;
  end;
end;

procedure TFrmKontrakt.edtFNamnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  PNumR: string;
  ds: TADOQuery;
begin
  if key = VK_F5 then
    if SearchDriver((Sender as TEdit).text) then
    begin
      LoadDriver(frmSearch.SSearchCDS.fieldbyname('Cust_id').AsString);
      if (ShowCustNote>0) and (CustNoteStr<>'') then
          ShowMessage(CustNoteStr);
      frmsearch.ssearchcds.filtered := False;
    end;

  if (key = VK_F6) and (sdbway > '!') then
  begin
    PNumR := '';
    dmsession.SDb.close;
    dmsession.SDb.LoginPrompt := False;
    dmsession.SDb.ConnectionString := SDBWay;
    dmsession.SDb.connected := true;
    ds := CreateDS('SELECT * FROM ANSWER WHERE REGNR=''' + edtFpnum.Text + '''');
    ds.ConnectionString := SDBWay;
    ds.Connection := DmSession.SDb;
    ds.Open;
    if not ds.IsEmpty then
    begin
      PNUMR := Antispin(ds.fieldbyname('KundNr').AsString);
      if edtRef.Text<>'' then
        edtRef.Text := edtRef.Text + ' ' + edtFpnum.Text
      else
        edtRef.Text := edtFpnum.Text;
      if frmgreg.customerT.Locate('Org_No', PNumR, [lopartialkey]) then
      begin
        Showmessage('Kund fanns redan');
        LoadDriver(frmgreg.customerT.fieldbyname('Cust_Id').asstring);
        if (ShowCustNote>0) and (CustNoteStr<>'') then
          ShowMessage(CustNoteStr);
      end
      else
      begin
        frmgreg.CustomerT.Append;
        Frmgreg.customerT.FieldByname('Cust_Id').asinteger := frmsearch.GetNewCustomerId;
        frmgreg.CustomerT.fieldbyname('Org_No').AsString := PNumR;
        frmgreg.CustomerT.fieldbyname('Name').AsString := Trim(ds.fieldbyname('ENamn_CBR').asstring) + ', ' + trim(ds.fieldbyname('FNamn_CBR').asstring);
        frmgreg.CustomerT.fieldbyname('Adress').AsString := ds.fieldbyname('Uadr_CBR').asString;
        frmgreg.CustomerT.fieldbyname('Postal_Name').AsString := copy(ds.fieldbyname('PostNR_CBR').asstring, 1, 3) + ' ' + copy(ds.fieldbyname('PostNR_CBR').asstring, 4, 2) + '  ' + ds.fieldbyname('Ort_CBR').asstring;
        frmgreg.CustomerT.fieldbyname('Tel_1').AsString := 'B';
        frmgreg.CustomerT.fieldbyname('Tel_NR_1').AsString := ds.fieldbyname('Tel_Bost').asstring;
        frmgreg.customerT.edit;
        frmgreg.tab1.ActivePageIndex := 0;
        if frmGreg.ShowModal = mrOK then
        begin
          LoadDriver(frmgreg.customerT.fieldbyname('Cust_Id').asstring);
          if (ShowCustNote>0) and (CustNoteStr<>'') then
            ShowMessage(CustNoteStr);
        end;
      end;
    end
    else
    begin
      Showmessage('Uppgifter saknas på ' + AnsiUpperCase(edtFpnum.text));
      edtFpnum.text := '';
      edtFpnum.SetFocus;
    end;
    FreeDS(ds);
    dmsession.SDb.connected := False;
  end;

  if key = VK_F8 then
    EditDriver((Sender as TEdit).text);
end;

function MakeInt(str: string): integer;
begin
  try
    if str > '' then
      result := strtoint(str)
    else
      result := 0;
  except
    result := 0;
  end;
end;

function MakeFloat(str: string): real;
begin
  try
    if str > '' then
      result := StrToFloat(str)
    else
      result := 0;
  except
    result := 0;
  end;
end;

function MakeCurr(str: string): currency;
begin
  try
    if str > '' then
      result := StrToCurr(str)
    else
      result := 0;
  except
    result := 0;
  end;
end;

function TFrmKontrakt.GetSRiskVAT(): boolean;
begin
  //lägg ev in funktionallitet för att styra detta per prislista i framtiden
  result := SRISKMoms;
end;


procedure TFrmKontrakt.btnContractClick(Sender: TObject);
var
  I, J, sub, pp: Integer;
  days, km, xdays, xkm, srisk: currency;
  ObjStatus, Status: word;
  ViewType: ViewForm;
  OldContrId, MainSub: Integer;
  NumCopies: integer;
  PrintType: string;
  clickedok: boolean; //!benny för att kunna avbryta utskrift
  NumC: string; //!benny för att kunna avbryta utskrift
  Enum: Integer;
  Returning: Boolean;
  Preview: Boolean;
  Frm: TFrmUtsDg;
  ds: TAdoQuery;
  EnrLista: TStringList;
  CustIdPos: Integer;
begin
  InternKund := False;
  Returning := False;

  if sender = btnContract then
  begin
    Dmod.ADODBLogWriter.WriteToLog('Kontrakt - ' + frmMain.sign);
    ObjStatus := 1;
    Status := 4;
    ViewType := Contract;
  end else if sender = btnReturn then
  begin
    Dmod.ADODBLogWriter.WriteToLog('Återlämning - ' + frmMain.sign);
    ObjStatus := 2;
    Status := 9;
    ViewType := Return;
    if PayAlts[cbBetalning.itemindex].Code = 'I' then
      InternKund := True;
    returning := True;
  end else if sender = btnCheckIn then
  begin
    Dmod.ADODBLogWriter.WriteToLog('Check in - ' + frmMain.sign);
    ObjStatus := 2;
    Status := 8;
    ViewType := CheckIn;
  end
  else begin
    Dmod.ADODBLogWriter.WriteToLog('Bokning - ' + frmMain.sign);
    ObjStatus := 0; //Bokning
    Status := 2;
    ViewType := Booking;
  end;

  if objPanel.parent is TSGBObject then
    WriteToObject(objPanel.parent as TSGBObject);

  try
    CheckAllCorrect(ViewType);
  except
    on E: EUserError do
    begin
      Dmod.ADODBLogWriter.WriteToLog('Found error : ' + e.message);
      if E is EUserPaymentError then
        PageControl1.ActivePage := PageControl1.Pages[(E as EUserPaymentError).FTabIndexNumber];
      if E is EUserObjError then
      begin
        ChangeObject(ObjArr[(E as EUserObjError).FObjNum]);
        ReadFromObject(ObjArr[(E as EUserObjError).FObjNum]);
      end;
      if E.CompSetFocus <> nil then
      begin
        if E.CompSetFocus.parent is TShrinkGroupBox then
          TShrinkGroupBox(E.CompSetFocus.parent).SetFocus
        else
          if E.CompSetFocus.parent.parent is TShrinkGroupBox then
            TShrinkGroupBox(E.CompSetFocus.parent.parent).SetFocus;
        E.CompSetFocus.SetFocus;
      end;
      ShowMessage(E.Message);
      exit;
    end;
  end;

  SetLength(DelBetalare, 0);
  if Sender = btnReturn then //(Vid återlämning)
  begin
    //Hämta prisberäkning
    try
      if not assigned(frmPris) then
        frmPris := TfrmPris.Create(application);
      try

        for I := 1 to 9 do
          if assigned(objArr[i]) then
          begin
            with objArr[i] do

  //!            LocalServer.GetBestPrice(FDTVFrom,FDTVTO,(Makeint(FedtKM_IN) - Makeint(FedtKM_UT)),FcbPType,FedtPKlass,days,km,xdays,xkm,srisk);
              Frmsearch.GetBestPrice(FDTVFrom, FDTVTO, (Makeint(FedtKM_IN) - Makeint(FedtKM_UT)), FcbPType, FedtPKlass, days, km, xdays, xkm, srisk);

            if not objArr[i].FchSRRed then
              srisk := 0;
            frmPris.AddObjektCostToPrice(objArr[I].FedtObjId, days, km, xdays, xkm, srisk, GetSRiskVAT);
          end;

        J := 0;
        for I := 1 to sgCost.RowCount - 1 do
          if sgCost.Cells[0, I] > '' then
          begin
            if J = 0 then
              J := frmPris.AddOtherCostsToPrice('Tillägg');
            frmPris.AddCostsToPrice(J, sgCost.Cells[0, I], strtofloat(sgCost.Cells[3, I]), strtofloat(sgCost.Cells[5, I]) / 100);
          end;

        frmPris.AddDeposit(MakeFloat(edtDeposit.text));
        frmPris.UpdateCosts;
  //      frmPris.UpdateCostTot;

        pp := frmPris.AddPartPayer(edtHNamn.text);

        for I := 1 to length(DelLista) - 1 do
          with DelLista[i] do
          begin
            pp := frmPris.AddPartPayer(FNamn);
            frmPris.ChangePartPayer(pp, FProcent, FHyrdel, FKmDel, FMomsDel);
          end;

        frmPris.UpdateAll;

        //Visa prisbild
        if frmPris.ShowModal <> mrOk then
          exit;

      finally
        frmPris.Free;
        frmPris := nil;
      end;
    except
      on e: exception do
      begin
        Dmod.ADODBLogWriter.WriteToLog('Error on pricing : ' + e.message);
        raise;
      end;
    end;
  end;

  oldContrId := 0;
  EnrLista := TStringList.Create;
  DmSession.adoconnection1.BeginTrans; // <-----------
  try
    if DeleteBeforeUpdate then
    begin
      if ContrID > 0 then
      begin
        if Sender <> btnCheckIn then
        begin
          ds := CreateDS('SELECT SUBCUSTID,ENUMMER FROM CONTR_SUB WHERE ENUMMER>0 AND CONTRID=' + Inttostr(ContrId));
          ds.open;
          while not ds.Eof do
          begin
            if not DoesEnummerExist(ds.Fields[1].AsInteger) then
            begin
              EnrLista.AddObject(ds.Fields[0].AsString, TObject(ds.Fields[1].AsInteger));
            end;
            ds.Next;
          end;
          FreeDS(ds);

          FrmSearch.DeleteContract(ContrID);
          oldContrId := ContrId;
        end;
      end else begin
        ContrID := FrmSearch.GetNewNo(KontraktNr);
        oldContrId := ContrId;
        if ContrID = 0 then
          ContrID := FrmSearch.GetNewNo(KontraktNr);
      end;
    end;

    //Save contract base
    frmsearch.SaveContrBase(ContrID, CustId, frmMain.sign, edtRef.Text, Status, PayAlts[cbBetalning.itemindex].Code, strtoint(pnlBetVillkor.Caption),
    checkDelfakt.Checked,edDF_StartDatum.Text,edDF_SlutDatum.Text,edDF_BELOPP.Text);

    //Save contract History
    if OldContrId = 0 then
      FrmSearch.SaveContrHist(0, ContrID, 'Skapad', 'Kontrakts status = ' + inttostr(Status), frmMain.sign, status)
    else
      FrmSearch.SaveContrHist(0, ContrID, 'Ändrad', 'Kontrakts status = ' + inttostr(Status), frmMain.sign, status);

    //Save all contract objects
    I := 1;
    while assigned(objArr[i]) and (I <= 9) do
    begin
      with objArr[i] do
        FrmSearch.SaveContrObjT(ContrID, GetObjTypID(FcbObjId, cbObjTyp.items), FedtObjId, FDTVFrom, FDTVTO, FDTVOut, FDTVReturn, Makeint(FedtKM_UT), Makeint(FedtKM_IN), Makeint(FedtKM_KORT), FedtPKlass, FcbPType, FchSRRed, ObjStatus, FedtDragBil, 0);
      if EdtKm_In.visible then
//!Benny för att lägga ner km ställning
      begin
        dmod.Q1.Active := False;
        dmod.q1.SQL.Text := 'Update Objects Set KM_N=' + dbdel + EdtKm_In.text + dbdel + ' where Reg_No=' + dbdel + EdtObjId.text + dbdel;
        dmod.Q1.ExecSQL;
        dmod.Q1.Active := False;
      end;
//!Hit
      inc(I);
    end;
    //Save contract complements
    FrmSearch.SaveContrComp(ContrID, DriverID, SRRed, 0, MakeInt(edtDeposit.Text));
    //Save contract notes
    if (edtKNot1.text > '') or (edtKNot2.text > '') or (edtINot1.text > '') or (edtINot2.text > '') then
      FrmSearch.SaveContrNot(ContrID, edtKNot1.text, edtKNot2.text, edtINot1.text, edtINot2.text);
    //Save contract costs
    for I := 1 to SGCost.RowCount - 1 do
      if sgCost.Cells[0, I] > '' then
        FrmSearch.SaveContrCosts(ContrID, sgCost.Cells[0, I], MakeFloat(sgCost.Cells[1, I]), MakeCurr(sgCost.Cells[2, I]), MakeFloat(sgCost.Cells[5, I]), MakeInt(sgCost.Cells[6, I]), MakeInt(sgCost.Cells[7, I]));

    //Update credit card info
    if (PayAlts[cbBetalning.itemindex].Code = 'O') then
    begin
      if (cbCard.itemindex >= 0) and (cbCard.itemindex < length(ccards)) then
//! Lagt till
        FrmSearch.UpdateCreditCard(CustId, CCards[cbCard.itemindex].Id, edtCardNr.text, edtcardexp.text);
    end;
    //Save main payer if no part payers
    sub := 0;
    Mainsub := 0;
    if (CustId > 0) and (edtHNamn.text > '') then
      Mainsub := FrmSearch.SavePartPayer(ContrID, CustId, edtHNamn.text, '', true, 100, 100, 100, PayAlts[cbBetalning.itemindex].Code, strtoint(pnlBetVillkor.Caption));
//    save subId for Invoicepart
    if (PayAlts[cbBetalning.itemindex].Code = 'F') or (PayAlts[cbBetalning.itemindex].Code = 'U') then
      UpdateInvoicePayer(Mainsub, inttostr(CustId), '', '', '', '', '');

    if assigned(DelBetalare) and (length(DelBetalare) > 0) then
      with DelBetalare[0] do
      begin
        if ((InternKund) and (not IntMoms)) then
          FrmSearch.SavePartCost(Mainsub, RoundValue(sum), RoundValue(hyr), 0, RoundValue(Sum), '', '', false, '')
        else
          FrmSearch.SavePartCost(Mainsub, RoundValue(sum), RoundValue(hyr), RoundValue(btmoms), RoundValue(BTSum), '', '', false, '');
//!        FrmSearch.SavePartCost(Mainsub,sum,hyr,moms,tot,'','',false,'');
        for J := 0 to length(kostnader) - 1 do
          FrmSearch.SavePartRow(Mainsub, J + 1, kostnader[J].namn, RoundValue(kostnader[J].value), kostnader[J].percent, kostnader[J].byvalue);
      end;
    if CheckDelad.Checked then
    begin
      DelLista[0].FSub := MainSub;
      //Save part payers
      for I := 0 to length(DelLista) - 1 do //!  För att skriva ner 2 Parter i Sub    for I := 1 to length(DelLista) -1 do
        with DelLista[I] do
        begin
          sub := FrmSearch.SavePartPayer(ContrID, FKID, FNamn, FKontaktID, FProcent, FHyrDel, FKmDel, FMomsDel, FBetsatt, FBetvilkor);
          //    save subId for Invoicepart
          if (FBetsatt = 'F') or (FBetsatt = 'U') then
            UpdateInvoicePayer(Sub, inttostr(FKId), '', '', '', '', '');
          if assigned(DelBetalare) and (length(DelBetalare) > I) then
            with DelBetalare[I] do
            begin
              FSub := Sub;
              if ((not IntMoms) and (FBetSatt = 'I')) then
                FrmSearch.SavePartCost(sub, RoundValue(sum), RoundValue(hyr), 0, RoundValue(sum), '', '', false, '')
              else
                FrmSearch.SavePartCost(sub, RoundValue(sum), RoundValue(hyr), RoundValue(moms), RoundValue(sum) + RoundValue(moms), '', '', false, '');
              for J := 0 to length(kostnader) - 1 do
                FrmSearch.SavePartRow(sub, J + 1, kostnader[J].namn, RoundValue(kostnader[J].value), kostnader[J].percent, kostnader[J].byvalue);
            end;
          if FForsakring then
            FrmSearch.SaveInsurInfo(sub, FForskod, FSkadeDat, FFoRegNr, FForsKlass, FSkadeNr, FMpRegNr);
        end;
    end;
    // Save invoiceNotes
    FaktNotToKontr;
    if returning = true then
    begin
      if length(Dellista) > 0 then
      begin
        for i := 0 to length(DelLista) - 1 do
        begin
          CustIdPos := EnrLista.IndexOf(IntToStr(DelLista[i].FKID));
          if CustIdPos > -1 then
            Enum := Integer(EnrLista.Objects[CustIdPos])
          else
            enum := 0;
          if enum <= 0 then
          begin
            enum := 0;
            if (DelLista[i].FBetsatt = 'K') and (frmmain.EnrKontant = False) then
            begin
              enum := dmod.ParamT.fieldbyname('Knotenr').asinteger + 1;
              dmod.ParamT.edit;
              dmod.ParamT.fieldbyname('Knotenr').asinteger := Enum;
              dmod.ParamT.Post;
            end;
            if (DelLista[i].FBetsatt = 'O') and (frmmain.EnrKontoK = False) then
            begin
              enum := dmod.ParamT.fieldbyname('FBolagNr').asinteger + 1;
              dmod.ParamT.edit;
              dmod.ParamT.fieldbyname('FBolagNr').asinteger := Enum;
              dmod.ParamT.Post;
            end;
            if (DelLista[i].FBetsatt = 'F') and (frmmain.EnrFaktura = False) then
            begin
              enum := dmod.ParamT.fieldbyname('FaktNr').asinteger + 1;
              dmod.ParamT.edit;
              dmod.ParamT.fieldbyname('FaktNr').asinteger := Enum;
              dmod.ParamT.Post;
            end;
            if (DelLista[i].FBetsatt = 'I') and (frmmain.EnrInterna = False) then
            begin
              enum := dmod.ParamT.fieldbyname('InternNr').asinteger + 1;
              dmod.ParamT.edit;
              dmod.ParamT.fieldbyname('InternNr').asinteger := Enum;
              dmod.ParamT.Post;
            end;
          end;
          if enum > 0 then
          begin
            dmod.Q1.Active := False;
            dmod.Q1.Sql.Text := 'Update Contr_sub Set Enummer=' + dbdel + inttostr(Enum) + dbdel + ', Status=' + dbdel + '10' + dbdel + ' where Contrid=' + dbdel + inttostr(ContrId) + dbdel + ' AND Subname=' + dbdel + dellista[i].FNamn + dbdel;
            dmod.Q1.ExecSQL;
            MoveData(DelLista[i].FSub);
            enum := 0;
          end;
        end;
      end
      else
      begin
        CustIdPos := EnrLista.IndexOf(IntToStr(CustId));
        if CustIdPos > -1 then
          Enum := Integer(EnrLista.Objects[CustIdPos])
        else
          enum := 0;
        if enum <= 0 then
        begin
          enum := 0;
          if (PayAlts[cbBetalning.itemindex].Code = 'K') and (frmmain.EnrKontant = False) then
          begin
            enum := dmod.ParamT.fieldbyname('Knotenr').asinteger + 1;
            dmod.ParamT.edit;
            dmod.ParamT.fieldbyname('Knotenr').asinteger := Enum;
            dmod.ParamT.Post;
          end;
          if (PayAlts[cbBetalning.itemindex].Code = 'O') and (frmmain.EnrKontoK = False) then
          begin
            enum := dmod.ParamT.fieldbyname('FBolagNr').asinteger + 1;
            dmod.ParamT.edit;
            dmod.ParamT.fieldbyname('FBolagNr').asinteger := Enum;
            dmod.ParamT.Post;
          end;
          if (PayAlts[cbBetalning.itemindex].Code = 'F') and (frmmain.EnrFaktura = False) then
          begin
            enum := dmod.ParamT.fieldbyname('FaktNr').asinteger + 1;
            dmod.ParamT.edit;
            dmod.ParamT.fieldbyname('FaktNr').asinteger := Enum;
            dmod.ParamT.Post;
          end;
          if (PayAlts[cbBetalning.itemindex].Code = 'I') and (frmmain.EnrInterna = False) then
          begin
            enum := dmod.ParamT.fieldbyname('InternNr').asinteger + 1;
            dmod.ParamT.edit;
            dmod.ParamT.fieldbyname('InternNr').asinteger := Enum;
            dmod.ParamT.Post;
          end;
        end;
        if enum > 0 then
        begin
          dmod.Q1.Active := False;
          dmod.Q1.Sql.Text := 'Update Contr_sub Set Enummer=' + dbdel + inttostr(Enum) + dbdel + ', Status=' + dbdel + '10' + dbdel + ' where Contrid=' + dbdel + inttostr(ContrId) + dbdel;
          dmod.Q1.ExecSQL;
          MoveData(Mainsub);
          enum := 0;
        end;
      end;
    end;


    Dmsession.adoconnection1.CommitTrans;

    if oldContrId > 0 then
    begin
      try
        DmSession.adoconnection1.BeginTrans;
        FrmSearch.ChangeContrID(ContrId, oldContrId);
        ContrId := oldContrId;

        DmSession.adoconnection1.CommitTrans;

      except
        DmSession.adoconnection1.RollbackTrans;
      end;
    end;

//!Baz
    if (CheckDelad.Checked) and (dellista[0].FKID <> CustId) then
    begin
      ds := CreateDS(Format('SELECT * FROM CONTR_SUB WHERE CONTRID=%d AND SUBCUSTID=%d', [ContrID, CustId]));
      try
        ds.Open;
        if not ds.Eof then
        begin
          ds.Edit;
          ds.fieldbyname('SPPercent').AsBoolean := dellista[0].FProcent;
          ds.fieldbyname('SPRule_Rent').AsInteger := dellista[0].FHyrDel;
          ds.fieldbyname('SPRule_Km').AsInteger := dellista[0].FKmDel;
          ds.fieldbyname('SPRule_Vat').AsInteger := dellista[0].FMomsDel;
          ds.Post;
          SetDS(ds, Format('DELETE FROM CONTR_SUB WHERE CONTRID=%d AND SUBCUSTID=%d', [ContrID, dellista[0].FKID]));
          ExecDS(ds);
        end;
      finally
        FreeDS(ds);
      end;
    end;
//!TEst Hit

    //Utskrifter
    NumCopies := 0;
    //Bokning och kontrakt
    if ViewType in [Booking, Contract] then
    begin
      if ViewType = Booking then
      begin
        NumCopies := NumBookCopies;
        PrintType := 'Bokningsbekräftelse';
      end;
      if ViewType = Contract then
      begin
        NumCopies := NumContCopies;
        PrintType := 'Kontrakt';
      end;
      if NumCopies >= 0 then
      begin
        frm := TFrmUtsDg.Create(self);
        Frm.Caption := PrintType + ' ' + inttostr(contrid);
        Frm.Edit1.Text := inttostr(NumCopies);
        Frm.ShowModal;
        if Frm.ModalResult = MrOk then
          NumCopies := strtoint(Frm.Edit1.Text) else
          NumCopies := 0;
      end;
      if NumCopies <> 0 then
        eqprn.PrintAvtal(ContrID, 0, NumCopies, NumCopies = -1);
    end;

    //Återlämning
    if ViewType = Return then
    begin
      if not CheckDelad.Checked then
      begin
        GetPrintRules(PayAlts[cbBetalning.itemindex].Code, NumCopies, PrintType);

        if NumCopies >= 0 then
        begin
          frm := TFrmUtsDg.Create(Self);
          Frm.Caption := PrintType + ' ' + inttostr(contrid);
          Frm.Edit1.Text := inttostr(NumCopies);
        end;

        Frm.ShowModal;
        if Frm.ModalResult = MrOk then
          NumCopies := strtoint(Frm.Edit1.Text)
        else
          NumCopies := 0;

        if NumCopies <> 0 then
          eqprn.PrintKvitto(ContrID, Mainsub, 0, NumCopies, NumCopies = -1);
      //Deladbetalning
      end else begin
        for I := 0 to length(Dellista) - 1 do
        begin
          GetPrintRules(Dellista[I].FBetsatt, NumCopies, PrintType);

          if NumCopies >= 0 then
          begin
            frm := TFrmUtsDg.Create(self);
            Frm.Caption := PrintType + ' ' + inttostr(contrid);
            Frm.Edit1.Text := inttostr(NumCopies);
          end;
          Frm.ShowModal;
          if Frm.ModalResult = MrOk then
            NumCopies := strtoint(Frm.Edit1.Text) else
            NumCopies := 0;

          if NumCopies <> 0 then
            eqprn.PrintKvitto(ContrID, DelLista[I].FSub, 0, NumCopies, NumCopies = -1);
        end;
      end;
    end;
    Close; //Contractwindow
    if assigned(frmBokgraf) then
    begin
      frmBokgraf.UpdateFromDatabase(nil);
    end;
    frm.Free;
  except
    on E: Exception do
    begin
      if oldContrId > 0 then
        ContrId := oldContrId;

      Dmod.ADODBLogWriter.WriteToLog('Error on contract : ' + e.Message);
      ShowMessage('Ett fel inträffade.');
      DmSession.adoconnection1.RollbackTrans; //! RollBack
    end;
  end;
  EnrLista.Free;
end;

procedure TFrmKontrakt.GetPrintRules(PayCode: string; var Copies: integer; var PrintText: string);
begin
  if (PayCode = 'O') then
  begin
    Copies := NumCashCopies;
    PrintText := 'Kontantnota';
  end;
  if (PayCode = 'K') then
  begin
    Copies := NumCashCopies;
    PrintText := 'Kontantnota';
  end;
  if (PayCode = 'I') then
  begin
    Copies := NumInteCopies;
    PrintText := 'Internfaktura';
  end;
  if (PayCode = 'F') then
  begin
    Copies := NumIDepCopies;
    PrintText := 'Fakturaunderlag';
  end;
  if (PayCode = 'U') then
  begin
    Copies := NumIDepCopies;
    PrintText := 'Fakturaunderlag';
  end;
end;

procedure TFrmKontrakt.BitBtn6Click(Sender: TObject);
begin
  FetchContExecute(nil);
end;

procedure TFrmKontrakt.OKExecute(Sender: TObject);
begin
  case CurrentView of
    booking: btnContractClick(btnBook);
    contract: btnContractClick(btnContract);
    return: btnContractClick(btnReturn);
  end;
end;

procedure TFrmKontrakt.NyttObjExecute(Sender: TObject);
var
  I: Integer;
begin
  exit;

  I := GetObjNumber;
  if I = 10 then
    ShowMessage('Du kan bara ha 9 objekt per kontrakt.')
  else
    CreateObj(I);
end;

procedure TFrmKontrakt.RaderaObjExecute(Sender: TObject);
var
  obj: TSGBObject;
  I: Integer;
begin
  exit;
  if objPanel.parent is TSGBObject then
  begin
    cbObjTyp.SetFocus;
    if MessageDlg('Vill du ta bort hyresobjektet?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      obj := (objPanel.parent as TSGBObject);
      objPanel.visible := false;
      objPanel.parent := Scrollbox1;
      for I := 1 to 9 do
        if assigned(ObjArr[i]) and (I <> obj.tag) then
        begin
          ChangeObject(ObjArr[i]);
          ReadFromObject(ObjArr[i]);
        end;
      objArr[obj.tag] := nil;
      obj.free;

    end;
  end
  else
    ShowMessage('Inget objekt är valt');
end;

procedure TFrmKontrakt.FetchContExecute(Sender: TObject);
var
  i: Integer;
begin
  Loading := true;
  try
    case CurrentView of
      booking:
        begin
          if frmSearch.GetSQL_Sign('SQLBokn') > '!' then //! 021128
            frmSearch.SSQLString := frmSearch.GetSQL_Sign('SQLBokn') //! 021128
          else
            frmSearch.SSQLString := SQLBokning;
          frmSearch.caption := 'Sökresultat bokning';
          if frmSearch.ShowSearchResult then
          begin
//! Spara ner Ordning och skapa en ny Post i Ini
            LoadContract(frmSearch.SSearchCDS.fieldbyname('ContrID').AsInteger);
          end;
        end;
      contract:
        begin
          if frmSearch.GetSQL_Sign('SQLKontr') > '!' then //! 021128
            frmSearch.SSQLString := frmSearch.GetSQL_Sign('SQLKontr') //! 021128
          else //! 021128
            frmSearch.SSQLString := SQLKontrakt;
          frmSearch.caption := 'Sökresultat kontrakt';
          if frmSearch.ShowSearchResult then
          begin
//! Spara ner Ordning och skapa en ny Post i Ini
            LoadContract(frmSearch.SSearchCDS.fieldbyname('ContrId').AsInteger);
          end;
        end;
      return:
        begin
          if frmSearch.GetSQL_Sign('SQLRet') > '!' then //! 021128
            frmSearch.SSQLString := frmSearch.GetSQL_Sign('SQLRet') //! 021128
          else //! 021128
            frmSearch.SSQLString := SQLReturn;
          frmSearch.caption := 'Sökresultat återlämning';
          if frmSearch.ShowSearchResult then
          begin
//! Spara ner Ordning och skapa en ny Post i Ini
            LoadContract(frmSearch.SSearchCDS.fieldbyname('ContrID').AsInteger);
          end;
        end;
    end
  finally
    Loading := false;
  end;
  chSRRed.checked := SRRed;
end;

procedure TFrmKontrakt.DelContExecute(Sender: TObject);
var str: string;
begin
  if ContrID > 0 then
  begin
    case CurrentView of
      booking: str := 'Vill du radera bokningen?';
      contract: str := 'Vill du radera kontraktet?';
      return: str := 'Vill du radera kontraktet?';
    end;
    if MessageDlg(str,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FrmSearch.DeleteContract(ContrID);
      close;
    end;
  end;
end;

procedure TFrmKontrakt.edtPKlassChange(Sender: TObject);
begin
  if edtPKlass.text > '' then
  begin
    GetPriceTypes(edtPKlass.text, cbPristyp.Items, DTVFrom.DateTime, true);
    cbPristyp.itemindex := 0;
  end;
end;

procedure TFrmKontrakt.edtKM_INChange(Sender: TObject);
begin
  edtKM_KORT.text := inttostr(Makeint(edtKM_IN.text) - Makeint(edtKM_UT.text));
end;

procedure TFrmKontrakt.btnNewDelClick(Sender: TObject);
var I: Integer;
begin
  dlgDelbetalare := TdlgDelbetalare.create(self);
  try
    dlgDelbetalare.New := true;
    if dlgDelbetalare.showmodal = mrOK then
    begin
      I := AddDelBetalare;
      SparaDelbetalare(DelLista[i]);
      RecountDel;
      UpdateGrid;
      UpdateKidFaktNot(DelLista[i].FKID, DelLista[i].FBetsatt);
    end;
  finally
    dlgDelbetalare.free;
  end;
end;

procedure TFrmKontrakt.btnChangeDelClick(Sender: TObject);
var I: Integer;
begin
  I := StringGrid1.Selection.Top - 1;
  if I > 0 then
  begin
    dlgDelbetalare := TdlgDelbetalare.create(self);
    try
      dlgDelbetalare.ClearFields;
      FillDelBetalare(DelLista[I]);
      dlgDelbetalare.New := false;
      if dlgDelBetalare.showModal = mrOK then
      begin
        SparaDelbetalare(DelLista[I]);
        RecountDel;
        UpdateGrid;
        UpdateKidFaktNot(DelLista[i].FKID, DelLista[i].FBetsatt);
      end;
    finally
      dlgDelbetalare.free;
    end;
  end;
end;

procedure TFrmKontrakt.btnDeleteDelClick(Sender: TObject);
var I: Integer;
begin
  I := StringGrid1.Selection.Top - 1;
  if I > 0 then
  begin
    UpdateKidFaktNot(DelLista[i].FKID, '');
    DeleteDelbetalare(I);
    RecountDel;
    UpdateGrid;
  end;
end;

procedure TFrmKontrakt.RecountDel;
var H, K, M, I: word;
begin
  H := 0;
  K := 0;
  M := 0;
  if assigned(DelLista) then
  begin
    for I := length(DelLista) - 1 downto 1 do
    begin
      with DelLista[I] do
        if FProcent then
        begin
          H := H + FHyrDel;
          K := K + FKmDel;
          if FMomsDel <> 999 then
            M := M + FMomsDel;
        end;
    end;
    DelLista[0].FHyrDel := 100 - H;
    DelLista[0].FKmDel := 100 - K;
    DelLista[0].FMomsDel := 100 - M;
  end;
end;

procedure TFrmKontrakt.CreateDel;
begin
  SetLength(DelLista, 1);
  with DelLista[0] do
  begin
    FKID := CustID;
    FNamn := edtHNamn.Text;
    FBetsatt := PayAlts[cbBetalning.itemindex].code;
    FBetVilkor := strtoint(pnlBetvillkor.Caption);
    FHyrDel := 100;
    FKmDel := 100;
    FMomsDel := 100;
    FProcent := true;
  end;
  tabDelBet.TabVisible := true;
  UpdateGrid;
end;

procedure TFrmKontrakt.DestroyDel;
var I: Integer;
begin
  tabDelBet.TabVisible := false;
  for I := length(DelLista) - 1 downto 0 do
    DeleteDelbetalare(I);
end;

procedure TFrmKontrakt.UpdateGrid;
var
  I: Integer;
  str: string;
begin
  with StringGrid1 do
  begin
    Cells[0, 0] := 'Namn';
    Cells[1, 0] := 'Hyreskostnad';
    Cells[2, 0] := 'Km kostnad';
    Cells[3, 0] := 'Moms';
    for I := 0 to length(DelLista) - 1 do
    begin
      with DelLista[I] do
      begin
        Cells[0, I + 1] := FNamn;
        if FProcent then
          str := ' %'
        else
          str := ' kr';
        Cells[1, I + 1] := inttostr(FHyrDel) + str;
        Cells[2, I + 1] := inttostr(FKmDel) + str;
        if FMomsDel <> 999 then
          Cells[3, I + 1] := inttostr(FMomsDel) + str
        else
          Cells[3, I + 1] := '';
      end;
    end;
    if length(Dellista) < 2 then
      RowCount := 2
    else
      RowCount := length(Dellista) + 1;
  end;
end;

procedure TFrmKontrakt.FillDelbetalare(Delbetalare: TDelBetalare);
begin
  with Delbetalare do
  begin
    dlgDelbetalare.LoadDelbet(inttostr(FKID));
    dlgDelbetalare.edtKontakt.text := FKontaktID;
//!   dlgDelbetalare.Label4.Caption := GetKNamn(DM2.KundrT,FKontaktID);
    dlgDelbetalare.cbBetalning.Itemindex := GetBetIndex(FBetSatt);
    dlgDelbetalare.pnlBetVillkor.caption := inttostr(FBetVilkor);
    dlgDelbetalare.cbBetalningClick(nil);
    dlgDelbetalare.cbProcent.Checked := FProcent;
    dlgDelbetalare.Edit7.text := IntToStr(FHyrDel);
    dlgDelbetalare.Edit8.text := IntToStr(FKMDel);
    if FMomsDel <> 999 then
      dlgDelbetalare.Edit9.text := IntToStr(FMomsDel)
    else
      dlgDelbetalare.Edit9.text := '';

    dlgDelbetalare.cbForsakring.Checked := FForsakring;
    if FForsakring then
    begin
      dlgDelbetalare.Groupbox4.visible := true;
      dlgDelbetalare.Edit1.Text := FForsKod;
      dlgDelbetalare.Edit2.Text := FForsKlass;
      dlgDelbetalare.Edit3.Text := DateToStr(FSkadeDat);
      dlgDelbetalare.Edit4.Text := FSkadeNr;
      dlgDelbetalare.Edit5.Text := FFoRegNr;
      dlgDelbetalare.Edit6.Text := FMpRegNr;
    end;
    if FBetSatt = 'O' then
    begin
      dlgDelbetalare.cbCard.text := FKontoTyp;
      dlgDelbetalare.Edit18.Text := FKontoNr;
      dlgDelbetalare.Checkbox3.checked := FSparr;
      dlgDelbetalare.Edit19.Text := FSparrNr;
    end;
  end;
end;

procedure TFrmKontrakt.SparaDelbetalare(var Delbetalare: TDelBetalare);
begin
  with Delbetalare do
  begin
    FKID := dlgDelbetalare.PartID;
    FNamn := dlgDelbetalare.edtDelbet.text;
    FKontaktID := dlgDelbetalare.edtKontakt.text;
    FBetsatt := PayAlts[dlgDelbetalare.cbBetalning.itemindex].code;
    FBetVilkor := strtoint(dlgDelbetalare.pnlBetvillkor.caption);

    FHyrDel := StrToInt(dlgDelbetalare.Edit7.text);
    FKmDel := StrToInt(dlgDelbetalare.Edit8.text);
    if dlgDelbetalare.Edit9.text <> '' then
      FMomsDel := StrToInt(dlgDelbetalare.Edit9.text)
    else
      FMomsDel := 0;
    FProcent := dlgDelbetalare.cbProcent.Checked;

    FForsakring := dlgDelbetalare.cbForsakring.Checked;
    if FForsakring then
    begin
      FForsKod := dlgDelbetalare.Edit1.Text;
      FForsKlass := dlgDelbetalare.Edit2.Text;
      if dlgDelbetalare.Edit3.Text > '!' then
        FSkadeDat := StrToDate(dlgDelbetalare.Edit3.Text);
      FSkadeNr := dlgDelbetalare.Edit4.Text;
      FFoRegNr := dlgDelbetalare.Edit5.Text;
      FMpRegNr := dlgDelbetalare.Edit6.Text;
    end;
    if FBetSatt = 'O' then
    begin
      FKontoTyp := dlgDelbetalare.cbCard.text;
      FKontoNr := dlgDelbetalare.Edit18.Text;
      FSparr := dlgDelbetalare.Checkbox3.checked;
      FSparrNr := dlgDelbetalare.Edit19.Text;
    end;
  end;
end;

procedure TFrmKontrakt.FormDestroy(Sender: TObject);
begin
  frmMain.ClosingChild(self);
end;

procedure TFrmKontrakt.cbBetalningKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_F5 then
    SpeedButton1Click(nil);

end;

function TFrmKontrakt.GetObjRegNo(ObjNum: string): string;
begin
  result := ObjNum;
  if (ObjNum > '') and (ObjNum[1] <= '9') then
  begin
    frmSearch.GSQLString := 'SELECT Objects.Reg_No, Objects.ObjNum FROM Objects WHERE (Objects.ObjNum)= ' + ObjNum;
    if frmSearch.GetSearchResult then
      result := frmSearch.GSearchCDS.Fieldbyname('Reg_No').AsString;
  end;
end;

function TFrmKontrakt.GetObjectsType(Reg_No: string): integer;
var
  OType: string;
begin
  result := 0;
  frmSearch.GSQLString := 'SELECT Objects.Reg_No, Objects.Type FROM Objects WHERE (Objects.Reg_No)= ''' + Reg_No + '''';
  if frmSearch.GetSearchResult then
  begin
    OType := frmSearch.GSearchCDS.Fieldbyname('Type').AsString;
    result := GetObjTypIndex(OType, cbObjtyp.items);
  end;
end;

procedure TFrmKontrakt.edtObjIdExit(Sender: TObject);
var
  ds: TADOQuery;
begin
  label23.Font.Color := ClBlack;
//! Benny lagt till
  if edtObjId.text > '!' then
  begin
    edtObjId.text := GetObjRegNo(edtObjId.text);
//!  if LocalServer.CheckObjFree(edtObjId.Text,DTVFrom.DateTime,DTVTo.DateTime,ContrID,false) then
    if FrmSearch.CheckObjFree(edtObjId.Text, DTVFrom.DateTime, DTVTo.DateTime, ContrID, false) then
    begin
      edtObjId.Font.color := clBlack;
      if ObjChanged then
      begin
        LoadObject(edtObjId.Text);
      end;
      if ((edtKM_ut.Text = '0') or (edtKM_ut.Text = '')) and (CurrentView <> Booking) then
      begin
        ds := CreateDS('Select Objects.KM_N from Objects Where REG_NO = ''' + edtObjId.Text + '''');
        try
          ds.Active := True;
          edtKM_UT.text := ds.fieldbyname('KM_N').AsString;
          ds.Active := False;
        except
        end;
        FreeDS(ds);
      end;
    end
    else
      ClearObject;
  end;
  SetObjSummary;
end;

function TFrmKontrakt.AskToSaveCustomerInfo: boolean;
begin
  result := false;
  if (edtHNamn.text > '!') or
    (edtHAdress1.text > '!') or
    (edtHAdress2.text > '!') or
    (edtHTel.text > '!') then
    if MessageDlg('Du har kundinformation utan personnummer. Vill du spara kunden?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      result := true;
end;

function TFrmKontrakt.AskToSaveDriverInfo: boolean;
begin
  result := false;
  if (edtFNamn.text > '!') or
    (edtFAdress1.text > '!') or
    (edtFAdress2.text > '!') or
    (edtFTel.text > '!') then
    if MessageDlg('Du har kundinformation utan personnummer. Vill du spara kunden?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      result := true;
end;

function TFrmKontrakt.SaveCustomer(CType: TCustomerType): boolean;
var
  changed: boolean;
begin
  result := true;
  try
    if CType = Customer then
    begin
      if CustId < 1 then
      begin
        if (edtHPNum.text > '!') or (AskToSaveCustomerInfo) then
        begin
//!          CustId := LocalServer.GetNewCustomerId;
          CustId := FrmSearch.GetNewCustomerId;
          frmGReg.CustomerT.Append;
        end;
      end
      else
      begin
        if frmGReg.CustomerT.locate('Cust_Id', CustId, [loCaseInsensitive]) then
        begin
          changed := false;
          changed := changed or (frmGReg.CustomerT.FieldbyName('Name').AsString <> edtHNamn.text);
          changed := changed or (frmGReg.CustomerT.FieldbyName('Adress').AsString <> edtHAdress1.text);
          changed := changed or (frmGReg.CustomerT.FieldbyName('Postal_name').AsString <> edtHAdress2.text);
          changed := changed or (frmGReg.CustomerT.FieldbyName('Org_No').AsString <> edtHPNum.text);
          changed := changed or (frmGReg.CustomerT.FieldbyName('Tel_Nr_1').AsString <> edtHTel.text);
          if changed then
            frmGReg.CustomerT.Edit;
        end;
      end;
      if frmGReg.CustomerT.state in [dsEdit, dsInsert] then
      begin
        frmGReg.CustomerT.FieldbyName('Cust_Id').AsInteger := CustId;
        frmGReg.CustomerT.FieldbyName('Name').AsString := edtHNamn.text;
        frmGReg.CustomerT.FieldbyName('Adress').AsString := edtHAdress1.text;
        frmGReg.CustomerT.FieldbyName('Postal_name').AsString := edtHAdress2.text;
        frmGReg.CustomerT.FieldbyName('Org_No').AsString := edtHPNum.text;
        frmGReg.CustomerT.FieldbyName('Tel_Nr_1').AsString := edtHTel.text;
        frmGReg.CustomerT.Post;
   //        frmGReg.CustomerCDS.ApplyUpdates(0);
      end;
    end

    else
      if CType = Driver then
      begin
        if DriverId < 1 then
        begin
          if (edtFPNum.text > '!') or (AskToSaveDriverInfo) then
          begin
            DriverId := FrmSearch.GetNewCustomerId;
            frmGReg.CustomerT.Append;
          end;
        end
        else
        begin
          if frmGReg.CustomerT.locate('Cust_Id', DriverId, [loCaseInsensitive]) then
            frmGReg.CustomerT.Edit;
        end;
        if frmGReg.CustomerT.state in [dsEdit, dsInsert] then
        begin
          frmGReg.CustomerT.FieldbyName('Cust_Id').AsInteger := DriverId;
          frmGReg.CustomerT.FieldbyName('Name').AsString := edtFNamn.text;
          frmGReg.CustomerT.FieldbyName('Adress').AsString := edtFAdress1.text;
          frmGReg.CustomerT.FieldbyName('Postal_name').AsString := edtFAdress2.text;
          frmGReg.CustomerT.FieldbyName('Org_No').AsString := edtFPNum.text;
          frmGReg.CustomerT.FieldbyName('Tel_Nr_1').AsString := edtFTel.text;
          frmGReg.CustomerT.Post;
//!        frmGReg.CustomerT.ApplyUpdates(0);
        end;
      end;
  except
    result := false;
  end;
end;

function TFrmKontrakt.CheckAllCorrect(view: ViewForm): boolean;
var
  I: Integer;
  frm: TFrmDg_Hyresman;
  ds : TADOQuery;
begin
  result := false;
  for I := 1 to 9 do
    if assigned(objArr[i]) then
    begin
      if objArr[i].FDTVFrom >= objArr[i].FDTVTo then
        raise EUserObjError.create('Fråntid måste vara mindre än tilltid', DTVFrom, I);

      if objArr[i].FedtObjId > '!' then

//!     if not LocalServer.CheckObjFree(objArr[i].FedtObjId,objArr[i].FDTVFrom,objArr[i].FDTVTO,ContrID,false) then
        if currentview <> Return then
          if not FrmSearch.CheckObjFree(objArr[i].FedtObjId, objArr[i].FDTVFrom, objArr[i].FDTVTO, ContrID, false) then
          begin
            ObjChanged := true;
            raise EUserObjError.create(objArr[i].FedtObjId + ' är inte ledig under perioden', edtObjId, I);
          end;
      if (objArr[i].FcbObjId = 0) and (objArr[i].FedtObjId < '!') then
        raise EUserObjError.create('Du måste välja objektsgrupp eller objekt', cbObjTyp, I);
    end;
  if view in [booking, contract, checkin, return] then
  begin
    SaveCustomer(Customer);
    SaveCustomer(Driver);

//!    if cbBetalning.Itemindex = 1 then //Kreditkort
//!    begin
//!      if cbCard.itemindex < 0 then
//!        raise EUserPaymentError.create('Du måste välja kontokort', cbObjTyp, 4);
//!      if edtCardNr.text = '' then
//!        raise EUserPaymentError.create('Du måste ange kontonummer', edtCardNr, 4);
//!    end;

    if view in [contract, booking] then
    begin

      if (CustId > 0) and (DriverID < 1) then
        if frmGReg.CustomerT.locate('Cust_Id', CustId, [loCaseInsensitive]) then
          if MakeInt(Copy(frmGReg.CustomerT.Fieldbyname('Org_no').AsString, 3, 2)) > 12 then
//!Fixas istf MessageDlg Ska det in en Dialog med timer
//!            if MessageDlg('Hyresmanen är ett företag och du har inte anget någon förare. Är det Ok?',
//!              mtConfirmation, [mbNo, mbYes], 0) = mrNo then
          begin
            if ShowCustCompanyTimer >= 0 then
            begin
              frm := TFrmDg_Hyresman.Create(self);
              Frm.ShowModal;
              if Frm.ModalResult = MrCancel then
              begin
                edtFPnum.SetFocus;
                abort;
              end;
              frm.Free;
            end;
          end;
    end;

  end;

  if view in [contract, checkin, return, price] then
  begin
    for I := 1 to 9 do
      if assigned(objArr[i]) then
      begin
        if (objArr[i].FedtObjId < '!') and (view <> price) then
          raise EUserObjError.create('Du måste välja objekt', edtObjId, I);
        if objArr[i].FedtPKlass < '!' then
          raise EUserObjError.create('Du måste ange prisklass', edtPKlass, I);
        if objArr[i].FcbPType < '!' then
          raise EUserObjError.create('Du måste ange pristyp', cbPristyp, I);
        if edtKm_ut.visible then //!
          if (objArr[i].FedtKM_UT < '!') and (view <> price) then
            raise EUserObjError.create('Du måste ange kilometerställning', edtKM_UT, I);
        if (objArr[i].FedtKM_BER < '!') and (view = price) then
          raise EUserObjError.create('Du måste ange beräknadkilometer', edtKM_BER, I);
      end;
  end;
  if view in [checkin, return] then
  begin
    for I := 1 to 9 do
      if assigned(objArr[i]) then
      begin
        if objArr[i].FDTVOut >= objArr[i].FDTVReturn then
        begin //!benny lagt till  Begin, Dtvret & End för att hoppa till Tilltid vid återlämning
          raise EUserObjError.create('Utlämningstiden måste vara mindre än återlämningstiden', DTVOut, I);
          DTVReturn.SetFocus; //!benny
        end; //!benny
        if objArr[i].FedtKM_IN < '!' then
          raise EUserObjError.create('Du måste ange kilometerställning', edtKM_IN, I);
        if MakeInt(objArr[i].FedtKM_IN) < MakeInt(objArr[i].FedtKM_UT) then
          raise EUserObjError.create('Du måste ange högre kilometerställning in än ut', edtKM_IN, I);
        if CustId < 1 then
          raise EUserObjError.create('Du måste ange en kund', edtHPnum, I);
      end;
    for I := 1 to length(DelLista) - 1 do
    begin
      if DelLista[i].FBetsatt='F' then
      begin
        if DelLista[i].FBetVilkor<1 then
          raise EUserObjError.create('Betalningsvilkoret måste vara > 0 dagar.', edtHPnum, 1);
      end;
    end;
  end;
  result := true;
end;

{ EUserError }

constructor EUserError.create(const Msg: string; Comp: TWinControl);
begin
  inherited create(Msg);
  CompSetFocus := Comp;
end;

procedure EUserError.SetCompSetFocus(const Value: TWinControl);
begin
  FCompSetFocus := Value;
end;

{ EUserObjError }

constructor EUserObjError.create(const Msg: string; Comp: TWinControl;
  ObjNum: integer);
begin
  inherited Create(msg, comp);
  FObjNum := ObjNum;
end;

constructor EUserPaymentError.create(const Msg: string; Comp: TWinControl;
  TabIndex: integer);
begin
  inherited Create(msg, comp);
  FTabIndexNumber := TabIndex;
end;

procedure TFrmKontrakt.edtCost4Change(Sender: TObject);
begin
  try
    if ActiveControl = edtCost4 then
      if edtCost2.text <> formatfloat('0.00', strtofloat(edtCost4.Text) / (strtofloat(edtCost5.Text) / 100 + 1) / strtofloat(edtCost1.Text)) then
        edtCost2.text := formatfloat('0.00', strtofloat(edtCost4.Text) / (strtofloat(edtCost5.Text) / 100 + 1) / strtofloat(edtCost1.Text));
  except
    edtCost2.Text := '';
  end;
end;

procedure TFrmKontrakt.BitBtn8Click(Sender: TObject);
var
  pp, I, J: Integer;
  days, km, xdays, xkm, srisk: Currency;
begin
//!010227 2rader
  frmgreg.PriceTabRowsT.close;
  frmgreg.PriceTabRowsT.Open;

  if objPanel.parent is TSGBObject then
    WriteToObject(objPanel.parent as TSGBObject);
//!
  try
    CheckAllCorrect(price);
  except
    on E: EUserError do
    begin
      if E is EUserObjError then
      begin
        ChangeObject(ObjArr[(E as EUserObjError).FObjNum]);
        ReadFromObject(ObjArr[(E as EUserObjError).FObjNum]);
      end;
      if E.CompSetFocus <> nil then
      begin
        if E.CompSetFocus.parent is TShrinkGroupBox then
          TShrinkGroupBox(E.CompSetFocus.parent).SetFocus
        else
          if E.CompSetFocus.parent.parent is TShrinkGroupBox then
            TShrinkGroupBox(E.CompSetFocus.parent.parent).SetFocus;
        E.CompSetFocus.SetFocus;
      end;
      ShowMessage(E.Message);
      exit;
    end;
  end;

  if not assigned(frmPris) then
    frmPris := TfrmPris.Create(application);
  try
    for I := 1 to 9 do
      if assigned(objArr[i]) then
      begin
        days := 0;
        km := 0;
        xdays := 0;
        xkm := 0;
        srisk := 0;
        with objArr[i] do
//!            LocalServer.GetBestPrice(FDTVFrom,FDTVTO,(Makeint(FedtKM_KORT)),FcbPType,FedtPKlass,days,km,xdays,xkm,srisk);
          FrmSearch.GetBestPrice(FDTVFrom, FDTVTO, (Makeint(FedtKM_KORT)), FcbPType, FedtPKlass, days, km, xdays, xkm, srisk);
        if not objArr[i].FchSRRed then
          srisk := 0;
        frmPris.AddObjektCostToPrice(objArr[I].FedtObjId, days, km, xdays, xkm, srisk, GetSRiskVAT);
      end;

    J := 0;
    for I := 1 to sgCost.RowCount - 1 do
      if sgCost.Cells[0, I] > '' then
      begin
        if J = 0 then
          J := frmPris.AddOtherCostsToPrice('Tillägg');
        frmPris.AddCostsToPrice(J, sgCost.Cells[0, I], strtofloat(sgCost.Cells[3, I]), strtofloat(sgCost.Cells[5, I]) / 100);
      end;

    frmPris.UpdateCosts;

    frmPris.AddPartPayer(edtHNamn.text);
    for I := 1 to length(DelLista) - 1 do
      with DelLista[i] do
      begin
        pp := frmPris.AddPartPayer(FNamn);
        frmPris.ChangePartPayer(pp, FProcent, FHyrdel, FKmDel, FMomsDel);
      end;
    frmPris.UpdateAll;

      //Visa prisbild
    if frmPris.ShowModal <> mrOk then
      exit;

  finally
    frmPris.Free;
    frmPris := nil;
  end;

end;

function TFrmKontrakt.PriceNameInList(name: string): boolean;
var
  I: Integer;
begin
  result := false;
  for I := 0 to cbPristyp.Items.count - 1 do
    if cbPristyp.Items[I] = name then
      result := true;
end;

procedure TFrmKontrakt.edtHpnumExit(Sender: TObject);
var
  str: string;
begin
  label3.Font.Color := ClBlack;
  Label8.Font.Color := ClBlack;
  if (sender as tedit).text > '!' then
  begin
    str := PNummerKoll((sender as tedit).text);
    if str <> 'false' then
      (sender as tedit).text := str
    else
    begin
      ShowMessage('Felaktigt personnummer');
    end;
    if sender = edtHPnum then
      if frmGReg.CustomerT.locate('Org_No', edtHPnum.text, []) then
      begin
        if CustId <> frmGReg.CustomerT.FieldByName('Cust_Id').AsInteger then
        begin
          LoadCustomer(frmGReg.CustomerT.FieldByName('Cust_Id').AsString);
          if (ShowCustNote>0) and (CustNoteStr<>'') then
            ShowMessage(CustNoteStr);
        end;
      end
      else
        EditCustomer(edthpnum.text); //! allt efter end har Benny Lagt till
    if sender = edtFPnum then
      if frmGReg.CustomerT.locate('Org_No', edtFPnum.text, []) then
      begin
        if DriverId <> frmGReg.CustomerT.FieldByName('Cust_Id').AsInteger then
        begin
          LoadDriver(frmGReg.CustomerT.FieldByName('Cust_Id').AsString);
          if (ShowCustNote>0) and (CustNoteStr<>'') then
            ShowMessage(CustNoteStr);
        end;
      end
      else
        EditDriver(EdtFpNum.text); //! allt efter end har Benny Lagt till
  end;

end;

procedure TFrmKontrakt.edtHadress2Change(Sender: TObject);
begin
  edtHAdress2.text := GetPostOrt(edtHAdress2.text);
  edtHNamnChange(sender);
  EdtHtel.Text := StrRikt;
end;

procedure TFrmKontrakt.edtFAdress2Change(Sender: TObject);
begin
  edtFAdress2.text := GetPostOrt(edtFAdress2.text);
  edtFNamnChange(sender);
end;

procedure TFrmKontrakt.CustomerSGB1Click(Sender: TObject);
begin
  if CustomerSGB1.IsOpen then
    edtHPNum.SetFocus;
end;

procedure TFrmKontrakt.DriverSGB1Click(Sender: TObject);
begin
  if DriverSGB1.IsOpen then
    edtFPNum.SetFocus;
end;

function TFrmKontrakt.IsInternKund(CuiD: integer; var Konto: integer; var KStalle: integer): boolean;
begin
  result := true;
  try
    frmSearch.GSQLString := 'Select Customer.name, Customer.Org_no, Customer.Int_Cust, Customer.KundFdrKonto, Customer.IKStalle from Customer Where Cust_id = ' + inttostr(cuid);
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
      begin
        result := fieldbyname('Int_Cust').AsBoolean;
        if result then
        begin
          Konto := fieldbyname('KundFdrKonto').AsInteger;
          KStalle := fieldbyname('IKStalle').AsInteger;
        end;
      end;
  except
    result := false;
  end;
end;

procedure TFrmKontrakt.cbBetalningExit(Sender: TObject);
var
  konto, kstalle: integer;
begin
  Label29.Font.Color := ClBlack;
  if PayAlts[cbBetalning.itemindex].code = 'I' then
    if not IsInternKund(CustId, Konto, Kstalle) then
    begin
      MessageDlg('Kunden är ej en internkund?', mtConfirmation, [mbOK], 0);
      (Sender as TCombobox).SetFocus;
    end
    else
      pnlBetVillkor.caption := '0';
   if Length(DelLista)>0 then
     Dellista[0].FBetsatt := PayAlts[cbBetalning.itemindex].code;

  if PayAlts[cbBetalning.itemindex].code = 'F' then
  begin
    if edtHpnum.Tag=1 then
    begin
      ShowMessage('INFO! Fakturakund kan inte vara markerad som utländsk!');
    end
    else
    begin
      if Not PNummerOK(edtHpnum.Text) then
        ShowMessage('INFO! Kundens Pers/Org nr är inte korrekt för att vara fakturakund!');
    end;
  end;
end;

procedure TFrmKontrakt.DeleteInvoicePayer(Kid: string);
var
  I, num: integer;
begin

  num := -1;
  for I := 0 to length(invoiceArr) - 1 do
    if invoiceArr[I].Kid = KId then
      num := I;
  if num >= 0 then
  begin
    for I := num to length(invoiceArr) - 2 do
      invoiceArr[I] := invoiceArr[I + 1];
    SetLength(invoiceArr, length(invoiceArr) - 1);
  end;
end;

procedure TFrmKontrakt.UpdateInvoicePayer(SubId: integer; Kid, KNamn, FNamn, Att, Kom1, kom2: string);
var
  I, num: integer;
begin
  num := -1;
  for I := 0 to length(invoiceArr) - 1 do
    if invoiceArr[I].Kid = KId then
      num := I;
  if (num < 0) and (Kid > '') then
  begin
    num := length(invoiceArr);
    SetLength(invoiceArr, num + 1);
  end;
  if Kid > '' then
  begin
    invoiceArr[num].KID := Kid;
    if SubId >= 0 then
      invoiceArr[num].FaktSubId := SubId;
    if KNamn > '' then
      invoiceArr[num].KNamn := KNamn;
    if FNamn > '' then
      invoiceArr[num].FNamn := FNamn;
    if Att > '' then
      invoiceArr[num].Attention := Att;
    if Kom1 > '' then
      invoiceArr[num].Kom1 := Kom1;
    if Kom2 > '' then
      invoiceArr[num].Kom2 := Kom2;
  end;
end;

procedure TFrmKontrakt.StringGrid1Click(Sender: TObject);
begin
  btnChangeDel.Enabled := StringGrid1.Selection.Top > 1;
  btnDeleteDel.Enabled := StringGrid1.Selection.Top > 1;
end;

procedure TFrmKontrakt.FaktNotClick(Sender: TObject);
begin
  SparaFaktNot;
  VisaFaktNot(cbFaktKId.Text);
end;

procedure TFrmKontrakt.SparaFaktNot;
begin
  if FaktIndex >= 0 then
    with TFakturaNotering(InvoiceArr[FaktIndex]) do
    begin
      Attention := edtAtt.Text;
      Kom1 := edtFaktNot1.Text;
      Kom2 := edtFaktNot2.Text;
    end;
end;

procedure TFrmKontrakt.FaktNotToKontr;
var I: Integer;
begin
  try
    if length(InvoiceArr) > 0 then
    begin
      SparaFaktNot;
      for I := 0 to length(InvoiceArr) - 1 do
        with TFakturaNotering(InvoiceArr[I]) do
          if (Attention > '') or (Kom1 > '') or (Kom2 > '') then
//!            LocalServer.SavePartNote(FaktSubId, MakeInt(Kid), Attention, Kom1, Kom2);
            FrmSearch.SavePartNote(FaktSubId, MakeInt(Kid), Attention, Kom1, Kom2);
    end;
  except
    on E: Exception do ShowMessage(e.message);
  end;
end;

procedure TFrmKontrakt.KontrToFaktNot(ContrId: integer);
var
  I: Integer;
  SubIds: array of Integer;
begin
  SetLength(SubIds, 0);
  frmSearch.GSQLString := 'SELECT [Contr_Sub].ContrId, [Contr_SubNot].* FROM [Contr_Sub] LEFT JOIN [Contr_SubNot] ON [Contr_Sub].SubId = [Contr_SubNot].SubID Where ContrId = ' + inttostr(ContrId);
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      while not EOF do
      begin
        UpdateInvoicePayer(
          fieldbyname('SubId').AsInteger,
          fieldbyname('Kid').AsString, '', '',
          fieldbyname('FaktAtt').AsString,
          fieldbyname('FaktNot1').AsString,
          fieldbyname('FaktNot2').AsString);
        next;
      end;
    end;
  UpdateCbFaktDelId;
end;

procedure TFrmKontrakt.VisaFaktNot(inKid: string);
var I, J: Integer;
begin
  I := 0;
  if inKid <> '' then
  begin
    for J := 0 to length(InvoiceArr) - 1 do
      if TFakturaNotering(InvoiceArr[J]).Kid = inKid then
        I := J;
  end;
  if length(InvoiceArr) > I then
    with TFakturaNotering(InvoiceArr[i]) do
    begin
      if inKid = '' then
        cbFaktKid.ItemIndex := i;
//        cbFaktKId.Text := Kid;
//      if FNamn > '!' then
//        Label30.caption := 'Förare : ' + FNamn
//      else
//        Label30.caption := '';
      Label33.caption := KNamn;
//      Label33.caption := KID;
      edtAtt.Text := Attention;
      edtFaktNot1.Text := Kom1;
      edtFaktNot2.Text := Kom2;
    end;
  FaktIndex := I;
end;

procedure TFrmKontrakt.UpdateCbFaktDelId;
var I: Integer;
begin
  cbFaktKId.Clear;
  if length(InvoiceArr) > 0 then
  begin
    for I := 0 to length(InvoiceArr) - 1 do
      cbFaktKId.Items.Add(TFakturaNotering(InvoiceArr[I]).KId);
    VisaFaktNot('');
  end;
  TabInvoice.TabVisible := Length(InvoiceArr) > 0;
end;

procedure TFrmKontrakt.UpdateKidFaktNot(KID: integer; Betkod: string);
var
  KNamn: string;
begin
  if (BetKOD = 'F') or (BetKOD = 'U') then
  begin
    frmSearch.GSQLString := 'Select Customer.name, Customer.Adress, Customer.Postal_name, Customer.Tel_nr_1, Customer.Org_no, Customer.Payment, Customer.Terms_pay, Customer.Ins_comp from Customer Where Cust_id = ' + inttostr(Kid);
    if frmSearch.GetSearchResult then
      with frmSearch.GSearchCDS do
        Knamn := fieldbyname('Name').AsString + ', ' + ConcatCustInfo(fieldbyname('Org_no').AsString, fieldbyname('Adress').AsString, fieldbyname('Postal_name').AsString, fieldbyname('Tel_Nr_1').AsString, '');
    UpdateInvoicePayer(0, inttostr(KID), Knamn, '', '', '', '');
  end
  else
    DeleteInvoicePayer(inttostr(KID));
  UpdateCbFaktDelId;
end;

procedure TFrmKontrakt.cbFaktKidClick(Sender: TObject);
begin
  FaktNotClick(sender);
end;

procedure TFrmKontrakt.SpeedButton2Click(Sender: TObject);
begin
  frmmain.UpdFormLang(Self, 'Swe');
end;

procedure TFrmKontrakt.edtKM_INKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then DrvMCount(edtObjId.text);
end;

procedure TFrmKontrakt.DrvMCount(Regnr: string);
var m: Real;
  i, k: integer;
  x: string;
begin
  frmgreg.ObjectsT.First;
  if frmgreg.ObjectsT.locate('Reg_No', RegNr, [locaseinsensitive]) then
    x := frmgreg.ObjectsT.FieldByName('DType').asstring;

  k := cbcost1.Items.Count;
  for i := 0 to k - 1 do
  begin
    if cbcost1.Items.Strings[i] = x then
    begin
      edtCost2.text := formatFloat('0.00', costs[i].FPrice);
      edtCost5.text := formatFloat('0.#', costs[i].FMoms * 100);
      edtCost6.text := costs[i].FKonto;
      edtCost7.text := costs[i].FKStalle;
      break;
    end;
  end;

  cbcost1.Text := frmgreg.ObjectsT.FieldByName('DType').asstring;
  m := frmgreg.ObjectsT.fieldbyname('Drvm_km').AsFloat * strtofloat(edtkm_kort.Text);

  PageControl1.ActivePage := tabcosts;
  edtcost1.Text := formatfloat('0.00', m);
  edtcost1.setfocus;
end;

procedure TFrmKontrakt.DTVToExit(Sender: TObject);
begin
  dtvto.Font.Color := ClBlack;
  if currentview = return then
  begin
    if edtKm_in.visible then
      EdtKm_in.SetFocus;
    if DtvReturn.visible then
      if dtvto.DateTime < now then
        dtvreturn.DateTime := DTVTo.DateTime else
        dtvreturn.DateTime := now;
  end;
end;

procedure TFrmKontrakt.GetCdrDef;
begin

end;

procedure TFrmKontrakt.RBEgenMOmsClick(Sender: TObject);
begin
  MomsCountConst := 2;
end;

procedure TFrmKontrakt.RBTotalMOmsClick(Sender: TObject);
begin
  MomsCountConst := 1;
end;

function TFrmKontrakt.SearchDriver(str: string): boolean;
var test, SeekStr: string;
begin
  Test := '%';
  result := false;
  if length(str) > 1 then
  begin
    str := AnsiUppercase(str);
    frmSearch.SSQLString := SQLDriver;
    seekstr := stringreplace(str, '*', '%', [rfReplaceAll]);
    if (str[2] >= '0') and (str[2] <= '9') then
    begin
      frmSearch.caption := 'Sökresultat Pers/Org Nr';
      frmSearch.SSQLString := frmSearch.SSQLString + ' Where org_no like ''' + seekstr + '%''';
      frmSearch.SSQLString := frmSearch.SSQLString + ' ORDER BY org_no';

    end
    else
    begin
      frmSearch.caption := 'Sökresultat Namn';
      frmSearch.SSQLString := frmSearch.SSQLString + ' Where name like ''' + seekstr + '%''';
//!      frmSearch.SSQLString := frmSearch.SSQLString + ' where name >= ''' + str + '*''';
//      frmSearch.SSQLString := frmSearch.SSQLString + ' where name like ''' + str + '*'' order by name';
      frmSearch.SSQLString := frmSearch.SSQLString + ' ORDER BY name';
    end;
    result := frmSearch.ShowSearchResult;
  end
  else
  begin
//!    ShowMessage('Skriv namn eller kundid (minst 2 tecken)');
    frmSearch.SSQLString := SQLDriver;
    frmSearch.caption := 'Sökresultat KundNr';
    frmSearch.SSQLString := frmSearch.SSQLString + ' Where name like ''' + test + '%''';
    result := frmSearch.ShowSearchResult;
  end;

end;

procedure TFrmKontrakt.ChangeDelbetBaz(delid, Kontridbaz: string);
begin
  dmod.ADOQuery1.sql.text := 'DELETE Contr_Sub.SubId, Contr_Sub.SubName, Contr_Sub.ContrId, Contr_Sub.ENummer, Contr_Sub.SubCustId, Contr_Sub.Contact, Contr_Sub.SpPercent, Contr_Sub.SpRule_Rent, Contr_Sub.SpRule_KM, Contr_Sub.SpRule_Vat, Contr_Sub.Payment, Contr_Sub.Terms_Pay,';
  dmod.ADOQuery1.sql.text := dmod.ADOQuery1.sql.text + ' Contr_Sub.Status, Contr_Sub.Print_Date, Contr_Sub.ForfalloDat FROM Contr_Sub WHERE (((Contr_Sub.SubCustId)=' + delid + '));';
end;

procedure TFrmKontrakt.edtHNamnEnter(Sender: TObject);
begin
  label1.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtHNamnExit(Sender: TObject);
begin
  label1.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtHadress1Exit(Sender: TObject);
begin
  label2.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtHadress1Enter(Sender: TObject);
begin
  label2.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtHpnumEnter(Sender: TObject);
begin
  label3.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtHtelEnter(Sender: TObject);
begin
  label4.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtHtelExit(Sender: TObject);
begin
  label4.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtFpnumEnter(Sender: TObject);
begin
  Label8.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtFtelEnter(Sender: TObject);
begin
  Label9.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtFtelExit(Sender: TObject);
begin
  Label9.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtFNamnExit(Sender: TObject);
begin
  Label6.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtFNamnEnter(Sender: TObject);
begin
  Label6.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtFAdress1Enter(Sender: TObject);
begin
  Label5.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtFAdress1Exit(Sender: TObject);
begin
  Label5.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtRefEnter(Sender: TObject);
begin
  Label28.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtRefExit(Sender: TObject);
begin
  Label28.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.cbBetalningEnter(Sender: TObject);
begin
  Label29.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.CheckDeladEnter(Sender: TObject);
begin
  checkdelad.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.CheckDeladExit(Sender: TObject);
begin
  checkdelad.font.color := clBlack;
end;

procedure TFrmKontrakt.edtDepositEnter(Sender: TObject);
begin
  LblDeposit.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtDepositExit(Sender: TObject);
begin
  LblDeposit.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.cbObjtypEnter(Sender: TObject);
begin
  Label7.font.color := ClBlue;
end;

procedure TFrmKontrakt.cbObjtypExit(Sender: TObject);
begin
  Label7.font.color := ClBlack;
end;

procedure TFrmKontrakt.DTVFromEnter(Sender: TObject);
begin
  dtvfrom.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.DTVFromExit(Sender: TObject);
begin
  dtvfrom.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.DTVToEnter(Sender: TObject);
begin
  dtvto.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtObjIdEnter(Sender: TObject);
begin
  label23.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtDragBilEnter(Sender: TObject);
begin
  label27.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtDragBilExit(Sender: TObject);
begin
  label27.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtPKlassEnter(Sender: TObject);
begin
  label25.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtPKlassExit(Sender: TObject);
begin
  label25.Font.Color := ClBlack;
  SetObjSummary;
end;

procedure TFrmKontrakt.edtKM_INEnter(Sender: TObject);
begin
  label15.Font.Color := ClBlue;
  if PageControl1.ActivePage = tabCosts then
    BitBtn2.Default := False;
end;

procedure TFrmKontrakt.edtKM_INExit(Sender: TObject);
begin
  label15.Font.Color := ClBlack;
  SetObjSummary;
  if PageControl1.ActivePage = tabCosts then
    BitBtn2.Default := True;

end;

procedure TFrmKontrakt.cbPristypEnter(Sender: TObject);
begin
  LblPtyp.Font.color := ClBlue;
end;

procedure TFrmKontrakt.cbPristypExit(Sender: TObject);
begin
  LblPTyp.font.color := ClBlack;
  SetObjSummary;
end;

procedure TFrmKontrakt.edtKM_KORTEnter(Sender: TObject);
begin
  label34.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtKM_KORTExit(Sender: TObject);
begin
  label34.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtKM_BEREnter(Sender: TObject);
begin
  label10.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.edtKM_BERExit(Sender: TObject);
begin
  label10.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.chSRRedEnter(Sender: TObject);
begin
  chSRRed.font.color := ClBlue;
end;

procedure TFrmKontrakt.chSRRedExit(Sender: TObject);
begin
  chSRRed.font.color := ClBlack;
end;

procedure TFrmKontrakt.DTVOutEnter(Sender: TObject);
begin
  DTVOut.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.DTVOutExit(Sender: TObject);
begin
  DTVOut.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.DTVReturnEnter(Sender: TObject);
begin
  DTVReturn.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.DTVReturnExit(Sender: TObject);
begin
  DTVReturn.Font.Color := ClBlack;
end;

procedure TFrmKontrakt.edtKnot1Enter(Sender: TObject);
begin
  label40.font.color := ClBlue;
  label41.font.color := ClBlue;
end;

procedure TFrmKontrakt.edtKnot1Exit(Sender: TObject);
begin
  label40.font.color := ClBlAck;
  label41.font.color := ClBlAck;
end;

procedure TFrmKontrakt.edtInot1Exit(Sender: TObject);
begin
  label42.font.color := ClBlAck;
  label43.font.color := ClBlAck;
end;

procedure TFrmKontrakt.edtInot1Enter(Sender: TObject);
begin
  label42.font.color := ClBlue;
  label43.font.color := ClBlue;
end;

procedure TFrmKontrakt.edtInot2Enter(Sender: TObject);
begin
  label42.font.color := ClBlue;
  label43.font.color := ClBlue;
end;

procedure TFrmKontrakt.edtInot2Exit(Sender: TObject);
begin
  label42.font.color := ClBlack;
  label43.font.color := ClBlack;
end;

function TFrmKontrakt.GetEnum(Txt: string; Val: Boolean): integer;
begin
{
   if not val then
   Begin
      if Txt= 'K' then
      begin
        result := dmod.ParamT.fieldbyname('Knotenr').asinteger + 1;
        dmod.ParamT.edit;
        dmod.ParamT.fieldbyname('Knotenr').asinteger := Enum;
        dmod.ParamT.Post;
      end;
      if Txt = 'O' then
      begin
        Result := dmod.ParamT.fieldbyname('FBolagNr').asinteger + 1;
        dmod.ParamT.edit;
        dmod.ParamT.fieldbyname('FBolagNr').asinteger := Enum;
        dmod.ParamT.Post;
      end;
      if Txt= 'F' then
      begin
        Result := dmod.ParamT.fieldbyname('FaktNr').asinteger + 1;
        dmod.ParamT.edit;
        dmod.ParamT.fieldbyname('FaktNr').asinteger := Enum;
        dmod.ParamT.Post;
      end;
      if Txt = 'I' then
      begin
        Result := dmod.ParamT.fieldbyname('InternNr').asinteger + 1;
        dmod.ParamT.edit;
        dmod.ParamT.fieldbyname('InternNr').asinteger := Enum;
        dmod.ParamT.Post;
      end;
   End else
  result:=0;
 }
end;

procedure TFrmKontrakt.checkDelfaktEnter(Sender: TObject);
begin
  checkDelfakt.Font.Color := ClBlue;
end;

procedure TFrmKontrakt.checkDelfaktExit(Sender: TObject);
begin
  checkDelfakt.Font.Color := clBlack;
end;

procedure TFrmKontrakt.checkDelfaktClick(Sender: TObject);
begin
  if checkDelfakt.Checked then
  begin
    tabDelFakt.TabVisible := true;
  end
  else
  begin
    tabDelFakt.TabVisible := false;
  end;
end;

procedure TFrmKontrakt.edDF_StartDatumKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Stepping : Integer;
begin
  Stepping := 1;
  if Shift=[ssCtrl] then Stepping :=7;
  if Shift=[ssShift] then Stepping :=30;
    if Key=VK_UP then
    begin
       try
         TEQDateEdit(Sender).Text := DateToStr(StrToDate(TEQDateEdit(Sender).Text)+Stepping);
       except
         TEQDateEdit(Sender).Text := DateToStr(Now);
       end;
       key:=0;
    end;
    if Key=VK_DOWN then
    begin
       try
         TEQDateEdit(Sender).Text := DateToStr(StrToDate(TEQDateEdit(Sender).Text)-Stepping);
       except
         TEQDateEdit(Sender).Text := DateToStr(Now);
       end;
       key:=0;
    end;
end;

initialization

  ShowFreeOnly := True;

end.

