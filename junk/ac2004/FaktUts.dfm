object FrmFaktUts: TFrmFaktUts
  Left = 205
  Top = 172
  Width = 800
  Height = 523
  Caption = ','
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 623
    Top = 0
    Width = 169
    Height = 496
    Align = alRight
    TabOrder = 0
    object Label4: TLabel
      Left = 16
      Top = 408
      Width = 3
      Height = 13
    end
    object Label3: TLabel
      Left = 16
      Top = 392
      Width = 87
      Height = 13
      Caption = 'Antalet fakturor '#228'r '
    end
    object RG1: TRadioGroup
      Left = 16
      Top = 304
      Width = 145
      Height = 81
      Caption = 'Markera'
      TabOrder = 1
    end
    object RBAlla: TRadioButton
      Left = 24
      Top = 320
      Width = 105
      Height = 25
      Caption = 'Alla'
      TabOrder = 2
      OnClick = RBAllaClick
    end
    object RBEgna: TRadioButton
      Left = 24
      Top = 352
      Width = 113
      Height = 17
      Caption = 'Enstaka'
      TabOrder = 3
      OnClick = RBEgnaClick
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 145
      Height = 297
      Caption = 'Filtrera'
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 16
        Top = 184
        Width = 113
        Height = 22
        Caption = #197'terst'#228'll'
        Enabled = False
        OnClick = SpeedButton1Click
      end
      object Label5: TLabel
        Left = 16
        Top = 208
        Width = 28
        Height = 13
        Caption = 'Namn'
      end
      object Label7: TLabel
        Left = 16
        Top = 248
        Width = 34
        Height = 13
        Caption = 'Reg Nr'
      end
      object EdtNamn: TEdit
        Left = 16
        Top = 224
        Width = 113
        Height = 21
        Hint = #39'F2'#39' f'#246'r filtrering p'#229' Namn'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyDown = EdtNamnKeyDown
      end
      object Edit1: TEdit
        Left = 16
        Top = 264
        Width = 113
        Height = 21
        TabOrder = 1
        OnKeyDown = Edit1KeyDown
      end
      object Panel3: TPanel
        Left = 8
        Top = 16
        Width = 129
        Height = 161
        TabOrder = 2
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 30
          Height = 13
          Caption = 'T.o.m '
        end
        object Label6: TLabel
          Left = 8
          Top = 48
          Width = 44
          Height = 13
          Caption = 'Betal s'#228'tt'
        end
        object Label1: TLabel
          Left = 8
          Top = 88
          Width = 79
          Height = 13
          Caption = 'Summa st'#246'rre '#228'n'
        end
        object SpeedButton3: TSpeedButton
          Left = 8
          Top = 131
          Width = 113
          Height = 22
          Caption = 'Filtrera'
          Glyph.Data = {
            6E040000424D6E04000000000000360000002800000013000000120000000100
            18000000000038040000120B0000120B00000000000000000000BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBF000000000000000000000000000000000000000000000000
            000000000000000000BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBF000000FFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFF
            FFFF000000BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            000000BFBFBFFFFFFFBFBFBFFFFFFFBFBFBF000000000000000000BFBFBF0000
            00BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000FF
            FFFFBFBFBFFFFFFFBFBFBFFFFFFF000000FFFFFF000000FFFFFF000000BFBFBF
            BFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF0000
            00000000000000BFBFBF000000000000000000BFBFBF000000BFBFBFBFBFBF00
            0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000FFFFFFBFBFBFFFFFFF
            BFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFF000000BFBFBFBFBFBF000000BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFFFFFFFBFBFBFFFFFFFBF
            BFBF000000000000000000BFBFBF000000BFBFBFBFBFBF000000BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBF000000000000000000BFBFBFFFFFFFBFBFBFFFFFFF0000
            00FFFFFF000000FFFFFF000000BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBF0000007F7F00000000000000000000000000BFBFBF000000000000
            000000BFBFBF000000BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BF000000BFBFBF000000BFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFF
            FFFF000000BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000
            BFBFBF0000007F00007F00007F00007F00007F00007F00007F00007F00007F00
            00BFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF7F
            7F000000007F00007F00007F00007F00007F00007F00007F00007F0000BFBFBF
            BFBFBF000000BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF7F7F
            00000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00
            0000BFBFBFBFBFBF0000007F7F00FFFFFFFFFFFFBFBFBFBFBFBFBFBFBF7F7F00
            000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBF
            BF00000000000000000000000000000000000000000000000000000000000000
            0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000}
          OnClick = SpeedButton3Click
        end
        object DT: TDateTimePicker
          Left = 8
          Top = 24
          Width = 113
          Height = 21
          Date = 36783.132478472200000000
          Time = 36783.132478472200000000
          TabOrder = 0
        end
        object CBIntExt: TComboBox
          Left = 8
          Top = 64
          Width = 113
          Height = 21
          ItemHeight = 13
          TabOrder = 1
        end
        object EdtSum: TEdit
          Left = 8
          Top = 104
          Width = 113
          Height = 21
          TabOrder = 2
        end
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 448
      Width = 167
      Height = 47
      Align = alBottom
      TabOrder = 4
      object SpeedButton2: TSpeedButton
        Left = 32
        Top = 14
        Width = 105
        Height = 25
        Caption = '&Bearbeta'
        NumGlyphs = 2
        OnClick = SpeedButton2Click
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 623
    Height = 496
    Align = alClient
    DataSource = Dmod2.D1
    Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
end
