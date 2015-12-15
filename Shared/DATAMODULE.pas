{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Datamodule.pas
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
{ $Log:  13180: DATAMODULE.pas 
{
{   Rev 1.2    2003-12-29 16:32:02  peter
}
{
{   Rev 1.1    2003-12-29 15:42:50  hasp
}
{
{   Rev 1.0    2003-03-20 14:04:04  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit Datamodule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB;

type
  TADODBLogWriter = class
  private
    Fconnection : TADOConnection;
    FMaxRows: integer;
    FTimeStampRows: boolean;
    FTableName: string;
    procedure SetTimeStampRows(const Value: boolean);
    procedure SetTableName(const Value: string);
  public
    procedure WriteToLog(msg : string);
    property TimeStampRows : boolean read FTimeStampRows write SetTimeStampRows;
    property TableName : string read FTableName write SetTableName;
    constructor Create(connection : TADOConnection);
  end;


  TDmod = class(TDataModule)
    BetstT: TADOTable;
    Contr_BaseT: TADOTable;
    CompanyT: TADOTable;
    Contr_InsurT: TADOTable;
    Contr_HistT: TADOTable;
    Contr_EconT: TADOTable;
    Contr_costsT: TADOTable;
    Contr_NotT: TADOTable;
    Contr_ObjTT: TADOTable;
    Contr_ObjXT: TADOTable;
    Contr_SubT: TADOTable;
    Contr_SubCostRowT: TADOTable;
    Contr_SubNotT: TADOTable;
    ObjDateT: TADOTable;
    ObjCostT: TADOTable;
    Contr_SubCostT: TADOTable;
    OrtrgT: TADOTable;
    ParamT: TADOTable;
    ReportsT: TADOTable;
    ObjCostS: TDataSource;
    ObjDateS: TDataSource;
    LanguageT: TADOTable;
    BetstTCounter: TAutoIncField;
    BetstTKod: TWideStringField;
    BetstTNamn: TWideStringField;
    BetstTBTyp: TSmallintField;
    BetstTKonto: TFloatField;
    CompanyTDate: TWideStringField;
    CompanyTCompany: TWideStringField;
    CompanyTDep: TWideStringField;
    CompanyTAdr: TWideStringField;
    CompanyTPoAdr: TWideStringField;
    CompanyTCountry: TWideStringField;
    CompanyTDelAdr1: TWideStringField;
    CompanyTDelAdr2: TWideStringField;
    CompanyTVisAdr1: TWideStringField;
    CompanyTVisAdr2: TWideStringField;
    CompanyTT_Country: TWideStringField;
    CompanyTT_Area: TWideStringField;
    CompanyTT_No: TWideStringField;
    CompanyTTelex: TWideStringField;
    CompanyTFax_Country: TWideStringField;
    CompanyTFax_Area: TWideStringField;
    CompanyTFax_No: TWideStringField;
    CompanyTBANKGIRO: TWideStringField;
    CompanyTPOSTGIRO: TWideStringField;
    CompanyTORG_NR: TWideStringField;
    CompanyTMOMS_NR: TWideStringField;
    CompanyTSIGN: TWideStringField;
    CompanyTID_KOLL: TWideStringField;
    CompanyTYEAR: TFloatField;
    CompanyTMANAD_BEN: TWideStringField;
    CompanyTMANAD: TFloatField;
    CompanyTVECKODAG: TWideStringField;
    CompanyTVECKA: TFloatField;
    CompanyTSISVECKA: TWideStringField;
    CompanyTFELLOGG: TWideStringField;
    CompanyTPAUS: TWideStringField;
    Contr_BaseTContrId: TIntegerField;
    Contr_BaseTCustID: TIntegerField;
    Contr_BaseTContr_Date: TDateField;
    Contr_BaseTPrint_Date: TDateField;
    Contr_BaseTSign: TWideStringField;
    Contr_BaseTReferens: TWideStringField;
    Contr_BaseTStatus: TWordField;
    Contr_BaseTPayment: TWideStringField;
    Contr_BaseTPayfact: TSmallintField;
    Contr_BaseTDriveId: TIntegerField;
    Contr_BaseTSRiskreduc: TBooleanField;
    Contr_BaseTSR_Dygnspremie: TFloatField;
    Contr_BaseTDeposit: TBooleanField;
    Contr_BaseTDep_Amount: TFloatField;
    Contr_costsTCost_ID: TAutoIncField;
    Contr_costsTContrID: TIntegerField;
    Contr_costsTCostname: TWideStringField;
    Contr_costsTNo: TFloatField;
    Contr_costsTPrice: TBCDField;
    Contr_costsTVAT: TFloatField;
    Contr_costsTAcc_code: TIntegerField;
    Contr_costsTAcc_center: TIntegerField;
    Contr_EconTContrId: TIntegerField;
    Contr_EconTCust_ObjType: TSmallintField;
    Contr_EconTContoTyp: TWideStringField;
    Contr_EconTContoNr: TWideStringField;
    Contr_InsurTSubId: TIntegerField;
    Contr_InsurTICode: TWideStringField;
    Contr_InsurTIDate: TDateField;
    Contr_InsurTFREGNR: TWideStringField;
    Contr_InsurTIClass: TWideStringField;
    Contr_InsurTINumber: TWideStringField;
    Contr_InsurTMPREGNR: TWideStringField;
    Contr_NotTContrid: TIntegerField;
    Contr_NotTCnot1: TWideStringField;
    Contr_NotTCnot2: TWideStringField;
    Contr_NotTInot1: TWideStringField;
    Contr_NotTInot2: TWideStringField;
    Contr_ObjTTConObjID: TAutoIncField;
    Contr_ObjTTContrId: TIntegerField;
    Contr_ObjTTObTypId: TWideStringField;
    Contr_ObjTTOId: TWideStringField;
    Contr_ObjTTFrm_Time: TDateField;
    Contr_ObjTTTo_Time: TDateField;
    Contr_ObjTTOut_Time: TDateField;
    Contr_ObjTTRet_Time: TDateField;
    Contr_ObjTTKM_Out: TIntegerField;
    Contr_ObjTTKM_In: TIntegerField;
    Contr_ObjTTKM_Ber: TIntegerField;
    Contr_ObjTTPClass: TWideStringField;
    Contr_ObjTTPType: TWideStringField;
    Contr_ObjTTStatus: TWordField;
    Contr_ObjTTCarryCar: TWideStringField;
    Contr_ObjTTInvNo: TIntegerField;
    Contr_ObjTTSRRed: TBooleanField;
    Contr_SubCostTSubId: TIntegerField;
    Contr_SubCostTDSUM: TBCDField;
    Contr_SubCostTDHYR: TBCDField;
    Contr_SubCostTDMOMS: TBCDField;
    Contr_SubCostTDTOTAL: TBCDField;
    Contr_SubCostTKONTOTYP: TWideStringField;
    Contr_SubCostTKONTONR: TWideStringField;
    Contr_SubCostTK_SPARRKOLL: TBooleanField;
    Contr_SubCostTK_SPARRNR: TWideStringField;
    Contr_SubCostRowTSubId: TIntegerField;
    Contr_SubCostRowTRownumb: TIntegerField;
    Contr_SubCostRowTRowtext: TWideStringField;
    Contr_SubCostRowTValue: TBCDField;
    Contr_SubCostRowTPercent: TFloatField;
    Contr_SubCostRowTByValue: TBooleanField;
    Contr_SubNotTSubID: TIntegerField;
    Contr_SubNotTKid: TIntegerField;
    Contr_SubNotTFaktAtt: TWideStringField;
    Contr_SubNotTFaktNot1: TWideStringField;
    Contr_SubNotTFaktNot2: TWideStringField;
    ObjCostTCostID: TAutoIncField;
    ObjCostTReg_No: TWideStringField;
    ObjCostTCostDat: TDateField;
    ObjCostTMeasure: TWideStringField;
    ObjCostTCost: TBCDField;
    ObjCostTVat: TBCDField;
    ObjCostTSign: TWideStringField;
    ObjCostTNotDate: TDateField;
    ObjCostTTotal: TWideStringField;
    ObjDateTObjdateId: TAutoIncField;
    ObjDateTReg_No: TWideStringField;
    ObjDateTObjtyp: TWideStringField;
    ObjDateTTransDate: TDateField;
    ObjDateTTransInOut: TBooleanField;
    ObjDateTWhere: TWideStringField;
    ObjDateTTransCode: TWideStringField;
    ObjDateTSign: TWideStringField;
    ObjDateTNotDate: TDateField;
    OrtrgTPNR: TWideStringField;
    OrtrgTORT: TWideStringField;
    OrtrgTRIKT: TWideStringField;
    ADOQuery1: TADOQuery;
    Q1: TADOQuery;
    Q2: TADOQuery;
    Q3: TADOQuery;
    Q4: TADOQuery;
    Q5: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    ADODBLogWriter : TADODBLogWriter;
    { Public declarations }
  end;

var
  Dmod: TDmod;

implementation

uses DataSession, Pris, Main;

{$R *.DFM}

procedure TDmod.DataModuleCreate(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TAdoTable then
      (Components[I] as TAdoTable).open;
//! För att Styra Utskrifter med Urval
  ReportsT.Close;
  try
    Begin
     q1.Active :=False;
     q1.SQL.Text :='Select rep_Field from Reports';
     q1.Active :=True;
    end;
  except
   Begin
    q1.Active :=False;
    q1.SQL.Text :='Alter Table Reports Add Rep_Field Char(50)';
    q1.ExecSQL;
    q1.Active :=False;
    q1.SQL.Text :='Alter Table Reports Add Rep_UTyp Char(4)';
    q1.ExecSQL;
   end;
  end;
  ReportsT.Open;
//! Hit
  ADODBLogWriter := TADODBLogWriter.create(DmSession.ADOConnection1);
end;

{ TADODBLogWriter }

constructor TADODBLogWriter.Create(connection: TADOConnection);
begin
  Fconnection := connection;
  FTimeStampRows := true;
  FTableName := 'ERRORLOGG';
end;

procedure TADODBLogWriter.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

procedure TADODBLogWriter.SetTimeStampRows(const Value: boolean);
begin
  FTimeStampRows := value;
end;

function GetLocalHostName: string;
var
  i: LongWord;
begin
  SetLength(Result, MAX_COMPUTERNAME_LENGTH + 1);
  i := Length(Result);
  if GetComputerName(@Result[1], i) then begin
    SetLength(Result, i);
  end;
end;


procedure TADODBLogWriter.WriteToLog(msg: string);
var
  q : TADOQuery;
  usr, computer : string;
begin
  q := CreateDS('SELECT * FROM '+fTablename+' WHERE 1=2');
  try
    usr := frmMain.sign;
    computer := GetLocalHostName;
    q.Open;
    q.Append;
    q.Fields[0].AsDateTime := Now;
    q.Fields[1].AsString := usr;
    q.Fields[2].AsString := computer;
    q.Fields[3].AsString := msg;
    q.Post;
  finally
    FreeDS(q);
  end;
end;

procedure TDmod.DataModuleDestroy(Sender: TObject);
begin
  ADODBLogWriter.free;
end;

end.

