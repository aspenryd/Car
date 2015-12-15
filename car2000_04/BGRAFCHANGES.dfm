object FrmGrid: TFrmGrid
  Left = 208
  Top = 228
  Width = 696
  Height = 480
  Caption = 'Ändra griden'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 176
      Top = 12
      Width = 56
      Height = 13
      Caption = 'Dygnslängd'
    end
    object Label4: TLabel
      Left = 420
      Top = 12
      Width = 56
      Height = 13
      Caption = 'Objektshöjd'
    end
    object TrackBar1: TTrackBar
      Left = 248
      Top = 4
      Width = 158
      Height = 37
      Max = 120
      Min = 20
      Orientation = trHorizontal
      Frequency = 1
      Position = 64
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsNone
    end
    object TrackBar2: TTrackBar
      Left = 493
      Top = 4
      Width = 157
      Height = 37
      Max = 30
      Min = 10
      Orientation = trHorizontal
      Frequency = 1
      Position = 24
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      TickMarks = tmBoth
      TickStyle = tsNone
    end
  end
end
