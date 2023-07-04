-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Miogique
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12552, 14256,    -- Chainmail
        12680,  7783,    -- Chain Mittens
        12672, 23846,    -- Gauntlets
        12424,  9439,    -- Iron Mask
        12442, 13179,    -- Studded Bandana
        12698, 11012,    -- Studded Gloves
        12570, 20976,    -- Studded Vest
        12449,  1504,    -- Brass Cap
        12577,  2286,    -- Brass Harness
        12705,  1255,    -- Brass Mittens
        12448,   154,    -- Bronze Cap
        12576,   576,    -- Bronze Harness
        12704,   128,    -- Bronze Mittens
        12440,   396,    -- Leather Bandana
        12696,   331,    -- Leather Gloves
        12568,   618,    -- Leather Vest
        12699, 15023,    -- Cuir Gloves
        12955, 16053,    -- Cuir Highboots
    }

    player:showText(npc, ID.text.RAIMBROYS_SHOP_DIALOG + 1)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
