local UEHelpers = require("UEHelpers.UEHelpers")
local godModePreHookId = nil
local godModePostHookId = nil
local infiniteAmmoPreHookId = nil
local infiniteAmmoPostHookId = nil
local godMode = false
local infiniteAmmo = false
local GOD_MODE_HOOK_NAME = "/Game/Characters/Player/Base/Character_Master_Player_Base.Character_Master_Player_Base_C:HandleDamageTaken"
local INFINITE_AMMO_HOOK_NAME = "/Game/Items/Weapons/Common/Weapon_Gun_Base.Weapon_Gun_Base_C:OnFire"


RegisterConsoleCommandHandler("toggle_god_mode", function(FullCommand, Parameters, Ar)
    godMode = not godMode
    print("God mode Enabled: " .. tostring(godMode))
    Ar:Log("God mode Enabled: " .. tostring(godMode))
    return true
end)

RegisterConsoleCommandHandler("toggle_infinite_ammo", function(FullCommand, Parameters, Ar)
    infiniteAmmo = not infiniteAmmo
    print("Infinite Ammo Enabled: " .. tostring(infiniteAmmo))
    Ar:Log("Infinite Ammo Enabled: " .. tostring(infiniteAmmo))
    return true
end)


NotifyOnNewObject("/Game/Characters/Player/Base/Character_Master_Player_Base.Character_Master_Player_Base_C",
    function(Context)
       
        if godModePreHookId and godModePostHookId then
            UnregisterHook(GOD_MODE_HOOK_NAME, godModePreHookId, godModePostHookId)
        end
        if infiniteAmmoPreHookId and infiniteAmmoPostHookId then
            UnregisterHook(INFINITE_AMMO_HOOK_NAME, infiniteAmmoPreHookId, infiniteAmmoPostHookId)
        end

        local godPre, godPost = RegisterHook(GOD_MODE_HOOK_NAME,
            function(self, DamageInfo)
                if godMode then
                    local info = DamageInfo:get()
                    local damage = info.Damage
                    local p = UEHelpers.GetPlayer()
                    if p and damage > 0 then
                        p:ReplenishResources(
                            true,  -- Health,
                            false, -- Ammo
                            false, -- DragonHearts
                            false, -- Cooldowns
                            false, -- ModPower
                            false  -- IsBossRush
                        )
                    end
                end
            end)

        godModePreHookId = godPre
        godModePostHookId = godPost

        local infiniteAmmoPre, infiniteAmmoPost = RegisterHook(INFINITE_AMMO_HOOK_NAME, function(self, Amount)
            if infiniteAmmo then
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
            end
        end)

        infiniteAmmoPreHookId = infiniteAmmoPre
        infiniteAmmoPostHookId = infiniteAmmoPost

    end)