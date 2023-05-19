-----------------------------------
-- Assault: Saving Private Ryaaf
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SAVING_PRIVATE_RYAAF and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 70
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SAVING_PRIVATE_RYAAF and
        player:getCharVar("assaultEntered") == 0 and
        player:getMainLvl() > 70
end

instanceObject.onInstanceCreated = function(instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_REEF_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-495.000, -9.695, -72.000, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-490.000, -9.900, -72.000, 0)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 3 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8)
end

instanceObject.onEventFinish = function(player, csid, option)
end

return instanceObject
