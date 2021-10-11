program TriCasiers;

uses
  Forms,
  uTriCasiers in 'uTriCasiers.pas' {frmTriK};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTriK, frmTriK);
  Application.Run;
end.

