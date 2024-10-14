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
        943,    294,  -- Poison Dust
        944,   1035,  -- Venom Dust
        945,   2000,  -- Paralysis Dust
        17320,    7,  -- Iron Arrow
        17336,    5,  -- Crossbow Bolt
        18150,   14,  -- Blind Bolt (xiSP)
        18148,   18,  -- Acid Bolt (xiSP)
        18152,   20,  -- Venom Bolt (xiSP)
        18149,   27,  -- Sleep Bolt (xiSP)
        18151,   30,  -- Bloody Bolt (xiSP)
        17313, 1107,  -- Grenade
        16042, 10000, -- Duchy Waystone (xiSP)
    }

    player:showText(npc, ID.text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
