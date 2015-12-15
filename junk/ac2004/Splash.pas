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
{ $Log:  13507: Splash.pas
{
{   Rev 1.1    2004-01-29 10:24:24  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:24:12  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:06  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:08  Supervisor
{ Bytt ut LMD och BFC Combo
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
    Animate1: TAnimate;
    Label3: TLabel;
    Timer1: TTimer;
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
  inc(I);
  if I = 1 then
  begin
    if fileexists(frmMain.Avifilm) then
    begin
      Animate1.Visible := true;
      Animate1.play(1, 24, 1);
    end;
  end;
  if (I > WaitTime) and CanClose then
  begin
    Timer1.Enabled := false;
    close;
    SplashForm.Hide;
    SplashForm.free
  end;
end;

procedure TSplashForm.FormActivate(Sender: TObject);
begin
  I := 0;
  Timer1.Enabled := true;
  CanClose := false;
  if fileexists(frmMain.avifilm) then
    Animate1.FileName := frmMain.avifilm //!Benny för att göra Avin Mjuk
  else
    animate1.Enabled := False;
end;

end.

