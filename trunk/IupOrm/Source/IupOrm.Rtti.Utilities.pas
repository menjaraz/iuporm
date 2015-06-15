unit IupOrm.Rtti.Utilities;

interface

uses
  IupOrm.CommonTypes, System.Rtti;

type

  TioRttiUtilities = class
  private
    class function GetShortStringString(const ShortStringPointer: PByte): string;
  public
    class function IsAnInterface<T>: Boolean;
    class function GenericToString<T>: String;
    class function GenericInterfaceToGUI<T:IInterface>: String;
    class function ClassRefToRttiType(AClassRef:TioClassRef): TRttiInstanceType;
    class function CastObjectToGeneric<T>(AObj:TObject): T;
    class function IsAnInterfaceTypeName(ATypeName:String): Boolean;
  end;

implementation

uses
  System.TypInfo, System.SysUtils, IupOrm.RttiContext.Factory;

{ TioRttiUtilities }

class function TioRttiUtilities.GetShortStringString(const ShortStringPointer: PByte): string;
var
  ShortStringLength: Byte;
  FirstShortStringCharacter: MarshaledAString;
  ConvertedLength: Cardinal;
  UnicodeCharacters: array [Byte] of Char; // cannot be more than 255 characters, reserve 1 character for terminating null
begin
  if not Assigned(ShortStringPointer) then
    Result := ''
  else
  begin
    ShortStringLength := ShortStringPointer^;
    if ShortStringLength = 0 then
      Result := ''
    else
    begin
      FirstShortStringCharacter := MarshaledAString(ShortStringPointer + 1);
      ConvertedLength := UTF8ToUnicode(UnicodeCharacters, Length(UnicodeCharacters), FirstShortStringCharacter, ShortStringLength);
      // UTF8ToUnicode will always include the null terminator character in the Result:
      ConvertedLength := ConvertedLength - 1;
      SetString(Result, UnicodeCharacters, ConvertedLength);
    end;
  end;
end;


class function TioRttiUtilities.CastObjectToGeneric<T>(AObj: TObject): T;
begin
  Result := TValue.From<TObject>(AObj).AsType<T>;
end;

class function TioRttiUtilities.ClassRefToRttiType(AClassRef: TioClassRef): TRttiInstanceType;
begin
  Result := TioRttiContextFactory.RttiContext.GetType(AClassref).AsInstance;
end;

class function TioRttiUtilities.GenericInterfaceToGUI<T>: String;
begin
  Result := GUIDToString(   GetTypeData(   PTypeInfo(TypeInfo(T))   ).Guid   );

  // ----------------------------------------------------------------------------------
  // Old code
  // ----------------------------------------------------------------------------------
//  pinfo := TypeInfo(T);
//  if pinfo = nil then Exit(Self.ClassName + ': TypeInfo (GUI) not found!');
//  pdata := GetTypeData(pinfo);
//  Result := GUIDtoString(pdata.Guid);
  // ----------------------------------------------------------------------------------
end;

class function TioRttiUtilities.GenericToString<T>: String;
begin
{$IFDEF NEXTGEN}
  Result := GetShortStringString(   PByte(PTypeInfo(TypeInfo(T)).Name)   );
{$ELSE  NEXTGEN}
  Result := PTypeInfo(TypeInfo(T)).Name;
{$ENDIF NEXTGEN}
  // ----------------------------------------------------------------------------------
  // Old code
  // ----------------------------------------------------------------------------------
//  pinfo := TypeInfo(T);
//  if pinfo = nil then Exit(Self.ClassName + ': TypeInfo (name) not found!');
//  Result := pinfo.NameFld.ToString;
////  Result := pinfo.Name;
  // ----------------------------------------------------------------------------------
end;

class function TioRttiUtilities.IsAnInterfaceTypeName(ATypeName: String): Boolean;
begin
  Result := ATypeName.StartsWith('I');
end;

class function TioRttiUtilities.IsAnInterface<T>: Boolean;
begin
  // Result is True if T si an interface
//  Result := (   TioRttiContextFactory.RttiContext.GetType(TypeInfo(T)) is TRttiInterfaceType   );
  Result := PTypeInfo(TypeInfo(T)).Kind = tkInterface;
end;

end.
