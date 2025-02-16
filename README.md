# Reasonable Senses Configurable

[![License: CC-BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

A successor to the Witcher 3 mod [Reasonable Senses - Afterglow effects](https://www.nexusmods.com/witcher3/mods/3377).

## General

For proper description & usage, go to [User README](README-User.md).

### Changes from predecessor

- Highlight for each supported type of object is configurable from a mod menu
- Support more types of objects

## Technical

### Mod logic

- Structure
  - Config accessed through `theGame.GetRsenseConfig()` contains & initializes all the mod's options
  - Each feature has its own file, which contains its option class & all hooks it uses to do its things
    - Hooks are defined higher up in inheritance chain when possible
  - Most everything is done with [annotations](https://cdprojektred.atlassian.net/wiki/spaces/W3REDkit/pages/36241598/WS+Script+Compilation+Errors+overrides#Annotations) to keep the mod as compatible & merge-free as possible
    - Script edits not possible with annotations are in `_mr` version of the mod (standing for 'merge required'), as putting both annotations and script edits in the same mod can result in undefined behaviour (at least, WitcherScript IDE is not a fan)
- Features
  - Highlights
    - Override `SetFocusModeVisibility` to maybe set visibility to `FMV_None` depending on active options
      - `GetFocusModeVisibility` is also modified so it returns the same thing it would before the edit
    - For ON/OFF options, clue highlights are never hidden
    - Herb support requires extra stuff, as most herbs use the entry of `foliageComponent` to determine visibility
      - Create `_nohighlight` variants of herb `srt`s (removed `InteractiveOn` string), & add an entry called `full_nohighlight` to these in corresponding `w2sf` files
      - Override `foliageComponent.SetAndSaveEntry` to maybe set entry to `full_nohighlight` depending on active options

### Repo structure

- `_tools` folder
  - Callable `*.bat` files to be called by higher-level `*.bat` files
- One folder for each eventual `modX` folder
  - Subfolders
    - `redkit`: files that need to be packed into bundles or caches
    - `scripts`: `*.ws` files, usually has `local` etc folders inside 
    - `modmenu`: `*.xml` files, just files, they're put under `bin` by packer script
    - `localization`: `*.csv` files
    - `extra`: other files, like `README`, `user.settings.part`, etc
  - `witcherscript.toml`: Enable usage with *WitcherScript IDE* (Visual Studio Code extension)
  - `*.bat` files for packing & installing the mod

### Pack & install

1. Have [`w3strings.exe`](https://www.nexusmods.com/witcher3/mods/1055) in *Path* environment variable
2. For each top-level folder in the repo
   1. If there's a `redkit` folder, open it in REDkit & cook the mod (or maybe use wcclite to do it, or whatever else)
      - Only need to do it the first time & when content changes
   2. Run `pack.bat`
   3. Depending on if the mod is installed yet, either
      - Zip up the contents of the `packed` folder & install with [The Witcher 3 Mod Manager](https://www.nexusmods.com/witcher3/mods/2678), or
      - Make sure `gameDir` inside `_tools\updatecallerinstall.bat` matches your game directory & run `updateinstall.bat` to update your existing installation
         - This doesn't update any of the files referenced by `.part.txt` files
