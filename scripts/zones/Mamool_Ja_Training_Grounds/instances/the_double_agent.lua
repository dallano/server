-----------------------------------
-- Assault: The Double Agent
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.THE_DOUBLE_AGENT and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 70
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.THE_DOUBLE_AGENT and
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
    local table = ID.mob[xi.assault.mission.THE_DOUBLE_AGENT].QIQIRN

    instance:setLocalVar("doubleAgentID", table[math.random(1, #table)])

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_BHAFLAU_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-222, 2, -385, 192)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-220, 2, -385, 192)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 1 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 9, 8)
end

instanceObject.onEventFinish = function(player, csid, option)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.BHAFLAU_THICKETS)
end

return instanceObject
