{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     ..\Gate\Gpaths.pas
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
{ $Log:  13136: GPATHS.pas
{
{   Rev 1.2    2006-02-18 13:33:20  pb64
}
{
{   Rev 1.1    2004-01-29 10:24:26  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2003-03-20 14:02:28  peter
}
{
{   Rev 1.0    2003-03-17 14:41:46  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:36:00  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.1    2003-03-17 09:36:06  Supervisor
{ Stora förändringar
}
{
{   Rev 1.0    2003-03-17 09:26:22  Supervisor
{ Start av vc
}
unit GPaths;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Adodb;

type
  TfrmPath = class(TForm)
    Label1: TLabel;

    Edit1: TEdit;
    BitBtn1: TBitBtn;

    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPath: TfrmPath;
  DBI: Integer;

implementation

{$R *.DFM}

procedure TfrmPath.Button1Click(Sender: TObject);
var
  s: String;
begin
  s := Edit1.Text;
  s := PromptDataSource(handle,s);
  if s>'' then
    Edit1.Text := s;
end;

end.

