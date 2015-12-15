object frmGReg: TfrmGReg
  Left = 379
  Top = 13
  Width = 721
  Height = 516
  Caption = 'Grundregister'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 33
    Width = 622
    Height = 456
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object tab1: TPageControl
      Left = 5
      Top = 5
      Width = 612
      Height = 446
      ActivePage = tbCustomers
      Align = alClient
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = tab1Change
      object tbCustomers: TTabSheet
        Tag = 1
        Caption = 'K&under'
        OnEnter = tbCustomersEnter
        object SpeedButton1: TSpeedButton
          Left = 440
          Top = 108
          Width = 25
          Height = 25
          Hint = 'Radera notering'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
            305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
            005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
            B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
            B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
            B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
            B0557777FF577777F7F500000E055550805577777F7555575755500000555555
            05555777775555557F5555000555555505555577755555557555}
          NumGlyphs = 2
          OnClick = SpeedButton1Click
        end
        object PaKund: TPanel
          Left = 0
          Top = 0
          Width = 604
          Height = 418
          Align = alClient
          TabOrder = 0
          object Label12: TLabel
            Left = 16
            Top = 12
            Width = 28
            Height = 13
            Caption = 'Namn'
          end
          object Label11: TLabel
            Left = 16
            Top = 52
            Width = 77
            Height = 13
            Caption = 'F'#246'retagskontakt'
          end
          object Label14: TLabel
            Left = 16
            Top = 92
            Width = 32
            Height = 13
            Caption = 'Adress'
          end
          object Label15: TLabel
            Left = 16
            Top = 204
            Width = 36
            Height = 13
            Caption = 'Telefon'
          end
          object Label1: TLabel
            Left = 24
            Top = 320
            Width = 28
            Height = 13
            Caption = 'Konto'
          end
          object Label2: TLabel
            Left = 140
            Top = 320
            Width = 68
            Height = 13
            Caption = 'Kostnadsst'#228'lle'
          end
          object Label16: TLabel
            Left = 240
            Top = 12
            Width = 36
            Height = 13
            Caption = 'KundID'
          end
          object Label13: TLabel
            Left = 240
            Top = 52
            Width = 70
            Height = 13
            Caption = 'Personnummer'
          end
          object Label64: TLabel
            Left = 240
            Top = 92
            Width = 40
            Height = 13
            Caption = 'Notering'
          end
          object Label17: TLabel
            Left = 240
            Top = 204
            Width = 46
            Height = 13
            Caption = 'Kontokort'
          end
          object Label63: TLabel
            Left = 240
            Top = 248
            Width = 31
            Height = 13
            Caption = 'Pristyp'
          end
          object Label66: TLabel
            Left = 240
            Top = 272
            Width = 39
            Height = 13
            Caption = 'Bet. s'#228'tt'
          end
          object Label4: TLabel
            Left = 376
            Top = 248
            Width = 26
            Height = 13
            Caption = 'Giltigt'
          end
          object Label65: TLabel
            Left = 376
            Top = 272
            Width = 49
            Height = 13
            Caption = 'Bet. villkor'
          end
          object SpeedButton2: TSpeedButton
            Left = 480
            Top = 320
            Width = 97
            Height = 22
            Caption = 'Rensa kundposter'
            Visible = False
            OnClick = SpeedButton2Click
          end
          object edtKNamn: TDBEdit
            Left = 24
            Top = 28
            Width = 201
            Height = 21
            DataField = 'Name'
            DataSource = CustomerS
            TabOrder = 3
            OnEnter = edtKNamnEnter
            OnExit = edtKNamnExit
          end
          object DBEdit12: TDBEdit
            Left = 24
            Top = 68
            Width = 201
            Height = 21
            TabStop = False
            DataField = 'Contact'
            DataSource = CustomerS
            TabOrder = 22
            OnEnter = DBEdit12Enter
            OnExit = DBEdit12Exit
          end
          object edtKAdr1: TDBEdit
            Left = 24
            Top = 108
            Width = 201
            Height = 21
            Hint = 'c/o adress'
            TabStop = False
            DataField = 'Co_Adr'
            DataSource = CustomerS
            TabOrder = 23
            OnEnter = edtKAdr1Enter
            OnExit = edtKAdr1Exit
          end
          object edtKAdr2: TDBEdit
            Left = 24
            Top = 132
            Width = 201
            Height = 21
            Hint = 'Gatuadress'
            DataField = 'Adress'
            DataSource = CustomerS
            TabOrder = 4
            OnEnter = edtKAdr2Enter
            OnExit = edtKAdr2Exit
          end
          object edtKPAdr: TDBEdit
            Left = 24
            Top = 156
            Width = 201
            Height = 21
            Hint = 'Postort'
            DataField = 'Postal_Name'
            DataSource = CustomerS
            TabOrder = 5
            OnChange = edtKPAdrChange
            OnEnter = edtKPAdrEnter
            OnExit = edtKPAdrExit
          end
          object edtKLand: TDBEdit
            Left = 24
            Top = 180
            Width = 201
            Height = 21
            Hint = 'Land'
            DataField = 'Country'
            DataSource = CustomerS
            TabOrder = 24
            Visible = False
            OnEnter = edtKLandEnter
            OnExit = edtKLandExit
          end
          object cbTele1: TDBComboBox
            Left = 24
            Top = 220
            Width = 93
            Height = 21
            DataField = 'TEL_1'
            DataSource = CustomerS
            ItemHeight = 13
            TabOrder = 6
            OnEnter = cbTele1Enter
            OnExit = cbTele1Exit
            OnKeyDown = DBComboBox8KeyDown
          end
          object cbTele2: TDBComboBox
            Left = 24
            Top = 244
            Width = 93
            Height = 21
            DataField = 'TEL_2'
            DataSource = CustomerS
            ItemHeight = 13
            TabOrder = 8
            OnEnter = cbTele2Enter
            OnExit = cbTele2Exit
            OnKeyDown = DBComboBox8KeyDown
          end
          object cbTele3: TDBComboBox
            Left = 24
            Top = 268
            Width = 93
            Height = 21
            DataField = 'TEL_3'
            DataSource = CustomerS
            ItemHeight = 13
            TabOrder = 10
            OnEnter = cbTele3Enter
            OnExit = cbTele2Exit
            OnKeyDown = DBComboBox8KeyDown
          end
          object cbIKund: TDBCheckBox
            Left = 24
            Top = 296
            Width = 97
            Height = 17
            Caption = 'Internkund'
            DataField = 'Int_Cust'
            DataSource = CustomerS
            TabOrder = 18
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            OnClick = cbIKundClick
            OnEnter = cbIKundEnter
            OnExit = cbIKundExit
          end
          object edtKKonto: TDBEdit
            Left = 60
            Top = 316
            Width = 69
            Height = 21
            DataField = 'IKonto'
            DataSource = CustomerS
            TabOrder = 19
            OnEnter = edtKKontoEnter
            OnExit = edtKKontoExit
          end
          object edtKKStalle: TDBEdit
            Left = 216
            Top = 316
            Width = 69
            Height = 21
            DataField = 'IKStalle'
            DataSource = CustomerS
            TabOrder = 20
            OnEnter = edtKKStalleEnter
            OnExit = edtKKStalleExit
          end
          object DBEdit22: TDBEdit
            Left = 120
            Top = 268
            Width = 105
            Height = 21
            DataField = 'TEL_NR_3'
            DataSource = CustomerS
            TabOrder = 11
            OnEnter = DBEdit22Enter
            OnExit = cbTele2Exit
          end
          object DBEdit20: TDBEdit
            Left = 120
            Top = 244
            Width = 105
            Height = 21
            DataField = 'TEL_NR_2'
            DataSource = CustomerS
            TabOrder = 9
            OnEnter = DBEdit20Enter
            OnExit = cbTele2Exit
          end
          object DBEdit19: TDBEdit
            Left = 120
            Top = 220
            Width = 105
            Height = 21
            DataField = 'TEL_NR_1'
            DataSource = CustomerS
            TabOrder = 7
            OnEnter = DBEdit19Enter
            OnExit = DBEdit19Exit
          end
          object edtKID: TDBEdit
            Left = 252
            Top = 28
            Width = 93
            Height = 21
            TabStop = False
            DataField = 'Cust_Id'
            DataSource = CustomerS
            TabOrder = 25
            OnEnter = edtKIDEnter
            OnExit = edtKIDExit
          end
          object edtKPersNr: TDBEdit
            Left = 252
            Top = 68
            Width = 93
            Height = 21
            DataField = 'Org_No'
            DataSource = CustomerS
            TabOrder = 1
            OnEnter = edtKPersNrEnter
            OnExit = edtKPersNrExit
          end
          object meKund: TDBMemo
            Left = 252
            Top = 108
            Width = 185
            Height = 93
            DataField = 'Not'
            DataSource = CustomerS
            TabOrder = 21
            OnEnter = meKundEnter
            OnExit = meKundExit
          end
          object cbCards: TDBComboBox
            Left = 240
            Top = 220
            Width = 117
            Height = 21
            DataField = 'KTyp'
            DataSource = CustomerS
            ItemHeight = 13
            TabOrder = 12
            OnEnter = cbCardsEnter
            OnExit = cbCardsExit
          end
          object cbBetalning: TDBComboBox
            Left = 284
            Top = 268
            Width = 73
            Height = 21
            DataField = 'Payment'
            DataSource = CustomerS
            ItemHeight = 13
            Items.Strings = (
              'F Faktura'
              'K Kontant'
              'O Kontokort'
              'U Fakturaunderlag'
              'I Internt')
            TabOrder = 16
            OnEnter = cbBetalningEnter
            OnExit = cbBetalningExit
            OnKeyDown = DBComboBox8KeyDown
          end
          object DBEdit9: TDBEdit
            Left = 312
            Top = 244
            Width = 45
            Height = 21
            CharCase = ecUpperCase
            DataField = 'PTYP'
            DataSource = CustomerS
            TabOrder = 14
            OnEnter = DBEdit9Enter
            OnExit = DBEdit9Exit
          end
          object edtCreditNo: TDBEdit
            Left = 360
            Top = 220
            Width = 133
            Height = 21
            Hint = 'Postort'
            DataField = 'KontoNr'
            DataSource = CustomerS
            TabOrder = 13
            OnChange = edtKPAdrChange
            OnEnter = edtCreditNoEnter
            OnExit = cbCardsExit
          end
          object DBKexp: TDBEdit
            Left = 420
            Top = 244
            Width = 73
            Height = 21
            DataField = 'Kexp'
            DataSource = CustomerS
            TabOrder = 15
            OnEnter = DBKexpEnter
            OnExit = DBKexpExit
          end
          object DBEdit10: TDBEdit
            Left = 448
            Top = 268
            Width = 45
            Height = 21
            DataField = 'Terms_Pay'
            DataSource = CustomerS
            TabOrder = 17
            OnEnter = DBEdit10Enter
            OnExit = DBEdit10Exit
          end
          object cbUtlandsk: TDBCheckBox
            Left = 360
            Top = 72
            Width = 105
            Height = 17
            Caption = 'Utl'#228'ndsk person'
            DataField = 'UTLANDSK'
            DataSource = CustomerS
            TabOrder = 0
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            OnClick = cbUtlandskClick
            OnEnter = cbUtlandskEnter
            OnExit = cbUtlandskExit
          end
          object DBCheckBox1: TDBCheckBox
            Left = 360
            Top = 32
            Width = 97
            Height = 17
            Caption = 'Endast F'#246'rare'
            DataField = 'Driver'
            DataSource = CustomerS
            TabOrder = 2
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            OnEnter = DBCheckBox1Enter
            OnExit = DBCheckBox1Exit
          end
          object DBCheckBox2: TDBCheckBox
            Left = 120
            Top = 296
            Width = 97
            Height = 17
            Caption = 'Koncernkund'
            DataField = 'Cust_Koncern'
            DataSource = CustomerS
            TabOrder = 26
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object PaKundG: TPanel
            Left = 1
            Top = 1
            Width = 602
            Height = 416
            Align = alClient
            TabOrder = 27
            Visible = False
            object DBGrid1: TDBGrid
              Left = 1
              Top = 1
              Width = 600
              Height = 414
              Align = alClient
              DataSource = CustomerS
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
      object tbObjects: TTabSheet
        Tag = 2
        Caption = 'O&bjekt'
        object PaObj: TPanel
          Left = 0
          Top = 0
          Width = 604
          Height = 418
          Align = alClient
          TabOrder = 0
          object Label18: TLabel
            Left = 16
            Top = 12
            Width = 60
            Height = 13
            Caption = 'Reg.nummer'
          end
          object Label20: TLabel
            Left = 16
            Top = 44
            Width = 65
            Height = 13
            Caption = 'Typ av objekt'
          end
          object Label19: TLabel
            Left = 16
            Top = 72
            Width = 31
            Height = 13
            Caption = 'Modell'
          end
          object Label23: TLabel
            Left = 16
            Top = 100
            Width = 92
            Height = 13
            Caption = 'Aktuell KM-st'#228'llning'
          end
          object Label24: TLabel
            Left = 16
            Top = 136
            Width = 72
            Height = 13
            Caption = 'Serviceintervall'
          end
          object Label28: TLabel
            Left = 16
            Top = 160
            Width = 52
            Height = 13
            Caption = 'Tankvolym'
          end
          object Label33: TLabel
            Left = 16
            Top = 184
            Width = 40
            Height = 13
            Caption = 'Tillbeh'#246'r'
          end
          object Label21: TLabel
            Left = 200
            Top = 12
            Width = 73
            Height = 13
            Caption = 'Objektsnummer'
          end
          object Label3: TLabel
            Left = 264
            Top = 100
            Width = 53
            Height = 13
            Caption = 'Drivm / Km'
          end
          object Label25: TLabel
            Left = 252
            Top = 136
            Width = 65
            Height = 13
            Caption = 'N'#228'sta service'
          end
          object Label29: TLabel
            Left = 176
            Top = 160
            Width = 47
            Height = 13
            Caption = 'Drivmedel'
          end
          object Label30: TLabel
            Left = 332
            Top = 160
            Width = 21
            Height = 13
            Caption = 'F'#228'rg'
          end
          object Label32: TLabel
            Left = 340
            Top = 184
            Width = 41
            Height = 13
            Caption = 'Prisklass'
          end
          object Label31: TLabel
            Left = 340
            Top = 208
            Width = 37
            Height = 13
            Caption = 'VStatus'
          end
          object Label34: TLabel
            Left = 232
            Top = 232
            Width = 173
            Height = 13
            Caption = 'Kommentar p'#229' Kontraktet / Fakturan'
          end
          object GroupBox1: TGroupBox
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
              DataSource = ObjectsS
              TabOrder = 0
            end
          end
          object GroupBox2: TGroupBox
            Left = 1
            Top = 300
            Width = 587
            Height = 49
            Caption = '&KM-Ber'#228'kning'
            TabOrder = 1
            object Label5: TLabel
              Left = 16
              Top = 16
              Width = 31
              Height = 13
              Caption = 'Datum'
            end
            object Label6: TLabel
              Left = 208
              Top = 16
              Width = 67
              Height = 13
              Caption = 'Antal Km/Dag'
            end
            object Label7: TLabel
              Left = 344
              Top = 16
              Width = 40
              Height = 13
              Caption = 'Start Km'
            end
            object DBEdit1: TDBEdit
              Left = 60
              Top = 16
              Width = 121
              Height = 21
              DataField = 'LDatum'
              DataSource = ObjectsS
              TabOrder = 0
              OnEnter = DBEdit1Enter
              OnExit = DBEdit1Exit
            end
            object DBEdit2: TDBEdit
              Left = 280
              Top = 16
              Width = 49
              Height = 21
              DataField = 'LKM'
              DataSource = ObjectsS
              TabOrder = 1
              OnEnter = DBEdit2Enter
              OnExit = DBEdit2Exit
            end
            object DBEdit3: TDBEdit
              Left = 392
              Top = 16
              Width = 121
              Height = 21
              DataField = 'LkmStart'
              DataSource = ObjectsS
              TabOrder = 2
              OnEnter = DBEdit3Enter
              OnExit = DBEdit3Exit
            end
          end
          object DBEdit18: TDBEdit
            Left = 124
            Top = 8
            Width = 61
            Height = 21
            CharCase = ecUpperCase
            DataField = 'Reg_No'
            DataSource = ObjectsS
            TabOrder = 2
            OnEnter = DBEdit18Enter
            OnExit = DBEdit18Exit
          end
          object DBEdit23: TDBEdit
            Left = 288
            Top = 8
            Width = 65
            Height = 21
            DataField = 'ObjNum'
            DataSource = ObjectsS
            TabOrder = 3
            OnEnter = DBEdit23Enter
            OnExit = DBEdit23Exit
          end
          object cbObjTyp: TDBLookupComboBox
            Left = 124
            Top = 40
            Width = 145
            Height = 21
            DataField = 'Type'
            DataSource = ObjectsS
            KeyField = 'ID'
            ListField = 'Type'
            ListSource = ObjTypeS
            TabOrder = 4
            OnEnter = cbObjTypEnter
            OnExit = cbObjTypExit
            OnKeyDown = cbObjTypKeyDown
          end
          object DBEdit21: TDBEdit
            Left = 124
            Top = 68
            Width = 161
            Height = 21
            DataField = 'Model'
            DataSource = ObjectsS
            TabOrder = 5
            OnEnter = DBEdit21Enter
            OnExit = DBEdit21Exit
          end
          object DBEdit28: TDBEdit
            Left = 124
            Top = 96
            Width = 121
            Height = 21
            DataField = 'KM_N'
            DataSource = ObjectsS
            TabOrder = 6
            OnEnter = DBEdit28Enter
            OnExit = DBEdit28Exit
          end
          object EdtDrvm_km: TDBEdit
            Left = 328
            Top = 96
            Width = 121
            Height = 21
            DataField = 'Drvm_km'
            DataSource = ObjectsS
            TabOrder = 7
            OnEnter = EdtDrvm_kmEnter
            OnExit = EdtDrvm_kmExit
          end
          object DBEdit29: TDBEdit
            Left = 124
            Top = 132
            Width = 121
            Height = 21
            DataField = 'KM_SERVICE'
            DataSource = ObjectsS
            TabOrder = 8
            OnEnter = DBEdit29Enter
            OnExit = DBEdit29Exit
          end
          object DBEdit30: TDBEdit
            Left = 328
            Top = 132
            Width = 121
            Height = 21
            DataField = 'N_Service'
            DataSource = ObjectsS
            TabOrder = 9
            OnEnter = DBEdit30Enter
            OnExit = DBEdit30Exit
          end
          object DBEdit31: TDBEdit
            Left = 124
            Top = 156
            Width = 41
            Height = 21
            DataField = 'Tvolym'
            DataSource = ObjectsS
            TabOrder = 10
            OnEnter = DBEdit31Enter
            OnExit = DBEdit31Exit
          end
          object cbBensin: TDBComboBox
            Left = 228
            Top = 156
            Width = 101
            Height = 21
            DataField = 'DType'
            DataSource = ObjectsS
            ItemHeight = 13
            TabOrder = 11
            OnEnter = cbBensinEnter
            OnExit = cbBensinExit
          end
          object DBEdit33: TDBEdit
            Left = 360
            Top = 156
            Width = 89
            Height = 21
            DataField = 'Color'
            DataSource = ObjectsS
            TabOrder = 12
            OnEnter = DBEdit33Enter
            OnExit = DBEdit33Exit
          end
          object cbPClass: TDBComboBox
            Left = 396
            Top = 180
            Width = 53
            Height = 21
            DataField = 'PriceClass'
            DataSource = ObjectsS
            ItemHeight = 13
            TabOrder = 13
            OnEnter = cbPClassEnter
            OnExit = cbPClassExit
          end
          object DBEdit37: TDBEdit
            Left = 396
            Top = 204
            Width = 37
            Height = 21
            TabStop = False
            DataField = 'Vstat'
            DataSource = ObjectsS
            TabOrder = 14
            OnEnter = DBEdit37Enter
            OnExit = DBEdit37Exit
          end
          object DBEdit34: TDBEdit
            Left = 124
            Top = 180
            Width = 209
            Height = 21
            DataField = 'Accesories'
            DataSource = ObjectsS
            TabOrder = 15
            OnEnter = DBEdit34Enter
            OnExit = DBEdit34Exit
          end
          object DBEdit35: TDBEdit
            Left = 232
            Top = 252
            Width = 281
            Height = 21
            DataField = 'KNOT1'
            DataSource = ObjectsS
            TabOrder = 16
            OnEnter = DBEdit35Enter
            OnExit = DBEdit35Exit
          end
          object DBEdit36: TDBEdit
            Left = 232
            Top = 276
            Width = 281
            Height = 21
            DataField = 'KNOT2'
            DataSource = ObjectsS
            TabOrder = 17
            OnEnter = DBEdit35Enter
            OnExit = DBEdit35Exit
          end
          object PaObjG: TPanel
            Left = 1
            Top = 1
            Width = 602
            Height = 416
            Align = alClient
            TabOrder = 18
            Visible = False
            object DBGrid2: TDBGrid
              Left = 1
              Top = 1
              Width = 600
              Height = 414
              Align = alClient
              DataSource = ObjectsS
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
      object tbBlock: TTabSheet
        Caption = 'Sp'#228'rr&lista'
        ImageIndex = 8
        TabVisible = False
        object Label70: TLabel
          Left = 16
          Top = 12
          Width = 70
          Height = 13
          Caption = 'Personnummer'
        end
        object Label71: TLabel
          Left = 16
          Top = 52
          Width = 28
          Height = 13
          Caption = 'Namn'
        end
        object Label72: TLabel
          Left = 16
          Top = 92
          Width = 32
          Height = 13
          Caption = 'Adress'
        end
        object Label74: TLabel
          Left = 264
          Top = 12
          Width = 54
          Height = 13
          Caption = 'Sp'#228'rrdatum'
        end
        object Label75: TLabel
          Left = 264
          Top = 52
          Width = 63
          Height = 13
          Caption = 'Sp'#228'rrdatum 2'
        end
        object Label76: TLabel
          Left = 264
          Top = 92
          Width = 19
          Height = 13
          Caption = 'Kod'
        end
        object Label77: TLabel
          Left = 20
          Top = 216
          Width = 52
          Height = 13
          Caption = 'Sp'#228'rrad av'
        end
        object DBNavigator9: TDBNavigator
          Left = 0
          Top = 393
          Width = 604
          Height = 25
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
          TabOrder = 0
        end
        object DBEdit107: TDBEdit
          Left = 24
          Top = 28
          Width = 121
          Height = 21
          Hint = 'Personnummer eller organisationsnummer'
          DataField = 'Pers_nr'
          TabOrder = 1
        end
        object DBEdit108: TDBEdit
          Left = 24
          Top = 68
          Width = 201
          Height = 21
          DataField = 'Namn'
          TabOrder = 2
        end
        object DBEdit109: TDBEdit
          Left = 24
          Top = 108
          Width = 197
          Height = 21
          Hint = 'Adress'
          DataField = 'Adr'
          TabOrder = 3
        end
        object DBEdit110: TDBEdit
          Left = 24
          Top = 132
          Width = 197
          Height = 21
          Hint = 'Postnummer och ort'
          DataField = 'Postort'
          TabOrder = 4
        end
        object DBEdit111: TDBEdit
          Left = 24
          Top = 156
          Width = 197
          Height = 21
          Hint = 'Land'
          DataField = 'Land'
          TabOrder = 5
        end
        object DBEdit112: TDBEdit
          Left = 272
          Top = 28
          Width = 73
          Height = 21
          DataField = 'Sparrdat'
          TabOrder = 6
        end
        object DBEdit113: TDBEdit
          Left = 272
          Top = 68
          Width = 73
          Height = 21
          DataField = 'Sparrdat2'
          TabOrder = 7
        end
        object DBEdit114: TDBEdit
          Left = 272
          Top = 108
          Width = 61
          Height = 21
          DataField = 'Kod'
          TabOrder = 8
        end
        object DBEdit115: TDBEdit
          Left = 28
          Top = 232
          Width = 77
          Height = 21
          DataField = 'Sign'
          Enabled = False
          TabOrder = 9
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 622
    Top = 33
    Width = 91
    Height = 456
    Align = alRight
    BevelInner = bvLowered
    ParentColor = True
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 8
      Top = 24
      Width = 75
      Height = 25
      Caption = '&OK'
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        CE070000424DCE07000000000000360000002800000024000000120000000100
        1800000000009807000000000000000000000000000000000000007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7FFFFFFF007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F7F00007F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7FFFFFFF
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F7F0000007F00007F007F0000007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        7F7F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F7F0000007F00007F00007F0000
        7F007F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F7F7F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F000000
        7F00007F00007F00007F00007F00007F007F0000007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F007F7F007F7F007F7F007F
        7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F7F0000007F00007F00007F0000FF00007F00007F00007F00007F00
        7F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFF
        FF007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F7F7F7FFFFFFF007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F00007F00007F0000FF00007F7F
        00FF00007F00007F00007F007F0000007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F7F7F7FFFFFFF007F7F7F7F7F007F7F7F7F7FFFFFFF007F7F00
        7F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F00FF00
        007F0000FF00007F7F007F7F007F7F00FF00007F00007F00007F007F0000007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7F007F7F00
        7F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F00FF00007F7F007F7F007F7F007F7F007F7F00FF
        00007F00007F00007F007F0000007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F7F7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F
        7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F00FF00007F00007F00007F007F0000007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00FF0000
        7F00007F00007F007F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F
        7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F00FF00007F00007F00007F007F0000007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00FF00007F00
        007F00007F007F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFF
        FFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F00FF00007F00007F007F0000007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F
        7F7FFFFFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00FF00007F00007F
        00007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F00FF00007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F}
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 8
      Top = 64
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Avbryt'
      TabOrder = 1
      OnClick = BitBtn3Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 713
    Height = 33
    ButtonHeight = 21
    Caption = 'ToolBar1'
    TabOrder = 2
    object SpeedButton3: TSpeedButton
      Left = 0
      Top = 2
      Width = 23
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnFace
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton3Click
    end
    object Splitter1: TSplitter
      Left = 23
      Top = 2
      Width = 10
      Height = 21
      ResizeStyle = rsNone
    end
    object BtnRecNo: TEdit
      Left = 33
      Top = 2
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = 'BtnRecNo'
    end
    object BtnFirst: TSpeedButton
      Left = 154
      Top = 2
      Width = 23
      Height = 21
      Hint = 'F'#246'rsta [Ctrl+PgUp]'
      Glyph.Data = {
        F6040000424DF60400000000000036040000280000000E0000000C0000000100
        080000000000C0000000C30E0000C30E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00BFBFBFBFBFBF
        BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBF0000BF
        BFBFBFBF00BFBFBF0000BFBFBF0000BFBFBFBF0000BFBFBF0000BFBFBF0000BF
        BFBF000000BFBFBF0000BFBFBF0000BFBF00000000BFBFBF0000BFBFBF0000BF
        BFBF000000BFBFBF0000BFBFBF0000BFBFBFBF0000BFBFBF0000BFBFBF0000BF
        BFBFBFBF00BFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBF0000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnFirstClick
    end
    object BtnMinEn: TSpeedButton
      Left = 177
      Top = 2
      Width = 23
      Height = 21
      Hint = 'F'#246'reg'#229'ende [PgUp]'
      Glyph.Data = {
        AE040000424DAE0400000000000036040000280000000C0000000A0000000100
        08000000000078000000C30E0000C30E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBF
        BFBF000000BFBFBFBFBFBFBFBF00000000BFBFBFBFBFBFBFBFBF000000BFBFBF
        BFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnMinEnClick
    end
    object BtnPlusen: TSpeedButton
      Left = 200
      Top = 2
      Width = 23
      Height = 21
      Hint = 'N'#228'sta  [PgDn]'
      Glyph.Data = {
        A2040000424DA20400000000000036040000280000000A000000090000000100
        0800000000006C000000C30E0000C30E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00BFBFBFBFBFBF
        BFBFBFBF0000BFBFBFBF00BFBFBFBFBF0000BFBFBFBF0000BFBFBFBF0000BFBF
        BFBF000000BFBFBF0000BFBFBFBF00000000BFBF0000BFBFBFBF000000BFBFBF
        0000BFBFBFBF0000BFBFBFBF0000BFBFBFBF00BFBFBFBFBF0000BFBFBFBFBFBF
        BFBFBFBF0000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnPlusenClick
    end
    object BtnLast: TSpeedButton
      Left = 223
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Sista [Ctrl+PgDn]'
      Glyph.Data = {
        E6040000424DE60400000000000036040000280000000E0000000B0000000100
        080000000000B0000000C30E0000C30E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00BFBFBFBFBFBF
        BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBF00BFBF
        BFBFBF0000BFBFBF0000BFBFBF0000BFBFBFBF0000BFBFBF0000BFBFBF000000
        BFBFBF0000BFBFBF0000BFBFBF00000000BFBF0000BFBFBF0000BFBFBF000000
        BFBFBF0000BFBFBF0000BFBFBF0000BFBFBFBF0000BFBFBF0000BFBFBF00BFBF
        BFBFBF0000BFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBF0000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnLastClick
    end
    object Splitter2: TSplitter
      Left = 246
      Top = 2
      Width = 10
      Height = 21
    end
    object BtnTotRecNo: TEdit
      Left = 256
      Top = 2
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = 'BtnTotRecNo'
    end
    object BtnNew: TSpeedButton
      Left = 377
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Ny [Ctrl+Ins]'
      Glyph.Data = {
        56050000424D5605000000000000360400002800000010000000120000000100
        08000000000020010000C30E0000C30E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBF0000000000000000000000BFBFBFBFBF00FFFFFF
        FFFFFFFFFFFF00BFBFBFBFBF00FFFFFFFFFFFFFFFFFF00BFBFBFBFBF00FFFFFF
        FFFFFFFFFFFF00BFBFBFBFBF00FFFFFFFFFFFFFFFFFF00BFBFBFBFBF00FFFFFF
        FFFFFFFFFFFF00BFBFBFBFBF00FFFFFFFFFFFFFFFFFF00BFBFBFBFBF00FFFFFF
        FFFFFFFFFFFF00BFBFBFBFBF00FFFFFFFFFFFFFFFFFF00BFBFBFBFBF00FFFFFF
        FFFFFF00000000BFBFBFBFBF00FFFFFFFFFFFF00FF00BFBFBFBFBFBF00FFFFFF
        FFFFFF0000BFBFBFBFBFBFBF0000000000000000BFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnNewClick
    end
    object BtnDel: TSpeedButton
      Left = 400
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Ta Bort  [Ctrl+Del]'
      Glyph.Data = {
        AA030000424DAA03000000000000360000002800000011000000110000000100
        18000000000074030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBF00BFB8BFBFB8BFBFB8BFBFB8BFBFB8BFBFB8BF
        BFB8BF4F484F4F484F4F484F000000000000BFB8BFBFB8BFBFB8BFBFB8BFBFBF
        BF00BFB8BFBFB8BFBFB8BFBFB8BFBFB8BF4F484F4F484FCFC8CFCFC8CF808080
        4F484F4F484F202020BFB8BFBFB8BFBFB8BFBFBFBF00BFB8BFBFB8BFBFB8BF4F
        484F4F484FCFC8CFCFC8CFCFC8CFCFC8CFCFC8CF4F484F4F484F000000BFB8BF
        BFB8BFBFB8BFBFBFBF00BFB8BFBFB8BF808080CFC8CFCFC8CFD0E0E0007800D0
        E0E0CFC8CFCFC8CF6060604F484F4F484F000000BFB8BFBFB8BFBFBFBF00BFB8
        BFBFB8BF808080D0E0E0D0E0E0007800007800007800609060CFC8CF80808060
        60604F484F000000BFB8BFBFB8BFBFBFBF00BFB8BFBFB8BF808080D0E0E02F90
        2FBFB8BF007800D0E0E0007800CFC8CF8080806060606060604F484F000000BF
        B8BFBFBFBF00BFB8BF808080D0E0E0BFB8BF007800BFB8BFD0E0E0D0E0E0D0E0
        E0D0E0E0CFC8CF707070606060606060000000BFB8BFBFBFBF00BFB8BF808080
        D0E0E02F902F007800007800BFB8BF007800007800D0E0E0CFC8CF8080806060
        606060600000004F484FBFBFBF00BFB8BF808080D0E0E0D0E0E0007800BFB8BF
        D0E0E0808080007800BFB8BFCFC8CF8080808080806060606060604F484FBFBF
        BF00808080D0E0E0D0E0E0D0E0E0D0E0E02F902F2F902FCFC8CFF0F0F0F0F0F0
        F0F0F0F0F0F08080808080806060604F484FBFBFBF00808080D0E0E0D0E0E0CF
        C8CFCFC8CFCFC8CFF0F0F0F0F0F05050508080808FA0AFCFC8CFF0F0F0808080
        8080804F484FBFBFBF00808080CFC8CFCFC8CFF0F0F0F0F0F080808050505050
        50508080808FA0AFCFC8CFCFC8CFCFC8CFF0F0F08080804F484FBFBFBF008080
        80F0F0F0F0F0F00000000000005050505050508080808FA0AFCFC8CFF0F0F0F0
        F0F0808080808080BFB8BFBFB8BFBFBFBF008080808080800000000000005050
        505050508080808FA0AFF0F0F0F0F0F0808080808080BFB8BFBFB8BFBFB8BFBF
        B8BFBFBFBF00BFB8BFBFB8BF808080808080505050808080F0F0F0F0F0F08080
        80808080BFB8BFBFB8BFBFB8BFBFB8BFBFB8BFBFB8BFBFBFBF00BFB8BFBFB8BF
        BFB8BFBFB8BF808080808080808080808080BFB8BFBFB8BFBFB8BFBFB8BFBFB8
        BFBFB8BFBFB8BFBFB8BFBFBFBF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnDelClick
    end
    object BtnSave: TSpeedButton
      Left = 423
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Spara  [Ctrl+Enter]'
      Enabled = False
      Glyph.Data = {
        AA040000424DAA04000000000000360000002800000014000000130000000100
        18000000000074040000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000008780008780
        000000000000000000000000000000000000C0C7C0C0C7C00000000087800000
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000878000878000000000
        0000000000000000000000000000C0C7C0C0C7C0000000008780000000BFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000000087800087800000000000000000
        00000000000000000000C0C7C0C0C7C0000000008780000000BFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF000000008780008780000000000000000000000000
        000000000000000000000000000000008780000000BFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF00000000878000878000878000878000878000878000878000
        8780008780008780008780008780000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBF0000000087800087800000000000000000000000000000000000000000
        00000000008780008780000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00
        0000008780000000C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0
        000000008780000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000000087
        80000000C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C000000000
        8780000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000008780000000
        C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C00000000087800000
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000008780000000C0C7C0C0
        C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0000000008780000000BFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000008780000000C0C7C0C0C7C0C0C7
        C0C0C7C0C0C7C0C0C7C0C0C7C0C0C7C0000000000000000000BFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF000000008780000000C0C7C0C0C7C0C0C7C0C0C7C0
        C0C7C0C0C7C0C0C7C0C0C7C0000000C0C7C0000000BFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnSaveClick
    end
    object BtnCan: TSpeedButton
      Left = 446
      Top = 2
      Width = 23
      Height = 21
      Hint = #197'ngra  [Ctrl+Home]'
      Enabled = False
      Glyph.Data = {
        76030000424D7603000000000000360000002800000011000000100000000100
        18000000000040030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BF00BFBFBFBFBFBF000000000000000000000000000000000000000000BFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBF000000BFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000000000BFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF00BFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBF00000000BFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBF
        BF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000BFBF00BFBF00
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBF000000FFFFFF00FF
        FFFFFFFF00FFFFFFFFFF00FFFF00000000BFBF00BFBF000000BFBFBFBFBFBFBF
        BFBFBFBFBF00BFBFBFBFBFBFBFBFBF000000FFFFFF00FFFFFFFFFF00FFFFFFFF
        FF00FFFF00000000BFBF00BFBF000000BFBFBFBFBFBFBFBFBF00BFBFBFBFBFBF
        BFBFBFBFBFBF000000FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00000000BF
        BF00BFBF000000BFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00000000BFBF000000BFBFBFBFBF
        BF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000FFFFFF00FFFFFFFFFF
        00FFFFFFFFFF00FFFF000000000000BFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF000000FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF
        000000BFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBF000000000000000000000000000000000000BFBFBFBFBFBFBFBFBF00BFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnCanClick
    end
    object BtnUpd: TSpeedButton
      Left = 469
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Uppdatera'
      Glyph.Data = {
        66030000424D660300000000000036000000280000000F000000110000000100
        18000000000030030000C30E0000C30E00000000000000000000232323181819
        1B18191C18191C18181B18191D18181A18191D18181B18191C18181C18191B18
        18212222252525000000292A295552504853524553524353534B52513E545458
        585E3E54544B52514353534553524B5454322E2D212222000000403F3EF6FFFD
        C7FFFFC7FFFFC5FFFFCBFFFFCAFFFFB3EBCEC0FFFFCBFFFFC5FFFFC7FFFFD3FF
        FF4D54531A1818000000403E3DE6FBF4BCFCF8C0FBF7C0FAF6CBFFFF95D5AC0F
        9C39D1FFFFC8FFFFC0FAF6C0FBF7C8FFFF4353521C1818000000403E3DE8FBF4
        BDFCF8C0FBF7C7FEFD86D0A10191230098303DBC798ED9B3C9FFFFC0FBF7C9FF
        FF4553521C18180000003F3E3DEDFAF3C0FBF8C0FBF8C3FDFC9CDDBB0E962F00
        9C3A43C37E43810DBAC19AC1FEFCCCFFFF4A52511B1919000000413E3DE2FBF5
        BAFCF8C1FBF7C2FBF7C6FFFFA9E1C31FA247D0FFFF6DAC6B72934BCDFFFFC6FF
        FF4053531C18180000003F3E3DF1FAF3C1FBF8C0FBF8BAFAF6C5FAF5BDFFFFC1
        EDDDBCFFFFB3C7A28E9851C5FFFFCDFFFF4E52511A1919000000423E3DDFFBF6
        B6FCF9CDFFFE73A1628DCCABD2FFFFA6FAF4D3FDFCB8F6F0C4F2E8C1FBF8C5FF
        FF3D53531D18180000003D3E3DF8F9F2CFFAF6C1FFFF859046AAAF72BCFFFF13
        A9548BECDBD6FFFFBCFEFCBFFBF8CDFFFF4E52511A19190000003D3E3DF3FAF3
        F9F6EFD2FDFB93BC9441800B89C7870D9C3A039C3985E5CCC8FBF8CAFFFFD4FF
        FF4157571C17170000003D3E3DF3FAF3EFF7F0F3F6EFFFFFFF82CF9F46AF6002
        972E008F204BCB98DDFFFF9BDFDD91A9A94841401D1D1D0000003D3E3DF3FAF3
        F0F7F0F0F7F0EFF6EFFFFDFDFFFDFC099A334ED0A0DEFFFF9BD8D8233E3E0000
        001E1F1F1A1A1A0000003D3E3DF3FAF3F0F7F0F0F7F0F0F7F0F0F7F0EAF5ED69
        DCB9D1FFFFCBFFFF758E8B4D4543B3B4B42627266666660000003D3E3DF4FBF4
        F1F8F1F1F8F1F1F8F1F1F8F1F1F8F2DDFFFFB9FDFAD4FFFF5F8E8DA19F9B9D9F
        9D6A696AC6C6C60000003D3E3DF6FDF6F3FAF3F3FAF3F3FAF3F3FAF3F3FAF3F8
        FAF1CEFDF9C7FFFF8FA29F222020656665C3C3C3C5C5C50000002727273E3F3E
        3D3E3D3D3E3D3D3E3D3D3E3D3D3E3D3F3E3D3D3E3D353F3F2C28275F5F5FC4C4
        C4C5C5C5BEBEBE000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnUpdClick
    end
    object Splitter3: TSplitter
      Left = 492
      Top = 2
      Width = 10
      Height = 21
    end
    object BtnFilter: TSpeedButton
      Left = 502
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Filtrera enl markering'
      Enabled = False
      Glyph.Data = {
        46040000424D4604000000000000360000002800000011000000140000000100
        18000000000010040000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000000000
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF7F7F7F00FFFF000000000000BFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBF7F7F7F00FFFF000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7FFFFFFF00FFFF00
        0000000000BFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7FFFFFFF00FFFF000000000000BFBFBFBF
        BFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000000000
        00000000000000FFFFFF00FFFF000000000000BFBFBFBFBFBF00BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7FFFFFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF000000000000BFBFBF00BFBFBFBFBFBFBFBFBFBFBFBF000000000000
        000000BFBFBF7F7F7FFFFFFF00FFFF000000000000BFBFBFBFBFBFBFBFBFBFBF
        BF00BFBFBFBFBFBFBFBFBFBFBFBF0000007F7F00000000BFBFBFBFBFBF7F7F7F
        FFFFFF00FFFF000000000000BFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBF
        BFBF000000BFBFBF000000BFBFBFBFBFBF7F7F7FFFFFFF00FFFF00FFFF000000
        000000BFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF000000BF
        BFBFBFBFBFBFBFBF7F7F7FFFFFFF00FFFF00FFFF000000000000BFBFBF00BFBF
        BFBFBFBFBFBFBF000000BFBFBFBFBFBF7F7F00000000BFBFBFBFBFBFBFBFBF7F
        7F7FFFFFFF00FFFF00FFFF000000BFBFBF00BFBFBFBFBFBF000000BFBFBFBFBF
        BFBFBFBFBFBFBF7F7F00000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBF00BFBFBF0000007F7F00FFFFFFFFFFFFBFBFBFBFBFBFBFBFBF7F7F
        00000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000
        000000000000000000000000000000000000000000000000000000BFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnFilterClick
    end
    object BtnASC: TSpeedButton
      Left = 525
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Sortera enl markering'
      Enabled = False
      Glyph.Data = {
        96030000424D9603000000000000360000002800000010000000120000000100
        18000000000060030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00007F00007F00007FBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF7F7F7F0000007F7F7FBFBFBFBFBFBFBFBFBFBFBFBF
        00007FBFBFBFBFBFBFBFBFBF00007FBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F0000
        007F7F7FBFBFBFBFBFBFBFBFBFBFBFBF00007FBFBFBFBFBFBFBFBFBF00007FBF
        BFBFBFBFBFBFBFBFBFBFBF000000000000000000BFBFBFBFBFBFBFBFBFBFBFBF
        00007FBFBFBFBFBFBFBFBFBF00007FBFBFBFBFBFBFBFBFBF7F7F7F0000000000
        000000007F7F7FBFBFBFBFBFBFBFBFBFBFBFBF00007F00007F00007FBFBFBFBF
        BFBFBFBFBFBFBFBF000000000000000000000000000000BFBFBFBFBFBFBFBFBF
        00007F00007FBFBFBF00007F00007FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00007F00007FBFBFBF00007F00007FBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00BFBFBFBFBFBFBFBFBFBFBFBF7F00007F00007F0000BFBFBF7F00007F00007F
        0000BFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF7F7F7F
        7F0000BFBFBFBFBFBFBFBFBF7F00007F7F7FBFBFBFBFBFBFBFBFBFBFBFBF0000
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F00007F00007F00007F00007F0000BF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        7F7F7F7F0000BFBFBF7F00007F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F00007F00007F0000BFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBF7F7F7F7F00007F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F0000BFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnASCClick
    end
    object BtnDESC: TSpeedButton
      Left = 548
      Top = 2
      Width = 23
      Height = 21
      Hint = 'Sortera enl markering'
      Enabled = False
      Glyph.Data = {
        22030000424D220300000000000036000000280000000E000000110000000100
        180000000000EC020000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBF00007F00007F00007F0000BFBFBF7F00007F00007F0000BFBFBFBFBF
        BFBFBFBF7F7F7F0000007F7F7FBFBFBF00007F7F7F7F0000BFBFBFBFBFBFBFBF
        BF7F00007F7F7FBFBFBFBFBFBFBFBFBF7F7F7F0000007F7F7FBFBFBF0000BFBF
        BF7F00007F00007F00007F00007F0000BFBFBFBFBFBFBFBFBFBFBFBF00000000
        0000000000BFBFBF0000BFBFBF7F7F7F7F0000BFBFBF7F00007F7F7FBFBFBFBF
        BFBFBFBFBF7F7F7F0000000000000000007F7F7F0000BFBFBFBFBFBF7F00007F
        00007F0000BFBFBFBFBFBFBFBFBFBFBFBF000000000000000000000000000000
        0000BFBFBFBFBFBF7F7F7F7F00007F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBF000000BFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBF7F0000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF0000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBF
        BFBFBFBF0000BFBFBFBFBFBF00007F00007F00007FBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF000000BFBFBFBFBFBF0000BFBFBF00007FBFBFBFBFBFBFBFBF
        BF00007FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF0000BFBF
        BF00007FBFBFBFBFBFBFBFBFBF00007FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00
        0000BFBFBFBFBFBF0000BFBFBF00007FBFBFBFBFBFBFBFBFBF00007FBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF0000BFBFBFBFBFBF00007F00
        007F00007FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF
        0000BFBFBF00007F00007FBFBFBF00007F00007FBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBF000000BFBFBFBFBFBF0000BFBFBF00007F00007FBFBFBF00007F00007F
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF0000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBF0000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnDESCClick
    end
  end
  object ObjectsS: TDataSource
    DataSet = ObjectsT
    OnStateChange = ObjectsSStateChange
    Left = 436
    Top = 108
  end
  object CustomerS: TDataSource
    DataSet = CustomerT
    OnStateChange = CustomerSStateChange
    Left = 428
    Top = 40
  end
  object CardsS: TDataSource
    DataSet = CardsT
    Left = 556
    Top = 40
  end
  object ObjTypeS: TDataSource
    DataSet = ObjTypeT
    Left = 588
    Top = 116
  end
  object PriceTabS: TDataSource
    DataSet = PriceTabT
    Left = 588
    Top = 160
  end
  object SignrS: TDataSource
    DataSet = SignrT
    Left = 588
    Top = 196
  end
  object DrivMS: TDataSource
    DataSet = DrivMT
    Left = 588
    Top = 260
  end
  object TtypS: TDataSource
    DataSet = TtypT
    Left = 588
    Top = 224
  end
  object CostsS: TDataSource
    DataSet = CostsT
    Left = 588
    Top = 296
  end
  object PriceTabRowsS: TDataSource
    DataSet = PriceTabRowsT
    Left = 668
    Top = 280
  end
  object CardsT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    AfterPost = CardsTAfterPost
    AfterCancel = CardsTAfterCancel
    TableName = 'Cards'
    Left = 513
    Top = 29
    object CardsTTyp: TWideStringField
      FieldName = 'Typ'
      Size = 3
    end
    object CardsTTypNamn: TWideStringField
      FieldName = 'TypNamn'
    end
    object CardsTPreNr: TIntegerField
      FieldName = 'PreNr'
    end
    object CardsTCheck: TWideStringField
      FieldName = 'Check'
      Size = 15
    end
    object CardsTTelNr: TWideStringField
      FieldName = 'TelNr'
      Size = 15
    end
  end
  object ObjectsT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorType = ctDynamic
    AfterInsert = ObjectsTAfterInsert
    AfterScroll = ObjectsTAfterScroll
    TableName = 'Objects'
    Left = 393
    Top = 110
    object ObjectsTReg_No: TWideStringField
      FieldName = 'Reg_No'
      Size = 10
    end
    object ObjectsTObjNum: TSmallintField
      FieldName = 'ObjNum'
    end
    object ObjectsTModel: TWideStringField
      FieldName = 'Model'
    end
    object ObjectsTType: TWideStringField
      FieldName = 'Type'
      Size = 4
    end
    object ObjectsTKM_N: TIntegerField
      FieldName = 'KM_N'
    end
    object ObjectsTKM_Service: TIntegerField
      FieldName = 'KM_Service'
    end
    object ObjectsTN_Service: TIntegerField
      FieldName = 'N_Service'
    end
    object ObjectsTOut_KM: TIntegerField
      FieldName = 'Out_KM'
    end
    object ObjectsTTvolym: TSmallintField
      FieldName = 'Tvolym'
    end
    object ObjectsTDrvm_km: TFloatField
      FieldName = 'Drvm_km'
    end
    object ObjectsTDType: TWideStringField
      FieldName = 'DType'
      Size = 10
    end
    object ObjectsTColor: TWideStringField
      FieldName = 'Color'
      Size = 10
    end
    object ObjectsTAccesories: TWideStringField
      FieldName = 'Accesories'
      Size = 25
    end
    object ObjectsTPriceClass: TWideStringField
      FieldName = 'PriceClass'
      Size = 2
    end
    object ObjectsTStatus: TFloatField
      FieldName = 'Status'
    end
    object ObjectsTKNOT1: TWideStringField
      FieldName = 'KNOT1'
      Size = 48
    end
    object ObjectsTKNOT2: TWideStringField
      FieldName = 'KNOT2'
      Size = 48
    end
    object ObjectsTNOTE: TMemoField
      FieldName = 'NOTE'
      BlobType = ftMemo
    end
    object ObjectsTSRiskKonto: TIntegerField
      FieldName = 'SRiskKonto'
    end
    object ObjectsTHyrKonto: TIntegerField
      FieldName = 'HyrKonto'
    end
    object ObjectsTKmKonto: TIntegerField
      FieldName = 'KmKonto'
    end
    object ObjectsTXHyrKonto: TIntegerField
      FieldName = 'XHyrKonto'
    end
    object ObjectsTXKmKonto: TIntegerField
      FieldName = 'XKmKonto'
    end
    object ObjectsTTimKonto: TIntegerField
      FieldName = 'TimKonto'
    end
    object ObjectsTVStat: TFloatField
      FieldName = 'VStat'
    end
    object ObjectsTLDatum: TDateField
      FieldName = 'LDatum'
    end
    object ObjectsTLKM: TSmallintField
      FieldName = 'LKM'
    end
    object ObjectsTLkmStart: TIntegerField
      FieldName = 'LkmStart'
    end
  end
  object CustomerT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorType = ctStatic
    AfterInsert = CustomerTAfterInsert
    BeforePost = CustomerTBeforePost
    AfterScroll = CustomerTAfterScroll
    TableName = 'Customer'
    Left = 393
    Top = 40
    object CustomerTCust_Id: TIntegerField
      FieldName = 'Cust_Id'
    end
    object CustomerTName: TWideStringField
      FieldName = 'Name'
      Size = 30
    end
    object CustomerTContact: TWideStringField
      FieldName = 'Contact'
      Size = 30
    end
    object CustomerTCo_Adr: TWideStringField
      FieldName = 'Co_Adr'
      Size = 30
    end
    object CustomerTAdress: TWideStringField
      FieldName = 'Adress'
      Size = 30
    end
    object CustomerTPostal_Name: TWideStringField
      FieldName = 'Postal_Name'
      Size = 30
    end
    object CustomerTCountry: TWideStringField
      FieldName = 'Country'
    end
    object CustomerTOrg_No: TWideStringField
      FieldName = 'Org_No'
      Size = 11
    end
    object CustomerTTel_1: TWideStringField
      FieldName = 'Tel_1'
      Size = 1
    end
    object CustomerTTel_Nr_1: TWideStringField
      FieldName = 'Tel_Nr_1'
      Size = 15
    end
    object CustomerTTel_2: TWideStringField
      FieldName = 'Tel_2'
      Size = 1
    end
    object CustomerTTel_Nr_2: TWideStringField
      FieldName = 'Tel_Nr_2'
      Size = 15
    end
    object CustomerTTel_3: TWideStringField
      FieldName = 'Tel_3'
      Size = 1
    end
    object CustomerTTel_Nr_3: TWideStringField
      FieldName = 'Tel_Nr_3'
      Size = 15
    end
    object CustomerTUtlandsk: TBooleanField
      FieldName = 'Utlandsk'
    end
    object CustomerTKTyp: TWideStringField
      FieldName = 'KTyp'
      Size = 3
    end
    object CustomerTKontoNr: TWideStringField
      FieldName = 'KontoNr'
    end
    object CustomerTKExp: TWideStringField
      FieldName = 'KExp'
      Size = 5
    end
    object CustomerTPtyp: TWideStringField
      FieldName = 'Ptyp'
      Size = 2
    end
    object CustomerTNot: TMemoField
      FieldName = 'Not'
      BlobType = ftMemo
    end
    object CustomerTPayment: TWideStringField
      FieldName = 'Payment'
      Size = 1
    end
    object CustomerTTerms_Pay: TSmallintField
      FieldName = 'Terms_Pay'
    end
    object CustomerTKundFdrKonto: TIntegerField
      FieldName = 'KundFdrKonto'
    end
    object CustomerTIKonto: TIntegerField
      FieldName = 'IKonto'
    end
    object CustomerTIKStalle: TIntegerField
      FieldName = 'IKStalle'
    end
    object CustomerTSamlingsFaktura: TBooleanField
      FieldName = 'SamlingsFaktura'
    end
    object CustomerTInt_Cust: TBooleanField
      FieldName = 'Int_Cust'
    end
    object CustomerTIns_Comp: TBooleanField
      FieldName = 'Ins_Comp'
    end
    object CustomerTDelfaktureras: TBooleanField
      FieldName = 'Delfaktureras'
    end
    object CustomerTDriver: TBooleanField
      FieldName = 'Driver'
    end
    object CustomerTCust_Koncern: TBooleanField
      FieldName = 'Cust_Koncern'
    end
  end
  object ObjTypeT: TADOTable
    Connection = DmSession.ADOConnection1
    AfterInsert = ObjTypeTAfterInsert
    TableName = 'ObjType'
    Left = 553
    Top = 121
  end
  object PriceTabT: TADOTable
    Connection = DmSession.ADOConnection1
    BeforeInsert = PriceTabTBeforeInsert
    AfterPost = PriceTabTAfterPost
    AfterScroll = PriceTabTAfterScroll
    TableName = 'PriceTab'
    Left = 553
    Top = 155
    object PriceTabTPriceId: TAutoIncField
      FieldName = 'PriceId'
    end
    object PriceTabTPKLASS: TWideStringField
      FieldName = 'PKLASS'
      Size = 2
    end
    object PriceTabTPTYP: TWideStringField
      FieldName = 'PTYP'
      Size = 2
    end
    object PriceTabTFDAT: TDateField
      FieldName = 'FDAT'
    end
    object PriceTabTPNAMN: TWideStringField
      FieldName = 'PNAMN'
      Size = 30
    end
    object PriceTabTTDAT: TDateField
      FieldName = 'TDAT'
    end
    object PriceTabTSR_DYGN: TFloatField
      FieldName = 'SR_DYGN'
    end
    object PriceTabTSR_DAG1: TFloatField
      FieldName = 'SR_DAG1'
    end
    object PriceTabTSR_MAX1: TFloatField
      FieldName = 'SR_MAX1'
    end
    object PriceTabTSR_DAG2: TFloatField
      FieldName = 'SR_DAG2'
    end
    object PriceTabTSR_MAX2: TFloatField
      FieldName = 'SR_MAX2'
    end
    object PriceTabTSR_OVERDYGN: TFloatField
      FieldName = 'SR_OVERDYGN'
    end
    object PriceTabTPRIS_TIM: TFloatField
      FieldName = 'PRIS_TIM'
    end
    object PriceTabTKOST_TIM: TFloatField
      FieldName = 'KOST_TIM'
    end
    object PriceTabTSRiskKonto: TIntegerField
      FieldName = 'SRiskKonto'
    end
    object PriceTabTHyrKonto: TIntegerField
      FieldName = 'HyrKonto'
    end
    object PriceTabTKmKonto: TIntegerField
      FieldName = 'KmKonto'
    end
    object PriceTabTXHyrKonto: TIntegerField
      FieldName = 'XHyrKonto'
    end
    object PriceTabTXKmKonto: TIntegerField
      FieldName = 'XKmKonto'
    end
    object PriceTabTTimKonto: TIntegerField
      FieldName = 'TimKonto'
    end
    object PriceTabTInkMoms: TBooleanField
      FieldName = 'InkMoms'
    end
    object PriceTabTPriceInfo: TMemoField
      FieldName = 'PriceInfo'
      BlobType = ftMemo
    end
    object PriceTabTCdr_Def: TBooleanField
      FieldName = 'Cdr_Def'
    end
  end
  object SignrT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorLocation = clUseServer
    TableName = 'Signr'
    Left = 553
    Top = 196
    object SignrTSIGN: TWideStringField
      FieldName = 'SIGN'
      Size = 8
    end
    object SignrTNAMN: TWideStringField
      FieldName = 'NAMN'
      Size = 30
    end
    object SignrTC_O_ADR: TWideStringField
      FieldName = 'C_O_ADR'
      Size = 30
    end
    object SignrTADRESS: TWideStringField
      FieldName = 'ADRESS'
      Size = 30
    end
    object SignrTPNR: TWideStringField
      FieldName = 'PNR'
      Size = 6
    end
    object SignrTORT: TWideStringField
      FieldName = 'ORT'
      Size = 16
    end
    object SignrTPERS_NR: TWideStringField
      FieldName = 'PERS_NR'
      Size = 11
    end
    object SignrTTEL_1: TWideStringField
      FieldName = 'TEL_1'
      Size = 1
    end
    object SignrTTEL_NR_1: TWideStringField
      FieldName = 'TEL_NR_1'
      Size = 15
    end
    object SignrTTEL_2: TWideStringField
      FieldName = 'TEL_2'
      Size = 1
    end
    object SignrTTEL_NR_2: TWideStringField
      FieldName = 'TEL_NR_2'
      Size = 15
    end
    object SignrTPROVIS_D: TFloatField
      FieldName = 'PROVIS_D'
    end
    object SignrTPROVIS_P: TFloatField
      FieldName = 'PROVIS_P'
    end
    object SignrTAVD: TWideStringField
      FieldName = 'AVD'
      Size = 30
    end
    object SignrTKAT: TWideStringField
      FieldName = 'KAT'
      Size = 15
    end
    object SignrTKTJ_GRP: TWideStringField
      FieldName = 'KTJ_GRP'
      Size = 1
    end
    object SignrTKSTLLE: TFloatField
      FieldName = 'KST'#196'LLE'
    end
    object SignrTPassword: TWideStringField
      FieldName = 'Password'
      Size = 15
    end
    object SignrTPwd_sign: TWideStringField
      FieldName = 'Pwd_sign'
      Size = 8
    end
  end
  object TtypT: TADOTable
    Connection = DmSession.ADOConnection1
    TableName = 'Ttyp'
    Left = 553
    Top = 229
    object TtypTTeletyp: TWideStringField
      FieldName = 'Teletyp'
      Size = 1
    end
    object TtypTTelebeskrivning: TWideStringField
      FieldName = 'Telebeskrivning'
      Size = 25
    end
  end
  object DrivMT: TADOTable
    Connection = DmSession.ADOConnection1
    TableName = 'DrivM'
    Left = 553
    Top = 263
    object DrivMTID: TWideStringField
      FieldName = 'ID'
      Size = 3
    end
    object DrivMTNamn: TWideStringField
      FieldName = 'Namn'
      Size = 50
    end
    object DrivMTKostnad: TBCDField
      FieldName = 'Kostnad'
      Precision = 19
    end
  end
  object CostsT: TADOTable
    Connection = DmSession.ADOConnection1
    TableName = 'Costs'
    Left = 553
    Top = 296
    object CostsTCost_ID: TAutoIncField
      FieldName = 'Cost_ID'
    end
    object CostsTCostname: TWideStringField
      FieldName = 'Costname'
      Size = 50
    end
    object CostsTNo: TFloatField
      FieldName = 'No'
    end
    object CostsTPrice: TBCDField
      FieldName = 'Price'
      Precision = 19
    end
    object CostsTVAT: TFloatField
      FieldName = 'VAT'
    end
    object CostsTAcc_code: TIntegerField
      FieldName = 'Acc_code'
    end
    object CostsTAcc_center: TIntegerField
      FieldName = 'Acc_center'
    end
  end
  object PriceTabRowsT: TADOTable
    Connection = DmSession.ADOConnection1
    CursorType = ctStatic
    BeforeInsert = PriceTabRowsTBeforeInsert
    AfterInsert = PriceTabRowsTAfterInsert
    IndexFieldNames = 'PriceId'
    TableName = 'PriceTabRows'
    Left = 640
    Top = 280
    object PriceTabRowsTPriceId: TIntegerField
      FieldName = 'PriceId'
    end
    object PriceTabRowsTRowNum: TIntegerField
      FieldName = 'RowNum'
    end
    object PriceTabRowsTMINDAG: TSmallintField
      FieldName = 'MINDAG'
    end
    object PriceTabRowsTPRISDAG: TSmallintField
      FieldName = 'PRISDAG'
    end
    object PriceTabRowsTKOST: TBCDField
      FieldName = 'KOST'
      Precision = 19
    end
    object PriceTabRowsTINKL_KM: TSmallintField
      FieldName = 'INKL_KM'
    end
    object PriceTabRowsTOVERKM: TFloatField
      FieldName = 'OVERKM'
    end
    object PriceTabRowsTXDYGN: TSmallintField
      FieldName = 'XDYGN'
    end
    object PriceTabRowsTXINKLKM: TFloatField
      FieldName = 'XINKLKM'
    end
  end
  object Q1: TADOQuery
    Connection = DmSession.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT ObjType.ID, ObjType.Type, Objects.Reg_No, Objects.Model'
      'FROM ObjType LEFT JOIN Objects ON ObjType.ID = Objects.Type'
      'WHERE (((ObjType.ID)>'#39'!'#39'))'
      'ORDER BY ObjType.ID, Objects.Reg_No;')
    Left = 649
    Top = 101
  end
  object Q2Cust: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'Select * from Customer;')
    Left = 647
    Top = 136
  end
  object Q3PKlass: TADOQuery
    Connection = DmSession.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'SELECT PriceTab.PKLASS, PriceTab.PTYP'
      'FROM PriceTab'
      'ORDER BY PriceTab.PKLASS;')
    Left = 655
    Top = 176
  end
  object ImageList1: TImageList
    Left = 336
    Top = 34
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF0084000000840000008400
      000084000000FFFFFF00C6C6C600FFFFFF008400000084000000840000008400
      00008400000084000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000FFFFFF000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF0084000000840000008400
      000084000000FFFFFF00C6C6C600FFFFFF008400000084000000840000008400
      0000840000008400000084000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF0084000000840000008400
      000084000000FFFFFF00C6C6C600FFFFFF008400000084000000840000008400
      00008400000084000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600FFFF
      FF00C6C6C600C6C6C60084848400848484000000000000000000FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0084000000840000008400
      000084000000FFFFFF00C6C6C600FFFFFF008400000084000000840000008400
      0000840000008400000084000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000840000008400000084000000840000008400000084000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0084000000840000008400
      000084000000FFFFFF00C6C6C600FFFFFF008400000084000000840000008400
      00008400000084000000FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000840000008400000084000000840000008400000084000000000000000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0084000000840000008400
      000084000000FFFFFF00C6C6C600FFFFFF008400000084000000840000008400
      0000840000008400000084000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600FFFF
      FF00C6C6C600C6C6C60084848400FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF800000088007FFFF80000C00
      80070000A000662080070000A000000080070000A000000080070000A0000000
      80070000A000000080070000A000000080470000A000000088A20000A0000000
      855C0000A000000082BE0000A0001010FD7E0000BFFC3353FEFC000080005720
      FF02000080000000FFFFFFFFFFFF470200000000000000000000000000000000
      000000000000}
  end
end
