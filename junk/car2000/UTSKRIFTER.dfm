object FrmUtskrift: TFrmUtskrift
  Left = 595
  Top = 103
  Width = 367
  Height = 213
  Caption = 'Utskrifter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 345
    Height = 177
    Caption = 'Avtal/Kvitto'
    TabOrder = 0
    object LblVal: TLabel
      Left = 32
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Skriv ut:'
    end
    object Label1: TLabel
      Left = 184
      Top = 24
      Width = 54
      Height = 13
      Caption = 'Baserat p'#229':'
    end
    object Label2: TLabel
      Left = 32
      Top = 64
      Width = 42
      Height = 13
      Caption = 'Nummer:'
    end
    object Label3: TLabel
      Left = 184
      Top = 64
      Width = 34
      Height = 13
      Caption = 'Datum:'
      Visible = False
    end
    object ComboBox1: TComboBox
      Left = 32
      Top = 40
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox2Change
      Items.Strings = (
        'Kontrakt (Avtal)'
        'Faktura (Kvitto)')
    end
    object ComboBox2: TComboBox
      Left = 184
      Top = 40
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = ComboBox2Change
      OnEnter = ComboBox2Enter
      Items.Strings = (
        'KontraktsNr'
        'FakturaNr (ENummer)'
        'RegNr & Datum')
    end
    object Edit1: TEdit
      Left = 32
      Top = 80
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 32
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Skriv Ut'
      TabOrder = 4
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 112
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Avbryt'
      TabOrder = 5
      Kind = bkCancel
    end
    object CBGranska: TCheckBox
      Left = 32
      Top = 112
      Width = 153
      Height = 17
      Caption = 'F'#246'rhandsgranska'
      TabOrder = 3
    end
    object DateTimePicker1: TDateTimePicker
      Left = 184
      Top = 80
      Width = 145
      Height = 21
      Date = 37422.503049919000000000
      Time = 37422.503049919000000000
      TabOrder = 6
      Visible = False
    end
  end
end
