unit Main.Form;

interface

uses Winapi.Windows, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Buttons, System.SysUtils, Data.DB, MemDS, DBAccess, Ora, OraCall,
  System.JSON, Registry, Winapi.Messages,     Web.HTTPApp,
  DBClient, Datasnap.Provider, Vcl.Grids, Vcl.DBGrids, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls,
  Horse, Horse.Jhonson, Horse.Paginate, DataSet.Serialize,
  Horse.BasicAuthentication;

const
  WM_MY_MESSAGE = WM_USER + 1;
  InputBoxMsg = WM_USER + 123;

type
  TFrmVCL = class(TForm)
    lbStatus: TLabel;
    lbPorta: TLabel;
    btnStop: TBitBtn;
    btnStart: TBitBtn;
    session: TOraSession;
    qryCidades: TOraQuery;
    qryCidadesCGC_TRAN_PADRAO: TStringField;
    qryCidadesCIDADE: TStringField;
    qryCidadesCOBRAR_FRETE: TStringField;
    qryCidadesCODIGO_BMS: TIntegerField;
    qryCidadesCOD_MUNICIPIO: TFloatField;
    qryCidadesDATA_HORA_ALTERACAO: TDateTimeField;
    qryCidadesEMPRESA_ALTERACAO: TStringField;
    qryCidadesEMPRESA_FATURAR: TStringField;
    qryCidadesESTADO: TStringField;
    qryCidadesNOME: TStringField;
    qryCidadesOBSERVACAO: TStringField;
    qryCidadesPERC_FRETE_PADRAO: TFloatField;
    qryCidadesPROCESSO_ALTERACAO: TStringField;
    qryCidadesSUSPENSO: TStringField;
    qryCidadesTIPO_COBRANCA: TStringField;
    qryCidadesTIPO_FRETE_PADRAO: TStringField;
    qryCidadesTOLERANCIA_DIAS_JUROS: TIntegerField;
    qryCidadesUSUARIO_ALTERACAO: TStringField;
    qryCidadesVALOR_MINIMO_PEDIDO: TFloatField;
    TrayIcon1: TTrayIcon;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    Restaurar1: TMenuItem;
    Button1: TButton;
    lblStatus: TLabel;
    Button2: TButton;
    Memo: TMemo;
    Button3: TButton;
    procedure btnStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    bolLog : Boolean;
    procedure Status;
    procedure Start;
    procedure Stop;
    procedure InstalarServico;
    procedure cidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure cidadeById(Req: THorseRequest; Res: THorseResponse; Next: TProc);

  end;

var
  FrmVCL: TFrmVCL;

implementation


{$R *.dfm}

procedure TFrmVCL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if THorse.IsRunning then
    Stop;
end;

procedure TFrmVCL.Restaurar1Click(Sender: TObject);
begin
  TrayIcon1DblClick(self);
end;

procedure TFrmVCL.Start;
begin

  THorse.Use(Jhonson()).Use(Paginate());
  THorse.Routes.RegisterRoute(mtGet,'/cidade', cidade);
  THorse.Routes.RegisterRoute(mtGet,'/cidade/:id', cidadebyid);
  THorse.Routes.RegisterRoute(mtPut,'/cidade/:id', cidadebyid);

//  THorse.Use(HorseBasicAuthentication(
//    function(const AUsername, APassword: string): Boolean
//    begin
//      Result := AUsername.Equals('user') and APassword.Equals('password');
//    end));
//
//  THorse.Get('ping',
//    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
//    begin
//      qryCidades.Close;
//      qryCidades.SQL.Clear;
//      qryCidades.SQL.Add('select * from fat_cidades');
//      qryCidades.Open;
//      Res.Send<TJSONArray>(qryCidades.ToJSONArray);
//    end);
//
//  THorse.Get('ping/:id',
//    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
//    begin
//      qryCidades.Close;
//      qryCidades.SQL.Clear;
//      qryCidades.SQL.Add('select * from fat_cidades');
//      if (Req.Params.Count > 0) and (Req.Params.Items['id'] <> '') then
//        qryCidades.SQL.Add(' where cidade = ' + Req.Params.Items['id']);
//      qryCidades.Open;
//      Res.Send<TJSONObject>(qryCidades.ToJSONObject);
//
//      if bolLog then
//      begin
//        memo.Lines.Add(THorse.Host + ' - '+ Req.Params.Items['id']);
//      end;
//    end);



  THorse.Listen(8080);
end;

procedure TFrmVCL.Status;
begin
  btnStop.Enabled := THorse.IsRunning;
  btnStart.Enabled := not THorse.IsRunning;
  if THorse.IsRunning then
  begin
    lbStatus.Caption := 'Status: Online';
    lbPorta.Caption := 'Port: ' + IntToStr(THorse.Port);
  end
  else
  begin
    lbStatus.Caption := 'Status: Offline';
    lbPorta.Caption := 'Port: ';
  end;
end;

