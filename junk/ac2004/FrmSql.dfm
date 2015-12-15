object FormSql: TFormSql
  Left = 193
  Top = 167
  Width = 696
  Height = 480
  Caption = 'Sql'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 688
    Height = 111
    Align = alTop
    TabOrder = 0
  end
  object DBGrid6: TDBGrid
    Left = 0
    Top = 111
    Width = 583
    Height = 342
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel2: TPanel
    Left = 583
    Top = 111
    Width = 105
    Height = 342
    Align = alRight
    TabOrder = 2
    object Button4: TButton
      Left = 8
      Top = 8
      Width = 91
      Height = 25
      Caption = 'K'#246'r Sql-Fr'#229'ga'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 8
      Top = 48
      Width = 91
      Height = 25
      Caption = 'Sql-Fr'#229'ga'
      PopupMenu = PopupMenu1
      TabOrder = 1
      OnClick = Button5Click
    end
    object Button2: TButton
      Left = 8
      Top = 88
      Width = 91
      Height = 25
      Caption = 'Spara Resultat'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Sql1: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 591
    Top = 311
  end
  object DataSource1: TDataSource
    DataSet = Sql1
    Left = 631
    Top = 311
  end
  object Od1: TOpenDialog
    Filter = 'TextFiler|*.txt'
    Left = 632
    Top = 344
  end
  object SD1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'TextFiles|*.txt'
    Left = 592
    Top = 344
  end
  object SaveDiaSql: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Textfiles|*.txt'
    Left = 583
    Top = 383
  end
  object PopupMenu1: TPopupMenu
    TrackButton = tbLeftButton
    Left = 552
    Top = 288
    object Tm1: TMenuItem
      Caption = 'T'#246'm'
      OnClick = Tm1Click
    end
    object Lsin1: TMenuItem
      Caption = 'L'#228's in'
      OnClick = Lsin1Click
    end
    object Spara1: TMenuItem
      Caption = 'Spara'
      OnClick = Spara1Click
    end
  end
  object PopupMenu2: TPopupMenu
    TrackButton = tbLeftButton
    Left = 552
    Top = 256
    object SelectFrga1: TMenuItem
      Caption = #39'Select'#39'-Fr'#229'ga'
      OnClick = SelectFrga1Click
    end
    object UppdateringsFrga1: TMenuItem
      Caption = 'Uppdaterings-Fr'#229'ga'
      OnClick = UppdateringsFrga1Click
    end
  end
end
