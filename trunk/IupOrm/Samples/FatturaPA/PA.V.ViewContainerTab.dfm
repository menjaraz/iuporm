inherited paViewContainerTab: TpaViewContainerTab
  Height = 519
  ExplicitHeight = 519
  inherited LeftSidePanel: TPanel
    Height = 500
    ExplicitHeight = 500
  end
  inherited WorkSpace: TScrollBox
    Height = 500
    ExplicitHeight = 500
    object ChildsArea: TPageControl
      Left = 0
      Top = 0
      Width = 783
      Height = 500
      Align = alClient
      TabOrder = 0
      OnChange = ChildsAreaChange
    end
  end
end
