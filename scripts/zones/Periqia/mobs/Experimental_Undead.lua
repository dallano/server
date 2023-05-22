-----------------------------------
-- Area: Periqia (Saving Private Ryaaf)
--  Mob: Experimental Undead
-- TODO: Create kneeling animation for false undead

-- 20 yalm ability agro range
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

local fakeNPCs =
{
    17006656,
    17006657,
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 5)

    for i = 1, 3 do
        if mob:getID() == fakeNPCs[i] then
            mob:setMobMod(xi.mobMod.SOUND_RANGE, 3)
            mob:setLocalVar("fakeNPC", 1)
            mob:setUntargetable(true)
            mob:hideName(true)
            mob:setAnimation(33)
        end
    end
end

entity.onMobEngaged = function(mob)
    if mob:getLocalVar("fakeNPC") == 1 then
        mob:setUntargetable(false)
        mob:hideName(false)
        mob:setAnimation(1)
    end

    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    local spawnPos = mob:getSpawnPos()
    local pos      = mob:getPos()

    mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z, xi.path.flag.SCRIPT)

    if
        pos.x - spawnPos.z < 2 and
        pos.z - spawnPos.z < 2
    then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)

        if mob:getLocalVar("fakeNPC") == 1 then
            mob:setUntargetable(true)
            mob:hideName(true)
            mob:setAnimation(33)
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:checkDistance(target) >= 40 then
        mob:disengage()
    end
end

return entity
