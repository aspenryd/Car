{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     ..\Shared\Urval1.pas
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
{ $Log:  13188: URVAL1.pas 
{
{   Rev 1.1    2005-04-07 22:02:52  pb64
}
{
{   Rev 1.0    2003-03-20 14:04:04  peter
}
{
{   Rev 1.0    2003-03-17 14:39:48  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:10  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:10  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Urval1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, EQFormatEdit;

type
  TFrmUrval1 = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    EQFormatEdit1: TEQFormatEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUrval1: TFrmUrval1;

implementation

uses FaktUts, eqprn;

{$R *.DFM}

procedure TFrmUrval1.BitBtn1Click(Sender: TObject);
var
   i : Integer;

begin
   i := KrediteraFaktura(StrToInt(EQFormatEdit1.Text));
   if i>0 then
      PrintKvitto(0,0,i,1,False);
end;

end.

