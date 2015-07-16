inherited paViewDataDatiGeneraliDocumento: TpaViewDataDatiGeneraliDocumento
  Width = 868
  Height = 46
  ExplicitWidth = 868
  ExplicitHeight = 46
  object Label1: TLabel
    Left = 11
    Top = 11
    Width = 76
    Height = 13
    Caption = 'Tipo documento'
  end
  object Label5: TLabel
    Left = 258
    Top = 11
    Width = 28
    Height = 13
    Caption = 'Divisa'
  end
  object Label6: TLabel
    Left = 442
    Top = 11
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object Label7: TLabel
    Left = 626
    Top = 11
    Width = 37
    Height = 13
    Caption = 'Numero'
  end
  object eNumero: TEdit
    Left = 669
    Top = 8
    Width = 100
    Height = 21
    MaxLength = 60
    TabOrder = 3
    Text = '755384'
  end
  object eTipoDocumento: TEdit
    Left = 93
    Top = 8
    Width = 100
    Height = 21
    MaxLength = 60
    TabOrder = 0
    Text = 'Bitmap28'
  end
  object eDivisa: TEdit
    Left = 292
    Top = 8
    Width = 100
    Height = 21
    MaxLength = 60
    TabOrder = 1
    Text = 'Bitmap28'
  end
  object eData: TEdit
    Left = 471
    Top = 8
    Width = 100
    Height = 21
    MaxLength = 60
    TabOrder = 2
    Text = 'Darkgoldenrod'
  end
  object Button1: TButton
    Left = 775
    Top = 7
    Width = 75
    Height = 23
    Caption = 'Post'
    TabOrder = 4
    OnClick = Button1Click
  end
  object BSDatiGeneraliDocumento: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'TipoDocumento'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Divisa'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Data'
        Generator = 'ColorsNames'
        ReadOnly = False
      end
      item
        Name = 'Numero'
        FieldType = ftUInteger
        Generator = 'Colors'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLDatiGeneraliDocumentoType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '2.1.1:DatiGeneraliDocumento'
    ioVM_UseBSPropsOnCreate = False
    Left = 432
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkFillControlToField1: TLinkFillControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiGeneraliDocumento
      FieldName = 'TipoDocumento'
      Track = True
      FillDataSource = BSDatiGeneraliDocumento
      AutoFill = True
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiGeneraliDocumento
      FieldName = 'Numero'
      Control = eNumero
      Track = True
    end
    object LinkFillControlToField2: TLinkFillControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiGeneraliDocumento
      FieldName = 'Divisa'
      Track = True
      FillDataSource = BSDatiGeneraliDocumento
      AutoFill = False
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkControlToField3: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiGeneraliDocumento
      FieldName = 'TipoDocumento'
      Control = eTipoDocumento
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiGeneraliDocumento
      FieldName = 'Divisa'
      Control = eDivisa
      Track = True
    end
    object LinkControlToField5: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiGeneraliDocumento
      FieldName = 'Data'
      Control = eData
      Track = True
    end
  end
end
