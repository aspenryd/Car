{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     UtskriftsDialog.pas
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
{ $Log:  14892: UTSKRIFTSDIALOG.pas 
{
{   Rev 1.0    2004-08-18 11:01:08  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:32  peter
}
{
{   Rev 1.0    2003-03-17 14:41:48  Supervisor
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
unit UtskriftsDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TFrmUtsDg = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUtsDg: TFrmUtsDg;

implementation

uses Main, Kontrakt;

{$R *.DFM}

procedure TFrmUtsDg.FormActivate(Sender: TObject);
begin
  if dgtimer>0 then
  Begin
    timer1.Interval :=dgtimer*1000;
    timer1.Enabled :=True;
  End;
  edit1.SetFocus;
  edit1.SelectAll ;  
end;

procedure TFrmUtsDg.Timer1Timer(Sender: TObject);
begin
  BitBtn1.Click ;
end;

procedure TFrmUtsDg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dgtimer > 0 then
   timer1.Enabled :=False;
end;

procedure TFrmUtsDg.FormShow(Sender: TObject);
begin
  edit1.SetFocus ;
end;

procedure TFrmUtsDg.BitBtn1Click(Sender: TObject);
var
  i: integer;
begin
  try
    i := StrToInt(Edit1.Text);
  except
    ShowMessage('Antalet måste vara ett heltal.');
    ModalResult := mrNone;
  end;
end;

end.

