@echo off
pushd "%~dp0"

@REM Change per batch file!
set "mod=modReasonableSensesConfigurable"

call "..\..\tools\packcaller"

popd
@echo on
