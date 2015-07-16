inherited paViewDataDataAnagraficiCedenteType: TpaViewDataDataAnagraficiCedenteType
  Width = 809
  Height = 170
  ExplicitWidth = 809
  ExplicitHeight = 170
  object Label2: TLabel
    Left = 11
    Top = 119
    Width = 67
    Height = 13
    Caption = 'Codice Fiscale'
  end
  object Label1: TLabel
    Left = 11
    Top = 146
    Width = 88
    Height = 13
    Caption = 'Albo professionale'
  end
  object Label5: TLabel
    Left = 259
    Top = 146
    Width = 49
    Height = 13
    Caption = 'Prov. albo'
  end
  object Label3: TLabel
    Left = 387
    Top = 146
    Width = 65
    Height = 13
    Caption = 'N'#176' iscriz. albo'
  end
  object Label4: TLabel
    Left = 611
    Top = 146
    Width = 76
    Height = 13
    Caption = 'Data iscriz. albo'
  end
  object Label6: TLabel
    Left = 342
    Top = 119
    Width = 68
    Height = 13
    Caption = 'Regime fiscale'
  end
  inline paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
    Left = 0
    Top = 0
    Width = 809
    Height = 28
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
    ExplicitWidth = 809
    inherited eIdCodice: TEdit
      Width = 595
      ExplicitWidth = 595
    end
  end
  inline paViewDataAnagraficaType1: TpaViewDataAnagraficaType
    Left = 0
    Top = 28
    Width = 809
    Height = 82
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
    TabOrder = 1
    ExplicitTop = 28
    ExplicitWidth = 809
    inherited eDenominazione: TEdit
      Width = 711
      ExplicitWidth = 711
    end
  end
  object eCodiceFiscale: TEdit
    Left = 89
    Top = 116
    Width = 244
    Height = 21
    MaxLength = 80
    TabOrder = 2
    Text = 'Bitmap28'
  end
  object eAlboProfessionale: TEdit
    Left = 105
    Top = 143
    Width = 136
    Height = 21
    MaxLength = 80
    TabOrder = 3
    Text = 'Bitmap28'
  end
  object eProvinciaAlbo: TEdit
    Left = 316
    Top = 143
    Width = 53
    Height = 21
    MaxLength = 17
    TabOrder = 4
    Text = 'Bitmap28'
  end
  object eNumIscrizAlbo: TEdit
    Left = 458
    Top = 143
    Width = 127
    Height = 21
    MaxLength = 17
    TabOrder = 5
    Text = 'Bitmap28'
  end
  object eDataIscrizAlbo: TEdit
    Left = 693
    Top = 143
    Width = 107
    Height = 21
    MaxLength = 17
    TabOrder = 6
    Text = '01/11/2015'
  end
  object eRegimeFiscale: TEdit
    Left = 420
    Top = 116
    Width = 69
    Height = 21
    MaxLength = 80
    TabOrder = 7
    Text = 'Bitmap28'
  end
  object BSDatiAnagraficiCedenteType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'CodiceFiscale'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'AlboProfessionale'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'ProvinciaAlbo'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'NumeroIscrizioneAlbo'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'DataIscrizioneAlbo'
        FieldType = ftDate
        Generator = 'Date'
        ReadOnly = False
      end
      item
        Name = 'RegimeFiscale'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLDatiAnagraficiCedenteType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '1.2.1:DatiAnagrafici'
    ioVM_UseBSPropsOnCreate = False
    Left = 200
    Top = 128
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'CodiceFiscale'
      Control = eCodiceFiscale
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'AlboProfessionale'
      Control = eAlboProfessionale
      Track = True
    end
    object LinkControlToField3: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'ProvinciaAlbo'
      Control = eProvinciaAlbo
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'NumeroIscrizioneAlbo'
      Control = eNumIscrizAlbo
      Track = True
    end
    object LinkControlToField5: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'DataIscrizioneAlbo'
      Control = eDataIscrizAlbo
      Track = True
    end
    object LinkControlToField6: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'RegimeFiscale'
      Control = eRegimeFiscale
      Track = True
    end
  end
end
