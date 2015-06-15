object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 309
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonHello: TButton
    Left = 8
    Top = 8
    Width = 297
    Height = 113
    Caption = 'ButtonHello'
    TabOrder = 0
  end
  object ButtonOnOff: TButton
    Left = 8
    Top = 127
    Width = 297
    Height = 113
    Caption = 'ButtonOnOff'
    TabOrder = 1
  end
  object ioPrototypeBindSource1: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioAutoLoadData = True
    ioAutoPersist = True
    ioViewDataType = dtList
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IVCL_ViewModel'
    ioVM_UseBSPropsOnCreate = False
    Left = 136
    Top = 256
  end
end
