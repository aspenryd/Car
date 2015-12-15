object FrmInloggning: TFrmInloggning
  Left = 431
  Top = 233
  Width = 258
  Height = 141
  Caption = 'Inloggning'
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
    Top = 16
    Width = 55
    Height = 13
    Caption = 'Anv'#228'ndare:'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 47
    Height = 13
    Caption = 'L'#246'senord:'
  end
  object Edit1: TEdit
    Left = 80
    Top = 48
    Width = 161
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    Text = 'Edit1'
    OnKeyDown = Edit1KeyDown
  end
  object BitBtn1: TBitBtn
    Left = 80
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 2
    Kind = bkCancel
  end
  object ComboBox1: TComboBox
    Left = 80
    Top = 16
    Width = 161
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = 'ComboBox1'
  end
end
