object Dmod: TDmod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 243
  Top = 175
  Height = 480
  Width = 696
  object BetstT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    TableName = 'Betst'
    Left = 24
    Top = 16
    object BetstTCounter: TAutoIncField
      FieldName = 'Counter'
    end
    object BetstTKod: TWideStringField
      FieldName = 'Kod'
      Size = 1
    end
    object BetstTNamn: TWideStringField
      FieldName = 'Namn'
    end
    object BetstTBTyp: TSmallintField
      FieldName = 'BTyp'
    end
    object BetstTKonto: TFloatField
      FieldName = 'Konto'
    end
  end
  object Contr_BaseT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_Base'
    Left = 163
    Top = 16
    object Contr_BaseTContrId: TIntegerField
      FieldName = 'ContrId'
    end
    object Contr_BaseTCustID: TIntegerField
      FieldName = 'CustID'
    end
    object Contr_BaseTContr_Date: TDateField
      FieldName = 'Contr_Date'
    end
    object Contr_BaseTPrint_Date: TDateField
      FieldName = 'Print_Date'
    end
    object Contr_BaseTSign: TWideStringField
      FieldName = 'Sign'
      Size = 8
    end
    object Contr_BaseTReferens: TWideStringField
      FieldName = 'Referens'
      Size = 30
    end
    object Contr_BaseTStatus: TWordField
      FieldName = 'Status'
    end
    object Contr_BaseTPayment: TWideStringField
      FieldName = 'Payment'
      Size = 1
    end
    object Contr_BaseTPayfact: TSmallintField
      FieldName = 'Pay-fact'
    end
    object Contr_BaseTDriveId: TIntegerField
      FieldName = 'DriveId'
    end
    object Contr_BaseTSRiskreduc: TBooleanField
      FieldName = 'SRiskreduc'
    end
    object Contr_BaseTSR_Dygnspremie: TFloatField
      FieldName = 'SR_Dygnspremie'
    end
    object Contr_BaseTDeposit: TBooleanField
      FieldName = 'Deposit'
    end
    object Contr_BaseTDep_Amount: TFloatField
      FieldName = 'Dep_Amount'
    end
  end
  object CompanyT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    TableName = 'Company'
    Left = 98
    Top = 16
    object CompanyTDate: TWideStringField
      FieldName = 'Date'
      Size = 10
    end
    object CompanyTCompany: TWideStringField
      FieldName = 'Company'
      Size = 30
    end
    object CompanyTDep: TWideStringField
      FieldName = 'Dep'
      Size = 30
    end
    object CompanyTAdr: TWideStringField
      FieldName = 'Adr'
      Size = 30
    end
    object CompanyTPoAdr: TWideStringField
      FieldName = 'PoAdr'
      Size = 30
    end
    object CompanyTCountry: TWideStringField
      FieldName = 'Country'
      Size = 30
    end
    object CompanyTDelAdr1: TWideStringField
      FieldName = 'DelAdr1'
      Size = 30
    end
    object CompanyTDelAdr2: TWideStringField
      FieldName = 'DelAdr2'
      Size = 30
    end
    object CompanyTVisAdr1: TWideStringField
      FieldName = 'VisAdr1'
      Size = 30
    end
    object CompanyTVisAdr2: TWideStringField
      FieldName = 'VisAdr2'
      Size = 30
    end
    object CompanyTT_Country: TWideStringField
      FieldName = 'T_Country'
      Size = 5
    end
    object CompanyTT_Area: TWideStringField
      FieldName = 'T_Area'
      Size = 4
    end
    object CompanyTT_No: TWideStringField
      FieldName = 'T_No'
      Size = 8
    end
    object CompanyTTelex: TWideStringField
      FieldName = 'Telex'
      Size = 7
    end
    object CompanyTFax_Country: TWideStringField
      FieldName = 'Fax_Country'
      Size = 5
    end
    object CompanyTFax_Area: TWideStringField
      FieldName = 'Fax_Area'
      Size = 4
    end
    object CompanyTFax_No: TWideStringField
      FieldName = 'Fax_No'
      Size = 8
    end
    object CompanyTBANKGIRO: TWideStringField
      FieldName = 'BANKGIRO'
      Size = 10
    end
    object CompanyTPOSTGIRO: TWideStringField
      FieldName = 'POSTGIRO'
      Size = 10
    end
    object CompanyTORG_NR: TWideStringField
      FieldName = 'ORG_NR'
      Size = 18
    end
    object CompanyTMOMS_NR: TWideStringField
      FieldName = 'MOMS_NR'
      Size = 18
    end
    object CompanyTSIGN: TWideStringField
      FieldName = 'SIGN'
      Size = 6
    end
    object CompanyTID_KOLL: TWideStringField
      FieldName = 'ID_KOLL'
      Size = 4
    end
    object CompanyTYEAR: TFloatField
      FieldName = 'YEAR'
    end
    object CompanyTMANAD_BEN: TWideStringField
      FieldName = 'MANAD_BEN'
      Size = 10
    end
    object CompanyTMANAD: TFloatField
      FieldName = 'MANAD'
    end
    object CompanyTVECKODAG: TWideStringField
      FieldName = 'VECKODAG'
      Size = 7
    end
    object CompanyTVECKA: TFloatField
      FieldName = 'VECKA'
    end
    object CompanyTSISVECKA: TWideStringField
      FieldName = 'SISVECKA'
      Size = 4
    end
    object CompanyTFELLOGG: TWideStringField
      FieldName = 'FELLOGG'
      Size = 1
    end
    object CompanyTPAUS: TWideStringField
      FieldName = 'PAUS'
      Size = 1
    end
  end
  object Contr_InsurT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_Insur'
    Left = 96
    Top = 80
    object Contr_InsurTSubId: TIntegerField
      FieldName = 'SubId'
    end
    object Contr_InsurTICode: TWideStringField
      FieldName = 'ICode'
      Size = 8
    end
    object Contr_InsurTIDate: TDateField
      FieldName = 'IDate'
    end
    object Contr_InsurTFREGNR: TWideStringField
      FieldName = 'FREGNR'
      Size = 11
    end
    object Contr_InsurTIClass: TWideStringField
      FieldName = 'IClass'
      Size = 8
    end
    object Contr_InsurTINumber: TWideStringField
      FieldName = 'INumber'
      Size = 30
    end
    object Contr_InsurTMPREGNR: TWideStringField
      FieldName = 'MPREGNR'
      Size = 11
    end
  end
  object Contr_HistT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_Hist'
    Left = 24
    Top = 80
  end
  object Contr_EconT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_Econ'
    Left = 392
    Top = 16
    object Contr_EconTContrId: TIntegerField
      FieldName = 'ContrId'
    end
    object Contr_EconTCust_ObjType: TSmallintField
      FieldName = 'Cust_ObjType'
    end
    object Contr_EconTContoTyp: TWideStringField
      FieldName = 'ContoTyp'
      Size = 3
    end
    object Contr_EconTContoNr: TWideStringField
      FieldName = 'ContoNr'
    end
  end
  object Contr_costsT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_costs'
    Left = 318
    Top = 16
    object Contr_costsTCost_ID: TAutoIncField
      FieldName = 'Cost_ID'
    end
    object Contr_costsTContrID: TIntegerField
      FieldName = 'ContrID'
    end
    object Contr_costsTCostname: TWideStringField
      FieldName = 'Costname'
      Size = 50
    end
    object Contr_costsTNo: TFloatField
      FieldName = 'No'
    end
    object Contr_costsTPrice: TBCDField
      FieldName = 'Price'
      Precision = 19
    end
    object Contr_costsTVAT: TFloatField
      FieldName = 'VAT'
    end
    object Contr_costsTAcc_code: TIntegerField
      FieldName = 'Acc_code'
    end
    object Contr_costsTAcc_center: TIntegerField
      FieldName = 'Acc_center'
    end
  end
  object Contr_NotT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_Not'
    Left = 168
    Top = 80
    object Contr_NotTContrid: TIntegerField
      FieldName = 'Contrid'
    end
    object Contr_NotTCnot1: TWideStringField
      FieldName = 'Cnot1'
      Size = 48
    end
    object Contr_NotTCnot2: TWideStringField
      FieldName = 'Cnot2'
      Size = 48
    end
    object Contr_NotTInot1: TWideStringField
      FieldName = 'Inot1'
      Size = 48
    end
    object Contr_NotTInot2: TWideStringField
      FieldName = 'Inot2'
      Size = 48
    end
  end
  object Contr_ObjTT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_ObjT'
    Left = 248
    Top = 80
    object Contr_ObjTTConObjID: TAutoIncField
      FieldName = 'ConObjID'
    end
    object Contr_ObjTTContrId: TIntegerField
      FieldName = 'ContrId'
    end
    object Contr_ObjTTObTypId: TWideStringField
      FieldName = 'ObTypId'
      Size = 4
    end
    object Contr_ObjTTOId: TWideStringField
      FieldName = 'OId'
      Size = 10
    end
    object Contr_ObjTTFrm_Time: TDateField
      FieldName = 'Frm_Time'
    end
    object Contr_ObjTTTo_Time: TDateField
      FieldName = 'To_Time'
    end
    object Contr_ObjTTOut_Time: TDateField
      FieldName = 'Out_Time'
    end
    object Contr_ObjTTRet_Time: TDateField
      FieldName = 'Ret_Time'
    end
    object Contr_ObjTTKM_Out: TIntegerField
      FieldName = 'KM_Out'
    end
    object Contr_ObjTTKM_In: TIntegerField
      FieldName = 'KM_In'
    end
    object Contr_ObjTTKM_Ber: TIntegerField
      FieldName = 'KM_Ber'
    end
    object Contr_ObjTTPClass: TWideStringField
      FieldName = 'PClass'
      Size = 2
    end
    object Contr_ObjTTPType: TWideStringField
      FieldName = 'PType'
      Size = 2
    end
    object Contr_ObjTTStatus: TWordField
      FieldName = 'Status'
    end
    object Contr_ObjTTCarryCar: TWideStringField
      FieldName = 'CarryCar'
      Size = 7
    end
    object Contr_ObjTTInvNo: TIntegerField
      FieldName = 'InvNo'
    end
    object Contr_ObjTTSRRed: TBooleanField
      FieldName = 'SRRed'
    end
  end
  object Contr_ObjXT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    TableDirect = True
    TableName = 'Contr_ObjX'
    Left = 320
    Top = 80
  end
  object Contr_SubT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_Sub'
    Left = 392
    Top = 80
  end
  object Contr_SubCostRowT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_SubCostRow'
    Left = 104
    Top = 144
    object Contr_SubCostRowTSubId: TIntegerField
      FieldName = 'SubId'
    end
    object Contr_SubCostRowTRownumb: TIntegerField
      FieldName = 'Rownumb'
    end
    object Contr_SubCostRowTRowtext: TWideStringField
      FieldName = 'Rowtext'
      Size = 50
    end
    object Contr_SubCostRowTValue: TBCDField
      FieldName = 'Value'
      Precision = 19
    end
    object Contr_SubCostRowTPercent: TFloatField
      FieldName = 'Percent'
    end
    object Contr_SubCostRowTByValue: TBooleanField
      FieldName = 'ByValue'
    end
  end
  object Contr_SubNotT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_SubNot'
    Left = 240
    Top = 264
    object Contr_SubNotTSubID: TIntegerField
      FieldName = 'SubID'
    end
    object Contr_SubNotTKid: TIntegerField
      FieldName = 'Kid'
    end
    object Contr_SubNotTFaktAtt: TWideStringField
      FieldName = 'FaktAtt'
      Size = 50
    end
    object Contr_SubNotTFaktNot1: TWideStringField
      FieldName = 'FaktNot1'
      Size = 50
    end
    object Contr_SubNotTFaktNot2: TWideStringField
      FieldName = 'FaktNot2'
      Size = 50
    end
  end
  object ObjDateT: TADOTable
    Connection = DmSession.ADOConnection1
    TableName = 'ObjDate'
    Left = 392
    Top = 144
    object ObjDateTObjdateId: TAutoIncField
      FieldName = 'ObjdateId'
    end
    object ObjDateTReg_No: TWideStringField
      FieldName = 'Reg_No'
      Size = 10
    end
    object ObjDateTObjtyp: TWideStringField
      FieldName = 'Objtyp'
      Size = 4
    end
    object ObjDateTTransDate: TDateField
      FieldName = 'TransDate'
    end
    object ObjDateTTransInOut: TBooleanField
      FieldName = 'TransIn-Out'
    end
    object ObjDateTWhere: TWideStringField
      FieldName = 'Where'
      Size = 30
    end
    object ObjDateTTransCode: TWideStringField
      FieldName = 'TransCode'
    end
    object ObjDateTSign: TWideStringField
      FieldName = 'Sign'
      Size = 8
    end
    object ObjDateTNotDate: TDateField
      FieldName = 'NotDate'
    end
  end
  object ObjCostT: TADOTable
    Connection = DmSession.ADOConnection1
    TableName = 'ObjCost'
    Left = 320
    Top = 144
    object ObjCostTCostID: TAutoIncField
      FieldName = 'CostID'
    end
    object ObjCostTReg_No: TWideStringField
      FieldName = 'Reg_No'
      Size = 10
    end
    object ObjCostTCostDat: TDateField
      FieldName = 'CostDat'
    end
    object ObjCostTMeasure: TWideStringField
      FieldName = 'Measure'
      Size = 50
    end
    object ObjCostTCost: TBCDField
      FieldName = 'Cost'
      Precision = 19
    end
    object ObjCostTVat: TBCDField
      FieldName = 'Vat'
      Precision = 19
    end
    object ObjCostTSign: TWideStringField
      FieldName = 'Sign'
      Size = 8
    end
    object ObjCostTNotDate: TDateField
      FieldName = 'NotDate'
    end
    object ObjCostTTotal: TWideStringField
      FieldName = 'Total'
      Size = 50
    end
  end
  object Contr_SubCostT: TADOTable
    Connection = DmSession.ADOConnection1
    TableDirect = True
    TableName = 'Contr_SubCost'
    Left = 104
    Top = 248
    object Contr_SubCostTSubId: TIntegerField
      FieldName = 'SubId'
    end
    object Contr_SubCostTDSUM: TBCDField
      FieldName = 'DSUM'
      Precision = 19
    end
    object Contr_SubCostTDHYR: TBCDField
      FieldName = 'DHYR'
      Precision = 19
    end
    object Contr_SubCostTDMOMS: TBCDField
      FieldName = 'DMOMS'
      Precision = 19
    end
    object Contr_SubCostTDTOTAL: TBCDField
      FieldName = 'DTOTAL'
      Precision = 19
    end
    object Contr_SubCostTKONTOTYP: TWideStringField
      FieldName = 'KONTOTYP'
      Size = 3
    end
    object Contr_SubCostTKONTONR: TWideStringField
      FieldName = 'KONTONR'
    end
    object Contr_SubCostTK_SPARRKOLL: TBooleanField
      FieldName = 'K_SPARRKOLL'
    end
    object Contr_SubCostTK_SPARRNR: TWideStringField
      FieldName = 'K_SPARRNR'
      Size = 50
    end
  end
  object OrtrgT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    TableName = 'Ortrg'
    Left = 104
    Top = 192
    object OrtrgTPNR: TWideStringField
      FieldName = 'PNR'
      Size = 6
    end
    object OrtrgTORT: TWideStringField
      FieldName = 'ORT'
      Size = 16
    end
    object OrtrgTRIKT: TWideStringField
      FieldName = 'RIKT'
      Size = 4
    end
  end
  object ParamT: TADOTable
    Connection = DmSession.ADOConnection1
    TableName = 'Param'
    Left = 176
    Top = 192
  end
  object ReportsT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    TableName = 'Reports'
    Left = 256
    Top = 192
  end
  object ObjCostS: TDataSource
    DataSet = ObjCostT
    Left = 320
    Top = 192
  end
  object ObjDateS: TDataSource
    DataSet = ObjDateT
    Left = 392
    Top = 192
  end
  object LanguageT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorType = ctStatic
    TableName = 'Lang'
    Left = 24
    Top = 136
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 32
    Top = 296
  end
  object Q1: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    Left = 576
    Top = 16
  end
  object Q2: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    Left = 576
    Top = 64
  end
  object Q3: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    Left = 584
    Top = 112
  end
  object Q4: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    Left = 584
    Top = 160
  end
  object Q5: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    Left = 584
    Top = 208
  end
end
