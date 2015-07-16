inherited paViewDataIdFiscaleType: TpaViewDataIdFiscaleType
  Width = 708
  Height = 28
  ExplicitWidth = 708
  ExplicitHeight = 28
  DesignSize = (
    708
    28)
  object Label1: TLabel
    Left = 11
    Top = 6
    Width = 39
    Height = 13
    Caption = 'IdPaese'
  end
  object Label2: TLabel
    Left = 163
    Top = 6
    Width = 42
    Height = 13
    Caption = 'IdCodice'
  end
  object eIdCodice: TEdit
    Left = 211
    Top = 3
    Width = 494
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'Bitmap28'
  end
  object eIdPaese: TComboBox
    Left = 62
    Top = 3
    Width = 60
    Height = 21
    ItemIndex = 49
    Sorted = True
    TabOrder = 0
    Text = 'Bitmap28'
    Items.Strings = (
      'Bitmap38'
      'Bitmap50'
      'Bitmap18'
      'Bitmap12'
      'Bitmap26'
      'Bitmap49'
      'Bitmap21'
      'Bitmap23'
      'Bitmap24'
      'Bitmap31'
      'Bitmap27'
      'Bitmap7'
      'Bitmap4'
      'Bitmap30'
      'Bitmap5'
      'Bitmap2'
      'Bitmap34'
      'Bitmap13'
      'Bitmap45'
      'Bitmap11'
      'Bitmap37'
      'Bitmap15'
      'Bitmap20'
      'Bitmap39'
      'Bitmap9'
      'Bitmap48'
      'Bitmap6'
      'Bitmap42'
      'Bitmap3'
      'Bitmap32'
      'Bitmap33'
      'Bitmap17'
      'Bitmap10'
      'Bitmap35'
      'Bitmap8'
      'Bitmap40'
      'Bitmap1'
      'Bitmap29'
      'Bitmap36'
      'Bitmap44'
      'Bitmap22'
      'Bitmap25'
      'Bitmap19'
      'Bitmap47'
      'Bitmap43'
      'Bitmap41'
      'Bitmap14'
      'Bitmap16'
      'Bitmap46'
      'Bitmap28'
      'Bitmap38'
      'Bitmap50'
      'Bitmap18'
      'Bitmap12'
      'Bitmap26'
      'Bitmap49'
      'Bitmap21'
      'Bitmap23'
      'Bitmap24'
      'Bitmap31'
      'Bitmap27'
      'Bitmap7'
      'Bitmap4'
      'Bitmap30'
      'Bitmap5'
      'Bitmap2'
      'Bitmap34'
      'Bitmap13'
      'Bitmap45'
      'Bitmap11'
      'Bitmap37'
      'Bitmap15'
      'Bitmap20'
      'Bitmap39'
      'Bitmap9'
      'Bitmap48'
      'Bitmap6'
      'Bitmap42'
      'Bitmap3'
      'Bitmap32'
      'Bitmap33'
      'Bitmap17'
      'Bitmap10'
      'Bitmap35'
      'Bitmap8'
      'Bitmap40'
      'Bitmap1'
      'Bitmap29'
      'Bitmap36'
      'Bitmap44'
      'Bitmap22'
      'Bitmap25'
      'Bitmap19'
      'Bitmap47'
      'Bitmap43'
      'Bitmap41'
      'Bitmap14'
      'Bitmap16'
      'Bitmap46'
      'Bitmap28'
      'Bitmap38'
      'Bitmap50'
      'Bitmap18'
      'Bitmap12'
      'Bitmap26'
      'Bitmap49'
      'Bitmap21'
      'Bitmap23'
      'Bitmap24'
      'Bitmap31'
      'Bitmap27'
      'Bitmap7'
      'Bitmap4'
      'Bitmap30'
      'Bitmap5'
      'Bitmap2'
      'Bitmap34'
      'Bitmap13'
      'Bitmap45'
      'Bitmap11'
      'Bitmap37'
      'Bitmap15'
      'Bitmap20'
      'Bitmap39'
      'Bitmap9'
      'Bitmap48'
      'Bitmap6'
      'Bitmap42'
      'Bitmap3'
      'Bitmap32'
      'Bitmap33'
      'Bitmap17'
      'Bitmap10'
      'Bitmap35'
      'Bitmap8'
      'Bitmap40'
      'Bitmap1'
      'Bitmap29'
      'Bitmap36'
      'Bitmap44'
      'Bitmap22'
      'Bitmap25'
      'Bitmap19'
      'Bitmap47'
      'Bitmap43'
      'Bitmap41'
      'Bitmap14'
      'Bitmap16'
      'Bitmap46'
      'Bitmap28'
      'Bitmap38'
      'Bitmap50'
      'Bitmap18'
      'Bitmap12'
      'Bitmap26'
      'Bitmap49'
      'Bitmap21'
      'Bitmap23'
      'Bitmap24'
      'Bitmap31'
      'Bitmap27'
      'Bitmap7'
      'Bitmap4'
      'Bitmap30'
      'Bitmap5'
      'Bitmap2'
      'Bitmap34'
      'Bitmap13'
      'Bitmap45'
      'Bitmap11'
      'Bitmap37'
      'Bitmap15'
      'Bitmap20'
      'Bitmap39'
      'Bitmap9'
      'Bitmap48'
      'Bitmap6'
      'Bitmap42'
      'Bitmap3'
      'Bitmap32'
      'Bitmap33'
      'Bitmap17'
      'Bitmap10'
      'Bitmap35'
      'Bitmap8'
      'Bitmap40'
      'Bitmap1'
      'Bitmap29'
      'Bitmap36'
      'Bitmap44'
      'Bitmap22'
      'Bitmap25'
      'Bitmap19'
      'Bitmap47'
      'Bitmap43'
      'Bitmap41'
      'Bitmap14'
      'Bitmap16'
      'Bitmap46'
      'Bitmap28')
  end
  object BSIdFiscaleType: TioPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'IdPaese'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'IdCodice'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    ioTypeName = 'IXMLIdFiscaleType'
    ioAutoLoadData = False
    ioAutoPersist = False
    ioViewDataType = dtSingle
    ioAutoRefreshOnNotification = arEnabledNoReload
    ioVM_Interface = 'IpaViewModelForViewData'
    ioVM_Alias = '1.2.1.1:IdFiscaleIVA'
    ioVM_UseBSPropsOnCreate = False
    Left = 416
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 380
    Top = 65533
    object LinkFillControlToField1: TLinkFillControlToField
      Category = 'Quick Bindings'
      DataSource = BSIdFiscaleType
      FieldName = 'IdPaese'
      Control = eIdPaese
      Track = True
      FillDataSource = BSIdFiscaleType
      FillDisplayFieldName = 'IdPaese'
      AutoFill = True
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BSIdFiscaleType
      FieldName = 'IdCodice'
      Control = eIdCodice
      Track = True
    end
  end
end
