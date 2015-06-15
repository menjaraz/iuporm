unit VCL_RegisterClasses;

interface

type

  TClassRegister = class
  public
    class procedure RegisterClasses;
  end;

implementation

uses
  IupOrm, VCL_InterfacesU, VCL_ViewModelU;

{ TClassRegister }

class procedure TClassRegister.RegisterClasses;
begin
  TIupOrm.DependencyInjection.RegisterClass<TVCL_ViewModel>.Implements<IVCL_ViewModel>.Execute;
end;

end.
