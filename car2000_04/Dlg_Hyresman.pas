{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Dlg_Hyresman.pas
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
{ $Log:  14842: Dlg_Hyresman.pas 
{
{   Rev 1.0    2004-08-18 11:00:54  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.1    2004-08-10 10:45:40  pb64
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
unit Dlg_Hyresman;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TFrmDg_Hyresman = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Timer1: TTimer;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDg_Hyresman: TFrmDg_Hyresman;

implementation

uses Main;

{$R *.DFM}

procedure TFrmDg_Hyresman.FormActivate(Sender: TObject);
begin
 BitBtn1.SetFocus;
  if ShowCustCompanyTimer > 0 then
   begin
    timer1.Interval :=ShowCustCompanyTimer * 1000;
    timer1.Enabled :=True;
   end;
end;

procedure TFrmDg_Hyresman.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if ShowCustCompanyTimer > 0 then
    timer1.Enabled :=False;
end;

procedure TFrmDg_Hyresman.Timer1Timer(Sender: TObject);
begin
  BitBtn1.Click ;
end;

end.

