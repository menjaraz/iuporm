inherited paViewDataFatturaElettronicaHeaderType: TpaViewDataFatturaElettronicaHeaderType
  Width = 834
  Height = 600
  ExplicitWidth = 834
  ExplicitHeight = 600
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 834
    Height = 600
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Dati trasmissione'
      ImageIndex = 1
    end
    object TabSheet1: TTabSheet
      Caption = 'Cedente/Prestatore'
      inline paViewDataCedentePrestatoreType1: TpaViewDataCedentePrestatoreType
        Left = 0
        Top = 0
        Width = 826
        Height = 341
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 826
        inherited paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
          Width = 826
          ExplicitWidth = 826
          inherited paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
            Width = 826
            ExplicitWidth = 826
            inherited eIdCodice: TEdit
              Width = 612
              ExplicitWidth = 612
            end
            inherited eIdPaese: TComboBox
              Text = 'Bitmap20'
              Items.Strings = (
                'Bitmap1'
                'Bitmap1'
                'Bitmap1'
                'Bitmap1'
                'Bitmap10'
                'Bitmap10'
                'Bitmap10'
                'Bitmap10'
                'Bitmap11'
                'Bitmap11'
                'Bitmap11'
                'Bitmap11'
                'Bitmap12'
                'Bitmap12'
                'Bitmap12'
                'Bitmap12'
                'Bitmap13'
                'Bitmap13'
                'Bitmap13'
                'Bitmap13'
                'Bitmap14'
                'Bitmap14'
                'Bitmap14'
                'Bitmap14'
                'Bitmap15'
                'Bitmap15'
                'Bitmap15'
                'Bitmap15'
                'Bitmap16'
                'Bitmap16'
                'Bitmap16'
                'Bitmap16'
                'Bitmap17'
                'Bitmap17'
                'Bitmap17'
                'Bitmap17'
                'Bitmap18'
                'Bitmap18'
                'Bitmap18'
                'Bitmap18'
                'Bitmap19'
                'Bitmap19'
                'Bitmap19'
                'Bitmap19'
                'Bitmap2'
                'Bitmap2'
                'Bitmap2'
                'Bitmap2'
                'Bitmap20'
                'Bitmap20'
                'Bitmap20'
                'Bitmap20'
                'Bitmap21'
                'Bitmap21'
                'Bitmap21'
                'Bitmap21'
                'Bitmap22'
                'Bitmap22'
                'Bitmap22'
                'Bitmap22'
                'Bitmap23'
                'Bitmap23'
                'Bitmap23'
                'Bitmap23'
                'Bitmap24'
                'Bitmap24'
                'Bitmap24'
                'Bitmap24'
                'Bitmap25'
                'Bitmap25'
                'Bitmap25'
                'Bitmap25'
                'Bitmap26'
                'Bitmap26'
                'Bitmap26'
                'Bitmap26'
                'Bitmap27'
                'Bitmap27'
                'Bitmap27'
                'Bitmap27'
                'Bitmap28'
                'Bitmap28'
                'Bitmap28'
                'Bitmap28'
                'Bitmap29'
                'Bitmap29'
                'Bitmap29'
                'Bitmap29'
                'Bitmap3'
                'Bitmap3'
                'Bitmap3'
                'Bitmap3'
                'Bitmap30'
                'Bitmap30'
                'Bitmap30'
                'Bitmap30'
                'Bitmap31'
                'Bitmap31'
                'Bitmap31'
                'Bitmap31'
                'Bitmap32'
                'Bitmap32'
                'Bitmap32'
                'Bitmap32'
                'Bitmap33'
                'Bitmap33'
                'Bitmap33'
                'Bitmap33'
                'Bitmap34'
                'Bitmap34'
                'Bitmap34'
                'Bitmap34'
                'Bitmap35'
                'Bitmap35'
                'Bitmap35'
                'Bitmap35'
                'Bitmap36'
                'Bitmap36'
                'Bitmap36'
                'Bitmap36'
                'Bitmap37'
                'Bitmap37'
                'Bitmap37'
                'Bitmap37'
                'Bitmap38'
                'Bitmap38'
                'Bitmap38'
                'Bitmap38'
                'Bitmap39'
                'Bitmap39'
                'Bitmap39'
                'Bitmap39'
                'Bitmap4'
                'Bitmap4'
                'Bitmap4'
                'Bitmap4'
                'Bitmap40'
                'Bitmap40'
                'Bitmap40'
                'Bitmap40'
                'Bitmap41'
                'Bitmap41'
                'Bitmap41'
                'Bitmap41'
                'Bitmap42'
                'Bitmap42'
                'Bitmap42'
                'Bitmap42'
                'Bitmap43'
                'Bitmap43'
                'Bitmap43'
                'Bitmap43'
                'Bitmap44'
                'Bitmap44'
                'Bitmap44'
                'Bitmap44'
                'Bitmap45'
                'Bitmap45'
                'Bitmap45'
                'Bitmap45'
                'Bitmap46'
                'Bitmap46'
                'Bitmap46'
                'Bitmap46'
                'Bitmap47'
                'Bitmap47'
                'Bitmap47'
                'Bitmap47'
                'Bitmap48'
                'Bitmap48'
                'Bitmap48'
                'Bitmap48'
                'Bitmap49'
                'Bitmap49'
                'Bitmap49'
                'Bitmap49'
                'Bitmap5'
                'Bitmap5'
                'Bitmap5'
                'Bitmap5'
                'Bitmap50'
                'Bitmap50'
                'Bitmap50'
                'Bitmap50'
                'Bitmap6'
                'Bitmap6'
                'Bitmap6'
                'Bitmap6'
                'Bitmap7'
                'Bitmap7'
                'Bitmap7'
                'Bitmap7'
                'Bitmap8'
                'Bitmap8'
                'Bitmap8'
                'Bitmap8'
                'Bitmap9'
                'Bitmap9'
                'Bitmap9'
                'Bitmap9')
            end
          end
          inherited paViewDataAnagraficaType1: TpaViewDataAnagraficaType
            Width = 826
            ExplicitWidth = 826
            inherited eDenominazione: TEdit
              Width = 728
              ExplicitWidth = 728
            end
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Rappresentante fiscale'
      ImageIndex = 2
    end
    object TabSheet4: TTabSheet
      Caption = 'Cessionario/Committente'
      ImageIndex = 3
    end
    object TabSheet5: TTabSheet
      Caption = 'Terzo intermediario/Sogg. emittente'
      ImageIndex = 4
    end
    object TabSheet6: TTabSheet
      Caption = 'Soggetto emittente'
      ImageIndex = 5
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
    ioVM_Interface = 'IpaViewModelForDataView'
    ioVM_Alias = '1:FatturaElettronicaHeader'
    ioVM_UseBSPropsOnCreate = False
    Left = 620
    Top = 328
  end
end
