{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Login.pas
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
{ $Log:  13012: Login.pas 
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
unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB;

type
  TfrmLogin = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Edit1: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    strLog: string;
    { Private declarations }
  public
    inne: boolean;
    lastlogin, namn: string[50];
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses Main, Dmod;
{$R *.DFM}

procedure TfrmLogin.BitBtn2Click(Sender: TObject);
var
  I: Integer;
begin
  if (UpperCase(strlog) = 'HASP') then
  begin
    frmMain.sign := '$HASP';
    frmMain.inloggad := True;
  end
  else
    if (UpperCase(strlog) = 'LASP') then
    begin
      frmMain.sign := '$LASP';
      frmMain.inloggad := True;
    end
    else
    begin
      dmod2.SignrT.first;
      while not dmod2.SignrT.eof do
    //!for I := 0 to length(signs) -1 do
      begin
        if ansilowercase(combobox1.text) = ansilowercase(dmod2.SignrT.fieldByName('namn').asstring) then
        begin
          frmMain.sign := dmod2.SignrT.fieldbyname('sign').asstring;
          exit;
        end;
        Dmod2.signrT.Next;

      end;
    end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
var I: Integer;
begin
  combobox1.clear;
  dmod2.SignrT.first;
  while not Dmod2.signrT.Eof do
//!  for I := 0 to length(signs) -1 do
  begin
    combobox1.items.add(Dmod2.signrT.fieldbyname('Namn').text);
    dmod2.signrT.next;
  end;
  combobox1.itemindex := 0;
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    modalresult := mrCancel;
  if shift = [ssCtrl, ssShift] then
  begin
    if key in [65..90] then
      strLog := strLog + chr(key);
  end
  else
    strLog := '';
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var i: integer;
    ok: boolean;
begin
  ok := false;

  for i:=0 to ComboBox1.Items.Count do
    if ComboBox1.Items[i] = frmMain.LastLogin then
      ok := true;
  if not ok then
    ComboBox1.Text := ComboBox1.Items[0];
end;

end.

