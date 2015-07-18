inherited paViewDataCedentePrestatoreType: TpaViewDataCedentePrestatoreType
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited LeftSidePanel: TPanel
    Top = 169
    Height = 136
    TabOrder = 2
    ExplicitTop = 169
    ExplicitHeight = 136
  end
  inherited WorkSpace: TScrollBox
    Top = 169
    Width = 434
    Height = 136
    ExplicitTop = 169
    ExplicitWidth = 434
    ExplicitHeight = 136
    object Label1: TLabel
      Left = 11
      Top = 4
      Width = 134
      Height = 13
      Caption = 'Riferimento amministrazione'
    end
    object eRiferimentoAmministrazione: TEdit
      Left = 153
      Top = 0
      Width = 200
      Height = 21
      MaxLength = 80
      TabOrder = 0
      Text = 'Bitmap28'
    end
  end
  inline paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
    Left = 0
    Top = 0
    Width = 451
    Height = 169
    ParentCustomHint = False
    Align = alTop
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
    ExplicitHeight = 169
    inherited paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
      inherited LeftSidePanel: TPanel
        ExplicitHeight = 28
      end
      inherited WorkSpace: TScrollBox
        inherited eIdCodice: TEdit
          Width = 324
          ExplicitWidth = 324
        end
      end
    end
    inherited LeftSidePanel: TPanel
      Height = 59
    end
    inherited WorkSpace: TScrollBox
      Height = 59
      ExplicitHeight = 59
    end
    inherited BSDatiAnagraficiCedenteType: TioPrototypeBindSource
      Left = 552
    end
  end
  object BSCedentePrestatoreType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'RiferimentoAmministrazione'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLCedentePrestatoreType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '1.2:CedentePrestatore'
    ioVM_UseBSPropsOnCreate = False
    Left = 392
    Top = 168
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSCedentePrestatoreType
      FieldName = 'RiferimentoAmministrazione'
      Control = eRiferimentoAmministrazione
      Track = True
    end
  end
end
