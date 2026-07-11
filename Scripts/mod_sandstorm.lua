local SandstormDefaults = {
    CycloneDuration = nil,
    CycloneBaseRadius = nil,
    CycloneHomingRadius = nil,
    CycloneDPS = nil,
    CycloneDamageFrequency = nil,
    NumChargesConsumedOnUse = nil,
}

local SandstormMultipliers = {
    CycloneDuration = 10,
    CycloneBaseRadius = 10,
    CycloneHomingRadius = 10,
    CycloneDPS = 10,
    CycloneDamageFrequency = 10,
    NumChargesConsumedOnUse = 0,
}

local function SetSandstormDefaults(mod)
    SandstormDefaults.CycloneDuration = mod.CycloneDuration
    SandstormDefaults.CycloneBaseRadius = mod.CycloneBaseRadius
    SandstormDefaults.CycloneHomingRadius = mod.CycloneHomingRadius
    SandstormDefaults.CycloneDPS = mod.CycloneDPS
    SandstormDefaults.CycloneDamageFrequency = mod.CycloneDamageFrequency
    SandstormDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
end

local function ModSandstorm()
    local sandstorm = FindAllOf("Mod_Sandstorm_C")
    if sandstorm then
        for _, mod in pairs(sandstorm) do
            if not SandstormDefaults.CycloneDuration then
                SetSandstormDefaults(mod)
            end
            mod.NumChargesConsumedOnUse = SandstormDefaults.NumChargesConsumedOnUse * SandstormMultipliers.NumChargesConsumedOnUse
            mod.CycloneDuration = SandstormDefaults.CycloneDuration * SandstormMultipliers.CycloneDuration
            mod.CycloneBaseRadius = SandstormDefaults.CycloneBaseRadius * SandstormMultipliers.CycloneBaseRadius
            mod.CycloneHomingRadius = SandstormDefaults.CycloneHomingRadius * SandstormMultipliers.CycloneHomingRadius
            mod.CycloneDPS = SandstormDefaults.CycloneDPS * SandstormMultipliers.CycloneDPS
            mod.CycloneDamageFrequency = SandstormDefaults.CycloneDamageFrequency * SandstormMultipliers.CycloneDamageFrequency
            print("Sandstorm modified.  Cyclone Duration From: " ..
                tostring(SandstormDefaults.CycloneDuration) ..
                " to " .. tostring(mod.CycloneDuration) ..
                " and Cyclone Base Radius From: " .. tostring(SandstormDefaults.CycloneBaseRadius) .. " to " .. tostring(mod.CycloneBaseRadius) ..
                " and Cyclone Homing Radius From: " .. tostring(SandstormDefaults.CycloneHomingRadius) .. " to " .. tostring(mod.CycloneHomingRadius) ..
                " and Cyclone DPS From: " .. tostring(SandstormDefaults.CycloneDPS) .. " to " .. tostring(mod.CycloneDPS) ..
                " and Cyclone Damage Frequency From: " .. tostring(SandstormDefaults.CycloneDamageFrequency) .. " to " .. tostring(mod.CycloneDamageFrequency) ..
                " and Num Charges Consumed On Use From: " .. tostring(SandstormDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse))
        end
    else
        print("Sandstorm not found")
    end

end

local SandstormMod = {
    ModSandstorm = ModSandstorm,
}

return SandstormMod