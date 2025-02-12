@REM Shared pack functionality
@REM Meant to be called from one of the subfolders, e.g. main
@REM Requires 'mod' environment variable to be set
@REM Requires w3strings.exe in Path

if exist redkit (
	robocopy "redkit\packed\mods\%mod%\content" "packed\mods\%mod%\content" "*.store" /purge > nul
	robocopy "redkit\packed\mods\%mod%\content" "packed\mods\%mod%\content" "*.bundle" /purge > nul
	robocopy "redkit\packed\mods\%mod%\content" "packed\mods\%mod%\content" "*.*cache" /purge > nul
)

if exist scripts robocopy "scripts" "packed\mods\%mod%\content\scripts" "*.ws" /s /purge > nul
if exist modmenu robocopy "modmenu" "packed\bin\config\r4game\user_config_matrix\pc" "*.xml" /purge > nul

if exist localization (
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
)

if exist extra robocopy "extra" "packed\mods\%mod%" > nul
