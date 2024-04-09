-----------------------------------
-- Area: Rolanberry Fields (110)
--  HNM: Simurgh
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/mobs")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    --xi.mob.nmTODPersistCache(mob:getZone(), mob:getID())
    mob:addImmunity(xi.immunity.SLEEP)
    mob:setMod(xi.mod.EVA, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    -- custom distance from retail capture
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 34)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SIMURGH_POACHER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(129600, 172800)) -- (xiSP 36 - 48 hours)
end

return entity
