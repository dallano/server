-----------------------------------
-- Area: Bastok Mines
--  NPC: Dry Bone
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npc:injectActionPacket(player:getID(), 4, 261, 0, 0, 0, 10, 1)
    npc:timer(3000, function(x)
        xi.teleport.to(player, xi.teleport.id.LOWER_JEUNO)
    end)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
