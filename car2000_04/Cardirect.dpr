{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14898: Cardirect.dpr 
{
{   Rev 1.1    2005-02-07 15:18:12  pb64
}
{
{   Rev 1.0    2004-08-18 11:01:10  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
program Cardirect;

uses
  Forms,
  uRfid in 'uRfid.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
