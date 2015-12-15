{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\UtskriftsDialog.pas
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
{ $Log:  13039: UTSKRIFTSDIALOG.pas 
{
{   Rev 1.0    2003-03-20 13:59:34  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:08  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:10  Supervisor
{ Bytt ut LMD och BFC Combo
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUtsDg: TFrmUtsDg;

implementation

{$R *.DFM}

procedure TFrmUtsDg.FormActivate(Sender: TObject);
begin
//!  if dgtimer>0 then
//!  Begin
//!    timer1.Interval :=dgtimer*1000;
//!    timer1.Enabled :=True;
//!  End;
 edit1.SetFocus ;
end;

procedure TFrmUtsDg.Timer1Timer(Sender: TObject);
begin
  BitBtn1.Click ;
end;

procedure TFrmUtsDg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//!  if dgtimer > 0 then
//!   timer1.Enabled :=False;
end;

end.

