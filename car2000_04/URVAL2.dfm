object FrmUrval2: TFrmUrval2
  Left = 322
  Top = 177
  Width = 221
  Height = 122
  Caption = 'Urval 2'
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
    Left = 8
    Top = 8
    Width = 21
    Height = 13
    Caption = 'Från'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 13
    Height = 13
    Caption = 'Till'
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 60
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object DateTimePicker1: TDateTimePicker
    Left = 16
    Top = 24
    Width = 89
    Height = 21
    CalAlignment = dtaLeft
    Date = 37264.6960560185
    Time = 37264.6960560185
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
  end
  object DateTimePicker2: TDateTimePicker
    Left = 16
    Top = 64
    Width = 89
    Height = 21
    CalAlignment = dtaLeft
    Date = 37264.6960923032
    Time = 37264.6960923032
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
end
