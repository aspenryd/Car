{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\QkundStat.pas
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
{ $Log:  13029: QKUNDSTAT.pas 
{
{   Rev 1.0    2003-03-20 13:59:34  peter
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
unit QkundStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls;

type
  TFrmQKundStat = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QrFd: TQRLabel;
    QrTd: TQRLabel;
    QrNamn: TQRLabel;
    QrAddr: TQRLabel;
    QrPAddr: TQRLabel;
    QrLand: TQRLabel;
    QrOrgNr: TQRLabel;
    QrTele: TQRLabel;
    QrHyror: TQRLabel;
    QrTot: TQRLabel;
    QrSnitt: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQKundStat: TFrmQKundStat;

implementation

{$R *.DFM}

end.

