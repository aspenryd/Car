object FrmReg: TFrmReg
  Left = 211
  Top = 174
  BorderStyle = bsSingle
  ClientHeight = 465
  ClientWidth = 734
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object tab1: TPageControl
    Left = 0
    Top = 0
    Width = 734
    Height = 465
    ActivePage = TabSheet1
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TabStop = False
    OnChange = tab1Change
    object TabSheet1: TTabSheet
      Caption = '&Inst'#228'llningar'
      ImageIndex = 7
      object Label57: TLabel
        Left = 16
        Top = 8
        Width = 20
        Height = 13
        Caption = 'Titel'
      end
      object Label55: TLabel
        Left = 16
        Top = 48
        Width = 38
        Height = 13
        Caption = 'Startbild'
      end
      object Label14: TLabel
        Left = 16
        Top = 88
        Width = 88
        Height = 13
        Caption = 'Startbild ACar2000'
      end
      object Label15: TLabel
        Left = 16
        Top = 128
        Width = 33
        Height = 13
        Caption = 'Avi film'
      end
      object Label92: TLabel
        Left = 280
        Top = 48
        Width = 124
        Height = 13
        Caption = 'V'#228'lj Printer (Avtal / Kvitto):'
      end
      object Label93: TLabel
        Left = 280
        Top = 88
        Width = 109
        Height = 13
        Caption = 'V'#228'lj Printer (Rapporter):'
      end
      object EdtTitel: TEdit
        Left = 16
        Top = 21
        Width = 113
        Height = 21
        TabOrder = 0
      end
      object EdtSBild: TEdit
        Left = 16
        Top = 62
        Width = 225
        Height = 21
        TabOrder = 1
      end
      object Button2: TButton
        Left = 240
        Top = 62
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 2
        OnClick = Button2Click
      end
      object Edit1: TEdit
        Left = 16
        Top = 102
        Width = 225
        Height = 21
        TabOrder = 3
      end
      object Button3: TButton
        Left = 240
        Top = 102
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = Button3Click
      end
      object EdtAvi: TEdit
        Left = 16
        Top = 144
        Width = 225
        Height = 21
        TabOrder = 5
      end
      object Button1: TButton
        Left = 240
        Top = 144
        Width = 23
        Height = 22
        Caption = '...'
        TabOrder = 6
        OnClick = Button1Click
      end
      object ComboBox1: TComboBox
        Left = 280
        Top = 62
        Width = 233
        Height = 21
        ItemHeight = 13
        TabOrder = 7
      end
      object ComboBox2: TComboBox
        Left = 280
        Top = 102
        Width = 233
        Height = 21
        ItemHeight = 13
        TabOrder = 8
      end
    end
    object tbcompany: TTabSheet
      Tag = 5
      Caption = '&Firma'
      ImageIndex = 9
      OnExit = tbcompanyExit
      object PaFirma: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label20: TLabel
          Left = 16
          Top = 12
          Width = 67
          Height = 13
          Caption = 'F'#246'retagsnamn'
        end
        object Label18: TLabel
          Left = 16
          Top = 52
          Width = 32
          Height = 13
          Caption = 'Adress'
        end
        object Label17: TLabel
          Left = 16
          Top = 92
          Width = 52
          Height = 13
          Caption = 'Postadress'
        end
        object Label16: TLabel
          Left = 16
          Top = 132
          Width = 24
          Height = 13
          Caption = 'Tele:'
        end
        object Label23: TLabel
          Left = 16
          Top = 172
          Width = 20
          Height = 13
          Caption = 'Fax:'
        end
        object Label21: TLabel
          Left = 232
          Top = 132
          Width = 55
          Height = 13
          Caption = 'Moms regnr'
        end
        object Label25: TLabel
          Left = 232
          Top = 92
          Width = 42
          Height = 13
          Caption = 'Bankgiro'
        end
        object Label24: TLabel
          Left = 232
          Top = 52
          Width = 38
          Height = 13
          Caption = 'Postgiro'
        end
        object Label19: TLabel
          Left = 232
          Top = 12
          Width = 34
          Height = 13
          Caption = 'Org Nr:'
        end
        object DBEdit9: TDBEdit
          Left = 16
          Top = 28
          Width = 201
          Height = 21
          DataField = 'Company'
          DataSource = Dmod2.CompanyS
          TabOrder = 0
        end
        object DBEdit20: TDBEdit
          Left = 16
          Top = 68
          Width = 201
          Height = 21
          DataField = 'Adr'
          DataSource = Dmod2.CompanyS
          TabOrder = 1
        end
        object DBEdit16: TDBEdit
          Left = 16
          Top = 108
          Width = 201
          Height = 21
          Hint = 'Postnummer'
          DataField = 'PoAdr'
          DataSource = Dmod2.CompanyS
          TabOrder = 2
        end
        object DBEdit13: TDBEdit
          Left = 16
          Top = 148
          Width = 65
          Height = 21
          DataField = 'T_Area'
          DataSource = Dmod2.CompanyS
          TabOrder = 3
        end
        object DBEdit14: TDBEdit
          Left = 16
          Top = 188
          Width = 65
          Height = 21
          DataField = 'Fax_Area'
          DataSource = Dmod2.CompanyS
          TabOrder = 5
        end
        object DBEdit19: TDBEdit
          Left = 100
          Top = 188
          Width = 117
          Height = 21
          DataField = 'Fax_No'
          DataSource = Dmod2.CompanyS
          TabOrder = 6
        end
        object DBEdit18: TDBEdit
          Left = 100
          Top = 148
          Width = 117
          Height = 21
          DataField = 'T_No'
          DataSource = Dmod2.CompanyS
          TabOrder = 4
        end
        object DBEdit21: TDBEdit
          Left = 232
          Top = 148
          Width = 201
          Height = 21
          DataField = 'MOMS_NR'
          DataSource = Dmod2.CompanyS
          TabOrder = 10
        end
        object DBEdit12: TDBEdit
          Left = 232
          Top = 108
          Width = 201
          Height = 21
          DataField = 'BANKGIRO'
          DataSource = Dmod2.CompanyS
          TabOrder = 9
        end
        object DBEdit17: TDBEdit
          Left = 232
          Top = 68
          Width = 201
          Height = 21
          Hint = 'Postort'
          DataField = 'POSTGIRO'
          DataSource = Dmod2.CompanyS
          TabOrder = 8
        end
        object DBEdit10: TDBEdit
          Left = 232
          Top = 28
          Width = 149
          Height = 21
          DataField = 'ORG_NR'
          DataSource = Dmod2.CompanyS
          TabOrder = 7
        end
        object PaFirmaGrid: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 11
          Visible = False
          object DBGrid6: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.CompanyS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid6CellClick
            OnKeyUp = DBGrid6KeyUp
          end
        end
      end
    end
    object tbparam: TTabSheet
      Tag = 6
      Caption = 'P&aram'
      ImageIndex = 10
      OnExit = tbparamExit
      object PaParam: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 8
          Width = 74
          Height = 13
          Caption = 'Kund Idnummer'
        end
        object Label31: TLabel
          Left = 16
          Top = 40
          Width = 82
          Height = 13
          Caption = 'Kontraktsnummer'
        end
        object Label29: TLabel
          Left = 16
          Top = 72
          Width = 63
          Height = 13
          Caption = 'Offertnummer'
        end
        object Label28: TLabel
          Left = 16
          Top = 104
          Width = 47
          Height = 13
          Caption = 'Momssats'
        end
        object Label13: TLabel
          Left = 16
          Top = 136
          Width = 62
          Height = 13
          Caption = 'Minutintervall'
        end
        object Label58: TLabel
          Left = 16
          Top = 168
          Width = 73
          Height = 13
          Caption = 'Objektsnummer'
        end
        object Label59: TLabel
          Left = 16
          Top = 200
          Width = 51
          Height = 13
          Caption = 'Kontant Nr'
        end
        object Label68: TLabel
          Left = 16
          Top = 232
          Width = 59
          Height = 13
          Caption = 'Kreditkort Nr'
        end
        object Label30: TLabel
          Left = 16
          Top = 264
          Width = 50
          Height = 13
          Caption = 'Faktura Nr'
        end
        object Label69: TLabel
          Left = 16
          Top = 296
          Width = 47
          Height = 13
          Caption = 'Interna Nr'
        end
        object Label12: TLabel
          Left = 280
          Top = 8
          Width = 62
          Height = 13
          Caption = 'Telefontyp 1:'
        end
        object Label11: TLabel
          Left = 280
          Top = 40
          Width = 62
          Height = 13
          Caption = 'Telefontyp 2:'
        end
        object Label4: TLabel
          Left = 280
          Top = 72
          Width = 62
          Height = 13
          Caption = 'Telefontyp 3:'
        end
        object Label3: TLabel
          Left = 280
          Top = 104
          Width = 86
          Height = 13
          Caption = 'Standard betals'#228'tt'
        end
        object Label2: TLabel
          Left = 280
          Top = 136
          Width = 98
          Height = 13
          Caption = 'Iordningsst'#228'ller bil p'#229
        end
        object Label38: TLabel
          Left = 280
          Top = 168
          Width = 84
          Height = 13
          Caption = 'Anpassa mindr '#228'n'
        end
        object Label34: TLabel
          Left = 280
          Top = 200
          Width = 83
          Height = 13
          Caption = 'Gr'#228'ns f'#246'r timuppr.'
        end
        object Label56: TLabel
          Left = 280
          Top = 232
          Width = 98
          Height = 13
          Caption = 'Gr'#228'ns f'#246'r dygnsuppr.'
        end
        object Label70: TLabel
          Left = 280
          Top = 272
          Width = 101
          Height = 13
          Caption = '% till Objektkalendern'
        end
        object Label74: TLabel
          Left = 280
          Top = 304
          Width = 56
          Height = 13
          Caption = 'Start Datum'
        end
        object Label60: TLabel
          Left = 424
          Top = 240
          Width = 33
          Height = 13
          Caption = ' timmar'
        end
        object Label33: TLabel
          Left = 424
          Top = 208
          Width = 19
          Height = 13
          Caption = ' min'
        end
        object Label37: TLabel
          Left = 424
          Top = 176
          Width = 102
          Height = 13
          Caption = ' timmars '#246'verlappning'
        end
        object Label32: TLabel
          Left = 424
          Top = 144
          Width = 22
          Height = 13
          Caption = ' min '
        end
        object DBEdit1: TDBEdit
          Left = 104
          Top = 8
          Width = 73
          Height = 21
          DataField = 'KUNDID'
          DataSource = Dmod2.ParamS
          TabOrder = 0
        end
        object DBEdit15: TDBEdit
          Left = 104
          Top = 72
          Width = 73
          Height = 21
          DataField = 'OffertNr'
          DataSource = Dmod2.ParamS
          TabOrder = 2
        end
        object DBEdit22: TDBEdit
          Left = 104
          Top = 104
          Width = 73
          Height = 21
          DataField = 'MOMS'
          DataSource = Dmod2.ParamS
          TabOrder = 3
        end
        object DBEdit23: TDBEdit
          Left = 104
          Top = 136
          Width = 73
          Height = 21
          DataField = 'MINUT_INTERVALL'
          DataSource = Dmod2.ParamS
          TabOrder = 4
        end
        object GroupBox5: TGroupBox
          Left = 0
          Top = 326
          Width = 537
          Height = 107
          Caption = 'Utskriftsexemplar'
          TabOrder = 20
          object Label61: TLabel
            Left = 8
            Top = 24
            Width = 88
            Height = 13
            Caption = 'Antal ex av Offert :'
          end
          object Label63: TLabel
            Left = 8
            Top = 48
            Width = 120
            Height = 13
            Caption = 'Antal ex av Kontantnota :'
          end
          object Label64: TLabel
            Left = 8
            Top = 72
            Width = 115
            Height = 13
            Caption = 'Antal ex av Bekr'#228'ftelse :'
          end
          object Label65: TLabel
            Left = 272
            Top = 24
            Width = 102
            Height = 13
            Caption = 'Antal ex av Kontrakt :'
          end
          object Label66: TLabel
            Left = 272
            Top = 48
            Width = 98
            Height = 13
            Caption = 'Antal ex av Faktura :'
          end
          object Label67: TLabel
            Left = 272
            Top = 72
            Width = 139
            Height = 13
            Caption = 'Antal ex av Fakturaunderlag :'
          end
          object DBEdit33: TDBEdit
            Left = 136
            Top = 24
            Width = 41
            Height = 21
            DataField = 'OFFERT_COPY'
            DataSource = Dmod2.ParamS
            TabOrder = 0
          end
          object DBEdit34: TDBEdit
            Left = 136
            Top = 48
            Width = 41
            Height = 21
            DataField = 'KONTANT_COPY'
            DataSource = Dmod2.ParamS
            TabOrder = 1
          end
          object DBEdit35: TDBEdit
            Left = 136
            Top = 72
            Width = 41
            Height = 21
            DataField = 'BEKR_COPY'
            DataSource = Dmod2.ParamS
            TabOrder = 2
          end
          object DBEdit36: TDBEdit
            Left = 416
            Top = 24
            Width = 41
            Height = 21
            DataField = 'KONTRAKT_COPY'
            DataSource = Dmod2.ParamS
            TabOrder = 3
          end
          object DBEdit37: TDBEdit
            Left = 416
            Top = 48
            Width = 41
            Height = 21
            DataField = 'FAKTURA_COPY'
            DataSource = Dmod2.ParamS
            TabOrder = 4
          end
          object DBEdit40: TDBEdit
            Left = 416
            Top = 72
            Width = 41
            Height = 21
            DataField = 'UNDER_COPY'
            DataSource = Dmod2.ParamS
            TabOrder = 5
          end
        end
        object DBEdit41: TDBEdit
          Left = 104
          Top = 296
          Width = 73
          Height = 21
          DataField = 'InternNr'
          DataSource = Dmod2.ParamS
          TabOrder = 9
        end
        object DBEdit11: TDBEdit
          Left = 104
          Top = 264
          Width = 73
          Height = 21
          DataField = 'FAKTNR'
          DataSource = Dmod2.ParamS
          TabOrder = 8
        end
        object DBEdit61: TDBEdit
          Left = 104
          Top = 232
          Width = 73
          Height = 21
          DataField = 'FBOLAGNR'
          DataSource = Dmod2.ParamS
          TabOrder = 7
        end
        object DBEdit62: TDBEdit
          Left = 104
          Top = 200
          Width = 73
          Height = 21
          DataField = 'KNOTENR'
          DataSource = Dmod2.ParamS
          TabOrder = 6
        end
        object DBEdit32: TDBEdit
          Left = 104
          Top = 168
          Width = 73
          Height = 21
          DataField = 'ObjNr'
          DataSource = Dmod2.ParamS
          TabOrder = 5
        end
        object DBEdit67: TDBEdit
          Left = 384
          Top = 304
          Width = 41
          Height = 21
          DataField = 'SDate'
          DataSource = Dmod2.ParamS
          TabOrder = 19
        end
        object DBEdit63: TDBEdit
          Left = 384
          Top = 272
          Width = 41
          Height = 21
          DataField = 'ObjKProcent'
          DataSource = Dmod2.ParamS
          TabOrder = 18
        end
        object DBEdit31: TDBEdit
          Left = 384
          Top = 232
          Width = 41
          Height = 21
          DataField = 'TimFrist'
          DataSource = Dmod2.ParamS
          TabOrder = 17
        end
        object DBEdit30: TDBEdit
          Left = 384
          Top = 200
          Width = 41
          Height = 21
          DataField = 'MinutFrist'
          DataSource = Dmod2.ParamS
          TabOrder = 16
        end
        object DBEdit29: TDBEdit
          Left = 384
          Top = 168
          Width = 41
          Height = 21
          DataField = 'AnpassTid'
          DataSource = Dmod2.ParamS
          TabOrder = 15
        end
        object DBEdit28: TDBEdit
          Left = 384
          Top = 136
          Width = 41
          Height = 21
          DataField = 'ClearTid'
          DataSource = Dmod2.ParamS
          TabOrder = 14
        end
        object DBEdit27: TDBEdit
          Left = 384
          Top = 104
          Width = 41
          Height = 21
          DataField = 'DEF_BETSATT'
          DataSource = Dmod2.ParamS
          TabOrder = 13
        end
        object DBEdit26: TDBEdit
          Left = 384
          Top = 72
          Width = 41
          Height = 21
          DataField = 'TEL_3'
          DataSource = Dmod2.ParamS
          TabOrder = 12
        end
        object DBEdit25: TDBEdit
          Left = 384
          Top = 40
          Width = 41
          Height = 21
          DataField = 'TEL_2'
          DataSource = Dmod2.ParamS
          TabOrder = 11
        end
        object DBEdit24: TDBEdit
          Left = 384
          Top = 8
          Width = 41
          Height = 21
          DataField = 'TEL_1'
          DataSource = Dmod2.ParamS
          TabOrder = 10
        end
        object DBEdit2: TDBEdit
          Left = 104
          Top = 40
          Width = 73
          Height = 21
          DataField = 'KONTRNR'
          DataSource = Dmod2.ParamS
          TabOrder = 1
        end
        object PaParamGrid: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 21
          Visible = False
          object DBGrid7: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.ParamS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid7CellClick
            OnKeyUp = DBGrid7KeyUp
          end
        end
      end
    end
    object tbObjectTypes: TTabSheet
      Tag = 1
      Caption = '&Objektstyper'
      ImageIndex = 3
      OnExit = tbObjectTypesExit
      object PaObjTyp: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label35: TLabel
          Left = 12
          Top = 4
          Width = 55
          Height = 13
          Caption = 'Typnummer'
        end
        object Label5: TLabel
          Left = 12
          Top = 52
          Width = 95
          Height = 13
          Caption = 'Antal '#246'verbokningar'
        end
        object Label8: TLabel
          Left = 12
          Top = 80
          Width = 95
          Height = 13
          Caption = 'Antal '#246'verbokningar'
        end
        object Label22: TLabel
          Left = 12
          Top = 108
          Width = 95
          Height = 13
          Caption = 'Antal '#246'verbokningar'
        end
        object Label26: TLabel
          Left = 148
          Top = 108
          Width = 36
          Height = 13
          Caption = 'd'#228'refter'
        end
        object Label9: TLabel
          Left = 148
          Top = 80
          Width = 22
          Height = 13
          Caption = 'inom'
        end
        object Label6: TLabel
          Left = 148
          Top = 52
          Width = 22
          Height = 13
          Caption = 'inom'
        end
        object Label36: TLabel
          Left = 116
          Top = 4
          Width = 55
          Height = 13
          Caption = 'Beskrivning'
        end
        object Label7: TLabel
          Left = 216
          Top = 52
          Width = 27
          Height = 13
          Caption = 'dagar'
        end
        object Label10: TLabel
          Left = 216
          Top = 80
          Width = 27
          Height = 13
          Caption = 'dagar'
        end
        object Label27: TLabel
          Left = 256
          Top = 4
          Width = 94
          Height = 13
          Caption = 'Standard deposition'
        end
        object DBEdit38: TDBEdit
          Left = 12
          Top = 20
          Width = 49
          Height = 21
          CharCase = ecUpperCase
          DataField = 'ID'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 0
        end
        object DBCheckBox1: TDBCheckBox
          Left = 12
          Top = 144
          Width = 121
          Height = 17
          Caption = 'Visa km rutor'
          DataField = 'ShowKM'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 8
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox3: TDBCheckBox
          Left = 12
          Top = 164
          Width = 121
          Height = 17
          Caption = 'Visa prisklass ruta'
          DataField = 'ShowPKlass'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 9
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox4: TDBCheckBox
          Left = 12
          Top = 184
          Width = 121
          Height = 17
          Caption = 'Visa pristyps ruta'
          DataField = 'ShowPTyp'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 10
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox5: TDBCheckBox
          Left = 12
          Top = 204
          Width = 121
          Height = 17
          Caption = 'Visa dragbils ruta'
          DataField = 'ShowDragbil'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 11
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBEdit7: TDBEdit
          Left = 116
          Top = 104
          Width = 25
          Height = 21
          DataField = 'OverBook3'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 7
        end
        object DBEdit5: TDBEdit
          Left = 116
          Top = 76
          Width = 25
          Height = 21
          DataField = 'OverBook2'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 5
        end
        object DBEdit3: TDBEdit
          Left = 116
          Top = 48
          Width = 25
          Height = 21
          DataField = 'OverBook1'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 3
        end
        object DBEdit39: TDBEdit
          Left = 116
          Top = 20
          Width = 121
          Height = 21
          DataField = 'Type'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 1
        end
        object DBEdit4: TDBEdit
          Left = 180
          Top = 48
          Width = 29
          Height = 21
          DataField = 'OverTime1'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 4
        end
        object DBEdit6: TDBEdit
          Left = 180
          Top = 76
          Width = 29
          Height = 21
          DataField = 'OverTime2'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 6
        end
        object DBEdit8: TDBEdit
          Left = 256
          Top = 20
          Width = 121
          Height = 21
          DataField = 'Default_Dep'
          DataSource = Dmod2.ObjTypeS
          TabOrder = 2
        end
        object PaObjTypGrid: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 12
          Visible = False
          object DBGrid8: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.ObjTypeS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid8CellClick
            OnDblClick = DBGrid8DblClick
            OnKeyUp = DBGrid8KeyUp
          end
        end
      end
    end
    object tbSignatures: TTabSheet
      Tag = 3
      Caption = '&Signaturer'
      ImageIndex = 5
      OnExit = tbSignaturesExit
      object PaSign: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label39: TLabel
          Left = 16
          Top = 12
          Width = 39
          Height = 13
          Caption = 'Signatur'
        end
        object Label40: TLabel
          Left = 16
          Top = 52
          Width = 28
          Height = 13
          Caption = 'Namn'
        end
        object Label42: TLabel
          Left = 16
          Top = 92
          Width = 32
          Height = 13
          Caption = 'Adress'
        end
        object Label43: TLabel
          Left = 16
          Top = 180
          Width = 36
          Height = 13
          Caption = 'Telefon'
        end
        object Label79: TLabel
          Left = 240
          Top = 12
          Width = 44
          Height = 13
          Caption = 'L'#246'senord'
        end
        object Label41: TLabel
          Left = 240
          Top = 52
          Width = 70
          Height = 13
          Caption = 'Personnummer'
        end
        object Label94: TLabel
          Left = 240
          Top = 96
          Width = 74
          Height = 13
          Caption = 'S'#228'kerhets niv'#229':'
          OnClick = Button1Click
        end
        object DBEdit42: TDBEdit
          Left = 24
          Top = 28
          Width = 65
          Height = 21
          CharCase = ecUpperCase
          DataField = 'SIGN'
          DataSource = Dmod2.SignrS
          TabOrder = 0
        end
        object DBEdit43: TDBEdit
          Left = 24
          Top = 68
          Width = 201
          Height = 21
          DataField = 'NAMN'
          DataSource = Dmod2.SignrS
          TabOrder = 1
        end
        object DBEdit44: TDBEdit
          Left = 24
          Top = 108
          Width = 201
          Height = 21
          Hint = 'c/o adress'
          TabStop = False
          DataField = 'C_O_ADR'
          DataSource = Dmod2.SignrS
          TabOrder = 2
        end
        object DBEdit45: TDBEdit
          Left = 24
          Top = 132
          Width = 201
          Height = 21
          Hint = 'Gatuadress'
          DataField = 'ADRESS'
          DataSource = Dmod2.SignrS
          TabOrder = 3
        end
        object DBEdit46: TDBEdit
          Left = 24
          Top = 156
          Width = 65
          Height = 21
          Hint = 'Postnummer'
          DataField = 'PNR'
          DataSource = Dmod2.SignrS
          TabOrder = 4
        end
        object DBEdit47: TDBEdit
          Left = 96
          Top = 156
          Width = 129
          Height = 21
          Hint = 'Postort'
          DataField = 'ORT'
          DataSource = Dmod2.SignrS
          TabOrder = 5
        end
        object cbTele4: TDBComboBox
          Left = 24
          Top = 196
          Width = 65
          Height = 21
          DataField = 'TEL_1'
          DataSource = Dmod2.SignrS
          ItemHeight = 13
          TabOrder = 6
        end
        object cbTele5: TDBComboBox
          Left = 24
          Top = 220
          Width = 65
          Height = 21
          DataField = 'TEL_2'
          DataSource = Dmod2.SignrS
          ItemHeight = 13
          TabOrder = 7
        end
        object DBEdit50: TDBEdit
          Left = 108
          Top = 220
          Width = 117
          Height = 21
          DataField = 'TEL_NR_2'
          DataSource = Dmod2.SignrS
          TabOrder = 8
        end
        object DBEdit49: TDBEdit
          Left = 108
          Top = 196
          Width = 117
          Height = 21
          DataField = 'TEL_NR_1'
          DataSource = Dmod2.SignrS
          TabOrder = 9
        end
        object DBEdit118: TDBEdit
          Left = 252
          Top = 28
          Width = 121
          Height = 21
          DataField = 'Password'
          DataSource = Dmod2.SignrS
          PasswordChar = '*'
          TabOrder = 10
        end
        object DBEdit48: TDBEdit
          Left = 252
          Top = 68
          Width = 121
          Height = 21
          DataField = 'PERS_NR'
          DataSource = Dmod2.SignrS
          TabOrder = 11
        end
        object DBEdit84: TDBEdit
          Left = 252
          Top = 112
          Width = 121
          Height = 21
          DataField = 'KTJ_GRP'
          DataSource = Dmod2.SignrS
          TabOrder = 12
        end
        object PaSignGrid: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 13
          object DBGrid9: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.SignrS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid9CellClick
            OnDblClick = DBGrid9DblClick
            OnKeyUp = DBGrid9KeyUp
          end
        end
      end
    end
    object tbCosts: TTabSheet
      Tag = 4
      Caption = 'Kos&tnader'
      ImageIndex = 9
      OnExit = tbCostsExit
      object PaCosts: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label97: TLabel
          Left = 640
          Top = 16
          Width = 71
          Height = 13
          Caption = 'Koncern Konto'
        end
        object Label96: TLabel
          Left = 560
          Top = 16
          Width = 58
          Height = 13
          Caption = 'Intern Konto'
        end
        object Label75: TLabel
          Left = 24
          Top = 16
          Width = 39
          Height = 13
          Caption = 'Kostnad'
        end
        object Label76: TLabel
          Left = 168
          Top = 16
          Width = 24
          Height = 13
          Caption = 'Antal'
        end
        object Label77: TLabel
          Left = 248
          Top = 16
          Width = 17
          Height = 13
          Caption = 'Pris'
        end
        object Label78: TLabel
          Left = 328
          Top = 16
          Width = 28
          Height = 13
          Caption = 'Moms'
        end
        object Label80: TLabel
          Left = 408
          Top = 16
          Width = 28
          Height = 13
          Caption = 'Konto'
        end
        object Label81: TLabel
          Left = 480
          Top = 16
          Width = 68
          Height = 13
          Caption = 'Kostnadsst'#228'lle'
        end
        object DBEdit86: TDBEdit
          Left = 640
          Top = 32
          Width = 57
          Height = 21
          DataField = 'KoncernKontoNr'
          DataSource = Dmod2.CostsS
          TabOrder = 7
        end
        object DBEdit87: TDBEdit
          Left = 560
          Top = 32
          Width = 57
          Height = 21
          DataField = 'InternKontoNr'
          DataSource = Dmod2.CostsS
          TabOrder = 8
        end
        object DBEdit68: TDBEdit
          Left = 24
          Top = 32
          Width = 121
          Height = 21
          DataField = 'Costname'
          DataSource = Dmod2.CostsS
          TabOrder = 0
        end
        object DBEdit69: TDBEdit
          Left = 168
          Top = 32
          Width = 57
          Height = 21
          DataField = 'No'
          DataSource = Dmod2.CostsS
          TabOrder = 1
        end
        object DBEdit70: TDBEdit
          Left = 248
          Top = 32
          Width = 57
          Height = 21
          DataField = 'Price'
          DataSource = Dmod2.CostsS
          TabOrder = 2
        end
        object DBEdit71: TDBEdit
          Left = 328
          Top = 32
          Width = 57
          Height = 21
          DataField = 'VAT'
          DataSource = Dmod2.CostsS
          TabOrder = 3
        end
        object DBEdit72: TDBEdit
          Left = 480
          Top = 32
          Width = 57
          Height = 21
          DataField = 'Acc_center'
          DataSource = Dmod2.CostsS
          TabOrder = 5
        end
        object DBEdit73: TDBEdit
          Left = 408
          Top = 32
          Width = 57
          Height = 21
          DataField = 'Acc_code'
          DataSource = Dmod2.CostsS
          TabOrder = 4
        end
        object PACostsG: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 6
          Visible = False
          object DBGrid1: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.CostsS
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
    object tbPrices: TTabSheet
      Tag = 2
      Caption = '&Priser'
      ImageIndex = 4
      OnExit = tbPricesExit
      object PaPris: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label44: TLabel
          Left = 12
          Top = 12
          Width = 41
          Height = 13
          Caption = 'Prisklass'
        end
        object Label46: TLabel
          Left = 12
          Top = 40
          Width = 44
          Height = 13
          Caption = 'Giltig fr'#229'n'
        end
        object Prisnamn: TLabel
          Left = 12
          Top = 68
          Width = 43
          Height = 13
          Caption = 'Prisnamn'
        end
        object Label45: TLabel
          Left = 128
          Top = 12
          Width = 31
          Height = 13
          Caption = 'Pristyp'
        end
        object Label47: TLabel
          Left = 128
          Top = 40
          Width = 35
          Height = 13
          Caption = 'Giltig till'
        end
        object DBEdit51: TDBEdit
          Left = 60
          Top = 8
          Width = 29
          Height = 21
          CharCase = ecUpperCase
          DataField = 'PKLASS'
          DataSource = Dmod2.PriceTabS
          TabOrder = 0
        end
        object DBEdit53: TDBEdit
          Left = 60
          Top = 36
          Width = 65
          Height = 21
          DataField = 'FDAT'
          DataSource = Dmod2.PriceTabS
          TabOrder = 2
        end
        object DBEdit55: TDBEdit
          Left = 60
          Top = 64
          Width = 177
          Height = 21
          DataField = 'PNAMN'
          DataSource = Dmod2.PriceTabS
          TabOrder = 4
        end
        object DBCheckBox2: TDBCheckBox
          Left = 60
          Top = 88
          Width = 109
          Height = 17
          Caption = 'Pris inkl moms'
          DataField = 'InkMoms'
          DataSource = Dmod2.PriceTabS
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox6: TDBCheckBox
          Left = 60
          Top = 112
          Width = 81
          Height = 17
          Caption = 'Cdr Default'
          DataField = 'Cdr_Def'
          DataSource = Dmod2.PriceTabS
          TabOrder = 6
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object GroupBox3: TGroupBox
          Left = 12
          Top = 132
          Width = 229
          Height = 37
          Caption = 'Minimumhyra'
          TabOrder = 7
          object Label52: TLabel
            Left = 16
            Top = 16
            Width = 29
            Height = 13
            Caption = 'Dagar'
          end
          object Label53: TLabel
            Left = 128
            Top = 16
            Width = 34
            Height = 13
            Caption = 'Timmar'
          end
          object DBEdit58: TDBEdit
            Left = 76
            Top = 12
            Width = 37
            Height = 21
            DataField = 'SR_DAG2'
            DataSource = Dmod2.PriceTabS
            TabOrder = 0
          end
          object DBEdit59: TDBEdit
            Left = 172
            Top = 12
            Width = 37
            Height = 21
            DataField = 'SR_MAX2'
            DataSource = Dmod2.PriceTabS
            TabOrder = 1
          end
        end
        object GroupBox4: TGroupBox
          Left = 12
          Top = 172
          Width = 645
          Height = 213
          Caption = 'Priser '
          TabOrder = 8
          object Label54: TLabel
            Left = 12
            Top = 16
            Width = 77
            Height = 13
            Caption = 'Kostnad / timme'
          end
          object Label62: TLabel
            Left = 172
            Top = 16
            Width = 56
            Height = 13
            Caption = 'Km kostnad'
          end
          object DBEdit60: TDBEdit
            Left = 100
            Top = 12
            Width = 49
            Height = 21
            DataField = 'PRIS_TIM'
            DataSource = Dmod2.PriceTabS
            TabOrder = 1
          end
          object DBEdit105: TDBEdit
            Left = 240
            Top = 12
            Width = 49
            Height = 21
            DataField = 'KOST_TIM'
            DataSource = Dmod2.PriceTabS
            TabOrder = 2
          end
          object Panel3: TPanel
            Left = 2
            Top = 32
            Width = 641
            Height = 179
            Align = alBottom
            BevelOuter = bvNone
            BorderWidth = 5
            TabOrder = 0
            object DBGrid2: TDBGrid
              Left = 5
              Top = 5
              Width = 631
              Height = 150
              Align = alClient
              DataSource = Dmod2.PriceTabRowsS
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PriceId'
                  Visible = False
                end
                item
                  Expanded = False
                  FieldName = 'RowNum'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'MINDAG'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRISDAG'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'KOST'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'INKL_KM'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'OVERKM'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'XDYGN'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'XINKLKM'
                  Visible = True
                end>
            end
            object DBNavigator11: TDBNavigator
              Left = 5
              Top = 155
              Width = 631
              Height = 19
              DataSource = Dmod2.PriceTabRowsS
              Align = alBottom
              Hints.Strings = (
                'F'#246'rsta (Ctrl-PgUp)'
                'F'#246'reg'#229'ende (PgUp)'
                'N'#228'sta (PgDn)'
                'Sista (Ctrl-PgDn)'
                'L'#228'gg till (Ctrl-Ins)'
                'Ta bort (Ctrl-Del)'
                #196'ndra'
                'Spara (Ctrl-Enter)'
                'Avbryt (Ctrl-Home)'
                'Uppdatera (Ctrl-Enter)')
              ConfirmDelete = False
              TabOrder = 1
            end
          end
        end
        object DBEdit52: TDBEdit
          Left = 168
          Top = 8
          Width = 29
          Height = 21
          CharCase = ecUpperCase
          DataField = 'PTYP'
          DataSource = Dmod2.PriceTabS
          TabOrder = 1
        end
        object DBEdit54: TDBEdit
          Left = 168
          Top = 36
          Width = 69
          Height = 21
          DataField = 'TDAT'
          DataSource = Dmod2.PriceTabS
          TabOrder = 3
        end
        object GroupBox2: TGroupBox
          Left = 244
          Top = 8
          Width = 413
          Height = 57
          Caption = 'Sj'#228'lvriskreducering '
          TabOrder = 9
          object Label48: TLabel
            Left = 16
            Top = 16
            Width = 73
            Height = 13
            Caption = 'Kostnad / dygn'
          end
          object Label49: TLabel
            Left = 96
            Top = 32
            Width = 6
            Height = 13
            Caption = '<'
          end
          object Label50: TLabel
            Left = 104
            Top = 16
            Width = 73
            Height = 13
            Caption = 'dagar deb. max'
          end
          object Label51: TLabel
            Left = 232
            Top = 16
            Width = 89
            Height = 13
            Caption = 'Kostnad / '#246'verdag'
          end
          object DBEdit56: TDBEdit
            Left = 108
            Top = 28
            Width = 25
            Height = 21
            DataField = 'SR_DAG1'
            DataSource = Dmod2.PriceTabS
            TabOrder = 1
          end
          object DBEdit57: TDBEdit
            Left = 152
            Top = 28
            Width = 65
            Height = 21
            DataField = 'SR_MAX1'
            DataSource = Dmod2.PriceTabS
            TabOrder = 2
          end
          object DBEdit103: TDBEdit
            Left = 16
            Top = 28
            Width = 65
            Height = 21
            DataField = 'SR_DYGN'
            DataSource = Dmod2.PriceTabS
            TabOrder = 0
          end
          object DBEdit104: TDBEdit
            Left = 232
            Top = 28
            Width = 65
            Height = 21
            DataField = 'SR_OVERDYGN'
            DataSource = Dmod2.PriceTabS
            TabOrder = 3
          end
        end
        object GroupBox1: TGroupBox
          Left = 244
          Top = 64
          Width = 413
          Height = 105
          Caption = 'Utskrifts text'
          TabOrder = 10
          object DBMemo1: TDBMemo
            Left = 16
            Top = 15
            Width = 385
            Height = 82
            DataField = 'PriceInfo'
            DataSource = Dmod2.PriceTabS
            TabOrder = 0
            OnExit = DBMemo1Exit
          end
        end
        object PaPrisGrid: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 11
          Visible = False
          object DBGrid10: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 288
            Align = alClient
            DataSource = Dmod2.PriceTabS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid10CellClick
            OnDblClick = DBGrid10DblClick
            OnKeyUp = DBGrid10KeyUp
          end
          object DBGrid11: TDBGrid
            Left = 1
            Top = 289
            Width = 722
            Height = 145
            Align = alBottom
            DataSource = Dmod2.PriceTabRowsS
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
        end
      end
    end
    object tbrapport: TTabSheet
      Tag = 7
      Caption = '&Rapporter'
      ImageIndex = 11
      OnExit = tbrapportExit
      object PaRep: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label82: TLabel
          Left = 24
          Top = 32
          Width = 39
          Height = 13
          Caption = 'Program'
        end
        object Label83: TLabel
          Left = 168
          Top = 32
          Width = 26
          Height = 13
          Caption = 'Meny'
        end
        object Label84: TLabel
          Left = 312
          Top = 32
          Width = 55
          Height = 13
          Caption = 'Rapp namn'
        end
        object Label85: TLabel
          Left = 448
          Top = 32
          Width = 55
          Height = 13
          Caption = 'Meny namn'
        end
        object Label86: TLabel
          Left = 584
          Top = 32
          Width = 47
          Height = 13
          Caption = 'Rapp Typ'
        end
        object DBEdit74: TDBEdit
          Left = 24
          Top = 48
          Width = 121
          Height = 21
          DataField = 'Program'
          DataSource = Dmod2.ReportsS
          TabOrder = 0
        end
        object DBEdit75: TDBEdit
          Left = 168
          Top = 48
          Width = 121
          Height = 21
          DataField = 'Meny'
          DataSource = Dmod2.ReportsS
          TabOrder = 1
        end
        object DBEdit76: TDBEdit
          Left = 312
          Top = 48
          Width = 121
          Height = 21
          DataField = 'CallName'
          DataSource = Dmod2.ReportsS
          TabOrder = 2
        end
        object DBEdit77: TDBEdit
          Left = 448
          Top = 48
          Width = 121
          Height = 21
          DataField = 'MenuName'
          DataSource = Dmod2.ReportsS
          TabOrder = 3
        end
        object DBEdit78: TDBEdit
          Left = 584
          Top = 48
          Width = 57
          Height = 21
          DataField = 'AccessType'
          DataSource = Dmod2.ReportsS
          TabOrder = 4
        end
        object PARepG: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 5
          Visible = False
          object DBGrid4: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.ReportsS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'RapportId'
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Program'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Meny'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CallName'
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MenuName'
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AccessType'
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Rep_Field'
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Rep_UTyp'
                Width = 20
                Visible = True
              end>
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Tag = 8
      Caption = '&Kontering'
      ImageIndex = 8
      OnExit = TabSheet2Exit
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 57
        Align = alTop
        TabOrder = 0
        object Label71: TLabel
          Left = 16
          Top = 8
          Width = 63
          Height = 13
          Caption = 'LoggNummer'
        end
        object Label72: TLabel
          Left = 104
          Top = 8
          Width = 63
          Height = 13
          Caption = 'Kst'#228'lle Debet'
        end
        object Label73: TLabel
          Left = 208
          Top = 8
          Width = 61
          Height = 13
          Caption = 'Kst'#228'lle Kredit'
        end
        object DBEdit64: TDBEdit
          Left = 16
          Top = 24
          Width = 65
          Height = 21
          DataField = 'Loggnr'
          DataSource = Dmod2.ParamS
          TabOrder = 0
        end
        object DBEdit65: TDBEdit
          Left = 104
          Top = 24
          Width = 81
          Height = 21
          DataField = 'KStalle_Debet'
          DataSource = Dmod2.ParamS
          TabOrder = 1
        end
        object DBEdit66: TDBEdit
          Left = 208
          Top = 24
          Width = 81
          Height = 21
          DataField = 'KStalle_Kredit'
          DataSource = Dmod2.ParamS
          TabOrder = 2
        end
        object DBNavigator1: TDBNavigator
          Left = 312
          Top = 20
          Width = 25
          Height = 25
          DataSource = Dmod2.ParamS
          VisibleButtons = [nbPost]
          TabOrder = 3
        end
      end
      object PaKont: TPanel
        Left = 0
        Top = 57
        Width = 726
        Height = 380
        Align = alClient
        TabOrder = 1
        object Label87: TLabel
          Left = 24
          Top = 24
          Width = 61
          Height = 13
          Caption = 'Konterings id'
        end
        object Label88: TLabel
          Left = 112
          Top = 24
          Width = 76
          Height = 13
          Caption = 'Konteringsnamn'
        end
        object Label89: TLabel
          Left = 204
          Top = 24
          Width = 28
          Height = 13
          Caption = 'Konto'
        end
        object Label90: TLabel
          Left = 294
          Top = 24
          Width = 72
          Height = 13
          Caption = 'KSt'#228'lle styrning'
        end
        object Label91: TLabel
          Left = 384
          Top = 24
          Width = 58
          Height = 13
          Caption = 'Intern Konto'
        end
        object Label95: TLabel
          Left = 464
          Top = 24
          Width = 71
          Height = 13
          Caption = 'Koncern Konto'
        end
        object DBEdit79: TDBEdit
          Left = 24
          Top = 40
          Width = 57
          Height = 21
          DataField = 'Konteringsid'
          DataSource = Dmod2.KonteringS
          TabOrder = 0
        end
        object DBEdit80: TDBEdit
          Left = 112
          Top = 40
          Width = 57
          Height = 21
          DataField = 'Konteringsnamn'
          DataSource = Dmod2.KonteringS
          TabOrder = 1
        end
        object DBEdit81: TDBEdit
          Left = 204
          Top = 40
          Width = 57
          Height = 21
          DataField = 'Kontonr'
          DataSource = Dmod2.KonteringS
          TabOrder = 2
        end
        object DBEdit82: TDBEdit
          Left = 294
          Top = 40
          Width = 57
          Height = 21
          DataField = 'KStalleStyrning'
          DataSource = Dmod2.KonteringS
          TabOrder = 3
        end
        object DBEdit83: TDBEdit
          Left = 384
          Top = 40
          Width = 57
          Height = 21
          DataField = 'InternKontoNr'
          DataSource = Dmod2.KonteringS
          TabOrder = 4
        end
        object DBEdit85: TDBEdit
          Left = 464
          Top = 40
          Width = 57
          Height = 21
          DataField = 'KoncernKontoNr'
          DataSource = Dmod2.KonteringS
          TabOrder = 5
        end
        object PaKontG: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 378
          Align = alClient
          TabOrder = 6
          Visible = False
          object DBGrid3: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 376
            Align = alClient
            DataSource = Dmod2.KonteringS
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
    object tbCustomers: TTabSheet
      Tag = 9
      Caption = 'K&under'
      ImageIndex = 9
      OnExit = tbCustomersExit
      object PaKund: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label98: TLabel
          Left = 16
          Top = 12
          Width = 28
          Height = 13
          Caption = 'Namn'
        end
        object Label99: TLabel
          Left = 16
          Top = 52
          Width = 77
          Height = 13
          Caption = 'F'#246'retagskontakt'
        end
        object Label100: TLabel
          Left = 16
          Top = 92
          Width = 32
          Height = 13
          Caption = 'Adress'
        end
        object Label101: TLabel
          Left = 16
          Top = 204
          Width = 36
          Height = 13
          Caption = 'Telefon'
        end
        object Label102: TLabel
          Left = 24
          Top = 320
          Width = 28
          Height = 13
          Caption = 'Konto'
        end
        object Label103: TLabel
          Left = 140
          Top = 320
          Width = 68
          Height = 13
          Caption = 'Kostnadsst'#228'lle'
        end
        object Label104: TLabel
          Left = 240
          Top = 12
          Width = 36
          Height = 13
          Caption = 'KundID'
        end
        object Label105: TLabel
          Left = 240
          Top = 52
          Width = 70
          Height = 13
          Caption = 'Personnummer'
        end
        object Label106: TLabel
          Left = 240
          Top = 92
          Width = 40
          Height = 13
          Caption = 'Notering'
        end
        object Label107: TLabel
          Left = 240
          Top = 204
          Width = 46
          Height = 13
          Caption = 'Kontokort'
        end
        object Label108: TLabel
          Left = 240
          Top = 248
          Width = 31
          Height = 13
          Caption = 'Pristyp'
        end
        object Label109: TLabel
          Left = 240
          Top = 272
          Width = 39
          Height = 13
          Caption = 'Bet. s'#228'tt'
        end
        object Label110: TLabel
          Left = 376
          Top = 248
          Width = 26
          Height = 13
          Caption = 'Giltigt'
        end
        object Label111: TLabel
          Left = 376
          Top = 272
          Width = 49
          Height = 13
          Caption = 'Bet. villkor'
        end
        object SpeedButton2: TSpeedButton
          Left = 464
          Top = 320
          Width = 97
          Height = 22
          Caption = 'Rensa kundposter'
          Visible = False
        end
        object edtKNamn: TDBEdit
          Left = 24
          Top = 28
          Width = 201
          Height = 21
          DataField = 'Name'
          DataSource = Dmod2.CustomerS
          TabOrder = 3
        end
        object DBEdit88: TDBEdit
          Left = 24
          Top = 68
          Width = 201
          Height = 21
          TabStop = False
          DataField = 'Contact'
          DataSource = Dmod2.CustomerS
          TabOrder = 22
        end
        object edtKAdr1: TDBEdit
          Left = 24
          Top = 108
          Width = 201
          Height = 21
          Hint = 'c/o adress'
          TabStop = False
          DataField = 'Co_Adr'
          DataSource = Dmod2.CustomerS
          TabOrder = 23
        end
        object edtKAdr2: TDBEdit
          Left = 24
          Top = 132
          Width = 201
          Height = 21
          Hint = 'Gatuadress'
          DataField = 'Adress'
          DataSource = Dmod2.CustomerS
          TabOrder = 4
        end
        object edtKPAdr: TDBEdit
          Left = 24
          Top = 156
          Width = 201
          Height = 21
          Hint = 'Postort'
          DataField = 'Postal_Name'
          DataSource = Dmod2.CustomerS
          TabOrder = 5
        end
        object edtKLand: TDBEdit
          Left = 24
          Top = 180
          Width = 201
          Height = 21
          Hint = 'Land'
          DataField = 'Country'
          DataSource = Dmod2.CustomerS
          TabOrder = 24
          Visible = False
        end
        object cbTele1: TDBComboBox
          Left = 24
          Top = 220
          Width = 93
          Height = 21
          DataField = 'TEL_1'
          DataSource = Dmod2.CustomerS
          ItemHeight = 13
          TabOrder = 6
        end
        object cbTele2: TDBComboBox
          Left = 24
          Top = 244
          Width = 93
          Height = 21
          DataField = 'TEL_2'
          DataSource = Dmod2.CustomerS
          ItemHeight = 13
          TabOrder = 8
        end
        object cbTele3: TDBComboBox
          Left = 24
          Top = 268
          Width = 93
          Height = 21
          DataField = 'TEL_3'
          DataSource = Dmod2.CustomerS
          ItemHeight = 13
          TabOrder = 10
        end
        object cbIKund: TDBCheckBox
          Left = 24
          Top = 296
          Width = 97
          Height = 17
          Caption = 'Internkund'
          DataField = 'Int_Cust'
          DataSource = Dmod2.CustomerS
          TabOrder = 18
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object edtKKonto: TDBEdit
          Left = 60
          Top = 316
          Width = 69
          Height = 21
          DataField = 'IKonto'
          DataSource = Dmod2.CustomerS
          TabOrder = 19
        end
        object edtKKStalle: TDBEdit
          Left = 216
          Top = 316
          Width = 69
          Height = 21
          DataField = 'IKStalle'
          DataSource = Dmod2.CustomerS
          TabOrder = 20
        end
        object DBEdit89: TDBEdit
          Left = 120
          Top = 268
          Width = 105
          Height = 21
          DataField = 'TEL_NR_3'
          DataSource = Dmod2.CustomerS
          TabOrder = 11
        end
        object DBEdit90: TDBEdit
          Left = 120
          Top = 244
          Width = 105
          Height = 21
          DataField = 'TEL_NR_2'
          DataSource = Dmod2.CustomerS
          TabOrder = 9
        end
        object DBEdit91: TDBEdit
          Left = 120
          Top = 220
          Width = 105
          Height = 21
          DataField = 'TEL_NR_1'
          DataSource = Dmod2.CustomerS
          TabOrder = 7
        end
        object edtKID: TDBEdit
          Left = 252
          Top = 28
          Width = 93
          Height = 21
          TabStop = False
          DataField = 'Cust_Id'
          DataSource = Dmod2.CustomerS
          TabOrder = 25
        end
        object edtKPersNr: TDBEdit
          Left = 252
          Top = 68
          Width = 93
          Height = 21
          DataField = 'Org_No'
          DataSource = Dmod2.CustomerS
          TabOrder = 1
        end
        object meKund: TDBMemo
          Left = 252
          Top = 108
          Width = 185
          Height = 93
          DataField = 'Not'
          DataSource = Dmod2.CustomerS
          TabOrder = 21
        end
        object cbCards: TDBComboBox
          Left = 240
          Top = 220
          Width = 117
          Height = 21
          DataField = 'KTyp'
          DataSource = Dmod2.CustomerS
          ItemHeight = 13
          TabOrder = 12
        end
        object cbBetalning: TDBComboBox
          Left = 284
          Top = 268
          Width = 73
          Height = 21
          DataField = 'Payment'
          DataSource = Dmod2.CustomerS
          ItemHeight = 13
          Items.Strings = (
            'F Faktura'
            'K Kontant'
            'O Kontokort'
            'U Fakturaunderlag'
            'I Internt')
          TabOrder = 16
        end
        object DBEdit92: TDBEdit
          Left = 312
          Top = 244
          Width = 45
          Height = 21
          CharCase = ecUpperCase
          DataField = 'PTYP'
          DataSource = Dmod2.CustomerS
          TabOrder = 14
        end
        object edtCreditNo: TDBEdit
          Left = 360
          Top = 220
          Width = 133
          Height = 21
          Hint = 'Postort'
          DataField = 'KontoNr'
          DataSource = Dmod2.CustomerS
          TabOrder = 13
        end
        object DBKexp: TDBEdit
          Left = 420
          Top = 244
          Width = 73
          Height = 21
          DataField = 'Kexp'
          DataSource = Dmod2.CustomerS
          TabOrder = 15
        end
        object DBEdit93: TDBEdit
          Left = 448
          Top = 268
          Width = 45
          Height = 21
          DataField = 'Terms_Pay'
          DataSource = Dmod2.CustomerS
          TabOrder = 17
        end
        object cbUtlandsk: TDBCheckBox
          Left = 360
          Top = 72
          Width = 105
          Height = 17
          Caption = 'Utl'#228'ndsk person'
          DataField = 'UTLANDSK'
          DataSource = Dmod2.CustomerS
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox7: TDBCheckBox
          Left = 360
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Endast F'#246'rare'
          DataField = 'Driver'
          DataSource = Dmod2.CustomerS
          TabOrder = 2
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox8: TDBCheckBox
          Left = 120
          Top = 296
          Width = 97
          Height = 17
          Caption = 'Koncernkund'
          DataField = 'Cust_Koncern'
          DataSource = Dmod2.CustomerS
          TabOrder = 26
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object PaKundG: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 27
          Visible = False
          object DBGrid5: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.CustomerS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnDblClick = DBGrid5DblClick
            OnKeyUp = DBGrid1KeyUp
          end
        end
      end
    end
    object tbObjects: TTabSheet
      Tag = 10
      Caption = 'O&bjekt'
      ImageIndex = 10
      OnExit = tbObjectsExit
      object PaObj: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 437
        Align = alClient
        TabOrder = 0
        object Label112: TLabel
          Left = 16
          Top = 12
          Width = 60
          Height = 13
          Caption = 'Reg.nummer'
        end
        object Label113: TLabel
          Left = 16
          Top = 44
          Width = 65
          Height = 13
          Caption = 'Typ av objekt'
        end
        object Label114: TLabel
          Left = 16
          Top = 72
          Width = 31
          Height = 13
          Caption = 'Modell'
        end
        object Label115: TLabel
          Left = 16
          Top = 100
          Width = 92
          Height = 13
          Caption = 'Aktuell KM-st'#228'llning'
        end
        object Label116: TLabel
          Left = 16
          Top = 136
          Width = 72
          Height = 13
          Caption = 'Serviceintervall'
        end
        object Label117: TLabel
          Left = 16
          Top = 160
          Width = 52
          Height = 13
          Caption = 'Tankvolym'
        end
        object Label118: TLabel
          Left = 16
          Top = 184
          Width = 40
          Height = 13
          Caption = 'Tillbeh'#246'r'
        end
        object Label119: TLabel
          Left = 200
          Top = 12
          Width = 73
          Height = 13
          Caption = 'Objektsnummer'
        end
        object Label120: TLabel
          Left = 264
          Top = 100
          Width = 53
          Height = 13
          Caption = 'Drivm / Km'
        end
        object Label121: TLabel
          Left = 252
          Top = 136
          Width = 65
          Height = 13
          Caption = 'N'#228'sta service'
        end
        object Label122: TLabel
          Left = 176
          Top = 160
          Width = 47
          Height = 13
          Caption = 'Drivmedel'
        end
        object Label123: TLabel
          Left = 332
          Top = 160
          Width = 21
          Height = 13
          Caption = 'F'#228'rg'
        end
        object Label124: TLabel
          Left = 340
          Top = 184
          Width = 41
          Height = 13
          Caption = 'Prisklass'
        end
        object Label125: TLabel
          Left = 340
          Top = 208
          Width = 37
          Height = 13
          Caption = 'VStatus'
        end
        object Label126: TLabel
          Left = 232
          Top = 232
          Width = 173
          Height = 13
          Caption = 'Kommentar p'#229' Kontraktet / Fakturan'
        end
        object GroupBox6: TGroupBox
          Left = 16
          Top = 204
          Width = 213
          Height = 97
          Caption = 'Notering'
          TabOrder = 0
          object DBMemo2: TDBMemo
            Left = 2
            Top = 15
            Width = 209
            Height = 80
            Align = alClient
            DataField = 'NOTE'
            DataSource = Dmod2.ObjectS
            TabOrder = 0
          end
        end
        object GroupBox7: TGroupBox
          Left = 1
          Top = 300
          Width = 587
          Height = 49
          Caption = '&KM-Ber'#228'kning'
          TabOrder = 1
          object Label127: TLabel
            Left = 16
            Top = 16
            Width = 31
            Height = 13
            Caption = 'Datum'
          end
          object Label128: TLabel
            Left = 208
            Top = 16
            Width = 67
            Height = 13
            Caption = 'Antal Km/Dag'
          end
          object Label129: TLabel
            Left = 344
            Top = 16
            Width = 40
            Height = 13
            Caption = 'Start Km'
          end
          object DBEdit94: TDBEdit
            Left = 60
            Top = 16
            Width = 121
            Height = 21
            DataField = 'LDatum'
            DataSource = Dmod2.ObjectS
            TabOrder = 0
          end
          object DBEdit95: TDBEdit
            Left = 280
            Top = 16
            Width = 49
            Height = 21
            DataField = 'LKM'
            DataSource = Dmod2.ObjectS
            TabOrder = 1
          end
          object DBEdit96: TDBEdit
            Left = 392
            Top = 16
            Width = 121
            Height = 21
            DataField = 'LkmStart'
            DataSource = Dmod2.ObjectS
            TabOrder = 2
          end
        end
        object DBEdit97: TDBEdit
          Left = 124
          Top = 8
          Width = 61
          Height = 21
          CharCase = ecUpperCase
          DataField = 'Reg_No'
          DataSource = Dmod2.ObjectS
          TabOrder = 2
        end
        object DBEdit98: TDBEdit
          Left = 288
          Top = 8
          Width = 65
          Height = 21
          DataField = 'ObjNum'
          DataSource = Dmod2.ObjectS
          TabOrder = 3
        end
        object cbObjTyp: TDBLookupComboBox
          Left = 124
          Top = 40
          Width = 145
          Height = 21
          DataField = 'Type'
          DataSource = Dmod2.ObjectS
          KeyField = 'ID'
          ListField = 'Type'
          ListSource = Dmod2.ObjTypeS
          TabOrder = 4
        end
        object DBEdit99: TDBEdit
          Left = 124
          Top = 68
          Width = 161
          Height = 21
          DataField = 'Model'
          DataSource = Dmod2.ObjectS
          TabOrder = 5
        end
        object DBEdit100: TDBEdit
          Left = 124
          Top = 96
          Width = 121
          Height = 21
          DataField = 'KM_N'
          DataSource = Dmod2.ObjectS
          TabOrder = 6
        end
        object EdtDrvm_km: TDBEdit
          Left = 328
          Top = 96
          Width = 121
          Height = 21
          DataField = 'Drvm_km'
          DataSource = Dmod2.ObjectS
          TabOrder = 7
        end
        object DBEdit101: TDBEdit
          Left = 124
          Top = 132
          Width = 121
          Height = 21
          DataField = 'KM_SERVICE'
          DataSource = Dmod2.ObjectS
          TabOrder = 8
        end
        object DBEdit102: TDBEdit
          Left = 328
          Top = 132
          Width = 121
          Height = 21
          DataField = 'N_Service'
          DataSource = Dmod2.ObjectS
          TabOrder = 9
        end
        object DBEdit106: TDBEdit
          Left = 124
          Top = 156
          Width = 41
          Height = 21
          DataField = 'Tvolym'
          DataSource = Dmod2.ObjectS
          TabOrder = 10
        end
        object cbBensin: TDBLookupComboBox
          Left = 228
          Top = 156
          Width = 101
          Height = 21
          DataField = 'DType'
          DataSource = Dmod2.ObjectS
          KeyField = 'namn'
          ListField = 'namn'
          ListSource = Dmod2.DrivMS
          TabOrder = 11
        end
        object DBEdit107: TDBEdit
          Left = 360
          Top = 156
          Width = 89
          Height = 21
          DataField = 'Color'
          DataSource = Dmod2.ObjectS
          TabOrder = 12
        end
        object cbPClass: TDBComboBox
          Left = 396
          Top = 180
          Width = 53
          Height = 21
          AutoDropDown = True
          DataField = 'PriceClass'
          DataSource = Dmod2.ObjectS
          ItemHeight = 13
          TabOrder = 13
        end
        object DBEdit108: TDBEdit
          Left = 396
          Top = 204
          Width = 37
          Height = 21
          TabStop = False
          DataField = 'Vstat'
          DataSource = Dmod2.ObjectS
          TabOrder = 14
        end
        object DBEdit109: TDBEdit
          Left = 124
          Top = 180
          Width = 209
          Height = 21
          DataField = 'Accesories'
          DataSource = Dmod2.ObjectS
          TabOrder = 15
        end
        object DBEdit110: TDBEdit
          Left = 232
          Top = 252
          Width = 281
          Height = 21
          DataField = 'KNOT1'
          DataSource = Dmod2.ObjectS
          TabOrder = 16
        end
        object DBEdit111: TDBEdit
          Left = 232
          Top = 276
          Width = 281
          Height = 21
          DataField = 'KNOT2'
          DataSource = Dmod2.ObjectS
          TabOrder = 17
        end
        object PaObjG: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 435
          Align = alClient
          TabOrder = 18
          Visible = False
          object DBGrid12: TDBGrid
            Left = 1
            Top = 1
            Width = 722
            Height = 433
            Align = alClient
            DataSource = Dmod2.ObjectS
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnDblClick = DBGrid12DblClick
            OnKeyUp = DBGrid1KeyUp
          end
        end
      end
    end
  end
  object OPD2: TOpenPictureDialog
    Left = 156
    Top = 256
  end
  object OPD1: TOpenPictureDialog
    Left = 188
    Top = 256
  end
  object ODAvi: TOpenDialog
    Filter = 'Film|*.Avi'
    Left = 148
    Top = 200
  end
end
