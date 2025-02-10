@echo off

@REM Variable values, change per bat
set "mod=modReasonableSensesConfigurable"

@REM Save state & run silently at location
set "od=%cd%"
cd /D "%~dp0"

@REM ---------------------------------------------------------------------------

@REM REDkit, only copy files I care about (aka no info.json)
@REM Note: the mod folder within REDkit is lowercase, but robocopy doesn't mind
robocopy "redkit\packed\mods\%mod%\content" "packed\mods\%mod%\content" "*.store" /purge > nul
robocopy "redkit\packed\mods\%mod%\content" "packed\mods\%mod%\content" "*.bundle" /purge > nul
robocopy "redkit\packed\mods\%mod%\content" "packed\mods\%mod%\content" "*.*cache" /purge > nul

@REM Scripts & mod menu
robocopy "scripts" "packed\mods\%mod%\content\scripts" "*.ws" /s /purge > nul
robocopy "modmenu" "packed\bin\config\r4game\user_config_matrix\pc" "*.xml" /purge > nul

@REM Localization
cd localization
@REM Generate from CSVs (add other languages if needed)
w3strings --encode en.csv --id-space 3377 > nul
rename "????.csv.w3strings" "????.w3strings"
@REM Copy English for languages without localization
copy en.w3strings ar.w3strings > nul
copy en.w3strings br.w3strings > nul
copy en.w3strings cz.w3strings > nul
copy en.w3strings de.w3strings > nul
copy en.w3strings es.w3strings > nul
copy en.w3strings esmx.w3strings > nul
copy en.w3strings fr.w3strings > nul
copy en.w3strings hu.w3strings > nul
copy en.w3strings it.w3strings > nul
copy en.w3strings jp.w3strings > nul
copy en.w3strings kr.w3strings > nul
copy en.w3strings pl.w3strings > nul
copy en.w3strings ru.w3strings > nul
copy en.w3strings zh.w3strings > nul
@REM The generated test script just errored out the game last I checked...
del *.ws
@REM Pack 'em up
cd ..
robocopy "localization" "packed\mods\%mod%\content" "*.w3strings" /mov /purge > nul

@REM ---------------------------------------------------------------------------

@REM Restore state
cd /D %od%
@echo on
