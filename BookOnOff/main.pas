unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls,DBTables, Db, ComCtrls, ExtCtrls,
  IsgCSsec;

const
    STR_VERSION_INFO='Bookon/off V1.0.0.0';
    LOG_AUTO=0;
    LOG_MANUAL=1;
type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    menFile: TMenuItem;
    menFileExit: TMenuItem;
    dbDuty: TDatabase;
    qTemp: TQuery;
    spGetNearestShift: TStoredProc;
    qFPData: TQuery;
    StatBar: TStatusBar;
    gbLoginDetails: TGroupBox;
    txtPin: TEdit;
    cmdProcessPin: TButton;
    Label1: TLabel;
    Label2: TLabel;
    memResults: TMemo;
    tmrCheckReader: TTimer;
    menHelp: TMenuItem;
    menHelpAbout: TMenuItem;
    sprocLogCall: TStoredProc;
    IsgCSsecure1: TIsgCSsecure;
    procedure cmdProcessPinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure menFileExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure menHelpAboutClick(Sender: TObject);
    procedure txtPinKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    m_bActivated:Boolean;
    m_bTerminating:Boolean;
    FIsAdministrator:Boolean;
    procedure GetNearestShift(nLogType:Integer);
    procedure ShowProgress(sResult:String);

  public
    { Public declarations }
    property IsAdministrator :Boolean read FIsAdministrator default false;
  end;

var
  frmMain: TfrmMain;

implementation

uses GetEmployeeID,SecurityConsts,
   RMLAbout,BDEFunctions;

{$R *.DFM}


procedure TfrmMain.cmdProcessPinClick(Sender: TObject);
var
    nIndex:Integer;
    bManualAllowed:Boolean;
begin
    // make sure this pin can be entered manually
{    bManualAllowed:=False;
    for nIndex:=0 to high(m_arFPData) do
    begin
        if m_arFPData[nIndex].UserID =trim(txtPin.Text) then
        begin
            bManualAllowed:= m_arFPData[nIndex].AllowManualLogging;
            break;
        end;
    end;
    if not bManualAllowed then
        showMessage('You are not allowed to enter your pin manually')
    else}
        GetNearestShift(LOG_MANUAL);
end;

procedure TfrmMain.GetNearestShift(nLogType:Integer);
var
    sActualSite,sSQL,sError,sResult, sLogType:String;
    bSuccess:boolean;
begin
    //NOTES Sp only returns duties with status of 'TODO'
    bSuccess:=true; // default value - will be changed on exception
    memResults.Lines.Clear;
    memResults.Lines.Add('Starting to process your pin...');
    spGetNearestShift.ParamByName('@Pin').AsString:=trim(txtPin.Text);
    spGetNearestShift.ParamByName('@Site').AsString:='';//frmFPOptions.Site;
    spGetNearestShift.ExecProc;
    sActualSite:=trim(spGetNearestShift.ParamByName('@Site').AsString);
    if sActualSite='' then
    begin
  //      frmLogResult.success :=false;
  //      frmLogResult.FormPaint(self);
        ShowProgress('You do not appear to have a logon/logoff due...');
//        Application.ProcessMessages;
//        sleep(10000);
//        frmLogResult.Hide;
        memResults.Lines.Add('You entered an incorrect pin or do not have a shift due.');
        exit;
    end;
 //   if sActualSite=frmFPOptions.Site then
