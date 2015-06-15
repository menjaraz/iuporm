inherited paViewDataAnagraficaType: TpaViewDataAnagraficaType
  Width = 836
  Height = 82
  ExplicitWidth = 836
  ExplicitHeight = 82
  DesignSize = (
    836
    82)
  object Label2: TLabel
    Left = 11
    Top = 6
    Width = 72
    Height = 13
    Caption = 'Denominazione'
  end
  object Label3: TLabel
    Left = 11
    Top = 33
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label4: TLabel
    Left = 363
    Top = 33
    Width = 45
    Height = 13
    Caption = 'Cognome'
  end
  object Label1: TLabel
    Left = 11
    Top = 60
    Width = 26
    Height = 13
    Caption = 'Titolo'
  end
  object Label5: TLabel
    Left = 363
    Top = 60
    Width = 51
    Height = 13
    Caption = 'Cod. EORI'
  end
  object eDenominazione: TEdit
    Left = 89
    Top = 3
    Width = 738
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 80
    TabOrder = 0
    Text = 'Bitmap28'
  end
  object eNome: TEdit
    Left = 89
    Top = 30
    Width = 244
    Height = 21
    MaxLength = 60
    TabOrder = 1
    Text = 'Bitmap28'
  end
  object eCognome: TEdit
    Left = 420
    Top = 30
    Width = 285
    Height = 21
    MaxLength = 60
    TabOrder = 2
    Text = 'Bitmap28'
  end
  object eTitolo: TEdit
    Left = 89
    Top = 57
    Width = 244
    Height = 21
    MaxLength = 10
    TabOrder = 3
    Text = 'Bitmap28'
  end
  object eCodEORI: TEdit
    Left = 420
    Top = 57
    Width = 265
    Height = 21
    MaxLength = 17
    TabOrder = 4
    Text = 'Bitmap28'
  end
  object BSAnagraficaType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Denominazione'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Nome'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Cognome'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Titolo'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'CodEORI'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLAnagraficaType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForDataView'
    ioVM_Alias = '1.2.1.3:Anagrafica'
    ioVM_UseBSPropsOnCreate = False
    Left = 624
    Top = 32
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 724
    Top = 29
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSAnagraficaType
      FieldName = 'Denominazione'
      Control = eDenominazione
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSAnagraficaType
      FieldName = 'Nome'
      Control = eNome
      Track = True
    end
    object LinkControlToField3: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSAnagraficaType
      FieldName = 'Cognome'
      Control = eCognome
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSAnagraficaType
      FieldName = 'Titolo'
      Control = eTitolo
      Track = True
    end
    object LinkControlToField5: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSAnagraficaType
      FieldName = 'CodEORI'
      Control = eCodEORI
      Track = True
    end
  end
end
