local ConcussiveShotDefaults = {
    BlastDamage = nil,
    MaxRange = nil,
    BaseKnockbackDistance = nil,
    AOERadius = nil,
    MaxCharges = nil,
    NumChargesConsumedOnUse = nil,
}   

local ConcussiveShotMultipliers = {
    BlastDamage = 10,
    MaxRange = 10,
    BaseKnockbackDistance = 10,
    AOERadius = 10,
    MaxCharges = 10,
    NumChargesConsumedOnUse = 0,
}

local function SetConcussiveShotDefaults(mod)
    ConcussiveShotDefaults.BlastDamage = mod.BlastDamage
    ConcussiveShotDefaults.MaxRange = mod.MaxRange
    ConcussiveShotDefaults.BaseKnockbackDistance = mod.BaseKnockbackDistance
    ConcussiveShotDefaults.AOERadius = mod.AOERadius
    ConcussiveShotDefaults.MaxCharges = mod.MaxCharges
    ConcussiveShotDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
end

local function ModConcussiveShot()
    local concussiveShot = FindAllOf("Mod_ConcussiveShot_C")
    if concussiveShot then
        for _, mod in pairs(concussiveShot) do
            if not ConcussiveShotDefaults.BlastDamage then
                SetConcussiveShotDefaults(mod)
            end

            mod.NumChargesConsumedOnUse = ConcussiveShotDefaults.NumChargesConsumedOnUse * ConcussiveShotMultipliers.NumChargesConsumedOnUse
            mod.BlastDamage = ConcussiveShotDefaults.BlastDamage * ConcussiveShotMultipliers.BlastDamage
            mod.MaxRange = ConcussiveShotDefaults.MaxRange * ConcussiveShotMultipliers.MaxRange
            mod.BaseKnockbackDistance = ConcussiveShotDefaults.BaseKnockbackDistance * ConcussiveShotMultipliers.BaseKnockbackDistance
            mod.AOERadius = ConcussiveShotDefaults.AOERadius * ConcussiveShotMultipliers.AOERadius
            mod.MaxCharges = ConcussiveShotDefaults.MaxCharges * ConcussiveShotMultipliers.MaxCharges
            print("Concussive Shot modified.  Blast Damage From: " ..
                tostring(ConcussiveShotDefaults.BlastDamage) ..
                " to " .. tostring(mod.BlastDamage) ..
                " and Max Range From: " .. tostring(ConcussiveShotDefaults.MaxRange) .. " to " .. tostring(mod.MaxRange) ..
                " and Base Knockback Distance From: " .. tostring(ConcussiveShotDefaults.BaseKnockbackDistance) .. " to " .. tostring(mod.BaseKnockbackDistance) ..
                " and AOERadius From: " .. tostring(ConcussiveShotDefaults.AOERadius) .. " to " .. tostring(mod.AOERadius) ..
                " and Max Charges From: " .. tostring(ConcussiveShotDefaults.MaxCharges) .. " to " .. tostring(mod.MaxCharges) ..
                " and Num Charges Consumed On Use From: " .. tostring(ConcussiveShotDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse))
        end
    else
        print("Concussive Shot not found")
    end

end

local ConcussiveShotMod = {
    ModConcussiveShot = ModConcussiveShot,
}

return ConcussiveShotMod