unit ShareMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,IdHTTP,IdComponent, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    memResult: TMemo;
    StatBar: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure HttpWork(Sender: TObject; AWorkMode: TWorkMode;
                                                const AWorkCount: Integer);
    procedure GetShareData();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    m_Http1: TIdHTTP;
    m_SMSResult:String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
   GetShareData();
end;

procedure TForm1.GetShareData();
var
  sSearch,sError:String;
  i:Integer;
begin
  memResult.Lines.Clear;
    try
        try
            screen.Cursor := crHourGlass;
            m_Http1.Request.UserAgent := 'User-Agent: NULL';
            m_Http1.OnWork := HttpWork;
            //for i:=0 to lbNumbers.Items.Count -1 do
            //begin
                //memResult.Lines.Add(lbNumbers.Items[i] + ':');
                sSearch := 'http://uk.old.finance.yahoo.com/d/quotes.csv?s=@%5EFTAS&f=sl1d1t1c1ohgv&e=.csv';
                StatBar.SimpleText:='Sending Message to ' ;//+ lbNumbers.Items[i];
                m_SMSResult := m_Http1.Get (sSearch);
               // m_SMSResult:=AddInstructionsToResultsText(m_SMSResult);
                memResult.Lines.Add('    ' + m_SMSResult);
            //end;
        except
            on E: exception do
            begin
                memResult.Lines.Add(E.Message);
                if E.Message <> '' then
                    sError:='The following error occured trying to send your SMS Message:'#13#10
                            +  E.Message + #13#10
                            + 'Please confirm you have a connection to the internet.' + #13#10
                            + 'If this problem persists please contact your systems administrator.'
                else
                    sError:='An following error occured trying to send your SMS Message.'#13#10
                            + 'Please confirm you have a connection to the internet.' + #13#10
                            + 'If this problem persists please contact your systems administrator.';
                showMessage(sError);
               // frmRMLGeneral.AddAuditEntry(g_sApplicationName, g_sVersionNumber, 'SMS Error',
                //    FOfficer,FActivity,'Error Sending SMS:' + E.Message ,0, 0, 0);
                StatBar.SimpleText:='' ;// Clear  status text on completion
            end;
        end;
    finally
        screen.Cursor:=crDefault;
    end;

end;

procedure TForm1.HttpWork(Sender: TObject; AWorkMode: TWorkMode;
                                                const AWorkCount: Integer);
begin
    memResult.Lines.Add('    ' + TIdHTTP(Sender).ResponseText);
    if Pos('Error',TIdHTTP(Sender).ResponseText) > 0 then
    begin
        ShowMessage('The following error occured trying to send your SMS Message:'#13#10
                +  TIdHTTP(Sender).ResponseText + #13#10
                + 'Please confirm you have a connection to the internet.' + #13#10
                + 'If this problem persists please contact your systems administrator.');
        //frmRMLGeneral.AddAuditEntry(g_sApplicationName, g_sVersionNumber, 'SMS Error',
        //            FOfficer,FActivity,'Error Sending SMS:' + TIdHTTP(Sender).ResponseText ,0, 0, 0);
    end;
    StatBar.SimpleText:='';// Clear  status text on completion
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
    m_Http1 := TIdHTTP.Create (nil);
end;

end.
