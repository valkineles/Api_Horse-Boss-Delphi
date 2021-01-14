object FrmVCL: TFrmVCL
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'VCL'
  ClientHeight = 368
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatus: TLabel
    Left = 8
    Top = 7
    Width = 70
    Height = 13
    Caption = 'Status: Offline'
  end
  object lbPorta: TLabel
    Left = 8
    Top = 26
    Width = 24
    Height = 13
    Caption = 'Port:'
  end
  object lblStatus: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 442
    Height = 30
    Margins.Right = 10
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Desconectado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    StyleElements = [seClient, seBorder]
    ExplicitWidth = 497
  end
  object btnStop: TBitBtn
    Left = 127
    Top = 53
    Width = 113
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 0
    OnClick = btnStopClick
  end
  object btnStart: TBitBtn
    Left = 8
    Top = 53
    Width = 113
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object Button1: TButton
    Left = 24
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 165
    Top = 104
    Width = 116
    Height = 25
    Caption = 'Install Service'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Memo: TMemo
    Left = 8
    Top = 192
    Width = 439
    Height = 168
    TabOrder = 4
  end
  object Button3: TButton
    Left = 372
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Log'
    TabOrder = 5
    OnClick = Button3Click
  end
  object session: TOraSession
    Options.Direct = True
    Username = 'confat'
    Server = 'desenvolvimento'
    Connected = True
    LoginPrompt = False
    Left = 312
    Top = 48
    EncryptedPassword = '92FF9EFF91FF9EFF98FF9AFF8DFF'
  end
  object qryCidades: TOraQuery
    Session = session
    SQL.Strings = (
      'select * from fat_cidades')
    FetchAll = True
    Left = 304
    Top = 96
    object qryCidadesCGC_TRAN_PADRAO: TStringField
      FieldName = 'CGC_TRAN_PADRAO'
      Size = 18
    end
    object qryCidadesCIDADE: TStringField
      FieldName = 'CIDADE'
      Required = True
      Size = 5
    end
    object qryCidadesCOBRAR_FRETE: TStringField
      FieldName = 'COBRAR_FRETE'
      FixedChar = True
      Size = 1
    end
    object qryCidadesCODIGO_BMS: TIntegerField
      FieldName = 'CODIGO_BMS'
      Required = True
    end
    object qryCidadesCOD_MUNICIPIO: TFloatField
      FieldName = 'COD_MUNICIPIO'
    end
    object qryCidadesDATA_HORA_ALTERACAO: TDateTimeField
      FieldName = 'DATA_HORA_ALTERACAO'
    end
    object qryCidadesEMPRESA_ALTERACAO: TStringField
      FieldName = 'EMPRESA_ALTERACAO'
      Size = 18
    end
    object qryCidadesEMPRESA_FATURAR: TStringField
      FieldName = 'EMPRESA_FATURAR'
      Size = 18
    end
    object qryCidadesESTADO: TStringField
      FieldName = 'ESTADO'
      Required = True
      Size = 2
    end
    object qryCidadesNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 40
    end
    object qryCidadesOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 40
    end
    object qryCidadesPERC_FRETE_PADRAO: TFloatField
      FieldName = 'PERC_FRETE_PADRAO'
    end
    object qryCidadesPROCESSO_ALTERACAO: TStringField
      FieldName = 'PROCESSO_ALTERACAO'
    end
    object qryCidadesSUSPENSO: TStringField
      FieldName = 'SUSPENSO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryCidadesTIPO_COBRANCA: TStringField
      FieldName = 'TIPO_COBRANCA'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryCidadesTIPO_FRETE_PADRAO: TStringField
      FieldName = 'TIPO_FRETE_PADRAO'
      Size = 3
    end
    object qryCidadesTOLERANCIA_DIAS_JUROS: TIntegerField
      FieldName = 'TOLERANCIA_DIAS_JUROS'
      Required = True
    end
    object qryCidadesUSUARIO_ALTERACAO: TStringField
      FieldName = 'USUARIO_ALTERACAO'
    end
    object qryCidadesVALOR_MINIMO_PEDIDO: TFloatField
      FieldName = 'VALOR_MINIMO_PEDIDO'
      Required = True
    end
  end
  object TrayIcon1: TTrayIcon
    Icons = ImageList1
    PopupMenu = PopupMenu1
    OnDblClick = TrayIcon1DblClick
    Left = 184
    Top = 136
  end
  object ImageList1: TImageList
    Left = 128
    Top = 136
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 144
    object Restaurar1: TMenuItem
      Caption = 'Restaurar'
      OnClick = Restaurar1Click
    end
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
end
