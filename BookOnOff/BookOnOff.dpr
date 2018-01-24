program BookOnOff;

uses
  Forms,
  main in 'main.pas' {frmMain},
  ViewUsers in 'ViewUsers.pas' {frmViewUsers},
  SecurityConsts in '..\common\SecurityConsts.pas',
  Constants in '..\common\Constants.pas',
  RMLAbout in '..\common\RMLAbout.pas' {frmAbout},
  BDEFunctions in '..\common\Delphi5\units\BDEFunctions.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmViewUsers, frmViewUsers);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
