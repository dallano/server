-----------------------------------
-- Area: Periqia (Saving Private Ryaaf)
--  Mob: Cursed Chigoe
-----------------------------------
mixins = { require("scripts/mixins/families/chigoe") }
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobFight = function(mob, target)
end

return entity
