{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Splash.pas
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
{ $Log:  14878: SPLASH.pas 
{
{   Rev 1.1    2005-02-14 16:08:34  pb64
{ Fixat visning av AVI fil
}
{
{   Rev 1.0    2004-08-18 11:01:04  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:30  peter
}
{
{   Rev 1.0    2003-03-17 14:41:40  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:54  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:28  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
//  Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
//  Skapad: 1997-02-07 11:00:12                                   //
//                                                                //
// Noteringar :                                                   //
//                                                                //
//                                                                //
// Historia :                                                     //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////
unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, jpeg;

type
  TSplashForm = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    Image1: TImage;
    Label3: TLabel;
    Timer1: TTimer;
    Animate1: TAnimate;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CanClose: boolean;
  end;

var
  SplashForm: TSplashForm;
  I: WORD;

const
  WaitTime: integer = 2;
implementation

uses Main;

{$R *.DFM}

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
{
  inc(I);
  if (I = 1) and (fileexists(frmmain.avifilm)) then
  begin
    Animate1.Visible := true;
    Animate1.play(1, 24, 1);
  end;
  if (I > WaitTime) and CanClose then
  begin
    Timer1.Enabled := false;
    close;
    SplashForm.Hide;
    SplashForm.free
  end;
}
end;

procedure TSplashForm.FormActivate(Sender: TObject);
begin
  if fileexists(frmmain.avifilm) then
  begin
    Animate1.FileName := frmmain.avifilm;
    Animate1.Active := true;
    Animate1.Visible := true;
  end
  else
    animate1.Enabled := False;

{
  I := 0;
  Timer1.Enabled := true;
  CanClose := false;

  if fileexists(frmmain.avifilm) then
    Animate1.FileName := frmmain.avifilm
  else //!Benny för att göra Avin Mjuk
    animate1.Enabled := False;
}
end;

end.

