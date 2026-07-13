local UEHelpers = require("UEHelpers.UEHelpers")
local INFINITE_AMMO_HOOK_NAME = "/Game/Items/Weapons/Common/Weapon_Gun_Base.Weapon_Gun_Base_C:OnFire"
local MOFIFY_INCOMING_DAMAGE_HOOK_NAME =
"/Game/Characters/Player/Base/Character_Master_Player_Base.Character_Master_Player_Base_C:ModifyIncomingDamage"

local godmode = false
local hookRegistered = false
RegisterConsoleCommandHandler("toggle_god_mode", function(FullCommand, Parameters, Ar)
    godmode = not godmode
    print("God Mode: " .. (godmode and "Enabled" or "Disabled"))
    if not hookRegistered then
        hookRegistered = true
        RegisterHook(MOFIFY_INCOMING_DAMAGE_HOOK_NAME,
            function(self, DamageInfo)
                local damage = DamageInfo:get()
                if godmode then
                    damage.Damage = 0
                end
            end)
    end

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
