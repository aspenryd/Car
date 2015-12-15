{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\QObjTyper.pas
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
{ $Log:  13031: QOBJTYPER.pas 
{
{   Rev 1.0    2003-03-20 13:59:34  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
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
unit QObjTyper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls;

type
  TFrmQObjTyp = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRlabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRFd: TQRLabel;
    QRTd: TQRLabel;
    QRobjtyp: TQRLabel;
    QrAntalRet: TQRLabel;
    QrTotInt: TQRLabel;
    QRUtnGrad: TQRLabel;
    QObjD: TQRLabel;
    QLAntObj: TQRLabel;
    QRUtn: TQRLabel;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQObjTyp: TFrmQObjTyp;

implementation

uses Statistik, Bearb, Dmod;

{$R *.DFM}

end.

