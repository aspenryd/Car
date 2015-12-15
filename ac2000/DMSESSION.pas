{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     DmSession.pas
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
{ $Log:  13004: DMSESSION.pas 
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:06  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:06  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit DmSession;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB;

type
  TDmod1 = class(TDataModule)
    ADOConnection1: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dmod1: TDmod1;

implementation

{$R *.DFM}

end.


