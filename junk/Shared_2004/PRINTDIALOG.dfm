object frmPrintDialog: TfrmPrintDialog
  Left = 326
  Top = 189
  Width = 385
  Height = 288
  Caption = 'frmPrintDialog'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 365
    Height = 220
    Align = alClient
    PageIndex = 5
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr0'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr1'
      object Label2: TLabel
        Left = 40
        Top = 36
        Width = 33
        Height = 13
        Caption = 'Loggnr'
      end
      object edLoggnr: TEdit
        Left = 96
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        OnKeyDown = edLoggnrKeyDown
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr2'
      object Label3: TLabel
        Left = 32
        Top = 32
        Width = 82
        Height = 13
        Caption = 'Kontraktsnummer'
      end
      object ed2_1: TEdit
        Left = 128
        Top = 29
        Width = 121
        Height = 21
        TabOrder = 0
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr3'
      object Label4: TLabel
        Left = 16
        Top = 28
        Width = 60
        Height = 13
        Caption = 'Reg.nummer'
      end
      object Label5: TLabel
        Left = 16
        Top = 60
        Width = 68
        Height = 13
        Caption = 'Datum interval'
      end
      object ed3_1: TEQFormatEdit
        Left = 104
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        EnterAsTab = False
      end
      object ed3_2: TEQFormatEdit
        Left = 232
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 1
        EnterAsTab = False
      end
      object ed3_3: TEQDateEdit
        Left = 104
        Top = 56
        Width = 121
        Height = 21
        Silent = False
        Text = 'ed3_3'
        TabOrder = 2
      end
      object ed3_4: TEQDateEdit
        Left = 232
        Top = 56
        Width = 121
        Height = 21
        Silent = False
        Text = 'ed3_4'
        TabOrder = 3
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr4'
      object Label1: TLabel
        Left = 32
        Top = 32
        Width = 73
        Height = 13
        Caption = 'Fakturanummer'
        FocusControl = btnCancel
      end
      object ED4_1: TEdit
        Left = 128
        Top = 29
        Width = 121
        Height = 21
        TabOrder = 0
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'nr5'
      object Label6: TLabel
        Left = 16
        Top = 60
        Width = 68
        Height = 13
        Caption = 'Datum interval'
      end
      object Label7: TLabel
        Left = 16
        Top = 28
        Width = 33
        Height = 13
        Caption = 'Obj.typ'
      end
      object ed5_4: TEQDateEdit
        Left = 232
        Top = 56
        Width = 121
        Height = 21
        Silent = False
        Text = 'ed5_4'
        TabOrder = 0
      end
      object ed5_2: TEQFormatEdit
        Left = 232
        Top = 24
        Width = 60
        Height = 21
        MaxLength = 4
        TabOrder = 1
        EnterAsTab = False
      end
      object ed5_1: TEQFormatEdit
        Left = 104
        Top = 24
        Width = 60
        Height = 21
        MaxLength = 4
        TabOrder = 2
        EnterAsTab = False
      end
      object ed5_3: TEQDateEdit
        Left = 104
        Top = 56
        Width = 121
        Height = 21
        Silent = False
        Text = 'ed5_3'
        TabOrder = 3
      end
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
    Top = 220
    Width = 377
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 202
      Top = 0
      Width = 175
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnCancel: TButton
        Left = 6
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Avbryt'
        ModalResult = 2
        TabOrder = 0
      end
      object btnPrint: TButton
        Left = 94
        Top = 8
        Width = 75
        Height = 25
        Caption = '&Skriv ut'
        Default = True
        TabOrder = 1
        OnClick = btnPrintClick
      end
    end
    object cbPreview: TCheckBox
      Left = 16
      Top = 16
      Width = 105
      Height = 17
      Caption = 'F'#246'rhandsgranska'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 365
    Top = 0
    Width = 12
    Height = 220
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
      Visible = False
    end
  end
end
