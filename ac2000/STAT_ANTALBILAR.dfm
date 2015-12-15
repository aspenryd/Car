object FrmStatAntBil: TFrmStatAntBil
  Left = 224
  Top = 124
  Width = 239
  Height = 130
  Caption = 'Antal Objekt'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 59
    Height = 13
    Caption = 'Antal objekt:'
  end
  object SpeedButton1: TSpeedButton
    Left = 144
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Alla Objekt'
    OnClick = SpeedButton1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 68
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
end
