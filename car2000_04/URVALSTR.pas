{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     UrvalStr.pas
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
{ $Log:  14888: URVALSTR.pas 
{
{   Rev 1.0    2004-08-18 11:01:08  pb64
{ Start inför införande av kontraktsfakturering.
{ 
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
unit UrvalStr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFrmUrvalStr = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUrvalStr: TFrmUrvalStr;

implementation

{$R *.DFM}

procedure TFrmUrvalStr.FormActivate(Sender: TObject);
begin
  edit1.Text :='';
  edit1.SetFocus;
end;

end.

