inherited paViewModelForMasterView: TpaViewModelForMasterView
  Height = 251
  inherited Commands: TActionList
    object acNew: TAction
      Caption = 'acNew'
      OnExecute = acNewExecute
    end
    object acLoadFromFile: TAction
      Caption = 'acLoad'
      OnExecute = acLoadFromFileExecute
    end
    object acSaveToFile: TAction
      Caption = 'acSaveToFile'
      OnExecute = acSaveToFileExecute
      OnUpdate = acSaveToFileUpdate
    end
  end
  object OD1: TOpenDialog
    Left = 32
    Top = 176
  end
  object SD1: TSaveDialog
    DefaultExt = 'XML'
    Left = 128
    Top = 147
  end
end
