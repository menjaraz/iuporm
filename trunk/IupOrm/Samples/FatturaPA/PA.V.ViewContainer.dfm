inherited paViewContainer: TpaViewContainer
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 800
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    Color = 14342874
    ParentBackground = False
    TabOrder = 1
    object ButtonAdd: TSpeedButton
      Left = 0
      Top = 0
      Width = 71
      Height = 19
      Cursor = crHandPoint
      Align = alLeft
      Caption = 'Aggiungi'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 2
      ExplicitTop = 1
      ExplicitHeight = 17
    end
    object ButtonDelete: TSpeedButton
      Left = 742
      Top = 0
      Width = 58
      Height = 19
      Cursor = crHandPoint
      Align = alRight
      Caption = 'Elimina'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 741
    end
  end
  inherited LeftSidePanel: TPanel
    Top = 19
    Height = 322
    ExplicitTop = 19
    ExplicitHeight = 322
  end
  inherited WorkSpace: TScrollBox
    Top = 19
    Height = 322
    TabOrder = 2
    ExplicitTop = 19
    ExplicitHeight = 322
  end
end
