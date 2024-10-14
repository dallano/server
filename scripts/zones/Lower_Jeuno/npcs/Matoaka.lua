-----------------------------------
-- Area: Lower Jeuno
--  NPC: Matoaka
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12494, 39564, -- Gold Hairpin
    }

    player:showText(npc, ID.text.GEMS_BY_KSHAMA_SHOP_DIALOG)
    xi.shop.general(player, stock, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
