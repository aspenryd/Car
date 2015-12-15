{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13112: C2.dpr
{
{   Rev 1.4    2004-08-10 10:45:34  pb64
}
{
{   Rev 1.3    2004-01-27 12:19:44  peter
}
{
{   Rev 1.2    2003-12-30 16:21:58  hasp
}
{
{   Rev 1.1    2003-12-29 00:44:02  hasp
}
{
{   Rev 1.0    2003-03-20 14:00:32  peter
}
{
{   Rev 1.0    2003-03-17 14:41:40  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:54  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:20  Supervisor
{ Start av vc
}
program C2;

uses
  Forms,
  Sysutils,
  SWSec in '..\reg\SWSec.pas',
  Main in 'Main.pas' {frmMain},
  About in '..\Shared\About.pas' {frmAbout},
  Splash in 'Splash.pas' {SplashForm},
  Kontrakt in 'Kontrakt.pas' {FrmKontrakt},
  Search in 'Search.pas' {frmSearch},
  Login in 'Login.pas' {frmLogin},
  Tmpdata in '..\Shared\Tmpdata.pas',
  Data2 in 'Data2.pas' {TCARSearch: TRemoteDataModule},
  Bgmain in 'Bgmain.pas' {frmBokgraf},
  Legend in 'Legend.pas' {dlgLegend},
  Pris in 'Pris.pas' {frmPris},
  Funcs in 'Funcs.pas',
  History in 'History.pas' {frmHistory},
  Delbet in 'Delbet.pas' {dlgDelbetalare},
  Bilbyte in 'Bilbyte.pas' {frmBilByte},
  Deposit in 'Deposit.pas' {dlgDeposit},
  Hints in 'Hints.pas',
  Greg in 'Greg.pas' {frmGReg},
  Reconcil in 'Reconcil.pas' {ReconcileErrorForm},
  Vclfuncs in 'Vclfuncs.pas',
  BgrafChanges in 'BgrafChanges.pas' {FrmGrid},
  Obcost in 'Obcost.pas' {frmObCost},
  Obdat in 'Obdat.pas' {frmObdat},
  DataSession in 'DATASESSION.pas' {DmSession: TDataModule},
  TimerDlg in 'TimerDlg.pas' {DlgTimer},
  GPaths in '..\Gate\Gpaths.pas' {frmPath},
  DBCMain in '..\Gate\Dbcmain.pas' {frmGate},
  Utskrifter in 'Utskrifter.pas' {FrmUtskrift},
  spin in 'Spin.pas',
  UtskriftsDialog in 'UtskriftsDialog.pas' {FrmUtsDg},
  Dlg_Hyresman in 'Dlg_Hyresman.pas' {FrmDg_Hyresman},
  Dlg_ObjService in 'Dlg_ObjService.pas' {FrmDg_ObjService},
  Not_Registred in 'Not_Registred.pas' {FrmNotReg},
  Urval1 in 'Urval1.pas' {FrmUrval1},
  UrvalStr in 'UrvalStr.pas' {FrmUrvalStr},
  Urval2 in 'Urval2.pas' {FrmUrval2},
  PrintDialog in '..\Shared\PrintDialog.pas' {frmPrintDialog},
  eqprn in '..\Shared\eqprn.pas',
  BetVilk in 'BetVilk.pas' {dlgBetVillkor},
  Datamodule in '..\Shared\Datamodule.pas' {Dmod: TDataModule},
  divutils in '..\Shared\divutils.pas';

{$R *.RES}

begin
  if not CheckREG(funcs.RegName, 'Software\MM\C2', true) then
    exit;
  Application.Initialize;
  Application.Title := 'Car2000';
  Application.HelpFile := 'Car.Hlp';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmGate, frmGate);
  Application.CreateForm(TdlgBetVillkor, dlgBetVillkor);
  Splashform := Tsplashform.create(Application);
  Application.CreateForm(TDmSession, DmSession);
  dmsession.ADOConnection1.close;
  dmsession.ADOConnection1.LoginPrompt := False;
  frmMain.dbexists := false;

  repeat
    begin
      frmMain.ndraDatabas1Click(nil);
      Splashform.show;
      Splashform.Update;
      if frmMain.quit then
      begin
        frmMain.Free;
        DmSession.Free;
        Exit;
      end;

  end until frmMain.dbexists;
  frmMain.ReadINIFile;
  Application.CreateForm(TfrmSearch, frmSearch);
  Application.CreateForm(TDmod, Dmod);
  Application.CreateForm(TfrmGReg, frmGReg);
  Application.CreateForm(TTCARSearch, TCARSearch);
  Application.CreateForm(TfrmHistory, frmHistory);
  Application.CreateForm(TFrmGrid, FrmGrid);
//!  Splashform.Close;
  Application.Run;

end.

