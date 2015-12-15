{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\UObjStat.pas
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
{ $Log:  13037: UOBJSTAT.pas 
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
{   Rev 1.0    2003-03-17 14:28:10  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit UObjStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls;

type
  TfrmUObjStat = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRRegNr: TQRLabel;
    QrFD: TQRLabel;
    QrTd: TQRLabel;
    QrAntalRet: TQRLabel;
    QrTotInt: TQRLabel;
    QRUtnGrad: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRLabel6: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUObjStat: TfrmUObjStat;

implementation

{$R *.DFM}

end.


