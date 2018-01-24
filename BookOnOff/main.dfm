object frmMain: TfrmMain
  Left = 213
  Top = 165
  Width = 503
  Height = 313
  Caption = 'Log on/off shift'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatBar: TStatusBar
    Left = 0
    Top = 248
    Width = 495
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 150
      end
      item
        Width = 120
      end
      item
        Width = 50
      end>
    SimplePanel = False
    SizeGrip = False
  end
  object gbLoginDetails: TGroupBox
    Left = 32
    Top = 8
    Width = 441
    Height = 193
    Caption = 'Login Details'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 103
      Height = 13
      Caption = 'Enter your pin number'
    end
    object Label2: TLabel
      Left = 72
      Top = 64
      Width = 35
      Height = 13
      Caption = 'Results'
    end
    object txtPin: TEdit
      Left = 120
      Top = 24
      Width = 137
      Height = 21
      TabOrder = 0
      OnKeyPress = txtPinKeyPress
    end
    object cmdProcessPin: TButton
      Left = 272
      Top = 24
      Width = 65
      Height = 25
      Caption = '&Ok'
      TabOrder = 1
      OnClick = cmdProcessPinClick
    end
    object memResults: TMemo
      Left = 112
      Top = 64
      Width = 313
      Height = 113
      Lines.Strings = (
        '')
      TabOrder = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 24
    object menFile: TMenuItem
      Caption = '&File'
      object menFileExit: TMenuItem
        Caption = 'E&xit'
        OnClick = menFileExitClick
      end
    end
    object menHelp: TMenuItem
      Caption = '&Help'
      object menHelpAbout: TMenuItem
        Caption = '&About'
        OnClick = menHelpAboutClick
      end
    end
  end
  object dbDuty: TDatabase
    AliasName = 'Duty'
    DatabaseName = 'DutyDB'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 8
    Top = 72
  end
  object qTemp: TQuery
    DatabaseName = 'DutyDB'
    Left = 8
    Top = 112
  end
  object spGetNearestShift: TStoredProc
    DatabaseName = 'DutyDB'
    StoredProcName = 'FingerPGetNearestShift;1'
    Left = 8
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = '@RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftString
        Name = '@Pin'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = '@Site'
        ParamType = ptInputOutput
        Value = '               '
      end
      item
        DataType = ftString
        Name = '@SiteName'
        ParamType = ptInputOutput
        Value = '                              '
      end
      item
        DataType = ftDateTime
        Name = '@StartTime'
        ParamType = ptInputOutput
        Value = 0d
      end
      item
        DataType = ftInteger
        Name = '@Length'
        ParamType = ptInputOutput
        Value = 0
      end
      item
        DataType = ftFloat
        Name = '@ShiftID'
        ParamType = ptInputOutput
        Value = 0
      end
      item
        DataType = ftString
        Name = '@Status'
        ParamType = ptInputOutput
        Value = '          '
      end
      item
        DataType = ftString
        Name = '@CheckPattern'
        ParamType = ptInputOutput
        Value = '          '
      end>
  end
  object qFPData: TQuery
    DatabaseName = 'DutyDB'
    Left = 8
    Top = 192
  end
  object tmrCheckReader: TTimer
    Enabled = False
    Interval = 50
    Left = 32
    Top = 232
  end
  object sprocLogCall: TStoredProc
    DatabaseName = 'DutyDB'
    StoredProcName = 'FingerPBookShift;1'
    Left = 48
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = '@RETURN_VALUE'
        ParamType = ptResult
      end
      item
        DataType = ftFloat
        Name = '@ShiftID'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = '@LogType'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = '@CallTypeDesc'
        ParamType = ptInputOutput
        Value = ''
      end
      item
        DataType = ftInteger
        Name = '@ResultCode'
        ParamType = ptInputOutput
        Value = 0
      end>
  end
  object IsgCSsecure1: TIsgCSsecure
    Alias = 'RoleSecurity'
    Password = '*role?CALL!'
    Options = [soAutoValidate, soShowUI]
    Left = 56
    Top = 112
  end
end
