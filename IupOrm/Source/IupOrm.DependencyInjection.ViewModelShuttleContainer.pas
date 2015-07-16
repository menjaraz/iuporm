unit IupOrm.DependencyInjection.ViewModelShuttleContainer;

interface

uses
  System.Generics.Collections, IupOrm.MVVM.Interfaces, System.SyncObjs;

type

  // Define the ViewModel shuttle container instance types
  TioViewModelShuttleContainerKey = String;
  TioViewModelShuttleContainerValue = IioViewModel;
  TioViewModelShuttleContainerInstance = TDictionary<TioViewModelShuttleContainerKey, TioViewModelShuttleContainerValue>;

  // Define the ViewModel shuttle container
  TioViewModelShuttleContainer = class
  strict private
    class var FContainer: TioViewModelShuttleContainerInstance;
    class var FCriticalSection: TCriticalSection;
    class function Container: TioViewModelShuttleContainerInstance;
    class function CriticalSection: TCriticalSection;
  public
    class procedure CleanUp;
    class function TryGet(var AViewModel: IioViewModel; const AMarker:String = ''): Boolean;
    class procedure TryDelete(const AMarker:String = '');
    class procedure Add(const AViewModel: IioViewModel; const AMarker:String = '');
  end;

implementation

uses
  IupOrm.Exceptions;

{ TioViewModelShuttleContainer }


class function TioViewModelShuttleContainer.CriticalSection: TCriticalSection;
begin
  if not Assigned(FCriticalSection) then
    FCriticalSection := TCriticalSection.Create;
  Result := FCriticalSection;
end;

class procedure TioViewModelShuttleContainer.TryDelete(const AMarker: String);
begin
  if not Assigned(FContainer) then Exit;  // For optimization when not assigned
  Self.CriticalSection.Acquire;
  try
    Self.Container.Remove(AMarker);
  finally
    Self.CriticalSection.Release;
  end;
end;

class function TioViewModelShuttleContainer.TryGet(var AViewModel: IioViewModel; const AMarker: String): Boolean;
begin
  Result := False;
  if not Assigned(FContainer) then Exit;  // For optimization when not assigned
  Self.CriticalSection.Acquire;
  try
    Result := Self.Container.ContainsKey(AMarker);
    if Result then
    begin
      AViewModel := Self.Container.Items[AMarker];
      Self.Container.Remove(AMarker);
    end;
  finally
    Self.CriticalSection.Release;
  end;
end;

class procedure TioViewModelShuttleContainer.Add(const AViewModel: IioViewModel; const AMarker: String);
begin
  Self.CriticalSection.Acquire;
  try
    if Self.Container.ContainsKey(AMarker) then
      raise EIupOrmException.Create(Self.ClassName + ': ViewModel marker already exist!');
    Self.Container.Add(AMarker, AViewModel);
  finally
    Self.CriticalSection.Release;
  end;
end;

class procedure TioViewModelShuttleContainer.CleanUp;
begin
  if Assigned(FCriticalSection) then FCriticalSection.Free;
  if Assigned(FContainer) then FContainer.Free;
end;

class function TioViewModelShuttleContainer.Container: TioViewModelShuttleContainerInstance;
begin
  if not Assigned(FContainer) then
    FContainer := TioViewModelShuttleContainerInstance.Create;
  Result := FContainer;
end;

initialization

finalization

  TioViewModelShuttleContainer.CleanUp;

end.
