inherited paViewDataMaster: TpaViewDataMaster
  Width = 931
  Height = 593
  TabOrder = 1
  ExplicitWidth = 931
  ExplicitHeight = 593
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 931
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonNew: TButton
      Left = 5
      Top = 5
      Width = 116
      Height = 32
      Caption = 'New'
      TabOrder = 0
    end
    object ButtonLoad: TButton
      Left = 127
      Top = 5
      Width = 116
      Height = 32
      Caption = 'Load'
      TabOrder = 1
    end
    object ButtonSave: TButton
      Left = 249
      Top = 5
      Width = 116
      Height = 32
      Caption = 'Save'
      TabOrder = 2
    end
  end
  inline paViewDataFatturaElettronicaType1: TpaViewDataFatturaElettronicaType
    Left = 0
    Top = 41
    Width = 931
    Height = 552
    Align = alClient
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 931
    ExplicitHeight = 552
    inherited PageControl1: TPageControl
      Width = 931
      Height = 552
      ExplicitWidth = 931
      ExplicitHeight = 552
      inherited TabSheet1: TTabSheet
        ExplicitWidth = 923
        ExplicitHeight = 524
        inherited paViewDataFatturaElettronicaHeaderType1: TpaViewDataFatturaElettronicaHeaderType
          Width = 923
          Height = 524
          ExplicitWidth = 923
          ExplicitHeight = 524
          inherited PageControl1: TPageControl
            Width = 923
            Height = 524
            ExplicitWidth = 923
            ExplicitHeight = 524
            inherited TabSheet1: TTabSheet
              ExplicitWidth = 915
              ExplicitHeight = 496
              inherited paViewDataCedentePrestatoreType1: TpaViewDataCedentePrestatoreType
                Width = 915
                ExplicitWidth = 915
                inherited paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
                  Width = 915
                  ExplicitWidth = 915
                  inherited paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
                    Width = 915
                    ExplicitWidth = 915
                    inherited eIdCodice: TEdit
                      Width = 701
                      ExplicitWidth = 701
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
                    Width = 915
                    ExplicitWidth = 915
                    inherited eDenominazione: TEdit
                      Width = 817
                      ExplicitWidth = 817
                    end
                  end
                end
              end
            end
          end
        end
      end
      inherited TabSheet2: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 885
        ExplicitHeight = 545
      end
      inherited TabSheet3: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 885
        ExplicitHeight = 545
      end
    end
  end
  object BSMaster: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    ioOnNeedViewModel = BSMasterioOnNeedViewModel
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForMasterView'
    ioVM_UseBSPropsOnCreate = False
    Left = 288
    Top = 496
  end
end
