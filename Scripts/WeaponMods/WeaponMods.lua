local HotShotMod = require("WeaponMods.mod_hotshot")
local SandstormMod = require("WeaponMods.mod_sandstorm")
local ConcussiveShotMod = require("WeaponMods.mod_concussiveshot")
local ScrapshotMod = require("WeaponMods.mod_scrapshot")
local HelixMod = require("WeaponMods.mod_helix")
local StatisBeamMod = require("WeaponMods.mod_statisbeam")
local VoltaicRondureMod = require("WeaponMods.mod_voltaic_rondure")
local RottedArrowMod = require("WeaponMods.mod_rottedarrow")

local function EnableAllWeaponMods()
    HotShotMod.ModHotShot()
    SandstormMod.ModSandstorm()
    ConcussiveShotMod.ModConcussiveShot()
    ScrapshotMod.ModScrapshot()
    HelixMod.ModHelix()
    StatisBeamMod.ModStatisBeam()
    VoltaicRondureMod.ModVoltaicRondure()
    RottedArrowMod.ModRottedArrow()
end

return {
    EnableAllWeaponMods = EnableAllWeaponMods,
}