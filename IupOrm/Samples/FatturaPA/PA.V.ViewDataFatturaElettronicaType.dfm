inherited paViewDataFatturaElettronicaType: TpaViewDataFatturaElettronicaType
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited LeftSidePanel: TPanel
    Height = 305
    ExplicitHeight = 305
  end
  inherited WorkSpace: TScrollBox
    Width = 434
    Height = 305
    ExplicitWidth = 434
    ExplicitHeight = 305
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 434
      Height = 305
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Header'
        inline paViewDataFatturaElettronicaHeaderType1: TpaViewDataFatturaElettronicaHeaderType
          Left = 0
          Top = 0
          Width = 426
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
          ExplicitWidth = 426
          ExplicitHeight = 277
          inherited LeftSidePanel: TPanel
            Height = 277
          end
          inherited WorkSpace: TScrollBox
            Width = 409
            Height = 277
            ExplicitWidth = 409
            ExplicitHeight = 277
            inherited PageControl1: TPageControl
              Width = 409
              Height = 277
              ExplicitWidth = 409
              ExplicitHeight = 277
              inherited TabSheet2: TTabSheet
                ExplicitLeft = 4
                ExplicitTop = 24
                ExplicitWidth = 809
                ExplicitHeight = 572
              end
              inherited TabSheet1: TTabSheet
                ExplicitWidth = 401
                ExplicitHeight = 249
                inherited paViewDataCedentePrestatoreType1: TpaViewDataCedentePrestatoreType
                  Width = 401
                  ExplicitWidth = 401
                  inherited WorkSpace: TScrollBox
                    Width = 384
                    ExplicitWidth = 384
                  end
                  inherited paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
                    Width = 401
                    ExplicitWidth = 401
                    inherited paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
                      Width = 401
                      ExplicitWidth = 401
                      inherited WorkSpace: TScrollBox
                        Width = 384
                        ExplicitWidth = 384
                        inherited eIdCodice: TEdit
                          Width = 0
                          ExplicitWidth = 0
                        end
                      end
                    end
                    inherited WorkSpace: TScrollBox
                      Width = 384
                      ExplicitWidth = 384
                    end
                    inherited paViewDataAnagraficaType1: TpaViewDataAnagraficaType
                      Width = 401
                      ExplicitWidth = 401
                      inherited WorkSpace: TScrollBox
                        Width = 384
                        ExplicitWidth = 384
                        inherited eDenominazione: TEdit
                          Width = 1731
                          ExplicitWidth = 1731
                        end
                      end
                    end
                  end
                end
              end
              inherited TabSheet3: TTabSheet
                ExplicitLeft = 4
                ExplicitTop = 24
                ExplicitWidth = 809
                ExplicitHeight = 572
              end
              inherited TabSheet4: TTabSheet
                ExplicitLeft = 4
                ExplicitTop = 24
                ExplicitWidth = 809
                ExplicitHeight = 572
              end
              inherited TabSheet5: TTabSheet
                ExplicitLeft = 4
                ExplicitTop = 24
                ExplicitWidth = 809
                ExplicitHeight = 572
              end
              inherited TabSheet6: TTabSheet
                ExplicitLeft = 4
                ExplicitTop = 24
                ExplicitWidth = 809
                ExplicitHeight = 572
              end
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Body'
        ImageIndex = 1
        inline paViewContainerTabFatturaElettronicaBody1: TpaViewContainerTabFatturaElettronicaBody
          Left = 0
          Top = 0
          Width = 426
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
          ExplicitWidth = 426
          ExplicitHeight = 277
          inherited Panel1: TPanel
            Width = 426
            ExplicitWidth = 426
          end
          inherited LeftSidePanel: TPanel
            Height = 258
          end
          inherited WorkSpace: TScrollBox
            Width = 409
            Height = 258
            ExplicitWidth = 409
            ExplicitHeight = 258
            inherited ChildsArea: TPageControl
              Width = 938
              Height = 258
              ExplicitWidth = 409
              ExplicitHeight = 258
            end
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Signature'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  object BSFatturaElettronica: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Versione'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLFatturaElettronicaType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '0:FatturaElettronica'
    ioVM_Marker = 'BSFatturaElettronica'
    ioVM_UseBSPropsOnCreate = False
    Left = 620
    Top = 408
  end
end