//    begin
        if nLogType= LOG_AUTO then sLogType:='AUTO' else sLogType:='MANUAL';
        if Trim(spGetNearestShift.ParamByName('@CheckPattern').AsString)='LOGON' then
        begin //User has logged on , needs to log off
            ShowProgress('Please wait,you are being logged off...');
            memResults.Lines.Add('Please wait while the system logs you off...');
            Application.ProcessMessages;
            //  sSQL:='UPDATE roster SET ro_shift_length=DATEDIFF(mi,ro_shift_start,GETDATE()),'
           //     + ' ro_status=''COMP'''
            //    + ' WHERE ro_shiftid=' +FloatToStr(spGetNearestShift.ParamByName('@ShiftID').AsFloat);
            //qTemp.SQL.Text :=sSQL;
            //qTemp.ExecSQL;
            try
                sprocLogCall.ParamByName('@ShiftID').Asfloat:=spGetNearestShift.ParamByName('@ShiftID').AsFloat;
                sprocLogCall.ParamByName('@LogType').AsString:=sLogType;
                sprocLogCall.ExecProc;
                //@CallTypeDesc AS VARCHAR(20) OUTPUT,
                //	@CallTime AS DATETIME OUTPUT,
                //	@ResultCode  AS INTEGER  OUTPUT
            except
               on E: Exception do
               begin
                   bSuccess:=false;
                   sError:=E.Message;
               end;
            end;
            if sprocLogCall.ParamByName('@ResultCode').AsInteger<0 then
            begin
                bSuccess:=false;
                sError:='You have no logons/logoff due';
            end;
            //frmLogResult.success :=bSuccess;
        //    frmLogResult.FormPaint(self) ;
            if bSuccess then
            begin
                sResult :='Success-you have been logged off...';
                memResults.Lines.Add('You have been logged off...');
            end
            else
            begin
                sResult :='Error: '+ sError;
                memResults.Lines.Add('Error occured when trying to log shift...');
                memResults.Lines.Add(sError);
            end;
            ShowProgress(sResult);
//            Application.ProcessMessages;
 //           sleep(1000 * frmFPOptions.FlashDuration);
            //frmLogResult.Hide;
        end
        else//log on
        begin
            {ShowProgress('Please wait while your shift at '
                    + FormatDateTime('hh:nn', spGetNearestShift.ParamByName('@StartTime').AsDateTime)
                    + ' is updated.', 0,false);}
            memResults.Lines.Add('Please wait while shift is updated with current time....');
            Application.ProcessMessages;
            try
                sprocLogCall.ParamByName('@ShiftID').Asfloat:=spGetNearestShift.ParamByName('@ShiftID').AsFloat;
                sprocLogCall.ParamByName('@LogType').AsString:=sLogType;
                sprocLogCall.ExecProc;
            except
               on E: Exception do
               begin
                    bSuccess:=false;
                    sError:=E.Message;
               end;
            end;
            if sprocLogCall.ParamByName('@ResultCode').AsInteger<0 then
            begin
                bSuccess:=false;
                sError:='You have no logons/logoff due';
            end;
            //frmLogResult.success :=bSuccess;
            if bSuccess then
            begin
                sResult :='Success-you have been logged on...';
                memResults.Lines.Add('You have been logged on...');
            end
            else
            begin
                sResult :='Error: '+ sError;
                memResults.Lines.Add('Error occured when trying to log shift...');
                memResults.Lines.Add(sError);
            end;
            ShowProgress(sResult);
  //          Application.ProcessMessages;
  //          sleep(1000 * frmFPOptions.FlashDuration);
            //frmLogResult.Hide;
        end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    m_bActivated:=false;
    //Ensure database starts up disconnected
    dbDuty.connected:=false;
    m_bTerminating:=false;
    StatBar.Panels[0].Text:='Logging onto server...';
    Application.processmessages;
    if not LogOnToDatabase(IsgCSsecure1, ISG_FINGERPRINT_ALLOW_ACCESS,dbDuty) then
    begin
        m_bTerminating:=True;// flag to rest of start-up that login failed and we are closing application
        application.terminate;
        exit;
    end;
    StatBar.Panels[0].Text:='Logged onto server...';
    Application.processmessages;
//    frmFPOptions:=frmFPOptions.Create(self);

end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
    if m_bTerminating = true then exit;
    if not m_bActivated then
    begin
        m_bActivated:=true;
        StatBar.Panels[0].Text:='Checking user...';
        Application.processmessages;
        if IsgCSsecure1.TestAccess(ISG_FINGERPRINT_ADMIN) then
            FIsAdministrator:=True;
  //      frmFPOptions.LoadSettings;
        StatBar.Panels[0].Text:='';
        Application.processmessages;
    end;
end;

procedure TfrmMain.menFileExitClick(Sender: TObject);
begin
    close;
    application.terminate;
end;



procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose:=true;
end;


procedure TfrmMain.ShowProgress(sResult:String);
begin
    ShowMessage(sResult);
end;

procedure TfrmMain.menHelpAboutClick(Sender: TObject);
begin
    frmAbout.gbInfo.Caption:=STR_VERSION_INFO;
    frmAbout.ShowModal;
end;

procedure TfrmMain.txtPinKeyPress(Sender: TObject; var Key: Char);
begin
    if Ord(Key)=13 then cmdProcessPinClick(nil);
end;

end.
