@echo off
pushd "%~dp0"

@REM Change per batch file!
set "mod=mod0Rsense_VegetationBillboardsRemastered"

call "..\..\..\tools\updatecallerinstall"

popd
@echo on
