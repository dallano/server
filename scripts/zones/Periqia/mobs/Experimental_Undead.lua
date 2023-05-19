-----------------------------------
-- Area: Periqia (Saving Private Ryaaf)
--  Mob: Experimental Undead
-- TODO: Create kneeling animation for false undead

-- 20 yalm ability agro range
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMobMod(xi.mobMod.NO_ROAM, 1)
end

entity.onMobFight = function(mob, target)
    if mob:checkDistance(target) >= 40 then
        mob:resetEnmity(target)
    end
end

return entity
