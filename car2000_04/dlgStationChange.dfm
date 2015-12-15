object StationChangeDlg: TStationChangeDlg
  Left = 420
  Top = 419
  BorderStyle = bsDialog
  Caption = 'Objektsflytt'
  ClientHeight = 199
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label112: TLabel
    Left = 16
    Top = 16
    Width = 60
    Height = 13
    Caption = 'Reg.nummer'
  end
  object Label119: TLabel
    Left = 176
    Top = 16
    Width = 73
    Height = 13
    Caption = 'Objektsnummer'
  end
  object Label145: TLabel
    Left = 16
    Top = 48
    Width = 21
    Height = 13
    Caption = 'Fr'#229'n'
  end
  object Label1: TLabel
    Left = 16
    Top = 80
    Width = 13
    Height = 13
    Caption = 'Till'
  end
  object Label2: TLabel
    Left = 16
    Top = 112
    Width = 17
    Height = 13
    Caption = 'N'#228'r'
  end
  object DBEdit97: TDBEdit
    Left = 88
    Top = 8
    Width = 61
    Height = 21
    CharCase = ecUpperCase
    DataField = 'Reg_No'
    DataSource = frmGReg.ObjectsS
    Enabled = False
    TabOrder = 0
  end
  object DBEdit98: TDBEdit
    Left = 264
    Top = 8
    Width = 65
    Height = 21
    DataField = 'ObjNum'
    DataSource = frmGReg.ObjectsS
    Enabled = False
    TabOrder = 1
  end
  object dtpChangeDate: TDateTimePicker
    Left = 56
    Top = 104
    Width = 121
    Height = 21
    Date = 39625.000000000000000000
    Time = 39625.000000000000000000
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 88
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Flytta'
    TabOrder = 3
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Avbryt'
    TabOrder = 4
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 56
    Top = 72
    Width = 121
    Height = 21
    DataField = 'Station'
    DataSource = frmGReg.ObjectsS
    KeyField = 'StationId'
    ListField = 'Name'
    ListSource = frmGReg.StationS
    TabOrder = 5
  end
  object edFromStation: TEdit
    Left = 56
    Top = 40
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 6
    Text = 'edFromStation'
  end
end
