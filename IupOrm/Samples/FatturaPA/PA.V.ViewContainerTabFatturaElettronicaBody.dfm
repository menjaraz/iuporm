inherited paViewContainerTabFatturaElettronicaBody: TpaViewContainerTabFatturaElettronicaBody
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited Panel1: TPanel
    Width = 451
    ExplicitWidth = 451
  end
  inherited LeftSidePanel: TPanel
    Height = 288
    ExplicitHeight = 288
  end
  inherited WorkSpace: TScrollBox
    Width = 434
    Height = 288
    ExplicitWidth = 434
    ExplicitHeight = 288
    inherited ChildsArea: TPageControl
      Width = 434
      Height = 288
      ExplicitWidth = 434
      ExplicitHeight = 288
    end
  end
  object BSFatturaElettronicaBodyList: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioTypeName = 'IXMLFatturaElettronicaBodyTypeList'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewContainer'
    ioVM_Alias = '2.List:FatturaElettronicaBodyList'
    ioVM_UseBSPropsOnCreate = False
    Left = 440
    Top = 72
  end
end
