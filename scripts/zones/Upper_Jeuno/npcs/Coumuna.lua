-----------------------------------
-- Area: Upper Jeuno
--  NPC: Coumuna
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
        16705,  4550,    -- Greataxe
        16518, 21000,    -- Mythril Degen
        16460,  8096,    -- Kris
        16467, 10560,    -- Mythril Knife
        16399, 11488,    -- Katars
        16589,  9962,    -- Two-Handed Sword
        16412, 19760,    -- Mythril Claws
        16567, 35250,    -- Knight's Sword
        16644, 28600,    -- Mythril Axe
        17061,  6256,    -- Mythril Rod
        17027,  8232,    -- Oak Cudgel
        17036, 13048,    -- Mythril Mace
        17044,  6558,    -- Warhammer
        17098, 15440,    -- Oak Pole
        16836, 17550,    -- Halberd
        16774,  8596,    -- Scythe
        17320,     8,    -- Iron Arrow
    }

    player:showText(npc, ID.text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
