unit GetEmployeeID;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmGetPinToEnroll = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
    txtEmployeeID: TEdit;
    Label1: TLabel;
    chkAllowManualBookon: TCheckBox;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtEmployeeIDKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function AllowManual: boolean;
  public
    { Public declarations }
    property AllowManualBookon:boolean Read AllowManual default false;
end;

var
  frmGetPinToEnroll: TfrmGetPinToEnroll;

implementation

{$R *.DFM}

procedure TfrmGetPinToEnroll.cmdCancelClick(Sender: TObject);
begin
    ModalResult:=mrCancel;
end;

procedure TfrmGetPinToEnroll.FormActivate(Sender: TObject);
begin
    txtEmployeeID.SetFocus;
end;

procedure TfrmGetPinToEnroll.txtEmployeeIDKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key=#13 then
        modalResult:=mrOK;
end;

function TfrmGetPinToEnroll.AllowManual: boolean;
begin
    result:=chkAllowManualBookon.Checked;
end;

end.
