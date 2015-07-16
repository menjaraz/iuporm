inherited paViewModelForViewService: TpaViewModelForViewService
  Height = 251
  inherited Commands: TActionList
    object acNew: TAction [0]
      Caption = 'acNew'
      OnExecute = acNewExecute
    end
    object acLoadFromFile: TAction [1]
      Caption = 'acLoad'
      OnExecute = acLoadFromFileExecute
    end
    object acSaveToFile: TAction [2]
      Caption = 'acSaveToFile'
      OnExecute = acSaveToFileExecute
      OnUpdate = acSaveToFileUpdate
    end
    object acClose: TAction
      Caption = 'acClose'
      OnExecute = acCloseExecute
      OnUpdate = acCloseUpdate
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
