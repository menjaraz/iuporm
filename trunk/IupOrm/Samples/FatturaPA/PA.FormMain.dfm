object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 610
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inline paViewService1: TpaViewService
    Left = 0
    Top = 0
    Width = 943
    Height = 610
    ParentCustomHint = False
    Align = alClient
    BiDiMode = bdLeftToRight
    DoubleBuffered = False
    Color = clBtnFace
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentBiDiMode = False
    ParentColor = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    ExplicitWidth = 943
    ExplicitHeight = 610
    inherited LeftSidePanel: TPanel
      Height = 569
    end
    inherited WorkSpace: TScrollBox
      Width = 926
      Height = 569
      ExplicitWidth = 926
      ExplicitHeight = 569
    end
    inherited PanelTools: TPanel
      Width = 943
      ExplicitWidth = 943
    end
    inherited BSService: TioPrototypeBindSource
      ioOnNeedViewModel = paViewService1BSServiceioOnNeedViewModel
    end
  end
end
