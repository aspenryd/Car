{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Bokning\Legend.pas
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
{ $Log:  14858: LEGEND.pas 
{
{   Rev 1.0    2004-08-18 11:00:58  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.1    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.0    2003-03-20 14:00:26  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:26:20  Supervisor
{ Start av vc
}
unit legend;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TdlgLegend = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Panel5: TPanel;
    Label6: TLabel;
    Panel6: TPanel;
    ColorDialog1: TColorDialog;
    Panel7: TPanel;
    Label7: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgLegend: TdlgLegend;

implementation

uses Main, bgmain;

{$R *.DFM}

procedure TdlgLegend.FormActivate(Sender: TObject);
begin
  Panel1.color := clBooking;
  Panel4.color := clLateBooking;
  Panel3.color := clContract;
  Panel5.color := clLateReturn;
  Panel2.color := clReturned;
  Panel6.color := clHistoric;
  Panel7.color := clOther;
end;

procedure TdlgLegend.Panel1DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    case (Sender as TPanel).tag of
      0: clBooking := ColorDialog1.color;
      1: clLateBooking := ColorDialog1.color;
      2: clContract := ColorDialog1.color;
      3: clLateReturn := ColorDialog1.color;
      4: clReturned := ColorDialog1.color;
      5: clHistoric := ColorDialog1.color;
      6: clOther := ColorDialog1.color;
    end;
    FormActivate(nil);
    frmBokgraf.UpdateDummyGrid;
  end;
end;

end.

