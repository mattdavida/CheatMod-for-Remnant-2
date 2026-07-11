local RottedArrowDefaults = {
    NumChargesConsumedOnUse = nil,
    MaxCharges = nil,
    WeakSpotMod = nil,
    ImpactDamage = nil,
    BlastDamage = nil,
    DOTDamage = nil,
    CloudDuration = nil,
    BlastRadius = nil,
    CloudDamagePerSecond = nil,
}

local RottedArrowMultipliers = {
    NumChargesConsumedOnUse = 0,
    MaxCharges = 10,
    WeakSpotMod = 10,
    ImpactDamage = 10,
    BlastDamage = 0,
    DOTDamage = 10,
    CloudDuration = 10,
    BlastRadius = 10,
    CloudDamagePerSecond = 10,
}

local function SetRottedArrowDefaults(mod)
    RottedArrowDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
    RottedArrowDefaults.MaxCharges = mod.MaxCharges
    RottedArrowDefaults.WeakSpotMod = mod.WeakSpotMod
    RottedArrowDefaults.ImpactDamage = mod.ImpactDamage
    RottedArrowDefaults.BlastDamage = mod.BlastDamage
    RottedArrowDefaults.DOTDamage = mod.DOTDamage
    RottedArrowDefaults.CloudDuration = mod.CloudDuration
    RottedArrowDefaults.BlastRadius = mod.BlastRadius
    RottedArrowDefaults.CloudDamagePerSecond = mod.CloudDamagePerSecond
end

local function ModRottedArrow()
    local rottedarrow = FindAllOf("Mod_RottedArrow_C")
    if rottedarrow then
        for _, mod in pairs(rottedarrow) do
            if not RottedArrowDefaults.NumChargesConsumedOnUse then
                SetRottedArrowDefaults(mod)
            end
            mod.NumChargesConsumedOnUse = RottedArrowDefaults.NumChargesConsumedOnUse * RottedArrowMultipliers.NumChargesConsumedOnUse
            mod.MaxCharges = RottedArrowDefaults.MaxCharges * RottedArrowMultipliers.MaxCharges
            mod.WeakSpotMod = RottedArrowDefaults.WeakSpotMod * RottedArrowMultipliers.WeakSpotMod
            mod.ImpactDamage = RottedArrowDefaults.ImpactDamage * RottedArrowMultipliers.ImpactDamage
            mod.BlastDamage = RottedArrowDefaults.BlastDamage * RottedArrowMultipliers.BlastDamage
            mod.DOTDamage = RottedArrowDefaults.DOTDamage * RottedArrowMultipliers.DOTDamage    
            mod.CloudDuration = RottedArrowDefaults.CloudDuration * RottedArrowMultipliers.CloudDuration
            mod.BlastRadius = RottedArrowDefaults.BlastRadius * RottedArrowMultipliers.BlastRadius
            mod.CloudDamagePerSecond = RottedArrowDefaults.CloudDamagePerSecond * RottedArrowMultipliers.CloudDamagePerSecond
            print("RottedArrow modified.  Num Charges Consumed On Use From: " .. tostring(RottedArrowDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse) ..
                " and Max Charges From: " .. tostring(RottedArrowDefaults.MaxCharges) .. " to " .. tostring(mod.MaxCharges) ..
                " and Weak Spot Mod From: " .. tostring(RottedArrowDefaults.WeakSpotMod) .. " to " .. tostring(mod.WeakSpotMod) ..
                " and Impact Damage From: " .. tostring(RottedArrowDefaults.ImpactDamage) .. " to " .. tostring(mod.ImpactDamage) ..
                " and Blast Damage From: " .. tostring(RottedArrowDefaults.BlastDamage) .. " to " .. tostring(mod.BlastDamage) ..
                " and DOT Damage From: " .. tostring(RottedArrowDefaults.DOTDamage) .. " to " .. tostring(mod.DOTDamage) ..
                " and Cloud Duration From: " .. tostring(RottedArrowDefaults.CloudDuration) .. " to " .. tostring(mod.CloudDuration) ..
                " and Blast Radius From: " .. tostring(RottedArrowDefaults.BlastRadius) .. " to " .. tostring(mod.BlastRadius) ..
                " and Cloud Damage Per Second From: " .. tostring(RottedArrowDefaults.CloudDamagePerSecond) .. " to " .. tostring(mod.CloudDamagePerSecond))    
        end
    else
        print("RottedArrow not found")
    end
end

local RottedArrowMod = {
    ModRottedArrow = ModRottedArrow,
}

return RottedArrowMod