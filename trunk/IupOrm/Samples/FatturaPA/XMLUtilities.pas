unit XMLUtilities;

interface

uses
  Xml.XMLIntf;

type

  TXMLUty = class
  public
    class function IsEmpty(const ANode: IXMLNode): Boolean;
  end;


implementation

{ TXMLUty }

class function TXMLUty.IsEmpty(const ANode: IXMLNode): Boolean;
begin

end;

end.
