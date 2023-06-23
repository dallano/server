-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ronpaurege
-- !pos 65.739 -0.199 74.275 231
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getMainLvl() > 20 then
        npc:injectActionPacket(player:getID(), 4, 261, 0, 0, 0, 10, 1)

        npc:timer(3500, function(x)
            xi.teleport.to(player, xi.teleport.id.LOWER_JEUNO)
        end)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
