local HelixDefaults = {
    MaxCharges = nil,
    ImpactDamage = nil,
    SideWinderDamage = nil,
    SideWinderCount = nil,
    NumChargesConsumedOnUse = nil,
}

local HelixMultipliers = {
    MaxCharges = 10,
    ImpactDamage = 10,
    SideWinderDamage = 10,
    SideWinderCount = 10,
    NumChargesConsumedOnUse = 0,
}

local function SetHelixDefaults(mod)
    HelixDefaults.MaxCharges = mod.MaxCharges
    HelixDefaults.ImpactDamage = mod.ImpactDamage
    HelixDefaults.SideWinderDamage = mod.SideWinderDamage
    HelixDefaults.SideWinderCount = mod.SideWinderCount
    HelixDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
end

local function ModHelix()
    local helix = FindAllOf("Mod_Helix_C")
    if helix then
        for _, mod in pairs(helix) do
            if not HelixDefaults.MaxCharges then
                SetHelixDefaults(mod)
            end

            mod.NumChargesConsumedOnUse = HelixDefaults.NumChargesConsumedOnUse * HelixMultipliers.NumChargesConsumedOnUse
            mod.MaxCharges = HelixDefaults.MaxCharges * HelixMultipliers.MaxCharges
            mod.ImpactDamage = HelixDefaults.ImpactDamage * HelixMultipliers.ImpactDamage
            mod.SideWinderDamage = HelixDefaults.SideWinderDamage * HelixMultipliers.SideWinderDamage
            mod.SideWinderCount = HelixDefaults.SideWinderCount * HelixMultipliers.SideWinderCount
            print("Helix modified.  Max Charges From: " .. tostring(HelixDefaults.MaxCharges) .. " to " .. tostring(mod.MaxCharges) ..
                " and Impact Damage From: " .. tostring(HelixDefaults.ImpactDamage) .. " to " .. tostring(mod.ImpactDamage) ..
                " and SideWinder Damage From: " .. tostring(HelixDefaults.SideWinderDamage) .. " to " .. tostring(mod.SideWinderDamage) ..
                " and SideWinder Count From: " .. tostring(HelixDefaults.SideWinderCount) .. " to " .. tostring(mod.SideWinderCount) ..
                " and Num Charges Consumed On Use From: " .. tostring(HelixDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse))
        end
    else
        print("Helix not found")
    end 

end

local HelixMod = {
    ModHelix = ModHelix,
}

return HelixMod