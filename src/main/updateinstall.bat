@echo off
set "od=%cd%"
cd /D "%~dp0"

@REM Change per batch file!
set "mod=modReasonableSensesConfigurable"

call "..\..\tools\updatecallerinstall"

cd /D %od%
@echo on
