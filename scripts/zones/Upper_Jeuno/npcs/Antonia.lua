-----------------------------------
-- Area: Upper Jeuno
--  NPC: Antonia
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
    17061,  6256, -- Mythril Rod
    17027,  8232, -- Oak Cudgel
    17036, 11048, -- Mythril Mace
    17044,  6033, -- Warhammer
    17098, 13440, -- Oak Pole
    16836, 17550, -- Halberd
    16847, 29058, -- Mythril Lance
    16848, 49109, -- Darksteel Lance
    16849, 61098, -- Cermet Lance
    16774,  7596, -- Scythe
    17320,     7, -- Iron Arrow
    }

    player:showText(npc, ID.text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
