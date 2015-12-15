object Form1: TForm1
  Left = 192
  Top = 107
  Width = 681
  Height = 599
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 208
    Width = 625
    Height = 337
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    WordWrap = False
  end
  object Button1: TButton
    Left = 128
    Top = 64
    Width = 105
    Height = 25
    Caption = 'Kolla fil'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 504
    Top = 64
    Width = 129
    Height = 25
    Caption = #214'verf'#246'r data'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 128
    Top = 120
    Width = 161
    Height = 25
    Caption = 'S'#228'tt upp databas'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 504
    Top = 96
    Width = 129
    Height = 25
    Caption = 'Bygg ny Answer'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 152
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 5
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 248
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 6
    Visible = False
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 352
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button7'
    TabOrder = 7
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 512
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button8'
    TabOrder = 8
    OnClick = Button8Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=Car_Stat;Data Source=SVR01'
    Provider = 'SQLOLEDB.1'
    Left = 72
    Top = 16
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 112
    Top = 16
  end
end
