@echo off
set "od=%cd%"
cd /D "%~dp0"

@REM Change per batch file!
set "mod=modZReasonableSensesConfigurable_MR"

call "..\..\tools\updatecallerinstall"

cd /D %od%
@echo on
