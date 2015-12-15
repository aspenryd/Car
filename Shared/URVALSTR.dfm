object FrmUrvalStr: TFrmUrvalStr
  Left = 302
  Top = 194
  Width = 635
  Height = 319
  Caption = 'Urval 3'
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
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 488
    Height = 247
    Align = alClient
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr0'
      object Label1: TLabel
        Left = 40
        Top = 24
        Width = 70
        Height = 13
        Caption = 'Skriv in urval...'
      end
      object BitBtn1: TBitBtn
        Left = 240
        Top = 36
        Width = 75
        Height = 25
        TabOrder = 0
        Kind = bkOK
      end
      object Edit1: TEdit
        Left = 40
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr1'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr2'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr3'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr4'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr5'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr6'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr7'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr8'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr9'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr10'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr11'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr12'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 247
    Width = 627
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnPrint: TButton
      Left = 528
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Skriv ut'
      TabOrder = 0
      OnClick = btnPrintClick
    end
    object btnCancel: TButton
      Left = 440
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Avbryt'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 488
    Top = 0
    Width = 139
    Height = 247
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object btnPrinter: TButton
      Left = 16
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Skrivare..'
      TabOrder = 0
    end
    object cbPreview: TCheckBox
      Left = 16
      Top = 216
      Width = 105
      Height = 17
      Caption = 'F'#246'rhandgranska'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
end
