-----------------------------------
--  Adventuring Fellow
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/fellow_utils")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(fellow)
    xi.fellow_utils.onFellowSpawn(fellow)
end

entity.onTrigger = function(player, fellow)
    xi.fellow_utils.onTrigger(player, fellow)
end

entity.onMobRoam = function(fellow)
    xi.fellow_utils.onFellowRoam(fellow)
end

entity.onMobFight = function(fellow, target)
    xi.fellow_utils.onFellowFight(fellow, target)
end

entity.onMobDeath = function(fellow)
    xi.fellow_utils.onDeath(fellow)
end

entity.onMobDespawn = function(fellow)
    xi.fellow_utils.onDespawn(fellow)
end

return entity
