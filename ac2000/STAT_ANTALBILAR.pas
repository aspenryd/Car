{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat_AntalBilar.pas
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
{ $Log:  13020: STAT_ANTALBILAR.pas 
{
{   Rev 1.0    2003-03-20 13:58:58  peter
}
{
{   Rev 1.0    2003-03-17 14:39:48  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:08  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:08  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Stat_AntalBilar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFrmStatAntBil = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStatAntBil: TFrmStatAntBil;

implementation

uses Dmod;

{$R *.DFM}

procedure TFrmStatAntBil.SpeedButton1Click(Sender: TObject);
 Var
  i:Integer;
begin
i:=0;
  dmod.Dmod2.QAntBil.Active :=False;
  dmod.Dmod2.QAntBil.Active :=True;
    dmod.Dmod2.QAntBil.first;
    while not dmod.Dmod2.QAntBil.eof do
    Begin
     Inc(i);
       dmod.Dmod2.QAntBil.next;
    end;
   edit1.text:=Inttostr(i); 
end;

end.

