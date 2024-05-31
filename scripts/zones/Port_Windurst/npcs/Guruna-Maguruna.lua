-----------------------------------
-- Area: Port Windurst
--  NPC: Guruna-Maguruna
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12593, 12355, 3,    -- Cotton Doublet
        14424, 18763, 3,    -- Seers Tunic (xiSP)
        12721,  6696, 3,    -- Cotton Gloves
        13085,   972, 3,    -- Hemp Gorget
        12592,  2470, 3,    -- Doublet
        14856, 14532, 3,    -- Seers Mitts (xiSP)
        12600,   216, 3,    -- Robe
        12568,   604, 3,    -- Leather Vest
        12608,  1260, 3,    -- Tunic
        12601,  2776, 3,    -- Linen Robe
        14325, 17852, 3,    -- Seers Slacks (xiSP)
        12720,  1363, 3,    -- Gloves
        12728,   118, 3,    -- Cuffs
        12696,   324, 3,    -- Leather Gloves
        15313, 13265, 3,    -- Seers Pumps (xiSP)
        12736,   589, 3,    -- Mitts
        12729,  1570, 3,    -- Linen Cuffs
        15163, 15368, 3,    -- Seers Crown (xiSP)
    }

    player:showText(npc, ID.text.GURUNAMAGURUNA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
