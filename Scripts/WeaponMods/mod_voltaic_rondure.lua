local VoltaicRondureDefaults = {
    PulseDelay = nil, -- 0.01
    MaxCharges = nil, -- .5
    OrbDamage = nil, -- 30
    ProjectileLifetime = nil, -- 20
    EffectRadius = nil, -- 600
    ShockDamage = nil, -- 25
    ShockDuration = nil, -- 15
    NumChargesConsumedOnUse = nil,
}

local VoltaicRondureMultipliers = {
    MaxCharges = 10,
    OrbDamage = 10,
    ProjectileLifetime = 1,
    EffectRadius = 3,
    ShockDamage = 10,
    ShockDuration = 2,
    NumChargesConsumedOnUse = 0,
}

local function SetVoltaicRondureDefaults(mod)
    VoltaicRondureDefaults.PulseDelay = mod.PulseDelay
    VoltaicRondureDefaults.OrbDamage = mod.OrbDamage
    VoltaicRondureDefaults.ProjectileLifetime = mod.ProjectileLifetime
    VoltaicRondureDefaults.EffectRadius = mod.EffectRadius
    VoltaicRondureDefaults.ShockDamage = mod.ShockDamage
    VoltaicRondureDefaults.ShockDuration = mod.ShockDuration
    VoltaicRondureDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
end

local function ModVoltaicRondure()
    local voltaicRondure = FindAllOf("Mod_VoltaicRondure_C")
    if voltaicRondure then
        for _, mod in pairs(voltaicRondure) do
            if not VoltaicRondureDefaults.PulseDelay then
                SetVoltaicRondureDefaults(mod)
            end

            mod.NumChargesConsumedOnUse = VoltaicRondureDefaults.NumChargesConsumedOnUse * VoltaicRondureMultipliers.NumChargesConsumedOnUse
            mod.PulseDelay = 0.01
            mod.OrbDamage = VoltaicRondureDefaults.OrbDamage * VoltaicRondureMultipliers.OrbDamage
            mod.ProjectileLifetime = VoltaicRondureDefaults.ProjectileLifetime * VoltaicRondureMultipliers.ProjectileLifetime
            mod.EffectRadius = VoltaicRondureDefaults.EffectRadius * VoltaicRondureMultipliers.EffectRadius
            mod.ShockDamage = VoltaicRondureDefaults.ShockDamage * VoltaicRondureMultipliers.ShockDamage
            mod.ShockDuration = VoltaicRondureDefaults.ShockDuration * VoltaicRondureMultipliers.ShockDuration
            print("Voltaic Rondure modified.  Pulse Delay From: " .. tostring(VoltaicRondureDefaults.PulseDelay) .. " to " .. tostring(0.01) ..
                " and Orb Damage From: " .. tostring(VoltaicRondureDefaults.OrbDamage) .. " to " .. tostring(mod.OrbDamage) ..
                " and Projectile Lifetime From: " .. tostring(VoltaicRondureDefaults.ProjectileLifetime) .. " to " .. tostring(mod.ProjectileLifetime) ..
                " and Effect Radius From: " .. tostring(VoltaicRondureDefaults.EffectRadius) .. " to " .. tostring(mod.EffectRadius) ..
                " and Shock Damage From: " .. tostring(VoltaicRondureDefaults.ShockDamage) .. " to " .. tostring(mod.ShockDamage) ..
                " and Shock Duration From: " .. tostring(VoltaicRondureDefaults.ShockDuration) .. " to " .. tostring(mod.ShockDuration) ..
                " and Num Charges Consumed On Use From: " .. tostring(VoltaicRondureDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse))
        end
    else
        print("Voltaic Rondure not found")  
    end

end

local VoltaicRondureMod = {
    ModVoltaicRondure = ModVoltaicRondure,
}

return VoltaicRondureMod