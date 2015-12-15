{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13491: ACar2004.dpr
{
{   Rev 1.3    2004-01-30 14:44:18  peter
{ Fixat journal + kontering + + + +
}
{
{   Rev 1.2    2004-01-29 10:31:40  peter
}
{
{   Rev 1.1    2004-01-29 10:24:20  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:24:06  peter
{ 2004-01-28 : Start av version 2004
}


program ACar2004;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Dmod in 'Dmod.pas' {Dmod2: TDataModule},
  FormReg in 'FormReg.pas' {FrmReg},
  Login in 'Login.pas' {frmLogin},
  DmSession in 'DmSession.pas' {Dmod1: TDataModule},
  Statiska in 'Statiska.pas' {FrmStatiska},
  About in '..\Shared_2004\About.pas' {frmAbout},
  Bearb in 'Bearb.pas' {Form2},
  FaktUts in 'FaktUts.pas' {FrmFaktUts},
  Splash in 'Splash.pas' {SplashForm},
  Utskrift in 'Utskrift.pas' {FrmUtskr},
  FrmSql in 'FrmSql.pas' {FormSql},
  DBCMain in '..\Gate\Dbcmain.pas' {frmGate},
  GPaths in '..\Gate\Gpaths.pas' {frmPath},
  PrintDialog in '..\Shared_2004\PrintDialog.pas' {frmPrintDialog},
  Urval1 in '..\Shared_2004\Urval1.pas' {FrmUrval1},
  Urval2 in '..\Shared_2004\Urval2.pas' {FrmUrval2},
  UrvalStr in '..\Shared_2004\UrvalStr.pas' {FrmUrvalStr},
  eqprn in '..\Shared_2004\eqprn.pas',
  tmpData in '..\Shared_2004\Tmpdata.pas',
  Utskrifter in '..\car2004\UTSKRIFTER.pas' {FrmUtskrift},
  func in '..\Shared_2004\func.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'ACAR.HLP';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDmod1, Dmod1);
  Application.CreateForm(TfrmGate, frmGate);
  Application.CreateForm(TfrmPath, frmPath);
  Application.CreateForm(TFrmUtskrift, FrmUtskrift);
  repeat
    frmMain.ndraDatabas1Click(nil);
    if frmMain.Quit then
    begin
      DMod1.Free;
      frmMain.Free;
      frmgate.Free;
      frmPath.Free;
      Exit;
    end;
  until frmMain.DBExcists;
  frmMain.ReadIni;

  Application.CreateForm(TDmod2, Dmod2);
  Application.Run;
end.

