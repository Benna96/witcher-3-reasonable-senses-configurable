@REM Shared update install functionality
@REM Meant to be called from one of the subfolders, e.g. main
@REM Requires 'mod' environment variable to be set

@REM Change per computer!
set "gamedir=F:\Games\SteamLibrary\steamapps\common\The Witcher 3"

if exist packed\bin robocopy "packed\bin" "%gamedir%\bin" /s > nul
if exist packed\mods robocopy "packed\mods\%mod%" "%gamedir%\mods\%mod%" /s /purge > nul
