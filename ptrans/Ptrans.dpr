{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14780: Ptrans.dpr 
{
{   Rev 1.0    2004-07-02 08:50:54  pb64
}
{
{   Rev 1.0    2003-03-20 14:01:50  peter
}
{
{   Rev 1.0    2003-03-17 09:26:20  Supervisor
{ Start av vc
}
program PTrans;

uses
  Forms,
  SysUtils,
  dialogs,
  Main in 'Main.pas' {frmMain},
  Adeko in 'Adeko.pas',
  DBFuncs in 'DBFuncs.pas',
  DBCMain in '..\Gate\Dbcmain.pas' {frmGate},
  GPaths in '..\Gate\Gpaths.pas' {frmPath},
  inloggning in 'inloggning.pas' {FrmInloggning},
  FormVal in 'FormVal.pas' {FrmVal};

{$R *.RES}
var
  inistr : string;
begin
  Application.Initialize;
  Application.HelpFile := 'car.hlp';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFrmVal, FrmVal);
  if not DbExists then
  Begin
   frmMain.Free;
   exit;
  End;
  Application.Run;
end.
