# Reasonable Senses Configurable

[![License: CC-BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

A successor to the Witcher 3 mod [Reasonable Senses - Afterglow effects](https://www.nexusmods.com/witcher3/mods/3377).

## Changes from predecessor

- Glow for each supported type of object is configurable from a mod menu
- Support herbs
- Support signpost ( & fix visibility bug )
- Support stash
- Support workbenches & grindstones
- Support clues (note, clue glow still shows up, this hides interactive glow)
- Support some types of containers separately from other containers

## Mod compatibility

- Friendly Focus: When 'Fade Transition' option is off, objects that you've set to not glow may glow for a split second on the first time you focus after a loading screen
  - Couldn't solve this
    - Vanilla's slower transition only hides the issue, & lengthening Friendly Focus' quicker transition time wouldn't help consistently as I think it depends on the object's distance from camera as well
  - Something that'd edit out the glow's trailing effect might fix it. (Trailing effect meaning, when you move the camera around, old glow chills around for a bit.)
    - Most likely would need a shader edit, which seems close to if not impossible
    - Or, it's a particle effect, but going through a bunch of `.w2p` files with even the most slightly related names, none affected it. Wonder if there's ones not exposed to REDkit... Editing monster ripple ones worked just fine.

## Technical

### Mod structure, logic, notes

- General logic
  - Override `SetFocusModeVisibility` to maybe actually set to `FMV_None`, depending on active options
    - `GetFocusModeVisibility` returns the previously not-necessarily-set visibility to support code that uses the visibility for logic (e.g. All Containers Glow)
    - Clue highlights aren't affected, except with options that allow more than just on/off
    - ***Note***: `gameplayEntity.ws` changes aren't possible to do with annotations. They're super simple though & should automerge in the vast majority of cases.
  - Each of the mod's options has a corresponding option class, all listed in `CRsenseConfig`; functionality is split between the option class & vanilla code injections
- Herb support
  - `_noglow` variants of herb `srt`s (removed `InteractiveOn` string), & an entry called `fullnoglow` to these in corresponding `w2sf` files
  - Override `foliageComponent.SetAndSaveEntry` to maybe set it to `fullnoglow`, depending on active options
- Compatibility
  - Make as many changes as possible using [annotations](https://cdprojektred.atlassian.net/wiki/spaces/W3REDkit/pages/36241598/WS+Script+Compilation+Errors+overrides#Annotations)
    - Not possible for everything, some scripts do need to be merged. All such scripts are put inside a `*_mr` folder (standing for 'merge required').

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