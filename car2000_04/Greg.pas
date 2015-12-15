{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Greg.pas
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
{ $Log:  14850: Greg.pas
{
{   Rev 1.6    2008-06-27 13:33:44  Henry
{ Lagt till hantering av stationer
{
}
{   Rev 1.5    2006-02-18 13:33:48  pb64
}
{
{   Rev 1.4    2005-04-28 16:03:54  pb64
{ Ändrat insert till append
}
{
{   Rev 1.3    2005-02-14 16:13:38  pb64
{ infört visning av debuginfo
}
{
{   Rev 1.2    2005-02-08 21:14:14  pb64
{ Implementerat hantering för Cardirect seriell kommunikation.
}
{
{   Rev 1.1    2004-10-26 15:47:50  pb64
}
{
{   Rev 1.0    2004-08-18 11:00:56  pb64
{ Start inför införande av kontraktsfakturering.
{
}
{
{   Rev 1.2    2004-08-13 09:11:04  pb64
}
{
{   Rev 1.1    2004-01-28 13:36:06  peter
}
{
{   Rev 1.0    2003-03-20 14:00:26  peter
}
{
{   Rev 1.0    2003-03-17 14:41:44  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:58  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:24  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
// Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
// Skapad: 1997-02-07 10:57:54                                   //
// Noteringar :                                                   //
// Historia :                                                     //
// Uppföljd 0003 Benny Lauridsen                                  //
////////////////////////////////////////////////////////////////////
unit GReg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, DBCtrls, DB, DBTables, Mask, Menus, Dialogs,
  DBClient, Grids, DBGrids, ADODB, inifiles, ToolWin, ImgList,
  TransBtn2;

type
  TfrmGReg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    tab1: TPageControl;
    tbCustomers: TTabSheet;
    tbObjects: TTabSheet;
    BitBtn3: TBitBtn;
    ObjectsS: TDataSource;
    SpeedButton1: TSpeedButton;
    CustomerS: TDataSource;
    tbBlock: TTabSheet;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    DBNavigator9: TDBNavigator;
    DBEdit107: TDBEdit;
    DBEdit108: TDBEdit;
    DBEdit109: TDBEdit;
    DBEdit110: TDBEdit;
    DBEdit111: TDBEdit;
    DBEdit112: TDBEdit;
    DBEdit113: TDBEdit;
    DBEdit114: TDBEdit;
    DBEdit115: TDBEdit;
    CardsS: TDataSource;
    ObjTypeS: TDataSource;
    PriceTabS: TDataSource;
    SignrS: TDataSource;
    DrivMS: TDataSource;
    TtypS: TDataSource;
    CostsS: TDataSource;
    PriceTabRowsS: TDataSource;
    CardsT: TADOTable;
    ObjectsT: TADOTable;
    CustomerT: TADOTable;
    ObjTypeT: TADOTable;
    PriceTabT: TADOTable;
    SignrT: TADOTable;
    TtypT: TADOTable;
    DrivMT: TADOTable;
    CostsT: TADOTable;
    PriceTabRowsT: TADOTable;
    Q1: TADOQuery;
    CardsTTyp: TWideStringField;
    CardsTTypNamn: TWideStringField;
    CardsTPreNr: TIntegerField;
    CardsTCheck: TWideStringField;
    CardsTTelNr: TWideStringField;
    PriceTabTPriceId: TAutoIncField;
    PriceTabTPKLASS: TWideStringField;
    PriceTabTPTYP: TWideStringField;
    PriceTabTFDAT: TDateField;
    PriceTabTPNAMN: TWideStringField;
    PriceTabTTDAT: TDateField;
    PriceTabTSR_DYGN: TFloatField;
    PriceTabTSR_DAG1: TFloatField;
    PriceTabTSR_MAX1: TFloatField;
    PriceTabTSR_DAG2: TFloatField;
    PriceTabTSR_MAX2: TFloatField;
    PriceTabTSR_OVERDYGN: TFloatField;
    PriceTabTPRIS_TIM: TFloatField;
    PriceTabTKOST_TIM: TFloatField;
    PriceTabTSRiskKonto: TIntegerField;
    PriceTabTHyrKonto: TIntegerField;
    PriceTabTKmKonto: TIntegerField;
    PriceTabTXHyrKonto: TIntegerField;
    PriceTabTXKmKonto: TIntegerField;
    PriceTabTTimKonto: TIntegerField;
    PriceTabTInkMoms: TBooleanField;
    PriceTabTPriceInfo: TMemoField;
    PriceTabTCdr_Def: TBooleanField;
    SignrTSIGN: TWideStringField;
    SignrTNAMN: TWideStringField;
    SignrTC_O_ADR: TWideStringField;
    SignrTADRESS: TWideStringField;
    SignrTPNR: TWideStringField;
    SignrTORT: TWideStringField;
    SignrTPERS_NR: TWideStringField;
    SignrTTEL_1: TWideStringField;
    SignrTTEL_NR_1: TWideStringField;
    SignrTTEL_2: TWideStringField;
    SignrTTEL_NR_2: TWideStringField;
    SignrTPROVIS_D: TFloatField;
    SignrTPROVIS_P: TFloatField;
    SignrTAVD: TWideStringField;
    SignrTKAT: TWideStringField;
    SignrTKTJ_GRP: TWideStringField;
    SignrTKSTLLE: TFloatField;
    SignrTPassword: TWideStringField;
    SignrTPwd_sign: TWideStringField;
    TtypTTeletyp: TWideStringField;
    TtypTTelebeskrivning: TWideStringField;
    DrivMTID: TWideStringField;
    DrivMTNamn: TWideStringField;
    DrivMTKostnad: TBCDField;
    CostsTCost_ID: TAutoIncField;
    CostsTCostname: TWideStringField;
    CostsTNo: TFloatField;
    CostsTPrice: TBCDField;
    CostsTVAT: TFloatField;
    CostsTAcc_code: TIntegerField;
    CostsTAcc_center: TIntegerField;
    Q2Cust: TADOQuery;
    Q3PKlass: TADOQuery;
    PriceTabRowsTPriceId: TIntegerField;
    PriceTabRowsTRowNum: TIntegerField;
    PriceTabRowsTMINDAG: TSmallintField;
    PriceTabRowsTPRISDAG: TSmallintField;
    PriceTabRowsTKOST: TBCDField;
    PriceTabRowsTINKL_KM: TSmallintField;
    PriceTabRowsTOVERKM: TFloatField;
    PriceTabRowsTXDYGN: TSmallintField;
    PriceTabRowsTXINKLKM: TFloatField;
    PaKund: TPanel;
    Label12: TLabel;
    edtKNamn: TDBEdit;
    Label11: TLabel;
    DBEdit12: TDBEdit;
    Label14: TLabel;
    edtKAdr1: TDBEdit;
    edtKAdr2: TDBEdit;
    edtKPAdr: TDBEdit;
    edtKLand: TDBEdit;
    Label15: TLabel;
    cbTele1: TDBComboBox;
    cbTele2: TDBComboBox;
    cbTele3: TDBComboBox;
    cbIKund: TDBCheckBox;
    edtKKonto: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtKKStalle: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit19: TDBEdit;
    Label16: TLabel;
    edtKID: TDBEdit;
    Label13: TLabel;
    edtKPersNr: TDBEdit;
    Label64: TLabel;
    meKund: TDBMemo;
    Label17: TLabel;
    cbCards: TDBComboBox;
    Label63: TLabel;
    Label66: TLabel;
    cbBetalning: TDBComboBox;
    DBEdit9: TDBEdit;
    edtCreditNo: TDBEdit;
    Label4: TLabel;
    DBKexp: TDBEdit;
    Label65: TLabel;
    DBEdit10: TDBEdit;
    SpeedButton2: TSpeedButton;
    cbUtlandsk: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    PaObj: TPanel;
    Label18: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label28: TLabel;
    Label33: TLabel;
    GroupBox1: TGroupBox;
    DBMemo2: TDBMemo;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit18: TDBEdit;
    Label21: TLabel;
    DBEdit23: TDBEdit;
    cbObjTyp: TDBLookupComboBox;
    DBEdit21: TDBEdit;
    DBEdit28: TDBEdit;
    Label3: TLabel;
    EdtDrvm_km: TDBEdit;
    DBEdit29: TDBEdit;
    Label25: TLabel;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    Label29: TLabel;
    cbBensin: TDBComboBox;
    Label30: TLabel;
    DBEdit33: TDBEdit;
    cbPClass: TDBComboBox;
    Label32: TLabel;
    Label31: TLabel;
    DBEdit37: TDBEdit;
    DBEdit34: TDBEdit;
    Label34: TLabel;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    PaObjG: TPanel;
    DBGrid2: TDBGrid;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    BtnFirst: TSpeedButton;
    BtnMinEn: TSpeedButton;
    BtnPlusen: TSpeedButton;
    BtnLast: TSpeedButton;
    BtnNew: TSpeedButton;
    BtnDel: TSpeedButton;
    BtnSave: TSpeedButton;
    BtnCan: TSpeedButton;
    BtnUpd: TSpeedButton;
    BtnFilter: TSpeedButton;
    BtnASC: TSpeedButton;
    BtnDESC: TSpeedButton;

    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
//    Speedbutton3: TTransparentButton2;
    Speedbutton3: TSpeedButton;
    DBCheckBox2: TDBCheckBox;
    PaKundG: TPanel;
    DBGrid1: TDBGrid;
    BtnTotRecNo: TEdit;
    BtnRecNo: TEdit;
    Timer1: TTimer;
    Label8: TLabel;
    edtLang: TDBEdit;
    Label9: TLabel;
    DBEdit4: TDBEdit;
    Label10: TLabel;
    DBEdit5: TDBEdit;
    StationT: TADOTable;
    StationS: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Label22: TLabel;
    btnChangeStation: TButton;
    StationChangeT: TADOTable;
    StationChangeS: TDataSource;
    DBCheckBox3: TDBCheckBox;
    procedure AddKund;
    procedure CheckIntern;
    procedure FillCombos;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CustomerTBeforePost(DataSet: TDataSet);
    procedure CustomerTAfterInsert(DataSet: TDataSet);
    procedure cbUtlandskClick(Sender: TObject);
    procedure DBMemo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBNavigator3BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure DBNavigator4BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure DBEdit12Exit(Sender: TObject);
    procedure DBEdit13Enter(Sender: TObject);
    procedure tbCustomersEnter(Sender: TObject);
    procedure CustomerTAfterScroll(DataSet: TDataSet);
    procedure DBLookupComboBox5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBComboBox8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtKPersNrExit(Sender: TObject);
    procedure cbIKundClick(Sender: TObject);
    procedure CustomerTReconcileError(DataSet: TClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtKPAdrChange(Sender: TObject);
    procedure DBEdit46Change(Sender: TObject);
    procedure ObjectsTAfterInsert(DataSet: TDataSet);
    procedure cbObjTypKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ObjTypeTAfterInsert(DataSet: TDataSet);
    procedure CardsTAfterPost(DataSet: TDataSet);
    procedure CardsTAfterCancel(DataSet: TDataSet);
    procedure PriceTabRowsTBeforeInsert(DataSet: TDataSet);
    procedure PriceTabRowsTAfterInsert(DataSet: TDataSet);
    procedure PriceTabTBeforeInsert(DataSet: TDataSet);
    procedure PriceTabTAfterScroll(DataSet: TDataSet);
    procedure PriceTabTAfterPost(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure tab1Change(Sender: TObject);
    procedure DBEdit23Enter(Sender: TObject);
    procedure DBEdit21Exit(Sender: TObject);
    procedure edtKNamnExit(Sender: TObject);
    procedure edtKAdr2Exit(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BtnFirstClick(Sender: TObject);
    procedure BtnMinEnClick(Sender: TObject);
    procedure BtnPlusenClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCanClick(Sender: TObject);
    procedure BtnUpdClick(Sender: TObject);
    procedure BtnFilterClick(Sender: TObject);
    procedure BtnASCClick(Sender: TObject);
    procedure BtnDESCClick(Sender: TObject);
    procedure edtKNamnEnter(Sender: TObject);
    procedure DBEdit12Enter(Sender: TObject);
    procedure edtKIDEnter(Sender: TObject);
    procedure edtKPersNrEnter(Sender: TObject);
    procedure edtKAdr1Enter(Sender: TObject);
    procedure edtKAdr2Enter(Sender: TObject);
    procedure edtKPAdrEnter(Sender: TObject);
    procedure edtKLandEnter(Sender: TObject);
    procedure meKundEnter(Sender: TObject);
    procedure cbTele1Enter(Sender: TObject);
    procedure DBEdit19Enter(Sender: TObject);
    procedure cbTele2Enter(Sender: TObject);
    procedure DBEdit20Enter(Sender: TObject);
    procedure cbTele3Enter(Sender: TObject);
    procedure DBEdit22Enter(Sender: TObject);
    procedure cbIKundEnter(Sender: TObject);
    procedure cbCardsEnter(Sender: TObject);
    procedure edtCreditNoEnter(Sender: TObject);
    procedure DBEdit9Enter(Sender: TObject);
    procedure DBKexpEnter(Sender: TObject);
    procedure cbBetalningEnter(Sender: TObject);
    procedure DBEdit10Enter(Sender: TObject);
    procedure edtKKontoEnter(Sender: TObject);
    procedure edtKKStalleEnter(Sender: TObject);
    procedure edtKAdr1Exit(Sender: TObject);
    procedure edtKPAdrExit(Sender: TObject);
    procedure edtKLandExit(Sender: TObject);
    procedure cbTele1Exit(Sender: TObject);
    procedure DBEdit19Exit(Sender: TObject);
    procedure cbTele2Exit(Sender: TObject);
    procedure edtKIDExit(Sender: TObject);
    procedure meKundExit(Sender: TObject);
    procedure cbCardsExit(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure DBKexpExit(Sender: TObject);
    procedure cbBetalningExit(Sender: TObject);
    procedure DBEdit10Exit(Sender: TObject);
    procedure cbIKundExit(Sender: TObject);
    procedure edtKKontoExit(Sender: TObject);
    procedure edtKKStalleExit(Sender: TObject);
    procedure DBEdit18Enter(Sender: TObject);
    procedure cbObjTypEnter(Sender: TObject);
    procedure DBEdit21Enter(Sender: TObject);
    procedure DBEdit28Enter(Sender: TObject);
    procedure DBEdit29Enter(Sender: TObject);
    procedure DBEdit31Enter(Sender: TObject);
    procedure DBEdit34Enter(Sender: TObject);
    procedure EdtDrvm_kmEnter(Sender: TObject);
    procedure DBEdit30Enter(Sender: TObject);
    procedure cbBensinEnter(Sender: TObject);
    procedure DBEdit33Enter(Sender: TObject);
    procedure cbPClassEnter(Sender: TObject);
    procedure DBEdit37Enter(Sender: TObject);
    procedure DBEdit35Enter(Sender: TObject);
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit2Enter(Sender: TObject);
    procedure DBEdit3Enter(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBEdit18Exit(Sender: TObject);
    procedure cbObjTypExit(Sender: TObject);
    procedure DBEdit28Exit(Sender: TObject);
    procedure DBEdit29Exit(Sender: TObject);
    procedure DBEdit31Exit(Sender: TObject);
    procedure DBEdit34Exit(Sender: TObject);
    procedure cbBensinExit(Sender: TObject);
    procedure DBEdit23Exit(Sender: TObject);
    procedure EdtDrvm_kmExit(Sender: TObject);
    procedure DBEdit30Exit(Sender: TObject);
    procedure DBEdit33Exit(Sender: TObject);
    procedure cbPClassExit(Sender: TObject);
    procedure DBEdit37Exit(Sender: TObject);
    procedure DBEdit35Exit(Sender: TObject);
    procedure cbUtlandskEnter(Sender: TObject);
    procedure cbUtlandskExit(Sender: TObject);
    procedure DBCheckBox1Enter(Sender: TObject);
    procedure DBCheckBox1Exit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CustomerSStateChange(Sender: TObject);
    procedure ObjectsSStateChange(Sender: TObject);
    procedure ObjectsTAfterScroll(DataSet: TDataSet);
    procedure Timer1Timer(Sender: TObject);
    procedure edtLangEnter(Sender: TObject);
    procedure edtLangExit(Sender: TObject);
    procedure btnChangeStationClick(Sender: TObject);
  private
    LastSender: TObject;
    dataChanged: boolean;
    LastRow: Integer;
    procedure DoGRegSearch(Cont: TDBEdit);
    procedure FixStr(sender: TDBEdit);
    procedure FixRaknare;
    { Private declarations }
  public
    function GetObject(OId: string): boolean;
    function GetCustomer(CustId: integer): boolean;
    { Public declarations }
  end;

var
  frmGReg: TfrmGReg;
  Notesstop, StopHere: Boolean;
  search: string;

implementation

uses search, main, tmpdata, funcs, bgmain, Reconcil, DataSession,
  Datamodule, dlgStationChange;
{$R *.DFM}

function IsSearchField(Sender: TObject): Boolean;
begin
  result := false;
  if (sender is TDBEdit) then
    if ((sender as TDBEdit).name = 'DBEdit11') or
      ((sender as TDBEdit).name = 'DBEdit24') or
      ((sender as TDBEdit).name = 'DBEdit17') or
      ((sender as TDBEdit).name = 'DBEdit12') or
      ((sender as TDBEdit).name = 'DBEdit18') or
      ((sender as TDBEdit).name = 'DBEdit21') then
      result := true;
end;

procedure TfrmGReg.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TAdoTable then
      (Components[I] as TAdoTable).Close;
//  frmMain.SavePos(GRegForm,'GReg');
end;

procedure TfrmGReg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if not StopHere then
    begin
//      if not (ActiveControl is TDBLookupComboBox) then
//      begin
//        key := #0;
      ActiveControl := FindNextControl(ActiveControl, true, true, false);
//      end;
    end
    else
      StopHere := false;
end;

procedure TfrmGReg.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin
  screen.cursor := crHourGlass;
  try
    for I := 0 to ComponentCount - 1 do
      if Components[I] is TAdoTable then
      begin
        if (Components[I] as TAdoTable).State in [dsInsert, dsEdit] then
          (Components[I] as TAdoTable).Post;
//!          if (Components[I] as TAdoTable).ChangeCount > 0 then
//!          begin
//!            (Components[I] as TAdoTable).ApplyUpdates(0);
        dataChanged := true;
//!          end;
      end;
    if dataChanged then
    begin
      frmMain.LoadTmpData;
//!      frmMain.LoadCosts;
      FillCombos;
      dataChanged := false;
      if assigned(frmBokgraf) then
        frmBokGraf.UpdateFromDatabase(nil);
    end;
    modalresult := mrOK;
  finally
    screen.cursor := crDefault;
  end;
end;

procedure TfrmGReg.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TAdoTable then
      if (Components[I] as TAdoTable).State in [dsInsert, dsEdit] then
        (Components[I] as TAdoTable).Cancel;
//  DM1.OrtrgT.Cancel;

  Timer1.Enabled := False;
  frmMain.Timer2.Enabled := true;
end;

procedure TfrmGReg.CustomerTBeforePost(DataSet: TDataSet);
var
  id: Integer;
begin
  if CustomerT.fieldbyName('Cust_Id').AsInteger < 1 then
  begin
    id := Frmsearch.GetNewCustomerId;
    if (CustomerT.State in [dsEdit, dsInsert]) then
      CustomerT.fieldbyName('Cust_Id').value := Id;
  end;
end;

procedure TfrmGReg.CustomerTAfterInsert(DataSet: TDataSet);
begin
  CustomerT.fieldbyName('Utlandsk').AsBoolean := false;
  CustomerT.fieldbyName('Int_Cust').AsBoolean := false;
  if visible then
    cbUtlandsk.SetFocus;
end;

procedure TfrmGReg.cbUtlandskClick(Sender: TObject);
begin
  edtKLand.Visible := cbUtlandsk.Checked;
  if cbUtlandsk.Checked then
    Label13.caption := 'Körkortsnummer'
  else
    Label13.caption := 'Personnummer';
end;

procedure TfrmGReg.AddKund;
begin
  Tab1.ActivePage := tbCustomers;
  CustomerT.Cancel;
  CustomerT.Append;
end;

procedure TfrmGReg.DBMemo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if KEY = VK_RETURN then
  begin
    StopHere := true;
    Notesstop := true;
  end;
end;

procedure TfrmGReg.FormActivate(Sender: TObject);
var I, J: Integer;
begin
  frmMain.Timer2.Enabled := False;
  Timer1.Enabled := True;

  dataChanged := false;
  I := screen.cursor;
  screen.cursor := crHourglass;
  try
    if tab1.activepage = tbCustomers then
      edtKPersNr.SetFocus;
    if tab1.activepage = tbObjects then
      DBEdit18.SetFocus;
    for J := 0 to ComponentCount - 1 do
      if Components[J] is TAdoTable then
        //!Baz(Components[J] as TAdoTable).ReSync([RMCenter]);
        (Components[J] as TAdoTable).Open;
  finally
    screen.cursor := I;
  end;
//!  case Tab1.ActivePage.Tag of
//!    1: dbnav.DataSource := CustomerS;
//!    2: dbnav.DataSource := ObjectsS;
//!  end;
//!För att rensa bland Kundposter måste shif + Alt + LASP inloggas
  if ('$LASP' = frmmain.sign) then
    speedbutton2.Visible := True
  else
    speedbutton2.Visible := False;
  FixRaknare;
  SpeedButton3.Glyph := nil;
  ImageList1.GetBitmap(1, SpeedButton3.Glyph)
end;

procedure TfrmGReg.FillCombos;
var
  I, J: Integer;
  NotInList: Boolean;
begin
  cbBetalning.clear;
  for I := 0 to length(PayAlts) - 1 do
    cbBetalning.Items.add(PayAlts[i].Code + ' ' + PayAlts[i].Name);
  cbBetalning.Itemindex := GetBetIndex(DefBetSt);

  cbBensin.clear;
  for I := 0 to length(Petrols) - 1 do
    cbBensin.Items.add(Petrols[i].Name);
  cbBensin.Itemindex := 0;

  cbPClass.clear;
  for I := 0 to length(PriceLists) - 1 do
  begin
    notinlist := true;
    j := 0;
    while (j < cbPClass.Items.count) and NotInList do
    begin
      if PriceLists[i].PClass = cbPClass.Items[J] then
        NotInList := false;
      inc(j);
    end;
    if NotInList then
      cbPClass.Items.add(PriceLists[i].PClass);
  end;
  cbPClass.Itemindex := 0;

  cbTele1.clear;
  for I := 0 to length(Telephones) - 1 do
    cbTele1.Items.add(Telephones[i].Id + ' ' + Telephones[i].Name);
  cbTele1.Itemindex := 0;
  cbTele2.items := cbTele1.items;
  cbTele3.items := cbTele1.items;
//!  cbTele4.items := cbTele1.items;
//!  cbTele5.items := cbTele1.items;
//!  Tab1.activePage := Kunder;

  cbCards.clear;
  for I := 0 to length(CCards) - 1 do
    cbCards.Items.add(CCards[i].Id + ' ' + CCards[i].Name);
  cbCards.Itemindex := -1;
end;

function GetProperTable(sheet: TTabsheet; var table: TDataSet): Boolean;
var I: Integer;
begin
  result := true;
  for I := 0 to sheet.owner.ComponentCount - 1 do
  begin
    if sheet.owner.Components[I] is TDBNavigator then
      if (sheet.owner.Components[I] as TDBNavigator).parent = sheet then
        table := (sheet.owner.Components[I] as TDBNavigator).DataSource.DataSet;
  end;
end;

procedure GetProperIndex(table: TDataSet; SearchControl: TWinControl);
var
  I: Integer;
  DataField: string;
  IndexFound: boolean;
begin
  if (SearchControl is TDBEdit) and (table is TClientDataSet) then
  begin
    indexfound := false;
    DataField := (SearchControl as TDBEdit).DataField;
    if DataField = '' then
      exit;
    (table as TClientDataSet).IndexDefs.Update;
    { Find one which combines Customer Number ('CustNo') and Order Number ('OrderNo') }
    for I := 0 to (table as TClientDataSet).IndexDefs.Count - 1 do
      if (table as TClientDataSet).IndexDefs.Items[I].Fields = DataField then
      begin
       { set that index as the current index for the dataset}
        (table as TClientDataSet).IndexName := (table as TClientDataSet).IndexDefs.Items[I].Name;
        indexfound := true;
      end;

    if not indexfound then
    begin
      (table as TClientDataSet).AddIndex(DataField, DataField, []);
      (table as TClientDataSet).IndexName := DataField;
    end;
  end;
end;

procedure TfrmGReg.DoGRegSearch(Cont: TDBEdit);
var
  srcValue: string;
begin
  srcValue := '';
  if Cont.DataSource <> nil then
    if Cont.DataField > '' then
      if inputQuery('Sök i fält ' + Cont.DataField, 'Efter', srcValue) and (srcValue > '') then
        if (Cont.DataSource.Dataset is TAdoTable) then
        begin
          GetProperIndex(Cont.DataSource.Dataset, Cont);
          (Cont.DataSource.Dataset as TAdoTable).Locate(Cont.Datafield, srcValue, [LopartialKey]);
        end;
end;

procedure TfrmGReg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I: Integer;
  Table: TDataset;
  Str: string;
begin
//!  Table := dbnav.DataSource.DataSet;
  if tab1.ActivePageIndex = 0 then
    table := customerT
  else
    table := objectsT;
//!Hit

  if Shift = [ssAlt] then
  begin
    for I := 0 to Tab1.PageCount - 1 do
      if UnderscoreChar(Tab1.Pages[I].Caption) = chr(Key) then
        if Tab1.Pages[I].TabVisible then
        begin
          Tab1.ActivePage := Tab1.Pages[I];
          exit;
        end;
  end;

  if (key = VK_F2) then
    SpeedButton3.Click;

  if (key = VK_F5) and (ActiveControl is TDBEdit) then
    DoGRegSearch(ActiveControl as TDBEdit);
  if key in [VK_Next, VK_Prior, VK_Delete, VK_Insert, VK_RETURN, VK_HOME] then
  begin
    str := '';
    if Assigned(ActiveControl) then
      Str := ActiveControl.ClassName;
    if not (str = 'TDBGrid') then
    begin
      if GetProperTable(Tab1.ActivePage, Table) and assigned(table) then
      begin
        if (key = VK_Next) and (shift = [ssCtrl]) then
        begin
          GetProperIndex(Table, ActiveControl);
          Table.Last;
          Key := 0;
        end
        else
          if (key = VK_Next) then
          begin
            GetProperIndex(table, ActiveControl);
            Table.next;
            Key := 0;
          end;
        if (key = VK_Prior) and (shift = [ssCtrl]) then
        begin
          GetProperIndex(table, ActiveControl);
          Table.First;
          Key := 0;
        end
        else
          if key = VK_Prior then
          begin
            GetProperIndex(table, ActiveControl);
            Table.Prior;
            Key := 0;
          end;
        if (key = VK_HOME) and (shift = [ssCtrl]) then
        begin
          Table.Cancel;
          Key := 0;
        end;
        if (key = VK_Delete) and (shift = [ssCtrl]) then
        begin
          Table.Delete;
          Key := 0;
        end;
        if (key = VK_Insert) and (shift = [ssCtrl]) then
        begin
          Table.Append;
          Key := 0;
        end;
        if (key = VK_RETURN) and (shift = [ssCtrl]) then
        begin
//!        if dbnav.DataSource = (ObjectsS) then
          if tab1.ActivePageIndex = 1 then //!
            ObjectsT.FieldByName('DType').asstring := cbbensin.Text;
          if Table.state in [dsEdit, dsInsert] then
            Table.Post
          else
            Table.Resync([RmCenter]);
          Key := 0;
        end;
      end;
    end;
  end;
end;

procedure TfrmGReg.DBNavigator3BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
//!  if button = nbinsert then
//!    cbUtlandsk.SetFocus;
end;

procedure TfrmGReg.DBNavigator4BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
//!  if button = nbinsert then
//!    DBEdit18.SetFocus;

end;

procedure TfrmGReg.DBEdit12Exit(Sender: TObject);
begin
//  ActiveControl := FindNextControl(ActiveControl, true, true, false);
  label11.font.color := ClBlack;
  LastSender := Sender;
end;

procedure TfrmGReg.DBEdit13Enter(Sender: TObject);
begin
  if LastSender = edtKAdr1 then
    ActiveControl := FindNextControl(ActiveControl, true, true, false);
end;

procedure TfrmGReg.tbCustomersEnter(Sender: TObject);
begin
  LastSender := Sender;
end;

procedure TfrmGReg.CheckIntern;
begin
  edtKKonto.Enabled := cbIKund.checked;
  edtKKStalle.Enabled := cbIKund.checked;
end;

procedure TfrmGReg.CustomerTAfterScroll(DataSet: TDataSet);
begin
  CheckIntern;
  fixraknare;
end;

procedure TfrmGReg.DBLookupComboBox5KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    if (sender as TDBLookupComboBox).Listvisible then
      stophere := true;
  end;
end;

procedure TfrmGReg.DBComboBox8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    if (sender as TDBComboBox).DroppedDown then
      stophere := true;
  end;
end;

procedure TfrmGReg.SpeedButton1Click(Sender: TObject);
begin
  meKund.clear;
end;

procedure TfrmGReg.edtKPersNrExit(Sender: TObject);
begin
  label13.font.color := ClBlack;
  if (edtKPersNr.Text > '!') and (not cbUtlandsk.checked) and (customert.State in [dsInsert, dsEdit]) then
  begin
    if not (PNummerKoll(edtKPersNr.Text) = 'false') then
    begin
      if (CustomerT.Fieldbyname('Org_no').value <> PNummerKoll(edtKPersNr.Text)) then
        CustomerT.Fieldbyname('Org_no').value := PNummerKoll(edtKPersNr.Text);
    end
    else
    begin
      Showmessage('Felaktigt personnummer!!');
      edtKPersNr.SetFocus;
    end;
  end;
  LastSender := Sender;
end;

procedure TfrmGReg.cbIKundClick(Sender: TObject);
begin
  edtKKonto.Enabled := cbIKund.checked;
  edtKKStalle.Enabled := cbIKund.checked;
end;

function TfrmGReg.GetCustomer(CustId: integer): boolean;
begin
  screen.cursor := crHourglass;
  try
    result := CustomerT.locate('Cust_Id', CustId, []);

    if result then
      CustomerT.Resync([RmCenter]);
    tab1.ActivePage := tbCustomers;
  finally
    screen.cursor := crDefault;
  end;
end;

function TfrmGReg.GetObject(OId: string): boolean;
begin
//  result := ObjectsCDS.locate('REG_NO', OID, [loCaseInsensitive]);
  result := true;
//!  ObjectsT.FindNearest([OID]);
  ObjectsT.locate('REG_NO', OID, [loCaseInsensitive]);
  tab1.ActivePage := tbObjects;
end;

procedure TfrmGReg.CustomerTReconcileError(DataSet: TClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TfrmGReg.BitBtn3Click(Sender: TObject);
var
  J: Integer;
  HasAnswered: boolean;
begin
  if CustomerT.Filtered = true then
    customert.Filtered := False;
  if ObjectsT.Filtered = true then
    ObjectsT.Filtered := False;

  HasAnswered := false;
  for J := 0 to ComponentCount - 1 do
    if Components[J] is TAdoTable then
      if ((Components[J] as TAdoTable).State in [dsInsert, dsEdit]) then //! Or ((Components[J] as TAdoTable).ChangeCount > 0) then
      begin
        if not HasAnswered then
        begin
          if MessageDlg('Du har förändrat poster. Vill du avbryta dessa förändringar?',
            mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            exit;
          HasAnswered := true;
        end;
        (Components[J] as TAdoTable).Cancel;
        (Components[J] as TAdoTable).CancelUpdates;
      end;
  dataChanged := false;
  modalresult := mrCancel;
end;

procedure TfrmGReg.FormCreate(Sender: TObject);
var I, J: Integer;
begin
  dataChanged := false;
  I := screen.cursor;
  screen.cursor := crHourglass;

  for J := 0 to ComponentCount - 1 do
    if Components[J] is TAdoTable then
      (Components[J] as TAdoTable).Open;
  q1.open;
  screen.cursor := I;

end;

procedure TfrmGReg.edtKPAdrChange(Sender: TObject);
begin
  edtKPAdr.text := GetPostOrt(edtKPAdr.text);
end;

procedure TfrmGReg.DBEdit46Change(Sender: TObject);
var
  str: string;
begin
//!  str := GetPostOrt(DBEdit46.text);
//!  DBEdit46.text := Copy(str,1,6);
//!  Delete(str,1,8);
  //DBEdit47.text := str;
//!  if SignrCDS.state in [dsEdit, dsInsert] then
//!    SignrCDS.FieldByName('ORT').AsString := str;
end;

procedure TfrmGReg.ObjectsTAfterInsert(DataSet: TDataSet);
begin
  if visible then
    DBEdit18.SetFocus;
end;

procedure TfrmGReg.cbObjTypKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F4 then
    if (sender is TDBLookupComboBox) then
    begin
      if (sender as TDBLookupComboBox).ListVisible then
        (sender as TDBLookupComboBox).CloseUp(false)
      else
        (sender as TDBLookupComboBox).DropDown;
    end;
  if key = VK_RETURN then
  begin
    if (sender as TDBLookupComboBox).Listvisible then
      stophere := true;
  end;
end;

procedure TfrmGReg.cbCardKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F4 then
    if (sender is TDBLookupComboBox) then
    begin
      if (sender as TDBLookupComboBox).ListVisible then
        (sender as TDBLookupComboBox).CloseUp(false)
      else
        (sender as TDBLookupComboBox).DropDown;
    end;
  if key = VK_RETURN then
  begin
    if (sender as TDBLookupComboBox).Listvisible then
      stophere := true;
  end;
end;

procedure TfrmGReg.ObjTypeTAfterInsert(DataSet: TDataSet);
begin
  ObjTypeT.fieldbyName('ShowKM').AsBoolean := true;
  ObjTypeT.fieldbyName('ShowPKlass').AsBoolean := true;
  ObjTypeT.fieldbyName('ShowPTyp').AsBoolean := true;
  ObjTypeT.fieldbyName('ShowDragbil').AsBoolean := false;
end;

procedure TfrmGReg.CardsTAfterPost(DataSet: TDataSet);
begin
//!  (Dataset as TClientDataSet).Applyupdates(0);
//  (Dataset as TClientDataSet).Refresh;
  dataChanged := true;
end;

procedure TfrmGReg.CardsTAfterCancel(DataSet: TDataSet);
begin
  (Dataset as TAdoTable).CancelUpdates;
end;

procedure TfrmGReg.PriceTabRowsTBeforeInsert(DataSet: TDataSet);
begin
  PriceTabRowsT.Last;
  LastRow := PriceTabRowsT.Fieldbyname('RowNum').AsInteger;
end;

procedure TfrmGReg.PriceTabRowsTAfterInsert(DataSet: TDataSet);
begin
  PriceTabRowsT.Fieldbyname('PriceId').AsInteger := PriceTabT.Fieldbyname('PriceId').AsInteger;
  PriceTabRowsT.Fieldbyname('RowNum').AsInteger := LastRow + 1;
end;

procedure TfrmGReg.PriceTabTBeforeInsert(DataSet: TDataSet);
begin
  PriceTabRowsT.Close;
end;

procedure TfrmGReg.PriceTabTAfterScroll(DataSet: TDataSet);
begin
  if PriceTabT.Fieldbyname('PriceId').AsString > '' then
  begin
    PriceTabRowsT.Filter := 'PriceId = ' + PriceTabT.Fieldbyname('PriceId').AsString;
    PriceTabRowsT.Filtered := true;
    PriceTabRowsT.Open;
  end
  else
    PriceTabRowsT.close;
end;

procedure TfrmGReg.PriceTabTAfterPost(DataSet: TDataSet);
begin
//!  (Dataset as TClientDataSet).Applyupdates(0);
  PriceTabT.Resync([RmCenter]);
  dataChanged := true;
  PriceTabRowsT.Open;
end;

procedure TfrmGReg.Button1Click(Sender: TObject);
var
  CarIni: TIniFile;
begin
  CarIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Car2000.Ini');
  with CarIni do
  begin
//!     if EdtTitel.text > ' ' then
//!      WriteString('Params','Title',EdtTitel.text);
//!      if EdtSBild.text > ' ' then
//!      WriteString('Params','Image',EdtSBild.text);
//!      if EdtDb.text > ' ' then
//!      WriteString('Params','Db',EdtDb.text);
  end;
  CarIni.Free;

end;

procedure TfrmGReg.tab1Change(Sender: TObject);
begin
  FixRaknare;
  speedbutton3.Flat := false;
  SpeedButton3.Glyph := nil;
  ImageList1.GetBitmap(1, SpeedButton3.Glyph);
  pakundG.visible := False;
  PaObjG.visible := False;
  btnfilter.enabled := False;
  btnASC.enabled := False;
  BtnDESC.enabled := False;
  if btnfilter.Flat then
  begin
    customert.filtered := False;
    ObjectsT.Filtered := False;
    btnfilter.Flat := False;
  end;
end;

procedure TfrmGReg.DBEdit23Enter(Sender: TObject);
begin
  label21.font.color := ClBlue;
  //!Benny för att lägga in ObjNummer och VStat auto matiskt
  if dbedit23.text < '!' then
  begin
    dbedit23.text := dmod.ParamT.fieldbyname('ObjNr').asstring;
    dbedit37.text := '1';
    cbbensin.Text := 'Bensin 95';

    dmod.ParamT.Edit;
    dmod.ParamT.FieldByName('ObjNr').asinteger := Strtoint(dbedit23.text) + 1;
    dmod.ParamT.Post;
    dbedit23.SetFocus;
  end;
end;

procedure TfrmGReg.FixStr(sender: TDBEdit);
var x, y: string;
  i, j, k: Integer;
begin
  if (sender as TDBedit).text > '!' then
  begin
    x := uppercase((sender as tdbedit).text[1]);
    y := (sender as tdbedit).text;
    delete(y, 1, 1);
    (sender as Tdbedit).text := x + y;

    j := length((sender as TDBEdit).text);
    for i := 0 to j - 1 do begin
      k := 0;
      if (sender as tdbedit).text[i] = ',' then
      begin
        k := i + 1;
        y := (sender as tdbEdit).text;
        x := ' ';
        if (sender as tdbEdit).text[i + 1] <> ' ' then
        begin
          insert(x, y, i + 1);
          (sender as tdbEdit).text := y;
        end;
        k := k + 1;

      end;

      if k <> 0 then
      begin
        x := uppercase((sender as tdbedit).text[k]);
        y := (sender as tdbedit).text;
        delete(y, k, 1);
        insert(x, y, k);
        (sender as Tdbedit).text := y;
      end;
    end;
  end;
end;

procedure TfrmGReg.DBEdit21Exit(Sender: TObject);
begin
  label19.font.color := ClBlack;
  fixstr(Dbedit21);
end;

procedure TfrmGReg.edtKNamnExit(Sender: TObject);
begin
  label12.font.color := ClBlack;
  fixstr(edtknamn);
end;

procedure TfrmGReg.edtKAdr2Exit(Sender: TObject);
begin
  label14.font.color := ClBlack;
  fixstr(EdtKAdr2);
end;

procedure TfrmGReg.SpeedButton2Click(Sender: TObject);
var i: Integer;
begin
  i := 0;
  if MessageDlg('Vill du radera samtliga kundposter?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.cursor := crHourglass;
    CustomerT.First;
    while not CustomerT.EOF do
    begin
      if not (dmod.Contr_BaseT.locate('Custid', CustomerT.fieldbyname('Cust_Id').asstring, [lopartialkey])) or
        (dmod.Contr_BaseT.locate('Driveid', CustomerT.fieldbyname('Cust_Id').asstring, [lopartialkey])) then
      begin
        CustomerT.Delete;
        Inc(i);
        CustomerT.MoveBy(-1);
      end;
      CustomerT.Next;
    end;
    Showmessage('Du tog bort ' + inttostr(i) + ' kundposter');
    screen.cursor := crDefault;
  end;

end;

procedure TfrmGReg.DBGrid1DblClick(Sender: TObject);
begin
  PaKundG.visible := False;
  SpeedButton3Click(nil);
end;

procedure TfrmGReg.DBGrid2DblClick(Sender: TObject);
begin
  PaObjG.visible := False;
  SpeedButton3Click(nil);
end;

procedure TfrmGReg.SpeedButton3Click(Sender: TObject);
var
  c, o: Integer;
begin
  if speedbutton3.Flat then
  begin
    case tab1.ActivePageIndex of
      0: PaKundg.visible := False;
      1: PaObjG.visible := False;
    end;
    speedbutton3.Down := False;
    speedbutton3.Hint := 'Visa Tabell form';
    btnfilter.enabled := False;
    btnfilter.flat := False;
    btnASC.enabled := False;
    BtnDESC.enabled := False;
//!Bookmark
    c := Customert.fieldbyname('Cust_id').asinteger;
    o := ObjectsT.fieldbyname('objnum').asinteger;
//!hit
    customert.active := False;
    ObjectsT.active := False;
//    customerT.CursorLocation := clUseServer;
//    ObjectsT.CursorLocation := clUseServer;
    customert.active := True;
    ObjectsT.active := True;
//!Bookmark
    customerT.locate('Cust_Id', c, [lopartialkey]);
    ObjectsT.locate('ObjNum', o, [lopartialkey]);
//!Hit
    SpeedButton3.Glyph := nil;
    ImageList1.GetBitmap(1, SpeedButton3.Glyph);
    SpeedButton3.Flat := false;
  end
  else
  begin
    case tab1.ActivePageIndex of
      0: PaKundg.visible := True;
      1: PaObjG.visible := True;
    end;
    speedbutton3.Down := True;
    speedbutton3.Hint := 'Visa Formulär form';
    btnfilter.enabled := True;
    btnASC.enabled := True;
    BtnDESC.enabled := True;
//! Bookmark
    c := Customert.fieldbyname('Cust_id').asinteger;
    o := ObjectsT.fieldbyname('objnum').asinteger;
//!Hit
    customert.active := False;
    ObjectsT.active := False;
    CustomerT.CursorLocation := clUseClient;
    ObjectsT.CursorLocation := clUseClient;
    customert.active := True;
    ObjectsT.active := True;
//! Bookmark tillbaka
    customerT.locate('Cust_Id', c, [lopartialkey]);
    ObjectsT.locate('ObjNum', o, [lopartialkey]);
//!Hit
    SpeedButton3.Glyph := nil;
    ImageList1.GetBitmap(2, SpeedButton3.Glyph);
    SpeedButton3.Flat := true;
  end;
end;

procedure TfrmGReg.BtnFirstClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.first;
    2: ObjectsT.first;
  end;
  FixRaknare;
end;

procedure TfrmGReg.BtnMinEnClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.moveby(-1);
    2: ObjectsT.moveby(-1);
  end;
  FixRaknare;
end;

procedure TfrmGReg.BtnPlusenClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.moveby(1);
    2: ObjectsT.moveby(1);
  end;
  FixRaknare;
end;

procedure TfrmGReg.BtnLastClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.Last;
    2: ObjectsT.Last;
  end;
  FixRaknare;
end;

procedure TfrmGReg.BtnNewClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1:
      begin
        customert.Append;
        DBCheckBox1.Checked := false;
        DBCheckBox1.Enabled := true;
        cbUtlandsk.SetFocus;
      end;
    2:
      begin
        ObjectsT.Append;
        dbedit18.setfocus;
      end;
  end;
end;

procedure TfrmGReg.BtnDelClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.Delete;
    2: ObjectsT.Delete;
  end;
end;

procedure TfrmGReg.BtnEditClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.Edit;
    2: ObjectsT.Edit;
  end;
end;

procedure TfrmGReg.BtnSaveClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.post;
    2:
      begin
        ObjectsT.FieldByName('DType').asstring := cbbensin.Text;
        ObjectsT.post;
      end;
  end;
end;

procedure TfrmGReg.BtnCanClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.Cancel;
    2: ObjectsT.Cancel;
  end;
end;

procedure TfrmGReg.BtnUpdClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: customert.resync([rmcenter]);
    2: ObjectsT.resync([rmcenter]);
  end;
end;

procedure TfrmGReg.FixRaknare;
begin
  case Tab1.ActivePage.Tag of
    1:
      begin
        customerT.Open;
        btnRecNo.text := inttostr(customert.RecNo);
        BtnTotRecNo.text := inttostr(CustomerT.recordcount);
      end;
    2:
      begin
        objectsT.open;
        btnRecNo.text := inttostr(Objectst.RecNo);
        BtnTotRecNo.text := inttostr(ObjectsT.recordcount);
      end;
  end;
end;

procedure TfrmGReg.BtnFilterClick(Sender: TObject);
begin
  if btnfilter.Flat then
  begin
    btnfilter.flat := False;
    case Tab1.ActivePage.Tag of
      1: customert.Filtered := False;
      2: Objectst.Filtered := False;
    end;
  end
  else
  begin
    btnfilter.flat := True;
    case Tab1.ActivePage.Tag of
      1:
        if dbgrid1.SelectedField.AsString > '!' then
        begin
          customerS.DataSet.Filter := dbgrid1.SelectedField.FieldName + '=''' + dbgrid1.SelectedField.asstring + '''';
          customerS.DataSet.Filtered := True;
        end;
      2:
        if dbgrid2.SelectedField.AsString > '!' then
        begin
          ObjectsS.Dataset.Filter := dbgrid2.SelectedField.FieldName + '=''' + dbgrid2.SelectedField.AsString + '''';
          Objectss.Dataset.Filtered := True;
        end;
    end;
  end;
end;

procedure SetSort(tbl: TADOTable; SortOn: string);
var
  tmp: string;
begin
  if SortOn <> tbl.Sort then
  begin
    tmp := tbl.Fields[0].AsString;
    tbl.Sort := SortOn;
    tbl.Locate(tbl.Fields[0].FieldName, tmp, []);
  end;
end;



procedure TfrmGReg.BtnASCClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: SetSort(customert, dbgrid1.SelectedField.FieldName);
    2: SetSort(Objectst, dbgrid2.SelectedField.FieldName);
  end;
end;

procedure TfrmGReg.BtnDESCClick(Sender: TObject);
begin
  case Tab1.ActivePage.Tag of
    1: SetSort(customert, dbgrid1.SelectedField.FieldName + ' DESC');
    2: SetSort(Objectst, dbgrid2.SelectedField.FieldName + ' DESC');
  end;
end;

procedure TfrmGReg.edtKNamnEnter(Sender: TObject);
begin
  label12.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit12Enter(Sender: TObject);
begin
  label11.font.color := ClBlue;
end;

procedure TfrmGReg.edtKIDEnter(Sender: TObject);
begin
  label16.font.color := ClBlue;
end;

procedure TfrmGReg.edtKPersNrEnter(Sender: TObject);
begin
  label13.font.color := ClBlue;
end;

procedure TfrmGReg.edtKAdr1Enter(Sender: TObject);
begin
  label14.font.color := ClBlue;
end;

procedure TfrmGReg.edtKAdr2Enter(Sender: TObject);
begin
  label14.font.color := ClBlue;
end;

procedure TfrmGReg.edtKPAdrEnter(Sender: TObject);
begin
  label14.font.color := ClBlue;
end;

procedure TfrmGReg.edtKLandEnter(Sender: TObject);
begin
  label14.font.color := ClBlue;
end;

procedure TfrmGReg.meKundEnter(Sender: TObject);
begin
  label64.font.color := ClBlue;
end;

procedure TfrmGReg.cbTele1Enter(Sender: TObject);
begin
  label15.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit19Enter(Sender: TObject);
begin
  label15.font.color := ClBlue;
end;

procedure TfrmGReg.cbTele2Enter(Sender: TObject);
begin
  label15.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit20Enter(Sender: TObject);
begin
  label15.font.color := ClBlue;
end;

procedure TfrmGReg.cbTele3Enter(Sender: TObject);
begin
  label15.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit22Enter(Sender: TObject);
begin
  label15.font.color := ClBlue;
end;

procedure TfrmGReg.cbIKundEnter(Sender: TObject);
begin
  cbikund.font.color := ClBlue;
end;

procedure TfrmGReg.cbCardsEnter(Sender: TObject);
begin
  label17.font.color := ClBlue;
end;

procedure TfrmGReg.edtCreditNoEnter(Sender: TObject);
begin
  label17.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit9Enter(Sender: TObject);
begin
  label63.font.color := ClBlue;
end;

procedure TfrmGReg.DBKexpEnter(Sender: TObject);
begin
  label4.font.color := ClBlue;
end;

procedure TfrmGReg.cbBetalningEnter(Sender: TObject);
begin
  label66.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit10Enter(Sender: TObject);
begin
  label65.font.color := ClBlue;
end;

procedure TfrmGReg.edtKKontoEnter(Sender: TObject);
begin
  label1.font.color := ClBlue;
end;

procedure TfrmGReg.edtKKStalleEnter(Sender: TObject);
begin
  label2.font.color := ClBlue;
end;

procedure TfrmGReg.edtKAdr1Exit(Sender: TObject);
begin
  label14.font.color := ClBlack;
end;

procedure TfrmGReg.edtKPAdrExit(Sender: TObject);
begin
  label14.font.color := ClBlack;
end;

procedure TfrmGReg.edtKLandExit(Sender: TObject);
begin
  label14.font.color := ClBlack;
end;

procedure TfrmGReg.cbTele1Exit(Sender: TObject);
begin
  label15.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit19Exit(Sender: TObject);
begin
  label15.font.color := ClBlack;
end;

procedure TfrmGReg.cbTele2Exit(Sender: TObject);
begin
  label15.font.color := ClBlack;
end;

procedure TfrmGReg.edtKIDExit(Sender: TObject);
begin
  label16.font.color := ClBlack;
end;

procedure TfrmGReg.meKundExit(Sender: TObject);
begin
  label64.font.color := ClBlack;
end;

procedure TfrmGReg.cbCardsExit(Sender: TObject);
begin
  label17.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit9Exit(Sender: TObject);
begin
  label63.font.color := ClBlack;
end;

procedure TfrmGReg.DBKexpExit(Sender: TObject);
begin
  label4.font.color := ClBlack;
end;

procedure TfrmGReg.cbBetalningExit(Sender: TObject);
begin
  label66.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit10Exit(Sender: TObject);
begin
  label65.font.color := ClBlack;
end;

procedure TfrmGReg.cbIKundExit(Sender: TObject);
begin
  cbikund.font.color := ClBlack;
end;

procedure TfrmGReg.edtKKontoExit(Sender: TObject);
begin
  label1.font.color := ClBlack;
end;

procedure TfrmGReg.edtKKStalleExit(Sender: TObject);
begin
  label2.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit18Enter(Sender: TObject);
begin
  label18.font.color := ClBlue;
end;

procedure TfrmGReg.cbObjTypEnter(Sender: TObject);
begin
  label20.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit21Enter(Sender: TObject);
begin
  label19.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit28Enter(Sender: TObject);
begin
  label23.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit29Enter(Sender: TObject);
begin
  label24.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit31Enter(Sender: TObject);
begin
  label28.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit34Enter(Sender: TObject);
begin
  label33.font.color := ClBlue;
end;

procedure TfrmGReg.EdtDrvm_kmEnter(Sender: TObject);
begin
  label3.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit30Enter(Sender: TObject);
begin
  label25.font.color := ClBlue;
end;

procedure TfrmGReg.cbBensinEnter(Sender: TObject);
begin
  label29.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit33Enter(Sender: TObject);
begin
  label30.font.color := ClBlue;
end;

procedure TfrmGReg.cbPClassEnter(Sender: TObject);
begin
  label32.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit37Enter(Sender: TObject);
begin
  label31.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit35Enter(Sender: TObject);
begin
  label34.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit1Enter(Sender: TObject);
begin
  label5.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit2Enter(Sender: TObject);
begin
  label6.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit3Enter(Sender: TObject);
begin
  label7.font.color := ClBlue;
end;

procedure TfrmGReg.DBEdit3Exit(Sender: TObject);
begin
  label7.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit2Exit(Sender: TObject);
begin
  label6.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit1Exit(Sender: TObject);
begin
  label5.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit18Exit(Sender: TObject);
begin
  label18.font.color := ClBlack;
end;

procedure TfrmGReg.cbObjTypExit(Sender: TObject);
begin
  label20.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit28Exit(Sender: TObject);
begin
  label23.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit29Exit(Sender: TObject);
begin
  label24.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit31Exit(Sender: TObject);
begin
  label28.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit34Exit(Sender: TObject);
begin
  label33.font.color := ClBlack;
end;

procedure TfrmGReg.cbBensinExit(Sender: TObject);
begin
  label29.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit23Exit(Sender: TObject);
begin
  label21.font.color := ClBlack;
end;

procedure TfrmGReg.EdtDrvm_kmExit(Sender: TObject);
begin
  label3.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit30Exit(Sender: TObject);
begin
  label25.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit33Exit(Sender: TObject);
begin
  label30.font.color := ClBlack;
end;

procedure TfrmGReg.cbPClassExit(Sender: TObject);
begin
  label32.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit37Exit(Sender: TObject);
begin
  label31.font.color := ClBlack;
end;

procedure TfrmGReg.DBEdit35Exit(Sender: TObject);
begin
  label34.font.color := ClBlack;
end;

procedure TfrmGReg.cbUtlandskEnter(Sender: TObject);
begin
  CBUtlandsk.font.color := ClBlue;
end;

procedure TfrmGReg.cbUtlandskExit(Sender: TObject);
begin
  CBUtlandsk.font.color := ClBlack;
//!  DBCheckBox1.Checked :=False;
//!  DBCheckBox2.Checked :=False;
end;

procedure TfrmGReg.DBCheckBox1Enter(Sender: TObject);
begin
  dbcheckbox1.font.color := ClBlue;
end;

procedure TfrmGReg.DBCheckBox1Exit(Sender: TObject);
begin
  dbcheckbox1.font.color := ClBlack;
end;

procedure TfrmGReg.DBGrid1CellClick(Column: TColumn);
begin
//!  FixRaknare;
end;

procedure TfrmGReg.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//!  fixraknare;
end;

procedure TfrmGReg.DBGrid2CellClick(Column: TColumn);
begin
//!  fixraknare;
end;

procedure TfrmGReg.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//!  fixraknare;
end;

procedure TfrmGReg.CustomerSStateChange(Sender: TObject);
begin
  if customerS.state in [dsedit, dsinsert] then
  begin
    BtnCan.Enabled := True;
    btnsave.Enabled := True;
  end
  else
  begin
    BtnCan.Enabled := False;
    BtnSave.enabled := False;
  end;
end;

procedure TfrmGReg.ObjectsSStateChange(Sender: TObject);
begin
  if ObjectsS.state in [dsedit, dsinsert] then
  begin
    BtnCan.Enabled := True;
    btnsave.Enabled := True;
  end
  else
  begin
    BtnCan.Enabled := False;
    BtnSave.enabled := False;
  end;
end;

procedure TfrmGReg.ObjectsTAfterScroll(DataSet: TDataSet);
begin
  fixRaknare;
end;

procedure TfrmGReg.Timer1Timer(Sender: TObject);
var
  Regnr: string;
begin
  DebugInfo('+++ TfrmGReg.Timer1Timer +++');


  if tab1.ActivePage = tbObjects then
  begin
    if RFID_Active then
    begin
      if RFID_DataExist then
      begin
        if (RFID_TimeStamp + (15.0 / 86400) > Now) and (RFID_RfidStr <> '') then
        begin
          Timer1.Interval:=1000;
          Regnr := ObjectsS.DataSet.FieldByName('Reg_No').AsString;
          try
            GenericExecSQL('UPDATE OBJECTS SET CARDIRECT='''' WHERE CARDIRECT=''' + RFID_RfidStr + ''' AND REG_NO<>''' + REGNR + '''');
          except
          end;
          if ObjectsS.state in [dsedit, dsinsert] then
          begin
            ObjectsS.DataSet.Edit;
            ObjectsS.DataSet.FieldByName('CARDIRECT').AsString := RFID_RfidStr;
          end
          else
          begin
            GenericExecSQL('UPDATE OBJECTS SET CARDIRECT=''' + RFID_RfidStr + ''' WHERE REG_NO=''' + Regnr + '''');
            try
              ObjectsS.DataSet.Refresh;
            except
              ObjectsS.DataSet.Close;
              ObjectsS.DataSet.Open;
            end;
            ObjectsS.DataSet.Locate('REG_NO', REGNR, []);
          end;
          ObjectsSStateChange(nil);
        end;
      end;
      RFID_RfidStr := '';
      RFID_TimeStamp := 0;
      RFID_DataExist := False;
    end;
  end;
  DebugInfo('--- TfrmGReg.Timer1Timer ---');
end;

procedure TfrmGReg.edtLangEnter(Sender: TObject);
begin
  label8.font.color := clBlue;
end;

procedure TfrmGReg.edtLangExit(Sender: TObject);
begin
  label8.font.color := ClBlack;
end;

procedure TfrmGReg.btnChangeStationClick(Sender: TObject);
begin
  StationChangeDlg.ShowModal;
end;

end.

