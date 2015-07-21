inherited paViewDataIdFiscaleType: TpaViewDataIdFiscaleType
  Width = 813
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited LeftSidePanel: TPanel
    Height = 305
    ExplicitHeight = 305
  end
  inherited WorkSpace: TScrollBox
    Width = 796
    Height = 305
    ExplicitWidth = 434
    ExplicitHeight = 305
    DesignSize = (
      796
      305)
    object Label1: TLabel
      Left = 11
      Top = 6
      Width = 39
      Height = 13
      Caption = 'IdPaese'
    end
    object Label2: TLabel
      Left = 163
      Top = 6
      Width = 42
      Height = 13
      Caption = 'IdCodice'
    end
    object eIdPaese: TEdit
      Left = 59
      Top = 3
      Width = 65
      Height = 21
      TabOrder = 0
      Text = 'Bitmap28'
    end
    object eIdCodice: TEdit
      Left = 216
      Top = 3
      Width = 575
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'Bitmap28'
      ExplicitWidth = 213
    end
  end
  object BSIdFiscaleType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'IdPaese'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'IdCodice'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLIdFiscaleType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '1.2.1.1:IdFiscaleIVA'
    ioVM_UseBSPropsOnCreate = False
    Left = 416
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSIdFiscaleType
      FieldName = 'IdPaese'
      Control = eIdPaese
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSIdFiscaleType
      FieldName = 'IdCodice'
      Control = eIdCodice
      Track = True
    end
  end
end
