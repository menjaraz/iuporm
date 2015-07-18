inherited paViewDataFatturaElettronicaHeaderType: TpaViewDataFatturaElettronicaHeaderType
  Width = 834
  Height = 600
  ExplicitWidth = 834
  ExplicitHeight = 600
  inherited LeftSidePanel: TPanel
    Height = 600
    TabOrder = 1
    ExplicitHeight = 600
  end
  inherited WorkSpace: TScrollBox
    Width = 817
    Height = 600
    TabOrder = 0
    ExplicitWidth = 817
    ExplicitHeight = 600
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 817
      Height = 600
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet2: TTabSheet
        Caption = 'Dati trasmissione'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet1: TTabSheet
        Caption = 'Cedente/Prestatore'
        inline paViewDataCedentePrestatoreType1: TpaViewDataCedentePrestatoreType
          Left = 0
          Top = 0
          Width = 809
          Height = 199
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
          ExplicitHeight = 199
          inherited LeftSidePanel: TPanel
            Height = 30
          end
          inherited WorkSpace: TScrollBox
            Width = 792
            Height = 30
            ExplicitWidth = 792
            ExplicitHeight = 30
          end
          inherited paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
            Width = 809
            ExplicitWidth = 809
            inherited paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
              Width = 809
              ExplicitWidth = 809
              inherited WorkSpace: TScrollBox
                Width = 792
                ExplicitWidth = 792
                inherited eIdCodice: TEdit
                  Width = 188
                  ExplicitWidth = 188
                end
              end
            end
            inherited WorkSpace: TScrollBox
              Width = 792
              ExplicitWidth = 792
            end
            inherited paViewDataAnagraficaType1: TpaViewDataAnagraficaType
              Width = 809
              ExplicitWidth = 809
              inherited WorkSpace: TScrollBox
                Width = 792
                ExplicitWidth = 792
                inherited eDenominazione: TEdit
                  Width = 315
                  ExplicitWidth = 315
                end
              end
            end
          end
          inherited BSCedentePrestatoreType: TioPrototypeBindSource
            Top = 160
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Rappresentante fiscale'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet4: TTabSheet
        Caption = 'Cessionario/Committente'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet5: TTabSheet
        Caption = 'Terzo intermediario/Sogg. emittente'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet6: TTabSheet
        Caption = 'Soggetto emittente'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  object BSFatturaElettronicaHeaderType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioTypeName = 'IXMLFatturaElettronicaHeaderType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '1:FatturaElettronicaHeader'
    ioVM_UseBSPropsOnCreate = False
    Left = 620
    Top = 304
  end
end
