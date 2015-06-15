inherited paViewDataCedentePrestatoreType: TpaViewDataCedentePrestatoreType
  Width = 809
  ExplicitWidth = 809
  inline paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
    Left = 0
    Top = 0
    Width = 809
    Height = 170
    Align = alTop
    TabOrder = 0
  end
  object BSCedentePrestatoreType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioTypeName = 'IXMLCedentePrestatoreType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForDataView'
    ioVM_Alias = '1.2:CedentePrestatore'
    ioVM_UseBSPropsOnCreate = False
    Left = 616
    Top = 216
  end
end
