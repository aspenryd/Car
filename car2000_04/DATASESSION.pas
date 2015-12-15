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
{ $Log:  14836: DATASESSION.pas 
{
{   Rev 1.0    2004-08-18 11:00:52  pb64
{ Start inför införande av kontraktsfakturering.
{ 
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


