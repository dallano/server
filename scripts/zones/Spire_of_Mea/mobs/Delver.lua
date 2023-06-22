-----------------------------------
-- Area: Spire of Mea
--  Mob: Delver
-----------------------------------
mixins = { require("scripts/mixins/families/empty_terroanima") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
    mob:setSpeed(50)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 15 then
        mob:setMod(xi.mod.STORETP, 50)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
