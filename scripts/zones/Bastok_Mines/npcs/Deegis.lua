-----------------------------------
-- Area: Bastok Mines
--  NPC: Deegis
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
        12450, 18360, 3,     --Padded Cap
        12424,  9234, 3,     --Iron Mask
        12578, 28339, 3,     --Padded Armor
        12706, 15552, 3,     --Iron Mittens
        12449,  1471, 3,     --Brass Cap
        12440,   396, 3,     --Leather Bandana
        12577,  2236, 3,     --Brass Harness
        12568,   604, 3,     --Leather Vest
        12705,  1228, 3,     --Brass Mittens
        12696,   324, 3,     --Leather Gloves
        12448,   151, 3,     --Bronze Cap
        12576,   230, 3,     --Bronze Harness
        12552, 14256, 3,     --Chainmail
        12704,   126, 3,     --Bronze Mittens
        12680,  7614, 3,     --Chain Mittens
    }

    player:showText(npc, ID.text.DEEGIS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
