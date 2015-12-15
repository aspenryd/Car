{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13024: ACar2000.dpr
{
{   Rev 1.4    2006-02-18 13:33:16  pb64
}
{
{   Rev 1.3    2005-02-07 13:15:42  pb64
}
{
{   Rev 1.2    2004-01-28 14:40:18  peter
}
{
{   Rev 1.1    2003-08-04 11:58:46  Supervisor
}
{
{   Rev 1.0    2003-03-20 13:58:58  peter
}
{
{   Rev 1.0    2003-03-17 14:39:42  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:04  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:04  Supervisor
{ Bytt ut LMD och BFC Combo
}
program ACar2000;

uses
  ExceptionLog,
  Forms,
  Main in 'Main.pas' {frmMain},
  Dmod in 'Dmod.pas' {Dmod2: TDataModule},
  FormReg in 'FormReg.pas' {FrmReg},
  Login in 'Login.pas' {frmLogin},
  DmSession in 'DMSESSION.pas' {Dmod1: TDataModule},
  Statiska in 'Statiska.pas' {FrmStatiska},
  About in '..\Shared\About.pas' {frmAbout},
  Bearb in 'Bearb.pas' {Form2},
  FaktUts in 'FaktUts.pas' {FrmFaktUts},
  Splash in 'Splash.pas' {SplashForm},
  Utskrift in 'Utskrift.pas' {FrmUtskr},
  FrmSql in 'FrmSql.pas' {FormSql},
  Statistik in 'Stat\Statistik.pas' {FrmStat},
  DBCMain in '..\Gate\Dbcmain.pas' {frmGate},
  GPaths in '..\Gate\Gpaths.pas' {frmPath},
  PrintDialog in '..\Shared\PrintDialog.pas' {frmPrintDialog},
  Urval1 in '..\Shared\Urval1.pas' {FrmUrval1},
  Urval2 in '..\Shared\Urval2.pas' {FrmUrval2},
  UrvalStr in '..\Shared\UrvalStr.pas' {FrmUrvalStr},
  eqprn in '..\Shared\eqprn.pas',
  tmpData in '..\Shared\Tmpdata.pas',
  SWSecFunc in '..\reg\SWSecFunc.pas',
  Utskrifter in '..\Shared\UTSKRIFTER.pas' {FrmUtskrift},
  dlgStationChange in 'dlgStationChange.pas' {StationChangeDlg},
  DateUtil in '..\Shared\DateUtil.pas',
  EDIFactClasses in '..\EDIFact\EDIFactClasses.pas',
  EDIFactUtils in '..\EDIFact\EDIFactUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'ACAR.HLP';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDmod1, Dmod1);
  Application.CreateForm(TfrmGate, frmGate);
  Application.CreateForm(TfrmPath, frmPath);
  Application.CreateForm(TStationChangeDlg, StationChangeDlg);
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

