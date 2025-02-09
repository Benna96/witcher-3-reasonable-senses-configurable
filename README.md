# Reasonable Senses Configurable

[![License: CC-BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

A successor to the Witcher 3 mod [Reasonable Senses - Afterglow effects](https://www.nexusmods.com/witcher3/mods/3377).

## Changes from predecessor

- Glow for each supported type of object is configurable from a mod menu
- Support herbs
- Support signpost ( & fix visibility bug )
- Support stash
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
    - `GetFocusModeVisibility` return the previously not-necessarily-set visibility to support code that uses the visibility for logic (e.g. All Containers Glow)
    - Clue highlights *shouldn't* be affected
    - ***Note***: `gameplayEntity.ws` changes aren't possible to do with annotations. They're super simple though & should automerge in the vast majority of cases.
  - Each of the mod's options has a corresponding option class, all listed in `CRsenseConfig`; functionality is split between the option class & vanilla code injections
- Herb support
  - `_noglow` variants of herb `srt`s (removed `InteractiveOn` string), & an entry called `fullnoglow` to these in corresponding `w2sf` files
  - Override `foliageComponent.SetAndSaveEntry` to maybe set it to `fullnoglow`, depending on active options
- Compatibility
  - Make as many changes as possible using [annotations](https://cdprojektred.atlassian.net/wiki/spaces/W3REDkit/pages/36241598/WS+Script+Compilation+Errors+overrides#Annotations)
    - Not possible for everything, some scripts do need to be merged

### Folder structure

- `workspace` contains most content files.
- `workspace_root` contains bin files & localization files.
  - Localization files are much nicer to edit through a CSV than REDkit's Localized String Editor, imo.

### Packing the mod

The packed mod is in a `packed` folder. This folder is not included in the repo as it's not source assets.

1. Pack `workspace` files with REDkit.
   - Packs files, generates `metadata.store,`, copies them + loose files.
     - *Note*: This clears the `packed` folder beforehand, at least when using REDkit. You'll have to do step 2 again afterwards.
   - **Not required if** only non-packable files (like scripts) have been edited, those can be copied on their own.
   - Maybe WCCLite can be used, idk, haven't used it myself.
2. Pack `workspace_root` by running `packroot.bat`.
   - Copies scripts from `workspace`.
   - Copies all files & encodes localization files.
3. Zip up the **contents** of `packed` to make an archive you can install from.

## Usage

Install the mod as you would any other mod.
I recommend using [The Witcher 3 Mod Manager](https://www.nexusmods.com/witcher3/mods/2678).
- *Note*: The mod needs to be packed first, as it includes files that need to be in a bundle. I recommend downloading the mod from its Nexus Page.

Ingame, go to Options, Mods, Reasonable Senses. Configure the options to your liking.
- ***Important note:*** If your Mods menu has over 9 menus in it, the ones later in the list don't work due to engine limitations.  
You'll need to install [Community Patch - Menu Strings](https://www.nexusmods.com/witcher3/mods/3650) and edit `modReasonableSenses.xml` to put Reasonable Senses Configurable in a submenu, see description of [Menu Strings](https://www.nexusmods.com/witcher3/mods/3650) for instructions.  
Reasonable Senses Configurable supports whichever submenu you pick; I pick *Visuals and Graphics*, myself (and plan to ship a version of the mod already under it).
- ATM, you have to load a save after changing settings for them to apply.