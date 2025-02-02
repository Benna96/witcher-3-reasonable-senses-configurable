:: If only editing scripts, allow applying edits through this in addition to REDkit
robocopy "workspace/scripts" "packed/Mods/modReasonableSensesConfigurable/content/scripts" /s

robocopy workspace_root packed /s

cd "packed/Mods/modReasonableSensesConfigurable/localization"
call encode
cd ../../../../