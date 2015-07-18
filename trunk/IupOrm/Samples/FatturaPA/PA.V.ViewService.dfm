inherited paViewService: TpaViewService
  Width = 931
  Height = 593
  ExplicitWidth = 931
  ExplicitHeight = 593
  inherited LeftSidePanel: TPanel
    Top = 41
    Height = 552
    TabOrder = 2
  end
  object PanelTools: TPanel [1]
    Left = 0
    Top = 0
    Width = 931
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonNew: TButton
      Left = 5
      Top = 5
      Width = 116
      Height = 32
      Caption = 'New'
      TabOrder = 0
    end
    object ButtonLoad: TButton
      Left = 127
      Top = 5
      Width = 116
      Height = 32
      Caption = 'Load'
      TabOrder = 1
    end
    object ButtonSave: TButton
      Left = 249
      Top = 5
      Width = 116
      Height = 32
      Caption = 'Save'
      TabOrder = 2
    end
    object ButtonClose: TButton
      Left = 521
      Top = 5
      Width = 116
      Height = 32
      Caption = 'Close'
      TabOrder = 3
    end
  end
  inherited WorkSpace: TScrollBox
    Top = 41
    Width = 914
    Height = 552
    ExplicitTop = 41
    ExplicitWidth = 914
    ExplicitHeight = 552
  end
  object BSService: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioOnNeedViewModel = BSServiceioOnNeedViewModel
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewService'
    ioVM_UseBSPropsOnCreate = False
    Left = 424
  end
end
