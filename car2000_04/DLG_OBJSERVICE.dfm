object FrmDg_ObjService: TFrmDg_ObjService
  Left = 300
  Top = 181
  Width = 358
  Height = 110
  Caption = 'Service kontroll'
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
    Left = 16
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 48
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 272
    Top = 24
  end
end
