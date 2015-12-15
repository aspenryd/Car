{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Urval1.pas
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
{ $Log:  13100: URVAL1.pas 
{
{   Rev 1.0    2003-03-20 14:00:30  peter
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
unit Urval1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls;

type
  TFrmUrval1 = class(TForm)
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUrval1: TFrmUrval1;

implementation

{$R *.DFM}

procedure TFrmUrval1.FormActivate(Sender: TObject);
begin
  DateTimePicker1.Date :=Now;
end;

end.

