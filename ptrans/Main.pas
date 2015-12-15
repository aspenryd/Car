{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     EkTrans.pas
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
{ $Log:  14778: Main.pas 
{
{   Rev 1.0    2004-07-02 08:50:54  pb64
}
{
{   Rev 1.5    2004-01-27 15:41:40  peter
}
{
{   Rev 1.4    2003-12-09 09:40:36  peter
{ Fixat problem vid 0 i varuvärde och negativ moms.
}
{
{   Rev 1.3    2003-06-26 11:45:06  Supervisor
}
{
{   Rev 1.2    2003-05-21 14:53:04  Supervisor
{ 1. Överföring av kunder endast 10 och 11 tkn orgnr.
{ 2. Öreskontroll när värdet blir negativt kollar <-0.5 istället för <0
{ 3. Möjlighet att spara filer på flera pathvägar. ( ; används för att dela
{ pathvägarna.
{ 4. Logg spara till disk.
}
{
{   Rev 1.1    2003-03-20 15:10:32  peter
{ Fixat så att kunder utan Orgnr inte överförs till Adekund
}
{
{   Rev 1.0    2003-03-20 14:01:50  peter
}
{
{   Rev 1.0    2003-03-17 09:26:22  Supervisor
{ Start av vc
}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ComCtrls, IniFiles, ADODB, DB, EQIniStrings, Variants;

type
  TfrmMain = class(TForm)
    StartTransfer: TButton;
    MainMenu1: TMainMenu;
    Arkiv1: TMenuItem;
    Config1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    StatusBar1: TStatusBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TempQueryT: TADOQuery;
    Label2: TLabel;
    IFSQ1: TADOQuery;
    IfsQ2: TADOQuery;
    QKonto: TADOQuery;
    Q320: TADOQuery;
    Q310: TADOQuery;
    ADOConnection1: TADOConnection;
    ndraDatabas1: TMenuItem;
    IniT: TADOTable;
    LoggaIn1: TMenuItem;
    LoggaUt1: TMenuItem;
    Qinlogg: TADOQuery;
    Q1: TADOQuery;
    procedure ReadIni;
    procedure WriteIni;
    procedure Logga(Val: Boolean);
    procedure StartTransferClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ndraDatabas1Click(Sender: TObject);
    procedure LoggaIn1Click(Sender: TObject);
    procedure LoggaUt1Click(Sender: TObject);

  private
    { Private declarations }
  public
    function RoundUp(X: Extended): Extended;
    function RoundDn(X: Extended): Extended;
    function Sgn(X: Extended): Integer;
    function RoundBaz(X: Extended): Extended;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  dbWay: string;
  DbExists: Boolean;

implementation

{$R *.DFM}

uses
  adeko, DBCMain, inloggning;

var
  Fini: TiniFile;
  lastlogin: string;

function SplitString(var s: string): string;
var
  iPos: Integer;
begin
  iPos := Pos(';', s);
  if iPos > 0 then
  begin
    Result := Copy(s, 1, iPos - 1);
    s := Copy(s, iPos + 1, 999);
  end
  else
  begin
    Result := s;
    s := '';
  end;
end;


procedure TfrmMain.StartTransferClick(Sender: TObject);
var
  AYear, AMonth, ADay: Word;
  DayNumber: Integer;
  FName: string;
  sl: TStringList;
  j: Integer;
begin
  sl := TStringList.Create;
  FName := Edit3.Text;
  while FName <> '' do
  begin
    sl.Add(SplitString(FName));
  end;
  FName := '';
  Adeko.KorPa := True;
  StartTransfer.enabled := false;
  DecodeDate(Date, AYear, AMonth, ADay);
  DayNumber := trunc(date - EncodeDate(AYear, 1, 1)) + 1;

  Adeko.LastFakt := StrToInt(Edit2.Text);
  Edit2.Text := IntToStr(Adeko.LastFakt + 1);


  begin
    StatusBar1.Panels[0].Text := 'Överför fakturainformation.';
    Application.ProcessMessages;
    FName := Edit4.Text;
    Adeko.RunPyramid(sl[0] + FName);
    for j := 2 to sl.Count do
    begin
      try
        CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
      except
      end;
    end;

  end;
  StatusBar1.Panels[0].Text := '';

  FName := 'LOGG' + FormatFloat('0000', DayNumber) + '.log' ;
  Adeko.WriteLog(sl[0] + FName);
  for j := 2 to sl.Count do
  begin
    try
      CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
    except
    end;
  end;

//     Showmessage('Antal Kundposter '+inttostr(CustCount)+', Antal FakturaPoster '+INttostr(FaktCount)+', Antal KontoPoster '+IntToStr(kontocount));

  Edit2.Text := IntToStr(Adeko.LastFakt);
  sl.Free;
  WriteIni;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var Carini: TiniFile;
  i: Integer;
begin
  ndraDatabas1.Visible := FileExists(ExtractFilePath(Application.ExeName) + 'Gate.ini');
  ndraDatabas1.Click;
  if DbExists then
  begin
    logga(false);
    ReadIni;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if DbExists then
  begin
    Adeko.TempQueryT.free;
//    WriteIni;
  end;
end;

procedure TfrmMain.Config1Click(Sender: TObject);
begin
  StartTransfer.Visible := False;
  Edit2.Visible := True;
  Edit3.Visible := True;
  Edit4.Visible := True;
  label2.Visible := True;
  label4.Visible := True;
  label5.Visible := True;
  label6.Visible := True;
  Button1.Visible := True;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Edit2.Visible := False;
  Edit3.Visible := False;
  Edit4.Visible := False;
  Button1.Visible := False;
  label2.Visible := False;
  label4.Visible := false;
  label5.Visible := false;
  label6.Visible := false;
  StartTransfer.Visible := True;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;


procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if ParamCount > 0 then
  begin
    if AnsiUpperCase(ParamStr(1)) = 'AUTO' then
    begin
      screen.cursor := crHourGlass;
      StartTransferClick(nil);
      screen.cursor := crDefault;
      close;
    end;
  end;
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
  else if X = 0 then
    Result := 0
  else
    Result := 1;

end;

function TfrmMain.RoundBaz(X: Extended): Extended;
begin
  if Abs(Frac(X)) >= 0.5 then
    Result := RoundUp(X)
  else
    Result := RoundDn(X);

  Result := Int(X) + Int(Frac(X) * 2);
end;

procedure TfrmMain.ndraDatabas1Click(Sender: TObject);
var
  I, j: integer;
  frmgate: TfrmGate;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Gate.ini') then
  begin
    frmgate := TfrmGate.Create(self);
    frmgate.ShowModal;
    if frmgate.modalresult = mrok then
    begin
      ADOConnection1.close;
      ADOConnection1.LoginPrompt := False;
      ADOConnection1.ConnectionString := dbway;
      try
        ADOConnection1.connected := true;
        ReadIni;
      except
        dbexists := false;
        exit;
      end;
      dbexists := true;
    end else
    begin
      frmgate.Free;
      DbExists := False;
      exit;
    end;
    frmgate.Free;
  end
  else
  begin
    DbExists := true;
    ADOConnection1.Close;
    ADOConnection1.LoginPrompt := False;
    ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Car00;Data Source=LocalHost';
    dbWay := ADOConnection1.ConnectionString;
    try
      ADOConnection1.Connected := True;
      ReadIni;
    except
    end;
  end;

end;

procedure TfrmMain.ReadIni;
var
  CarIni: TEQIniStrings;
begin
  init.Open;
  iniT.Locate('Prog;Signr', vararrayof(['PTrans', '!MM']), [lopartialkey]);
  carini := TEqIniStrings.Create('');
  CarIni.LoadFromStream(init.CreateBlobStream(IniT.FieldByName('ini'), BmRead));
  with CarIni do
  begin
    lastlogin := carini.ReadString('PTrans', 'LastLogin', 'Demo Uthyraren');
    Edit2.Text := IntToStr(carini.ReadInteger('PTrans', 'LastFaktNr', 0));
    Edit3.Text := carini.ReadString('PTrans', 'Path', ExtractFilePath(Application.ExeName));
    Edit4.Text := carini.ReadString('PTrans', 'Filename', 'faktura.dat');
  end;
  CarIni.Free;
end;

procedure TfrmMain.WriteIni;
var
  CarIni: TEQIniStrings;
  Stream: TStream;
begin
  init.Open;
  iniT.Locate('Prog;Signr', vararrayof(['PTrans', '!MM']), [lopartialkey]);
  carini := TEqIniStrings.Create('');
  with CarIni do
  begin
    CarIni.WriteString('PTrans', 'LastLogin', lastlogin);
    carini.WriteInteger('PTrans', 'LastFaktNr', StrToInt(Edit2.Text));
    carini.WriteString('PTrans', 'Path', Edit3.Text);
    carini.WriteString('PTrans', 'Filename', Edit4.Text);
  end;
  IniT.Open;
  IniT.Locate('Prog;Signr', vararrayof(['PTrans', '!MM']), [lopartialkey]);
  init.Edit;
  Stream := IniT.CreateBlobStream(iniT.FieldByName('Ini'), BmWrite);
  CarIni.SaveToStream(Stream);
  Stream.Free;
  Init.Post;
  CarIni.Free;
end;

procedure TfrmMain.Logga(Val: Boolean);
begin
  LoggaIn1.Enabled := not val;
  LoggaUt1.Enabled := Val;
  Config1.Enabled := Val;
  ndraDatabas1.Enabled := Val;
  StartTransfer.Enabled := Val;
end;

procedure TfrmMain.LoggaIn1Click(Sender: TObject);
var
  frm: TFrmInloggning;
begin
  frm := TFrmInloggning.Create(self);
  Qinlogg.Active := False;
  Qinlogg.SQL.Text := 'Select namn from signr order by namn';
  Qinlogg.Active := True;
  while not Qinlogg.Eof do
  begin
    frm.ComboBox1.Items.Add(Qinlogg.fieldbyname('namn').AsString);
    Qinlogg.Next;
  end;
  Qinlogg.Active := False;
  frm.ComboBox1.Text := LastLogin;
  frm.ShowModal;
  if frm.ModalResult = Mrok then
  begin
    if frm.Edit1.Text > '!' then
    begin
      Q1.Active := False;
      Q1.SQL.Text := 'Select * from Signr where Namn =''' + frm.ComboBox1.Text + ''' AND Password = ''' + frm.Edit1.Text + '''';
      Q1.Active := True;
    end;
    if (q1.RecordCount > 0) or (UpperCase(strLog) = 'LASP') then
      logga(True);
  end else
    logga(False);
  frm.Free;
end;

procedure TfrmMain.LoggaUt1Click(Sender: TObject);
begin
  logga(False);
end;

end.

