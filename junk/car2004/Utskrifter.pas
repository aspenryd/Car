{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Utskrifter.pas
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
{ $Log:  13598: Utskrifter.pas
{
{   Rev 1.1    2004-01-29 10:24:30  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:25:56  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.1    2003-10-14 11:35:26  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.0    2003-03-20 14:00:30  peter
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
{   Rev 1.0    2003-03-17 09:25:30  Supervisor
{ Start av vc
}
unit Utskrifter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, eqprn, ComCtrls;

type
  TFrmUtskrift = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LblVal: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    CBGranska: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUtskrift: TFrmUtskrift;

implementation


{$R *.DFM}

procedure TFrmUtskrift.FormCreate(Sender: TObject);
begin
  combobox1.ItemIndex := 0;
  Combobox2.itemindex := 0;
end;

procedure TFrmUtskrift.BitBtn1Click(Sender: TObject);
begin

  if ComboBox1.ItemIndex = 0 then
  begin
    if ComboBox2.ItemIndex = 0 then
      eqprn.PrintAvtal(strtoint(edit1.text), 0, 1, cbgranska.checked);
    if ComboBox2.ItemIndex = 2 then
      eqprn.PrintRegDatAvt(edit1.text, DateToStr(DateTimePicker1.Date), 1, cbgranska.checked);
  end;

  if ComboBox1.ItemIndex = 1 then
  begin
    if ComboBox2.ItemIndex = 0 then
      eqprn.PrintKvitto(StrToInt(edit1.Text), 0, 0, 1, cbgranska.checked);
    if combobox2.itemindex = 1 then
//        dmcrystal.PrintKvitto(0, strtoint(edit1.text), 1, cbgranska.checked);
      eqprn.PrintKvitto(0, 0, StrToInt(edit1.Text), 1, CBGranska.Checked);
    if Combobox2.itemindex = 2 then
      eqprn.PrintRegDatKvi(Edit1.Text, DateToStr(DateTimePicker1.Date), 1, cbgranska.checked);
  end;

end;

procedure TFrmUtskrift.ComboBox2Enter(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 0 then
    ComboBox2.Items.Strings[1] := ''
  else
    ComboBox2.Items.Strings[1] := 'FakturaNr (ENummer)';

end;

procedure TFrmUtskrift.ComboBox2Change(Sender: TObject);
begin
  if ComboBox2.ItemIndex = 2 then begin
    DateTimePicker1.Visible := true;
    Label3.Visible := true;
    Label2.Caption := 'Reg. Nr:';
    DateTimePicker1.TabOrder := 3;
    CBGranska.TabOrder := 4;
    BitBtn1.TabOrder := 5;
    BitBtn2.TabOrder := 6;
  end else begin
    DateTimePicker1.Visible := false;
    Label3.Visible := false;
    Label2.Caption := 'Nummer:';
    DateTimePicker1.TabOrder := 6;
    CBGranska.TabOrder := 3;
    BitBtn1.TabOrder := 4;
    BitBtn2.TabOrder := 5;
  end;
end;

end.

