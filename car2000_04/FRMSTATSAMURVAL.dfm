object FrmUrvSams: TFrmUrvSams
  Left = 339
  Top = 209
  Width = 318
  Height = 125
  Caption = 'Urval sammanställning'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 24
    Height = 13
    Caption = 'Från:'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 16
    Height = 13
    Caption = 'Till:'
  end
  object DateTimePicker1: TDateTimePicker
    Left = 24
    Top = 24
    Width = 186
    Height = 21
    CalAlignment = dtaLeft
    Date = 37171.1459777778
    Time = 37171.1459777778
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 0
  end
  object DateTimePicker2: TDateTimePicker
    Left = 24
    Top = 64
    Width = 186
    Height = 21
    CalAlignment = dtaLeft
    Date = 37171.146022338
    Time = 37171.146022338
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 224
    Top = 60
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 224
    Top = 20
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 3
    Kind = bkCancel
  end
end
