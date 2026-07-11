-- helps out if the difficulty spikes in game and you get stuck and just want to move on
local HotShodDefaults = {
    FireDuration = nil,
    FireBaseDamage = nil,
    ModDuration = nil,
}

local HotShodMultipliers = {
    FireDuration = 10,
    FireBaseDamage = 100,
    ModDuration = 10,
}

local function SetHotShotDefaults(mod)
    HotShodDefaults.FireDuration = mod.FireDuration
    HotShodDefaults.FireBaseDamage = mod.FireBaseDamage
    HotShodDefaults.ModDuration = mod.ModDuration
end

local function ModHotShot()
    local hotShot = FindAllOf("Mod_Hotshot_C")
    if hotShot then
        for _, mod in pairs(hotShot) do
            if not HotShodDefaults.FireDuration then
                SetHotShotDefaults(mod)
            end

            mod.FireDuration = HotShodDefaults.FireDuration * HotShodMultipliers.FireDuration   
            mod.FireBaseDamage = HotShodDefaults.FireBaseDamage * HotShodMultipliers.FireBaseDamage
            mod.ModDuration = HotShodDefaults.ModDuration * HotShodMultipliers.ModDuration
            print("Hot Shot modified.  Fire Duration From: " ..
                tostring(HotShodDefaults.FireDuration) ..
                " to " ..
                tostring(mod.FireDuration) ..
                " and Fire Base Damage From: " ..
                tostring(HotShodDefaults.FireBaseDamage) ..
                " to " ..
                tostring(mod.FireBaseDamage) ..
                " and Mod Duration From: " ..
                tostring(HotShodDefaults.ModDuration) .. " to " .. tostring(mod.ModDuration))
        end
    else
        print("Hot Shot not found")
    end
end

local HotShotMod = {
    ModHotShot = ModHotShot,
}

return HotShotMod