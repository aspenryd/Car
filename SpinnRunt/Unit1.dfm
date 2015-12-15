object Form1: TForm1
  Left = 239
  Top = 168
  Width = 330
  Height = 149
  Caption = 'SpinnBack'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 19
    Height = 13
    Caption = 'Pnr:'
  end
  object SpeedButton1: TSpeedButton
    Left = 296
    Top = 0
    Width = 23
    Height = 22
    Flat = True
    OnClick = SpeedButton1Click
  end
  object Edit1: TEdit
    Left = 24
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 168
    Top = 24
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 216
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 56
    object Arkiv1: TMenuItem
      Caption = '&Arkiv'
      object Avsluta1: TMenuItem
        Caption = 'Avsluta'
        OnClick = Avsluta1Click
      end
    end
  end
end
