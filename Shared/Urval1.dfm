object FrmUrval1: TFrmUrval1
  Left = 292
  Top = 126
  Width = 321
  Height = 153
  Caption = 'Kreditera faktura'
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
    Left = 8
    Top = 24
    Width = 159
    Height = 13
    Caption = 'Ange faktura som skall krediteras.'
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 68
    Width = 81
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object EQFormatEdit1: TEQFormatEdit
    Left = 184
    Top = 20
    Width = 113
    Height = 21
    TabOrder = 1
    Text = '1'
    EnterAsTab = False
    Format = efInteger
  end
end
