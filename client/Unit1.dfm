object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 181
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 456
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Get All'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo: TMemo
    Left = 24
    Top = 24
    Width = 385
    Height = 153
    Lines.Strings = (
      'Memo')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 456
    Top = 137
    Width = 153
    Height = 25
    Caption = 'JSON To Object'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 571
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Get By ID'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Edit: TEdit
    Left = 440
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
