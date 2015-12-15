{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Not_Registred.pas
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
{ $Log:  13570: NOT_REGISTRED.pas
{
{   Rev 1.1    2004-01-29 10:26:42  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:48  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:00:28  peter
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
{   Rev 1.0    2003-03-17 09:25:26  Supervisor
{ Start av vc
}
unit Not_Registred;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons;

type
  TFrmNotReg = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNotReg: TFrmNotReg;

implementation

{$R *.DFM}

end.

