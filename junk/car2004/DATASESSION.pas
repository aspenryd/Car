{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     DataSession.pas
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
{ $Log:  13540: DATASESSION.pas
{
{   Rev 1.1    2004-01-29 10:26:40  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:38  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:00:24  peter
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
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit DataSession;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB;

type
  TDmSession = class(TDataModule)
    ADOConnection1: TADOConnection;
    SDb: TADOConnection;
    SDbAnswerT: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmSession: TDmSession;




implementation

{$R *.DFM}

end.

