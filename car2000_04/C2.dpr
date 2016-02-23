{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14896: C2.dpr 
{
{   Rev 1.5    2006-02-18 13:33:42  pb64
}
{
{   Rev 1.4    2005-02-14 16:16:56  pb64
{ infört visning av debuginfo
}
{
{   Rev 1.3    2005-02-08 22:20:54  pb64    Version: 2005.01
{ Ändrat version nummer
}
{
{   Rev 1.2    2005-02-07 11:24:58  pb64
{ Rutiner för att hantera den nya licensiering som sparas i databasen.
}
{
{   Rev 1.1    2004-10-26 15:47:48  pb64
}
{
{   Rev 1.0    2004-08-18 11:01:10  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
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
  SWSecFunc in '..\reg\SWSecFunc.pas',
  Main in 'Main.pas' {frmMain},
  About in '..\Shared\About.pas' {frmAbout},
  Splash in 'Splash.pas' {SplashForm},
  Kontrakt in 'Kontrakt.pas' {FrmKontrakt},
  Search in 'Search.pas' {frmSearch},
  Login in 'LOGIN.pas' {frmLogin},
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
  BgrafChanges in 'BGRAFCHANGES.pas' {FrmGrid},
  Obcost in 'Obcost.pas' {frmObCost},
  Obdat in 'Obdat.pas' {frmObdat},
  DataSession in 'DATASESSION.pas' {DmSession: TDataModule},
  TimerDlg in 'TimerDlg.pas' {DlgTimer},
  GPaths in '..\Gate\Gpaths.pas' {frmPath},
  DBCMain in '..\Gate\Dbcmain.pas' {frmGate},
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
  uCarLegal in 'uCarLegal.pas' {frmCarlegal},
  Utskrifter in '..\Shared\UTSKRIFTER.pas' {FrmUtskrift},
  dlgStationChange in 'dlgStationChange.pas' {StationChangeDlg},
  edifact in '..\Shared\edifact.pas',
  DateUtil in '..\Shared\DateUtil.pas';

{$R *.RES}


begin
  if lowercase(ParamStr(1))='debug' then
    DebugLevel := 0
  else
    DebugLevel := -1;
  DebugInfo('*** Start av car2004 ***',True);
  Application.Initialize;
  Application.Title := 'Car2000';
  Application.HelpFile := 'Car.Hlp';
  DebugInfo('*** CreateForm(TfrmMain, frmMain) ***');
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFrmUtskrift, FrmUtskrift);
  Application.CreateForm(TStationChangeDlg, StationChangeDlg);
  //  Application.CreateForm(TfrmCarlegal, frmCarlegal);
  DebugInfo('*** CreateForm(TfrmGate, frmGate) ***');
  Application.CreateForm(TfrmGate, frmGate);
  DebugInfo('*** CreateForm(TdlgBetVillkor, dlgBetVillkor) ***');
  Application.CreateForm(TdlgBetVillkor, dlgBetVillkor);
  DebugInfo('*** Tsplashform.create(Application) ***');
  Splashform := Tsplashform.create(Application);
  DebugInfo('*** CreateForm(TDmSession, DmSession) ***');
  Application.CreateForm(TDmSession, DmSession);
  DebugInfo('*** ADOConnection1.close ***');
  dmsession.ADOConnection1.close;
  dmsession.ADOConnection1.LoginPrompt := False;
  frmMain.dbexists := false;

  repeat
    begin
  DebugInfo('*** frmMain.ndraDatabas1Click(nil) ***');
      frmMain.ndraDatabas1Click(nil);
  DebugInfo('*** Splashform.show ***');
      Splashform.show;
  DebugInfo('*** Splashform.Update ***');
      Splashform.Update;
  DebugInfo('*** frmMain.quit ***');
      if frmMain.quit then
      begin
        frmMain.Free;
        DmSession.Free;
        Exit;
      end;

  end until frmMain.dbexists;

  DebugInfo('*** CheckREG ***');
  if not CheckREG(funcs.RegName, 'Software\MM\C2') then
    exit;
  DebugInfo('*** ReadINIFile ***');
  frmMain.ReadINIFile;
  DebugInfo('*** CreateForm(TfrmSearch, frmSearch) ***');
  Application.CreateForm(TfrmSearch, frmSearch);
  DebugInfo('*** CreateForm(TDmod, Dmod) ***');
  Application.CreateForm(TDmod, Dmod);
  DebugInfo('*** CreateForm(TfrmGReg, frmGReg) ***');
  Application.CreateForm(TfrmGReg, frmGReg);
  DebugInfo('*** CreateForm(TTCARSearch, TCARSearch) ***');
  Application.CreateForm(TTCARSearch, TCARSearch);
  DebugInfo('*** CreateForm(TfrmHistory, frmHistory) ***');
  Application.CreateForm(TfrmHistory, frmHistory);
  DebugInfo('*** CreateForm(TFrmGrid, FrmGrid) ***');
  Application.CreateForm(TFrmGrid, FrmGrid);
  DebugInfo('*** Application.Run ***');
//!  Splashform.Close;
  Application.Run;

end.

