-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ashene
-- Standard Merchant NPC
-- !pos 70 0 61 230
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
        16455,  4309,    -- Baselard
        16532, 16934,    -- Gladius
        16545, 21067,    -- Broadsword
        16576, 35769,    -- Hunting Sword
        16524, 13406,    -- Fleuret
        16450,  1827,    -- Dagger
        16536,  7128,    -- Iron Sword
        16566,  8294,    -- Longsword
        16448,   140,    -- Bronze Dagger
        16449,   837,    -- Brass Dagger
        16531,  3523,    -- Brass Xiphos
        16535,   241,    -- Bronze Sword
        16565,  1674,    -- Spatha
        xi.items.RUSTY_GREATSWORD, 567, -- (xiSP)
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
