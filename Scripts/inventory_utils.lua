local UEHelpers = require("UEHelpers.UEHelpers")

local knownItemMappings = {
    Iron = "Material_Iron_C",
}

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


return {
    SetAllWeaponLevel = SetAllWeaponLevel,
    SetInventoryItemQuantity = SetInventoryItemQuantity,
    LogInventoryItems = LogInventoryItems,
}