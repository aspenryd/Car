object frmCarlegal: TfrmCarlegal
  Left = 519
  Top = 210
  Width = 477
  Height = 316
  Caption = 'CARLegal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 469
    Height = 241
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 469
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      469
      41)
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 97
      Height = 25
      Caption = 'L'#228's in k'#246'rkort'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 384
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
  object Twain: TDelphiTwain
    OnTwainAcquire = TwainTwainAcquire
    TransferMode = ttmMemory
    SourceCount = 0
    Info.MajorVersion = 1
    Info.MinorVersion = 0
    Info.Language = tlUserLocale
    Info.CountryCode = 1
    Info.Groups = [tgControl, tgImage]
    Info.VersionInfo = 'Application name'
    Info.Manufacturer = 'Application manufacturer'
    Info.ProductFamily = 'App product family'
    Info.ProductName = 'App product name'
    LibraryLoaded = False
    SourceManagerLoaded = False
    Left = 152
    Top = 32
  end
end
