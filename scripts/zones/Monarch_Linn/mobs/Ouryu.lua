-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.

    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 14) -- 54 + 2 + 14 = 70
end

entity.onMobFight = function(mob, target)
    local bf = mob:getBattlefield()
    if bf:getID() == 961 and mob:getHPP() < 30 then
        bf:win()
        return
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.MIST_MELTER)
end

return entity
