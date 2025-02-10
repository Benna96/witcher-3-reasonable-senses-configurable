@REM This only updates an EXISTING installation!
@REM Doesn't edit dx11filelist.txt, dx12filelist.txt, nor mods.settings.

@echo off

@REM Variable values, change per bat, change gameDir per computer
set "gamedir=F:\Games\SteamLibrary\steamapps\common\The Witcher 3"
set "mod=modReasonableSensesConfigurable"

@REM Save state
set "od=%cd%"
cd /D "%~dp0"

@REM ---------------------------------------------------------------------------

@REM Copy bin
robocopy "packed\bin" "%gamedir%\bin" /s > nul

@REM Copy mod itself. THIS WILL DELETE OLD FILES.
robocopy "packed\mods\%mod%" "%gamedir%\mods\%mod%" /s /purge > nul

@REM ---------------------------------------------------------------------------

@REM Restore state
cd /D %od%

@echo on
