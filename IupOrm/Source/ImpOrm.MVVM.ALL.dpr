program ImpOrm.MVVM.ALL;

uses
  FMX.Forms,
  IupOrm.MVVM.Interfaces in 'IupOrm.MVVM.Interfaces.pas',
  IupOrm.MVVM.ViewModelBase in 'IupOrm.MVVM.ViewModelBase.pas' {ioViewModelBase: TDataModule},
  IupOrm.MVVM.ALL.ViewModel in 'IupOrm.MVVM.ALL.ViewModel.pas' {ioViewModel: TDataModule},
  DuckListU in '..\ExtLibs\DMVC\DuckListU.pas',
  DuckObjU in '..\ExtLibs\DMVC\DuckObjU.pas',
  DuckPropFieldU in '..\ExtLibs\DMVC\DuckPropFieldU.pas',
  ObjectsMappers in '..\ExtLibs\DMVC\ObjectsMappers.pas',
  ObjMapper in '..\ExtLibs\DMVC\ObjMapper.pas',
  ObjMapperAttributes in '..\ExtLibs\DMVC\ObjMapperAttributes.pas',
  ObjMapperEngine in '..\ExtLibs\DMVC\ObjMapperEngine.pas',
  ObjMappers in '..\ExtLibs\DMVC\ObjMappers.pas',
  RTTIUtilsU in '..\ExtLibs\DMVC\RTTIUtilsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.
