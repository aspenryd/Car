{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     FormReg.pas
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
{ $Log:  13008: FormReg.pas
{
{   Rev 1.10    2008-06-27 13:33:44  Henry
{ Lagt till hantering av stationer
{
}
{   Rev 1.9    2006-02-18 13:33:18  pb64
}
{
{   Rev 1.8    2005-04-28 19:25:56  pb64
{ Inställning för att styra depositionsfaktura
}
{
{   Rev 1.7    2005-04-28 15:59:12  pb64
{ Ändrat insert till append.
}
{
{   Rev 1.6    2005-03-21 14:08:44  pb64
{ Ändrat så att man inte kan ta bort param registret.
}
{
{   Rev 1.5    2005-02-14 16:20:08  pb64
{ Lagt till inställningar för Cardirect
}
{
{   Rev 1.4    2005-02-08 21:36:34  pb64
{ Sätt till att endast byte 1..11 används i fältet funktioner.
}
{
{   Rev 1.3    2005-02-07 13:15:44  pb64
}
{
{   Rev 1.2    2004-01-28 14:40:18  peter
}
{
{   Rev 1.1    2003-08-04 11:58:46  Supervisor
}
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:04  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:06  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit FormReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Grids, DBGrids, ExtCtrls, Mask, ComCtrls, ExtDlgs,
  Buttons, ADODB, DB, Printers, DBClient, EQFormatEdit;

type
  TFrmReg = class(TForm)
    tab1: TPageControl;
    tbObjectTypes: TTabSheet;
    tbPrices: TTabSheet;
    tbSignatures: TTabSheet;
    tbCosts: TTabSheet;
    tbcompany: TTabSheet;
    tbparam: TTabSheet;
    tbrapport: TTabSheet;
    OPD2: TOpenPictureDialog;
    OPD1: TOpenPictureDialog;
    ODAvi: TOpenDialog;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Label71: TLabel;
    DBEdit64: TDBEdit;
    Label72: TLabel;
    DBEdit65: TDBEdit;
    Label73: TLabel;
    DBEdit66: TDBEdit;
    DBNavigator1: TDBNavigator;
    PaFirma: TPanel;
    Label20: TLabel;
    DBEdit9: TDBEdit;
    Label18: TLabel;
    DBEdit20: TDBEdit;
    Label17: TLabel;
    DBEdit16: TDBEdit;
    Label16: TLabel;
    DBEdit13: TDBEdit;
    Label23: TLabel;
    DBEdit14: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit21: TDBEdit;
    Label21: TLabel;
    DBEdit12: TDBEdit;
    Label25: TLabel;
    DBEdit17: TDBEdit;
    Label24: TLabel;
    DBEdit10: TDBEdit;
    Label19: TLabel;
    PaParam: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label31: TLabel;
    Label29: TLabel;
    Label28: TLabel;
    DBEdit15: TDBEdit;
    DBEdit22: TDBEdit;
    Label13: TLabel;
    DBEdit23: TDBEdit;
    Label58: TLabel;
    Label59: TLabel;
    Label68: TLabel;
    Label30: TLabel;
    Label69: TLabel;
    GroupBox5: TGroupBox;
    Label61: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit41: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit61: TDBEdit;
    DBEdit62: TDBEdit;
    DBEdit32: TDBEdit;
    Label12: TLabel;
    Label11: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label38: TLabel;
    Label34: TLabel;
    Label56: TLabel;
    Label70: TLabel;
    Label74: TLabel;
    DBEdit67: TDBEdit;
    DBEdit63: TDBEdit;
    DBEdit31: TDBEdit;
    Label60: TLabel;
    Label33: TLabel;
    DBEdit30: TDBEdit;
    Label37: TLabel;
    DBEdit29: TDBEdit;
    Label32: TLabel;
    DBEdit28: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit2: TDBEdit;
    PaObjTyp: TPanel;
    Label35: TLabel;
    DBEdit38: TDBEdit;
    Label5: TLabel;
    Label8: TLabel;
    Label22: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBEdit7: TDBEdit;
    Label26: TLabel;
    Label9: TLabel;
    DBEdit5: TDBEdit;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit39: TDBEdit;
    Label36: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label10: TLabel;
    Label27: TLabel;
    DBEdit8: TDBEdit;
    PaObjTypGrid: TPanel;
    DBGrid8: TDBGrid;
    PaSign: TPanel;
    Label39: TLabel;
    DBEdit42: TDBEdit;
    Label40: TLabel;
    DBEdit43: TDBEdit;
    Label42: TLabel;
    DBEdit44: TDBEdit;
    DBEdit45: TDBEdit;
    DBEdit46: TDBEdit;
    DBEdit47: TDBEdit;
    Label43: TLabel;
    cbTele4: TDBComboBox;
    cbTele5: TDBComboBox;
    DBEdit50: TDBEdit;
    DBEdit49: TDBEdit;
    Label79: TLabel;
    DBEdit118: TDBEdit;
    Label41: TLabel;
    DBEdit48: TDBEdit;
    PaPris: TPanel;
    Label44: TLabel;
    DBEdit51: TDBEdit;
    Label46: TLabel;
    DBEdit53: TDBEdit;
    Prisnamn: TLabel;
    DBEdit55: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    GroupBox3: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    DBEdit58: TDBEdit;
    DBEdit59: TDBEdit;
    GroupBox4: TGroupBox;
    Label54: TLabel;
    Label62: TLabel;
    DBEdit60: TDBEdit;
    DBEdit105: TDBEdit;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    DBNavigator11: TDBNavigator;
    Label45: TLabel;
    DBEdit52: TDBEdit;
    Label47: TLabel;
    DBEdit54: TDBEdit;
    GroupBox2: TGroupBox;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    DBEdit56: TDBEdit;
    DBEdit57: TDBEdit;
    DBEdit103: TDBEdit;
    DBEdit104: TDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    PaPrisGrid: TPanel;
    DBGrid10: TDBGrid;
    DBGrid11: TDBGrid;
    PaCosts: TPanel;
    DBEdit68: TDBEdit;
    DBEdit69: TDBEdit;
    DBEdit70: TDBEdit;
    DBEdit71: TDBEdit;
    DBEdit72: TDBEdit;
    DBEdit73: TDBEdit;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    PACostsG: TPanel;
    DBGrid1: TDBGrid;
    PaRep: TPanel;
    DBEdit74: TDBEdit;
    DBEdit75: TDBEdit;
    DBEdit76: TDBEdit;
    DBEdit77: TDBEdit;
    DBEdit78: TDBEdit;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    PaKont: TPanel;
    DBEdit79: TDBEdit;
    DBEdit80: TDBEdit;
    DBEdit81: TDBEdit;
    DBEdit82: TDBEdit;
    DBEdit83: TDBEdit;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    PaFirmaGrid: TPanel;
    DBGrid6: TDBGrid;
    PaParamGrid: TPanel;
    DBGrid7: TDBGrid;
    DBEdit84: TDBEdit;
    Label94: TLabel;
    PaSignGrid: TPanel;
    DBGrid9: TDBGrid;
    DBEdit85: TDBEdit;
    Label95: TLabel;
    PaKontG: TPanel;
    DBGrid3: TDBGrid;
    PARepG: TPanel;
    DBGrid4: TDBGrid;
    DBEdit86: TDBEdit;
    DBEdit87: TDBEdit;
    Label96: TLabel;
    Label97: TLabel;
    tbCustomers: TTabSheet;
    tbObjects: TTabSheet;
    PaKund: TPanel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    SpeedButton2: TSpeedButton;
    edtKNamn: TDBEdit;
    DBEdit88: TDBEdit;
    edtKAdr1: TDBEdit;
    edtKAdr2: TDBEdit;
    edtKPAdr: TDBEdit;
    edtKLand: TDBEdit;
    cbTele1: TDBComboBox;
    cbTele2: TDBComboBox;
    cbTele3: TDBComboBox;
    cbIKund: TDBCheckBox;
    edtKKonto: TDBEdit;
    edtKKStalle: TDBEdit;
    DBEdit89: TDBEdit;
    DBEdit90: TDBEdit;
    DBEdit91: TDBEdit;
    edtKID: TDBEdit;
    edtKPersNr: TDBEdit;
    meKund: TDBMemo;
    cbCards: TDBComboBox;
    cbBetalning: TDBComboBox;
    DBEdit92: TDBEdit;
    edtCreditNo: TDBEdit;
    DBKexp: TDBEdit;
    DBEdit93: TDBEdit;
    cbUtlandsk: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    PaKundG: TPanel;
    DBGrid5: TDBGrid;
    PaObj: TPanel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    GroupBox6: TGroupBox;
    DBMemo2: TDBMemo;
    GroupBox7: TGroupBox;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    DBEdit94: TDBEdit;
    DBEdit95: TDBEdit;
    DBEdit96: TDBEdit;
    DBEdit97: TDBEdit;
    DBEdit98: TDBEdit;
    cbObjTyp: TDBLookupComboBox;
    DBEdit99: TDBEdit;
    DBEdit100: TDBEdit;
    EdtDrvm_km: TDBEdit;
    DBEdit101: TDBEdit;
    DBEdit102: TDBEdit;
    DBEdit106: TDBEdit;
    cbBensin: TDBLookupComboBox;
    DBEdit107: TDBEdit;
    cbPClass: TDBComboBox;
    DBEdit108: TDBEdit;
    DBEdit109: TDBEdit;
    DBEdit110: TDBEdit;
    DBEdit111: TDBEdit;
    PaObjG: TPanel;
    DBGrid12: TDBGrid;
    PageControl1: TPageControl;
    tbReg: TTabSheet;
    Label130: TLabel;
    Edit2: TEdit;
    MaskEdit1: TMaskEdit;
    Label131: TLabel;
    Label132: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label133: TLabel;
    Label134: TLabel;
    Edit5: TEdit;
    Button4: TButton;
    tbAcar: TTabSheet;
    tbCar: TTabSheet;
    tbSettings: TTabSheet;
    Label55: TLabel;
    edtCarStartBild: TEdit;
    Button2: TButton;
    edtACarStartBild: TEdit;
    Label14: TLabel;
    Button3: TButton;
    Label15: TLabel;
    EdtAviFilm: TEdit;
    Button1: TButton;
    Label135: TLabel;
    edtAcarTitle: TEdit;
    Label57: TLabel;
    EdtCarTitel: TEdit;
    Label136: TLabel;
    edtRptKatalog: TEdit;
    edtCustCompanyTimer: TEQFormatEdit;
    edtCustNote: TEQFormatEdit;
    edtDG_Timer: TEQFormatEdit;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    cbACAREnrFaktura: TCheckBox;
    cbACAREnrInterna: TCheckBox;
    cbACAREnrKontant: TCheckBox;
    cbACAREnrKontoK: TCheckBox;
    cbACARIntMoms: TCheckBox;
    cbACARSRISKMoms: TCheckBox;
    cbCARCheckOrgNr: TCheckBox;
    cbCARCheckPnr: TCheckBox;
    cbCARDefaultCDR: TCheckBox;
    cbCARKmKontroll: TCheckBox;
    cbCARPaymentOnBooking: TCheckBox;
    Label140: TLabel;
    edtSDB: TEdit;
    Button5: TButton;
    Label92: TLabel;
    Label93: TLabel;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    Label141: TLabel;
    cbCarDepfaktura: TCheckBox;
    Panel2: TPanel;
    cbCarBC: TCheckBox;
    Label142: TLabel;
    EdtBCCustomerLoginName: TEQFormatEdit;
    EdtBCUserLoginName: TEQFormatEdit;
    Label143: TLabel;
    Label144: TLabel;
    EdtBCPassword: TEQFormatEdit;
    Label145: TLabel;
    tbStations: TTabSheet;
    PaSta: TPanel;
    Label146: TLabel;
    DBEdit112: TDBEdit;
    GroupBox8: TGroupBox;
    DBMemo3: TDBMemo;
    DBLookupComboBox1: TDBLookupComboBox;
    btnStationChange: TButton;
    PaStaG: TPanel;
    DBGrid13: TDBGrid;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    DBEdit113: TDBEdit;
    DBEdit114: TDBEdit;
    edtLang: TDBEdit;
    DBCheckBox9: TDBCheckBox;
    GroupBox9: TGroupBox;
    Label150: TLabel;
    DBEdit115: TDBEdit;
    Label151: TLabel;
    DBEdit116: TDBEdit;
    DBEdit117: TDBEdit;
    Label152: TLabel;
    Label153: TLabel;
    DBEdit119: TDBEdit;
    Label154: TLabel;
    DBEdit120: TDBEdit;
    DBCheckBox10: TDBCheckBox;
    GroupBox10: TGroupBox;
    Label155: TLabel;
    DBEdit121: TDBEdit;
    Label156: TLabel;
    DBEdit122: TDBEdit;
    Label157: TLabel;
    DBEdit123: TDBEdit;
    Label158: TLabel;
    DBEdit124: TDBEdit;
    Label159: TLabel;
    DBEdit125: TDBEdit;
    Label160: TLabel;
    DBEdit126: TDBEdit;
    DBEdit127: TDBEdit;
    Label161: TLabel;
    DBEdit128: TDBEdit;
    Label162: TLabel;
    DBEdit129: TDBEdit;
    Label163: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure tab1Change(Sender: TObject);
    procedure DoGRegSearch(Cont: TDBEdit);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBMemo1Exit(Sender: TObject);
    procedure tbcompanyExit(Sender: TObject);
    procedure tbparamExit(Sender: TObject);
    procedure tbObjectTypesExit(Sender: TObject);
    procedure tbSignaturesExit(Sender: TObject);
    procedure tbCostsExit(Sender: TObject);
    procedure tbPricesExit(Sender: TObject);
    procedure tbrapportExit(Sender: TObject);
    procedure TabSheet2Exit(Sender: TObject);
    procedure DBGrid6CellClick(Column: TColumn);
    procedure DBGrid6KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid7CellClick(Column: TColumn);
    procedure DBGrid7KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid8KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid8CellClick(Column: TColumn);
    procedure DBGrid9CellClick(Column: TColumn);
    procedure DBGrid9KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid10CellClick(Column: TColumn);
    procedure DBGrid10KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure DBGrid4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid8DblClick(Sender: TObject);
    procedure DBGrid9DblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid10DblClick(Sender: TObject);
    procedure DBGrid4DblClick(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure tbCustomersExit(Sender: TObject);
    procedure tbObjectsExit(Sender: TObject);
    procedure DBGrid5DblClick(Sender: TObject);
    procedure DBGrid12DblClick(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TEditExit(Sender: TObject);
    procedure TEditEnter(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ComboBox3Exit(Sender: TObject);
    procedure btnStationChangeClick(Sender: TObject);
    procedure tbStationsExit(Sender: TObject);
    procedure DBGrid13DblClick(Sender: TObject);
  private
    { Private declarations }
    AktTabell: TADOTable;
    procedure GetTable;
  public
    { Public declarations }
  end;

var
  FrmReg: TFrmReg;

implementation

uses Main, Dmod, DmSession, SWSecFunc, FaktUts, dlgStationChange;

{$R *.DFM}



procedure TFrmReg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.ReadIni;
  try
    FrmReg.free;
    frmreg := nil;
  except
  end;
  frmMain.Panel1.visible := True;
  frmMain.S_H_DBNav(False);
  frmMain.DbNavBaz := '';
end;

procedure TFrmReg.Button2Click(Sender: TObject);
begin
  opd2.InitialDir := ExtractFilePath(Application.ExeName);
  if opd2.Execute then
  begin
    edtCarStartBild.text := opd2.filename;
    edtCarStartBild.Modified := true;
    TEditExit(edtCarStartBild);
  end;
end;

procedure TFrmReg.FormActivate(Sender: TObject);
var
  I: Integer;
  Q: tDataset;
begin



  for i := 0 to printer.Printers.Count - 1 do
    ComboBox1.items.Add(printer.Printers.Strings[i]);
  combobox1.Text := frmMain.ValdPrinter;
  if ComboBox1.Text < '!' then
    combobox1.ItemIndex := 0;

  for i := 0 to printer.Printers.Count - 1 do
    ComboBox2.items.Add(printer.Printers.Strings[i]);
  combobox2.Text := frmMain.ValdPrinterRapp;
  if ComboBox2.Text < '!' then
    combobox2.ItemIndex := 0;

  edtAcarTitle.text := frmMain.title;
  edtCarStartBild.text := frmMain.imageCar;
  edtACarStartBild.text := frmMain.image;
  EdtAviFilm.text := frmMain.AviFilm;

  frmMain.speedbutton2.flat := false;
  frmMain.SpeedButton2.Glyph := nil;
  frmMain.ImageList1.GetBitmap(0, frmMain.SpeedButton2.Glyph);

  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.SQL.Text := 'SELECT * FROM Ttyp ORDER BY TELETYP';
  frmMain.dmodq1.Active := True;

  cbTele1.clear;
  while not frmMain.dmodq1.Eof do
  begin
    cbTele1.Items.add(frmMain.dmodq1.FieldByName('TELETYP').AsString + ' ' + frmMain.dmodq1.FieldByName('TELEBESKRIVNING').AsString);
    frmMain.dmodq1.Next;
  end;
  cbTele1.Itemindex := 0;
  cbTele2.items := cbTele1.items;
  cbTele3.items := cbTele1.items;


  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.SQL.Text := 'SELECT * FROM CARDS ORDER BY TYP';
  frmMain.dmodq1.Active := True;
  cbCards.clear;
  while not frmMain.dmodq1.Eof do
  begin
    cbCards.Items.add(frmMain.dmodq1.FieldByName('TYP').AsString + ' ' + frmMain.dmodq1.FieldByName('TYPNAMN').AsString);
    frmMain.dmodq1.Next;
  end;
  cbCards.Itemindex := -1;

  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.SQL.Text := 'SELECT DISTINCT PKLASS FROM PRICETAB ORDER BY PKLASS';
  frmMain.dmodq1.Active := True;
  cbPClass.clear;
  while not frmMain.dmodq1.Eof do
  begin
    cbPClass.Items.add(frmMain.dmodq1.FieldByName('PKLASS').AsString);
    frmMain.dmodq1.Next;
  end;
  cbPClass.Itemindex := -1;


  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.SQL.Text := 'SELECT * FROM BETST ORDER BY KOD';
  frmMain.dmodq1.Active := True;

  cbBetalning.clear;
  while not frmMain.dmodq1.Eof do
  begin
    cbBetalning.Items.add(frmMain.dmodq1.FieldByName('KOD').AsString + ' ' + frmMain.dmodq1.FieldByName('NAMN').AsString);
    frmMain.dmodq1.Next;
  end;
  cbBetalning.Itemindex := 0; // GetBetIndex(DefBetSt);

  frmMain.dmodq1.Active := False;

  Edit5.Text := GetValueFromInit('REG', '!MM', 'Actcode');
  Edit4.Text := GetValueFromInit('REG', '!MM', 'Funktioner');
  Edit3.Text := GetValueFromInit('REG', '!MM', 'Regcode');
  MaskEdit1.Text := GetValueFromInit('REG', '!MM', 'Serial');
  Edit2.Text := GetValueFromInit('REG', '!MM', 'Reg');
  PaFirmaGrid.Align := alClient;
  PaParamGrid.Align := alClient;
  PACostsG.Align := alClient;
  PaObjTypGrid.Align := alClient;
  PaSignGrid.Align := alClient;
  PaPrisGrid.Align := alClient;
  PARepG.Align := alClient;
  PaKontG.Align := alClient;
  PaKundG.Align := alClient;
  PaObjG.Align := alClient;
  PaStaG.Align := alClient;
  Tab1.ActivePage := TabSheet1;

end;

procedure TFrmReg.Button1Click(Sender: TObject);
begin
  ODAvi.InitialDir := ExtractFilePath(Application.ExeName);
  if ODAvi.Execute then
  begin
    EdtAviFilm.text := ODAvi.filename;
    frmMain.AviFilm := ODAvi.filename;
    EdtAviFilm.Modified := true;
    TEditExit(EdtAviFilm);
  end;
end;

procedure TFrmReg.Button3Click(Sender: TObject);
begin
  opd1.InitialDir := ExtractFilePath(Application.ExeName);
  if OPD1.Execute then
  begin
    edtACarStartBild.text := opd1.filename;
    frmMain.image := opd1.filename;
    edtACarStartBild.Modified := true;
    TEditExit(edtACarStartBild);
  end;
end;

procedure TFrmReg.tab1Change(Sender: TObject);
begin
  frmMain.NoFilt; //! för att inte ha det filtrerat vid byte
  frmMain.btnfilter.enabled := False;
  frmMain.btnAsc.enabled := False;
  frmMain.btnDesc.enabled := False;
  frmMain.speedbutton2.flat := false;
  frmMain.SpeedButton2.Glyph := nil;
  frmMain.ImageList1.GetBitmap(0, frmMain.SpeedButton2.Glyph);
  PaFirmagrid.visible := False;
  PaParamgrid.visible := False;
  PaObjTypgrid.visible := False;
  PaSigngrid.visible := False;
  PaCostsg.visible := False;
  PaRepg.visible := False;
  PaKontg.visible := False;
  PaPrisGrid.Visible := False;
  PaKundG.Visible := False;
  PaObjG.Visible := False;
  PaStaG.Visible := False;
  frmMain.FixRaknare;
  case Tab1.ActivePage.Tag of
    0: frmMain.S_H_DBNav(false);
    1: frmMain.S_H_DBNav(True);
    2: frmMain.S_H_DBNav(True);
    3: frmMain.S_H_DBNav(True);
    4: frmMain.S_H_DBNav(True);
    5: frmMain.S_H_DBNav(True);
    6: frmMain.S_H_DBNav(True, False);
    7: frmMain.S_H_DBNav(True);
    8: frmMain.S_H_DBNav(True);
    9: frmMain.S_H_DBNav(True);
    10: frmMain.S_H_DBNav(True);
    11: frmMain.S_H_DBNav(True);
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


procedure TFrmReg.DoGRegSearch(Cont: TDBEdit);
var
  srcValue: string;
begin
  srcValue := '';
  if Cont.DataSource <> nil then
    if Cont.DataField > '' then
      if inputQuery('Sök i fält ' + Cont.DataField, 'Efter', srcValue) and (srcValue > '') then
        if (Cont.DataSource.Dataset is TAdoTable) then
        begin
//          GetProperIndex(Cont.DataSource.Dataset, Cont);
          frmMain.SetSort((Cont.DataSource.Dataset as TAdoTable), Cont.Datafield);
          (Cont.DataSource.Dataset as TAdoTable).Locate(Cont.Datafield, srcValue, [LopartialKey]);
        end;
end;


procedure TFrmReg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  str: string;
begin
  str := '';
  if tab1.ActivePage.Tag <> 8 then
  begin
    if (Key = VK_F2) then
      frmMain.SpeedButton2.Click;
    if Assigned((sender as TForm).ActiveControl) then
      str := (sender as TForm).ActiveControl.ClassName;
    if Str <> 'TDBGrid' then
    begin
      if key in [VK_Next, VK_Prior, VK_Delete, VK_Insert, VK_RETURN, VK_HOME] then
      begin
        getTable;
        if (key = VK_Next) and (shift = [ssCtrl]) then
        begin
          AktTabell.Last;
          Key := 0;
        end
        else
          if (key = VK_Next) then
          begin
            AktTabell.next;
            Key := 0;
          end;
        if (key = VK_Prior) and (shift = [ssCtrl]) then
        begin
          AktTabell.First;
          Key := 0;
        end
        else
          if key = VK_Prior then
          begin
            AktTabell.Prior;
            Key := 0;
          end;
        if (key = VK_HOME) and (shift = [ssCtrl]) then
        begin
          AktTabell.Cancel;
          Key := 0;
        end;
        if (key = VK_Delete) and (shift = [ssCtrl]) then
        begin
          AktTabell.Delete;
          Key := 0;
        end;
        if (key = VK_Insert) and (shift = [ssCtrl]) then
        begin
          AktTabell.Append;
          Key := 0;
        end;
        if (key = VK_RETURN) and (shift = [ssCtrl]) then
        begin
          if AktTabell.state in [dsEdit, dsInsert] then
            AktTabell.Post
          else
            AktTabell.Resync([RmCenter]);
          Key := 0;
        end;
      end;
      if (key = VK_F5) and (ActiveControl is TDBEdit) then
        DoGRegSearch(ActiveControl as TDBEdit);
    end;
  end;
  frmMain.fixraknare;
end;

procedure TFrmReg.GetTable;
begin
  case tab1.ActivePage.Tag of
    1: AktTabell := Dmod2.ObjTypeT;
    2: AktTabell := Dmod2.PriceTabT;
    3: AktTabell := Dmod2.SignrT;
    4: AktTabell := Dmod2.CostsT;
    5: AktTabell := Dmod2.CompanyT;
    6: AktTabell := Dmod2.ParamT;
    7: AktTabell := Dmod2.ReportsT;
    8: AktTabell := Dmod2.KonteringT;
    9: AktTabell := Dmod2.CustomerT;
    10: AktTabell := Dmod2.ObjectT;
  end;
end;

procedure TFrmReg.DBMemo1Exit(Sender: TObject);
begin
  if dmod2.PriceTabT.state in [dsedit, Dsinsert] then
    dmod2.PriceTabT.post;
end;

procedure TFrmReg.tbcompanyExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaFirmagrid.visible := False;
end;

procedure TFrmReg.tbparamExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaParamgrid.visible := False;
end;

procedure TFrmReg.tbObjectTypesExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaObjTypgrid.visible := False;
end;

procedure TFrmReg.tbSignaturesExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaSigngrid.visible := False;
end;

procedure TFrmReg.tbCostsExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaCostsg.visible := False;
end;

procedure TFrmReg.tbPricesExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaPrisgrid.visible := False;
end;

procedure TFrmReg.tbrapportExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaRepg.visible := False;
end;

procedure TFrmReg.TabSheet2Exit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaKontg.visible := False;
end;

procedure TFrmReg.tbCustomersExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaKundG.visible := False;
end;

procedure TFrmReg.tbObjectsExit(Sender: TObject);
begin
//  frmMain.speedbutton2.Caption := 'G';
  PaObjG.visible := False;
end;

procedure TFrmReg.DBGrid6CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid6KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid7CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid8CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid9CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid9KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid1CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid10CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid10KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid4CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid3CellClick(Column: TColumn);
begin
  frmMain.FixRaknare;
end;

procedure TFrmReg.DBGrid8DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.ObjTypeT.fieldbyname('id').asstring;
  PaObjTypGrid.visible := False;
  frmMain.FindBack(dmod2.ObjTypeT, 'Id', bmark);
end;

procedure TFrmReg.DBGrid9DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.SignRT.fieldbyname('Sign').asstring;
  PaSignGrid.visible := False;
  frmMain.FindBack(dmod2.SignrT, 'Sign', bmark);

end;

procedure TFrmReg.DBGrid1DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.CostsT.fieldbyname('Cost_ID').asstring;
  PaCostsG.visible := False;
  frmMain.FindBack(dmod2.CostsT, 'Cost_ID', bmark);

end;

procedure TFrmReg.DBGrid10DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.PriceTabT.fieldbyname('PriceId').asstring;
  PaPrisGrid.visible := False;
  frmMain.FindBack(dmod2.PriceTabT, 'PriceId', bmark);

end;

procedure TFrmReg.DBGrid4DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.ReportsT.fieldbyname('RapportId').asstring;
  PaRepG.visible := False;
  frmMain.FindBack(dmod2.ReportsT, 'RapportId', bmark);
end;

procedure TFrmReg.DBGrid3DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.KonteringT.fieldbyname('Counter').asstring;
  PaKontG.visible := False;
  frmMain.FindBack(dmod2.KonteringT, 'Counter', bmark);

end;

procedure TFrmReg.FormDeactivate(Sender: TObject);
begin
  frmMain.nofilt;
  try
    FrmReg.free;
    frmreg := nil;
  except
  end;
  frmMain.Panel1.visible := True;
  frmMain.S_H_DBNav(False);
  frmMain.DbNavBaz := '';
end;


procedure TFrmReg.DBGrid5DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.CustomerT.fieldbyname('cust_id').asstring;
  PaKundG.visible := False;
  frmMain.FindBack(dmod2.CustomerT, 'cust_id', bmark);
  frmMain.SpeedButton2Click(nil);
end;

procedure TFrmReg.DBGrid12DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.ObjectT.fieldbyname('reg_no').asstring;
  PaObjG.visible := False;
  frmMain.FindBack(dmod2.ObjectT, 'reg_no', bmark);
  frmMain.SpeedButton2Click(nil);
end;

procedure TFrmReg.Edit3Exit(Sender: TObject);
begin
  if Length(Edit3.Text) <> 11 then
  begin
    ShowMessage('Felaktig Registreringskod');
    exit;
  end;

  if Edit3.Text <> GetRegCode(Edit2.Text, MaskEdit1.Text) then
  begin
    ShowMessage('Felaktig Registreringskod');
  end;
end;

procedure TFrmReg.Edit5Exit(Sender: TObject);
begin
  if Length(Edit5.Text) <> 11 then
  begin
    ShowMessage('Felaktig aktiveringskod');
    exit;
  end;
  if Edit5.Text <> GetActCode(copy(Edit4.Text, 1, 11), Edit3.Text) then
    ShowMessage('Felaktig aktiveringskod');
end;

procedure TFrmReg.Edit4Exit(Sender: TObject);
begin
  if Length(Edit4.Text) < 11 then
  begin
    Edit4.Text := copy(edit4.Text + '000000000000000', 1, 11);
  end;
end;

procedure TFrmReg.Button4Click(Sender: TObject);
var
  Q: TADOQuery;
begin
  if Length(Edit4.Text) >= 11 then
  begin
    if Length(Edit3.Text) = 11 then
    begin
      if Edit3.Text = GetRegCode(Edit2.Text, MaskEdit1.Text) then
      begin
        if Length(Edit5.Text) = 11 then
        begin
          if Edit5.Text = GetActCode(copy(Edit4.Text, 1, 11), Edit3.Text) then
          begin
            Dmod2.CompanyT.Edit;
            Dmod2.CompanyT.FieldByName('COMPANY').AsString := Edit2.Text;
            Dmod2.CompanyT.FieldByName('ORG_NR').AsString := MaskEdit1.Text;
            Dmod2.CompanyT.Post;
            SetValueToInit('REG', '!MM', 'Actcode', Edit5.Text);
            SetValueToInit('REG', '!MM', 'Funktioner', Edit4.Text);
            SetValueToInit('REG', '!MM', 'Regcode', Edit3.Text);
            SetValueToInit('REG', '!MM', 'Serial', MaskEdit1.Text);
            SetValueToInit('REG', '!MM', 'Reg', Edit2.Text);


          end;
        end;
      end;
    end;
  end;


end;

procedure TFrmReg.TEditExit(Sender: TObject);
begin
{  if TEdit(Sender).Modified then
  begin}

  { Inställningar ACAR }
    if (Sender = edtAcarTitle) then
      SetValueToInit('ACAR', '!MM', 'Title', TEdit(Sender).Text);
    if (Sender = cbACAREnrFaktura) then
      SetValueToInit('CAR', '!MM', 'EnrFaktura', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbACAREnrInterna) then
      SetValueToInit('CAR', '!MM', 'EnrInterna', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbACAREnrKontant) then
      SetValueToInit('CAR', '!MM', 'EnrKontant', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbACAREnrKontoK) then
      SetValueToInit('CAR', '!MM', 'EnrKontoK', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbACARIntMoms) then
      SetValueToInit('CAR', '!MM', 'IntMoms', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbACARSRISKMoms) then
      SetValueToInit('CAR', '!MM', 'SRISKMoms', BoolToStr(TCheckBox(Sender).Checked));



  { Inställningar CAR }
    if (Sender = EdtCarTitel) then
      SetValueToInit('CAR', '!MM', 'Title', TEdit(Sender).Text);
    if (Sender = cbCARCheckOrgNr) then
      SetValueToInit('CAR', '!MM', 'CheckOrgNr', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbCARCheckPnr) then
      SetValueToInit('CAR', '!MM', 'CheckPnr', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbCARDefaultCDR) then
      SetValueToInit('CAR', '!MM', 'DefaultCDR', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbCARKmKontroll) then
      SetValueToInit('CAR', '!MM', 'KmKontroll', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbCARPaymentOnBooking) then
      SetValueToInit('CAR', '!MM', 'PaymentOnBooking', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbCarDepfaktura) then
      SetValueToInit('CAR', '!MM', 'DepFaktura', BoolToStr(TCheckBox(Sender).Checked));
    if (Sender = cbCarBC) then
      SetValueToInit('CAR', '!MM', 'BC', BoolToStr(TCheckBox(Sender).Checked));

    if (Sender = EdtBCCustomerLoginName) then
      SetValueToInit('CAR', '!MM', 'BCCustomerLoginName', TEdit(Sender).Text);
    if (Sender = EdtBCUserLoginName) then
      SetValueToInit('CAR', '!MM', 'BCUserLoginName', TEdit(Sender).Text);
    if (Sender = EdtBCPassword) then
      SetValueToInit('CAR', '!MM', 'BCPassword', TEdit(Sender).Text);

  { Inställningar Generell }
    if (Sender = edtCarStartBild) then
      SetValueToInit('CAR', '!MM', 'Image', TEdit(Sender).Text);
    if (Sender = edtACarStartBild) then
      SetValueToInit('ACAR', '!MM', 'Image', TEdit(Sender).Text);
    if (Sender = EdtAviFilm) then
      SetValueToInit('CAR', '!MM', 'AviFilm', TEdit(Sender).Text);
    if (Sender = edtRptKatalog) then
      SetValueToInit('CAR', '!MM', 'rptDirectory', TEdit(Sender).Text);

{  end; }

  if (Sender = ComboBox1) then
    SetValueToInit('CAR', '!MM', 'Skrivare', TComboBox(Sender).Text);
  if (Sender = ComboBox2) then
    SetValueToInit('CAR', '!MM', 'SkrivarRapp', TComboBox(Sender).Text);


end;

procedure TFrmReg.TEditEnter(Sender: TObject);
begin

  { Inställningar ACAR }
  if (Sender = edtAcarTitle) then
    TEdit(Sender).Text := GetValueFromInit('ACAR', '!MM', 'Title', 'ACar');
  if (Sender = cbACAREnrFaktura) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'EnrFaktura', 'False'));
  if (Sender = cbACAREnrInterna) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'EnrInterna', 'False'));
  if (Sender = cbACAREnrKontant) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'EnrKontant', 'False'));
  if (Sender = cbACAREnrKontoK) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'EnrKontoK', 'False'));

  if (Sender = cbACARIntMoms) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'IntMoms', 'False'));
  if (Sender = cbACARSRISKMoms) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'SRISKMoms', 'False'));


  { Inställningar CAR }
  if (Sender = EdtCarTitel) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'Title', 'Car');
  if (Sender = edtCustCompanyTimer) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'CustCompanyTimer', '0');
  if (Sender = edtCustNote) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'CustNote', '0');
  if (Sender = edtDG_Timer) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'DG_Timer', '0');

  if (Sender = edtBCCustomerLoginName) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'BCCustomerLoginName', '');
  if (Sender = edtBCUserLoginName) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'BCUserLoginName', '');
  if (Sender = edtBCPassword) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'BCPassword', '');






  if (Sender = cbCARCheckOrgNr) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'CheckOrgNr', 'False'));
  if (Sender = cbCARCheckPnr) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'CheckPnr', 'False'));
  if (Sender = cbCARDefaultCDR) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'DefaultCDR', 'False'));
  if (Sender = cbCARKmKontroll) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'KmKontroll', 'False'));
  if (Sender = cbCARPaymentOnBooking) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'PaymentOnBooking', 'False'));

  if (Sender = cbCarDepfaktura) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'DepFaktura', 'False'));
  if (Sender = cbCarBC) then
    TCheckBox(Sender).Checked := StrToBool(GetValueFromInit('CAR', '!MM', 'BC', 'False'));


  if (Sender = ComboBox3) then
    TComboBox(Sender).ItemIndex := StrToInt(GetValueFromInit('CAR', PBKGetClientName, 'ComPort', '0'));


  { Inställningar Generell }
  if (Sender = edtCarStartBild) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'Image', ExtractFilePath(Application.ExeName) + 'Bilder\C2.jpg');
  if (Sender = edtACarStartBild) then
    TEdit(Sender).Text := GetValueFromInit('ACAR', '!MM', 'Image', ExtractFilePath(Application.ExeName) + 'Bilder\ACar2.jpg');
  if (Sender = EdtAviFilm) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'AviFilm', ExtractFilePath(Application.ExeName) + 'Bilder\Car2000.avi');
  if (Sender = edtRptKatalog) then
    TEdit(Sender).Text := GetValueFromInit('CAR', '!MM', 'rptDirectory', ExtractFilePath(Application.ExeName) + 'Rapporter\');
  if (Sender = ComboBox1) then
    TComboBox(Sender).Text := GetValueFromInit('CAR', '!MM', 'Skrivare');
  if (Sender = ComboBox2) then
    TComboBox(Sender).Text := GetValueFromInit('CAR', '!MM', 'SkrivarRapp');



  TEdit(Sender).Modified := False;
end;

procedure TFrmReg.Button5Click(Sender: TObject);
var
  s: string;
begin
  S := PromptDataSource(0, edtSDB.Text);
  if S <> '' then
  begin
    edtSDB.Text := S;
    edtSDB.Modified := true;
    TEditExit(edtSDB);
  end;
end;

procedure TFrmReg.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = tbAcar then
  begin
    TEditEnter(edtAcarTitle);
    TEditEnter(cbACAREnrFaktura);
    TEditEnter(cbACAREnrInterna);
    TEditEnter(cbACAREnrKontant);
    TEditEnter(cbACAREnrKontoK);
    TEditEnter(cbACARIntMoms);
    TEditEnter(cbACARSRISKMoms);
  end;
  if PageControl1.ActivePage = tbCar then
  begin
    TEditEnter(EdtCarTitel);
    TEditEnter(edtCustCompanyTimer);
    TEditEnter(edtCustNote);
    TEditEnter(edtDG_Timer);
    TEditEnter(cbCARCheckOrgNr);
    TEditEnter(cbCARCheckPnr);
    TEditEnter(cbCARDefaultCDR);
    TEditEnter(cbCARKmKontroll);
    TEditEnter(cbCARPaymentOnBooking);
    TEditEnter(ComboBox3);
    TEditEnter(cbCarBC);
    TEditEnter(EdtBCCustomerLoginName);
    TEditEnter(EdtBCUserLoginName);
    TEditEnter(EdtBCPassword);

  end;
  if PageControl1.ActivePage = tbSettings then
  begin
    TEditEnter(edtCarStartBild);
    TEditEnter(edtACarStartBild);
    TEditEnter(EdtAviFilm);
    TEditEnter(edtRptKatalog);
    TEditEnter(edtSDB);
  end;

end;

procedure TFrmReg.ComboBox3Exit(Sender: TObject);
begin
  if (Sender = ComboBox3) then
    SetValueToInit('CAR', PBKGetClientName, 'ComPort', IntToStr(TComboBox(Sender).ItemIndex));
end;

procedure TFrmReg.btnStationChangeClick(Sender: TObject);
begin
  StationChangeDlg.ShowModal;
end;

procedure TFrmReg.tbStationsExit(Sender: TObject);
begin
  PaStaG.Visible := false;
end;

procedure TFrmReg.DBGrid13DblClick(Sender: TObject);
var
  bmark: string;
begin

  bmark := dmod2.StationT.fieldbyname('Name').AsString;
  PaStaG.visible := False;
  frmMain.FindBack(dmod2.StationT, 'Name', bmark);
  frmMain.SpeedButton2Click(nil);

end;

end.

