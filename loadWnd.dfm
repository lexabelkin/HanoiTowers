object LoadingScreen: TLoadingScreen
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'LoadingScreen'
  ClientHeight = 331
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = -40
    Width = 102
    Height = 185
    Caption = 'H'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -133
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 106
    Top = -40
    Width = 97
    Height = 185
    Caption = 'A'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -133
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 60
    Top = 72
    Width = 106
    Height = 185
    Caption = 'N'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -133
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 172
    Top = 72
    Width = 106
    Height = 185
    Caption = 'O'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -133
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label5: TLabel
    Left = 172
    Top = 176
    Width = 73
    Height = 185
    Caption = 'I'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -133
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 16
    Top = 252
    Width = 130
    Height = 46
    Caption = 'fuck you'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 280
    Top = 16
  end
  object Timer2: TTimer
    Interval = 15
    OnTimer = Timer2Timer
    Left = 352
    Top = 32
  end
end
