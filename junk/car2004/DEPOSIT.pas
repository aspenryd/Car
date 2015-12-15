{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Deposit.pas
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
{ $Log:  13544: DEPOSIT.pas
{
{   Rev 1.1    2004-01-29 10:26:36  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:40  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:00:24  peter
}
{
{   Rev 1.0    2003-03-17 14:41:44  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:58  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
//  Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
//                                                                //
//  Skapad: 1997-02-07 10:57:18                                   //
// Noteringar :                                                   //
// Historia :                                                     //
////////////////////////////////////////////////////////////////////
unit Deposit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TdlgDeposit = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EditDep: TEdit;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditDepExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgDeposit: TdlgDeposit;

implementation

{$R *.DFM}

procedure TdlgDeposit.FormActivate(Sender: TObject);
begin
  CheckBox1.SetFocus;
end;

procedure TdlgDeposit.FormDeactivate(Sender: TObject);
begin
//  EditDep.Enabled := true;
end;

procedure TdlgDeposit.FormCreate(Sender: TObject);
begin
  Checkbox1.Checked := true;
  EditDep.Text := '0';
end;

procedure TdlgDeposit.EditDepExit(Sender: TObject);
begin
  try
    strtoint((Sender as Tedit).text);
  except
    (Sender as Tedit).Setfocus;
    ShowMessage('Ange ett heltal');
    abort;
  end;
end;

end.

