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
{ $Log:  13014: Main.pas
{
{   Rev 1.10    2006-02-18 13:33:16  pb64
}
{
{   Rev 1.9    2005-04-29 12:30:08  pb64
{ Lagt till rutiner för att spara prislista till pris.txt och läsa in den på
{ nytt.
}
{
{   Rev 1.8    2005-04-28 15:57:04  pb64
{ Fixat kreditering av faktura.
{ Ändrat insert kommando till append för att fungera med SQL (Gäller
{ grundregister).
}
{
{   Rev 1.7    2005-03-21 14:09:18  pb64
}
{
{   Rev 1.6    2005-02-07 13:15:42  pb64
}
{
{   Rev 1.5    2004-12-07 16:37:46  pb64
{ Fixat kontering vid deposition.
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
  Buttons, StdCtrls, DBCtrls, Grids, DBGrids, Mask, ComCtrls, ExtCtrls,
  Menus, ToolWin, inifiles, jpeg, db, ExtDlgs, adodb, ImgList, TransBtn2, Printers, Variants;

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
    Kreditering1: TMenuItem;
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
    procedure KontLogg(LoggNr, LoggTyp, Nummer: Integer; date: string);
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
    procedure S_H_DBNav(val: Boolean; OKRemove: Boolean = True);
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
    procedure PrintAcc(Sender: TObject);
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
    procedure Kreditering1Click(Sender: TObject);

  private
    procedure MenuOpen(val: boolean);
    procedure WriteIni;
    procedure LoadReports;
    procedure PrintRapp(sender: TObject);
    function GetMenuItem(var Top: TMenuItem; srcCaption: string): boolean;
    function RoundBaz(X: Extended): Extended;
    function RoundUp(X: Extended): Extended;
    function RoundDn(X: Extended): Extended;
    function Sgn(X: Extended): Integer;

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

const
  acQuitPrompt = $00000000;
  acQuitSaveAll = $00000001;
  acQuitSaveNone = $00000002;

  acViewNormal = $00000000;
  acViewDesign = $00000001;
  acViewPreview = $00000002;
  DBDel = '''';
  REPORTID = 'ACar2000';


implementation

uses Dmod, FormReg, Login, Statiska, About, FaktUts, Utskrift,
  FrmSql, DmSession, comobj, Statistik, GPaths, DBCMain, eqprn, UrvalStr,
  Urval1, Urval2, EqiniStrings, PrintDialog, Utskrifter, tmpData;

{$R *.DFM}

{ TForm1 }


procedure MakeDBStruct;
var
  ds : TADOQuery;
begin
  ds := CreateDS('CREATE TABLE Betst (	Counter int IDENTITY (1, 1) NOT NULL ,	Kod nvarchar (1) NULL ,'+
         ' Namn nvarchar (20) NULL ,	BTyp smallint NULL ,	AntDagar smallint NULL ,	Konto float NULL)');
  ExecDS(ds);

  SetDS(ds,'  ');




end;


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
begin

  Preview := StrToBool(GetValueFromInit('CAR', '!MM', 'Preview', 'False'));
  rptdirectory := GetValueFromInit('CAR', '!MM', 'rptDirectory', ExtractFilePath(Application.ExeName) + 'Rapporter\');
  tmpData.rptDirectory := rptdirectory;
  LastLogin := GetValueFromInit('ACAR', '!MM', 'LastLogin', sign);
  avrundning := 9390;
  AvrundningKostst := 9980;
  Image := GetValueFromInit('ACAR', '!MM', 'Image', ExtractFilePath(Application.ExeName) + 'Bilder\ACar2.jpg');
  ValdPrinter := GetValueFromInit('CAR', '!MM', 'Skrivare');
  if Printer.Printers.IndexOf(ValdPrinter) < 0 then
    ValdPrinter := Printer.Printers.Strings[Printer.PrinterIndex];
  ValdPrinterRapp := GetValueFromInit('CAR', '!MM', 'SkrivarRapp');
  if Printer.Printers.IndexOf(ValdPrinterRapp) < 0 then
    ValdPrinterRapp := Printer.Printers.Strings[Printer.PrinterIndex];

  AviFilm := GetValueFromInit('CAR', '!MM', 'AviFilm', ExtractFilePath(Application.ExeName) + 'Bilder\Car2000.avi');
  Title := GetValueFromInit('ACAR', '!MM', 'Title', 'ACar');
  ImageCar := GetValueFromInit('CAR', '!MM', 'Image', ExtractFilePath(Application.ExeName) + 'Bilder\ACar2.jpg');

  frmMain.Caption := Title;
  if FileExists(Image) then
    Image1.Picture.LoadFromFile(Image);


end;

procedure TfrmMain.WriteIni;
begin
  if Dmod1.ADOConnection1.Connected then
    SetValueToInit('ACAR', '!MM', 'LastLogin', LastLogin);
end;

procedure TfrmMain.LoadReports;
var
  myMenu, NewItem: TMenuItem;
begin
  with Dmod2.ReportsT do
  begin
    First;

    if not EOF then
    begin
      NewItem := TMenuItem.Create(Self);
      NewItem.Caption := '-';
      Rapporter1.Add(NewItem);
    end;

    while not EOF do
    begin
      if (Fieldbyname('Program').AsString = REPORTID) then
      begin
        if (Fieldbyname('AccessType').AsString = 'A') then
        begin
          NewItem := TMenuItem.Create(Self);
          NewItem.Caption := Fieldbyname('MenuName').AsString;
          NewItem.hint := Fieldbyname('CallName').AsString;
          NewItem.Onclick := PrintAcc;
          Rapporteraccess1.Enabled := True;
          Rapporteraccess1.Add(NewItem);
        end;

        if (Fieldbyname('AccessType').AsString = 'R') then
        begin
          NewItem := TMenuItem.Create(Self);
          NewItem.Caption := Fieldbyname('MenuName').AsString;
          NewItem.hint := Fieldbyname('CallName').AsString;
          if NewItem.hint > '!' then
            NewItem.Onclick := PrintRapp;
          if Fieldbyname('Meny').AsString = 'Rapporter' then
          begin
            Rapporter1.Add(NewItem);
          end
          else
            if Fieldbyname('Meny').AsString = 'Statistik' then
            begin
              Statistik1.Enabled := true;
              Statistik1.Add(NewItem);
            end
            else
            begin //Generella rapportmenyer
              if GetMenuItem(myMenu, Fieldbyname('Meny').AsString) then
              begin
                myMenu.Add(NewItem);
              end;
            end;
        end;
      end;
      Next;
    end;
  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if firsttime then
  begin
    LoadReports;
    firsttime := False;
    Loggain1Click(nil);
  end;
end;

procedure TfrmMain.PrintRapp(sender: TObject);
var
  rpt, RWhere, str: string;
begin
  if (Sender as TMenuItem).hint > '!' then
  begin
    Dmod2.q1.Close;
    Dmod2.q1.SQL.Text := 'Select * from Reports where Program =''ACar2000'' AND CallName = ''' + (Sender as TMenuItem).hint + '''';
    Dmod2.q1.Active := True;

{


    //! Om det finns Urval Stgräng   1:Datum   2: Datum T & F   3:Sträng & Integer
    if TrimRight(dmod2.q1.fieldbyname('Rep_UTyp').AsString)  ='3' then
    Begin
     FrmUrvalStr.ShowModal;
     if FrmUrvalStr.ModalResult =MrOk then
       Rwhere :=FrmUrvalStr.Edit1.Text ;
      str := RWhere + ';';
    End;

    //! Om det finns Urval Datum
    if TrimRight(dmod2.q1.fieldbyname('Rep_UTyp').AsString)  ='1' then
    Begin
    FrmUrval1.ShowModal;
    if FrmUrval1.ModalResult =MrOk then
      Rwhere :=datetostr(frmurval1.DateTimePicker1.Date);
      str := RWhere+';';
    End;

    //! Om det finns Urval DatumSpann Till Från
    if TrimRight(dmod2.q1.fieldbyname('Rep_UTyp').AsString)  ='2' then
    Begin
      FrmUrval2.ShowModal;
      if FrmUrval2.ModalResult =MrOk then
        str := DateToStr(FrmUrval2.DateTimePicker1.Date) + ';' +
          DateToStr(FrmUrval2.DateTimePicker2.Date) + ';';
    End;
  }frmPrintDialog := TfrmPrintDialog.Create(Self);
    frmPrintDialog.Q1 := dmod2.q1;
    frmPrintDialog.FormCaption := dmod2.q1.fieldbyname('MenuName').AsString;
    try
      frmPrintDialog.UrvalsTyp := dmod2.q1.fieldbyname('Rep_UTyp').AsInteger;
    except
      frmPrintDialog.UrvalsTyp := 0;
    end;
    dmod2.q1.Active := False;
    tmpData.rptDirectory := rptdirectory;
    frmPrintDialog.ReportFileName := rptDirectory + (Sender as TMenuItem).hint;
    frmPrintDialog.ShowModal;
    frmPrintDialog.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var clickedok: Boolean;
  Newstring: string;
begin
  Koncernkund := False;
// MBH -- Vi kör mot databas.
// KillProgram('','Car2000');
  SecLevel := 0;
//  readIni;
  //!Sökväg till db
{
  if pos('PROVIDER=', UpperCase(DbWay)) <> 1 then begin
    if not fileexists(Dbway) then
    begin
      if OD1.Execute then
        dbway := od1.filename
      else
        Stang := True;
    end;
    DbConn := 'Provider=Microsoft.Jet.OLEDB.4.0;Data source='+DbWay;
  end else
    DbConn := DbWay;
 }
  if not Stang then
  begin
    if fileexists(Image) then
      image1.Picture.loadfromfile(image);
    Inloggad := False;
    menuOpen(Inloggad);
    S_H_DBNav(False);
//    statusbar1.Panels[2].Text := DbTitle;
    firsttime := True;
  end;
end;

procedure TfrmMain.MenuOpen(val: boolean);
begin
  SPBtnStat.Enabled := Val;
  SpBtnGreg.Enabled := Val;
  // MBH - Togbort KADao
  //     SpBtnKomp.Enabled :=Val;
  SpBtnSql.Enabled := Val;
  Loggain1.Enabled := not Val;
  Loggaut1.Enabled := Val;
  Uppfljning1.enabled := Val;
  Underhll1.enabled := Val;
  Bearbetning1.enabled := Val;
end;

procedure TfrmMain.Loggain1Click(Sender: TObject);
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
    if dmod2.SignrT.locate('Sign;Password', VarArrayof([sign, frmlogin.edit1.text]), [locaseinsensitive]) then
    begin
      lastlogin := dmod2.SignrT.fieldbyname('Namn').asstring;
      if (dmod2.SignrT.fieldbyname('KTJ_GRP').asString > '!') then
        SecLevel := dmod2.SignrT.fieldbyname('KTJ_GRP').asinteger
      else
        secLevel := 1;
      inloggad := True;
      menuOpen(InLoggad);
      LevelFix(seclevel);
      Statusbar1.Panels[1].text := sign;
    end;
    if not Inloggad then showmessage('Fel lösenord');
  end;

  frmLogin.free;
end;

procedure TfrmMain.Loggaut1Click(Sender: TObject);
begin
  if assigned(frmreg) then frmreg.close;
  Inloggad := False;
  MenuOpen(inloggad);
  sign := '';
  Statusbar1.Panels[1].text := sign;

end;

procedure TfrmMain.Grundregister1Click(Sender: TObject);
begin
  FrmStatiska := TFrmStatiska.create(Self);
  Panel1.visible := False;
  S_H_DBNav(true);
  DbNavBaz := 'FrmStat';
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  writeini;
end;

procedure TfrmMain.Avsluta1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.Halvstatiskaregister1Click(Sender: TObject);
begin
  frmReg := TfrmReg.create(self);
  panel1.visible := False;
  frmMain.S_H_DBNav(false);
  DbNavBaz := 'FrmGreg';
end;

procedure TfrmMain.Om1Click(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(application);
  frmAbout.ShowModal;
  frmAbout.free;
end;

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

procedure TfrmMain.KontLogg(LoggNr, LoggTyp, Nummer: Integer; date: string);
begin
  dmod2.LoggTabellT.Append;
  dmod2.LoggTabellT.FieldByname('LoggNR').asinteger := LOggNR;
  dmod2.LoggTabellT.FieldByname('NrTyp').asinteger := 1;
  dmod2.LoggTabellT.FieldByname('Nummer').asinteger := Nummer;
  Dmod2.LoggTabellT.FieldByName('Bokf_dag').AsString := date;
  Dmod2.LoggTabellT.Post;
end;

procedure TfrmMain.Kontera1Click(Sender: TObject);
var Contrid, LoggNr, ENummer, Subid, i, MomsKonto: Integer;
  test: string;
  Intern: Boolean;
  ds: TADOQuery;
begin
  if MessageDlg('Är du säker att kontering skall utföras?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Exit;
  end;

  screen.Cursor := crHourglass;
//!Fixa ett LOggNr
  LoggNr := Dmod2.ParamT.Fieldbyname('LoggNr').asinteger + 1;
//!Fixa LoggtabellT

  ds := CreateDS('UPDATE LOGGTABELL SET LOGGNR=' + IntToStr(LoggNr) + ' WHERE LOGGNR=0');
  if ExecDS(ds) > 0 then
  begin
    dmod2.ParamT.Edit;
    dmod2.ParamT.Fieldbyname('LoggNr').asinteger := Loggnr;
    dmod2.ParamT.Post;
  end
  else
  begin
    FreeDS(ds);
    screen.Cursor := crDefault;
    showmessage('Inget att kontera!'#13'Kontering Avslutad');
    Exit;
  end;


  SetDS(ds, 'UPDATE CONTR_SUB SET STATUS=11 WHERE STATUS=10');
  ExecDS(ds);

  SetDS(ds, 'SELECT FAKTNR,STATUS FROM FAKTHEAD INNER JOIN LOGGTABELL ON LOGGTABELL.NUMMER=FAKTHEAD.E_FAKTNR WHERE STATUS=0 AND LOGGNR=' + IntToStr(LoggNr));
  ds.Open;
  while not ds.Eof do
  begin
    KonteraData(ds.fieldByName('FAKTNR').AsInteger);
    ds.Next;
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

procedure TfrmMain.Internfakturautskrift1Click(Sender: TObject);
var
  Frm: TFrmUtskr;
begin
  frm := TFrmUtskr.Create(self);
  frm.Caption := 'Intern faktura utskrift';
  frm.ShowModal;
  frm.Free;
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

procedure TfrmMain.Sql1Click(Sender: TObject);
begin
  FormSql := TformSql.create(self);
  Panel1.Visible := False;
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

function TfrmMain.RoundBaz(X: Extended): Extended;
begin
  if Abs(Frac(X)) >= 0.5 then
    Result := RoundUp(X)
  else
    Result := RoundDn(X);

  Result := Int(X) + Int(Frac(X) * 2);
end;

function TfrmMain.RoundUp(X: Extended): Extended;
begin
  Result := Int(X) + Sgn(Frac(X));
end;

function TfrmMain.RoundDn(X: Extended): Extended;
begin
  Result := Int(X);
end;

function TfrmMain.Sgn(X: Extended): Integer;
begin
  if X < 0 then
    Result := -1
  else
    if X = 0 then
      Result := 0
    else
      Result := 1;
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

function ExportString(Value: string): string;
begin
  Result := StringReplace(Value, ',', '#44', [rfReplaceAll]);
  Result := StringReplace(Result, #13#10, '#13', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '#13', [rfReplaceAll]);
end;

function ImportString(Value: string): string;
begin
  Result := StringReplace(Value, '#44', ',', [rfReplaceAll]);
  Result := StringReplace(Result, '#13', #13#10, [rfReplaceAll]);
end;


function SplitStr(var s: string; SplitChar: string): string;
var
  i: Integer;
begin
  i := Pos(SplitChar, s);
  if i = 0 then
  begin
    Result := s;
    s := '';
  end
  else
  begin
    Result := Copy(s, 1, i - 1);
    s := Copy(s, i + Length(SplitChar), 9999);
  end;
end;



procedure TfrmMain.Spara1Click(Sender: TObject);
var i: integer;
  f: textfile;
  ds, ds2: TADOQuery;
  OldDec: Char;
begin
  ds := CreateDS('SELECT * FROM PRICETAB');
  ds2 := CreateDS('SELECT * FROM PRICETABROWS');

  OldDec := DecimalSeparator;
  DecimalSeparator := '.';
  ds.Open;
  AssignFile(F, extractfilepath(application.exename) + 'pris.txt');
  rewrite(F);
  writeln(F, 'SQL,DELETE PRICETAB');
  writeln(F, 'SQL,DELETE PRICETABROWS');

  while not ds.eof do
  begin
    for i := 0 to ds.FieldCount - 1 do
    begin
      if i = 0 then
        Write(F, 'PRICETAB,' + ExportString(ds.Fields[i].AsString))
      else
        Write(F, ',' + ExportString(ds.Fields[i].AsString));
    end;
    Writeln(F, '');
    SetDS(ds2, 'SELECT * FROM PRICETABROWS WHERE PRICEID=' + ds.Fields[0].AsString);
    ds2.Open;
    while not ds2.eof do
    begin
      for i := 0 to ds2.FieldCount - 1 do
      begin
        if i = 0 then
          Write(F, 'PRICETABROWS,' + ExportString(ds2.Fields[i].AsString))
        else
          Write(F, ',' + ExportString(ds2.Fields[i].AsString));
      end;
      Writeln(F, '');
      ds2.Next;
    end;
    ds.Next;
  end;
  closefile(f);
  DecimalSeparator := OldDec;
  FreeDs(ds);
  FreeDs(ds2);
  Showmessage('Prislistan sparad till "PRIS.TXT"');

end;

procedure TfrmMain.Lsin1Click(Sender: TObject);
var i, j, k: Integer;
  f: textfile;
  newstr, slask: string;
  OldDec: Char;
  ds: TAdoQuery;
  LastId: Integer;
begin
  LastId := 0;
  if fileexists(extractfilepath(application.exename) + 'pris.txt') then
  begin
    if MessageDlg('Vill du uppdatera prislistan?', mtCustom, [mbYes, mbNo], 0) = mrYes then
    begin
      ds := CreateDS('');
      OldDec := DecimalSeparator;
      DecimalSeparator := '.';
      AssignFile(F, extractfilepath(application.exename) + 'pris.txt');
      Reset(F);
      while not Eof(f) do
      begin
        readln(f, newstr);
        Slask := SplitStr(NewStr, ',');
        if Slask = 'PRICETABROWS' then
        begin
          if LastId > 0 then
          begin
            SetDS(ds, 'SELECT * FROM PRICETABROWS WHERE 1=2');
            ds.Open;
            Slask := SplitStr(NewStr, ',');
            ds.Append;
            ds.Fields[0].AsInteger := LastId;
            for i := 1 to ds.FieldCount - 1 do
            begin
              Slask := SplitStr(NewStr, ',');
              if Slask <> '' then
                ds.Fields[i].AsString := ImportString(Slask);
            end;
            ds.Post;
          end;
        end;
        if Slask = 'PRICETAB' then
        begin
          SetDS(ds, 'SELECT * FROM PRICETAB WHERE 1=2');
          ds.Open;
          Slask := SplitStr(NewStr, ',');
          ds.Append;
          for i := 1 to ds.FieldCount - 1 do
          begin
            Slask := SplitStr(NewStr, ',');
            if Slask <> '' then
              ds.Fields[i].AsString := ImportString(Slask);
          end;
          ds.Post;
          LastId := ds.Fields[0].AsInteger;
        end;
        if Slask = 'SQL' then
        begin
          SetDS(ds, newstr);
          ExecDS(ds);
        end;
      end;
      closefile(f);
      DecimalSeparator := OldDec;
      FreeDs(ds);
      showmessage('Prislistan uppdaterad');
    end;
  end
  else
    showmessage('Hittar inte filerna: Pris.txt');
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
        11: frmreg.PaStaG.Visible := False;
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
        11: frmreg.PaStaG.Visible := True;
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
      11:
        begin
          dmod2.StationT.Open;
          btnRecNo.Text := inttostr(dmod2.StationT.RecNo);
          BtnTotRecNo.Text := inttostr(dmod2.StationT.recordcount);
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
      11: dmod2.StationT.MoveBy(1);
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
      11: dmod2.StationT.MoveBy(-1);
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
      11: dmod2.StationT.Last;
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
      11: dmod2.StationT.First;
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
      11: dmod2.StationT.Cancel;
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
      5: ; // dmod2.CompanyT.Delete;
      6: ; // dmod2.ParamT.Delete;
      7: dmod2.ReportsT.Delete;
      8: dmod2.KonteringT.Delete;
      9: dmod2.CustomerT.Delete;
      10: dmod2.ObjectT.Delete;
      11: dmod2.StationT.Delete;
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
      1: dmod2.ObjTypeT.Append;
      2: dmod2.PriceTabT.Append;
      3: dmod2.SignRT.Append;
      4: dmod2.CostsT.Append;
      5: dmod2.CompanyT.Append;
      6: dmod2.ParamT.Append;
      7: dmod2.ReportsT.Append;
      8: dmod2.KonteringT.Append;
      9: dmod2.CustomerT.Append;
      10: dmod2.ObjectT.Append;
      11: dmod2.StationT.Append;
    end;
  end;
  if DbNavBaz = 'FrmStat' then
  begin
    case FrmStatiska.PageControl1.ActivePageIndex of
      0: dmod2.BetstT.Append;
      1: dmod2.DrivMT.Append;
      2: dmod2.CardsT.Append;
      3: dmod2.TtypT.Append;
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
      5:
      begin
        if dmod2.CompanyS.state in [dsedit, dsinsert] then
          dmod2.CompanyT.Post;
        if dmod2.EdiBaseS.state in [dsedit, dsinsert] then
          dmod2.EDIBaseT.Post;
      end;
      6: dmod2.ParamT.Post;
      7: dmod2.ReportsT.Post;
      8: dmod2.KonteringT.Post;
      9:
      begin
        if dmod2.CustomerS.state in [dsedit, dsinsert] then
          dmod2.CustomerT.Post;
        if dmod2.EdiCustS.state in [dsedit, dsinsert] then
          dmod2.EdiCustT.Post;
      end;
      10: dmod2.ObjectT.Post;
      11: dmod2.StationT.Post;
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
      11: dmod2.StationT.Resync([RmCenter]);
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

procedure TfrmMain.S_H_DBNav(val: Boolean; OKRemove: Boolean = True);
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
  if Val then
    BTNDel.Enabled := OKRemove
  else
    BTNDel.Enabled := True;
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
        11:
          begin
            dmod2.StationS.DataSet.Filter := frmreg.dbgrid13.SelectedField.FieldName + '=''' + frmreg.dbgrid13.SelectedField.asstring + '''';
            dmod2.StationS.DataSet.Filtered := True;
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
      11: SetSort(dmod2.StationT, frmreg.dbgrid13.SelectedField.FieldName + SortOrder);
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

procedure TfrmMain.PrintAcc(Sender: TObject);
var
  Access: Variant;
begin
  try
    Access := GetActiveOleObject('Access.Application');
  except
    Access := CreateOleObject('Access.Application');
  end;
  Access.Visible := True;
  Access.OpenCurrentDatabase(dbway, False);
  Access.DoCmd.OpenReport((Sender as TMenuItem).hint, acViewNormal, EmptyParam, EmptyParam);
  Access.CloseCurrentDatabase;
  Access.Quit(acQuitSaveNone);

end;

procedure TfrmMain.Statistik2Click(Sender: TObject);
begin
  panel1.Visible := False;
  frmstat := TfrmStat.Create(self);
  frmstat.show;
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

procedure TfrmMain.ndraDatabas1Click(Sender: TObject);
var
  I: Integer;
  ds: TADOQuery;
  MakeDB: Boolean;
  l1, l2, l3: string;
  SL : TStringList;
begin
  frmGate.showModal;
  quit := false;
  if frmGate.ModalResult = MrOk then
  begin
    DBTitle := frmgate.ComboBox1.Text;
    writeini;
    statusbar1.Panels[2].text := DBTitle;
    loggaut1.Click;

    if Pos('PROVIDER=', UpperCase(DbWay)) <> 1 then
      DbConn := 'Provider=Microsoft.Jet.OLEDB.4.0;Data source=' + dbway
    else
      DbConn := DbWay;



    Dmod1.ADOConnection1.close;
    Dmod1.ADOConnection1.LoginPrompt := False;
    Dmod1.ADOConnection1.ConnectionString := DbConn;

    DBExcists := true;
    MakeDB := False;
    try
      Dmod1.ADOConnection1.connected := true;
    except
      l3 := DbConn;
      l1 := SplitStr(l3, 'Initial Catalog=');
      l2 := SplitStr(l3, ';');

      Dmod1.ADOConnection1.connected := False;
      Dmod1.ADOConnection1.ConnectionString := l1 + 'Initial Catalog=master;' + l3;
      try
        Dmod1.ADOConnection1.connected := true;
        try
          dmod1.ADOConnection1.Execute('CREATE DATABASE ' + l2, i);
          Dmod1.ADOConnection1.connected := False;
          Dmod1.ADOConnection1.ConnectionString := DbConn;
          Dmod1.ADOConnection1.connected := true;
          MakeDB := True;
        except
          DBExcists := false;
        end;
      except
        DBExcists := false;
      end;
      if not DBExcists then
        Exit;
    end;

    // Kontrollera om databasen innehåller CONTR_BASE annars skapar du en DB.
    if MakeDB then
    begin
      ds := CreateDS('SELECT TOP 1 * FROM CONTR_BASE');
      try
        ds.Open;
        MakeDB := False;
      except
        MakeDB := True;
      end;
      if MakeDB then
      begin
        SL := TStringList.Create;
        SL.LoadFromFile('SQL.TXT');
        SetDS(ds,'');
        ds.ParamCheck := False;
        For i := 0 to SL.Count-1 do
        begin
          L1 := trim(SL[i]);
          if L1='' then
          begin
             try
               ExecDS(ds);
               SetDS(ds,'');
               ds.ParamCheck := False;
             except
             end;
          end
          else
          begin
            ds.SQL.Add(SL[i]);
          end;
        end;
        sl.Free;
      end;

      FreeDS(ds);
    end;
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

procedure TfrmMain.Standardrapporter1Click(Sender: TObject);
begin
  frmutskrift := TfrmUtskrift.Create(Self);
  frmutskrift.ShowModal;
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

procedure TfrmMain.Kreditering1Click(Sender: TObject);
begin
  with TFrmUrval1.Create(nil) do
  begin
    ShowModal;
    free;
  end;
end;

end.



