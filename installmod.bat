:: Make sure the path matches your path to the game folder!

robocopy "packed\bin" "F:\Games\SteamLibrary\steamapps\common\The Witcher 3\bin" /s

:: THIS WILL DELETE FILES FROM PREVIOUSLY INSTALLED MOD.
robocopy "packed\mods\modReasonableSensesConfigurable" "F:\Games\SteamLibrary\steamapps\common\The Witcher 3\Mods\modReasonableSensesConfigurable" /s /purge