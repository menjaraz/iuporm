inherited paViewDataDataAnagraficiCedenteType: TpaViewDataDataAnagraficiCedenteType
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inline paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType [0]
    Left = 0
    Top = 0
    Width = 451
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
    TabOrder = 2
    ExplicitHeight = 28
    inherited LeftSidePanel: TPanel
      Height = 28
    end
    inherited WorkSpace: TScrollBox
      Height = 28
      ExplicitHeight = 28
    end
    inherited BindingsList1: TBindingsList
      inherited LinkControlToField2: TLinkControlToField
        Control = nil
      end
    end
  end
  inherited LeftSidePanel: TPanel [1]
    Top = 110
    Height = 195
    ExplicitTop = 110
    ExplicitHeight = 195
  end
  inherited WorkSpace: TScrollBox
    Top = 110
    Width = 434
    Height = 195
    TabOrder = 3
    ExplicitTop = 110
    ExplicitWidth = 434
    ExplicitHeight = 195
    object Label2: TLabel
      Left = 11
      Top = 5
      Width = 67
      Height = 13
      Caption = 'Codice Fiscale'
    end
    object Label6: TLabel
      Left = 342
      Top = 5
      Width = 68
      Height = 13
      Caption = 'Regime fiscale'
    end
    object Label1: TLabel
      Left = 11
      Top = 32
      Width = 88
      Height = 13
      Caption = 'Albo professionale'
    end
    object Label5: TLabel
      Left = 256
      Top = 32
      Width = 49
      Height = 13
      Caption = 'Prov. albo'
    end
    object Label3: TLabel
      Left = 383
      Top = 32
      Width = 65
      Height = 13
      Caption = 'N'#176' iscriz. albo'
    end
    object Label4: TLabel
      Left = 592
      Top = 32
      Width = 76
      Height = 13
      Caption = 'Data iscriz. albo'
    end
    object eCodiceFiscale: TEdit
      Left = 89
      Top = 2
      Width = 244
      Height = 21
      MaxLength = 80
      TabOrder = 0
      Text = 'Bitmap28'
    end
    object eRegimeFiscale: TEdit
      Left = 420
      Top = 2
      Width = 69
      Height = 21
      MaxLength = 80
      TabOrder = 1
      Text = 'Bitmap28'
    end
    object eAlboProfessionale: TEdit
      Left = 105
      Top = 29
      Width = 136
      Height = 21
      MaxLength = 80
      TabOrder = 2
      Text = 'Bitmap28'
    end
    object eProvinciaAlbo: TEdit
      Left = 313
      Top = 29
      Width = 53
      Height = 21
      MaxLength = 17
      TabOrder = 3
      Text = 'Bitmap28'
    end
    object eNumIscrizAlbo: TEdit
      Left = 454
      Top = 29
      Width = 127
      Height = 21
      MaxLength = 17
      TabOrder = 4
      Text = 'Bitmap28'
    end
    object eDataIscrizAlbo: TEdit
      Left = 672
      Top = 29
      Width = 106
      Height = 21
      MaxLength = 17
      TabOrder = 5
      Text = '01/11/2015'
    end
  end
  inline paViewDataAnagraficaType1: TpaViewDataAnagraficaType
    Left = 0
    Top = 28
    Width = 451
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
    ExplicitHeight = 82
    inherited LeftSidePanel: TPanel
      Height = 82
      ExplicitHeight = 82
    end
    inherited WorkSpace: TScrollBox
      Height = 82
      ExplicitHeight = 82
      DesignSize = (
        434
        82)
      inherited eDenominazione: TEdit
        Width = 1038
        ExplicitWidth = 1038
      end
    end
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
    object LinkControlToField7: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'CodiceFiscale'
      Control = eCodiceFiscale
      Track = True
    end
    object LinkControlToField8: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'DataIscrizioneAlbo'
      Control = eDataIscrizAlbo
      Track = True
    end
    object LinkControlToField9: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'RegimeFiscale'
      Control = eRegimeFiscale
      Track = True
    end
    object LinkControlToField10: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'NumeroIscrizioneAlbo'
      Control = eNumIscrizAlbo
      Track = True
    end
    object LinkControlToField11: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'AlboProfessionale'
      Control = eAlboProfessionale
      Track = True
    end
    object LinkControlToField12: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSDatiAnagraficiCedenteType
      FieldName = 'ProvinciaAlbo'
      Control = eProvinciaAlbo
      Track = True
    end
  end
end
