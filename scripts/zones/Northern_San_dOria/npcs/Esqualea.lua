-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Esqualea
-----------------------------------
local entity = {}

local stock =
{
    xi.items.PIECE_OF_ANGEL_SKIN, 185365,
    xi.items.DIVINE_LOG,          124356,
    1133,                         115678, -- Dragon Blood
    866,                          17845,  -- Wyvern scales
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer("Welcome to the Abjuration Store!", 0, "Esqualea")
    xi.shop.general(player, stock, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
