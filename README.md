# CheatMod for Remnant 2

A UE4SS-based Lua scripting mod for Remnant 2 that grants a suite of in-game cheats through hotkeys and console commands. It operates by directly accessing and manipulating Unreal Engine player objects at runtime using the UEHelpers library bundled with RE-UE4SS.

The mod focuses on quality-of-life cheating: keeping the player alive, bypassing stamina limits, leveling up on demand, boosting combat feel, and managing inventory item quantities and weapon levels — all without needing Cheat Engine or a save editor.

---

## Requirements

- **UE4SS** (Unreal Engine 4 Scripting System) — [Download latest release](https://github.com/UE4SS-RE/RE-UE4SS/releases)
  - Only tested on the latest `zdev` build

---

## Installation

1. **Install UE4SS**
   - Download the latest UE4SS release
   - Extract to your game's Win64 folder:
     ```
     [Steam Path]\steamapps\common\Remnant2\Remnant2\Binaries\Win64\
     ```

2. **Install CheatMod**
   - Place the `CheatMod` folder inside:
     ```
     ...\Win64\ue4ss\Mods\CheatMod\
     ```

3. **Enable the mod**
   - Open `ue4ss/Mods/mods.txt`
   - Add the following line:
     ```
     CheatMod : 1
     ```

4. Launch the game — the mod will auto-initialize on startup.

---

## Features

### Hotkeys

| Key | Feature | Description |
|-----|---------|-------------|
| `F1` | **Replenish All Resources** | Instantly restores Health, Ammo, Dragon Hearts, Cooldowns, and Mod Power. Tip: bind to R1 or a controller equivalent for quick mid-combat access. |
| `F2` | **Infinite Stamina** | Appends the `InfiniteStamina` FName tag to the player's Stamina component. May need to be re-applied after death or level transitions. |
| `F3` | **Fast Player Actions** | Boosts the `RateScale` of all non-locomotion player animations to `2.0x` (evade roll set to `1.7x`). Walking, jogging, sprinting, running, crouching, and aiming are unaffected. Provides a noticeably snappier combat feel. |
| `F4` | **Mod Hotshot Boost** | Multiplies all active `Mod_Hotshot_C` stats: `FireDuration ×10`, `FireBaseDamage ×100`, `ModDuration ×10`. Useful when difficulty spikes and you need a quick power bump. |

### Console Commands

Open the console with `` ` `` (tilde) or `F10`.

| Command | Description |
|---------|-------------|
| `levelup [n]` | Calls `OnLevelUp()` on the player's Traits object `n` times (defaults to 1). Example: `levelup 5` grants 5 trait points. |
| `set_all_weapon_level <level>` | Sets every weapon in the player's inventory to the specified upgrade level. |
| `set_inventory_item_quantity <itemName> <quantity>` | Sets the quantity of a named inventory item. Supports friendly name aliases (e.g. `Iron` resolves to `Material_Iron_C`) or raw blueprint name search. Logs the old and new values. |
| `log_inventory_items [true\|false]` | Prints inventory item blueprint names and instance data to the console. Omit the flag (or pass `false`) to log only materials and consumables; pass `true` to log every item. Useful for finding the exact name to pass to `set_inventory_item_quantity`. |

---

## Known Item Name Aliases

| Alias | Blueprint Class |
|-------|----------------|
| `Iron` | `Material_Iron_C` |

---

## Notes

- Infinite Stamina may need to be toggled again after respawning or transitioning between areas.
- `Fast Player Actions` affects all currently loaded `AnimSequence` objects — press `F3` again after loading into a new area if animations reset.
- `log_inventory_items` is a handy discovery tool when you don't know the exact blueprint name for an item you want to modify.
