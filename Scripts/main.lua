local UEHelpers = require("UEHelpers.UEHelpers")

print("------------------------- CHEAT MOD ENABLED ---------------")

local knownItemMappings = {
    Iron = "Material_Iron_C",
}

local function LevelUp(Ar)
    local p = UEHelpers.GetPlayer()
    if p then
        p.Traits:OnLevelUp()
        print("Level up complete")
        Ar:Log("Level up complete")
    else
        print("Player  not found")
        Ar:Log("Player  not found")
    end
end

local function InfiniteStamina()
    local p = UEHelpers.GetPlayer()
    if p then
        local stamina = p.Stamina
        if stamina then
            local componentTags = stamina.ComponentTags
            componentTags[#componentTags + 1] = FName("InfiniteStamina")
            print("Infinite Stamina added")
        else
            print("Stamina not found")
        end
    else
        print("Player  not found")
    end
end

local function ReplenishAllResources()
    local p = UEHelpers.GetPlayer()
    if p then
        p:ReplenishResources(
            true, -- Health,
            true, -- Ammo
            true, -- DragonHearts
            true, -- Cooldowns
            true, -- ModPower
            false -- IsBossRush
        )
        print("Resources replenished")
    else
        print("Player  not found")
    end
end

-- helps out if the difficulty spikes in game and you get stuck and just want to move on
local function ModHotShot()
    local hotShot = FindAllOf("Mod_Hotshot_C")
    if hotShot then
        for _, mod in pairs(hotShot) do
            mod.FireDuration = mod.FireDuration * 10
            mod.FireBaseDamage = mod.FireBaseDamage * 100
            mod.ModDuration = mod.ModDuration * 10
            print("Hot Shot modified")
        end
    else
        print("Hot Shot not found")
    end
end

-- faster gameplay for player
local function FastPlayerActions()
    local animSequence = FindAllOf("AnimSequence")
    if animSequence then
        for _, anim in pairs(animSequence) do
            local name = anim:GetFullName():lower()

            if name:find("player") and
                not name:find("walk") and
                not name:find("jog") and
                not name:find("aim") and
                not name:find("sprint") and
                not name:find("run") and
                not name:find("crouch") and
                not name:find("evaderoll") then
                anim.RateScale = 2.0
            end

            if name:find("evaderoll") then
                -- 1.7 felt better than 2.0
                anim.RateScale = 1.7
            end
        end
        print("Fast Player Actions Enabled")
    else
        print("Anim Sequence not found")
    end
end

-- I Recommend binding F1 to R1 or Equivalent on PC.
-- Can easily be done in the steam controller settings.
RegisterKeyBind(Key.F1, function()
    ReplenishAllResources()
end)

-- nice to have if you like inf stamina
RegisterKeyBind(Key.F2, function()
    InfiniteStamina()
end)

-- for me this works great.  Much better movement compared to the default.
RegisterKeyBind(Key.F3, function()
    FastPlayerActions()
end)

-- I like keeping this on in case I really need it
RegisterKeyBind(Key.F4, function()
    ModHotShot()
end)

-- Give yourself trait points
RegisterConsoleCommandHandler("levelup", function(FullCommand, Parameters, Ar)
    local levels = tonumber(Parameters[1]) or 1
    for _ = 1, levels do
        LevelUp(Ar)
    end
    return true
end)


local function RunFnInPlayerInv(fn)
    local p = UEHelpers.GetPlayer()
    if p then
        local inventory = p.Inventory
        if inventory then
            local items = inventory:GetItems()
            if items then
                for _, item in pairs(items) do
                    local itemBP = item:get().ItemBP
                    local instanceData = item:get().InstanceData
                    local ismaterial = itemBP:GetFullName():find("Material")
                    local isconsumable = itemBP:GetFullName():find("Consumable")
                    local isweapon = itemBP:GetFullName():find("Weapon")

                    local shouldBreak = fn({
                        itemBP = itemBP,
                        instanceData = instanceData,
                        ismaterial = ismaterial,
                        isconsumable = isconsumable,
                        isweapon = isweapon,
                    })

                    if shouldBreak then
                        break
                    end
                end
            end
        end
    end
end

local function SetAllWeaponLevel(level, Ar)
    RunFnInPlayerInv(function(config)
        if config.isweapon then
            config.instanceData.Level = level
            print("Weapon level set to: " .. tostring(level))
            Ar:Log("Weapon level set to: " .. tostring(level))
        end
    end)
end

local function SetInventoryItemQuantity(itemName, quantity, Ar)
    RunFnInPlayerInv(function(config)
        local nameToFind = knownItemMappings[itemName] or itemName
        if config.itemBP:GetFullName():find(nameToFind) then
            local current_amount = config.instanceData.Quantity
            config.instanceData.Quantity = quantity
            print(itemName .. " set to: " .. tostring(quantity) .. " from " .. tostring(current_amount))
            Ar:Log(itemName .. " set to: " .. tostring(quantity) .. " from " .. tostring(current_amount))
            return true
        end
    end)
end

local function LogInventoryItems(log_all_items)
    RunFnInPlayerInv(function(config)
        if not log_all_items then
            if config.ismaterial then
                print("Material found: " .. tostring(config.itemBP:GetFName():ToString()))
                print("Instance Data: " .. tostring(config.instanceData:GetFullName()))
            end

            if config.isconsumable then
                print("Consumable found: " .. tostring(config.itemBP:GetFName():ToString()))
                print("Instance Data: " .. tostring(config.instanceData:GetFullName()))
            end
        else
            print("Inventory item found: " .. tostring(config.itemBP:GetFName():ToString()))
            print("Instance Data: " .. tostring(config.instanceData:GetFullName()))
        end
    end)
end

RegisterConsoleCommandHandler("set_all_weapon_level", function(FullCommand, Parameters, Ar)
    local level = tonumber(Parameters[1])
    if not level then
        print("Invalid level")
        return false
    end
    SetAllWeaponLevel(level, Ar)
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
    SetInventoryItemQuantity(itemName, quantity, Ar)
    return true
end)

RegisterConsoleCommandHandler("log_inventory_items", function(FullCommand, Parameters, Ar)
    local log_all_items = Parameters[1] == "true"
    print("Logging inventory items")
    Ar:Log("Logging inventory items")

    LogInventoryItems(log_all_items)
    return true
end)
