object paView: TpaView
  Left = 0
  Top = 0
  Width = 800
  Height = 341
  ParentCustomHint = False
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
  object LeftSidePanel: TPanel
    Left = 0
    Top = 0
    Width = 17
    Height = 341
    Align = alLeft
    BevelOuter = bvNone
    Color = 14342874
    ParentBackground = False
    TabOrder = 0
    Visible = False
    OnResize = LeftSidePanelResize
    object CheckBoxViewSelection: TCheckBox
      Left = 2
      Top = 1
      Width = 97
      Height = 17
      Cursor = crHandPoint
      TabOrder = 0
    end
  end
  object WorkSpace: TScrollBox
    Left = 17
    Top = 0
    Width = 783
    Height = 341
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 1
  end
end
