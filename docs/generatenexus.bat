@REM IMPORTANT NOTES
@REM Do not use trailing 2 spaces in md, use br tags (<br/>) instead
@REM Do not use consecutive equals signs
@REM Do not manually set sizes on anything, script relies on size to detect headings

set "input=README-User.md"
set "output=README-User-Nexus.txt"

@REM Requires md2nexus on path
md2nexus --input %input% --output %output% > nul

@REM Modify md2nexus output to my liking
@echo off
SetLocal EnableDelayedExpansion
set "substr=list"
set "eq=[size=6]"
(
	@REM findstr shenenigans are needed to not skip empty lines, it adds a line number to each line so none are "empty"
	@REM https://stackoverflow.com/questions/155932/how-do-you-loop-through-each-line-in-a-text-file-using-a-windows-batch-file
	for /F "usebackq delims=" %%L in (`"findstr /n ^^ %output%"`) do (
		set "line=%%L"

		@REM Temporarily replace hard-to-replace characters
		call :ReplaceCharIncludingConsecutive line "=" "_EQUALS_"

		@REM Remove br tags
		set "line=!line:<br/>=!"
		set "line=!line:<br>=!"
		set "line=!line:</br>=!"

		@REM Catppuccin mocha (=lightest) colors for headings
		set "line=!line:[size_EQUALS_6]=[color=#f38ba8][size=6]!"
		set "line=!line:[size_EQUALS_5]=[color=#fab387][size=5]!"
		set "line=!line:[size_EQUALS_4]=[color=#f9e2af][size=4]!"
		set "line=!line:[size_EQUALS_3]=[color=#a6e3a1][size=3]!"
		set "line=!line:[size_EQUALS_2]=[color=#74c7ec][size=2]!"
		set "line=!line:[size_EQUALS_1]=[color=#b4befe][size=1]!"
		set "line=!line:[/size]=[/size][/color]!"

		@REM Put hard-to-replace characters back in
		set "line=!line:_EQUALS_==!"

		@REM Remove line number prefix (added by findstr)
		@REM This must be done last as it can result in empty lines which messes up earlier replacements
		set "line=!line:*:=!"

		@REM Yes the dot is needed, and yes there should NOT be a space inbetween.
		echo.!line!
	)
) > tmp
move tmp %output% > nul
EndLocal

exit /B

@REM -------------------------------- FUNCTIONS --------------------------------

@REM Replacing consecutive equals signs with cmd is pretty much just... impossible.
@REM https://stackoverflow.com/questions/9556676/batch-file-how-to-replace-equal-signs-and-a-string-variable
:ReplaceCharIncludingConsecutive <variable> <char> <replacement> (
	SetLocal EnableDelayedExpansion
	set "string=!%~1!#"
	set "ret="

	@REM Loop one token at a time, using given char as delimiter
	:inner
		for /F "tokens=1* delims=%~2" %%A in ("%string%") do (
			if not defined ret (set "ret=%%A") else (set "ret=%ret%%~3%%A")
			set "string=%%B"
			if defined string goto inner
		)
	
	@REM On same line because "tunneling"
	@REM https://ss64.com/nt/syntax-functions.html
	EndLocal & set "%~1=%ret:~0,-1%"
	exit /B
)
