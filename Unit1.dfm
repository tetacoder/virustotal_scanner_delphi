object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Scanner'
  ClientHeight = 315
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMinimized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 440
    Top = -2
    Width = 105
    Height = 46
    Caption = 'scan'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    Visible = False
    OnClick = Button2Click
  end
  object ric: TRichEdit
    Left = 0
    Top = 0
    Width = 442
    Height = 314
    Color = clGreen
    Ctl3D = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    Zoom = 100
  end
  object Button3: TButton
    Left = 440
    Top = 50
    Width = 105
    Height = 47
    Caption = 'Dosya'
    TabOrder = 3
    OnClick = Button3Click
  end
  object open: TOpenDialog
    Left = 512
    Top = 112
  end
  object tr: TTrayIcon
    PopupMenu = PopupMenu1
    Left = 496
    Top = 168
  end
  object PopupMenu1: TPopupMenu
    Left = 480
    Top = 136
    object DosyaTara1: TMenuItem
      Caption = 'Dosya Tara'
      OnClick = DosyaTara1Click
    end
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 456
    Top = 232
  end
end
