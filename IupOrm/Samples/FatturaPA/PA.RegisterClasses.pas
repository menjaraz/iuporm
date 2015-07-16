unit PA.RegisterClasses;

interface

type

  TDIClassRegister = class
  public
    class procedure RegisterClasses;
  end;

implementation

uses
  IupOrm, PA.VM.ViewModelForViewService, PA.VM.Interfaces,
  IupOrm.MVVM.Interfaces, System.Rtti, fatturapa_v11, PA.VM.ViewModelForViewData,
  PA.U.DuckTyped.XMLList, PA.U.DuckTyped.Interfaces, IupOrm.Containers.List, IupOrm.Containers.Interfaces,
  PA.V.Interfaces, PA.VM.ViewModelForViewContainer, PA.V.ViewDataFatturaElettronicaBody,
  Unit1, Vcl.Controls, PA.V.ViewDataFatturaElettronicaType;

{ TDIClassRegister }

class procedure TDIClassRegister.RegisterClasses;
begin
  // ViewModelForMasterView
  TIupOrm.DependencyInjection.RegisterClass<TpaViewModelForViewService>.Implements<IpaViewModelForViewService>.Execute;


  // ================================================
  // MODEL CLASSES REGISTRATION
  // ------------------------------------------------
  // Fattura elettronica
  TIupOrm.DependencyInjection.RegisterClass<TXMLFatturaElettronicaType>.Implements<IXMLFatturaElettronicaType>.Execute;
  // Fattura elettronica header
  TIupOrm.DependencyInjection.RegisterClass<TXMLFatturaElettronicaHeaderType>.Implements<IXMLFatturaElettronicaHeaderType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLCedentePrestatoreType>.Implements<IXMLCedentePrestatoreType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLDatiAnagraficiCedenteType>.Implements<IXMLDatiAnagraficiCedenteType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLIdFiscaleType>.Implements<IXMLIdFiscaleType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLAnagraficaType>.Implements<IXMLAnagraficaType>.Execute;
  // Fattura elettronica body
  TIupOrm.DependencyInjection.RegisterClass<TXMLFatturaElettronicaBodyTypeList>.Implements<IXMLFatturaElettronicaBodyTypeList>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLFatturaElettronicaBodyType>.Implements<IXMLFatturaElettronicaBodyType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLDatiGeneraliType>.Implements<IXMLDatiGeneraliType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLDatiGeneraliDocumentoType>.Implements<IXMLDatiGeneraliDocumentoType>.Execute;
  // ================================================


  // ================================================
  // VIEWS REGISTRATION
  // ------------------------------------------------
  TIupOrm.DependencyInjection.RegisterClass<TpaViewDataFatturaElettronicaType>.Implements<IpaViewData>('0:FatturaElettronica').AsSingleton.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TpaViewDataFatturaElettronicaBody>.Implements<IpaViewData>('2:FatturaElettronicaBody').AsSingleton.Execute;
  // ================================================



  // ================================================
  // FATTURA ELETTRONICA ROOT
  // ------------------------------------------------
  // FatturaElettronica
//  TIupOrm.DependencyInjection.
//    RegisterClass<TpaViewModelForViewData>.
//    Implements<IpaViewModelForViewData>('0:FatturaElettronica').
//    DefaultConstructorMarker('CreateByTypeName').
//    DefaultConstructorParams(['IXMLFatturaElettronicaType', '', '', TValue.From<TioViewDataType>(dtSingle), False]).
//    AsSingleton.Execute;
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('0:FatturaElettronica').
    AsSingleton.Execute;
  // ================================================



  // ================================================
  // FATTURA ELETTRONICA HEADER
  // ------------------------------------------------
  // 1: FatturaElettronicaHeader
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('1:FatturaElettronicaHeader').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '0:FatturaElettronica', 'FatturaElettronicaHeader']).
    AsSingleton.Execute;
  // 1.2: FatturaElettronicaHeader.CedentePrestatore
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('1.2:CedentePrestatore').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '1:FatturaElettronicaHeader', 'CedentePrestatore']).
    AsSingleton.Execute;
  // 1.2.1: FatturaElettronicaHeader.CedentePrestatore.DatiAnagrafici
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('1.2.1:DatiAnagrafici').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '1.2:CedentePrestatore', 'DatiAnagrafici']).
    AsSingleton.Execute;
  // 1.2.1.1: FatturaElettronicaHeader.CedentePrestatore.DatiAnagrafici.IdFiscaleIVA
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('1.2.1.1:IdFiscaleIVA').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '1.2.1:DatiAnagrafici', 'IdFiscaleIVA']).
    AsSingleton.Execute;
  // 1.2.1.3: FatturaElettronicaHeader.CedentePrestatore.DatiAnagrafici.Anagrafica
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('1.2.1.3:Anagrafica').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '1.2.1:DatiAnagrafici', 'Anagrafica']).
    AsSingleton.Execute;
  // ================================================



  // ================================================
  // FATTURA ELETTRONICA BODY
  // ------------------------------------------------
  // 2.List: FatturaElettronicaBodyList
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewContainer>.
    Implements<IpaViewModelForViewContainer>('2.List:FatturaElettronicaBodyList').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '0:FatturaElettronica', 'FatturaElettronicaBody']).
    InjectProperty('ChildView_Interface', 'IpaViewData').
    InjectProperty('ChildView_Alias', '2:FatturaElettronicaBody').
    InjectProperty('ChildVM_Interface', 'IpaViewModelForViewData').
    InjectProperty('ChildVM_Alias', '2:FatturaElettronicaBody').
    AsSingleton.Execute;
  // 2: FatturaElettronicaBody
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.Implements<IpaViewModelForViewData>('2:FatturaElettronicaBody').AsSingleton.Execute;
  // 2.1: FatturaElettronicaBody.DatiGenerali
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('2.1:DatiGenerali').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '2:FatturaElettronicaBody', 'DatiGenerali']).
    AsSingleton.Execute;
  // 2.1.1: FatturaElettronicaBody.DatiGeneraliDocumento
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForViewData>.
    Implements<IpaViewModelForViewData>('2.1.1:DatiGeneraliDocumento').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForViewData', '2.1:DatiGenerali', 'DatiGeneraliDocumento']).
    AsSingleton.Execute;
  // ================================================


  // Other classes
  TIupOrm.DependencyInjection.RegisterClass<TDuckTypedXMLList>.Implements<IDuckTypedXMLList>.Execute;

  // Other collections
  TIupOrm.DependencyInjection.RegisterClass<TioInterfacedList<IpaView>>.Implements<IioList<IpaView>>.Execute;

end;

initialization

  TDIClassRegister.RegisterClasses;

end.
