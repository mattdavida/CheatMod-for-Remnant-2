local ScrapshotDefaults = {
    MaxCharges = nil,
    BlastRadius = nil,
    DOTDamage = nil,
    CaltropDuration = nil,
    BleedDamage = nil,
    BleedDuration = nil,
    NumChargesConsumedOnUse = nil,
}

local ScrapshotMultipliers = {
    MaxCharges = 10,
    BlastRadius = 10,
    DOTDamage = 10,
    CaltropDuration = 10,
    BleedDamage = 10,
    BleedDuration = 10,
    NumChargesConsumedOnUse = 0,
}

local function SetScrapshotDefaults(mod)
    ScrapshotDefaults.MaxCharges = mod.MaxCharges
    ScrapshotDefaults.BlastRadius = mod.BlastRadius
    ScrapshotDefaults.DOTDamage = mod.DOTDamage
    ScrapshotDefaults.CaltropDuration = mod.CaltropDuration
    ScrapshotDefaults.BleedDamage = mod.BleedDamage
    ScrapshotDefaults.BleedDuration = mod.BleedDuration
    ScrapshotDefaults.NumChargesConsumedOnUse = mod.NumChargesConsumedOnUse
end

local function ModScrapshot()
    local scrapshot = FindAllOf("Mod_Scrapshot_C")
    if scrapshot then
        for _, mod in pairs(scrapshot) do
            if not ScrapshotDefaults.MaxCharges then
                SetScrapshotDefaults(mod)
            end
            mod.NumChargesConsumedOnUse = ScrapshotDefaults.NumChargesConsumedOnUse * ScrapshotMultipliers.NumChargesConsumedOnUse
            mod.MaxCharges = ScrapshotDefaults.MaxCharges * ScrapshotMultipliers.MaxCharges
            mod.BlastRadius = ScrapshotDefaults.BlastRadius * ScrapshotMultipliers.BlastRadius
            mod.DOTDamage = ScrapshotDefaults.DOTDamage * ScrapshotMultipliers.DOTDamage
            mod.CaltropDuration = ScrapshotDefaults.CaltropDuration * ScrapshotMultipliers.CaltropDuration
            mod.BleedDamage = ScrapshotDefaults.BleedDamage * ScrapshotMultipliers.BleedDamage
            mod.BleedDuration = ScrapshotDefaults.BleedDuration * ScrapshotMultipliers.BleedDuration
            print("Scrapshot modified.  Max Charges From: " .. tostring(ScrapshotDefaults.MaxCharges) .. " to " .. tostring(mod.MaxCharges) ..
                " and Blast Radius From: " .. tostring(ScrapshotDefaults.BlastRadius) .. " to " .. tostring(mod.BlastRadius) ..
                " and DOT Damage From: " .. tostring(ScrapshotDefaults.DOTDamage) .. " to " .. tostring(mod.DOTDamage) ..
                " and Caltrop Duration From: " .. tostring(ScrapshotDefaults.CaltropDuration) .. " to " .. tostring(mod.CaltropDuration) ..
                " and Bleed Damage From: " .. tostring(ScrapshotDefaults.BleedDamage) .. " to " .. tostring(mod.BleedDamage) ..
                " and Bleed Duration From: " .. tostring(ScrapshotDefaults.BleedDuration) .. " to " .. tostring(mod.BleedDuration) ..
                " and Num Charges Consumed On Use From: " .. tostring(ScrapshotDefaults.NumChargesConsumedOnUse) .. " to " .. tostring(mod.NumChargesConsumedOnUse))
        end
    else
        print("Scrapshot not found")
    end
end

local ScrapshotMod = {
    ModScrapshot = ModScrapshot,
}

return ScrapshotMod