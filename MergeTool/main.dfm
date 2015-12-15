object Form1: TForm1
  Left = 270
  Top = 123
  Width = 565
  Height = 557
  Caption = 'Car Merge Tool'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 549
    Height = 105
    Align = alTop
    Caption = 'Database connections'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 71
      Height = 13
      Caption = 'Base database'
    end
    object Label2: TLabel
      Left = 24
      Top = 64
      Width = 85
      Height = 13
      Caption = 'Merging database'
    end
    object edBaseDatabase: TEdit
      Left = 129
      Top = 24
      Width = 297
      Height = 21
      TabOrder = 0
      Text = 
        'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
        'al Catalog=Car_Torslanda;Data Source=ISIS'
      OnChange = edBaseDatabaseChange
    end
    object btnCheckBase: TButton
      Left = 439
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Check'
      TabOrder = 1
      OnClick = btnCheckBaseClick
    end
    object edMergingDatabase: TEdit
      Left = 129
      Top = 56
      Width = 297
      Height = 21
      TabOrder = 2
      Text = 
        'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
        'al Catalog=Car_Tuve;Data Source=ISIS'
      OnChange = edMergingDatabaseChange
    end
    object btnCheckMerging: TButton
      Left = 439
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Check'
      TabOrder = 3
      OnClick = btnCheckMergingClick
    end
  end
  object gbIds: TGroupBox
    Left = 0
    Top = 105
    Width = 549
    Height = 161
    Align = alTop
    Caption = 'Add to Id'#39's'
    Enabled = False
    TabOrder = 1
    object Label3: TLabel
      Left = 24
      Top = 24
      Width = 34
      Height = 13
      Caption = 'ContrId'
    end
    object Label4: TLabel
      Left = 24
      Top = 56
      Width = 28
      Height = 13
      Caption = 'SubId'
    end
    object Label5: TLabel
      Left = 24
      Top = 88
      Width = 30
      Height = 13
      Caption = 'CustId'
    end
    object Label6: TLabel
      Left = 24
      Top = 120
      Width = 49
      Height = 13
      Caption = 'SubCustId'
    end
    object edAddContrId: TEdit
      Left = 88
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object btnGetBaseContrId: TButton
      Left = 216
      Top = 16
      Width = 145
      Height = 25
      Caption = 'Get Max from base'
      TabOrder = 1
      OnClick = btnGetBaseContrIdClick
    end
    object edAddSubId: TEdit
      Left = 88
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object btnGetBaseSubId: TButton
      Left = 216
      Top = 48
      Width = 145
      Height = 25
      Caption = 'Get Max from base'
      TabOrder = 3
      OnClick = btnGetBaseSubIdClick
    end
    object edAddCustId: TEdit
      Left = 88
      Top = 80
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object btnGetBaseCustId: TButton
      Left = 216
      Top = 80
      Width = 145
      Height = 25
      Caption = 'Get Max from base'
      TabOrder = 5
      OnClick = btnGetBaseCustIdClick
    end
    object edAddSubCustId: TEdit
      Left = 88
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object btnGetBaseSubCustId: TButton
      Left = 216
      Top = 112
      Width = 145
      Height = 25
      Caption = 'Get Max from base'
      TabOrder = 7
      OnClick = btnGetBaseSubCustIdClick
    end
  end
  object gbAfter: TGroupBox
    Left = 0
    Top = 393
    Width = 549
    Height = 128
    Align = alClient
    Caption = 'Aftermath'
    Enabled = False
    TabOrder = 2
    object Button7: TButton
      Left = 16
      Top = 24
      Width = 265
      Height = 25
      Caption = 'Update Param fields in base with Max value'
      TabOrder = 0
      OnClick = Button7Click
    end
  end
  object gbMerge: TGroupBox
    Left = 0
    Top = 266
    Width = 549
    Height = 127
    Align = alTop
    Caption = 'Merge'
    Enabled = False
    TabOrder = 3
    object lblTable: TLabel
      Left = 256
      Top = 32
      Width = 137
      Height = 13
      Alignment = taCenter
      AutoSize = False
    end
    object btnMergeContr: TButton
      Left = 168
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Contr_*'
      Enabled = False
      TabOrder = 0
      OnClick = btnMergeContrClick
    end
    object btnMergeCustomer: TButton
      Left = 80
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Customer'
      Enabled = False
      TabOrder = 1
      OnClick = btnMergeCustomerClick
    end
    object btnMergeSignR: TButton
      Left = 256
      Top = 56
      Width = 75
      Height = 25
      Caption = 'SignR'
      Enabled = False
      TabOrder = 2
      OnClick = btnMergeSignRClick
    end
    object btnStart: TButton
      Left = 24
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Start transaction'
      TabOrder = 3
      OnClick = btnStartClick
    end
    object btnCommit: TButton
      Left = 24
      Top = 96
      Width = 105
      Height = 25
      Caption = 'Commit transaction'
      Enabled = False
      TabOrder = 4
      OnClick = btnCommitClick
    end
    object btnRollback: TButton
      Left = 136
      Top = 96
      Width = 105
      Height = 25
      Caption = 'Rollback transaction'
      Enabled = False
      TabOrder = 5
      OnClick = btnRollbackClick
    end
    object pbMerge: TProgressBar
      Left = 152
      Top = 16
      Width = 249
      Height = 17
      TabOrder = 6
    end
  end
  object ConBase: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=Car_Tuve;Data Source=ISIS'
    Provider = 'SQLOLEDB.1'
    Left = 440
    Top = 24
  end
  object ConMerge: TADOConnection
    Left = 440
    Top = 64
  end
  object qryBase: TADOQuery
    Connection = ConBase
    Parameters = <>
    Left = 440
    Top = 121
  end
  object qryMerge: TADOQuery
    Connection = ConMerge
    Parameters = <>
    Left = 440
    Top = 177
  end
end
