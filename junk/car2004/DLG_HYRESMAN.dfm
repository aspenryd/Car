object FrmDg_Hyresman: TFrmDg_Hyresman
  Left = 337
  Top = 165
  Width = 318
  Height = 114
  Caption = 'Car2000'
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
    Width = 273
    Height = 13
    Caption = 'Kunden '#228'r ett f'#246'retag och du har inte anget n'#229'gon f'#246'rare. '
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 51
    Height = 13
    Caption = #196'r det Ok?'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 96
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 1
    Kind = bkCancel
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 232
    Top = 40
  end
end
