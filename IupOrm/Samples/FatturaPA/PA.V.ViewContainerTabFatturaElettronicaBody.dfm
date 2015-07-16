inherited paViewContainerTabFatturaElettronicaBody: TpaViewContainerTabFatturaElettronicaBody
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited ChildsArea: TPageControl
    Width = 451
    Height = 282
    ExplicitWidth = 451
    ExplicitHeight = 282
  end
  inherited Panel1: TPanel
    Width = 451
    ExplicitWidth = 451
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
