inherited paViewDataFatturaElettronicaBody: TpaViewDataFatturaElettronicaBody
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited LeftSidePanel: TPanel
    Height = 305
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
        Caption = 'Dati generali'
        inline paViewDataDatiGenerali1: TpaViewDataDatiGenerali
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
            ExplicitHeight = 277
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
              inherited TabSheet1: TTabSheet
                ExplicitWidth = 401
                ExplicitHeight = 249
                inherited paViewDataDatiGeneraliDocumento1: TpaViewDataDatiGeneraliDocumento
                  Width = 401
                  Height = 249
                  ExplicitWidth = 401
                  ExplicitHeight = 249
                  inherited LeftSidePanel: TPanel
                    Height = 249
                    ExplicitHeight = 249
                  end
                  inherited WorkSpace: TScrollBox
                    Width = 384
                    Height = 249
                    ExplicitWidth = 384
                    ExplicitHeight = 249
                  end
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet3: TTabSheet
        Caption = 'Dati veicoli'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet4: TTabSheet
        Caption = 'Dati pagamento'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet5: TTabSheet
        Caption = 'Allegati'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
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
