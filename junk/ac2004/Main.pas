{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Main.pas
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
{ $Log:  13489: Main.pas
{
{   Rev 1.2    2004-01-30 14:44:20  peter
{ Fixat journal + kontering + + + +
}
{
{   Rev 1.1    2004-01-29 10:24:20  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:21:28  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.4    2004-01-28 14:40:18  peter
}
{
{   Rev 1.3    2003-10-14 13:12:56  peter
{ Fixat utskrift av kontokort samt sortering i internt fakturanummer.
}
{
{   Rev 1.2    2003-08-04 11:58:46  Supervisor
}
{
{   Rev 1.1    2003-03-21 10:16:08  peter
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
{   Rev 1.0    2003-03-17 14:28:08  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants, ComCtrls, Buttons, StdCtrls, ExtCtrls, Menus, ToolWin, DB, ADODB,
  ImgList;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Arkiv1: TMenuItem;
    Hjlp1: TMenuItem;
    Loggain1: TMenuItem;
    Loggaut1: TMenuItem;
    N1: TMenuItem;
    Avsluta1: TMenuItem;
    N2: TMenuItem;
    Om1: TMenuItem;
    Image1: TImage;
    Uppfljning1: TMenuItem;
    Rapporter1: TMenuItem;
    Statistik1: TMenuItem;
    StatusBar1: TStatusBar;
    Underhll1: TMenuItem;
    Grundregister1: TMenuItem;
    OD1: TOpenDialog;
    Bearbetning1: TMenuItem;
    Halvstatiskaregister1: TMenuItem;
    Fakturering1: TMenuItem;
    Fakturautskrift1: TMenuItem;
    Kontera1: TMenuItem;
    Internfakturautskrift1: TMenuItem;
    Utskrift1: TMenuItem;
    Sql1: TMenuItem;
    KomprimeraReparera1: TMenuItem;
    SparaPrislista1: TMenuItem;
    Spara1: TMenuItem;
    Lsin1: TMenuItem;
    ToolBar1: TToolBar;
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
    RapporterAccess1: TMenuItem;
//    Speedbutton2: TTransparentButton2;
    ImageList1: TImageList;
    Statistik2: TMenuItem;
    ToolBar2: TToolBar;
    SpBtnGreg: TSpeedButton;
    SpBtnKomp: TSpeedButton;
    SpBtnSql: TSpeedButton;
    SPBtnStat: TSpeedButton;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    ndraDatabas1: TMenuItem;
    N3: TMenuItem;
    Splitter6: TSplitter;
    SpeedButton2: TSpeedButton;
    init: TADOTable;
    Backup1: TMenuItem;
    SaveDialog1: TSaveDialog;
    BtnTotRecNo: TEdit;
    BtnRecNo: TEdit;
    Splitter7: TSplitter;
    dmodq1: TADOQuery;
    Standardrapporter1: TMenuItem;
    FakturautskriftKontant1: TMenuItem;
    FakturautskriftKontokort1: TMenuItem;
    Contents: TMenuItem;
    SearchforHelpOn: TMenuItem;
    HowtoUseHelp: TMenuItem;
    function CheckKontFakt(Nr: string): Boolean;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Loggain1Click(Sender: TObject);
    procedure Loggaut1Click(Sender: TObject);
    procedure Grundregister1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Avsluta1Click(Sender: TObject);
    procedure Halvstatiskaregister1Click(Sender: TObject);
    procedure Om1Click(Sender: TObject);
    procedure Fakturering1Click(Sender: TObject);
    procedure Fakturautskrift1Click(Sender: TObject);
    procedure Kontera1Click(Sender: TObject);
    procedure SkapaKontrRadPost(typ, nr, konto, kstalle: integer; debet, kredit: Double);
    procedure Internfakturautskrift1Click(Sender: TObject);
    function GetKonto(RadTyp: Integer): Integer;
    function GetKstalle(Nr: integer): Integer;
    function GetKFKonto(nr: integer): Integer;
    procedure Sql1Click(Sender: TObject);
    procedure KomprimeraReparera1Click(Sender: TObject);
    procedure Spara1Click(Sender: TObject);
    procedure Lsin1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Fixraknare;
    procedure MoveNxt;
    procedure MovePrev;
    procedure MovrFrst;
    procedure MoveLst;
    procedure Ins;
    procedure Del;
    procedure Canc;
    procedure S_Post;
    procedure Refr;
    procedure NoFilt;
    procedure FindBack(data: TAdoTable; tabell, BMark: string);
    procedure S_H_DBNav(val: Boolean);
    procedure BtnPlusenClick(Sender: TObject);
    procedure BtnFirstClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCanClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnFilterClick(Sender: TObject);
    procedure BtnMinEnClick(Sender: TObject);
    procedure BtnUpdClick(Sender: TObject);
    procedure HelpSortClick(SortOrder: string);
    procedure BtnASCClick(Sender: TObject);
    procedure BtnDESCClick(Sender: TObject);
    procedure Statistik2Click(Sender: TObject);
    procedure LevelFix(SL: Integer);
    procedure KillProgram(Classname: string; WindowTitle: string);
    procedure SPBtnStatClick(Sender: TObject);
    procedure SpBtnGregClick(Sender: TObject);
    procedure SpBtnKompClick(Sender: TObject);
    procedure SpBtnSqlClick(Sender: TObject);
    procedure ndraDatabas1Click(Sender: TObject);
    function GetActPrint: string;
    function IsCustKoncern(KundNr: Integer): Boolean;
    procedure Backup1Click(Sender: TObject);
    procedure Standardrapporter1Click(Sender: TObject);
    procedure FakturautskriftKontant1Click(Sender: TObject);
    procedure FakturautskriftKontokort1Click(Sender: TObject);
    procedure ContentsClick(Sender: TObject);
    procedure SearchforHelpOnClick(Sender: TObject);
    procedure HowtoUseHelpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    procedure MenuOpen(val: boolean);
    procedure WriteIni;
    procedure LoadReports;
    procedure PrintRapp(sender: TObject);
    function GetMenuItem(var Top: TMenuItem; srcCaption: string): boolean;
{    function RoundBaz(X: Extended): Extended;
    function RoundUp(X: Extended): Extended;
    function RoundDn(X: Extended): Extended;
    function Sgn(X: Extended): Integer;  }

    { Private declarations }
  public
    SecLevel: Integer;
    ValdPrinter: string;
    ValdPrinterRapp: string;
    InLoggad: Boolean;
    Preview: Boolean;
    Title: string;
    DbTitle: string;
    DbConn: string;
    image, ImageCar, AviFilm: string;
    rptdirectory: string;
    LastLogin, sign: string;
    avrundning: integer;
    AvrundningKostst: Integer;
    Stang, DBExcists, Quit: Boolean;
    DBNavBaz: string;
    KoncernKund: Boolean;
    procedure ReadIni;
    procedure SetSort(tbl: TADOTable; SortOn: string);
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  Kstalle: Integer;
  Rowsearch: Boolean;
  FirstTime: Boolean;
  BDir: string;
  DbWay: string;
  ObjList : TList;

const
  DBDel = '''';

implementation

uses Dmod, PrintDialog, Login, FormReg, Statiska, About, FaktUts, FrmSql,
  DBCMain, DmSession, EqiniStrings, Utskrifter, Utskrift, eqprn, func;

{$R *.DFM}

{ TForm1 }


procedure TfrmMain.SetSort(tbl: TADOTable; SortOn: string);
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


procedure TfrmMain.ReadIni;
var
  CarIni: TEqiniStrings;
  ds: TADOQuery;
begin
  ds := CreateDS('SELECT * FROM INI WHERE PROG=''ACar'' AND SIGNR=''!MM''');
  try
    ds.Open;
    carini := TEqIniStrings.Create('');
    CarIni.Text := ds.FieldByName('ini').AsString;
    with CarIni do
    begin
      Preview := ReadBool('Setup', 'Preview', true);
      rptDirectory := ReadString('Setup', 'rptDirectory', 'C:\Program\Car2000\Databas\Rapporter\');
      LastLogin := ReadString('ACar', 'LastLogin', '');
      Avrundning := ReadInteger('Acar', 'A-konto', 9390);
      AvrundningKostST := ReadInteger('Acar', 'A-kostSt', 9980);
      image := readstring('ACar', 'image', ExtractFilePath(Application.ExeName) + 'Bilder\ACar2.jpg');
      ValdPrinter := ReadString('Params', 'Skrivare', GetActPrint);
      ValdPrinterRapp := ReadString('Params', 'SkrivarRapp', GetActPrint);
      AviFilm := ReadString('Params', 'AviFilm', ExtractFilePath(Application.ExeName) + 'Bilder\Car2000.avi');
      Title := ReadString('Params', 'Title', 'Car2000');
      ImageCar := Readstring('Params', 'Image', ExtractFilePath(Application.ExeName) + 'Bilder\C2.jpg');
    end;
    CarIni.Free;
  except
    WriteDebug('System','Fel i ReadIni!');
  end;
  FreeDS(ds);
end;

procedure TfrmMain.WriteIni;
var
  CarIni: TEqIniStrings;
  ds: TADOQuery;
begin
  carini := TEqIniStrings.Create('');
  with CarIni do
  begin
    if LastLogin > '' then
      WriteString('ACar', 'LastLogin', LastLogin);
    WriteString('Params', 'Skrivare', ValdPrinter);
    WriteString('Params', 'SkrivarRapp', ValdPrinterRapp);
    writestring('ACar', 'Image', Image);
    WriteString('Params', 'Title', Title);
    writestring('Params', 'Image', ImageCar);
    writestring('Params', 'AviFilm', AviFilm);
    WriteInteger('ACar', 'A-Konto', Avrundning);
    WriteInteger('ACar', 'A-KostSt', AvrundningKostSt);
  end;

  ds := CreateDS('SELECT * FROM INI WHERE PROG=''ACar'' AND SIGNR=''!MM''');
  try
    ds.Open;
    if ds.IsEmpty then
      ds.Append
    else
      ds.Edit;
    ds.FieldByName('Ini').AsString := CarIni.Text;
    ds.Post;
  except
    WriteDebug('System','Fel i WriteIni!');
  end;
  CarIni.Free;
  FreeDS(ds);
end;

procedure TfrmMain.LoadReports;
var
  myMenu, NewItem: TMenuItem;
  ds: TADOQuery;
begin
  ds := CreateDS('SELECT * FROM REPORTS WHERE PROGRAM=''ACar2000'' AND ACCESSTYPE=''R''');
  try
    ds.Open;
    with ds do
    begin
      while not EOF do
      begin
        NewItem := TMenuItem.Create(Self);
        ObjList.Add(NewItem);
        NewItem.Caption := Fieldbyname('MenuName').AsString;
        if NewItem.Caption <> '-' then
        begin
          NewItem.hint := Fieldbyname('CallName').AsString;
          if NewItem.hint > '!' then
            NewItem.Onclick := PrintRapp;
          try
            NewItem.Tag := Fieldbyname('Rep_UTyp').AsInteger;
          except
            NewItem.Tag := 0;
          end;
        end;
        if GetMenuItem(myMenu, Fieldbyname('Meny').AsString) then
        begin
          myMenu.Add(NewItem);
        end;
        Next;
      end;
    end;
  except
    WriteDebug('System','Fel i LoadReports!');
  end;
  FreeDS(ds);
end;

procedure TfrmMain.PrintRapp(sender: TObject);
var
  ds : TADOQuery;
begin
  if (Sender as TMenuItem).hint > '!' then
  begin
    ds := CreateDS('');
    try
      frmPrintDialog := TfrmPrintDialog.Create(Self);
      frmPrintDialog.Q1 := ds;
      frmPrintDialog.FormCaption := (Sender as TMenuItem).Caption;
      try
        frmPrintDialog.UrvalsTyp := (Sender as TMenuItem).Tag;
      except
        frmPrintDialog.UrvalsTyp := 0;
      end;
      frmPrintDialog.ReportFileName := rptDirectory + (Sender as TMenuItem).hint;
      frmPrintDialog.ShowModal;
      frmPrintDialog.Free;
    except
      WriteDebug('System','Fel i PrintRapp');
    end;
    FreeDS(ds);
  end;
end;

procedure TfrmMain.MenuOpen(val: boolean);
begin
  SPBtnStat.Enabled := Val;
  SpBtnGreg.Enabled := Val;
  SpBtnSql.Enabled := Val;
  Loggain1.Enabled := not Val;
  Loggaut1.Enabled := Val;
  Uppfljning1.enabled := Val;
  Underhll1.enabled := Val;
  Bearbetning1.enabled := Val;
end;

procedure TfrmMain.SkapaKontrRadPost(typ, nr, konto, kstalle: integer; debet,
  kredit: Double);
begin
  if (debet = 0) and (kredit = 0) then
    exit;
  dmod2.KnterRadT.Append;
  dmod2.KnterRadTNrTyp.AsInteger := typ;
  dmod2.KnterRadTNummer.AsInteger := Nr;
  dmod2.KnterRadTKonto.AsInteger := konto;
  dmod2.KnterRadTDebet.AsCurrency := debet; //!AsCurrency
  dmod2.KnterRadTKredit.AsCurrency := kredit; //!AsCurrency
  dmod2.KnterRadTKSTALLE.AsInteger := kstalle;
  dmod2.KnterRadT.Post;
end;

function TfrmMain.GetKonto(RadTyp: Integer): Integer;
begin
  if rowsearch = true then
  begin
    if dmod2.Contr_SubCostRowT.Fieldbyname('Value').asfloat > 0 then
      Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Kredit').asinteger;
    if dmod2.Contr_SubCostRowT.Fieldbyname('Value').asfloat < 0 then
      Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Debet').asinteger;
  end
  else
  begin
    if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat > 0 then
      Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Debet').asinteger;
    if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat < 0 then
      Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Kredit').asinteger;
  end;
  if dmod2.KonteringT.Locate('Konteringsid', Radtyp, [LoCaseInsensitive]) then
  begin
//! Här ska det in om det är till KoncerBolagsKund
    if dmod2.Contr_SubT.Fieldbyname('Payment').asstring = 'I'
      then
      result := dmod2.KonteringT.Fieldbyname('InternKontoNr').asinteger
    else
      result := dmod2.KonteringT.Fieldbyname('KontoNr').asinteger;
    if KoncernKund then
      result := dmod2.KonteringT.Fieldbyname('KoncernKontoNr').asinteger;
  end
  else
  begin
    dmod2.CostsT.Locate('Costname', Dmod2.Contr_SubCostRowT.FieldByName('Rowtext').asstring, [LoCaseInsensitive]);
    result := dmod2.CostsT.FieldByName('Acc_Code').asinteger;
    kstalle := dmod2.CostsT.FieldByName('Acc_Center').asinteger;
  end;
end;

function TfrmMain.GetKstalle(Nr: integer): Integer;
begin
//!
  Result := 0;
end;

function TfrmMain.GetKFKonto(nr: integer): Integer;
begin
//!
  case nr of
    0: result := dmod2.KonteringT.fieldbyname('KontoNr').asinteger;
    1:
      begin
        dmod2.CustomerT.first;
        dmod2.CustomerT.Locate('Cust_Id', dmod2.Contr_SubT.Fieldbyname('SubCustId').asinteger, [LoCaseInsensitive]);
        if dmod2.CustomerT.Fieldbyname('IKonto').asinteger > 0 then
        begin
          result := Dmod2.CustomerT.Fieldbyname('IKonto').asinteger;
          Kstalle := Dmod2.CustomerT.Fieldbyname('IKStalle').asinteger;
        end
        else
        begin
          if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat > 0 then
          begin
            result := dmod2.KonteringT.FieldByName('InternKontoNr').asinteger;
            Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Debet').asinteger;
          end;
          if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat < 0 then
          begin
            result := dmod2.KonteringT.FieldByName('InternKontoNr').asinteger;
            Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Kredit').asinteger;
          end;
        end;
      end;
    3:
      begin
        if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat > 0 then
        begin
          result := dmod2.KonteringT.FieldByName('KontoNr').asinteger;
          Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Debet').asinteger;
        end;
        if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat < 0 then
        begin
          result := dmod2.KonteringT.FieldByName('KontoNr').asinteger;
          Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Kredit').asinteger;
        end;
      end;
    4:
      begin
        if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat > 0 then
        begin
          result := dmod2.KonteringT.FieldByName('KontoNr').asinteger;
          Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Debet').asinteger;
        end;
        if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat < 0 then
        begin
          result := dmod2.KonteringT.FieldByName('KontoNr').asinteger;
          Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Kredit').asinteger;
        end;
      end;
    99:
      begin
        if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat > 0 then
        begin
          result := dmod2.KonteringT.FieldByName('KoncernKontoNr').asinteger;
          Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Debet').asinteger;
        end;
        if dmod2.Contr_SubCostT.FieldByName('DTotal').asfloat < 0 then
        begin
          result := dmod2.KonteringT.FieldByName('KoncernKontoNr').asinteger;
          Kstalle := dmod2.ParamT.Fieldbyname('KStalle_Kredit').asinteger;
        end;
      end;

  end;
end;

function FindMenuItem(Top: TMenuItem; srcCaption: string): TMenuItem;
var
  I: Integer;
begin
  result := nil;
  if srcCaption = Top.Caption then
    result := Top
  else
    for I := 0 to Top.Count - 1 do
      if not assigned(result) then
        result := FindMenuItem(Top.items[I], srcCaption);
end;

function TfrmMain.GetMenuItem(var Top: TMenuItem;
  srcCaption: string): boolean;
begin
  Top := FindMenuItem(Uppfljning1, srcCaption);
  if Top = nil then
  begin
    Top := TMenuItem.Create(Self);
    Top.Caption := srcCaption;
    Uppfljning1.Add(Top);
  end;
  result := true;
end;

procedure TfrmMain.KomprimeraReparera1Click(Sender: TObject);
var
  i: integer;
begin
  screen.Cursor := crHourglass;

//  dmod1.adoconnection1.connected := false;
//  db.database := dbway;
//  db.CompactAccessDatabase(dbway, '');
//  db.RepairAccessDatabase(dbway, '');
//  dmod1.adoconnection1.connected := true;
  for I := 0 to dmod2.ComponentCount - 1 do
    if dmod2.Components[I] is TAdoTable then
      (dmod2.Components[I] as TAdoTable).open;

  screen.Cursor := crDefault;
  Showmessage('Databasen är nu komprimerad/reparerad');
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    if speedbutton2.Flat then
    begin
      speedbutton2.flat := false;
      SpeedButton2.Glyph := nil;
      ImageList1.GetBitmap(0, SpeedButton2.Glyph);
      case frmreg.tab1.ActivePageIndex of
        1: frmreg.PaFirmaGrid.Visible := False;
        2: frmreg.PaParamGrid.Visible := False;
        3: frmreg.PaObjTypGrid.Visible := False;
        4: frmreg.PaSignGrid.Visible := False;
        5: frmreg.PaCostsG.Visible := False;
        6: frmreg.PaPrisGrid.Visible := False;
        7: frmreg.PaRepG.Visible := False;
        8: frmreg.PaKontG.Visible := False;
        9: frmreg.PaKundG.Visible := False;
        10: frmreg.PaObjG.Visible := False;
      end;
      btnfilter.enabled := False;
      btnAsc.enabled := False;
      btnDesc.enabled := False;
    end else begin
      speedbutton2.Flat := true;
      SpeedButton2.Glyph := nil;
      ImageList1.GetBitmap(2, SpeedButton2.Glyph);
      case frmreg.tab1.ActivePageIndex of
        1: frmreg.PaFirmaGrid.Visible := True;
        2: frmreg.PaParamGrid.Visible := True;
        3: frmreg.PaObjTypGrid.Visible := True;
        4: frmreg.PaSignGrid.Visible := True;
        5: frmreg.PaCostsG.Visible := True;
        6: frmreg.PaPrisGrid.Visible := True;
        7: frmreg.PaRepG.Visible := True;
        8: frmreg.PaKontG.Visible := True;
        9: frmreg.PaKundG.Visible := True;
        10: frmreg.PaObjG.Visible := True;
      end;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    if speedbutton2.Flat then
    begin
      speedbutton2.flat := false;
      SpeedButton2.Glyph := nil;
      ImageList1.GetBitmap(0, SpeedButton2.Glyph);
      case FrmStatiska.PageControl1.ActivePageIndex of
        0: FrmStatiska.PaBetsG.Visible := False;
        1: FrmStatiska.PaDrivMG.Visible := False;
        2: FrmStatiska.PaKontokG.Visible := False;
        3: FrmStatiska.PaTeleG.Visible := False;
      end;
      btnfilter.enabled := False;
      btnAsc.enabled := False;
      btnDesc.enabled := False;
    end else begin
      speedbutton2.flat := true;
      SpeedButton2.Glyph := nil;
      ImageList1.GetBitmap(2, SpeedButton2.Glyph);
      case FrmStatiska.PageControl1.ActivePageIndex of
        0: FrmStatiska.PaBetsG.Visible := True;
        1: FrmStatiska.PaDrivMG.Visible := True;
        2: FrmStatiska.PaKontokG.Visible := True;
        3: FrmStatiska.PaTeleG.Visible := True;
      end;
    end; //!Statiska
  end;

  btnfilter.enabled := True;
  btnAsc.enabled := True;
  btnDesc.enabled := True;
  frmMain.Fixraknare;
end;

procedure TfrmMain.Fixraknare;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1:
        begin
          dmod2.ObjTypeT.Open;
          btnRecNo.Text := inttostr(dmod2.ObjTypeT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.ObjTypeT.recordcount);
        end;
      2:
        begin
          dmod2.PriceTabT.Open;
          btnRecNo.Text := inttostr(dmod2.PriceTabT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.PriceTabT.recordcount);
        end;
      3:
        begin
          dmod2.SignRT.Open;
          btnRecNo.Text := inttostr(dmod2.SignRT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.SignRT.recordcount);
        end;
      4:
        begin
          dmod2.CostsT.Open;
          btnRecNo.Text := inttostr(dmod2.CostsT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.CostsT.recordcount);
        end;
      5:
        begin
          dmod2.CompanyT.Open;
          btnRecNo.Text := inttostr(dmod2.CompanyT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.CompanyT.recordcount);
        end;
      6:
        begin
          dmod2.ParamT.Open;
          btnRecNo.Text := inttostr(dmod2.ParamT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.ParamT.recordcount);
        end;
      7:
        begin
          dmod2.ReportsT.Open;
          btnRecNo.Text := inttostr(dmod2.ReportsT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.ReportsT.recordcount);
        end;
      8:
        begin
          dmod2.KonteringT.Open;
          btnRecNo.Text := inttostr(dmod2.KonteringT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.KonteringT.recordcount);
        end;
      9:
        begin
          dmod2.CustomerT.Open;
          btnRecNo.Text := inttostr(dmod2.CustomerT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.CustomerT.recordcount);
        end;
      10:
        begin
          dmod2.ObjectT.Open;
          btnRecNo.Text := inttostr(dmod2.ObjectT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.ObjectT.recordcount);
        end;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0:
        begin
          dmod2.BetstT.Open;
          btnRecNo.Text := inttostr(dmod2.BetstT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.BetstT.recordcount);
        end;
      1:
        begin
          dmod2.DrivMT.Open;
          btnRecNo.Text := inttostr(dmod2.DrivMT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.DrivMT.recordcount);
        end;
      2:
        begin
          dmod2.CardsT.Open;
          btnRecNo.Text := inttostr(dmod2.CardsT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.CardsT.recordcount);
        end;
      3:
        begin
          dmod2.TtypT.Open;
          btnRecNo.Text := inttostr(dmod2.TtypT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.TtypT.recordcount);
        end;
    end;
  end;
end;

procedure TfrmMain.MoveNxt;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.MoveBy(1);
      2: dmod2.PriceTabT.MoveBy(1);
      3: dmod2.SignRT.MoveBy(1);
      4: dmod2.CostsT.MoveBy(1);
      5: dmod2.CompanyT.MoveBy(1);
      6: dmod2.ParamT.MoveBy(1);
      7: dmod2.ReportsT.MoveBy(1);
      8: dmod2.KonteringT.MoveBy(1);
      9: dmod2.CustomerT.MoveBy(1);
      10: dmod2.ObjectT.MoveBy(1);
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.MoveBy(1);
      1: dmod2.DrivMT.MoveBy(1);
      2: dmod2.CardsT.MoveBy(1);
      3: dmod2.TtypT.MoveBy(1);
    end;
  end;
end;

procedure TfrmMain.BtnPlusenClick(Sender: TObject);
begin
  moveNxt;
  FixRaknare;
end;

procedure TfrmMain.MovePrev;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.MoveBy(-1);
      2: dmod2.PriceTabT.MoveBy(-1);
      3: dmod2.SignRT.MoveBy(-1);
      4: dmod2.CostsT.MoveBy(-1);
      5: dmod2.CompanyT.MoveBy(-1);
      6: dmod2.ParamT.MoveBy(-1);
      7: dmod2.ReportsT.MoveBy(-1);
      8: dmod2.KonteringT.MoveBy(-1);
      9: dmod2.CustomerT.MoveBy(-1);
      10: dmod2.ObjectT.MoveBy(-1);
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.MoveBy(-1);
      1: dmod2.DrivMT.MoveBy(-1);
      2: dmod2.CardsT.MoveBy(-1);
      3: dmod2.TtypT.MoveBy(-1);
    end;
  end;
end;

procedure TfrmMain.MoveLst;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.Last;
      2: dmod2.PriceTabT.Last;
      3: dmod2.SignRT.Last;
      4: dmod2.CostsT.Last;
      5: dmod2.CompanyT.Last;
      6: dmod2.ParamT.Last;
      7: dmod2.ReportsT.Last;
      8: dmod2.KonteringT.Last;
      9: dmod2.CustomerT.Last;
      10: dmod2.ObjectT.Last;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Last;
      1: dmod2.DrivMT.Last;
      2: dmod2.CardsT.Last;
      3: dmod2.TtypT.Last;
    end;
  end;
end;

procedure TfrmMain.MovrFrst;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.First;
      2: dmod2.PriceTabT.First;
      3: dmod2.SignRT.First;
      4: dmod2.CostsT.First;
      5: dmod2.CompanyT.First;
      6: dmod2.ParamT.First;
      7: dmod2.ReportsT.First;
      8: dmod2.KonteringT.First;
      9: dmod2.CustomerT.First;
      10: dmod2.ObjectT.First;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.First;
      1: dmod2.DrivMT.First;
      2: dmod2.CardsT.First;
      3: dmod2.TtypT.First;
    end;
  end;
end;

procedure TfrmMain.BtnFirstClick(Sender: TObject);
begin
  MovRFrst;
  FixRaknare;
end;

procedure TfrmMain.BtnLastClick(Sender: TObject);
begin
  MoveLst;
  FixRaknare;
end;

procedure TfrmMain.Canc;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.Cancel;
      2: dmod2.PriceTabT.Cancel;
      3: dmod2.SignRT.Cancel;
      4: dmod2.CostsT.Cancel;
      5: dmod2.CompanyT.Cancel;
      6: dmod2.ParamT.Cancel;
      7: dmod2.ReportsT.Cancel;
      8: dmod2.KonteringT.Cancel;
      9: dmod2.CustomerT.Cancel;
      10: dmod2.ObjectT.Cancel;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Cancel;
      1: dmod2.DrivMT.Cancel;
      2: dmod2.CardsT.Cancel;
      3: dmod2.TtypT.Cancel;
    end;
  end;
end;

procedure TfrmMain.Del;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.Delete;
      2: dmod2.PriceTabT.Delete;
      3: dmod2.SignRT.Delete;
      4: dmod2.CostsT.Delete;
      5: dmod2.CompanyT.Delete;
      6: dmod2.ParamT.Delete;
      7: dmod2.ReportsT.Delete;
      8: dmod2.KonteringT.Delete;
      9: dmod2.CustomerT.Delete;
      10: dmod2.ObjectT.Delete;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Delete;
      1: dmod2.DrivMT.Delete;
      2: dmod2.CardsT.Delete;
      3: dmod2.TtypT.Delete;
    end;
  end;
end;

procedure TfrmMain.Ins;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.Insert;
      2: dmod2.PriceTabT.Insert;
      3: dmod2.SignRT.Insert;
      4: dmod2.CostsT.Insert;
      5: dmod2.CompanyT.Insert;
      6: dmod2.ParamT.Insert;
      7: dmod2.ReportsT.Insert;
      8: dmod2.KonteringT.Insert;
      9: dmod2.CustomerT.Insert;
      10: dmod2.ObjectT.Insert;
    end;
  end;
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Insert;
      1: dmod2.DrivMT.Insert;
      2: dmod2.CardsT.Insert;
      3: dmod2.TtypT.Insert;
    end;
  end;
end;

procedure TfrmMain.S_Post;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.Post;
      2: dmod2.PriceTabT.Post;
      3: dmod2.SignRT.Post;
      4: dmod2.CostsT.Post;
      5: dmod2.CompanyT.Post;
      6: dmod2.ParamT.Post;
      7: dmod2.ReportsT.Post;
      8: dmod2.KonteringT.Post;
      9: dmod2.CustomerT.Post;
      10: dmod2.ObjectT.Post;
    end;
  end;
//!Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Post;
      1: dmod2.DrivMT.Post;
      2: dmod2.CardsT.Post;
      3: dmod2.TtypT.Post;
    end;
  end;

end;

procedure TfrmMain.BtnSaveClick(Sender: TObject);
begin
  s_Post;
end;

procedure TfrmMain.BtnCanClick(Sender: TObject);
begin
  Canc;
end;

procedure TfrmMain.BtnDelClick(Sender: TObject);
begin
  Del;
  FixRaknare;
end;

procedure TfrmMain.BtnNewClick(Sender: TObject);
begin
  Ins;
end;

procedure TfrmMain.Refr;
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: dmod2.ObjTypeT.Resync([RmCenter]);
      2: dmod2.PriceTabT.Resync([RmCenter]);
      3: dmod2.SignRT.Resync([RmCenter]);
      4: dmod2.CostsT.Resync([RmCenter]);
      5: dmod2.CompanyT.Resync([RmCenter]);
      6: dmod2.ParamT.Resync([RmCenter]);
      7: dmod2.ReportsT.Resync([RmCenter]);
      8: dmod2.KonteringT.Resync([RmCenter]);
      9: dmod2.CustomerT.Resync([RmCenter]);
      10: dmod2.ObjectT.Resync([RmCenter]);
    end;
  end;
//! Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Resync([RmCenter]);
      1: dmod2.DrivMT.Resync([RmCenter]);
      2: dmod2.CardsT.Resync([RmCenter]);
      3: dmod2.TtypT.Resync([RmCenter]);
    end;
  end;
end;

procedure TfrmMain.S_H_DBNav(val: Boolean);
begin
  speedbutton2.Visible := Val;
  BtnFirst.visible := Val;
  BtnMinEn.visible := Val;
  BtnRecNo.visible := Val;
  BtnPlusEn.visible := Val;
  BtnLast.visible := Val;
  BtnTotRecNo.visible := Val;
  BtnNew.visible := Val;
  BtnDel.visible := Val;
  BtnSave.visible := Val;
  BtnCan.visible := Val;
  BtnUpd.visible := Val;
  BtnFilter.visible := Val;
  BtnAsc.visible := Val;
  BtnDesc.visible := Val;
  Splitter1.visible := Val;
  Splitter2.visible := Val;
  Splitter3.visible := Val;
end;

procedure TfrmMain.NoFilt;
begin
  btnfilter.Flat := False;
  dmod2.CompanyT.Filtered := False;
  dmod2.ParamT.Filtered := False;
  dmod2.ObjTypeT.Filtered := False;
  dmod2.SignrT.Filtered := False;
  dmod2.PriceTabT.Filtered := False;
  dmod2.CostsT.Filtered := False;
  dmod2.ReportsT.Filtered := False;
  dmod2.KonteringT.Filtered := False;
  dmod2.BetstT.Filtered := False;
  dmod2.CardsT.Filtered := False;
  dmod2.TtypT.Filtered := False;
  dmod2.DrivMT.Filtered := False;
  dmod2.CustomerT.Filtered := False;
  dmod2.ObjectT.Filtered := False;


  SetSort(dmod2.BetstT, '');
  SetSort(dmod2.CardsT, '');
  SetSort(dmod2.TtypT, '');
  SetSort(dmod2.DrivMT, '');
  SetSort(dmod2.CompanyT, '');
  SetSort(dmod2.ParamT, '');
  SetSort(dmod2.ObjTypeT, '');
  SetSort(dmod2.SignrT, '');
  SetSort(dmod2.PriceTabT, '');
  SetSort(dmod2.CostsT, '');
  SetSort(dmod2.ReportsT, '');
  SetSort(dmod2.KonteringT, '');
  SetSort(dmod2.CustomerT, '');
  SetSort(dmod2.ObjectT, '');
end;

procedure TfrmMain.BtnFilterClick(Sender: TObject);
begin
  FixRaknare;
  if btnfilter.Flat then
  begin
    nofilt;
    btnfilter.flat := False;
  end
  else
  begin
    if DbNavBaz = 'FrmGreg' then
    begin
      case frmreg.Tab1.ActivePage.Tag of
        1:
          begin
            dmod2.ObjTypeS.DataSet.Filter := frmreg.dbgrid8.SelectedField.FieldName + '=''' + frmreg.dbgrid8.SelectedField.asstring + '''';
            dmod2.ObjTypeS.DataSet.Filtered := True;
          end;
        2:
          begin
            dmod2.PriceTabS.DataSet.Filter := frmreg.dbgrid10.SelectedField.FieldName + '=''' + frmreg.dbgrid10.SelectedField.asstring + '''';
            dmod2.PriceTabS.DataSet.Filtered := True;
          end;
        3:
          begin
            dmod2.SignRS.DataSet.Filter := frmreg.dbgrid9.SelectedField.FieldName + '=''' + frmreg.dbgrid9.SelectedField.asstring + '''';
            dmod2.SignRS.DataSet.Filtered := True;
          end;
        4:
          begin
            dmod2.CostsS.DataSet.Filter := frmreg.dbgrid1.SelectedField.FieldName + '=''' + frmreg.dbgrid1.SelectedField.asstring + '''';
            dmod2.CostsS.DataSet.Filtered := True;
          end;
        5:
          begin
            dmod2.CompanyS.DataSet.Filter := frmreg.dbgrid6.SelectedField.FieldName + '=''' + frmreg.dbgrid6.SelectedField.asstring + '''';
            dmod2.CompanyS.DataSet.Filtered := True;
          end;
        6:
          begin
            dmod2.ParamS.DataSet.Filter := frmreg.dbgrid7.SelectedField.FieldName + '=''' + frmreg.dbgrid7.SelectedField.asstring + '''';
            dmod2.ParamS.DataSet.Filtered := True;
          end;
        7:
          begin
            dmod2.ReportsS.DataSet.Filter := frmreg.dbgrid4.SelectedField.FieldName + '=''' + frmreg.dbgrid4.SelectedField.asstring + '''';
            dmod2.ReportsS.DataSet.Filtered := True;
          end;
        8:
          begin
            dmod2.KonteringS.DataSet.Filter := frmreg.dbgrid3.SelectedField.FieldName + '=''' + frmreg.dbgrid3.SelectedField.asstring + '''';
            dmod2.KonteringS.DataSet.Filtered := True;
          end;
        9:
          begin
            dmod2.CustomerS.DataSet.Filter := frmreg.dbgrid5.SelectedField.FieldName + '=''' + frmreg.dbgrid5.SelectedField.asstring + '''';
            dmod2.CustomerS.DataSet.Filtered := True;
          end;
        10:
          begin
            dmod2.ObjectS.DataSet.Filter := frmreg.dbgrid12.SelectedField.FieldName + '=''' + frmreg.dbgrid12.SelectedField.asstring + '''';
            dmod2.ObjectS.DataSet.Filtered := True;
          end;
      end;
    end; //! om   DbNavBaz:='FrmGreg';
    if DBNavBaz = 'FrmStat' then
    begin
      case FrmStatiska.PageControl1.ActivePageIndex of
        0:
          begin
            dmod2.BetstT.Filter := FrmStatiska.dbgrid1.SelectedField.FieldName + '=''' + FrmStatiska.dbgrid1.SelectedField.asstring + '''';
            dmod2.BetstT.Filtered := True;
          end;
        1:
          begin
            dmod2.DrivMT.Filter := FrmStatiska.dbgrid2.SelectedField.FieldName + '=''' + FrmStatiska.dbgrid2.SelectedField.asstring + '''';
            dmod2.DrivMT.Filtered := True;
          end;
        2:
          begin
            dmod2.CardsT.Filter := FrmStatiska.dbgrid3.SelectedField.FieldName + '=''' + FrmStatiska.dbgrid3.SelectedField.asstring + '''';
            dmod2.CardsT.Filtered := True;
          end;
        3:
          begin
            dmod2.TtypT.Filter := FrmStatiska.dbgrid4.SelectedField.FieldName + '=''' + FrmStatiska.dbgrid4.SelectedField.asstring + '''';
            dmod2.TtypT.Filtered := True;
          end;
      end;
    end; //! om   DbNavBaz:='FrmGreg';

    btnfilter.flat := True;
  end;

end;

procedure TfrmMain.BtnMinEnClick(Sender: TObject);
begin
  MovePrev;
  FixRaknare;
end;

procedure TfrmMain.BtnUpdClick(Sender: TObject);
begin
  refr;
  FixRaknare;
end;

procedure TfrmMain.FindBack(data: TAdoTable; tabell, BMark: string);
begin
//  FixRaknare;
//  (data as TadoTable).Sort := '';
//  (data as Tadotable).Locate(Tabell, Bmark, [LOPartialKey]);
  FixRaknare;
  BtnFilter.enabled := False;
  BtnASC.enabled := False;
  btndesc.enabled := False;
end;

procedure TfrmMain.HelpSortClick(SortOrder: string);
begin
  if DbNavBaz = 'FrmGreg' then
  begin
    case frmreg.Tab1.ActivePage.Tag of
      1: SetSort(dmod2.ObjTypeT, frmreg.dbgrid8.SelectedField.FieldName + SortOrder);
      2: SetSort(dmod2.PriceTabT, frmreg.dbgrid10.SelectedField.FieldName + SortOrder);
      3: SetSort(dmod2.SignRT, frmreg.dbgrid9.SelectedField.FieldName + SortOrder);
      4: SetSort(dmod2.CostsT, frmreg.dbgrid1.SelectedField.FieldName + SortOrder);
      5: SetSort(dmod2.CompanyT, frmreg.dbgrid6.SelectedField.FieldName + SortOrder);
      6: SetSort(dmod2.ParamT, frmreg.dbgrid7.SelectedField.FieldName + SortOrder);
      7: SetSort(dmod2.ReportsT, frmreg.dbgrid4.SelectedField.FieldName + SortOrder);
      8: SetSort(dmod2.KonteringT, frmreg.dbgrid3.SelectedField.FieldName + SortOrder);
      9: SetSort(dmod2.CustomerT, frmreg.dbgrid5.SelectedField.FieldName + SortOrder);
      10: SetSort(dmod2.ObjectT, frmreg.dbgrid12.SelectedField.FieldName + SortOrder);
    end;
  end;
//! Statiska
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: SetSort(dmod2.BetstT, FrmStatiska.dbgrid1.SelectedField.FieldName + SortOrder);
      1: SetSort(dmod2.DrivMT, FrmStatiska.dbgrid2.SelectedField.FieldName + SortOrder);
      2: SetSort(dmod2.CardsT, FrmStatiska.dbgrid3.SelectedField.FieldName + SortOrder);
      3: SetSort(dmod2.TtypT, FrmStatiska.dbgrid4.SelectedField.FieldName + SortOrder);
    end;
  end;
end;

procedure TfrmMain.BtnASCClick(Sender: TObject);
begin
  HelpSortClick('');
end;

procedure TfrmMain.BtnDESCClick(Sender: TObject);
begin
  HelpSortClick(' DESC');
end;

procedure TfrmMain.LevelFix(SL: Integer);
begin
  case sl of
    1: begin
        Statistik2.Enabled := False;
        SPBtnStat.Enabled := False;
        Fakturering1.Enabled := False;
        Utskrift1.Enabled := False;
        Kontera1.Enabled := False;
        Halvstatiskaregister1.Enabled := False;
        Grundregister1.Enabled := False;
        sql1.Enabled := False;
        SparaPrislista1.Enabled := False;
        SPBtnStat.Enabled := False;
        SpBtnGreg.Enabled := False;
//     SpBtnKomp.Enabled :=True;
        SpBtnSql.Enabled := False;
      end;
    3: begin
        SPBtnStat.Enabled := True;
        Statistik2.Enabled := True;
        Fakturering1.Enabled := False;
        Utskrift1.Enabled := False;
        Kontera1.Enabled := False;
        Halvstatiskaregister1.Enabled := False;
        Grundregister1.Enabled := False;
        sql1.Enabled := False;
        SparaPrislista1.Enabled := False;
        SPBtnStat.Enabled := True;
        SpBtnGreg.Enabled := False;
//     SpBtnKomp.Enabled :=True;
        SpBtnSql.Enabled := True;
      end;
    4: begin
        SPBtnStat.Enabled := True;
        Statistik2.Enabled := True;
        Fakturering1.Enabled := True;
        Utskrift1.Enabled := True;
        Kontera1.Enabled := True;
        Halvstatiskaregister1.Enabled := False;
        Grundregister1.Enabled := False;
        sql1.Enabled := True;
        SparaPrislista1.Enabled := False;
        SPBtnStat.Enabled := True;
        SpBtnGreg.Enabled := False;
//     SpBtnKomp.Enabled :=True;
        SpBtnSql.Enabled := True;
      end;
    5: begin
        Fakturering1.Enabled := true;
        Utskrift1.Enabled := True;
        Kontera1.Enabled := True;
        Halvstatiskaregister1.Enabled := True;
        Grundregister1.Enabled := True;
        sql1.Enabled := True;
        SparaPrislista1.Enabled := True;
        Statistik2.Enabled := True;
        SPBtnStat.Enabled := True;
        SpBtnGreg.Enabled := True;
//     SpBtnKomp.Enabled :=True;
        SpBtnSql.Enabled := True;
      end;
  end;

end;

procedure TfrmMain.KillProgram(Classname, WindowTitle: string);
var
  Window: HWND;
begin
  if FindWindow(nil, PCHAR(WindowTitle)) <> 0 then
    if MessageDlg('Du har Car2000 igång, du rekommenderas att avsluta det. Avsluta nu? ', mtWarning, [mbYes, mbNo], 0) = mrYes
      then
    begin
      Window := FindWindow(nil, PCHAR(WindowTitle));
      postmessage(window, WM_QUIT, 0, 0);
    end;

end;

procedure TfrmMain.SPBtnStatClick(Sender: TObject);
begin
  Statistik2.Click;
end;

procedure TfrmMain.SpBtnGregClick(Sender: TObject);
begin
  Halvstatiskaregister1.Click;
end;

procedure TfrmMain.SpBtnKompClick(Sender: TObject);
begin
//  KomprimeraReparera1.Click ;
end;

procedure TfrmMain.SpBtnSqlClick(Sender: TObject);
begin
  Sql1.Click;
end;

function TfrmMain.GetActPrint: string;
var
  ResStr: array[0..255] of char;
  namn, NyttNamn: string;
  i: Integer;
begin
  GetProfileString('Windows', 'device', '', ResStr, 255);
  namn := StrPas(ResStr);
  for i := 0 to length(namn) do
    if Namn[i] = ',' then
    begin
      Nyttnamn := copy(namn, 0, i - 1);
      Result := nyttnamn;
      exit;
    end;
end;

function TfrmMain.IsCustKoncern(KundNr: Integer): Boolean;
begin
//!
  dmod2.Q2.Active := False;
  dmod2.Q2.SQL.Clear;
  dmod2.Q2.SQL.Text := 'Select Cust_Koncern from Customer where Cust_Id=' + inttostr(KundNr);
  dmod2.Q2.Active := True;
  result := dmod2.q2.FieldByName('Cust_Koncern').AsBoolean;
  dmod2.q2.Active := False;
end;

function TfrmMain.CheckKontFakt(Nr: string): Boolean;
begin
//!
end;

{ Meny grupp "Arkiv"}

procedure TfrmMain.Loggain1Click(Sender: TObject);
var
  ds : TADOQuery;
begin
  frmLogin := TfrmLogin.create(application);
  if LastLogin > '' then
    frmLogin.ComboBox1.text := LastLogin;
  if frmLogin.ShowModal = mrOK then
  begin
    if (('$HASP' = sign) or ('$LASP' = sign)) and ('' = frmlogin.edit1.text) then
    begin
      inloggad := True;
      SecLevel := 5;
      menuOpen(InLoggad);
      Statusbar1.Panels[1].text := sign;
    end;
    ds := CreateDS('SELECT * FROM SIGNR WHERE SIGN='''+sign+''' AND PASSWORD='''+frmLogin.Edit1.Text+'''');
    try
      ds.Open;
      if Not ds.IsEmpty then
      begin
      lastlogin := ds.fieldbyname('Namn').asstring;
      try
        if (ds.fieldbyname('KTJ_GRP').asString > '!') then
          SecLevel := ds.fieldbyname('KTJ_GRP').asinteger
        else
          secLevel := 1;
      except
        WriteDebug('DATA','Fel fält KTJ_GRP USER: '+sign);
        secLevel := 1;
      end;
      inloggad := True;
      menuOpen(InLoggad);
      LevelFix(seclevel);
      Statusbar1.Panels[1].text := sign;
      end;
    except
    end;
    FreeDS(ds);
    if not Inloggad then showmessage('Fel lösenord');
  end;

  frmLogin.free;
end;

procedure TfrmMain.Loggaut1Click(Sender: TObject);
begin
  if assigned(frmreg) then frmreg.close;
  Inloggad := False;
  MenuOpen(inloggad);
  S_H_DBNav(False);
  SecLevel := 0;
  sign := '';
  Statusbar1.Panels[1].text := sign;

end;

procedure TfrmMain.ndraDatabas1Click(Sender: TObject);
var
  I: Integer;
begin
  frmGate.showModal;
  quit := false;
  if frmGate.ModalResult = MrOk then
  begin
    DBTitle := frmgate.ComboBox1.Text;
//    writeini;
    statusbar1.Panels[2].text := DBTitle;
    loggaut1.Click;

    if Pos('PROVIDER=', UpperCase(DbWay)) <> 1 then
      DbConn := 'Provider=Microsoft.Jet.OLEDB.4.0;Data source=' + dbway
    else
      DbConn := DbWay;

    Dmod1.ADOConnection1.close;
    Dmod1.ADOConnection1.LoginPrompt := False;
    Dmod1.ADOConnection1.ConnectionString := DbConn;
    try
      Dmod1.ADOConnection1.connected := true;
    except
      DBExcists := false;
      exit;
    end;
    DBExcists := true;

    if assigned(Dmod2) then begin
      for I := 0 to Dmod2.ComponentCount - 1 do
        if dmod2.Components[I] is TAdoTable then
          (dmod2.Components[I] as TAdoTable).open;
    end;
    ReadIni;
    Inloggad := False;
    menuOpen(Inloggad);
    S_H_DBNav(False);
  end
  else
    quit := true;

end;

procedure TfrmMain.Avsluta1Click(Sender: TObject);
begin
  Close;
end;

{ Meny grupp "Bearbetning"}

procedure TfrmMain.Fakturering1Click(Sender: TObject);
begin
  frmfaktuts := Tfrmfaktuts.Create(self);
  panel1.visible := False;
end;

procedure TfrmMain.Fakturautskrift1Click(Sender: TObject);
var
  Frm: TFrmUtskr;
begin
  frm := TFrmUtskr.Create(self);
  frm.Caption := 'Faktura utskrift';
  frm.ShowModal;
  frm.Free;
end;

procedure TfrmMain.Internfakturautskrift1Click(Sender: TObject);
var
  Frm: TFrmUtskr;
begin
  frm := TFrmUtskr.Create(self);
  frm.Caption := 'Intern faktura utskrift';
  frm.ShowModal;
  frm.Free;
end;

procedure TfrmMain.FakturautskriftKontant1Click(Sender: TObject);
var
  Frm: TFrmUtskr;
begin
  frm := TFrmUtskr.Create(self);
  frm.Caption := 'Kontant faktura utskrift';
  frm.ShowModal;
  frm.Free;
end;

procedure TfrmMain.FakturautskriftKontokort1Click(Sender: TObject);
var
  Frm: TFrmUtskr;
begin
  frm := TFrmUtskr.Create(self);
  frm.Caption := 'Kontokort faktura utskrift';
  frm.ShowModal;
  frm.Free;
end;

procedure TfrmMain.Kontera1Click(Sender: TObject);
var Contrid, LoggNr, ENummer, Subid, cc: Integer;
   ds : TADOQuery;
   ds2 : TADOQuery;
begin
  if MessageDlg('Är du säker att kontering skall utföras?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Exit;
  end;
  screen.Cursor := crHourglass;
  cc := 0;

  ds2 := CreateDS('SELECT SUBID,ENUMMER,CONTR_SUB.PAYMENT,CONTR_BASE.CONTRID,CONTR_SUB.STATUS FROM CONTR_SUB INNER JOIN CONTR_BASE ON CONTR_SUB.CONTRID=CONTR_BASE.CONTRID WHERE CONTR_BASE.STATUS=9');
  try
    ds2.open;
    while not ds2.Eof do
    begin
      if ds2.Fields[4].AsInteger<11 then
      begin
        ENummer := ds2.Fields[1].AsInteger;
        if ENummer=0 then
        begin
          // Fixa Nytt nummer
          Enummer := 0;
          case ds2.Fields[2].AsString[1] of
            'K' : enummer := GetNextNumberFromParam('KNOTENR');
            'O' : enummer := GetNextNumberFromParam('FBOLAGNR');
            'I' : enummer := GetNextNumberFromParam('INTERNNR');
            'F' : enummer := GetNextNumberFromParam('FAKTNR');
          end;
        end;
        // Spara i Sub
        if ENummer>0 then
        begin
          ds2.Connection.Execute('UPDATE CONTR_SUB SET ENUMMER='+IntToStr(ENUMMER)+' WHERE SUBID='+ds2.Fields[0].AsString);
          ds2.Connection.Execute('UPDATE CONTR_SUB SET PRINT_DATE=CONVERT(VARCHAR(10),GETDATE(),120),FORFALLODAT=CONVERT(VARCHAR(10),GETDATE()+TERMS_PAY,120),STATUS=10 WHERE SUBID='+ds2.Fields[0].AsString);
          MoveCSub2Faktura(ds2.Fields[0].AsInteger);
          // JA DET ÄR DEL MEN DET GICK FORT. DET SKICKAS SAMMA SQL BEROENDE PÅ ANTAL "SUBBAR"
          ds2.Connection.Execute('UPDATE CONTR_BASE SET STATUS=10 WHERE CONTRID='+ds2.Fields[3].AsString);
          inc(cc);
        end
        else
        begin
          ShowMessage('Det verkar vara något fel med betalningssättet på kontrakt nummer : '+ds2.Fields[3].AsString);
        end;
      end;
      ds2.Next;
    end;
  except
    WriteDebug('SYSTEM','Kan inte fakturera');
  end;
  FreeDS(ds2);

  if cc=0 then
  begin
    screen.Cursor := crDefault;
    ShowMessage('Inget att fakturera!');
    Exit;
  end;

  //!Fixa ett LOggNr
  LoggNr := GetNextNumberFromParam('LOGGNR');

  ds := CreateDS('INSERT INTO LOGGTABELL (LOGGNR,NRTYP,NUMMER,BOKF_DAG) '+
                'SELECT '+IntToStr(LoggNr)+',1,ENUMMER,CONVERT(VARCHAR(10),GETDATE(),120) FROM CONTR_SUB WHERE STATUS=10');
  try
    ExecDS(ds);
  except
    WriteDebug('System','Kan inte skapa Loggtabell');
  end;
  SetDS(ds,'UPDATE CONTR_SUB SET STATUS=11 WHERE STATUS=10');
  try
    ExecDS(ds);
  except
    WriteDebug('System','Kan inte uppdatera Contr_Sub');
  end;
  FreeDS(ds);
  try
    PrintOutReport('Journal.Ini', IntToStr(Loggnr) + ';', 1, False);
  except
  end;
  try
    PrintOutReport('FaktLogg.Ini', IntToStr(Loggnr) + ';', 1, False);
  except
  end;
  try
    PrintOutReport('Summa Konto Kstall.Ini', IntToStr(Loggnr) + ';', 1, False);
  except
  end;
  try
    PrintOutReport('FaktKont.Ini', IntToStr(Loggnr) + ';', 1, False);
  except
  end;
  try
    PrintOutReport('LoggFaktnr.ini', IntToStr(Loggnr) + ';', 1, False);
  except
  end;

  screen.Cursor := crDefault;
  showmessage('Kontering Avslutad');
end;

{ Meny grupp "Uppföljning"}

procedure TfrmMain.Standardrapporter1Click(Sender: TObject);
begin
  frmutskrift := TfrmUtskrift.Create(Self);
  frmutskrift.ShowModal;
end;

{ Meny grupp "Underhåll"}

procedure TfrmMain.Halvstatiskaregister1Click(Sender: TObject);
begin
  frmReg := TfrmReg.create(self);
  panel1.visible := False;
  frmMain.S_H_DBNav(false);
  DbNavBaz := 'FrmGreg';
end;

procedure TfrmMain.Grundregister1Click(Sender: TObject);
begin
  FrmStatiska := TFrmStatiska.create(Self);
  Panel1.visible := False;
  S_H_DBNav(true);
  DbNavBaz := 'FrmStat';
end;

procedure TfrmMain.Sql1Click(Sender: TObject);
begin
  FormSql := TformSql.create(self);
  Panel1.Visible := False;
end;

procedure TfrmMain.Spara1Click(Sender: TObject);
begin
{
  db.database := dbway;
  db.Connected := true;
  t1.active := true;
  t1.SaveToFile(extractfilepath(application.exename) + 'pris.bin');
  db.Connected := False;

  AssignFile(F, extractfilepath(application.exename) + 'pris.txt');
  Rewrite(F);
  j := 1;
  dmod2.PriceTabT.First;
  dmod2.PriceTabRowsT.First;
  while not dmod2.PriceTabT.eof do
  begin
    while not dmod2.PriceTabRowsT.Eof do
    begin
      newstr := inttostr(j) + ';';
      for i := 1 to dmod2.PriceTabRowsT.FieldCount - 1 do
        newstr := newstr + dmod2.PriceTabRowsT.Fields[i].AsString + ';';
      writeln(f, newstr);
      newstr := '';
      dmod2.PriceTabRowsT.Next;
    end;
    inc(j);
    dmod2.pricetabT.next;
  end;
  closefile(f);
  Showmessage('Prislistan sparad');
}
end;

procedure TfrmMain.Lsin1Click(Sender: TObject);
begin
{  if fileexists(extractfilepath(application.exename) + 'pris.bin') and
    fileexists(extractfilepath(application.exename) + 'pris.txt') then
  begin
    if MessageDlg('Vill du uppdatera prislistan?', mtCustom, [mbYes, mbNo], 0) = mrYes then
    begin
      for i := 0 to dmod2.pricetabT.RecordCount - 1 do
        dmod2.pricetabT.delete;
      KomprimeraReparera1.Click;
      db.database := dbway;
      db.Connected := true;
      t1.active := true;
      t1.LoadFromFile(extractfilepath(application.exename) + 'pris.bin', lmEmptyAppend);
      t1.Active := False;
      db.Connected := False;

      AssignFile(F, extractfilepath(application.exename) + 'pris.txt');
      Reset(F);
      while not Eof(f) do
      begin
        k := 0;
        j := 0;
        readln(f, newstr);
        dmod2.PriceTabRowsT.insert;
        for i := 1 to length(newstr) do
          if (newstr[i] = ';') and (K < 9) then
          begin
            slask := stringreplace(copy(newstr, j + 1, i - j), ';', '', [rfreplaceall]);
            dmod2.PriceTabRowsT.Fields[k].AsString := Slask;
            inc(k);
            j := i;
          end;
        dmod2.PriceTabRowsT.post;
      end;
//!
      closefile(f);
      dmod1.ADOConnection1.connected := False;
      dmod1.ADOConnection1.LoginPrompt := False;
      dmod1.ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data source=' + Form1.dbway;
      dmod1.ADOConnection1.connected := true;

      for I := 0 to dmod2.ComponentCount - 1 do
        if dmod2.Components[I] is TAdoTable then
          (dmod2.Components[I] as TAdoTable).open;
      showmessage('Prislistan uppdaterad');
    end;
  end
  else
    showmessage('Hittar inte filerna: Pris.txt & Pris.bin');
}
end;

procedure TfrmMain.Statistik2Click(Sender: TObject);
begin
  panel1.Visible := False;
//  frmstat := TfrmStat.Create(self);
//  frmstat.show;
end;

procedure TfrmMain.Backup1Click(Sender: TObject);
begin
  SaveDialog1.FileName := dmod1.ADOConnection1.DefaultDatabase;
  if SaveDialog1.Execute then
  begin
    try
      Screen.Cursor := CrHourglass;
      Dmod2.Q1.Active := False;
      Dmod2.Q1.Sql.Text := 'BACKUP DATABASE ' + dmod1.ADOConnection1.DefaultDatabase + ' TO DISK=''' + SaveDialog1.FileName + ''' WITH INIT RESTORE DATABASE ' + dmod1.ADOConnection1.DefaultDatabase + ' FROM DISK=''' + SaveDialog1.FileName + '''';
      Dmod2.Q1.ExecSQL;
      Screen.Cursor := CrDefault;
      Showmessage('Backup klar till ' + SaveDialog1.FileName);
    except
      Screen.Cursor := CrDefault;
      Showmessage('Ett fel inträffade, var god försök igen eller kontakta systemansvarig');
    end;
  end;
end;

{ Meny grupp "Hjälp"}

procedure TfrmMain.ContentsClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TfrmMain.SearchforHelpOnClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_KEY, 0);
end;

procedure TfrmMain.HowtoUseHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TfrmMain.Om1Click(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(application);
  frmAbout.ShowModal;
  frmAbout.free;
end;

{ Events för Formen }

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if firsttime then
  begin
    if ObjList.Count=0 then
      LoadReports;
    firsttime := False;
    Loggain1Click(nil);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIni;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ObjList := TList.Create;
  SecLevel := 0;
  if fileexists(Image) then
    image1.Picture.loadfromfile(image);
  Inloggad := False;
  menuOpen(Inloggad);
  S_H_DBNav(False);
  firsttime := True;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeListOfObjects(ObjList);
  ObjList.Free;
end;

end.

