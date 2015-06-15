inherited VCL_ViewModel: TVCL_ViewModel
  inherited Commands: TActionList
    object acHello: TAction
      Caption = 'acHello'
      OnExecute = acHelloExecute
    end
    object acOnOff: TAction
      Caption = 'acOnOff'
      OnExecute = acOnOffExecute
    end
  end
end
