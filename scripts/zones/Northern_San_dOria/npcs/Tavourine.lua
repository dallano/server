-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Tavourine
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        16584, 37800, -- Mythril Claymore
        16466,  2182, -- Knife
        17060,  2386, -- Rod
        16640,   284, -- Bronze Axe
        16465,   147, -- Bronze Knife
        17081,   621, -- Brass Rod
        16583,  2448, -- Claymore
        17035,  4363, -- Mace
        17059,    90, -- Bronze Rod
        17034,   169, -- Bronze Mace
        16845, 16578, -- Lance
    }

    player:showText(npc, ID.text.TAVOURINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
