# Reasonable Senses Configurable

This mod is a successor to [Reasonable Senses - Afterglow effects](https://www.nexusmods.com/witcher3/mods/3377).<br/>
It supports more types of objects, and is configurable.

## Features

You can disable witcher sense highlights for
- Doors
- Posters
- Clues
- Stashes
- Signposts
- Noticeboards
- Workbenches & grindstones
- Various types of containers
  - Herbs
  - Beehives (the natural ones on trees)
  - Corpses
  - Others

I might add support for more types of objects down the road. You can also request some in the comments. It's also quite likely I've missed some, feel free to let me know of any (with an attached save file).

## Installation & usage

Install with [The Witcher 3 Mod Manager](https://www.nexusmods.com/witcher3/mods/2678).<br/>
Of course, you can install manually if you wish, but I won't provide support for it.

In-game, tweak the options to your liking in the mod menu.

## Compatibility

Mods editing herb `.srt` files or `.w2sf` files will need a patch.

The few script edits not done through annotations should automerge in the vast majority of cases.

Keep the mod menu limit in mind. If you have more than 9 menus under the `Mods` submenu, you should use [Community Patch - Menu Strings](https://www.nexusmods.com/witcher3/mods/3650).

## Known bugs

- When having [Friendly Focus](https://www.nexusmods.com/witcher3/mods/7167)' 'Fade Transition' option off, objects set to not highlight may be highlighted for some frames on the first time focusing after a loading screen
  - Not exactly a bug, moreso a vanilla feature revealed by this mod combo
  - Likely caused by the lingering effect of the highlight, would likely need a particle or shader edit to fix. I tried & wasn't able to find the right file.

## Recommended mods

- [Friendly Focus](https://www.nexusmods.com/witcher3/mods/7167) — Makes focus mode a lot nicer to use
- [Witcher Sense Color Customizer](https://www.nexusmods.com/witcher3/mods/125) — For changing highlight colors. Should work with Next-Gen according to comments.

## Other

Source is available on [GitHub](https://github.com/Benna96/witcher-3-reasonable-senses-configurable).
