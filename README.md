# Reasonable Senses Configurable

[![License: CC-BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

A successor to the Witcher 3 mod [Reasonable Senses - Afterglow effects](https://www.nexusmods.com/witcher3/mods/3377).

## General

### Changes from predecessor

- Highlight for each supported type of object is configurable from a mod menu
- Support more types of objects

### Mod compatibility

- Friendly Focus: When 'Fade Transition' option is off, objects that have been set to not highlight may get highlighted for a few frames upon the first time focusing after a loading screen
  - Couldn't solve this
    - Vanilla's slower transition just hides the issue
    - Most likely an edit of the highlight shader to not linger on the screen would fix this, but that would be a whole ordeal of its own, even finding the correct thing to edit in the first place seems hard (I tried & failed)

## Technical

### Mod structure, logic, notes

- Structure
  - Config accessed through `theGame.GetRsenseConfig()`, with all options in it
  - Each option has its own file, which contains the option's class & all hooks the option uses to do its things
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
   1. If there's a `redkit` folder, open it in REDkit & cook the mod (or maybe use wcclite to do it)
      - Only need to do it first time & when content changes
   2. Run `pack.bat`
   3. Change `gameDir` inside `updateinstall.bat` & run it
   4. If the mod wasn't installed before, add it to `mods.settings`, `dx11filelist.txt`, and `dx12filelist.txt`
      - I personally skip running `updateinstall.bat` the first time & instead zip up the generated `packed` folder & install with [Mod Manager](https://www.nexusmods.com/witcher3/mods/2678), later updating through `updateinstall.bat` as I'm working on it

## Usage

Install the mod as you would any other mod.
I recommend using [The Witcher 3 Mod Manager](https://www.nexusmods.com/witcher3/mods/2678).
- *Note*: The mod needs to be packed first, as it includes files that need to be in a bundle. I recommend downloading the mod from its Nexus Page.

Ingame, go to Options -> Mods -> Reasonable Senses. Configure the options to your liking.
- ***Important note:*** If your Mods menu has over 9 menus in it, the ones later in the list don't work due to engine limitations.  
  You'll need to install [Community Patch - Menu Strings](https://www.nexusmods.com/witcher3/mods/3650) and edit `modReasonableSenses.xml` to put Reasonable Senses Configurable in a submenu, see description of [Menu Strings](https://www.nexusmods.com/witcher3/mods/3650) for instructions.  
  Reasonable Senses Configurable supports whichever submenu you pick; I pick *Visuals and Graphics*, myself (and plan to ship a version of the mod already under it).