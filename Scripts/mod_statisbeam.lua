local StatisBeamDefaults = {
    Damage = nil,
    Duration = nil,
    RequiredHitDuration = nil,
    NumChargesConsumedOnUse = nil,
}

local StatisBeamMultipliers = {
    Damage = 10,
    Duration = 10,
    RequiredHitDuration = 10,
    NumChargesConsumedOnUse = 0,
}

local function SetStatisBeamDefaults(mod)
    StatisBeamDefaults.Damage = mod.Damage
    StatisBeamDefaults.Duration = mod.Duration
    StatisBeamDefaults.RequiredHitDuration = mod.RequiredHitDuration
    StatisBeamDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
end

local function ModStatisBeam()
    local statisBeam = FindAllOf("Mod_StasisBeam_C")
    if statisBeam then
        for _, mod in pairs(statisBeam) do
            if not StatisBeamDefaults.MaxCharges then
                SetStatisBeamDefaults(mod)
            end

            mod.NumChargesConsumedOnUse = StatisBeamDefaults.NumChargesConsumedOnUse * StatisBeamMultipliers.NumChargesConsumedOnUse
            mod.Damage = StatisBeamDefaults.Damage * StatisBeamMultipliers.Damage
            mod.Duration = StatisBeamDefaults.Duration * StatisBeamMultipliers.Duration
            mod.RequiredHitDuration = StatisBeamDefaults.RequiredHitDuration * StatisBeamMultipliers.RequiredHitDuration
            print("Statis Beam modified.  Max Charges From: " .. tostring(StatisBeamDefaults.MaxCharges) .. " to " .. tostring(mod.MaxCharges) ..
                " and Damage From: " .. tostring(StatisBeamDefaults.Damage) .. " to " .. tostring(mod.Damage) ..    
                " and Duration From: " .. tostring(StatisBeamDefaults.Duration) .. " to " .. tostring(mod.Duration) ..
                " and Required Hit Duration From: " .. tostring(StatisBeamDefaults.RequiredHitDuration) .. " to " .. tostring(mod.RequiredHitDuration) ..
                " and Num Charges Consumed On Use From: " .. tostring(StatisBeamDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse))
        end
    else
        print("Statis Beam not found")
    end
end

local StatisBeamMod = {
    ModStatisBeam = ModStatisBeam,
}

return StatisBeamMod