procedure TFrmVCL.Stop;
begin
  THorse.StopListen;
end;

procedure TFrmVCL.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TFrmVCL.btnStartClick(Sender: TObject);
begin
  Start;
  Status;
end;

procedure TFrmVCL.btnStopClick(Sender: TObject);
begin
  Stop;
  Status;
end;

procedure TFrmVCL.Button1Click(Sender: TObject);
begin
  Self.Hide();
  Self.WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TFrmVCL.Button2Click(Sender: TObject);
begin
  InstalarServico;
end;

procedure TFrmVCL.Button3Click(Sender: TObject);
begin
  bolLog := not bolLog;
end;

procedure TFrmVCL.cidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  qryCidades.Close;
  qryCidades.SQL.Clear;
  qryCidades.SQL.Add('select * from fat_cidades');
  qryCidades.Open;
  Res.Send<TJSONArray>(qryCidades.ToJSONArray);
end;

procedure TFrmVCL.cidadeById(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  qryCidades.Close;
  qryCidades.SQL.Clear;
  qryCidades.SQL.Add('select * from fat_cidades');
  if (Req.Params.Count > 0) and (Req.Params.Items['id'] <> '') then
    qryCidades.SQL.Add(' where cidade = ' + Req.Params.Items['id']);
  qryCidades.Open;
  Res.Send<TJSONObject>(qryCidades.ToJSONObject);

end;

procedure TFrmVCL.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmVCL.InstalarServico();
var
  vExe: String;
  ResStream: TResourceStream;
  vRegistry: TRegistry;
  vMaquina, vUsuario, vSenha, _LocalExe: String;
begin
  _LocalExe := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  try
    vExe := 'instsrv';
    if not FileExists(_LocalEXE + vExe + '.exe') then
    begin
      ResStream := TResourceStream.Create(HInstance, vExe, RT_RCDATA);
      try
        ResStream.Position := 0;
        ResStream.SaveToFile(_LocalEXE + vExe + '.exe');
      finally
        ResStream.Free;
      end;
    end;

    vExe := 'srvany';
    if not FileExists(_LocalEXE + vExe + '.exe') then
    begin
      ResStream := TResourceStream.Create(HInstance, vExe, RT_RCDATA);
      try
        ResStream.Position := 0;
        ResStream.SaveToFile(_LocalEXE + vExe + '.exe');
      finally
        ResStream.Free;
      end;
    end;

    vExe := 'ntrights';
    if not FileExists(_LocalEXE + vExe + '.exe') then
    begin
      ResStream := TResourceStream.Create(HInstance, vExe, RT_RCDATA);
      try
        ResStream.Position := 0;
        ResStream.SaveToFile(_LocalEXE + vExe + '.exe');
      finally
        ResStream.Free;
      end;
    end;

    vUsuario := GetEnvironmentVariable('USERNAME');
    vMaquina := GetEnvironmentVariable('COMPUTERNAME');

    //Buscar senha do usuário
    PostMessage(Handle, InputBoxMsg, 0, 0);
    vSenha := InputBox('Autenticação', 'Informe sua senha (para login do WINDOWS):', '');

    lblStatus.Caption := 'Aguarde, instalando...';

    //Libera o usuário para fazer logon como serviço
    WinExec(PAnsiChar(AnsiString('"' + _LocalEXE + 'ntrights.exe" +r SeServiceLogonRight -u ' + vMaquina + '\' + vUsuario)), SW_HIDE);

    //Cria o serviço
    WinExec(PAnsiChar(AnsiString('"' + _LocalEXE + 'instsrv.exe" "HivaAPI" "' + _LocalEXE + 'srvany.exe"')), SW_HIDE);

    Sleep(8000);

    //Configura o usuário para iniciar o servico
    //Nota: os espaços depois de "obj=" e "password=" são obrigatórios!
    WinExec(PAnsiChar(AnsiString('sc.exe config "HivaAPI" obj= ".\' + vUsuario + '" password= "' + vSenha + '"')), SW_HIDE);

    //Configura o serviço
    //HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MEU_SERVICO
    vRegistry := TRegistry.Create;
    vRegistry.RootKey := HKEY_LOCAL_MACHINE;
    if not vRegistry.OpenKey('SYSTEM\\CurrentControlSet\\Services\\HivaAPI', False) then
    begin
      Sleep(3000);
      vRegistry.OpenKey('SYSTEM\\CurrentControlSet\\Services\\HivaAPI', False);
    end;
    vRegistry.OpenKey('Parameters', True);
    vRegistry.WriteString('Application', ParamStr(0));
    vRegistry.WriteString('AppDirectory', _LocalEXE);
    vRegistry.CloseKey;
    vRegistry.Free;
    showmessage('Serviço instalado com sucesso!');
  except
    on E: Exception do
    begin
     showmessage('Houve um problema ao instalar a aplicação como um serviço. Tente novamente. Erro: ' + E.Message);
    end;
  end;
end;
end.
