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
{ $Log:  13568: Main.pas
{
{   Rev 1.1    2004-01-29 10:26:28  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:46  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.8    2003-12-30 16:21:58  hasp
}
{
{   Rev 1.7    2003-12-29 16:37:58  peter
}
{
{   Rev 1.6    2003-12-29 15:42:38  hasp
}
{
{   Rev 1.5    2003-12-29 00:44:04  hasp
}
{
{   Rev 1.4    2003-12-09 10:33:10  peter
{ Fixat automatisk kontroll och uppdatering av databasen .
}
{
{   Rev 1.3    2003-11-27 13:49:24  peter
{ Bokningsgraf bokning sedan dubbelklick gav fel.
{ Fix av delbetalar kontroll
{ Fix av ett fel inträffar + avrundning av moms i prisberäkning.
}
{
{   Rev 1.2    2003-10-08 11:57:14  peter
}
{
{   Rev 1.1    2003-06-10 13:31:42  hasp
}
{
{   Rev 1.0    2003-03-20 14:00:28  peter
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
{   Rev 1.0    2003-03-17 09:25:26  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
// Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
// Skapad: 1997-02-07 10:59:29                                   //
// Noteringar :                                                   //
// Historia :                                                     //
// Uppföljd 0003 Benny Lauridsen                                  //
////////////////////////////////////////////////////////////////////
//! Ny function GetSql'_Sign i Search  021128
//!SQLKontr, SQLBokn, SQLRet

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Menus, StdCtrls, Buttons, IniFiles, Printers, Registry,
  DB, DBTables, Grids, DBGrids, ImgList, ToolWin, comp2000, Kontrakt, bgmain, Pris,
  {UCrpe32,}jpeg, filectrl, AdoDB, ListComb, Sendkeys, Variants;
  //!CARLocServ_TLB,;

type
  TSearchOption = (soReadOnly, soHidden, soSysFile, soVolumeID, soDirectory, soArchive, soAnyFile);
  TSearchOptions = set of TSearchOption;
  TSearchEvent = procedure(Sender: TObject; SearchRec: TWin32FindData; Path: string) of object;

  TSearchFiles = class(TComponent)
  private
    { Private declarations }
    FItems: TStrings;
    FDirs: TStrings;
    FMask: string;
    FOptions: TSearchOptions;
    FStripDirs: boolean;
    FDoSubs: boolean;
    FAbort: boolean;
    FOnFindFile: TSearchEvent;
    FOnFindDir: TSearchEvent;
    FOnClose: TNotifyEvent;
    FOnAbort: TNotifyEvent;
    procedure SetMask(Value: string);
    procedure SetOptions(Value: TSearchOptions);
    procedure SetDoSubs(Value: boolean);
    procedure SetStripDirs(Value: boolean);
    procedure FindAllFiles(Path, Filename: string; Flags: integer);
    function GetDrive: char;
    procedure SetDrive(Value: Char);
  protected
    { Protected declarations }
    procedure FindDir(FindData: TWin32FindData; Path: string); virtual;
    procedure FindFile(FindData: TWin32FindData; Path: string); virtual;
    procedure DoClose; virtual;
    procedure DoAbort; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Search: boolean;
    procedure Abort;
    property Files: TStrings read FItems;
    property Directories: TStrings read FDirs;
  published
    { Published declarations }
    property FileMask: string read FMask write SetMask;
    property Options: TSearchOptions read FOptions write SetOptions default [soAnyFile, soDirectory];
    property StripDirs: boolean read FStripDirs write SetStripDirs default False;
    property IncludeSubDirs: boolean read FDoSubs write SetDoSubs default True;
    property OnFindFile: TSearchEvent read FOnFindFile write FOnFindFile;
    property OnFindDirectory: TSearchEvent read FOnFindDir write FOnFindDir;
    property OnAbort: TNotifyEvent read FOnAbort write FOnAbort;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  TXTStr = record
    str: string;
  end;
  cbqp = record
    FN: string;
    R1: string;
    R2: string;
  end;
  TMyControl = class(TControl)
  public
    property Caption;
    property Text;
    property Hint;
  end;

  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Arkiv1: TMenuItem;
    Loggain1: TMenuItem;
    Loggaut1: TMenuItem;
    Instllningar1: TMenuItem;
    N2: TMenuItem;
    Avsluta1: TMenuItem;
    Uthyrning1: TMenuItem;
    Nyttkontrakt1: TMenuItem;
    Bokadekontrakt1: TMenuItem;
    terlmning1: TMenuItem;
    Oneway1: TMenuItem;
    Programunderhll1: TMenuItem;
    Grundregister1: TMenuItem;
    Help1: TMenuItem;
    Contents1: TMenuItem;
    SearchforHelpOn1: TMenuItem;
    HowtoUseHelp1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    StatusBar1: TStatusBar;
    N4: TMenuItem;
    Rapporter1: TMenuItem;
    Rapporter2: TMenuItem;
    Statistik1: TMenuItem;
    Byteavbil1: TMenuItem;
    N6: TMenuItem;
    Makron1: TMenuItem;
    N7: TMenuItem;
    Fordonsdatum1: TMenuItem;
    Objektskostnader1: TMenuItem;
    Fnster1: TMenuItem;
    Sidavidsida1: TMenuItem;
    verlappande1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Quickprofile1: TMenuItem;
    ToolButton4: TToolButton;
    ShowMaximized1: TMenuItem;
    Bokningsgraf1: TMenuItem;
    Historik1: TMenuItem;
    Kontraktshistorik1: TMenuItem;
    SpeedButton4: TSpeedButton;
    Panel1: TPanel;
    Image1: TImage;
    SpeedButton5: TSpeedButton;
    Information1: TMenuItem;
    Splitter1: TSplitter;
    Sprk1: TMenuItem;
    OD1: TOpenDialog;
    ndraDatabas1: TMenuItem;
    Timer1: TTimer;
    StandardRapp: TMenuItem;
    SendKey1: TSendKey;
    BtnQp: TSpeedButton;
    cb1: TComboBox;
    Rapporteraccess1: TMenuItem;
    init: TADOTable;
    dmodq1: TADOQuery;

    procedure Bokadekontrakt1Click(Sender: TObject);
    procedure Nyttkontrakt1Click(Sender: TObject);
    procedure terlmning1Click(Sender: TObject);
    procedure Avsluta1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Loggain1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Sidavidsida1Click(Sender: TObject);
    procedure verlappande1Click(Sender: TObject);
    procedure Byteavbil1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Loggaut1Click(Sender: TObject);
    procedure tbQPClick(Sender: TObject);
    procedure Contents1Click(Sender: TObject);
    procedure SearchforHelpOn1Click(Sender: TObject);
    procedure HowtoUseHelp1Click(Sender: TObject);
    procedure reQPChange(Sender: TObject);
    procedure reQPKeyPress(Sender: TObject; var Key: Char);
    procedure Maximizechildren1Click(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure ShowMaximized1Click(Sender: TObject);
    procedure Grundregister1Click(Sender: TObject);
    procedure Bokningsgraf1Click(Sender: TObject);
    procedure reQPExit(Sender: TObject);
    procedure reQPEnter(Sender: TObject);
    procedure Historik1Click(Sender: TObject);
    procedure Kontraktshistorik1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure Objektskostnader1Click(Sender: TObject);
    procedure Fordonsdatum1Click(Sender: TObject);
    procedure ndraDatabas1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StandardRappClick(Sender: TObject);
    procedure cb1Exit(Sender: TObject);
    procedure SF1Close(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnQpClick(Sender: TObject);
    procedure cb1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrintAcc(Sender: TObject);
    procedure KillProgram(Classname: string; WindowTitle: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure MenuOpen(val: boolean);
    // ReadINIFile
    procedure WriteINIFile;
    procedure RegThem;
    procedure GenerellRapport(Sender: TObject);
    procedure GenerelltMakro(Sender: TObject);
    //!Benny för språk Hantering...
    procedure MenyLanguage(sender: TObject);
    procedure GetLanguage;

    procedure LoadReports;
    procedure LoadQP;
    function GetMenuItem(var Top: TMenuItem; srcCaption: string): boolean;
    procedure AppendComp(Form, Comp, Prop, Caption, Lang: string);
    procedure LangMenuClick(Form: TForm; Lang: string);

    { Private declarations }
  public
    { Public declarations }
    OkToUpdateGraph: boolean;
    CheckPnr: Boolean;
    CheckOrgNr: Boolean;
    EnrKontant: Boolean;
    EnrKontoK: Boolean;
    EnrFaktura: Boolean;
    EnrInterna: Boolean;
    Title: string;
    DbTitle: string;
    image: string;
    AviFilm: string;
    Language: string;
    ObKTimer: Integer;
    frmKontraktLista: array[1..3] of TfrmKontrakt;
    LastLogin, sign: string;
    DefaultCDR, PaymentOnBooking, FirstTime, inloggad, dbexists, quit: boolean;
    procedure LoadTmpData;
    procedure LoadCosts;

    procedure UpdFormLang(Form: TForm; Lang: string);
    procedure UpdateLang(Form: TForm; Lang: string);

    procedure CheckLanguage;
    procedure SetLanguage;
    procedure ReadINIFile;
    procedure FillTxtArray(edttext: string);
    function CheckContractNo(ContId: integer): boolean;
    function GetProperName(ContType: ViewForm): string;
    function IsContractOpen(view: ViewForm; var index: integer): boolean;
    function Loggin(sgn, pwd: string): boolean;
    function Logout: boolean;
    function ShowContract(view: ViewForm): integer;
    function LoadContract(contrId: integer): boolean;
    procedure ClosingChild(Sender: TObject);
    procedure WmHotKey(var Msg: TMessage); message WM_HOTKEY;
  end;

type TForm1 = TfrmMain;
var
  ValdSkrivare: string;
  ValdSkrivareVit: string;
  frmMain: TfrmMain;
//!  LocalServer : ITCarLocServ;
//!  TCARSearch : TTCARSearch;
//!  LocalServerMachine : string;
  Km_Kontr: Boolean;
  dgtimer: Integer;
  DeleteBeforeUpdate: boolean;
  IntMoms: Boolean;
  SRISKMoms: Boolean;
  DbWay: string;
  SDBWay: string;
  GS: string; //!GlobalSträng för QP
  TxtStrs: array of TxtStr;
  CbQps: array of CBQP;
  SF1: TSearchFiles;
const
  acQuitPrompt = $00000000;
  acQuitSaveAll = $00000001;
  acQuitSaveNone = $00000002;

  acViewNormal = $00000000;
  acViewDesign = $00000001;
  acViewPreview = $00000002;
  DBDel = '''';
implementation

uses Login, About, search, tmpData, GReg, funcs, history, BilByte, Hints,
  Obcost, Obdat, Splash, Datamodule, DataSession, DBCMain, Utskrifter,
  spin, comobj, Urval1, Urval2, UrvalStr, eqprn, EQIniStrings, PrintDialog;

{$R *.DFM}

{ TSearchfiles }

{ Return a proper current dir. If no drive or path is specified in Filename , a
drive designation will be prepended otherwise Filename is returned unchanged}

function GetProperCurrentDir(Filename: string): string;
begin
  if SetCurrentDir(ExtractFileDir(Filename)) then
    Result := Filename
  else if ExtractFilePath(Filename) = '' then
    Result := ExpandFileName(Filename);
end;

constructor TSearchFiles.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TStringList.Create;
  FDirs := TStringList.Create;
  FDoSubs := True;
  FStripDirs := False;
  FAbort := False;
  FOptions := [soAnyFile, soDirectory];
end;

destructor TSearchFiles.Destroy;
begin
  FItems.Clear;
  FDirs.Clear;
  FItems.Free;
  FDirs.Free;
  inherited Destroy;
end;

function TSearchFiles.Search: boolean;
const FOpts: array[TSearchOption] of integer =
//! (faReadOnly,faHidden,faSysFile,faVolumeID,faDirectory,faArchive,faAnyFile);
  (FILE_ATTRIBUTE_READONLY, FILE_ATTRIBUTE_HIDDEN, FILE_ATTRIBUTE_SYSTEM, $00000008, FILE_ATTRIBUTE_DIRECTORY,
    FILE_ATTRIBUTE_ARCHIVE, FILE_ATTRIBUTE_NORMAL {, FILE_ATTRIBUTE_TEMPORARY, FILE_ATTRIBUTE_COMPRESSED, FILE_ATTRIBUTE_OFFLINE});

var FFlags: integer; i: TSearchOption;
var NewDrive, CurDrive: char;
begin
  FFlags := 0;
  FAbort := False;
  FItems.Clear;
  Result := False;
  if Length(FMask) < 1 then Exit;
  for i := Low(FOpts) to High(FOpts) do
    if i in FOptions then FFlags := FFlags or FOpts[I];

  FMask := GetProperCurrentDir(FMask);
  CurDrive := GetDrive;
  NewDrive := ExtractFileDir(FMask)[1];
  if (NewDrive <> '') and (NewDrive <> CurDrive) then
    SetDrive(NewDrive);

  FindAllFiles(ExtractFilePath(FMask), ExtractFilename(FMask), FFlags);
  SetDrive(CurDrive);
  DoClose;
  Result := True;
end;

procedure TSearchFiles.Abort;
begin
  FAbort := True;
  DoAbort;
end;

procedure TSearchFiles.SetMask(Value: string);
begin
  if FMask <> Value then
    FMask := Value;
end;

procedure TSearchFiles.SetOptions(Value: TSearchOptions);
begin
  if FOptions <> Value then
    FOptions := Value;
end;

procedure TSearchFiles.SetDoSubs(Value: boolean);
begin
  if FDoSubs <> Value then
    FDoSubs := Value;
end;

procedure TSearchFiles.SetStripDirs(Value: boolean);
begin
  if FStripDirs <> Value then
    FStripDirs := Value;
end;

procedure TSearchFiles.FindAllFiles(Path, Filename: string; Flags: integer);
var FHandle: THandle; FindData: TWin32FindData; Cont: bool;
begin
  if FDoSubs or bool(Flags and FILE_ATTRIBUTE_DIRECTORY) then
  begin
  { do subdirs: skip true files }
    FHandle := FindFirstFile(PChar(Path + '*.*'), FindData);
    try
      Cont := FHandle <> INVALID_HANDLE_VALUE;
      while Cont do
      begin
        Application.ProcessMessages;
        if FAbort then
        begin
          if FHandle <> INVALID_HANDLE_VALUE then
            Windows.FindClose(FHandle);
          Exit;
        end;
        if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY > 0)
          and (FindData.cFileName[0] <> '.') then
        begin
          if (FindData.dwFileAttributes and Flags > 0) then
          begin
            FDirs.Add(Path + FindData.cFilename);
            FindDir(FindData, Path);
          end;
          FindAllFiles(Path + FindData.cFilename + '\', Filename, Flags);
        end;
        Cont := Windows.FindNextFile(FHandle, FindData);
      end;
    finally
      if FHandle <> INVALID_HANDLE_VALUE then
        Windows.FindClose(FHandle);
    end;
  end;

  { do this dir (files only) }
  FHandle := FindFirstFile(PChar(Path + Filename), FindData);
  try
    Cont := FHandle <> INVALID_HANDLE_VALUE;
    while Cont do
    begin
      Application.ProcessMessages;
      if FAbort then
      begin
        if FHandle <> INVALID_HANDLE_VALUE then
          Windows.FindClose(FHandle);
        Exit;
      end;
      if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0)
        and (FindData.dwFileAttributes and (Flags and not FILE_ATTRIBUTE_DIRECTORY) > 0) then
      begin
        if FStripDirs then
          FItems.Add(FindData.cFilename)
        else
          FItems.Add(Path + FindData.cFilename);
        FindFile(FindData, Path);
      end;
      Cont := Windows.FindNextFile(FHandle, FindData);
    end;
  finally
    if FHandle <> INVALID_HANDLE_VALUE then
      Windows.FindClose(FHandle);
  end;
end;

procedure TSearchFiles.FindDir(FindData: TWin32FindData; Path: string);
begin
  if Assigned(FOnFindDir) then FOnFindDir(self, FindData, Path);
end;

procedure TSearchFiles.FindFile(FindData: TWin32FindData; Path: string);
begin
  if Assigned(FOnFindFile) then FOnFindFile(self, FindData, Path);
end;

procedure TSearchFiles.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TSearchFiles.DoAbort;
begin
  if Assigned(FOnAbort) then FOnAbort(Self);
end;

function TSearchFiles.GetDrive: char;
begin
  Result := GetCurrentDir[1];
end;

procedure TSearchFiles.SetDrive(Value: char);
begin
  SetCurrentDir(Format('%s:', [Value]));
end;

{ generisk sql fråga som inte returnerar ett resultat (UPDATE etc)
  returnerar antal påverkade rader eller -1 om något gick fel }

function GenericExecSQL(const SQLStr: string): integer;
var Q: TADOQuery;
begin
  Q := CreateDS(SQLStr);
  try
    Result := ExecDS(Q);
  finally
    FreeDS(Q);
  end;
end;


{** returnerar true om tabellen finns i databasen }

function TableExists(const TableName: string): boolean;
var S: TStringlist; i: integer;
begin
  S := TStringlist.Create;
  try
    DmSession.ADOConnection1.GetTableNames(s);
    for i := 0 to S.Count - 1 do
      if Pos('.', S[i]) > 0 then // ta bort SQL servers ''dbo.'' prefix // P3
        S[i] := Copy(S[i], Pos('.', S[i]) + 1, MaxInt);
    Result := S.IndexOf(TableName) > -1;
  finally
    S.Free;
  end;
end;

{ returnerar true om fältet som söks finns i tabellen
  OBS! verifiera först att tabellen finns med TableExists }

function FieldExists(const TableName, FieldName: string): boolean;
var Q: TADOQuery;
begin
  try
    Q := CreateDS(Format('SELECT * FROM %s WHERE 1 < 0', [TableName])); // borde vara tom men fältnamnen kopplade // P3
    try
      Q.Open;
      Result := Q.Fields.FindField(FieldName) <> nil;
    finally
      FreeDS(Q);
    end;
  except
    Result := false;
  end;
end;

function FieldTypeToSQL(FieldType: TFieldType): string;
begin
  { TODO -oP3 -cSQL : ändra SQL konstanterna för en del av dessa typer så att de stämmer bättre med verkligheten }
  case FieldType of
    ftUnknown: Result := '??';
    ftString: Result := 'VARCHAR';
    ftSmallint: Result := 'SHORT';
    ftInteger: Result := 'INTEGER';
    ftWord: Result := 'INTEGER';
    ftBoolean: Result := 'BOOLEAN';
    ftFloat: Result := 'FLOAT';
    ftCurrency: Result := 'MONEY';
    ftBCD: Result := 'BINARY';
    ftDate: Result := 'DATETIME';
    ftTime: Result := 'DATETIME';
    ftDateTime: Result := 'DATETIME';
    ftBytes: Result := 'BINARY';
    ftVarBytes: Result := 'BINARY';

    ftAutoInc: Result := 'COUNTER'; // IDENTITY på MSSQL ???
    ftBlob: Result := 'BINARY';
    ftMemo: Result := 'TEXT';
    ftGraphic: Result := 'BINARY';
    ftFmtMemo: Result := 'TEXT';
    ftParadoxOle: Result := 'BINARY';
    ftDBaseOle: Result := 'BINARY';
    ftTypedBinary: Result := 'BINARY';
    ftCursor: Result := 'BINARY';
    ftFixedChar: Result := 'TEXT';
    ftWideString: Result := 'TEXT';
    ftLargeInt: Result := 'LONG';
    ftADT: Result := 'BINARY';

    ftArray: Result := 'BINARY';
    ftReference: Result := 'BINARY';
    ftDataSet: Result := 'BINARY';
    ftOraBlob: Result := 'BINARY';
    ftOraClob: Result := 'BINARY';
    ftVariant: Result := 'VALUE';
    ftInterface: Result := 'BINARY';
    ftIDispatch: Result := 'BINARY';
    ftGuid: Result := 'GUID';
  end;
end;

function AddTableField(const TableName, FieldName: string; FieldType: TFieldType; Size: integer; XOption: string = 'NULL'): boolean;
var S: string;
begin
  S := FieldTypeToSQL(FieldType);
  if (Size > 0) then
    S := S + Format(' (%d)', [Size]); // COLUMN //
  Result := GenericExecSQL(Format('ALTER TABLE %s ADD %s %s %s', [TableName, FieldName, S, XOption])) > -1;
end;

function DropTableField(const TableName, FieldName: string): boolean;
begin
  Result := GenericExecSQL(Format('ALTER TABLE %s DROP COLUMN %s', [TableName, FieldName])) > -1;
end;


function ChangeTableField(const TableName, FieldName: string; FieldType: TFieldType; Size: integer; XOption: string = 'NULL'): boolean;
var S: string;
begin
  S := FieldTypeToSQL(FieldType);
  if (Size > 0) then
    S := S + Format(' (%d)', [Size]); // COLUMN //
  Result := GenericExecSQL(Format('ALTER TABLE %s ALTER COLUMN %s %s %s', [TableName, FieldName, S, XOption])) > -1;
end;

function CreateVersionTable: boolean;
begin
  Result := TableExists('DBVersion');
  if not Result then
  begin
    Result := GenericExecSQL('CREATE TABLE DBVERSION (VERSION INTEGER)') > -1;
    Result := GenericExecSQL('INSERT INTO DBVERSION VALUES(1)') > -1;
  end;
end;

function CreateErrorLoggTable: boolean;
begin
  Result := TableExists('ERRORLOG');
  if not Result then
  begin
    Result := GenericExecSQL('CREATE TABLE ERRORLOGG (CARTIME DATETIME, CARUSER VARCHAR(40), COMPUTER VARCHAR(40), ERRORMSG VARCHAR(255))') > -1;
  end;
end;

function SetDBVersion(Version: integer): integer;
var Q: TADOQuery;
begin
  Q := CreateDS(Format('UPDATE DBVERSION SET VERSION=%d', [Version]));
  try
    Result := ExecDS(Q);
  finally
    FreeDS(Q);
  end;
  if Result > 0 then
    ShowMessage('Uppgradering klar' + #13 + Format('Databasen har uppdaterats till version %d.00.'#13#10 +
      'Du måste logga ut och in igen för att genomföra ändringarna.', [Version]));
end;

function GetDBVersion: integer;
var Q: TADOQuery;
begin
  Result := -1;
  try
    Q := CreateDS('SELECT VERSION FROM DBVERSION');
    try
      Q.Open;
      if not Q.IsEmpty then
        Result := Q.Fields[0].AsInteger;
    finally
      FreeDS(Q);
    end;
  except
  end;
end;

procedure CheckDBVersion;
var
  i: Integer;
begin
  if GetDBVersion < 0 then
  begin
    CreateVersionTable;
//   AddTableField('DBVERSION','PTYP',ftString,2,'')
    ChangeTableField('CONTR_OBJT', 'Ptype', ftString, 4, 'NULL');
    SetDBVersion(1);
  end;
  if GetDBVersion <= 1 then
  begin
    CreateErrorLoggTable;
    SetDBVersion(2);
  end;
  if GetDBVersion <= 2 then
  begin

  end;
  if GetDBVersion <= 3 then
  begin

  end;
  if GetDBVersion <= 4 then
  begin

  end;
  if GetDBVersion <= 5 then
  begin

  end;
    // etc

end;




function TfrmMain.Loggin(sgn, pwd: string): boolean;
var
  I: Integer;
begin
  result := false;
  inloggad := false;
  sign := '';
  Dmod.Q1.Active := False;
  Dmod.Q1.Sql.Text := 'Select * from Signr where namn=' + dbdel + sgn + dbdel + ' and Password=' + dbdel + pwd + dbdel + '';
  Dmod.Q1.Active := True;
  if (dmod.Q1.RecordCount > 0) or (sgn = '$LASP') then
  begin
    inloggad := true;
    if sgn <> '$LASP' then
      sign := dmod.q1.fieldbyname('Sign').AsString else
      sign := Sgn;
    if sgn <> '$LASP' then
      LastLogin := sgn;
    result := true;
  end;
  MenuOpen(inloggad);
  Statusbar1.Panels[1].text := sign;
  if inloggad then Panel1.Visible := False;
end;

procedure TfrmMain.MenuOpen(val: boolean);
begin
  Uthyrning1.enabled := val;
  Rapporter1.enabled := val;
  Programunderhll1.enabled := val;
  Instllningar1.enabled := val;

  Fnster1.enabled := val;

  Loggain1.Enabled := not Val;
  Loggaut1.Enabled := Val;

  Speedbutton1.enabled := val;
  Speedbutton2.enabled := val;
  Speedbutton3.enabled := val;
  Speedbutton4.enabled := val;

  Sprk1.enabled := Val;
  cb1.Enabled := Val;
  btnqp.enabled := Val;
end;

procedure ShowChild(frm: TForm);
begin
  if frm.WindowState = wsMinimized then
    frm.WindowState := wsNormal
  else
    frm.Show;
end;

procedure TfrmMain.Bokadekontrakt1Click(Sender: TObject);
var I: Integer;
begin
  I := ShowContract(Contract);
end;

function TfrmMain.IsContractOpen(view: ViewForm; var index: integer): boolean;
begin
  result := false;
  index := 0;
  case view of
    booking: index := 1;
    contract: index := 2;
    return: index := 3;
  end;
  if index = 0 then
    exit;
  if assigned(frmKontraktLista[index]) then
    result := true;
end;

function TfrmMain.ShowContract(view: ViewForm): integer;
var K: Integer;
begin
  panel1.visible := False;
  result := -1;
  if IsContractOpen(view, K) then
    ShowChild(frmKontraktLista[K])
  else
  begin
    if K = 0 then
      exit;
    frmKontraktLista[K] := TFrmKontrakt.Create(Application);
    if ShowMaximized1.checked then
      frmKontraktLista[K].WindowState := wsMaximized
    else
      frmKontraktLista[K].WindowState := wsNormal;
    frmKontraktLista[K].ListNumber := K;
    frmKontraktLista[K].UpdateViewType(view);
    if View <> return then
    begin
      (frmKontraktLista[K] as TFrmKontrakt).Scrollbox1.visible := true;
      (frmKontraktLista[K] as TFrmKontrakt).cbObjTyp.SetFocus;
    end;
  end;
  result := K;

end;

procedure TfrmMain.Nyttkontrakt1Click(Sender: TObject);
begin
//! if speedbutton2.Flat then
//! frmKontraktLista[2].Close else
  ShowContract(booking);
end;

procedure TfrmMain.terlmning1Click(Sender: TObject);
var K, I, CID: Integer;
begin
//! if speedbutton3.Flat then
//! frmKontraktLista[3].Close else
  if assigned(frmKontraktLista[3]) then
    ShowChild(frmKontraktLista[3])
  else
  begin
    I := ShowContract(return);
    frmSearch.SSQLString := SQLReturn;
    frmSearch.caption := 'Sökresultat återlämning';
    if frmSearch.ShowSearchResult then //!AND not (frmSearch.SSearchCDS.EOF)
    begin
      CID := strtoint(frmSearch.Param1);
      if CheckContractNo(CID) then
      begin
        I := ShowContract(return);
        (frmKontraktLista[I] as TFrmKontrakt).LoadContract(CID);
      end;
    end else //! Lagt till Else + nästa rad...
      frmKontraktLista[3].BitBtn3.click; //!
  end;
end;

procedure TfrmMain.Avsluta1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MDIChildCount > 0 then
  begin
    if MessageDlg('Du har aktiva fönster. Vill du avsluta ändå?',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      CanClose := false;
  end
  else
    CanClose := true;
end;

procedure TfrmMain.Loggain1Click(Sender: TObject);
var
  Frm: TfrmLogin;
begin
  if assigned(Splashform) then
  begin
    SplashForm.CanClose := True;
    SplashForm.Free;
    SplashForm := nil;
  end;
  frm := TfrmLogin.create(application);
  if LastLogin > '' then
    frm.ComboBox1.text := LastLogin;
  if frm.ShowModal = mrOK then
    if frm.sign = '$LASP' then
      Loggin('$LASP', ' ') else
      if not Loggin(frm.ComboBox1.Text, frm.Edit1.text) then
        ShowMessage('Felaktigt lösenord');
  frm.free;
end;

procedure TfrmMain.RegThem;
begin
  RegisterHotKey(Self.Handle, Handle + 1, MOD_ALT, VK_F1);
  RegisterHotKey(Self.Handle, Handle + 2, MOD_ALT, VK_F2);
  RegisterHotKey(Self.Handle, Handle + 3, MOD_ALT, VK_F3);
end;

procedure TfrmMain.FormCreate(Sender: TObject);

begin
//KillProgram('','ACar2000');
//  MenuOpen(false);
//  RegThem;
//RegisterHotKey(Self.Handle,4,MOD_ALT,VK_F4);
//! dbexists:=true;
  OkToUpdateGraph := true;
  SF1 := TSearchFiles.Create(self);
  Sf1.OnClose := SF1Close;
  deletebeforeupdate := True;
  inloggad := false;
  sign := '';
  FirstTime := true;
  MenuOpen(inloggad);
//  ReadINIFile;
  SpinDllExists := False;
  SpinDllExists := fileexists('Spinapi.dll');
  if spindllexists then
    loadspindll;
  ndraDatabas1.Visible := FileExists(ExtractFilePath(Application.ExeName) + 'Gate.Ini');
end;

procedure TfrmMain.LoadTmpData;
var I: Integer;
begin

  frmSearch.GSQLString := 'Select * from ObjType order by ID';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(OBjTypes, 0);
      while not eof do
      begin
        I := length(OBjTypes);
        SetLength(OBjTypes, I + 1);
        ObjTypes[I].ObId := fieldbyname('ID').AsString;
        ObjTypes[I].ObTyp := fieldbyname('Type').AsString;
        ObjTypes[I].DefDep := fieldbyname('Default_Dep').AsCurrency;
        ObjTypes[I].ShowPClass := fieldbyname('ShowPKlass').AsBoolean;
        ObjTypes[I].ShowPType := fieldbyname('ShowPTyp').AsBoolean;
        ObjTypes[I].ShowDragbil := fieldbyname('ShowDragbil').AsBoolean;
        ObjTypes[I].ShowKM := fieldbyname('ShowKM').AsBoolean;
        next;
      end;
    end;

//! 021107 Baz & LASP för att sortera rätt i grundregisteret på PrisKLass
//! frmSearch.GSQLString := 'Select Pricetab.PKlass, Pricetab.PTyp, Pricetab.PNamn, Pricetab.FDat, Pricetab.TDat from Pricetab order by PNamn';
  frmSearch.GSQLString := 'Select Pricetab.PKlass, Pricetab.PTyp, Pricetab.PNamn, Pricetab.FDat, Pricetab.TDat from Pricetab order by PKlass,PNamn';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(PriceLists, 0);
      while not eof do
      begin
        I := length(PriceLists);
        SetLength(PriceLists, I + 1);
        PriceLists[I].PClass := fieldbyname('PKlass').AsString;
        PriceLists[I].PType := fieldbyname('PTyp').AsString;
        PriceLists[I].PNamn := fieldbyname('PNamn').AsString;
        PriceLists[I].FTime := fieldbyname('FDat').AsDateTime;
        PriceLists[I].TTime := fieldbyname('TDat').AsDateTime;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from BetSt';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(PayAlts, 0);
      while not eof do
      begin
        I := length(PayAlts);
        SetLength(PayAlts, I + 1);
        PayAlts[I].Code := fieldbyname('Kod').AsString;
        PayAlts[I].Name := fieldbyname('Namn').AsString;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from BetSt';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(PayAlts, 0);
      while not eof do
      begin
        I := length(PayAlts);
        SetLength(PayAlts, I + 1);
        PayAlts[I].Code := fieldbyname('Kod').AsString;
        PayAlts[I].Name := fieldbyname('Namn').AsString;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from Signr';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(Signs, 0);
      while not eof do
      begin
        I := length(Signs);
        SetLength(Signs, I + 1);
        Signs[I].Sign := fieldbyname('SIGN').AsString;
        Signs[I].Name := fieldbyname('Namn').AsString;
        Signs[I].Pswrd := fieldbyname('Password').AsString;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from Cards';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(CCards, 0);
      while not eof do
      begin
        I := length(CCards);
        SetLength(CCards, I + 1);
        CCards[I].Id := fieldbyname('TYP').AsString;
        CCards[I].Name := fieldbyname('TYPNamn').AsString;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from DrivM';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(Petrols, 0);
      while not eof do
      begin
        I := length(Petrols);
        SetLength(Petrols, I + 1);
        Petrols[I].Id := fieldbyname('ID').AsString;
        Petrols[I].Name := fieldbyname('Namn').AsString;
        Petrols[I].Cost := fieldbyname('Kostnad').AsCurrency;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from TTyp';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(Telephones, 0);
      while not eof do
      begin
        I := length(Telephones);
        SetLength(Telephones, I + 1);
        Telephones[I].Id := fieldbyname('TeleTyp').AsString;
        Telephones[I].Name := fieldbyname('Telebeskrivning').AsString;
        next;
      end;
    end;

  frmSearch.GSQLString := 'Select * from Param';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      DefBetSt := FieldbyName('DEF_BETSATT').AsString;
      NumOffeCopies := FieldbyName('Offert_copy').AsInteger;
      NumBookCopies := FieldbyName('Bekr_copy').AsInteger;
      NumContCopies := FieldbyName('Kontrakt_copy').AsInteger;
      NumCashCopies := FieldbyName('Kontant_copy').AsInteger;
      NumInteCopies := FieldbyName('Internal_copy').AsInteger;
      NumInvoCopies := FieldbyName('Faktura_copy').AsInteger;
      NumIDepCopies := FieldbyName('Under_copy').AsInteger;
    end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if FirstTime then
  begin
  //!    caption := caption + ' - ' + funcs.RegName;
    LoadReports;
    SetLanguage;
    if language > '!' then
      UpdateLang(Self, Language);
    WriteINIFile;
  end;

  if inloggad = False then
    Statusbar1.Panels[1].text := '';
  caption := Title + ' -' + language;
  LoadCosts;
  LoadTmpData;
  frmGreg.FillCombos;

  FirstTime := false;
  if FileExists(image) then
    image1.Picture.loadfromfile(image);
//½  statusbar1.Panels[2].text := DBTitle;

  if (not inloggad and not assigned(frmLogin)) then
    Loggain1Click(nil);
end;

procedure TfrmMain.ClosingChild(Sender: TObject);
begin
//  if (MDIChildcount = 1) and edtqp.visible then
//    edtqp.Setfocus;
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(application);
  frmAbout.ShowModal;
  frmAbout.free;
end;

procedure TfrmMain.Sidavidsida1Click(Sender: TObject);
begin
  Tile;
end;

procedure TfrmMain.verlappande1Click(Sender: TObject);
begin
  cascade;
end;

procedure TfrmMain.Byteavbil1Click(Sender: TObject);
begin
//  ShowfrmByte;
end;

procedure TfrmMain.ReadINIFile;
var
  CarIni: TEQIniStrings;
begin
  init.IndexFieldNames := 'Prog;Signr';
  init.Active := True;
  iniT.Locate('Prog;Signr', vararrayof(['Car2000', '!MM']), [lopartialkey]);
  carini := TEqIniStrings.Create('');
  CarIni.LoadFromStream(init.CreateBlobStream(IniT.FieldByName('ini'), BmRead));
  with CarIni do
  begin
    ValdSkrivare := ReadString('Params', 'Skrivare', '');
    ValdSkrivareVit := ReadString('Params', 'Skrivarrapp', '');
    DgTimer := Readinteger('Params', 'Dg_Timer', 0);
    PaymentOnBooking := ReadBool('Setup', 'PaymentOnBooking', false);
    DefaultCDR := ReadBool('Setup', 'DefaultCDR', true);
    pris.MomsCountConst := ReadInteger('Setup', 'MomsCountConst', 1);
    Preview := ReadBool('Setup', 'Preview', true);
    rptDirectory := ReadString('Setup', 'rptDirectory', 'C:\Program\Car2000\Rapporter\');
    LastLogin := ReadString('Params', 'LastLogin', '');
    Language := Readstring('Params', 'Language', 'Swe');
    ObKTimer := Readinteger('Params', 'ObjKalTimer', 60);
    CheckPnr := ReadBool('Params', 'CheckPnr', true);
    CheckOrgNr := ReadBool('Params', 'CheckOrgNr', true);
    EnrKontant := ReadBool('Params', 'EnrKontant', true);
    EnrKontoK := ReadBool('Params', 'EnrKontoK', true);
    EnrFaktura := ReadBool('Params', 'EnrFaktura', true);
    EnrInterna := ReadBool('Params', 'EnrInterna', true);
    Km_Kontr := ReadBool('Params', 'KmKontroll', False);

    IntMoms := ReadBool('Params', 'IntMoms', False); //!Falsk för att inte ha moms på Interna Sann för moms på INterna
    SRISKMoms := ReadBool('Params', 'SRISKMoms', True); //!Bestämmer om det skall vara moms på sjävriskreducering
    title := ReadString('Params', 'Title', 'Car2000');
 //   DbWay := readstring('Params', 'Db', 'C:\Program\Car2000\Databas\Car_2000.Mdb');
    SDbWay := readstring('Params', 'SDb', '');
//½    DbTitle := ReadString('Params', 'DbName', 'Standard');
    image := readstring('params', 'image', 'c:\Program\Car2000\Bilder\Car2000.jpg');
    AviFilm := ReadString('Params', 'AviFilm', ExtractFilePath(Application.ExeName) + 'Bilder\CAr2000.Avi');
    if FileExists(image) then
      image1.Picture.loadfromfile(image); // Flyttat hit idag 021007 Rasses födelsedag
    if dbtitle < '!' then
      statusbar1.Panels[2].text := 'Standard' else
      statusbar1.Panels[2].text := DBTitle; // Flyttat hit idag 021007 Rasses födelsedag

  end;
  CarIni.Free;
end;

procedure TfrmMain.WriteINIFile;
var
  CarIni: TEQIniStrings;
  Stream: TStream;
begin
  init.Open;
  iniT.Locate('Prog;Signr', vararrayof(['Car2000', '!MM']), [lopartialkey]);
  carini := TEqIniStrings.Create('');
  with CarIni do
  begin
    WriteString('Params', 'Skrivare', ValdSkrivare);
    WriteString('Params', 'SDB', Sdbway);
    if FileExists(image) then
      WriteString('Params', 'Image', Image);
    WriteInteger('Params', 'dg_timer', dgtimer);
    WriteString('Params', 'Language', Language);
    WriteBool('Setup', 'PaymentOnBooking', PaymentOnBooking);
    WriteBool('Setup', 'DefaultCDR', DefaultCDR);
//! För utlänska kunder
    WriteBool('Params', 'CheckPnr', CheckPnr);
    WriteBool('Params', 'CheckOrgNr', CheckOrgNr);
//! Hit
    WriteBool('Params', 'KmKontroll', Km_Kontr);
    WriteBool('Params', 'EnrKontant', EnrKontant);
    WriteBool('Params', 'EnrKontoK', EnrKontoK);
    WriteBool('Params', 'EnrFaktura', EnrFaktura);
    WriteBool('Params', 'EnrInterna', EnrInterna);

    if pris.MomsCountConst > 0 then
      WriteInteger('Setup', 'MomsCountConst', pris.MomsCountConst);
    WriteBool('Setup', 'Preview', Preview);
    if rptDirectory > '' then
      WriteString('Setup', 'rptDirectory', rptDirectory);
    if LastLogin > '' then
      WriteString('Params', 'LastLogin', LastLogin);
    writeString('Params', 'Db', Dbway);
//½    WriteString('Params', 'DbName', DBtitle);
    WriteINteger('Params', 'ObjKalTimer', ObKTimer);
  end;
  IniT.Open;
  IniT.Locate('Prog;Signr', vararrayof(['Car2000', '!MM']), [lopartialkey]);
  init.Edit;
  Stream := IniT.CreateBlobStream(iniT.FieldByName('Ini'), BmWrite);
  CarIni.SaveToStream(Stream);
  Stream.Free;
  Init.Post;
  CarIni.Free;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if spindllexists then
    Freespindll;
//  WriteINIFile;
//!  LocalServer := nil;
//  TCARSearch := nil;

end;

procedure TfrmMain.LoadCosts;
begin
  frmSearch.GSQLString := 'Select * from Costs';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      first;
      SetLength(costs, 0);
      while not eof do
      begin
        SetLength(costs, length(costs) + 1);
        costs[length(costs) - 1].FName := fieldbyname('costname').AsString;
        Costs[length(costs) - 1].FNumb := fieldbyname('No').AsInteger;
        Costs[length(costs) - 1].FPrice := fieldbyname('Price').AsFloat;
        Costs[length(costs) - 1].FKonto := fieldbyname('Acc_code').AsString;
        Costs[length(costs) - 1].FKStalle := fieldbyname('Acc_center').AsString;
        Costs[length(costs) - 1].FMoms := fieldbyname('VAT').AsFloat;
        next;
      end;
    end;
end;

procedure TfrmMain.Loggaut1Click(Sender: TObject);
begin
  MenuOpen(false);
  sign := '';
  Statusbar1.Panels[1].text := sign;
  Panel1.Visible := True;
  if assigned(ActiveMDIChild) then
    activemdichild.Close;
end;

procedure TfrmMain.tbQPClick(Sender: TObject);
begin
  Btnqp.Click;
end;

procedure TfrmMain.Contents1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TfrmMain.SearchforHelpOn1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_KEY, 0);
end;

procedure TfrmMain.HowtoUseHelp1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TfrmMain.reQPChange(Sender: TObject);
var
  OldPos: integer;
begin
{  with REQP do
  begin
    if length(reQP.Text) = 0 then
      exit;
    OldPos := SelStart;

    if SelStart < 2 then
    begin
  //      strTemp := Copy(Text,2,Length(Text));
      SelStart := 0;
      SelLength := 1;
  //      Text := AnsiUpperCase(Text[1])[1] + strTemp;
      SelAttributes.Color := clRed;
      SelAttributes.style := [fsBold];
    end;

    SelStart := SelStart -1;
    SelLength := 2;
    SelAttributes.color := clBlack;
    SelAttributes.style := [fsBold];
   { begin the search after the current selection if there is one }
    { otherwise, begin at the start of the text }

    {SelLength := 0;
    SelStart := OldPos;
    ShowHintWindow(GetQPHint(reQP.Text),reQP);
  end;}
end;

procedure TfrmMain.reQPKeyPress(Sender: TObject; var Key: Char);
begin
{  key := AnsiUpperCase(Key)[1];
  if key = #13 then
  begin
    key := #0;
    CancelHintWindow;
    InputQP(reQP.Text);
    reQP.lines.clear;
    reQP.visible := false;
    tbQP.Down := false;

  end;}
end;

function TfrmMain.CheckContractNo(ContId: integer): boolean;
begin
  result := false;
  frmSearch.GSQLString := 'Select * from [Contr_Base] Where Contrid = ' + inttostr(ContId);
  if frmSearch.GetSearchResult then
    result := not frmSearch.GSearchCDS.EOF;
end;

procedure TfrmMain.Maximizechildren1Click(Sender: TObject);
begin
  if assigned(ActiveMDIChild) then
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMain.Restore1Click(Sender: TObject);
begin
  if assigned(ActiveMDIChild) then
    ActiveMDIChild.WindowState := wsNormal;
end;

procedure TfrmMain.ShowMaximized1Click(Sender: TObject);
begin
  ShowMaximized1.checked := not ShowMaximized1.checked;
  if assigned(ActiveMDIChild) then
  begin
    if ShowMaximized1.checked then
      ActiveMDIChild.windowState := wsMaximized
    else
      ActiveMDIChild.windowState := wsNormal;
  end;
end;

procedure TfrmMain.WmHotKey(var Msg: TMessage);
begin
  Application.BringToFront;
  if Msg.WParam = Trunc(Handle + 3) then
    terlmning1Click(nil)
  else
    if Msg.WParam = Trunc(Handle + 2) then
      ShowContract(contract)
    else
      if Msg.WParam = Trunc(Handle + 1) then
        ShowContract(booking);
end;

procedure TfrmMain.Grundregister1Click(Sender: TObject);
begin
  frmMain.OkToUpdateGraph := false;
  try
    frmGreg.showmodal;
  finally
    OkToUpdateGraph := true;
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

function TfrmMain.GetMenuItem(var Top: TMenuItem; srcCaption: string): boolean;
begin
  Top := FindMenuItem(Rapporter1, srcCaption);
  if Top = nil then
  begin
    Top := TMenuItem.Create(Self);
    Top.Caption := srcCaption;
    Rapporter1.Add(Top);
  end;
  result := true;
end;

procedure TfrmMain.LoadReports;
var
  myMenu, NewItem: TMenuItem;
begin
  frmSearch.GSQLString := 'Select * from Reports';
  if frmSearch.GetSearchResult then
    with frmSearch.GSearchCDS do
    begin
      First;

      if not EOF then
      begin
        NewItem := TMenuItem.Create(Self);
        NewItem.Caption := '-';
        Rapporter2.Add(NewItem);
      end;
      while not EOF do
      begin
        if (Fieldbyname('Program').AsString = 'Car2000') then
        begin
          if (Fieldbyname('AccessType').AsString = 'A') then
          begin
            NewItem := TMenuItem.Create(Self);
            NewItem.Caption := Trim(Fieldbyname('MenuName').AsString);
            NewItem.hint := Fieldbyname('CallName').AsString;
            NewItem.Onclick := PrintAcc;
            Rapporteraccess1.Enabled := True;
            Rapporteraccess1.Add(NewItem);
          end;

          if (Fieldbyname('AccessType').AsString = 'R') then
          begin
            NewItem := TMenuItem.Create(Self);
            NewItem.Caption := Trim(Fieldbyname('MenuName').AsString);
            NewItem.hint := Fieldbyname('CallName').AsString;
//            if (Fieldbyname('Rep_UTyp').AsString >'!') then
//              NewItem.ImageIndex:=2;
            if NewItem.hint > '!' then
              NewItem.Onclick := GenerellRapport;
            if Fieldbyname('Meny').AsString = 'Rapporter' then
            begin
              Rapporter2.Add(NewItem);
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
          end
          else
            if (Fieldbyname('AccessType').AsString = 'M') then
            begin
              NewItem := TMenuItem.Create(Self);
              NewItem.Caption := Trim(Fieldbyname('MenuName').AsString);
              NewItem.hint := Fieldbyname('CallName').AsString;
              NewItem.Onclick := GenerelltMakro;
              Makron1.Add(NewItem);
              Makron1.Enabled := true;
            end;
        end;
        Next;
      end;
    end;
  GetLanguage;
end;

procedure TfrmMain.GenerellRapport(Sender: TObject);
var
  rpt, RWhere, RField, Str: string;
begin
  if (Sender as TMenuItem).hint > '!' then
  begin
    dmod.Q1.Active := False;
    dmod.q1.SQL.Text := 'Select * from Reports where Program =''Car2000'' AND CallName = ''' + (Sender as TMenuItem).hint + '''';
    dmod.q1.Active := True;

    frmPrintDialog := TfrmPrintDialog.Create(Self);
    frmPrintDialog.Q1 := Dmod.Q1;
    frmPrintDialog.FormCaption := dmod.q1.fieldbyname('MenuName').AsString;
    try
      frmPrintDialog.UrvalsTyp := dmod.q1.fieldbyname('Rep_UTyp').AsInteger;
    except
      frmPrintDialog.UrvalsTyp := 0;
    end;
    dmod.q1.Active := False;
    frmPrintDialog.ReportFileName := rptDirectory + (Sender as TMenuItem).hint;
    frmPrintDialog.ShowModal;
    frmPrintDialog.Free;
  end;
end;

procedure TfrmMain.GenerelltMakro(Sender: TObject);
begin
//  RunMakro((Sender as TMenuItem).hint);
  ShowMessage('Makrohantering ej implementerat');
end;

procedure TfrmMain.Bokningsgraf1Click(Sender: TObject);
begin
  if not assigned(frmBokgraf) then
  begin
    frmBokgraf := TfrmBokgraf.create(self);
    if ShowMaximized1.checked then
      frmBokgraf.WindowState := wsMaximized
    else
      frmBokgraf.WindowState := wsNormal;
  end;
  ShowChild(frmBokgraf);
end;

function TfrmMain.GetProperName(ContType: ViewForm): string;
begin
  case ContType of
    booking: result := 'en bokning';
    contract: result := 'ett kontrakt';
    checkin..return: result := 'en återlämning';
    price: result := 'en prisdialog';
  else
    result := '';
  end;
end;

function TfrmMain.LoadContract(contrId: integer): boolean;
var
  ContType: ViewForm;
  I: Integer;
begin
  result := true;
  try
    frmSearch.GSQLString := 'Select ContrId, Status from [Contr_base] where ContrId = ' + inttostr(contrid);
    if frmSearch.GetSearchResult then
    begin
      case frmSearch.GSearchCDS.FieldByName('Status').value of
        {1 = Offert, 2 = Bokning, 4-6 = kontrakt, 8 = halvcheckin, 9 = återlämnat}
//!        1..2 : ContType := Booking;
//!        4..6 : ContType := Contract;
        1..2: ContType := Contract;
        4..6: ContType := Return;
        7..15: ContType := Return;
      else
        ContType := Booking;
      end;
      if IsContractOpen(ContType, I) then
        ShowMessage('Det finns redan ' + GetProperName(ContType) + ' öppen')
      else
      begin
//!Baz 010125  För att inte kunna lyfta upp återlämningar om de är Konterade...
        dmod.Contr_SubT.Active := False;
        dmod.Contr_SubT.Active := True;
        dmod.Contr_SubT.First;
        if dmod.Contr_SubT.Locate('CONTRID', contrid, []) then
        begin
          if dmod.Contr_SubT.fieldbyname('Status').asinteger <= 10 then
          begin
//!Baz 010125 För att inte kunna lyfta upp återlämningar om de är Konterade...
            I := frmMain.ShowContract(ContType);
            with TfrmKontrakt(frmMain.frmKontraktLista[i]) do
              LoadContract(frmSearch.GSearchCDS.FieldByName('ContrId').AsInteger);
          end
          else
            showmessage('Kontraktet ' + inttostr(contrid) + ' är konterat och kan inte ändras');
        end
        else
        begin
          I := frmMain.ShowContract(ContType);
          with TfrmKontrakt(frmMain.frmKontraktLista[i]) do
            LoadContract(frmSearch.GSearchCDS.FieldByName('ContrId').AsInteger);
        end;
//!   end;//!Baz 010125
      end;
    end;
  except
    result := false;
  end;
end;

procedure TfrmMain.reQPExit(Sender: TObject);
begin
  CancelHintWindow;
end;

procedure TfrmMain.reQPEnter(Sender: TObject);
begin
//!  ShowHintWindow(GetQPHint(reQP.Text),reQP);
end;

function TfrmMain.Logout: boolean;
begin
  result := true;
  Loggaut1Click(nil);
end;

procedure TfrmMain.Historik1Click(Sender: TObject);
var I, CID: Integer;
begin
  if assigned(frmKontraktLista[3]) then
    ShowChild(frmKontraktLista[3])
  else
  begin
    frmSearch.SSQLString := SQLReturnAll;
    frmSearch.caption := 'Historik Återlämning';
    if frmSearch.ShowSearchResult then //!AND not (frmSearch.SSearchCDS.EOF)
    begin
      CID := strtoint(frmSearch.Param1);
      I := ShowContract(return);
      (frmKontraktLista[I] as TFrmKontrakt).LoadContract(CID);
    end;
  end;
end;

procedure TfrmMain.Kontraktshistorik1Click(Sender: TObject);
var
  ContrId: integer;
  strCont: string;
begin
  strCont := '';
  if ActiveMDIChild is TFrmKontrakt then
    strCont := Inttostr((ActiveMDIChild as TFrmKontrakt).ContrID)
  else
    InputQuery('Kontraktshistorik', 'Ange kontraktsnummer', strCont);
  if strCont > '' then
    frmHistory.ShowHistoryForContract(MakeInt(StrCont));
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
{  Panel1.Visible := False;
  if not assigned(frmstat) then
  begin
    FrmStat := Tfrmstat.create(self);
    SpeedButton5.Flat := True;
    showchild(frmstat);
  end
  else
    showchild(frmstat); }
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Bokningsgraf1.Click;
end;

procedure TfrmMain.Information1Click(Sender: TObject);
begin
  speedbutton5.click;
end;

procedure TfrmMain.Objektskostnader1Click(Sender: TObject);
begin
  FrmObCost := TFrmObCost.create(self);
  frmobcost.show;
end;

procedure TfrmMain.Fordonsdatum1Click(Sender: TObject);
begin
  FrmObDat := TFrmObDat.create(self);
  FrmObDat.show;
end;

procedure TfrmMain.GetLanguage;
var i, j: Integer;
  Item: TmenuItem;
begin
//!  j := 4;
//!  i := dmod.LanguageT.FieldCount;
//!  while j < i do
//!  begin
//!    item := Tmenuitem.create(self);
//!    Item.AutoHotkeys := maManual;
//!    Item.Name := dmod.LanguageT.Fields.Fields[j].FieldName;
//!    Item.caption := dmod.LanguageT.Fields.Fields[j].FieldName;
//!    item.OnClick := menylanguage;
//!    sprk1.Insert(sprk1.count, Item);
//!    inc(j);
//!  end;
end;

procedure TfrmMain.MenyLanguage(sender: TObject);
var i, j: integer;
  eng: string;
begin
//! rptDirectory:=extractfilepath(application.exename)+'Rapp_'+(sender as TMenuItem).caption+'\';
  i := frmmain.MainMenu1.items[4].Count;
  j := -1;
  while j < i - 1 do
  begin
    inc(j);
    MainMenu1.items[4].Items[j].Checked := False;
  end;
  (sender as TMenuItem).checked := True;
//! Benny checklanguage;
  UpdateLang(Self, (sender as TMenuItem).Caption);
 //!Benny Sätter Valt språk i Ini genom Variabel Language
  Language := (sender as TmenuItem).Caption;
end;

procedure TfrmMain.CheckLanguage;
var i, j: Integer;
begin
//!Benny testar olika Språk
  i := frmmain.MainMenu1.items[4].Count;
  j := -1;
  while j < i - 1 do
  begin
    inc(j);
    if frmmain.MainMenu1.items[4].Items[j].Checked
      then Language := frmmain.MainMenu1.items[4].Items[j].Caption;
  end;

end;

procedure TfrmMain.AppendComp(Form, Comp, Prop, Caption, Lang: string);
begin
  if dmod.LanguageT.Locate('Form;Comp;Prop', VarArrayOf([form, comp, prop]), [locaseinsensitive]) then
  begin
    if Dmod.LanguageT.FieldByName(Lang).asstring <> Caption then
    begin
      dmod.LanguageT.Edit;
      dmod.LanguageT.fieldbyname(lang).asstring := Caption;
      Dmod.LanguageT.Post;
    end;
  end
  else
  begin
    dmod.LanguageT.append;
    dmod.LanguageT.fieldbyname('Form').asstring := form;
    dmod.LanguageT.fieldbyname('Comp').asstring := Comp;
    dmod.LanguageT.fieldbyname('Prop').asstring := Prop;
    dmod.LanguageT.fieldbyname(Lang).asstring := Caption;
    Dmod.LanguageT.Post;
  end;
end;

procedure TfrmMain.UpdFormLang(Form: TForm; Lang: string);
var I: Integer;
begin
  dmod.LanguageT.open;
  for I := 0 to componentcount - 1 do
  begin
    if form.components[I] is TControl then
    begin
      if TMyControl(Form.Components[I]).Caption > '' then
        AppendComp(Form.Name, (form.components[I] as TControl).name, 'Caption', TMyControl(Form.Components[I]).Caption, lang);
      if TMyControl(Form.Components[I]).Text > '' then
        AppendComp(Form.Name, (form.components[I] as TControl).name, 'Text', TMyControl(Form.Components[I]).Text, lang);
      if TMyControl(Form.Components[I]).Hint > '' then
        AppendComp(Form.Name, (form.components[I] as TControl).name, 'Hint', TMyControl(Form.Components[I]).Hint, lang);
    end;
    if form.components[I] is TMenuItem then
    begin
      if TMenuItem(Form.components[i]).caption > '' then
        AppendComp(Form.Name, (form.components[I] as TComponent).name, 'Caption', TMenuItem(Form.Components[I]).Caption, lang);
      if TMenuItem(Form.Components[i]).hint > '' then
        AppendComp(Form.Name, (form.components[I] as TComponent).name, 'Hint', TMenuItem(Form.Components[I]).Caption, lang);
    end;
  end;
  Dmod.languageT.Close;
end;

procedure TfrmMain.LangMenuClick(Form: TForm; Lang: string);
begin
  UpdFormLang(Self, Lang);
end;

procedure TfrmMain.UpdateLang(Form: TForm; Lang: string);
var i: Integer;
  x: string;
begin
  for i := 0 to form.ComponentCount - 1 do
    if form.components[I] is TControl then
    begin
      if dmod.LanguageT.Locate('Form;Comp', VarArrayOf([form.name, form.Components[i].name]), [LoCaseInsensitive]) then
      begin
        if dmod.LanguageT.FieldByName('Prop').asstring = 'Caption' then
          TMyControl(form.Components[I]).Caption := dmod.LanguageT.fieldByName(Lang).asstring;
        if dmod.LanguageT.FieldByName('Prop').asstring = 'Text' then
          TMyControl(form.Components[I]).Text := dmod.LanguageT.fieldByName(Lang).asstring;
        if dmod.LanguageT.FieldByName('Prop').asstring = 'Hint' then
          TMyControl(form.Components[I]).Hint := dmod.LanguageT.fieldByName(Lang).asstring;
      end; end
    else
      if form.components[I] is TMenuItem then
        if dmod.LanguageT.Locate('Form;Comp', VarArrayOf([Form.name, form.Components[i].name]), [LoCaseInsensitive]) then
        begin
          if dmod.LanguageT.FieldByName('Prop').asstring = 'Caption' then
            TMenuItem(form.components[i]).caption := dmod.LanguageT.fieldByName(Lang).asstring;
          if dmod.LanguageT.FieldByName('Prop').asstring = 'Hint' then
            TMenuItem(form.Components[I]).Hint := dmod.LanguageT.fieldByName(Lang).asstring;
        end;
  Frmmain.Caption := 'Car2000 -' + Lang;
end;

procedure TfrmMain.SetLanguage;
var i, j: Integer;
begin
//!Benny Sätter in Språk
  i := frmmain.MainMenu1.items[4].Count;
  j := -1;
  while j < i - 1 do
  begin
    inc(j);
    if frmmain.MainMenu1.items[4].items[j].checked = false then
      if frmmain.MainMenu1.items[4].Items[j].Caption = Language then
        frmmain.MainMenu1.items[4].Items[j].Checked := true;
  end;
end;

procedure TfrmMain.ndraDatabas1Click(Sender: TObject);
var I, j: integer;
begin
 //!Baz
  if FileExists(ExtractFilePath(Application.ExeName) + 'Gate.ini') then
  begin
    frmgate.ShowModal;
    quit := false;
    if frmgate.modalresult = mrok then
    begin
      DbTitle := frmGate.ComboBox1.Text;
      statusbar1.Panels[2].text := DBTitle;
      loggaut1.Click;

      dmsession.ADOConnection1.close;
      dmsession.ADOConnection1.LoginPrompt := False;
      begin
        if pos('PROVIDER=', Uppercase(DbWay)) = 1 then
        begin
          dmsession.ADOConnection1.ConnectionString := dbway;
        end else
        begin
          dmsession.ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data source=' + dbway;
        end;
      end;
      try
        dmsession.ADOConnection1.connected := true;
      except
        dbexists := false;
        exit;
      end;

      ReadINIFile;
      dbexists := true;

      if assigned(Dmod) then
      begin
        for I := 0 to Dmod.ComponentCount - 1 do
          if dmod.Components[I] is TAdoTable then
            (dmod.Components[I] as TAdoTable).open;

        for I := 0 to frmgreg.ComponentCount - 1 do
          if frmgreg.Components[I] is TAdoTable then
            (frmgreg.Components[I] as TAdoTable).open;

        LoadtmpData;
      end;
    end else
      quit := true; // Stäng av Car om vi inte vill välja någon db vid start.
  end else
  begin
    statusbar1.Panels[2].text := 'Standard';
    DmSession.ADOConnection1.Close;
    dmsession.ADOConnection1.LoginPrompt := False;
    dmsession.ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Car00;Data Source=LocalHost';
    dbWay := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Car00;Data Source=LocalHost';
    try
      DmSession.ADOConnection1.Connected := True;
    except
      quit := True; //! Stäng av om inte sql är igång...
      ShowMessage('Får inte kontakt med databasen. CAR avslutas.');
      Exit;
    end;
    ReadINIFile;
    dbexists := true;
    if assigned(Dmod) then
    begin
      for I := 0 to Dmod.ComponentCount - 1 do
        if dmod.Components[I] is TAdoTable then
          (dmod.Components[I] as TAdoTable).open;

      for I := 0 to frmgreg.ComponentCount - 1 do
        if frmgreg.Components[I] is TAdoTable then
          (frmgreg.Components[I] as TAdoTable).open;

      LoadtmpData;
    end;
  end; //!FileExists

  if not quit then
    CheckDBVersion;


end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  if not Assigned(ActiveMDIChild) then
    panel1.Visible := True
  else
    panel1.visible := False;
end;

procedure TfrmMain.StandardRappClick(Sender: TObject);
begin
  frmutskrift := TfrmUtskrift.Create(Self);
  frmutskrift.ShowModal;
end;

procedure TfrmMain.cb1Exit(Sender: TObject);
begin
//!
end;

procedure TfrmMain.LoadQP;
var s: string;
begin
  sf1.FileMask := extractfilepath(application.exename) + 'Qp\*.*';
  sf1.Search;
end;

procedure TfrmMain.SF1Close(Sender: TObject);
var i, j, l, m: Integer;
  s, r1, r2, crap: string;
  f: Textfile;
begin
  SetLength(cbqps, 0);
  for i := 0 to sf1.files.count - 1 do
  begin
    m := 0;
    l := length(CBQps);
    SetLength(CBQps, L + 1);
    s := sf1.files[i];
    for j := 1 to length(s) do
      if s[j] = '.' then
        s := copy(s, 1, j - 1);
    assignfile(f, extractfilepath(application.exename) + 'qp\' + s + '.qp');
    reset(f);
    while not EOF(f) do
    begin
      inc(m); //!Rad Nummer
      if m = 1 then
        Readln(f, r1);
      if m = 2 then
        ReadLn(f, R2);
      if (m = 3) or (M > 3) then readln(f, crap);
    end;
    cbqps[i].FN := s;
    cbqps[i].R1 := r1;
    cbqps[i].R2 := r2;
    Closefile(f);
  end;
  for i := 0 to length(cbqps) - 1 do
    cb1.items.add(cbqps[i].R1);

end;

procedure TfrmMain.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//!
end;

procedure TfrmMain.FillTxtArray(edttext: string);
var i, j, k, l: Integer;
begin
//!För att kolla Antal Variabler som skickas med
  j := 0;
  k := 0;
  SetLength(txtstrs, 0);
  for i := 1 to length(edttext) do
    if (edttext[i] = ',') or (i = Length(edttext)) then
    begin
      inc(k);
      L := length(TxtStrs);
      SetLength(TxtStrs, L + 1);
      txtstrs[k - 1].str := stringreplace(copy(edttext, j + 1, i - j), ',', '', [rfreplaceall]);
      j := i;
    end;
//!Hit...
end;

procedure TfrmMain.BtnQpClick(Sender: TObject);
begin
  cb1.clear;
  cb1.hint := '';
  if cb1.Visible = true then
    cb1.Visible := false
  else
  begin
    loadqp;
    cb1.visible := True;
    cb1.setfocus;
  end;
  CancelHintWindow;
end;

procedure TfrmMain.cb1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var f: textfile;
  s, Crap: string;
  m, Rad: Integer; //! M för antal Variabler
begin
  if Key = Vk_Return then
  begin
    Cb1.text := cbqps[cb1.ItemIndex].FN;
    cb1.Hint := cbqps[cb1.ItemIndex].R2;
    cb1.SetFocus;
    sendkey1.SendKeys('{Right}' + ',');
    ShowHintWindow(cb1.Hint, cb1);
  end;

  if key = Vk_F3 then
  begin
    m := 1;
    Rad := 0;
    FillTxtArray(cb1.text);
    assignfile(f, extractfilepath(application.exename) + 'qp\' + txtstrs[0].str + '.qp');
    reset(f);
    while not EOF(f) do
    begin
      SLEEP(500);
      S := '';
      inc(Rad);
      if rad < 5 then
        Readln(f, crap)
      else
        readln(f, s);
      if s = 'Text' then
      begin
        s := txtstrs[m].str;
        inc(m);
      end;
      sendkey1.sendkeys(s);
    end;
    closefile(f);
//!  cb1.DroppedDown :=False;
    Btnqp.click;
  end;

  if key = VK_F4 then
  begin
    if (assigned(frmKontraktLista[1])) or (assigned(frmKontraktLista[2])) or (assigned(frmKontraktLista[3])) then
      showmessage('Stäng först ner alla fönster utom Objekstkalendern')
    else
    begin
      Filltxtarray(cb1.text);
      assignfile(f, extractfilepath(application.exename) + 'qp\' + txtstrs[0].str + '.qp');
      reset(f);
      s := '';
      GS := '';
      Rad := 0;
      m := 1; //!För antal Text ifrån TXTfilen
      while not EOF(f) do
      begin
        inc(Rad);
        if rad < 5 then
          Readln(f, crap)
        else
          readln(f, s);
        if s = 'Text' then //! Om det ska in en Variabel
        begin
          s := txtstrs[m].str;
          inc(m);
        end; //!Hit...
        GS := GS + s;
      end;
      sendkey1.sendkeys(GS);
      closefile(f);
      cb1.DroppedDown := true;
      Btnqp.click;
    end; //!  If assigned

  end;
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

procedure TfrmMain.KillProgram(Classname, WindowTitle: string);
var
  Window: HWND;
begin
  if FindWindow(nil, PCHAR(WindowTitle)) <> 0 then
    if MessageDlg('Du har ACar2000 igång, du rekommenderas att avsluta det. Avsluta nu? ', mtWarning, [mbYes, mbNo], 0) = mrYes
      then
    begin
      Window := FindWindow(nil, PCHAR(WindowTitle));
      postmessage(window, WM_QUIT, 0, 0);
    end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteINIFile;
end;

end.

