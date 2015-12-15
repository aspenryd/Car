{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     ..\Gate\Dbcmain.pas
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
{ $Log:  13134: Dbcmain.pas
{
{   Rev 1.4    2008-06-27 13:33:44  Henry
{ Fixat till storleken på fönstret
{
}
{   Rev 1.3    2004-01-29 10:24:26  peter
{ Formatterat källkoden.
}
{
{   Rev 1.2    2003-10-14 11:35:24  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.1    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.0    2003-03-20 14:02:26  peter
}
{
{   Rev 1.0    2003-03-17 14:41:46  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:36:00  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:26:24  Supervisor
{ Start av vc
}
unit DBCMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, IniFiles;

type
  TDBInfo = class
    FName: string;
    FDBPath: string;
    FDBSPath: string;
  end;

  TfrmGate = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure UpdateCombo;
    procedure SavePath(str: string);
    procedure DeleteDB(db: integer);
    procedure SaveDB;
    procedure LoadDB;
    procedure GetPath(str: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ActiveDB: string;
    ActiveRec: Integer;
  end;

var
  frmGate: TfrmGate;
  DBList: TList;
//  dbway:String;//! OBS!!!

implementation

uses GPaths, Main;

{$R *.DFM}

procedure TfrmGate.GetPath(str: string);
var I: Integer;
begin
  for I := 0 to DBList.count - 1 do
    with TDBInfo(DBList.items[i]) do
      if AnsiUpperCase(FName) = AnsiUpperCase(str) then
      begin
        dbi := I + 1;
        frmPath.Edit1.text := FDBPath;
        frmPath.Edit3.text := FName;
        exit;
      end;
  dbi := 0;
  frmPath.Edit1.text := '';
  frmPath.Edit3.text := str;
end;

procedure TfrmGate.DeleteDB(db: integer);
begin
  if DBList.count >= db then
    with TDBInfo(DBList.items[db - 1]) do
    begin
      if MessageDlg('Vill du ta bort "' + FName + '"?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        free;
        DBList.Delete(db - 1);
        UpdateCombo;
        Combobox1.Itemindex := db - 2;
      end;
    end;
end;

procedure TfrmGate.SavePath(str: string);
var
  I: Integer;
  db: TDBInfo;
begin
  if (frmPath.Edit3.text = '') then
  begin
    if dbi > 0 then
      DeleteDB(dbi);
    exit;
  end;
  for I := 0 to DBList.count - 1 do
    with TDBInfo(DBList.items[i]) do
      if AnsiUpperCase(FName) = AnsiUpperCase(str) then
      begin
        FDBPath := frmPath.Edit1.text;
        FName := frmPath.Edit3.text;
        UpdateCombo;
        Combobox1.text := frmPath.Edit3.text;
        exit;
      end;
  DB := TDBInfo.Create;
  DB.FDBPath := frmPath.Edit1.text;
  DB.FName := frmPath.Edit3.text;
  DBList.Add(DB);
  UpdateCombo;
  Combobox1.text := frmPath.Edit3.text;
end;

procedure TfrmGate.UpdateCombo;
var
  I: Integer;
  db: TDBInfo;
begin
  if (DBList.count < 1) then
  begin
    db := TDBInfo.create;
    db.FName := 'Car00';
    db.FDBPath := 'PROVIDER=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Car00;Data Source=LOCALHOST';
    ActiveDB := db.FName;
    DBList.add(db);
  end;
  Combobox1.clear;
  for I := 0 to DBList.count - 1 do
    Combobox1.items.add(TDBInfo(DBList.items[i]).FName);
end;

procedure TfrmGate.BitBtn2Click(Sender: TObject);
var
  str: string;
  frm: TfrmPath;
  i: Integer;
  cl, cl2: boolean;
  db: TDBInfo;
begin
  BitBtn2.Tag := 1;
  cl := false;
  frm := TfrmPath.Create(self);
  str := Combobox1.text;
//!  GetPath(str);
  for I := 0 to DBList.count - 1 do
    with TDBInfo(DBList.items[i]) do
      if AnsiUpperCase(FName) = AnsiUpperCase(str) then
      begin
        dbi := I + 1;
        frm.Edit1.text := FDBPath;
        frm.Edit3.text := FName;
        cl := true;
      end;
  if not cl then
  begin
    dbi := 0;
    frm.Edit1.text := '';
    frm.Edit3.text := str;
  end;
//!
  frm.showModal;
  if frm.ModalResult = mrOK then
  begin
    cl := False;
    if (frm.Edit3.text = '') then
    begin
      if dbi > 0 then
        DeleteDB(dbi);
      cl := true;
    end;
    if not cl then
    begin
      cl2 := false;
      for I := 0 to DBList.count - 1 do
        with TDBInfo(DBList.items[i]) do
          if AnsiUpperCase(FName) = AnsiUpperCase(str) then
          begin
            FDBPath := frm.Edit1.text;
            FName := frm.Edit3.text;
            UpdateCombo;
            Combobox1.text := frm.Edit3.text;
            cl2 := true;
          end;
      if not cl2 then
      begin
        DB := TDBInfo.Create;
        DB.FDBPath := frm.Edit1.text;
        DB.FName := frm.Edit3.text;
        DBList.Add(DB);
        UpdateCombo;
        Combobox1.text := frm.Edit3.text;
      end;
    end;
  end;
  frm.Free;
end;

procedure TfrmGate.FormCreate(Sender: TObject);
begin
  Combobox1.Clear;
  DBList := TList.Create;
  LoadDB;
  UpdateCombo;
//  Combobox1.text := ActiveDB;
  ComboBox1.ItemIndex := ActiveRec - 1;
end;

procedure TfrmGate.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DBList.count - 1 do
    TDBInfo(DBList.items[i]).free;
  DBList.free;
end;

procedure TfrmGate.BitBtn3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmGate.BitBtn1Click(Sender: TObject);
begin
  SaveDB;
  close;
//!  frmMain.DbTitle := ComboBox1.Text;
  modalresult := Mrok;
end;

procedure TfrmGate.LoadDB;
var
  gate: Tinifile;
  I, num, active: integer;
  db: TDBInfo;
begin
  gate := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'gate.ini');
  if gate.ReadString('DB', ExtractFileName(Application.ExeName), '') <> '' then
    BitBtn2.Enabled := False;
  num := gate.ReadInteger('DB', 'NoDB', 0);
  active := gate.ReadInteger('DB', 'active', 0);
  ActiveRec := Active;
  for I := 1 to num do
  begin
    db := TDBInfo.create;
    db.FName := gate.ReadString(inttostr(I), 'Name', '');
    db.FDBPath := gate.ReadString(inttostr(I), 'DB', '');
    if active = I then
      ActiveDB := db.FName;
    DBList.add(db);
  end;
  gate.free;
end;

procedure TfrmGate.SaveDB;
var
  gate: Tinifile;
  I: integer;
begin
  if (not BitBtn2.Enabled) or ((BitBtn2.Tag = 0) and (ComboBox1.ItemIndex + 1 = ActiveRec)) then
  begin
    ActiveDB := TDBInfo(DBList.items[ComboBox1.ItemIndex]).FName;
    dbWay := TDBInfo(DBList.items[ComboBox1.ItemIndex]).FDBPath;
  end
  else
  begin
    gate := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'gate.ini');
    gate.WriteInteger('DB', 'NoDB', DBList.count);
    for I := 0 to DBList.count - 1 do
      with TDBInfo(DBList.items[i]) do
      begin
        gate.WriteString(inttostr(I + 1), 'Name', FName);
        gate.WriteString(inttostr(I + 1), 'DB', FDBPath);
        if AnsiUpperCase(FName) = AnsiUpperCase(Combobox1.text) then
        begin
          gate.WriteInteger('DB', 'Active', I + 1);
          ActiveDB := FName;
          dbway := FDBpath;
        end;
      end;
    gate.free;
  end;
end;

end.

