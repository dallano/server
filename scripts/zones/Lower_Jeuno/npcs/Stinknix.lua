-----------------------------------
-- Area: Lower Jeuno
--  NPC: Stinknix
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
        943,    294, -- Poison Dust
        944,   1035, -- Venom Dust
        945,   2000, -- Paralysis Dust
        17320,    7, -- Iron Arrow
        17336,    5, -- Crossbow Bolt
        17313, 1107, -- Grenade
        2865, 10000, -- Dutchy Waystone
        1255, 65643, -- Fire Ore
        1256, 73125, -- Ice Ore
        1257, 67154, -- Wind Ore
        1258, 68156, -- Earth Ore
        1259, 62156, -- Lightning Ore
        1260, 58152, -- Water Ore
        1261, 75213, -- Light Ore
        1262, 76523, -- Dark Ore
    }

    player:showText(npc, ID.text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
