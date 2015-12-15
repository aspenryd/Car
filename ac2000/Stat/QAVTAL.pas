{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\QAvtal.pas
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
{ $Log:  13027: QAVTAL.pas 
{
{   Rev 1.0    2003-03-20 13:59:32  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
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
unit QAvtal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, QuickRpt, Qrctrls;

type
  TFrmQAvtal = class(TForm)
    QuickRep1: TQuickRep;
    QRSubDetail1: TQRSubDetail;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQAvtal: TFrmQAvtal;

implementation


{$R *.DFM}

end.

