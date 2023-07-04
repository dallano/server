-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Lotte
-- General Info NPC
-----------------------------------
local entity = {}

local stock =
{

}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(564)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 564 then
        xi.shop.general(player, xi.shop.foodStock)
    end
end

return entity
