object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 610
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inline paViewDataMaster1: TpaViewDataMaster
    Left = 0
    Top = 0
    Width = 943
    Height = 610
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 943
    ExplicitHeight = 610
    inherited Panel1: TPanel
      Width = 943
      ExplicitWidth = 943
    end
    inherited paViewDataFatturaElettronicaType1: TpaViewDataFatturaElettronicaType
      Width = 943
      Height = 569
      ExplicitWidth = 943
      ExplicitHeight = 569
      inherited PageControl1: TPageControl
        Width = 943
        Height = 569
        ExplicitWidth = 943
        ExplicitHeight = 569
        inherited TabSheet1: TTabSheet
          ExplicitWidth = 935
          ExplicitHeight = 541
          inherited paViewDataFatturaElettronicaHeaderType1: TpaViewDataFatturaElettronicaHeaderType
            Width = 935
            Height = 541
            ExplicitWidth = 935
            ExplicitHeight = 541
            inherited PageControl1: TPageControl
              Width = 935
              Height = 541
              ExplicitWidth = 935
              ExplicitHeight = 541
              inherited TabSheet1: TTabSheet
                ExplicitWidth = 927
                ExplicitHeight = 513
                inherited paViewDataCedentePrestatoreType1: TpaViewDataCedentePrestatoreType
                  Width = 927
                  ExplicitWidth = 927
                  inherited paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType
                    Width = 927
                    ExplicitWidth = 927
                    inherited paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType
                      Width = 927
                      ExplicitWidth = 927
                      inherited eIdCodice: TEdit
                        Width = 713
                        ExplicitWidth = 713
                      end
                    end
                    inherited paViewDataAnagraficaType1: TpaViewDataAnagraficaType
                      Width = 927
                      ExplicitWidth = 927
                      inherited eDenominazione: TEdit
                        Width = 829
                        ExplicitWidth = 829
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
