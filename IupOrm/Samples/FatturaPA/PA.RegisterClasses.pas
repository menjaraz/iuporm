unit PA.RegisterClasses;

interface

type

  TDIClassRegister = class
  public
    class procedure RegisterClasses;
  end;

implementation

uses
  IupOrm, PA.VM.ViewModelForMasterView, PA.VM.Interfaces,
  IupOrm.MVVM.Interfaces, System.Rtti, fatturapa_v11, PA.VM.ViewModelForDataView;

{ TDIClassRegister }

class procedure TDIClassRegister.RegisterClasses;
begin
  // ViewModelForMasterView
  TIupOrm.DependencyInjection.RegisterClass<TpaViewModelForMasterView>.Implements<IpaViewModelForMasterView>.Execute;
//    .InjectProperty('ioAutoLoadData', False)
//    .InjectProperty('ioViewDataType', TValue.From<TioViewDataType>(dtSingle))
//    .InjectProperty('ioTypeName', 'IXMLFatturaElettronicaType')
//      .Execute;


  // Model classes registration
  TIupOrm.DependencyInjection.RegisterClass<TXMLFatturaElettronicaType>.Implements<IXMLFatturaElettronicaType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLFatturaElettronicaHeaderType>.Implements<IXMLFatturaElettronicaHeaderType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLCedentePrestatoreType>.Implements<IXMLCedentePrestatoreType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLDatiAnagraficiCedenteType>.Implements<IXMLDatiAnagraficiCedenteType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLIdFiscaleType>.Implements<IXMLIdFiscaleType>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TXMLAnagraficaType>.Implements<IXMLAnagraficaType>.Execute;





  // FatturaElettronica
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForDataView>.
    Implements<IpaViewModelForDataView>('0:FatturaElettronica').
    DefaultConstructorMarker('CreateByTypeName').
    DefaultConstructorParams(['IXMLFatturaElettronicaType', '', '', TValue.From<TioViewDataType>(dtSingle), False]).
    AsSingleton.Execute;
  // 1: FatturaElettronicaHeader
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForDataView>.
    Implements<IpaViewModelForDataView>('1:FatturaElettronicaHeader').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForDataView', '0:FatturaElettronica', 'FatturaElettronicaHeader']).
    AsSingleton.Execute;
  // 1.2: FatturaElettronicaHeader.CedentePrestatore
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForDataView>.
    Implements<IpaViewModelForDataView>('1.2:CedentePrestatore').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForDataView', '1:FatturaElettronicaHeader', 'CedentePrestatore']).
    AsSingleton.Execute;
  // 1.2.1: FatturaElettronicaHeader.CedentePrestatore.DatiAnagrafici
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForDataView>.
    Implements<IpaViewModelForDataView>('1.2.1:DatiAnagrafici').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForDataView', '1.2:CedentePrestatore', 'DatiAnagrafici']).
    AsSingleton.Execute;
  // 1.2.1.1: FatturaElettronicaHeader.CedentePrestatore.DatiAnagrafici.IdFiscaleIVA
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForDataView>.
    Implements<IpaViewModelForDataView>('1.2.1.1:IdFiscaleIVA').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForDataView', '1.2.1:DatiAnagrafici', 'IdFiscaleIVA']).
    AsSingleton.Execute;
  // 1.2.1.3: FatturaElettronicaHeader.CedentePrestatore.DatiAnagrafici.Anagrafica
  TIupOrm.DependencyInjection.
    RegisterClass<TpaViewModelForDataView>.
    Implements<IpaViewModelForDataView>('1.2.1.3:Anagrafica').
    DefaultConstructorMarker('CreateByMasterViewModelFromDependencyInjection').
    DefaultConstructorParams(['IpaViewModelForDataView', '1.2.1:DatiAnagrafici', 'Anagrafica']).
    AsSingleton.Execute;



end;

initialization

  TDIClassRegister.RegisterClasses;

end.
