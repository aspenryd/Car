object DlgTimer: TDlgTimer
  Left = 257
  Top = 212
  Width = 284
  Height = 139
  Caption = 'Timer inställningar'
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
    Left = 24
    Top = 16
    Width = 43
    Height = 13
    Caption = 'Tid i sek:'
  end
  object EdtTimer: TEdit
    Left = 24
    Top = 32
    Width = 209
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 2
    Kind = bkCancel
  end
end
