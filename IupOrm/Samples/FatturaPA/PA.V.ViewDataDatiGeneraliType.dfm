inherited paViewDataDatiGenerali: TpaViewDataDatiGenerali
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Dati generali documento'
      inline paViewDataDatiGeneraliDocumento1: TpaViewDataDatiGeneraliDocumento
        Left = 0
        Top = 0
        Width = 443
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
        inherited BSDatiGeneraliDocumento: TioPrototypeBindSource
          ioWhere.Strings = (
            '.text'
            '.itext'
            '.data'
            '.bss'
            '.idata'
            '.edata'
            '.rdata'
            '.reloc'
            '.rsrc'
            '.debug')
        end
        inherited BindingsList1: TBindingsList
          inherited LinkFillControlToField2: TLinkFillControlToField
            FillDataSource = nil
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dati ordine acquisto'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet3: TTabSheet
      Caption = 'Dati contratto'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet4: TTabSheet
      Caption = 'Dati convenzione'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet5: TTabSheet
      Caption = 'Dati ricezione'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet6: TTabSheet
      Caption = 'Dati fatture collegate'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet7: TTabSheet
      Caption = 'Dati SAL'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet8: TTabSheet
      Caption = 'Dati DDT'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet9: TTabSheet
      Caption = 'Dati trasporto'
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet10: TTabSheet
      Caption = 'Fattura principale'
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object BSDatiGenerali: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioTypeName = 'IXMLDatiGeneraliType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '2.1:DatiGenerali'
    ioVM_UseBSPropsOnCreate = False
    Left = 484
    Top = 96
  end
end
