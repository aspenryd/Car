{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Dmod.pas
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
{ $Log:  13495: Dmod.pas
{
{   Rev 1.1    2004-01-29 10:24:20  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:24:08  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.1    2003-08-04 11:58:46  Supervisor
}
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:04  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:06  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Dmod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB;

type
  TDmod2 = class(TDataModule)
    BetstT: TADOTable;
    CardsT: TADOTable;
    ReportsT: TADOTable;
    SignrT: TADOTable;
    PriceTabRowsT: TADOTable;
    PriceTabT: TADOTable;
    ParamT: TADOTable;
    ObjTypeT: TADOTable;
    DrivMT: TADOTable;
    CostsT: TADOTable;
    CompanyT: TADOTable;
    TtypT: TADOTable;
    BetstS: TDataSource;
    CardsS: TDataSource;
    TtypS: TDataSource;
    SignrS: TDataSource;
    ReportsS: TDataSource;
    PriceTabRowsS: TDataSource;
    PriceTabS: TDataSource;
    ParamS: TDataSource;
    ObjTypeS: TDataSource;
    DrivMS: TDataSource;
    CostsS: TDataSource;
    CompanyS: TDataSource;
    Contr_BaseT: TADOTable;
    Contr_SubT: TADOTable;
    Contr_ObjtT: TADOTable;
    Contr_BaseS: TDataSource;
    Contr_SubS: TDataSource;
    Contr_ObjS: TDataSource;
    Contr_SubCostT: TADOTable;
    q1: TADOQuery;
    D1: TDataSource;
    KonteringT: TADOTable;
    KonteringS: TDataSource;
    LoggTabellT: TADOTable;
    KnterRadT: TADOTable;
    LoggTabellTLoggId: TAutoIncField;
    LoggTabellTLoggNr: TIntegerField;
    LoggTabellTNrTyp: TIntegerField;
    LoggTabellTNummer: TIntegerField;
    LoggTabellTBokf_dag: TDateField;
    KonteringTCounter: TAutoIncField;
    KonteringTKonteringsid: TFloatField;
    KonteringTKonteringsnamn: TWideStringField;
    KonteringTKontonr: TFloatField;
    KonteringTKStalleStyrning: TFloatField;
    KonteringTInternKontoNr: TFloatField;
    CustomerT: TADOTable;
    Contr_SubCostRowT: TADOTable;
    Ekq1: TADOQuery;
    Report_DateT: TADOTable;
    Report_DateS: TDataSource;
    PriceTabRowsTPriceId: TIntegerField;
    PriceTabRowsTRowNum: TIntegerField;
    PriceTabRowsTMINDAG: TSmallintField;
    PriceTabRowsTPRISDAG: TSmallintField;
    PriceTabRowsTKOST: TBCDField;
    PriceTabRowsTINKL_KM: TSmallintField;
    PriceTabRowsTOVERKM: TFloatField;
    PriceTabRowsTXDYGN: TSmallintField;
    PriceTabRowsTXINKLKM: TFloatField;
    KnterRadTCounter: TAutoIncField;
    KnterRadTNrTyp: TIntegerField;
    KnterRadTNummer: TFloatField;
    KnterRadTKonto: TFloatField;
    KnterRadTKStalle: TFloatField;
    KnterRadTDebet: TFloatField;
    KnterRadTKredit: TFloatField;
    QKont: TADOQuery;
    QAntBil: TADOQuery;
    KonteringTKoncernKontoNr: TFloatField;
    Q2: TADOQuery;
    CustomerS: TDataSource;
    ObjectT: TADOTable;
    ObjectS: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure CompanySStateChange(Sender: TObject);
    procedure CostsSStateChange(Sender: TObject);
    procedure ObjTypeSStateChange(Sender: TObject);
    procedure ParamSStateChange(Sender: TObject);
    procedure PriceTabSStateChange(Sender: TObject);
    procedure KonteringSStateChange(Sender: TObject);
    procedure ReportsSStateChange(Sender: TObject);
    procedure SignrSStateChange(Sender: TObject);
    procedure BetstSStateChange(Sender: TObject);
    procedure DrivMSStateChange(Sender: TObject);
    procedure CardsSStateChange(Sender: TObject);
    procedure TtypSStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dmod2: TDmod2;

implementation

uses DmSession, Main;

{$R *.DFM}

procedure TDmod2.DataModuleCreate(Sender: TObject);
var i: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TAdoTable then
      (Components[I] as TAdoTable).open;
end;

procedure TDmod2.CompanySStateChange(Sender: TObject);
begin
  if CompanyS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.CostsSStateChange(Sender: TObject);
begin
  if CostsS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.ObjTypeSStateChange(Sender: TObject);
begin
  if ObjTypeS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.ParamSStateChange(Sender: TObject);
begin
  if ParamS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.PriceTabSStateChange(Sender: TObject);
begin
  if PriceTabS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.KonteringSStateChange(Sender: TObject);
begin
  if KonteringS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.ReportsSStateChange(Sender: TObject);
begin
  if ReportsS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.SignrSStateChange(Sender: TObject);
begin
  if SignrS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.BetstSStateChange(Sender: TObject);
begin
  if BetstS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.DrivMSStateChange(Sender: TObject);
begin
  if DrivMS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.CardsSStateChange(Sender: TObject);
begin
  if CardsS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

procedure TDmod2.TtypSStateChange(Sender: TObject);
begin
  if TtypS.state in [dsedit, dsinsert] then
  begin
    frmMain.BtnCan.Enabled := True;
    frmMain.btnsave.Enabled := True;
  end
  else
  begin
    frmMain.BtnCan.Enabled := False;
    frmMain.BtnSave.enabled := False;
  end;
end;

end.

