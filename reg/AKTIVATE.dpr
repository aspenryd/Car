{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12992: AKTIVATE.dpr 
{
{   Rev 1.0    2003-03-20 13:55:36  peter
}
{
{   Rev 1.0    2003-03-17 09:26:24  Supervisor
{ Start av vc
}
program Aktivate;

uses
  ExceptionLog,
  Forms,
  Aktiv in 'Aktiv.pas' {AktForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TAktForm, AktForm);
  Application.Run;
end.
