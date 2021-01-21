program VCL;

uses
  Vcl.Forms,
  Main.Form in 'src\Main.Form.pas' {FrmVCL},
  untRoutes in 'src\untRoutes.pas',
  untApiRoutes in 'src\untApiRoutes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmVCL, FrmVCL);
  Application.Run;
end.
