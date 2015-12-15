{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Urval2.pas
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
{ $Log:  13592: URVAL2.pas
{
{   Rev 1.1    2004-01-29 10:26:44  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:54  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:00:30  peter
}
{
{   Rev 1.0    2003-03-17 14:41:48  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:36:02  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:30  Supervisor
{ Start av vc
}
unit Urval2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons;

type
  TFrmUrval2 = class(TForm)
    BitBtn1: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUrval2: TFrmUrval2;

implementation

{$R *.DFM}

procedure TFrmUrval2.FormActivate(Sender: TObject);
begin
  DateTimePicker1.Date := Now - 3;
  DateTimePicker2.date := Now;
end;

end.

