{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     BetVilk.pas
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
{ $Log:  14826: BetVilk.pas 
{
{   Rev 1.0    2004-08-18 11:00:50  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:22  peter
}
{
{   Rev 1.0    2003-03-17 09:25:20  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
//  Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
//  Skapad: 1997-02-07 10:56:15                                   //
//                                                                //
// Noteringar :                                                   //
//                                                                //
//                                                                //
// Historia :                                                     //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////
unit BetVilk;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons;

type
  TdlgBetVillkor = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label1: TLabel;
    RadioButton4: TRadioButton;
    edtDays: TEdit;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure SetDays(days : integer);
    { Private declarations }
  public
    BetVillkor : Integer;
    { Public declarations }
  end;

function ShowDlgBetVillkor(defDays : integer) : integer;

var
  dlgBetVillkor: TdlgBetVillkor;

implementation

uses Kontrakt;

{$R *.DFM}

function ShowDlgBetVillkor(defDays : integer) : integer;
begin
  result := -1;
  dlgBetVillkor := TdlgBetVillkor.create(application);
  try
    dlgBetVillkor.SetDays(defDays);
    if dlgBetVillkor.ShowModal = mrOk then
      result := strtoint(dlgBetVillkor.EdtDays.text);
  finally
    dlgBetVillkor.free;
  end;
end;


procedure TdlgBetVillkor.SetDays(days : integer);
begin
  case days of
    14 : RadioButton1.Checked := true;
    21 : RadioButton2.Checked := true;
    28 : RadioButton3.Checked := true;
  else
    RadioButton4.Checked := true;
    EdtDays.Text := inttostr(days);
  end;
end;

procedure TdlgBetVillkor.RadioButton1Click(Sender: TObject);
begin
  EdtDays.Text := '14';
end;

procedure TdlgBetVillkor.RadioButton2Click(Sender: TObject);
begin
  EdtDays.Text := '21';
end;

procedure TdlgBetVillkor.RadioButton3Click(Sender: TObject);
begin
  EdtDays.Text := '28';
end;

procedure TdlgBetVillkor.RadioButton4Click(Sender: TObject);
begin
  EdtDays.Text := inttostr(stdDays);
//  EdtDays.SetFocus;
end;

procedure TdlgBetVillkor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    modalresult := mrOK;
    key := 0;
  end;
  if KEY = VK_ESCAPE then
  begin
    modalresult := mrCANCEL;
    key := 0;
  end;
end;

end.
