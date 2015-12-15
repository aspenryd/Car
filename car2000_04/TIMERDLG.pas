{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     TimerDlg.pas
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
{ $Log:  14880: TIMERDLG.pas 
{
{   Rev 1.0    2004-08-18 11:01:06  pb64
{ Start inför införande av kontraktsfakturering.
{ 
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
{   Rev 1.0    2003-03-17 09:25:28  Supervisor
{ Start av vc
}
unit TimerDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TDlgTimer = class(TForm)
    Label1: TLabel;
    EdtTimer: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgTimer: TDlgTimer;

implementation

uses Main;

{$R *.DFM}

procedure TDlgTimer.FormActivate(Sender: TObject);
begin
  edttimer.text := inttostr(frmmain.ObKTimer);
end;

end.

