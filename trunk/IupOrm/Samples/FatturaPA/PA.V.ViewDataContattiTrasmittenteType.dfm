inherited paViewDataContattiTrasmittenteType: TpaViewDataContattiTrasmittenteType
  Width = 884
  Height = 26
  ExplicitWidth = 884
  ExplicitHeight = 26
  DesignSize = (
    884
    26)
  object Label2: TLabel
    Left = 11
    Top = 6
    Width = 42
    Height = 13
    Caption = 'Telefono'
  end
  object Label1: TLabel
    Left = 363
    Top = 6
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object eTelefono: TEdit
    Left = 59
    Top = 3
    Width = 274
    Height = 21
    MaxLength = 12
    TabOrder = 0
    Text = 'Bitmap28'
  end
  object eEmail: TEdit
    Left = 393
    Top = 3
    Width = 488
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 256
    TabOrder = 1
    Text = 'Bitmap28'
  end
  object BSContattiTrasmittenteType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Telefono'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Email'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_UseBSPropsOnCreate = False
    Left = 768
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 660
    Top = 65533
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSContattiTrasmittenteType
      FieldName = 'Telefono'
      Control = eTelefono
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSContattiTrasmittenteType
      FieldName = 'Email'
      Control = eEmail
      Track = True
    end
  end
end
