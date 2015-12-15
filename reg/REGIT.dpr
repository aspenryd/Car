{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12985: REGIT.dpr 
{
{   Rev 1.1    2005-02-07 12:24:22  pb64    Version: 2004.0.1
{ NY LICENS METOD
}
{
{   Rev 1.0    2003-03-20 13:53:48  peter
}
{
{   Rev 1.0    2003-03-19 20:49:38  peter
{ test
}
{
{   Rev 1.0    2003-03-17 09:26:24  Supervisor
{ Start av vc
}
program RegIt;

uses
  ExceptionLog,
  Forms,
  Reg in 'REG.pas' {RegForm},
  SWSecFunc in 'SWSecFunc.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TRegForm, RegForm);
  Application.Run;
end.
