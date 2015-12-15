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
{ $Log:  13501: FormReg.pas
{
{   Rev 1.1    2004-01-29 10:24:22  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:24:10  peter
{ 2004-01-28 : Start av version 2004
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
  Buttons, ADODB, DB, Printers, DBClient;

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
    Label57: TLabel;
    EdtTitel: TEdit;
    Label55: TLabel;
    EdtSBild: TEdit;
    Button2: TButton;
    Label14: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Label15: TLabel;
    EdtAvi: TEdit;
    Button1: TButton;
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
    Label92: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label93: TLabel;
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

uses Main, Dmod, DmSession;

{$R *.DFM}



procedure TFrmReg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.imageCar := edtSBild.text;
  frmMain.Title := edtTitel.text;
  frmMain.image := edit1.text;
  frmMain.ValdPrinter := ComboBox1.Text;
  frmMain.ValdPrinterRapp := ComboBox2.Text;
  frmReg.Free;
  frmReg := nil;
  frmMain.Panel1.visible := True;
  frmMain.S_H_DBNav(False);
  frmMain.DbNavBaz := '';
end;

procedure TFrmReg.Button2Click(Sender: TObject);
begin
  opd2.InitialDir := ExtractFilePath(Application.ExeName);
  if opd2.Execute then edtsbild.text := opd2.filename;
end;

procedure TFrmReg.FormActivate(Sender: TObject);
var
  I: Integer;
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

  edtTitel.text := frmMain.title;
  edtsbild.text := frmMain.imageCar;
  edit1.text := frmMain.image;
  EdtAvi.text := frmMain.AviFilm;

  frmMain.speedbutton2.flat := false;
  frmMain.SpeedButton2.Glyph := nil;
  frmMain.ImageList1.GetBitmap(0, frmMain.SpeedButton2.Glyph);

  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.SQL.Text := 'SELECT * FROM TTYP ORDER BY TELETYP';
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

end;

procedure TFrmReg.Button1Click(Sender: TObject);
begin
  ODAvi.InitialDir := ExtractFilePath(Application.ExeName);
  if ODAvi.Execute then
  begin
    EdtAvi.text := ODAvi.filename;
    frmMain.AviFilm := ODAvi.filename;
  end;
end;

procedure TFrmReg.Button3Click(Sender: TObject);
begin
  opd1.InitialDir := ExtractFilePath(Application.ExeName);
  if OPD1.Execute then
  begin
    edit1.text := opd1.filename;
    frmMain.image := opd1.filename;
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
  frmMain.FixRaknare;
  case Tab1.ActivePage.Tag of
    0: frmMain.S_H_DBNav(false);
    1: frmMain.S_H_DBNav(True);
    2: frmMain.S_H_DBNav(True);
    3: frmMain.S_H_DBNav(True);
    4: frmMain.S_H_DBNav(True);
    5: frmMain.S_H_DBNav(True);
    6: frmMain.S_H_DBNav(True);
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
          AktTabell.Insert;
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
  FrmReg.free;
  frmreg := nil;
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

end.

