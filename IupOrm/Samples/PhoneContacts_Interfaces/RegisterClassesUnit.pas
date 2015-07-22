unit RegisterClassesUnit;

interface

type

  TDIClassRegister = class
  public
    class procedure RegisterClasses;
  end;

implementation

uses
  IupOrm, Model, Interfaces, IupOrm.LazyLoad.Generics.List, IupOrm.Containers.Interfaces, IupOrm.Containers.List,
  AnotherModel;

{ TDIClassRegister }

class procedure TDIClassRegister.RegisterClasses;
begin
  // TPhoneNumber
  TIupOrm.DependencyInjection.RegisterClass<TPhoneNumber>.Implements<IPhoneNumber>.Execute;

  // TPerson and details
  TIupOrm.DependencyInjection.RegisterClass<TPerson>.Implements<IPerson>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TioList<IPhoneNumber>>.Implements<IioList<IPhoneNumber>>.Execute;

  // TAnotherPerson and details
  TIupOrm.DependencyInjection.RegisterClass<TAnotherPerson>.Implements<IPerson>.Alias('AnotherPerson').Execute;
  TIupOrm.DependencyInjection.RegisterClass<TioInterfacedList<IPhoneNumber>>.Implements<IioList<IPhoneNumber>>.Alias('Another').Execute;


  // Others descendants
  TIupOrm.DependencyInjection.RegisterClass<TEmployee>.Implements<IEmployee>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TCustomer>.Implements<ICustomer>.Execute;
  TIupOrm.DependencyInjection.RegisterClass<TVipCustomer>.Implements<IVipCustomer>.Execute;
end;

initialization

  TDIClassRegister.RegisterClasses;

end.

