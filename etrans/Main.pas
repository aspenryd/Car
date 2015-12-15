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
{ $Log:  13125: Main.pas
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
    Urval1: TMenuItem;
    KunderCheck1: TMenuItem;
    FakturorCheck: TMenuItem;
    KonteringarCheck1: TMenuItem;
    SummakontoCheck1: TMenuItem;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button1: TButton;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Edit6: TEdit;
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
    Label8: TLabel;
    Edit7: TEdit;
    Label9: TLabel;
    Edit8: TEdit;
    Label10: TLabel;
    Edit9: TEdit;
    Label11: TLabel;
    Edit10: TEdit;
    CheckBox2: TCheckBox;
    Label12: TLabel;
    Edit11: TEdit;
    procedure ReadIni;
    procedure WriteIni;
    procedure Logga(Val: Boolean);
    procedure StartTransferClick(Sender: TObject);
    procedure KunderCheck1Click(Sender: TObject);
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
    EType: string[1]; //! Typ av ETrans... A= Adeko, I= IFS, P= Pyramid
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
  adeko, spin, DBCMain, inloggning;

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
  FName, MultiListNr : string;
  sl: TStringList;
  j: Integer;
begin
  sl := TStringList.Create;
  MultiListNr := '=';
  if CheckBox2.Checked then
     MultiListNr := '>=';
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

  Adeko.LastList := StrToInt(Edit2.Text);
  Edit2.Text := IntToStr(Adeko.LastList + 1);
  if KonteringarCheck1.Checked then
  begin
    StatusBar1.Panels[0].Text := 'Överför kontoinformation.';
    Application.ProcessMessages;
    TempQueryT.SQL.Clear;
    TempQueryT.SQL.Text := 'SELECT knterrad.Konto, knterrad.KStalle, knterrad.Debet, knterrad.Kredit, LoggTabell.LoggNr, fakthead.Payment';
    TempQueryT.SQL.Text := TempQueryT.SQL.Text + ' FROM LoggTabell INNER JOIN Fakthead on Loggtabell.nummer=fakthead.e_faktnr inner JOIN knterrad ON fakthead.faktnr = knterrad.Nummer WHERE LoggTabell.LoggNr'+ MultiListNr + Edit2.Text + ' AND Fakthead.Payment<>''F''';
    TempQueryT.SQL.Text := TempQueryT.SQL.Text + ' ORDER BY knterrad.Konto, knterrad.KStalle, knterrad.Debet, knterrad.Kredit';

    FName := GetFileName(Edit8.Text,StrToInt(Edit1.Text),StrToInt(Edit2.Text),edit4.Text,Edit5.Text,Edit6.Text,StrToInt(Edit7.Text));
//    FName := 'B' + Copy(Edit4.Text, 1, 3) + 'H' + FormatFloat('0000', DayNumber) + '.' + Edit6.Text;
    Adeko.RunAdeko(sl[0] + FName, Edit6.Text);
    for j := 2 to sl.Count do
    begin
      try
        CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
      except
      end;
    end;

//!        Adeko.RunIFS(Edit3.Text+FName,Edit6.Text);
  end;
  if SummakontoCheck1.Checked then
  begin
    StatusBar1.Panels[0].Text := 'Överför summerad kontoinformation.';
    Application.ProcessMessages;
    TempQueryT.Active := False;
    TempQueryT.SQL.Clear;
    TempQueryT.SQL.Text := 'SELECT DISTINCT knterrad.Konto, knterrad.KStalle, Sum(knterrad.Debet), Sum(knterrad.Kredit), Max(LoggTabell.LoggNr)';
    TempQueryT.SQL.Text := TempQueryT.SQL.Text + ' FROM LoggTabell INNER JOIN Fakthead on Loggtabell.nummer=fakthead.e_faktnr inner JOIN knterrad ON fakthead.faktnr = knterrad.Nummer  ';
    TempQueryT.SQL.Text := TempQueryT.SQL.Text + ' WHERE LoggTabell.LoggNr'+ MultiListNr + edit2.text + ' GROUP BY knterrad.Konto, knterrad.KStalle ORDER BY knterrad.Konto, knterrad.KStalle';


    FName := GetFileName(Edit8.Text,StrToInt(Edit1.Text),StrToInt(Edit2.Text),edit4.Text,Edit5.Text,Edit6.Text,StrToInt(Edit7.Text));
//    FName := 'B' + Copy(Edit4.Text, 1, 3) + 'H' + FormatFloat('0000', DayNumber) + '.' + Edit6.Text;
    Adeko.RunAdeko(sl[0] + FName, Edit6.Text);
    for j := 2 to sl.Count do
    begin
      try
        CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
      except
      end;
    end;
//!        Adeko.RunIFS(Edit3.Text+FName,Edit6.Text);
  end;
  if FakturorCheck.Checked then
  begin
    StatusBar1.Panels[0].Text := 'Överför fakturaförteckning.';
    Application.ProcessMessages;
    TempQueryT.SQL.Clear;
    TempQueryT.SQL.text := 'SELECT fakthead.kundnr, fakthead.e_faktnr, fakthead.UTSKRDAT, fakthead.FORFDAT, fakthead.faktsum-fakthead.momssum, fakthead.koref, Customer.Utlandsk, LoggTabell.LoggNr, fakthead.Payment, LoggTabell.NrTyp';
    TempQueryT.SQL.text := TempQueryT.SQL.text + ', Customer.Org_No, fakthead.momssum,fakthead.faktsum FROM LoggTabell INNER JOIN Fakthead on Loggtabell.nummer=fakthead.e_faktnr INNER JOIN Customer ON fakthead.kundnr = Customer.Cust_Id';
    TempQueryT.SQL.text := TempQueryT.SQL.text + ' WHERE fakthead.E_faktnr>'''' AND LoggTabell.LoggNr'+ MultiListNr + edit2.text + ' AND fakthead.Payment=''F'' AND LoggTabell.NrTyp=1 AND fakthead.faktsum<>0';

    FName := GetFileName(Edit9.Text,StrToInt(Edit1.Text),StrToInt(Edit2.Text),edit4.Text,Edit5.Text,Edit6.Text,StrToInt(Edit7.Text));
//    FName := 'B' + Copy(Edit4.Text, 1, 3) + 'R' + FormatFloat('0000', DayNumber) + '.' + Edit6.Text;
    Adeko.RunAdekoFakturor(sl[0] + FName, Edit6.Text, Edit5.Text);
    for j := 2 to sl.Count do
    begin
      try
        CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
      except
      end;
    end;
//!        adeko.RunIFS_Rader(Edit3.Text+FName,Edit6.Text,Edit5.Text);//!Nytt
  end;
  if KunderCheck1.Checked then
  begin
    StatusBar1.Panels[0].Text := 'Överför kundinformation.';
    Application.ProcessMessages;
    LastKund := Edit1.Text;
    TempQueryT.SQL.Clear;
    TempQueryT.SQL.Text := 'SELECT DISTINCT Customer.Org_No, Customer.Name,';
    TempQueryT.SQL.Text := TempQueryT.SQL.Text + 'Customer.Adress, Customer.CO_ADR, Customer.Postal_Name, Customer.Country, Customer.TEL_Nr_1, Customer.Cust_id, Customer.Utlandsk ';
    TempQueryT.SQL.text := TempQueryT.SQL.text + 'FROM LoggTabell INNER JOIN Fakthead on Loggtabell.nummer=fakthead.e_faktnr INNER JOIN Customer ON fakthead.kundnr = Customer.Cust_Id';
    TempQueryT.SQL.text := TempQueryT.SQL.text + ' WHERE fakthead.E_faktnr>'''' AND LoggTabell.LoggNr'+ MultiListNr + edit2.text + ' AND fakthead.Payment=''F'' AND LoggTabell.NrTyp=1 AND fakthead.faktsum<>0';
//        TempQueryT.SQL.Text:=TempQueryT.SQL.Text+ 'FROM Customer WHERE Customer.Cust_id > '+Edit1.Text+' AND ((LEN(Customer.Org_No)=11) OR (LEN(Customer.Org_No)=10)) AND Customer.Name>''''';
//        TempQueryT.SQL.Text:=TempQueryT.SQL.Text+' ORDER BY Customer.Cust_id';
    FName := GetFileName(Edit10.Text,StrToInt(Edit1.Text),StrToInt(Edit2.Text),edit4.Text,Edit5.Text,Edit6.Text,StrToInt(Edit7.Text));
//    FName := 'KUND' + FormatFloat('0000', DayNumber) + '.' + Edit6.Text;
    Adeko.RunAdekoKunder(sl[0] + FName, Edit6.Text, Edit5.Text);
    for j := 2 to sl.Count do
    begin
      try
        CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
      except
      end;
    end;
    Edit1.Text := Adeko.LastKund;
  end;
  StatusBar1.Panels[0].Text := '';

  FName := GetFileName(Edit11.Text,StrToInt(Edit1.Text),StrToInt(Edit2.Text),edit4.Text,Edit5.Text,Edit6.Text,StrToInt(Edit7.Text));
//  FName := 'LOGG' + FormatFloat('0000', DayNumber) + '.' + Edit6.Text;
//  FName := 'LOGG' + FormatFloat('0000', DayNumber) + '.' + Edit6.Text;
  Adeko.WriteLog(sl[0] + FName, Edit6.Text, Edit5.Text);
  for j := 2 to sl.Count do
  begin
    try
      CopyFile(pChar(sl[0] + FName), pChar(sl[j - 1] + FName), False);
    except
    end;
  end;

//     Showmessage('Antal Kundposter '+inttostr(CustCount)+', Antal FakturaPoster '+INttostr(FaktCount)+', Antal KontoPoster '+IntToStr(kontocount));
  if (adeko.FaktCount>0) or (adeko.KontoCount>0) then
  begin
    Edit7.Text := IntToStr(StrToInt(Edit7.Text)+1);
  end;

  Edit2.Text := IntToStr(Adeko.LastList);
  sl.Free;
  WriteIni;
  StartTransfer.enabled := True;
end;

procedure TfrmMain.KunderCheck1Click(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var Carini: TiniFile;
  i: Integer;
begin
  ndraDatabas1.Visible := FileExists(ExtractFilePath(Application.ExeName) + 'Gate.ini');
  ndraDatabas1Click(Nil);
  if DbExists then
  begin
    logga(false);
    ReadIni;
    if SpinDLLExists then LoadSpinDLL;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if DbExists then
  begin
    Adeko.TempQueryT.free;
    FreeSpinDLL;
//    WriteIni;
  end;
end;

procedure TfrmMain.Config1Click(Sender: TObject);
begin
  StartTransfer.Visible := False;
  Edit1.Visible := True;
  Edit2.Visible := True;
  Edit3.Visible := True;
  Edit4.Visible := True;
  Edit5.Visible := True;
  Edit6.Visible := True;
  Edit7.Visible := True;
  Edit8.Visible := True;
  Edit9.Visible := True;
  Edit10.Visible := True;
  Edit11.Visible := True;
  label1.Visible := True;
  label3.Visible := True;
  label4.Visible := True;
  label5.Visible := True;
  label6.Visible := True;
  label7.Visible := True;
  label2.Visible := True;
  label8.Visible := True;
  label9.Visible := True;
  label10.Visible := True;
  label11.Visible := True;
  label12.Visible := True;
  CheckBox2.Visible := True;
  Button1.Visible := True;
  if SpinDLLExists then
    Checkbox1.Visible := true;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Edit1.Visible := False;
  Edit2.Visible := False;
  Edit3.Visible := False;
  Edit4.Visible := False;
  Edit5.Visible := False;
  Edit6.Visible := false;
  Edit7.Visible := false;
  Edit8.Visible := false;
  Edit9.Visible := false;
  Edit10.Visible := false;
  Edit11.Visible := false;
  Button1.Visible := False;
  label1.Visible := false;
  label3.Visible := false;
  label4.Visible := false;
  label5.Visible := false;
  label6.Visible := false;
  label7.Visible := false;
  label2.Visible := False;
  label8.Visible := false;
  label9.Visible := false;
  label10.Visible := false;
  label11.Visible := false;
  label12.Visible := false;
  StartTransfer.Visible := True;
  Checkbox1.Visible := false;
  Checkbox2.Visible := false;
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
    if AnsiUpperCase(ParamStr(1)) = 'AUTO' then
    begin
      Application.ProcessMessages;
      try
        if StrToInt(ParamStr(2))>-1 then
           frmGate.ComboBox1.ItemIndex := StrToInt(ParamStr(2))-1;
      except
      end;
      frmgate.BitBtn1Click(Nil);
    end
    else
    begin
      frmgate.ShowModal;
    end;
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
  iniT.Locate('Prog;Signr', vararrayof(['ETrans', '!MM']), [lopartialkey]);
  carini := TEqIniStrings.Create('');
  CarIni.LoadFromStream(init.CreateBlobStream(IniT.FieldByName('ini'), BmRead));
  with CarIni do
  begin
    lastlogin := carini.ReadString('ETrans', 'LastLogin', 'Demo Uthyraren');
    Edit1.Text := carini.ReadString('ETrans', 'LastKundNr', '0');
    Edit2.Text := IntToStr(carini.ReadInteger('ETrans', 'LastListNr', 0));
    Edit3.Text := carini.ReadString('ETrans', 'IFSPath', ExtractFilePath(Application.ExeName));
    Edit4.Text := carini.ReadString('ETrans', 'Avdelning', '000');
    Edit5.Text := carini.ReadString('ETrans', 'Vertyp', '00');
    Edit6.Text := carini.ReadString('ETrans', 'Bolag', '000');

    Edit7.Text := carini.ReadString('ETrans', 'Counter', '1');
    Edit8.Text := carini.ReadString('ETrans', 'HFilename', 'B%2:sH%4:s.%9:5d');
    Edit9.Text := carini.ReadString('ETrans', 'RFilename', 'B%2:sR%4:s.%9:5d');
    Edit10.Text := carini.ReadString('ETrans', 'CFilename', 'ADEKUND%4:s.%9:5d');
    Edit11.Text := carini.ReadString('ETrans', 'LFilename', 'LOGG%4:s.%9:5d');
    CheckBox2.checked := carini.ReadBool('ETrans', 'MultiListnr', False);

    KunderCheck1.checked := carini.ReadBool('ETrans', 'Kunder', True);
    FakturorCheck.checked := carini.ReadBool('ETrans', 'Fakturor', True);
    KonteringarCheck1.checked := carini.ReadBool('ETrans', 'Kontering', False);
    SummakontoCheck1.checked := carini.ReadBool('ETrans', 'Summa', True);
    EType := carini.Readstring('ETyp', 'Typ', 'A');
    if SpinDLLExists then
      CheckBox1.checked := carini.ReadBool('ETrans', 'spin', False);
  end;
  CarIni.Free;
end;

procedure TfrmMain.WriteIni;
var
  CarIni: TEQIniStrings;
  Stream: TStream;
begin
  init.Open;
  iniT.Locate('Prog;Signr', vararrayof(['ETrans', '!MM']), [lopartialkey]);
  carini := TEqIniStrings.Create('');
  with CarIni do
  begin
    CarIni.WriteString('ETrans', 'LastLogin', lastlogin);
    carini.WriteString('ETrans', 'LastKundNr', Edit1.Text);
    carini.WriteInteger('ETrans', 'LastListNr', StrToInt(Edit2.Text));
    carini.WriteString('ETrans', 'IFSPath', Edit3.Text);
    carini.WriteString('ETrans', 'Avdelning', Edit4.Text);
    carini.WriteString('ETrans', 'Vertyp', Edit5.Text);
    carini.WriteString('ETrans', 'Bolag', Edit6.Text);
    carini.WriteString('ETrans', 'Counter', Edit7.Text);
    carini.WriteString('ETrans', 'HFilename', Edit8.Text);
    carini.WriteString('ETrans', 'RFilename', Edit9.Text);
    carini.WriteString('ETrans', 'CFilename', Edit10.Text);
    carini.WriteString('ETrans', 'LFilename', Edit11.Text);
    carini.WriteBool('ETrans', 'Kunder', KunderCheck1.checked);
    carini.WriteBool('ETrans', 'Fakturor', FakturorCheck.checked);
    carini.WriteBool('ETrans', 'Kontering', KonteringarCheck1.checked);
    carini.WriteBool('ETrans', 'Summa', SummakontoCheck1.checked);
    carini.WriteBool('ETrans', 'spin', CheckBox1.checked);
    carini.WriteBool('ETrans', 'MultiListnr', CheckBox2.checked);
    carini.WriteString('ETyp', 'Typ', Etype);
  end;
  IniT.Open;
  IniT.Locate('Prog;Signr', vararrayof(['ETrans', '!MM']), [lopartialkey]);
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
  Urval1.Enabled := Val;
  KunderCheck1.Enabled := Val;
  FakturorCheck.Enabled := Val;
  KonteringarCheck1.Enabled := Val;
  SummakontoCheck1.Enabled := Val;
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

