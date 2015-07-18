inherited paViewModelForViewContainer: TpaViewModelForViewContainer
  inherited Commands: TActionList
    object acAdd: TAction
      Caption = 'Aggiungi'
      OnExecute = acAddExecute
    end
    object acDelete: TAction
      Caption = 'Elimina'
      OnExecute = acDeleteExecute
      OnUpdate = acDeleteUpdate
    end
  end
end
