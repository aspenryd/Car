{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Dlg_ObjService.pas
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
{ $Log:  14844: DLG_OBJSERVICE.pas 
{
{   Rev 1.0    2004-08-18 11:00:54  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:24  peter
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
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit Dlg_ObjService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TFrmDg_ObjService = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDg_ObjService: TFrmDg_ObjService;

implementation

uses Main;

{$R *.DFM}

procedure TFrmDg_ObjService.FormActivate(Sender: TObject);
begin
   timer1.Enabled :=True;
end;

procedure TFrmDg_ObjService.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   timer1.Enabled :=False;
end;

procedure TFrmDg_ObjService.Timer1Timer(Sender: TObject);
begin
  BitBtn1.Click ;
end;

end.

