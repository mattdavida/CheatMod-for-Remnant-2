local UEHelpers = require("UEHelpers.UEHelpers")


local function LevelUp(Ar)
    local p = UEHelpers.GetPlayer()
    if p then
        p.Traits:OnLevelUp()
        print("Level up complete")
        Ar:Log("Level up complete")
    else
        print("Player  not found")
        Ar:Log("Player  not found")
    end
end

local function InfiniteStamina()
    local p = UEHelpers.GetPlayer()
    if p then
        local stamina = p.Stamina
        if stamina then
            local componentTags = stamina.ComponentTags
            componentTags[#componentTags + 1] = FName("InfiniteStamina")
            print("Infinite Stamina added")
        else
            print("Stamina not found")
        end
    else
        print("Player  not found")
    end
end

local function ReplenishCooldownsAndModPower()
    local p = UEHelpers.GetPlayer()
    if p then
        p:ReplenishResources(
            false, -- Health,
            false, -- Ammo
            false, -- DragonHearts
            true,  -- Cooldowns
            true,  -- ModPower
            false  -- IsBossRush
        )
    else
        print("Player  not found")
    end
end

-- faster gameplay for player
local function FastPlayerActions()
    local animSequence = FindAllOf("AnimSequence")
    if animSequence then
        for _, anim in pairs(animSequence) do
            local name = anim:GetFullName():lower()

            if name:find("player") and
                not name:find("walk") and
                not name:find("jog") and
                not name:find("aim") and
                not name:find("sprint") and
                not name:find("run") and
                not name:find("crouch") and
                not name:find("evaderoll") then
                anim.RateScale = 4.0
            end

            if name:find("evaderoll") then
                -- 1.7 felt better than 2.0
                anim.RateScale = 1.7
            end
        end
        print("Fast Player Actions Enabled")
    else
        print("Anim Sequence not found")
    end
end

return {
    LevelUp = LevelUp,
    InfiniteStamina = InfiniteStamina,
    ReplenishCooldownsAndModPower = ReplenishCooldownsAndModPower,
    FastPlayerActions = FastPlayerActions,
}