unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient, System.Generics.Collections ,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, Rest.Json, IdHashMessageDigest, IdHash,
  REST.Authenticator.Basic, System.JSON, REST.Response.Adapter;


type

  TCidade = class
  private
    Fusuario_alteracao: string;
    Fprocesso_alteracao: string;
    Fobservacao: string;
    Fcodigo_bms: string;
    Fvalor_minimo_pedido: string;
    Fempresa_faturar: string;
    Ftipo_frete_padrao: string;
    Fsuspenso: string;
    Ftolerancia_dias_juros: string;
    Ftipo_cobranca: string;
    Fempresa_alteracao: string;
    Fcobrar_frete: string;
    Fcgc_tran_padrao: string;
    Fnome: string;
    Fcidade: string;
    Fdata_hora_alteracao: string;
    Fperc_frete_padrao: string;
    Festado: string;
    Fcod_municipio: string;
    procedure Setcgc_tran_padrao(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setcobrar_frete(const Value: string);
    procedure Setcod_municipio(const Value: string);
    procedure Setcodigo_bms(const Value: string);
    procedure Setdata_hora_alteracao(const Value: string);
    procedure Setempresa_alteracao(const Value: string);
    procedure Setempresa_faturar(const Value: string);
    procedure Setestado(const Value: string);
    procedure Setnome(const Value: string);
    procedure Setobservacao(const Value: string);
    procedure Setperc_frete_padrao(const Value: string);
    procedure Setprocesso_alteracao(const Value: string);
    procedure Setsuspenso(const Value: string);
    procedure Settipo_cobranca(const Value: string);
    procedure Settipo_frete_padrao(const Value: string);
    procedure Settolerancia_dias_juros(const Value: string);
    procedure Setusuario_alteracao(const Value: string);
    procedure Setvalor_minimo_pedido(const Value: string);
  published
    property cgc_tran_padrao : string read Fcgc_tran_padrao write Setcgc_tran_padrao;
    property cidade : string read Fcidade write Setcidade;
    property cobrar_frete : string read Fcobrar_frete write Setcobrar_frete;
    property codigo_bms : string read Fcodigo_bms write Setcodigo_bms;
    property cod_municipio : string read Fcod_municipio write Setcod_municipio;
    property data_hora_alteracao : string read Fdata_hora_alteracao write Setdata_hora_alteracao;
    property empresa_alteracao : string read Fempresa_alteracao write Setempresa_alteracao;
    property empresa_faturar : string read Fempresa_faturar write Setempresa_faturar;
    property estado : string read Festado write Setestado;
    property nome : string read Fnome write Setnome;
    property observacao : string read Fobservacao write Setobservacao;
    property perc_frete_padrao : string read Fperc_frete_padrao write Setperc_frete_padrao;
    property processo_alteracao : string read Fprocesso_alteracao write Setprocesso_alteracao;
    property suspenso : string read Fsuspenso write Setsuspenso;
    property tipo_cobranca : string read Ftipo_cobranca write Settipo_cobranca;
    property tipo_frete_padrao : string read Ftipo_frete_padrao write Settipo_frete_padrao;
    property tolerancia_dias_juros : string read Ftolerancia_dias_juros write Settolerancia_dias_juros;
    property usuario_alteracao : string read Fusuario_alteracao write Setusuario_alteracao;
    property valor_minimo_pedido : string read Fvalor_minimo_pedido write Setvalor_minimo_pedido;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Memo: TMemo;
    Button2: TButton;
    Button4: TButton;
    Edit: TEdit;
    Button3: TButton;
    edtMd5: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
  RestClient : TRESTClient;
  auth : THTTPBasicAuthenticator;
  req : TRESTRequest;
  res : TRESTResponse;



begin

  //vCidade := TCidade.create;
  auth := THTTPBasicAuthenticator.Create('user','password');

  RestClient := TRESTClient.Create('http://localhost:8080');
  RestClient.Authenticator := auth;

  req := TRESTRequest.Create(RestClient);
  req.Resource := 'ping?limit=10&page=1';

  res := TRESTResponse.Create(RestClient);
  req.Response := res;

  req.Execute;
  Memo.Text := res.Content;





end;

procedure TForm1.Button2Click(Sender: TObject);
var
  vCidade : TCidade;
begin
  vCidade := TJson.JsonToObject<TCidade>(memo.Lines.Text);

  ShowMessage(vCidade.CIDADE+' - '+vCidade.NOME);
end;

procedure TForm1.Button3Click(Sender: TObject);
  function MD5String(const Value: string): string;
  var
    xMD5: TIdHashMessageDigest5;
  begin
    xMD5 := TIdHashMessageDigest5.Create;
    try
      Result := xMD5.HashStringAsHex(Value);
    finally
      xMD5.Free;
    end;
  end;
begin
  ShowMessage(MD5String(edtMd5.Text));
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  RestClient : TRESTClient;
  auth : THTTPBasicAuthenticator;
  req : TRESTRequest;
  res : TRESTResponse;



begin

  //vCidade := TCidade.create;
  auth := THTTPBasicAuthenticator.Create('user','password');

  RestClient := TRESTClient.Create('http://localhost:8080');
  RestClient.Authenticator := auth;

  req := TRESTRequest.Create(RestClient);
  req.Resource := 'ping/'+Edit.Text;

  res := TRESTResponse.Create(RestClient);
  req.Response := res;

  req.Execute;
  Memo.Text := res.Content;



end;

{ TCidade }

procedure TCidade.Setcgc_tran_padrao(const Value: string);
begin
  Fcgc_tran_padrao := Value;
end;

procedure TCidade.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TCidade.Setcobrar_frete(const Value: string);
begin
  Fcobrar_frete := Value;
end;

procedure TCidade.Setcodigo_bms(const Value: string);
begin
  Fcodigo_bms := Value;
end;

procedure TCidade.Setcod_municipio(const Value: string);
begin
  Fcod_municipio := Value;
end;

procedure TCidade.Setdata_hora_alteracao(const Value: string);
begin
  Fdata_hora_alteracao := Value;
end;

procedure TCidade.Setempresa_alteracao(const Value: string);
begin
  Fempresa_alteracao := Value;
end;

procedure TCidade.Setempresa_faturar(const Value: string);
begin
  Fempresa_faturar := Value;
end;

procedure TCidade.Setestado(const Value: string);
begin
  Festado := Value;
end;

procedure TCidade.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TCidade.Setobservacao(const Value: string);
begin
  Fobservacao := Value;
end;

procedure TCidade.Setperc_frete_padrao(const Value: string);
begin
  Fperc_frete_padrao := Value;
end;

procedure TCidade.Setprocesso_alteracao(const Value: string);
begin
  Fprocesso_alteracao := Value;
end;

procedure TCidade.Setsuspenso(const Value: string);
begin
  Fsuspenso := Value;
end;

procedure TCidade.Settipo_cobranca(const Value: string);
begin
  Ftipo_cobranca := Value;
end;

procedure TCidade.Settipo_frete_padrao(const Value: string);
begin
  Ftipo_frete_padrao := Value;
end;

procedure TCidade.Settolerancia_dias_juros(const Value: string);
begin
  Ftolerancia_dias_juros := Value;
end;

procedure TCidade.Setusuario_alteracao(const Value: string);
begin
  Fusuario_alteracao := Value;
end;

procedure TCidade.Setvalor_minimo_pedido(const Value: string);
begin
  Fvalor_minimo_pedido := Value;
end;

end.
