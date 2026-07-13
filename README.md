# CheatMod for Remnant 2

A UE4SS-based Lua scripting mod for Remnant 2 that grants a suite of in-game cheats through hotkeys and console commands. It operates by directly accessing and manipulating Unreal Engine player objects at runtime using the UEHelpers library bundled with RE-UE4SS.

The mod focuses on quality-of-life cheating: keeping the player alive, bypassing stamina limits, leveling up on demand, boosting combat feel, and managing inventory item quantities and weapon levels — all without needing Cheat Engine or a save editor.

**God Mode** is a true toggle — it hooks `ModifyIncomingDamage` and zeroes all damage before it is applied. No visible health drop, no heal-after. **Infinite Ammo** is a session-persistent hook registered on first use. Weapon mod boosting is handled by eight dedicated per-mod modules, each idempotent and safe to re-trigger.

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

## File Structure

| File | Purpose |
|------|---------|
| `main.lua` | Wiring — imports, hotkey binds, console command handlers |
| `player_utils.lua` | Player state — stamina, cooldowns, leveling, animation speed |
| `inventory_utils.lua` | Inventory traversal, item quantity editing, weapon level setting |
| `cheat_hooks.lua` | God mode toggle + infinite ammo session hook |
| `WeaponMods/WeaponMods.lua` | Aggregator — owns all weapon mod imports, exposes `EnableAllWeaponMods()` |
| `WeaponMods/mod_*.lua` (×8) | Per-weapon-mod boosters (one file per supported mod) |

---

## Features

### Hotkeys

| Key | Feature | Description |
|-----|---------|-------------|
| `F1` | **Replenish Cooldowns & Mod Power** | Instantly resets all skill cooldowns and fills Mod Power. Health, Ammo, and Dragon Hearts are not affected. Tip: bind to R1 or a controller equivalent for quick mid-combat access. |
| `F2` | **Infinite Stamina** | Appends the `InfiniteStamina` FName tag to the player's Stamina component. May need to be re-applied after death or level transitions. |
| `F3` | **Fast Player Actions** | Boosts the `RateScale` of all non-locomotion player animations. Walking, jogging, sprinting, running, crouching, and aiming are unaffected. Evade roll is tuned separately. |
| `F4` | **Boost All Supported Weapon Mods** | Fires all eight weapon mod boost modules in sequence. Each captures baseline values on first press and applies multipliers from that baseline — re-pressing is safe and idempotent. Only mods currently equipped on your weapons are in memory; unequipped mods are silently skipped. Re-press after switching weapon mods. |

**Mods boosted by F4:**

| Module | UE Class | Stats Boosted |
|--------|----------|---------------|
| `mod_hotshot.lua` | `Mod_Hotshot_C` | FireDuration, FireBaseDamage, ModDuration |
| `mod_sandstorm.lua` | `Mod_Sandstorm_C` | CycloneDuration, CycloneBaseRadius, CycloneHomingRadius, CycloneDPS, CycloneDamageFrequency |
| `mod_concussiveshot.lua` | `Mod_ConcussiveShot_C` | BlastDamage, MaxRange, BaseKnockbackDistance, AOERadius, MaxCharges |
| `mod_helix.lua` | `Mod_Helix_C` | MaxCharges, ImpactDamage, SideWinderDamage, SideWinderCount |
| `mod_statisbeam.lua` | `Mod_StasisBeam_C` | Damage, Duration, RequiredHitDuration |
| `mod_voltaic_rondure.lua` | `Mod_VoltaicRondure_C` | PulseDelay (pinned to minimum), OrbDamage, ProjectileLifetime, EffectRadius, ShockDamage, ShockDuration |
| `mod_scrapshot.lua` | `Mod_Scrapshot_C` | MaxCharges, BlastRadius, DOTDamage, CaltropDuration, BleedDamage, BleedDuration, NumChargesConsumedOnUse (zeroed — free to cast) |
| `mod_rottedarrow.lua` | `Mod_RottedArrow_C` | MaxCharges, WeakSpotMod, ImpactDamage, DOTDamage, CloudDuration, BlastRadius, CloudDamagePerSecond, NumChargesConsumedOnUse (zeroed — free to cast) |

> **Planned:** Skewer, Defrag, AbrasiveRounds, HeatWave, Tremor

### Console Commands

Open the console with `` ` `` (tilde) or `F10`.

| Command | Description |
|---------|-------------|
| `levelup [n]` | Calls `OnLevelUp()` on the player's Traits object `n` times (defaults to 1). Example: `levelup 5` grants 5 trait points. |
| `set_all_weapon_level <level>` | Sets every weapon in the player's inventory to the specified upgrade level. |
| `set_inventory_item_quantity <itemName> <quantity>` | Sets the quantity of a named inventory item. Supports friendly name aliases (e.g. `Iron` resolves to `Material_Iron_C`) or raw blueprint name search. Logs the old and new values. |
| `log_inventory_items [true\|false]` | Prints inventory item blueprint names and instance data to the console. Omit the flag (or pass `false`) to log only materials and consumables; pass `true` to log every item. Useful for finding the exact name to pass to `set_inventory_item_quantity`. |
| `toggle_god_mode` | Toggles God Mode on/off. Hooks `ModifyIncomingDamage` on first use — all damage is zeroed before it applies. No visible health drop. Re-run twice (off/on) if the hook drops during a loading screen transition. |
| `start_infinite_ammo` | Registers a permanent hook into `Weapon_Gun_Base_C:OnFire` — ammo replenishes on every shot. Active for the session; restart the game to disable. Re-run if the hook drops during a loading screen transition. |

---

## Known Item Name Aliases

| Alias | Blueprint Class |
|-------|----------------|
| `Iron` | `Material_Iron_C` |

---

## Notes

- **Infinite Stamina** may need to be re-applied after respawning or transitioning between areas.
- **Fast Player Actions** affects all currently loaded `AnimSequence` objects — press `F3` again after loading into a new area if animations reset.
- **God Mode** is a true toggle. The hook registers once on first use and persists; the on/off state is controlled by a closure flag. If the hook drops during a loading screen, run `toggle_god_mode` twice to re-register.
- **Infinite Ammo** is session-persistent — restart the game to disable. Re-run `start_infinite_ammo` if it drops during a transition.
- **Weapon mod boosts (F4)** are idempotent — safe to press multiple times. Re-press after switching weapon mods to apply boosts to newly equipped ones.
- `log_inventory_items` is a handy discovery tool when you don't know the exact blueprint name for an item you want to modify with `set_inventory_item_quantity`.
