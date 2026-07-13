local UEHelpers = require("UEHelpers.UEHelpers")
local GOD_MODE_HOOK_NAME =
"/Game/Characters/Player/Base/Character_Master_Player_Base.Character_Master_Player_Base_C:HandleDamageTaken"
local INFINITE_AMMO_HOOK_NAME = "/Game/Items/Weapons/Common/Weapon_Gun_Base.Weapon_Gun_Base_C:OnFire"


-- notes: 
-- these hooks can sometimes unregister at random transitions on loading screens
-- if you notice this, just re-run the command
RegisterConsoleCommandHandler("start_god_mode", function(FullCommand, Parameters, Ar)
    print("God mode Enabled: ")
    RegisterHook(GOD_MODE_HOOK_NAME,
        function(self, DamageInfo)
            local p = UEHelpers.GetPlayer()
            if p then
                p:ReplenishResources(
                    true,      -- Health,
                    false,     -- Ammo
                    false,     -- DragonHearts
                    false,     -- Cooldowns
                    false,     -- ModPower
                    false      -- IsBossRush
                )
            end
        end)
    return true
end)

RegisterConsoleCommandHandler("start_infinite_ammo", function(FullCommand, Parameters, Ar)
    print("Infinite Ammo Enabled: ")
    RegisterHook(INFINITE_AMMO_HOOK_NAME, function(self, Amount)
        local p = UEHelpers.GetPlayer()
        if p then
            p:ReplenishResources(
                false, -- Health,
                true,  -- Ammo
                false, -- DragonHearts
                false, -- Cooldowns
                false, -- ModPower
                false  -- IsBossRush
            )
        end
    end)
    return true
end)
