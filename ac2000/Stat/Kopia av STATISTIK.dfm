object FrmStat: TFrmStat
  Left = 196
  Top = 105
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Information'
  ClientHeight = 380
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 150
    Height = 380
    Align = alLeft
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 16
      Top = 16
      Width = 121
      Height = 25
      Caption = 'Kund'
      TabOrder = 0
      OnClick = BtnKundClick
    end
    object BitBtn2: TBitBtn
      Left = 16
      Top = 48
      Width = 121
      Height = 25
      Caption = 'Objekt'
      TabOrder = 1
      OnClick = EBObjClick
    end
    object BitBtn3: TBitBtn
      Left = 16
      Top = 80
      Width = 121
      Height = 25
      Caption = 'Objects Grupp'
      TabOrder = 2
      OnClick = EBObjTypStatClick
    end
    object BitBtn4: TBitBtn
      Left = 16
      Top = 144
      Width = 121
      Height = 25
      Caption = 'Sammanst'#228'llning'
      TabOrder = 3
      OnClick = EBSamClick
    end
    object BitBtn5: TBitBtn
      Left = 16
      Top = 176
      Width = 121
      Height = 25
      Caption = 'T'#246'm'
      TabOrder = 4
      OnClick = EBTomClick
    end
    object BitBtn6: TBitBtn
      Left = 16
      Top = 208
      Width = 121
      Height = 25
      Caption = 'Print'
      TabOrder = 5
      Visible = False
      OnClick = EBPrintClick
    end
    object BitBtn7: TBitBtn
      Left = 16
      Top = 112
      Width = 121
      Height = 25
      Caption = 'Lista'
      TabOrder = 6
      OnClick = ExpressButton1Click
    end
  end
  object KundPanel: TPanel
    Left = 150
    Top = 0
    Width = 723
    Height = 380
    Align = alClient
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 1
    Visible = False
    object GroupBox3: TGroupBox
      Left = 0
      Top = 185
      Width = 723
      Height = 195
      Align = alClient
      Caption = 'Statistik'
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 719
        Height = 178
        Align = alClient
        Color = clMenu
        DataSource = QStatS
        Options = [dgRowLines, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object QuickRep1: TQuickRep
      Left = -16
      Top = -272
      Width = 794
      Height = 1123
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Functions.Strings = (
        'PAGENUMBER'
        'COLUMNNUMBER'
        'REPORTTITLE'
        'QRSTRINGSBAND1')
      Functions.DATA = (
        '0'
        '0'
        #39#39
        #39#39)
      Options = [FirstPageHeader, LastPageFooter]
      Page.Columns = 1
      Page.Orientation = poPortrait
      Page.PaperSize = A4
      Page.Values = (
        100
        2970
        100
        2100
        100
        100
        0)
      PrinterSettings.Copies = 1
      PrinterSettings.Duplex = False
      PrinterSettings.FirstPage = 0
      PrinterSettings.LastPage = 0
      PrinterSettings.OutputBin = Auto
      PrintIfEmpty = True
      ReportTitle = 'Sammanst'#228'llning'
      SnapToGrid = True
      Units = MM
      Zoom = 100
      object QRBand1: TQRBand
        Left = 38
        Top = 38
        Width = 718
        Height = 955
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = True
        Size.Values = (
          2526.77083333333
          1899.70833333333)
        BandType = rbTitle
        object QRLabel1: TQRLabel
          Left = 208
          Top = 16
          Width = 244
          Height = 37
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            97.8958333333333
            550.333333333333
            42.3333333333333
            645.583333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Sammanst'#228'llning'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 24
        end
        object QRLabel2: TQRLabel
          Left = 16
          Top = 56
          Width = 42
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            42.3333333333333
            148.166666666667
            111.125)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Period:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRFrom: TQRLabel
          Left = 16
          Top = 80
          Width = 50
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            42.3333333333333
            211.666666666667
            132.291666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRFrom'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRTO: TQRLabel
          Left = 16
          Top = 104
          Width = 37
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            42.3333333333333
            275.166666666667
            97.8958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRTO'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel3: TQRLabel
          Left = 80
          Top = 168
          Width = 116
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            444.5
            306.916666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Antal Objektsdagar:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel4: TQRLabel
          Left = 80
          Top = 232
          Width = 105
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            613.833333333333
            277.8125)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Antal Hyresdagar:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel5: TQRLabel
          Left = 80
          Top = 296
          Width = 96
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            783.166666666667
            254)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Utnyttjandegrad:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRIntDag: TQRLabel
          Left = 224
          Top = 360
          Width = 57
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            952.5
            150.8125)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRIntDag'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRHyrasnitt: TQRLabel
          Left = 224
          Top = 328
          Width = 72
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            867.833333333334
            190.5)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRHyrasnitt'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRUtnyt: TQRLabel
          Left = 224
          Top = 296
          Width = 51
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            783.166666666667
            134.9375)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRUtnyt'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRNetto: TQRLabel
          Left = 224
          Top = 264
          Width = 51
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            698.5
            134.9375)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRNetto'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRHyrD: TQRLabel
          Left = 224
          Top = 232
          Width = 49
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            613.833333333333
            129.645833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRHyrD'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRAvHy: TQRLabel
          Left = 224
          Top = 200
          Width = 50
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            529.166666666667
            132.291666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRAvHy'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRObjD: TQRLabel
          Left = 224
          Top = 168
          Width = 49
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            444.5
            129.645833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRObjD'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel13: TQRLabel
          Left = 80
          Top = 392
          Width = 98
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            1037.16666666667
            259.291666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Int'#228'kt per objekt:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel14: TQRLabel
          Left = 80
          Top = 424
          Width = 108
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            1121.83333333333
            285.75)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Totalt antal objekt:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel15: TQRLabel
          Left = 80
          Top = 328
          Width = 106
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            867.833333333334
            280.458333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Hyresl'#228'ngd i snitt:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel16: TQRLabel
          Left = 80
          Top = 264
          Width = 100
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            698.5
            264.583333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Nettooms'#228'ttning:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel17: TQRLabel
          Left = 80
          Top = 200
          Width = 126
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            529.166666666667
            333.375)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Antal avslutade hyror:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel18: TQRLabel
          Left = 80
          Top = 360
          Width = 109
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            952.5
            288.395833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Int'#228'kt per hyredag:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRIntObj: TQRLabel
          Left = 224
          Top = 392
          Width = 54
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            1037.16666666667
            142.875)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRIntObj'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRTotObj: TQRLabel
          Left = 224
          Top = 424
          Width = 58
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            1121.83333333333
            153.458333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRTotObj'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel6: TQRLabel
          Left = 272
          Top = 296
          Width = 13
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            719.666666666667
            783.166666666667
            34.3958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '%'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRShape2: TQRShape
          Left = 8
          Top = 528
          Width = 705
          Height = 9
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            23.8125
            21.1666666666667
            1397
            1865.3125)
          Shape = qrsRectangle
        end
        object QRShape1: TQRShape
          Left = 8
          Top = 136
          Width = 705
          Height = 9
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            23.8125
            21.1666666666667
            359.833333333333
            1865.3125)
          Shape = qrsRectangle
        end
        object QRLabel7: TQRLabel
          Left = 80
          Top = 456
          Width = 128
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            1206.5
            338.666666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Antal p'#229'b'#246'rjade hyror:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRPHyror: TQRLabel
          Left = 224
          Top = 456
          Width = 60
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            1206.5
            158.75)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRPHyror'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel9: TQRLabel
          Left = 80
          Top = 488
          Width = 107
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            211.666666666667
            1291.16666666667
            283.104166666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Antal '#246'ppna hyror:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QROHyror: TQRLabel
          Left = 224
          Top = 488
          Width = 61
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            592.666666666667
            1291.16666666667
            161.395833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QROHyror'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel8: TQRLabel
          Left = 104
          Top = 544
          Width = 57
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            275.166666666667
            1439.33333333333
            150.8125)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Pristyper:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel10: TQRLabel
          Left = 304
          Top = 544
          Width = 82
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            804.333333333333
            1439.33333333333
            216.958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Objektsgrupp:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel11: TQRLabel
          Left = 504
          Top = 544
          Width = 42
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            1333.5
            1439.33333333333
            111.125)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Till'#228'gg:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRShape4: TQRShape
          Left = 96
          Top = 560
          Width = 73
          Height = 1
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            2.64583333333333
            254
            1481.66666666667
            193.145833333333)
          Shape = qrsRectangle
        end
        object QRShape5: TQRShape
          Left = 296
          Top = 560
          Width = 97
          Height = 1
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            2.64583333333333
            783.166666666667
            1481.66666666667
            256.645833333333)
          Shape = qrsRectangle
        end
        object QRShape6: TQRShape
          Left = 496
          Top = 560
          Width = 57
          Height = 1
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            2.64583333333333
            1312.33333333333
            1481.66666666667
            150.8125)
          Shape = qrsRectangle
        end
      end
      object QRBand2: TQRBand
        Left = 38
        Top = 993
        Width = 718
        Height = 88
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = True
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          232.833333333333
          1899.70833333333)
        BandType = rbPageFooter
        object QRDBText1: TQRDBText
          Left = 56
          Top = 16
          Width = 56
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            148.166666666667
            42.3333333333333
            148.166666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = Dmod2.CompanyT
          DataField = 'Company'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRDBText2: TQRDBText
          Left = 56
          Top = 40
          Width = 21
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            148.166666666667
            105.833333333333
            55.5625)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = Dmod2.CompanyT
          DataField = 'Adr'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRDBText3: TQRDBText
          Left = 56
          Top = 64
          Width = 37
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            148.166666666667
            169.333333333333
            97.8958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = Dmod2.CompanyT
          DataField = 'PoAdr'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRShape3: TQRShape
          Left = 0
          Top = 8
          Width = 721
          Height = 1
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            2.64583333333333
            0
            21.1666666666667
            1907.64583333333)
          Shape = qrsRectangle
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 723
      Height = 185
      Align = alTop
      TabOrder = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 297
        Height = 169
        Caption = 'Information'
        TabOrder = 0
        object Label5: TLabel
          Left = 200
          Top = 40
          Width = 3
          Height = 13
        end
        object Label6: TLabel
          Left = 200
          Top = 64
          Width = 3
          Height = 13
        end
        object PStat: TPanel
          Left = 2
          Top = 15
          Width = 293
          Height = 152
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Label16: TLabel
            Left = 8
            Top = 8
            Width = 91
            Height = 13
            Caption = 'Antal objektsdagar:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 104
            Top = 8
            Width = 32
            Height = 13
            Caption = 'Label7'
          end
          object Label17: TLabel
            Left = 152
            Top = 8
            Width = 102
            Height = 13
            Caption = 'Antal avslutade hyror:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 256
            Top = 8
            Width = 32
            Height = 13
            Caption = 'Label8'
          end
          object Label18: TLabel
            Left = 8
            Top = 32
            Width = 82
            Height = 13
            Caption = 'Antal hyresdagar:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 96
            Top = 32
            Width = 38
            Height = 13
            Caption = 'Label11'
          end
          object Label20: TLabel
            Left = 8
            Top = 56
            Width = 78
            Height = 13
            Caption = 'Utnyttjandegrad:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 88
            Top = 56
            Width = 38
            Height = 13
            Caption = 'Label12'
          end
          object Label19: TLabel
            Left = 8
            Top = 80
            Width = 80
            Height = 13
            Caption = 'Nettooms'#228'ttning:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 88
            Top = 80
            Width = 38
            Height = 13
            Caption = 'Label10'
          end
          object Label23: TLabel
            Left = 8
            Top = 104
            Width = 80
            Height = 13
            Caption = 'Int'#228'kt per objekt:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 88
            Top = 104
            Width = 38
            Height = 13
            Caption = 'Label14'
          end
          object Label28: TLabel
            Left = 152
            Top = 123
            Width = 86
            Height = 13
            Caption = 'Antal '#246'ppna hyror:'
          end
          object Label29: TLabel
            Left = 240
            Top = 123
            Width = 38
            Height = 13
            Caption = 'Label29'
          end
          object Label26: TLabel
            Left = 152
            Top = 104
            Width = 103
            Height = 13
            Caption = 'Antal p'#229'b'#246'rjade hyror:'
          end
          object Label27: TLabel
            Left = 256
            Top = 104
            Width = 38
            Height = 13
            Caption = 'Label27'
          end
          object Label24: TLabel
            Left = 152
            Top = 80
            Width = 88
            Height = 13
            Caption = 'Totalt antal objekt:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 240
            Top = 80
            Width = 38
            Height = 13
            Caption = 'Label15'
          end
          object Label22: TLabel
            Left = 152
            Top = 56
            Width = 94
            Height = 13
            Caption = 'Int'#228'kt per hyresdag:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 248
            Top = 56
            Width = 38
            Height = 13
            Caption = 'Label13'
          end
          object Label21: TLabel
            Left = 152
            Top = 32
            Width = 83
            Height = 13
            Caption = 'Hyresl'#228'ngd i snitt:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 240
            Top = 32
            Width = 32
            Height = 13
            Caption = 'Label9'
          end
          object Label25: TLabel
            Left = 120
            Top = 56
            Width = 8
            Height = 13
            Caption = '%'
          end
        end
        object PKund: TPanel
          Left = 2
          Top = 15
          Width = 293
          Height = 152
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 27
            Top = 40
            Width = 3
            Height = 13
          end
          object Label2: TLabel
            Left = 27
            Top = 64
            Width = 3
            Height = 13
          end
          object Label4: TLabel
            Left = 27
            Top = 96
            Width = 3
            Height = 13
          end
          object Label3: TLabel
            Left = 27
            Top = 80
            Width = 3
            Height = 13
          end
        end
      end
      object GBPris: TGroupBox
        Left = 304
        Top = 8
        Width = 185
        Height = 169
        Caption = 'Pristyper'
        TabOrder = 1
        object LB: TListBox
          Left = 2
          Top = 15
          Width = 181
          Height = 152
          Style = lbOwnerDrawFixed
          Align = alClient
          BorderStyle = bsNone
          Color = clMenu
          ItemHeight = 20
          TabOrder = 0
        end
      end
      object GBObj: TGroupBox
        Left = 488
        Top = 8
        Width = 185
        Height = 169
        Caption = 'Objektsgrupper'
        TabOrder = 2
        object LBO: TListBox
          Left = 2
          Top = 15
          Width = 181
          Height = 152
          Style = lbOwnerDrawVariable
          Align = alClient
          BorderStyle = bsNone
          Color = clMenu
          ItemHeight = 20
          TabOrder = 0
        end
      end
      object GB2: TGroupBox
        Left = 672
        Top = 8
        Width = 185
        Height = 169
        Caption = 'Till'#228'gg'
        TabOrder = 3
        object LBTill: TListBox
          Left = 2
          Top = 15
          Width = 181
          Height = 152
          Style = lbOwnerDrawVariable
          Align = alClient
          BorderStyle = bsNone
          Color = clSilver
          ItemHeight = 20
          TabOrder = 0
        end
      end
    end
  end
  object PAObjST: TPanel
    Left = 150
    Top = 0
    Width = 723
    Height = 380
    Align = alClient
    TabOrder = 0
    Visible = False
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 721
      Height = 168
      Align = alTop
      Anchors = [akTop, akRight]
      Caption = 'GroupBox2'
      TabOrder = 0
      object Label30: TLabel
        Left = 16
        Top = 24
        Width = 38
        Height = 13
        Caption = 'Label30'
      end
      object Label31: TLabel
        Left = 16
        Top = 41
        Width = 38
        Height = 13
        Caption = 'Label31'
      end
      object Label32: TLabel
        Left = 16
        Top = 59
        Width = 38
        Height = 13
        Caption = 'Label32'
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 169
      Width = 721
      Height = 210
      Align = alClient
      TabOrder = 1
      object DBGrid2: TDBGrid
        Left = 1
        Top = 1
        Width = 719
        Height = 208
        Align = alClient
        Color = clMenu
        DataSource = QStatS
        Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object ImageList1: TImageList
    Left = 584
    Top = 22
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001001000000000000018
      000000000000000000000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000
      000000000000000000000000000000000000F75EF75EF75E0000F75E0000F75E
      0000F75E0000F75E0000F75E0000F75E00000000000000000000000000000000
      00000000000000000000F75EF75EF75EF75E0000000000000000000000000000
      00000000000000000000000000000000F75EF75EF75EF75E0000F75EFF7FF75E
      FF7FF75EFF7FF75EFF7FF75EFF7FF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07F0000F75EF75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07FF75EE07FF75E0000F75EF75EF75EF75E0000FF7F00000000
      0000000000000000000000000000FF7F0000F75EF75EF75E0000F75EF75E0000
      F75E0000F75E0000F75E0000F75EF75E00000000E07FF75EE07FF75EE07FF75E
      E07FF75EE07FF75E0000F75EF75EF75EF75E0000E07FF75EE07FF75EE07FF75E
      E07FF75EE07FF75EE07FF75EE07F0000F75EF75EF75EF75E0000F75EFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07F0000F75EF75EF75EF75E0000F75EE07FF75EE07F00000000
      0000000000000000F75EE07FF75E0000F75EF75EF75EF75E0000FF7F00000000
      0000000000000000000000000000FF7F0000F75EF75EF75E0000F75EF75E0000
      F75E0000F75E0000F75E0000F75EF75E00000000E07FF75EE07FF75EE07FF75E
      E07FF75EE07FF75E0000F75EF75EF75EF75E0000E07FF75EE07FF75E0000F75E
      E07FF75EE07FF75EE07FF75EE07F0000F75E0000F75EF75E0000F75EFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07F0000F75EF75E0000F75E0000F75EE07FF75EE07F0000E07F
      F75EE07FF75EE07FF75EE07FF75E0000F75EF75E0000F75E0000FF7F0000FF7F
      F75EFF7FF75EFF7FE001E001E001FF7F0000F75EF75EF75E0000F75EF75EF75E
      F75EF75EF75E0000F75E0000F75EF75E00000000E07FF75EE07FF75EE07FF75E
      E07FF75EE07FF75E0000F75E0000F75EF75E0000E07FF75E0000000000000000
      0000F75EE07FF75EE07FF75EE07F0000F75EF75EF75E000000000000FF7FF75E
      FF7FF75EFF7FF75EE003E003E003F75E0000007C007CF75EF75E007C007CF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07F00000000F75EF75EF75E0000F75EE07FF75E000000000000
      F75EE07FF75EE07FF75EE07FF75E0000F75E00000000F75EF75E000000000000
      000000000000000000000000000000000000F75E007C007C007C007CF75EF75E
      0000F75E0000F75E0000F75E0000F75E00000000000000000000000000000000
      0000000000000000F75EF75E0000F75E00000000E07FF75EE07FF75E0000F75E
      E07FF75EE07FF75EE07FF75EE07F0000F75EF75EF75E0000F75E0000F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E007C007CF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000E07FF75EE07FF75E0000
      F75EF75EF75E0000F75E0000F75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07FF75EE07FF75E0000F75EF75E0000F75E0000F75E0000F75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E007C007C007C007CF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000F75E
      F75EF75E0000F75E0000F75E0000F75EF75E0000000000000000000000000000
      0000000000000000000000000000F75EF75E0000F75EF75EF75EF75EF75E0000
      F75EF75EF75EF75EF75EF75EF75EF75EF75E007C007CF75EF75E007C007CF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75E0000F75EF75EF75EF75EF75E0000F75EF75E0000E07FF75EE07FF75EE07F
      0000F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E0000F75EF75EF75EF75EF75EF75E00000000000000000000
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E0000F75EF75EF75EF75E0000000000000000000000000000
      000000000000000000000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000000000000000
      0000000000000000000000000000000000000F000F000F000F000F000F000F00
      0F000F00F75EF75EF75EF75E003CF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75E00000000000000000000F75EEF3D
      EF3D000000000000000000000000000000000F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75EF75E003C003C003CF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E003C003C003CF75E0F000F000F000F000F000F000F00
      0F00F75EF75EF75EF75E003C003C003CF75E000000000000F75EF75EEF3DEF3D
      0000EF3DEF3D0000000000000000000000000F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75E003C003C003C003C003CF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E003C003C003C003C003C0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00F75EF75EF75E003C003C003C003C003C0000F75EF75EEF3DF75EEF3DEF3D
      EF3DEF3D0000EF3DEF3D00000000000000000F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75EF75E000000000000000000000000
      000000000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00F75EF75EF75EF75EF75E003CF75EF75EEF3DEF3DF75EF75EF75EEF3DEF3D
      EF3DEF3DEF3DEF3D0000EF3D0000000000000F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      000000000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F000F000F000F00F75EF75E003CF75EF75EFF7FEF3DF75EF75EF75EEF3DEF3D
      EF3DEF3DEF3DEF3DEF3DEF3D0000000000000F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75E0000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F00000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00E07FFF7F0F00F75EF75E003CF75EF75EFF7FEF3DF75EF75EFF7FF75EEF3D
      F75EEF3DEF3DEF3DEF3DEF3DEF3DEF3D00000F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75E0000FF7FFF7F0F00FF7F0F000F00
      FF7F00000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00FF7FE07F0F00F75EF75E003CF75EF75EFF7FEF3DFF7FF75E007CF75EEF3D
      F75EEF3DF75EEF3DEF3DEF3DEF3DF75EEF3D0F00FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75E0000FF7FFF7F0F00FF7F0F00FF7F
      FF7F00000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7F0F000F000F00
      0F00E07FFF7F0F00F75EF75E003CF75EF75EEF3DF75EEF3DF75EEF3DF75EF75E
      F75E0000F75EEF3DF75EEF3DEF3D000000000F000F000F000F000F000F000F00
      0F000F00F75EF75EF75EF75E003CF75EF75E0000FF7F0F000F00FF7FFF7F0F00
      FF7F00000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7F0F00FF7F0F00
      E07FFF7FE07F0F00F75EF75E003CF75EF75E00000000EF3DF75EEF3DEF3D0000
      FF7F1F00FF7F0000F75EEF3D000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75E0000FF7FFF7F0F00FF7F0F000F00
      FF7F00000000F75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7F0F000F00E07F
      FF7FE07FFF7F0F00F75EF75E003CF75EF75E0000000000000000EF3DF75EEF3D
      FF7FFF7F1F00F75E00000000000000000000F75EF75EF75EF75EF75E0F000F00
      0F000F00F75EF75EF75EF75E003CF75EF75E0000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F00000000F75EF75EF75E003CF75EF75E0F000F000F000F000F00E07FFF7F
      0F000F000F000F00F75EF75E003CF75EF75E000000000000000000000000EF3D
      FF7FFF7F1F00FF7FF75E0000000000000000F75EF75EF75EF75EF75E0F00FF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      000000000000F75EF75EF75E003CF75EF75EF75EF75EF75E0F00E07FFF7FE07F
      0F00E07F0F00F75EF75EF75E003CF75EF75E0000000000000000000000000000
      EF3DFF7FFF7F1F00FF7FF75E000000000000F75EF75EF75EF75EF75E0F00FF7F
      FF7F0F00F75EF75EF75EF75E003CF75EF75E00000F000F000F000F000F000F00
      0F0000000000F75EF75EF75E003CF75EF75EF75EF75EF75E0F00FF7FE07FFF7F
      0F000F00F75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      0000EF3DFF7FFF7FFF7FEF3D000000000000F75EF75EF75EF75EF75E0F000F00
      0F000F00F75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      00000000F75EF75EF75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      00000000EF3DEF3D00000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000EF3DEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      F75EF75E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      EF3DEF010000EF3DEF3D0000000000000000000000000000000000000000007C
      003C003C0000000000000000000000000000FF7FF75EF75EF75EF75EF75EF75E
      F75EF75E0000F75EF75EF75EF75EF75E00000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000EF3DEF3D
      EF3DEF01EF010000EF3DEF3D0000000000000000000000000000007C007C007C
      EF01003C0F3C0F3C00000000000000000000FF7FF75EF75EF75E0000F75EF75E
      F75EF75EF75EF75E0000F75EF75EF75E00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3DEF3DEF3D
      EF3DEF01EF01EF01EF3DEF3DEF3D0000000000000000007C007C007CEF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7FF75EF75EE07F0000F75EF75E
      F75EF75EF75EF75E0000F75EF75EF75E00000000000000000000EF3D00000000
      000000000000000000000000EF3D000000000000000000000000EF3DEF3DEF3D
      EF3DEF01EF01EF010000EF3DEF3D00000000007C007C007C0F001F00EF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7FF75E0000E07F0000F75E0000
      F75EF75EF75EF75E00000000F75EF75E00000000000000000000000000000000
      00000000000000000000FF7F00000000EF3D0000000000000000EF3DEF3DEF3D
      EF3DEF01EF01EF01EF010000000000000000007C007C007C1F001F00EF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7FF75EE07F000000000000F75E
      00000000F75E00000000E07FF75EF75E00000000007C00000000007C007C007C
      007C007C007C007C000000000000007CEF3D000000000000EF3DEF3DEF3DEF01
      00000000EF01EF01EF010000000000000000007C007C007C1F001F00EF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7F0000E07FE07F0000F75EF75E
      F75EF75EF75EF75EE07FE07F0000F75E00000000E07FE07FE07FE07FE07FE07F
      E07FE07FE07FE07F0000E07F00000000EF3D000000000000EF3DEF0100000000
      EF3DEF3D0000EF01EF010000000000000000007C007C007CE001E003EF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7F0000E07FE07F0000F75EF75E
      0000F75EF75EF75EE07F00000000F75E00000000000000000000000000000000
      0000000000000000000000000000E07FEF3D000000000000EF0100000000EF3D
      F75E0000EF3D0000EF010000000000000000007C007C007CE003E003EF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7F0000E07FE07F0000F75E0000
      0000F75E0000F75EE07F00000000F75E00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3DF75E0000
      0000E03D0000EF3D0000EF01000000000000007C007C007CE003E003EF01FF03
      FF03EF010F3C0F3C00000000000000000000FF7F0000E07F0000E07FF75E0000
      F75EF75E0000F75EE07FE07F0000F75E00000000000000000000000000000000
      000000000000000000000000000000000000000000000000E07FE07F0000EF3D
      00000000EF3D0000EF3D0000000000000000007C007C007CE003E003EF01FF03
      FF03EF010F3C0F3C00000000000000000000F75EF75E0000E07FE07FE07F0000
      0000F75E0000E07F0000E07FEF3DEF3D00000000000000000000000000000000
      00000000000000000000000000000000000000000000F75EE03D0000EF3DEF3D
      003C0000EF3DF75E00000000000000000000007C007C007CE001E003EF01EF01
      FF03FF030F3C0F3C000000000000000000000000FF7FF75EE07FE07FE07FE07F
      E07FE07FE07F0000E07F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FF75EF75E0000EF3DFF7F
      003C0000E03DE03DE07F0000EF3D00000000007C003C1F7CE001E001EF01FF03
      EF011F7C1F7C0F3C0000000000000000000000000000EF3DEF3DE07FE07FE07F
      E07FE07FE07FE07FE07F00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF7F0000F75EF75E
      FF7F0000E03DF75E000000000000000000001F7C007C003CE07FE07F00000000
      0F3C0F3C0000E003F75E000000000000000000000000000000000000E07FE07F
      E07FE07FE07FE07FE07F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      EF3D0000FF7FF75E0000000000000000000000000000E07FE03D0000003C003C
      00000000E003F75E000000000000000000000000000000000000000000000000
      E07FE07FE07F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      EF3D0000000000000000000000000000000000000000FF7FE07F003C003C0000
      0000E001F75E000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0014F52E010DE2CC7F0000000000000000
      7723CB7F0000000000000000000004000000040068F72E01B4E2CC7F00000000
      50576081D8F42E0120F94300C5B9F7BF3694CC7F6CD04D8200000000D8F42E01
      20F943006CD04D826DCFCB7F684E4300FE22CB7F684E43000CE0FC7F94F42E01
      0CE0FC7F684E4300684E43001A23CB7FFFFF430000000000FDFF2E01DB14F27F
      F07F0000644E4300C01F43000000000000074300000000000003F7BF26B3F7BF
      000376D750F42E0100016081644E430000002E0150F42E0100034300209976D7
      C0070000AC766081F01F430000000000FC0F430000004300FE03000000000000
      FF074300E44E4300FF9F0000A0A3F7BFFE7FFFFFFF1FFEFF0001FFFFFC0FF83F
      0000FFFFF007E01F0000FFFFF003801F0000C7F3E003001F00000000E00F001F
      00000000E00F001F00000000C007001F00000000C007001F00002AA9C007001F
      400000038007001F000180078003001F8007FFFF0003001FC007FFFFC007004F
      F00FFFFFF81FC19FF81FFFFFFC1FC33F00000000000000000000000000000000
      000000000000}
  end
  object QStatS: TDataSource
    DataSet = QStat
    Left = 508
    Top = 16
  end
  object QStat: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 428
    Top = 16
  end
  object Kstat: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 389
    Top = 17
  end
  object KstatS: TDataSource
    DataSet = Kstat
    Left = 469
    Top = 17
  end
  object StatQ: TADOQuery
    Connection = Dmod1.ADOConnection1
    Parameters = <>
    Left = 354
    Top = 17
  end
  object Od1: TOpenDialog
    Filter = 'Lista|*.txt'
    Left = 546
    Top = 18
  end
end
