{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13201: SpinR.dpr 
{
{   Rev 1.0    2003-03-20 14:04:56  peter
}
program SpinR;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  spin in 'SPIN.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
