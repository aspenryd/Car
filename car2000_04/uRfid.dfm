object Form1: TForm1
  Left = 192
  Top = 114
  Width = 870
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AdTerminal1: TAdTerminal
    Left = 192
    Top = 136
    Width = 300
    Height = 200
    CaptureFile = 'APROTERM.CAP'
    ComPort = ApdComPort1
    Scrollback = False
    Color = clBlack
    Emulator = AdVT100Emulator1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -12
    Font.Name = 'Terminal'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
  end
  object edit1: TMemo
    Tag = 1
    Left = 328
    Top = 392
    Width = 185
    Height = 25
    TabOrder = 1
  end
  object AdVT100Emulator1: TAdVT100Emulator
    Terminal = AdTerminal1
    Answerback = 'APROterm'
    DisplayUpperASCII = False
    OnProcessChar = AdVT100Emulator1ProcessChar
    Left = 584
    Top = 184
  end
  object ApdComPort1: TApdComPort
    ComNumber = 1
    Baud = 9600
    PromptForPort = False
    TraceName = 'APRO.TRC'
    LogName = 'APRO.LOG'
    Left = 208
    Top = 392
  end
end
