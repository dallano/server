-----------------------------------
-- Area: Bastok Mines
--  NPC: Zemedars
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12836, 23316, 3, -- Iron Subligar
        12825,  5003, 3, -- Lizard Trousers
        12962, 14484, 3, -- Leggins
        12953,  3162, 3, -- Lizard Ledelsens
        12301, 31544, 3, -- Buckler
        12833,  1840, 3, -- Brass Subligar
        12824,   493, 3, -- Leather Trousers
        12961,  1140, 3, -- Brass Leggins
        12952,   309, 3, -- Leather Highboots
        12300, 11076, 3, -- Targe
        12832,   191, 3, -- Bronze Subligar
        12808, 11592, 3, -- Chain Gose
        12960,   117, 3, -- Bronze Leggins
        12936,  7120, 3, -- Greaves
        12290,   556, 3, -- Maple Shield (WoTG)
        12289,   110, 3, -- Lauan Shield
    }

    player:showText(npc, ID.text.ZEMEDARS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
