object Dmod2: TDmod2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 208
  Top = 131
  Height = 480
  Width = 805
  object BetstT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Betst'
    Left = 32
    Top = 72
  end
  object CardsT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Cards'
    Left = 96
    Top = 72
  end
  object ReportsT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Reports'
    Left = 32
    Top = 304
  end
  object SignrT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Signr'
    Left = 96
    Top = 304
  end
  object PriceTabRowsT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    IndexFieldNames = 'PriceId'
    MasterFields = 'PriceId'
    MasterSource = PriceTabS
    TableName = 'PriceTabRows'
    Left = 288
    Top = 184
    object PriceTabRowsTPriceId: TIntegerField
      FieldName = 'PriceId'
    end
    object PriceTabRowsTRowNum: TIntegerField
      FieldName = 'RowNum'
    end
    object PriceTabRowsTMINDAG: TSmallintField
      FieldName = 'MINDAG'
    end
    object PriceTabRowsTPRISDAG: TSmallintField
      FieldName = 'PRISDAG'
    end
    object PriceTabRowsTKOST: TBCDField
      FieldName = 'KOST'
      Precision = 19
    end
    object PriceTabRowsTINKL_KM: TSmallintField
      FieldName = 'INKL_KM'
    end
    object PriceTabRowsTOVERKM: TFloatField
      FieldName = 'OVERKM'
    end
    object PriceTabRowsTXDYGN: TSmallintField
      FieldName = 'XDYGN'
    end
    object PriceTabRowsTXINKLKM: TFloatField
      FieldName = 'XINKLKM'
    end
  end
  object PriceTabT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'PriceTab'
    Left = 160
    Top = 184
  end
  object ParamT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Param'
    Left = 96
    Top = 184
  end
  object ObjTypeT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'ObjType'
    Left = 32
    Top = 184
  end
  object DrivMT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'DrivM'
    Left = 288
    Top = 72
  end
  object CostsT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Costs'
    Left = 224
    Top = 72
  end
  object CompanyT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Company'
    Left = 160
    Top = 72
  end
  object TtypT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Ttyp'
    Left = 160
    Top = 304
  end
  object BetstS: TDataSource
    DataSet = BetstT
    OnStateChange = BetstSStateChange
    Left = 32
    Top = 120
  end
  object CardsS: TDataSource
    DataSet = CardsT
    OnStateChange = CardsSStateChange
    Left = 96
    Top = 120
  end
  object TtypS: TDataSource
    DataSet = TtypT
    OnStateChange = TtypSStateChange
    Left = 160
    Top = 352
  end
  object SignrS: TDataSource
    DataSet = SignrT
    OnStateChange = SignrSStateChange
    Left = 96
    Top = 352
  end
  object ReportsS: TDataSource
    DataSet = ReportsT
    OnStateChange = ReportsSStateChange
    Left = 32
    Top = 352
  end
  object PriceTabRowsS: TDataSource
    DataSet = PriceTabRowsT
    Left = 288
    Top = 232
  end
  object PriceTabS: TDataSource
    DataSet = PriceTabT
    OnStateChange = PriceTabSStateChange
    Left = 160
    Top = 232
  end
  object ParamS: TDataSource
    DataSet = ParamT
    OnStateChange = ParamSStateChange
    Left = 96
    Top = 232
  end
  object ObjTypeS: TDataSource
    DataSet = ObjTypeT
    OnStateChange = ObjTypeSStateChange
    Left = 32
    Top = 232
  end
  object DrivMS: TDataSource
    DataSet = DrivMT
    OnStateChange = DrivMSStateChange
    Left = 288
    Top = 120
  end
  object CostsS: TDataSource
    DataSet = CostsT
    OnStateChange = CostsSStateChange
    Left = 224
    Top = 120
  end
  object CompanyS: TDataSource
    DataSet = CompanyT
    OnStateChange = CompanySStateChange
    Left = 160
    Top = 120
  end
  object Contr_BaseT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Contr_Base'
    Left = 264
    Top = 304
  end
  object Contr_SubT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    IndexFieldNames = 'ContrId'
    TableName = 'Contr_Sub'
    Left = 336
    Top = 304
  end
  object Contr_ObjtT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    IndexFieldNames = 'ContrId'
    TableName = 'Contr_ObjT'
    Left = 408
    Top = 304
  end
  object Contr_BaseS: TDataSource
    DataSet = Contr_BaseT
    Left = 258
    Top = 350
  end
  object Contr_SubS: TDataSource
    DataSet = Contr_SubT
    Left = 336
    Top = 352
  end
  object Contr_ObjS: TDataSource
    DataSet = Contr_ObjtT
    Left = 408
    Top = 360
  end
  object Contr_SubCostT: TADOTable
    Connection = Dmod1.ADOConnection1
    IndexFieldNames = 'SubId'
    TableName = 'Contr_SubCost'
    Left = 480
    Top = 304
  end
  object q1: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Contr_Base.ContrId, Contr_Sub.SubName, Contr_ObjT.OId, Co' +
        'ntr_ObjT.Ret_Time, Contr_SubCost.DTOTAL, Contr_Base.Status, Cont' +
        'r_Sub.SubId, Contr_Sub.Payment'
      
        'FROM (Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Co' +
        'ntr_ObjT.ContrId) INNER JOIN (Contr_Sub LEFT JOIN Contr_SubCost ' +
        'ON Contr_Sub.SubId = Contr_SubCost.SubId) ON Contr_Base.ContrId ' +
        '= Contr_Sub.ContrId'
      'WHERE (((Contr_Base.Status)=9));')
    Left = 496
    Top = 24
  end
  object D1: TDataSource
    DataSet = q1
    Left = 496
    Top = 72
  end
  object KonteringT: TADOTable
    Connection = Dmod1.ADOConnection1
    TableName = 'Kontering'
    Left = 384
    Top = 184
    object KonteringTCounter: TAutoIncField
      FieldName = 'Counter'
    end
    object KonteringTKonteringsid: TFloatField
      FieldName = 'Konteringsid'
    end
    object KonteringTKonteringsnamn: TWideStringField
      FieldName = 'Konteringsnamn'
    end
    object KonteringTKontonr: TFloatField
      FieldName = 'Kontonr'
    end
    object KonteringTKStalleStyrning: TFloatField
      FieldName = 'KStalleStyrning'
    end
    object KonteringTInternKontoNr: TFloatField
      FieldName = 'InternKontoNr'
    end
    object KonteringTKoncernKontoNr: TFloatField
      FieldName = 'KoncernKontoNr'
    end
  end
  object KonteringS: TDataSource
    DataSet = KonteringT
    OnStateChange = KonteringSStateChange
    Left = 384
    Top = 232
  end
  object LoggTabellT: TADOTable
    Connection = Dmod1.ADOConnection1
    TableName = 'LoggTabell'
    Left = 456
    Top = 184
    object LoggTabellTLoggId: TAutoIncField
      FieldName = 'LoggId'
    end
    object LoggTabellTLoggNr: TIntegerField
      FieldName = 'LoggNr'
    end
    object LoggTabellTNrTyp: TIntegerField
      FieldName = 'NrTyp'
    end
    object LoggTabellTNummer: TIntegerField
      FieldName = 'Nummer'
    end
    object LoggTabellTBokf_dag: TDateField
      FieldName = 'Bokf_dag'
    end
  end
  object KnterRadT: TADOTable
    Connection = Dmod1.ADOConnection1
    TableName = 'KnterRad'
    Left = 528
    Top = 192
    object KnterRadTCounter: TAutoIncField
      FieldName = 'Counter'
    end
    object KnterRadTNrTyp: TIntegerField
      FieldName = 'NrTyp'
    end
    object KnterRadTNummer: TFloatField
      FieldName = 'Nummer'
    end
    object KnterRadTKonto: TFloatField
      FieldName = 'Konto'
    end
    object KnterRadTKStalle: TFloatField
      FieldName = 'KStalle'
    end
    object KnterRadTDebet: TFloatField
      FieldName = 'Debet'
    end
    object KnterRadTKredit: TFloatField
      FieldName = 'Kredit'
    end
  end
  object CustomerT: TADOTable
    Connection = Dmod1.ADOConnection1
    TableName = 'Customer'
    Left = 360
    Top = 72
  end
  object Contr_SubCostRowT: TADOTable
    Connection = Dmod1.ADOConnection1
    TableName = 'Contr_SubCostRow'
    Left = 536
    Top = 304
  end
  object Ekq1: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 408
    Top = 24
  end
  object Report_DateT: TADOTable
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    TableName = 'Report_Date'
    Left = 32
    Top = 24
  end
  object Report_DateS: TDataSource
    DataSet = Report_DateT
    Left = 88
    Top = 16
  end
  object QKont: TADOQuery
    Connection = Dmod1.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 304
    Top = 16
  end
  object QAntBil: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select * from Objects;')
    Left = 176
    Top = 24
  end
  object Q2: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 488
    Top = 128
  end
  object CustomerS: TDataSource
    DataSet = CustomerT
    OnStateChange = DrivMSStateChange
    Left = 360
    Top = 128
  end
  object ObjectT: TADOTable
    Connection = Dmod1.ADOConnection1
    TableName = 'Objects'
    Left = 416
    Top = 72
  end
  object ObjectS: TDataSource
    DataSet = ObjectT
    OnStateChange = DrivMSStateChange
    Left = 416
    Top = 128
  end
end
