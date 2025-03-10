@echo off
pushd "%~dp0"

@REM Change per batch file!
set "mod=modZReasonableSensesConfigurable_MR"

call "..\..\tools\updatecallerinstall"

popd
@echo on
