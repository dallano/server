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
    local master        = fellow:getMaster()
    fellow:setLocalVar("masterID", master:getID())
    fellow:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
    master:setLocalVar("chatCounter", 0)
    master:setFellowValue("spawnTime", os.time())
    -- Attack now handled only by !fellowAttack <target>
    -- Disengage now handled only by !fellowDisengage
end

entity.onTrigger = function(player, fellow)
    xi.fellow_utils.onTrigger(player, fellow)
end

entity.onMobRoam = function(fellow)
    local master = fellow:getMaster()

    if master == nil then
        return
    end

    xi.fellow_utils.timeWarning(fellow, master)
    xi.fellow_utils.spellCheck(fellow, master)
end

entity.onMobFight = function(fellow, target)
    local master = fellow:getMaster()

    if master == nil then
        return
    end

    xi.fellow_utils.checkProvoke(fellow, target, master)
    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.weaponskill(fellow, target, master)
    xi.fellow_utils.battleMessaging(fellow, master)
    xi.fellow_utils.timeWarning(fellow, master)
end

entity.onMobDeath = function(fellow)
    xi.fellow_utils.onDeath(fellow)
end

entity.onMobDespawn = function(fellow)
    xi.fellow_utils.onDespawn(fellow)
end

return entity
