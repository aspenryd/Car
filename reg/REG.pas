{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Reg.pas
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
{ $Log:  12981: REG.pas 
{
{   Rev 1.1    2005-02-07 12:24:04  pb64    Version: 2004.0.1
{ NY LICENS METOD
}
{
{   Rev 1.0    2003-03-20 13:53:48  peter
}
{
{   Rev 1.0    2003-03-19 20:49:40  peter
{ test
}
{
{   Rev 1.0    2003-03-17 09:26:24  Supervisor
{ Start av vc
}
unit Reg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, IniFiles, ExtCtrls, registry, OleCtrls, isp3, Spin;

type
  TBok=Record
   boks:String[1];
   Bet:String[10];
  end;
  TFile_Info = record
    FileAttr : integer;
    CreateTime : TFileTime;
    LastAccessTime : TFileTime;
    LastWriteTime : TFileTime;
    VolSerNo : integer;
    FileSizeHigh : integer;
    FileSizeLow : integer;
    NoOfLinks : integer;
    FileIndHigh : integer;
    FileIndLow : integer;
  end;

  TRegForm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    Button4: TButton;
    Bevel1: TBevel;
    Label5: TLabel;
    Edit4: TEdit;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    SpinEdit2: TSpinEdit;
    Label8: TLabel;
    Button1: TButton;
    function UpdateLabel : boolean;
    procedure Edit2Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit4Enter(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SystemTimeToTDateTime(ST : TSystemTime):TDateTime;
function GetFileDateTime(Myfile : String; var DT : TDateTime): Boolean;


var
  RegForm: TRegForm;
  Bokst:array of TBok;
const
  UseSerialNo = true;
  RootDir = 'C:\';
implementation

uses
  SWSecFunc;
{$R *.DFM}

procedure TRegForm.Edit2Enter(Sender: TObject);
Var i,j:Integer;
begin
  Edit2.Text := GetRegCode(Edit1.Text, MaskEdit1.Text);
end;

procedure TRegForm.Edit1Exit(Sender: TObject);
begin
  if (length (Edit1.Text) < 7) AND (length (Edit1.Text) > 0) then
  begin
    ShowMessage('Registreringsnamnet måste vara minst 7 tecken långt!');
    Edit1.SetFocus;
  end;
  if length (Edit1.Text) > 30 then
  begin
    ShowMessage('Registreringsnamnet får max vara 30 tecken långt!');
    Edit1.SetFocus;
  end;
end;

function TRegForm.UpdateLabel : boolean;
var
  AIni: TIniFile;
begin
  result := false;
  if FileExists(RootDir + 'AKEY.INI') then
  begin
    AIni := TIniFile.Create(RootDir + 'AKEY.INI');
   //Label6.Caption := inttostr(AIni.ReadInteger('Keys','Number',0));
    Aini.Free;
    result := true;
    FileSetAttr(RootDir + 'AKEY.INI', faHIDDEN);
  end;
end;

Function CheckTime(InTime : TDateTime; FileName : String) : Boolean;
var
  DT : TDateTime;
begin
  result := false;
  if GetFileDateTime(FileName, DT) then
    if DT = InTime then
      result := true;
end;


function GetFileDateTime(Myfile : String; var DT : TDateTime): Boolean;
var
  FileHandle : Integer;
  CreateT, AccessT, WriteT : TFileTime;
  SysTime : TSystemTime;
begin
  result := false;
  FileHandle := FileOpen(MyFile, fmOpenRead or fmShareDenyNone);
  if GetFileTime(FileHandle, @createT, @accessT, @writeT) then
  begin
    FileTimeToSystemTime(createT, systime);
    DT := SystemTimeToTDateTime(systime);
    result := true;
  end;
end;

procedure TRegForm.Button2Click(Sender: TObject);
begin
  if length(Edit1.Text) < 7 then
  begin
    ShowMessage('Namnet skall vara 9 tecken lång');
    edit1.SetFocus;
    exit;
  end;

  if length(trim(MaskEdit1.Text)) <> 11 then
  begin
    ShowMessage('Ange org/personnummer skall vara 11 tecken lång');
    Maskedit1.SetFocus;
    exit;
  end;

  Edit2Enter(nil);  // beräkna om Registreringskoden

  if length(Edit3.Text)<11 then
  begin
    ShowMessage('Funktionsträngen skall vara minst 11 tecken lång');
    edit3.SetFocus;
    exit;
  end;
  Edit4Enter(nil);  // beräkna om Registreringskoden

  Memo1.Lines.Clear;
  Memo1.Lines.Add('Registreringsuppgifter CAR2004');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Företagsnamn : '+Edit1.Text);
  Memo1.Lines.Add('Org/personnr : '+MaskEdit1.Text);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Reg.kod      : '+Edit2.Text);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Funktioner   : '+Edit3.Text);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Akt.kod      : '+Edit4.Text);
  Memo1.Lines.Add('');



end;


procedure TRegForm.Button4Click(Sender: TObject);
begin
  close;
end;

function SystemTimeToTDateTime(ST : TSystemTime):TDateTime;
begin
  Result := EncodeDate(ST.wYear, ST.wMonth, ST.wDay);
  Result := Result + EncodeTime(ST.wHour, ST.wMinute, ST.wSecond, ST.wMilliseconds);
end;

procedure TRegForm.Edit4Enter(Sender: TObject);
Var i,j:Integer;
begin
  Edit4.Text := GetActCode(Edit3.Text, Edit2.Text);
end;

procedure TRegForm.SpinEdit2Change(Sender: TObject);
var
   y,m,d : Word;

begin
   if SpinEdit2.Text='' then
      exit;

   y := SpinEdit2.Value;
   m := y mod 12;
   d := trunc(y/12);

   if m<9 then
     Label8.Caption := IntToStr(2005+d)+'0'+IntToStr(1+m)
   else
     Label8.Caption := IntToStr(2005+d)+IntToStr(1+m);


end;

procedure TRegForm.Button1Click(Sender: TObject);
var
  s : String;
  i : Integer;
begin
  s:='';
  s := IntToHex(SpinEdit1.Value,1);
  i :=0;
  if CheckBox1.Checked then i:= i+128;
  if CheckBox2.Checked then i:= i+64;
  if CheckBox3.Checked then i:= i+32;
  if CheckBox4.Checked then i:= i+16;
  if CheckBox5.Checked then i:= i+8;
  if CheckBox6.Checked then i:= i+4;
  if CheckBox7.Checked then i:= i+2;
  if CheckBox8.Checked then i:= i+1;

  s := s + IntToHex(i,2)+IntToHex(SpinEdit2.Value,2)+'000000';
  Edit3.Text := s;
end;

end.

