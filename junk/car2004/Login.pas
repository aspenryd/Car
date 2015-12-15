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
{ $Log:  13566: Login.pas
{
{   Rev 1.1    2004-01-29 10:26:30  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:46  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.1    2003-10-14 11:35:26  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.0    2003-03-20 14:00:28  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:26  Supervisor
{ Start av vc
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
    sign: string;
    lastlogin, namn: string[50];
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses tmpData, Main, Greg;
{$R *.DFM}

procedure TfrmLogin.BitBtn2Click(Sender: TObject);
begin
  if (UpperCase(strLog) = 'LASP') then
    sign := '$LASP';

//!      for I := 0 to length(signs) - 1 do
//!        if ansilowercase(combobox1.text) = ansilowercase(signs[i].name) then
//!        begin
//!          sign := signs[I].sign;
//!          exit;
//!        end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
var I: Integer;
begin
  combobox1.clear;

  for I := 0 to length(signs) - 1 do
    combobox1.items.add(signs[i].name);

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
var
  i: integer;
  ok: boolean;
begin
  ok := false;
  for i := 0 to ComboBox1.Items.Count do
    if ComboBox1.Items[i] = ComboBox1.Text then
      ok := true;

  if not ok then
    ComboBox1.Text := ComboBox1.Items[0];
end;

end.

