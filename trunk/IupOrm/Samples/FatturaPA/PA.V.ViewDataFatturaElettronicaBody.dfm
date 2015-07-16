inherited paViewDataFatturaElettronicaBody: TpaViewDataFatturaElettronicaBody
  Width = 1096
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1096
    Height = 305
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 451
    object TabSheet1: TTabSheet
      Caption = 'Dati generali'
      ExplicitWidth = 443
      inline paViewDataDatiGenerali1: TpaViewDataDatiGenerali
        Left = 0
        Top = 0
        Width = 1088
        Height = 277
        ParentCustomHint = False
        Align = alClient
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
        ExplicitWidth = 443
        ExplicitHeight = 277
        inherited PageControl1: TPageControl
          Width = 1088
          Height = 277
          ExplicitWidth = 443
          ExplicitHeight = 277
          inherited TabSheet1: TTabSheet
            ExplicitWidth = 435
            ExplicitHeight = 249
            inherited paViewDataDatiGeneraliDocumento1: TpaViewDataDatiGeneraliDocumento
              Width = 1080
              Height = 249
              ExplicitWidth = 435
              ExplicitHeight = 249
            end
          end
          inherited TabSheet2: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet3: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet4: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet5: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet6: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet7: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet8: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet9: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
          inherited TabSheet10: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 443
            ExplicitHeight = 277
          end
        end
        inherited BSDatiGenerali: TioPrototypeBindSource
          Top = 88
        end
      end
      object Button1: TButton
        Left = 688
        Top = 192
        Width = 75
        Height = 25
        Caption = 'Post'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dati beni/servizi'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'Dati veicoli'
      ImageIndex = 2
    end
    object TabSheet4: TTabSheet
      Caption = 'Dati pagamento'
      ImageIndex = 3
    end
    object TabSheet5: TTabSheet
      Caption = 'Allegati'
      ImageIndex = 4
    end
  end
  object BSFatturaElettronicaBody: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioTypeName = 'IXMLFatturaElettronicaBodyType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '2:FatturaElettronicaBody'
    ioVM_Marker = 'BSFatturaElettronicaBody'
    ioVM_UseBSPropsOnCreate = False
    Left = 484
    Top = 200
  end
end
