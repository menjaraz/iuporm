unit IupOrm.Helpers.BindSourceHelperTools.Interfaces;

interface

uses
  Data.Bind.ObjectScope, System.Classes;

type

  IioBindSourceHelperTools = interface
    ['{1DDC2E5E-847E-4086-A42F-555F2DEB255C}']
    function GetDetailBindSourceAdapter(AOwner:TComponent; AMasterPropertyName:String): TBindSourceAdapter;
    function GetNaturalObjectBindSourceAdapter(AOwner:TComponent): TBindSourceAdapter;
  end;

implementation

end.
