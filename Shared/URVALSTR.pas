{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     ..\Shared\UrvalStr.pas
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
{ $Log:  13192: URVALSTR.pas 
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
unit UrvalStr;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, EQPrn;

type
  TFrmUrvalStr = class(TForm)
    Notebook1: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    btnPrint: TButton;
    btnPrinter: TButton;
    btnCancel: TButton;
    cbPreview: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
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

procedure TFrmUrvalStr.btnPrintClick(Sender: TObject);
begin
{  rpt := rptDirectory + (Sender as TMenuItem).hint;
  if Length(str) <> 0 then
     eqprn.PrintOutReport(rpt, str, 1, cb)  }
end;

end.

