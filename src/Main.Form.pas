unit Main.Form;

interface

uses Winapi.Windows, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Buttons, System.SysUtils, Data.DB, MemDS, DBAccess, Ora, OraCall,
  System.JSON,
  DBClient, Datasnap.Provider, Vcl.Grids, Vcl.DBGrids;

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
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure btnStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
  private
    procedure Status;
    procedure Start;
    procedure Stop;
  end;

var
  FrmVCL: TFrmVCL;

implementation

uses Horse, Horse.Jhonson, Horse.Paginate, DataSet.Serialize,
  Horse.BasicAuthentication;

{$R *.dfm}

procedure TFrmVCL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if THorse.IsRunning then
    Stop;
end;

procedure TFrmVCL.Start;
begin

  THorse.Use(Jhonson()).Use(Paginate());
  THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      Result := AUsername.Equals('user') and APassword.Equals('password');
    end));

  THorse.Get('ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      qryCidades.Close;
      qryCidades.SQL.Clear;
      qryCidades.SQL.Add('select * from fat_cidades');
      qryCidades.Open;
      Res.Send<TJSONArray>(qryCidades.ToJSONArray);
    end);

  THorse.Get('ping/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      qryCidades.Close;
      qryCidades.SQL.Clear;
      qryCidades.SQL.Add('select * from fat_cidades');
      if (Req.Params.Count > 0) and (Req.Params.Items['id'] <> '') then
        qryCidades.SQL.Add(' where cidade = ' + Req.Params.Items['id']);
      qryCidades.Open;
      Res.Send<TJSONObject>(qryCidades.ToJSONObject);
    end;
  end);

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

end.
