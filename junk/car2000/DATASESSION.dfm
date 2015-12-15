object DmSession: TDmSession
  OldCreateOrder = False
  Left = 170
  Top = 151
  Height = 480
  Width = 696
  object ADOConnection1: TADOConnection
    CursorLocation = clUseServer
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'ADsDSOObject'
    Left = 120
    Top = 72
  end
  object SDb: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB;Persist Security Info=False;User ID=sa;Initial' +
      ' Catalog=car;Data Source=PBSERVER02'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB'
    Left = 120
    Top = 184
  end
  object SDbAnswerT: TADOTable
    Connection = SDb
    CursorLocation = clUseServer
    TableDirect = True
    TableName = 'Answer'
    Left = 184
    Top = 184
  end
end
