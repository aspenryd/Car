object Form1: TForm1
  Left = 192
  Top = 110
  Width = 551
  Height = 415
  Caption = 'TDelphiTwain simple example'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    543
    381)
  PixelsPerInch = 96
  TextHeight = 13
  object ImageHolder: TImage
    Left = 32
    Top = 72
    Width = 489
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
  end
  object Title: TPanel
    Left = 0
    Top = 0
    Width = 543
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Simple example using TDelphiTwain'
    Color = clAppWorkSpace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object GoAcquire: TButton
    Left = 32
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Acquire'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = GoAcquireClick
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
    Left = 208
    Top = 48
  end
end
