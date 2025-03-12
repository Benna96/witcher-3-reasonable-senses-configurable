@echo off
pushd "%~dp0"

@REM Change per batch file!
set "mod=mod0Rsense_VegetationBillboardsRemasteredV2"

call "..\..\..\tools\updatecallerinstall"

popd
@echo on
