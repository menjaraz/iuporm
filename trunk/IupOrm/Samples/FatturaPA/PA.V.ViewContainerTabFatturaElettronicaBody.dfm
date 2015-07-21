inherited paViewContainerTabFatturaElettronicaBody: TpaViewContainerTabFatturaElettronicaBody
  Width = 716
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited Panel1: TPanel
    Width = 716
    ExplicitWidth = 451
    inherited ButtonDelete: TSpeedButton
      Left = 658
    end
  end
  inherited LeftSidePanel: TPanel
    Height = 286
    ExplicitHeight = 286
  end
  inherited WorkSpace: TScrollBox
    Width = 699
    Height = 286
    ExplicitWidth = 434
    ExplicitHeight = 286
    inherited ChildsArea: TPageControl
      Width = 699
      Height = 286
      ExplicitWidth = 434
      ExplicitHeight = 286
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
