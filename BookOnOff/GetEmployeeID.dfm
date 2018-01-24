object frmGetPinToEnroll: TfrmGetPinToEnroll
  Left = 292
  Top = 228
  BorderStyle = bsDialog
  Caption = 'Please enter employee ID to enroll.'
  ClientHeight = 153
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 24
    Width = 60
    Height = 13
    Caption = 'Employee ID'
  end
  object cmdOK: TButton
    Left = 80
    Top = 88
    Width = 73
    Height = 25
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object cmdCancel: TButton
    Left = 168
    Top = 88
    Width = 65
    Height = 25
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = cmdCancelClick
  end
  object txtEmployeeID: TEdit
    Left = 112
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    OnKeyPress = txtEmployeeIDKeyPress
  end
  object chkAllowManualBookon: TCheckBox
    Left = 120
    Top = 56
    Width = 161
    Height = 17
    Caption = 'Allow manual bookon'
    TabOrder = 3
  end
end
