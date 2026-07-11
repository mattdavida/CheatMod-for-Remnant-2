local InventoryUtils = require("inventory_utils")
local PlayerUtils = require("player_utils")
local WeaponMods = require("WeaponMods.WeaponMods")
require("cheat_hooks")

print("------------------------- CHEAT MOD ENABLED ---------------")

RegisterKeyBind(Key.F1, function()
    PlayerUtils.ReplenishCooldownsAndModPower()
end)

-- nice to have if you like inf stamina
RegisterKeyBind(Key.F2, function()
    PlayerUtils.InfiniteStamina()
end)

-- for me this works great.  Much better movement compared to the default.
RegisterKeyBind(Key.F3, function()
    PlayerUtils.FastPlayerActions()
end)

-- the only mod that is modified is the one that is equipped on your weapons 
-- you need to repress when switching mods on your weapons. 
RegisterKeyBind(Key.F4, function()
    WeaponMods.EnableAllWeaponMods()
end)

-- Give yourself trait points
RegisterConsoleCommandHandler("levelup", function(FullCommand, Parameters, Ar)
    local levels = tonumber(Parameters[1]) or 1
    for _ = 1, levels do
        PlayerUtils.LevelUp(Ar)
    end
    return true
end)


RegisterConsoleCommandHandler("set_all_weapon_level", function(FullCommand, Parameters, Ar)
    local level = tonumber(Parameters[1])
    if not level then
        print("Invalid level")
        return false
    end
    InventoryUtils.SetAllWeaponLevel(level, Ar)
    return true
end)

RegisterConsoleCommandHandler("set_inventory_item_quantity", function(FullCommand, Parameters, Ar)
    local itemName = Parameters[1]
    local quantity = tonumber(Parameters[2])
    if not quantity then
        print("Invalid quantity")
        return false
    end
    if not itemName then
        print("Invalid item name")
        return false
    end
    InventoryUtils.SetInventoryItemQuantity(itemName, quantity, Ar)
    return true
end)

RegisterConsoleCommandHandler("log_inventory_items", function(FullCommand, Parameters, Ar)
    local log_all_items = Parameters[1] == "true"
    print("Logging inventory items")
    Ar:Log("Logging inventory items")

    InventoryUtils.LogInventoryItems(log_all_items)
    return true
end)