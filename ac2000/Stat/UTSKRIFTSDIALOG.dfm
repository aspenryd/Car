object FrmUtsDg: TFrmUtsDg
  Left = 280
  Top = 316
  Width = 272
  Height = 127
  Caption = 'FrmUtsDg'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 70
    Height = 13
    Caption = 'Antal utskrifter:'
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 169
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 2
    Kind = bkCancel
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 0
    OnTimer = Timer1Timer
    Left = 216
    Top = 8
  end
end
