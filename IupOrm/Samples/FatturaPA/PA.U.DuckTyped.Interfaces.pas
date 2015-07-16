unit PA.U.DuckTyped.Interfaces;

interface

type

  IDuckTypedXMLList = interface
    ['{1124A8E6-DB5F-4F2D-8D33-DAFB53CA4DDB}']
    function Add: IInterface;
    function Get_Item(Index: Integer): IInterface;
    procedure Delete(Index: Integer);
    // Count property
    function GetCount: Integer;
    property Count: Integer read GetCount;
  end;

implementation

end.                                                   s
