object FrmStatiska: TFrmStatiska
  Left = 210
  Top = 168
  Width = 696
  Height = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet2: TTabSheet
      Tag = 2
      Caption = '&Bet.s'#228'tt'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 425
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 19
          Height = 13
          Caption = 'Kod'
        end
        object Label2: TLabel
          Left = 88
          Top = 16
          Width = 28
          Height = 13
          Caption = 'Namn'
        end
        object Label11: TLabel
          Left = 192
          Top = 16
          Width = 37
          Height = 13
          Caption = 'Bet Typ'
        end
        object Label12: TLabel
          Left = 296
          Top = 16
          Width = 54
          Height = 13
          Caption = 'Antal dagar'
        end
        object Label13: TLabel
          Left = 400
          Top = 16
          Width = 28
          Height = 13
          Caption = 'Konto'
        end
        object DBEdit22: TDBEdit
          Left = 16
          Top = 32
          Width = 57
          Height = 21
          DataField = 'Kod'
          DataSource = Dmod2.BetstS
          TabOrder = 0
        end
        object DBEdit26: TDBEdit
          Left = 88
          Top = 32
          Width = 89
          Height = 21
          DataField = 'Namn'
          DataSource = Dmod2.BetstS
          TabOrder = 1
        end
        object DBEdit25: TDBEdit
          Left = 192
          Top = 32
          Width = 89
          Height = 21
          DataField = 'BTyp'
          DataSource = Dmod2.BetstS
          TabOrder = 2
        end
        object DBEdit24: TDBEdit
          Left = 296
          Top = 32
          Width = 89
          Height = 21
          DataField = 'AntDagar'
          DataSource = Dmod2.BetstS
          TabOrder = 3
        end
        object DBEdit23: TDBEdit
          Left = 400
          Top = 32
          Width = 89
          Height = 21
          DataField = 'Konto'
          DataSource = Dmod2.BetstS
          TabOrder = 4
        end
        object PaBetsG: TPanel
          Left = 1
          Top = 1
          Width = 678
          Height = 423
          Align = alClient
          TabOrder = 5
          Visible = False
          object DBGrid1: TDBGrid
            Left = 1
            Top = 1
            Width = 676
            Height = 421
            Align = alClient
            DataSource = Dmod2.BetstS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnDblClick = DBGrid1DblClick
            OnKeyUp = DBGrid1KeyUp
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Tag = 3
      Caption = '&Drivmedel'
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 425
        Align = alClient
        TabOrder = 0
        object Label67: TLabel
          Left = 16
          Top = 12
          Width = 11
          Height = 13
          Caption = 'ID'
        end
        object Label68: TLabel
          Left = 168
          Top = 12
          Width = 28
          Height = 13
          Caption = 'Namn'
        end
        object DBEdit15: TDBEdit
          Left = 16
          Top = 28
          Width = 121
          Height = 21
          DataField = 'ID'
          DataSource = Dmod2.DrivMS
          TabOrder = 0
        end
        object DBEdit32: TDBEdit
          Left = 168
          Top = 28
          Width = 121
          Height = 21
          DataField = 'Namn'
          DataSource = Dmod2.DrivMS
          TabOrder = 1
        end
        object PaDrivMG: TPanel
          Left = 1
          Top = 1
          Width = 678
          Height = 423
          Align = alClient
          TabOrder = 2
          Visible = False
          object DBGrid2: TDBGrid
            Left = 1
            Top = 1
            Width = 676
            Height = 421
            Align = alClient
            DataSource = Dmod2.DrivMS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid2CellClick
            OnDblClick = DBGrid2DblClick
            OnKeyUp = DBGrid2KeyUp
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Tag = 1
      Caption = '&Kontokort'
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 425
        Align = alClient
        TabOrder = 0
        object Label3: TLabel
          Left = 16
          Top = 12
          Width = 18
          Height = 13
          Caption = 'Typ'
        end
        object Label4: TLabel
          Left = 128
          Top = 12
          Width = 28
          Height = 13
          Caption = 'Namn'
        end
        object DBEdit1: TDBEdit
          Left = 16
          Top = 28
          Width = 49
          Height = 21
          CharCase = ecUpperCase
          DataField = 'TYP'
          DataSource = Dmod2.CardsS
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 128
          Top = 28
          Width = 201
          Height = 21
          DataField = 'TYPNAMN'
          DataSource = Dmod2.CardsS
          TabOrder = 1
        end
        object PaKontokG: TPanel
          Left = 1
          Top = 1
          Width = 678
          Height = 423
          Align = alClient
          TabOrder = 2
          Visible = False
          object DBGrid3: TDBGrid
            Left = 1
            Top = 1
            Width = 676
            Height = 421
            Align = alClient
            DataSource = Dmod2.CardsS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid3CellClick
            OnDblClick = DBGrid3DblClick
            OnKeyUp = DBGrid3KeyUp
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Tag = 4
      Caption = '&Telefon'
      ImageIndex = 3
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 425
        Align = alClient
        TabOrder = 0
        object Label37: TLabel
          Left = 16
          Top = 12
          Width = 54
          Height = 13
          Caption = 'Telefonkod'
        end
        object Label38: TLabel
          Left = 128
          Top = 12
          Width = 55
          Height = 13
          Caption = 'Beskrivning'
        end
        object DBEdit40: TDBEdit
          Left = 16
          Top = 28
          Width = 25
          Height = 21
          CharCase = ecUpperCase
          DataField = 'Teletyp'
          DataSource = Dmod2.TtypS
          TabOrder = 0
        end
        object DBEdit41: TDBEdit
          Left = 128
          Top = 28
          Width = 121
          Height = 21
          DataField = 'Telebeskrivning'
          DataSource = Dmod2.TtypS
          TabOrder = 1
        end
        object PaTeleG: TPanel
          Left = 1
          Top = 1
          Width = 678
          Height = 423
          Align = alClient
          TabOrder = 2
          Visible = False
          object DBGrid4: TDBGrid
            Left = 1
            Top = 1
            Width = 676
            Height = 421
            Align = alClient
            DataSource = Dmod2.TtypS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid4CellClick
            OnDblClick = DBGrid4DblClick
            OnKeyUp = DBGrid4KeyUp
          end
        end
      end
    end
  end
end
