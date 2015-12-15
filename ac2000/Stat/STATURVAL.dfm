object FrmStatUrval: TFrmStatUrval
  Left = 177
  Top = 147
  Width = 225
  Height = 222
  Caption = 'Urval'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 112
    Width = 46
    Height = 13
    Caption = 'Antal bilar'
  end
  object BitBtn1: TBitBtn
    Left = 128
    Top = 152
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 128
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 2
    Kind = bkAbort
  end
  object DateTimePicker1: TDateTimePicker
    Left = 16
    Top = 56
    Width = 186
    Height = 21
    Date = 37066.731523611100000000
    Time = 37066.731523611100000000
    TabOrder = 0
  end
  object DateTimePicker2: TDateTimePicker
    Left = 16
    Top = 88
    Width = 186
    Height = 21
    Date = 37066.731557870400000000
    Time = 37066.731557870400000000
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 16
    Top = 128
    Width = 97
    Height = 21
    TabOrder = 3
  end
  object BFC_ComboBox1: TComboBox
    Left = 56
    Top = 16
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Text = 'BFC_ComboBox1'
  end
  object q1: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 32
    Top = 160
  end
end
