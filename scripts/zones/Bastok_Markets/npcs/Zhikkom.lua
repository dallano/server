-----------------------------------
-- Area: Bastok Markets
--  NPC: Zhikkom
-- Standard Merchant NPC
-- !pos -288.669 -10.319 -135.064 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16537, 31648, 3, -- Mythril Sword
        16545, 21535, 3, -- Broadsword
        16513, 11845, 3, -- Tuck
        16558, 62560, 3, -- Falchion
        16536,  7286, 3, -- Iron Sword
        16552,  4163, 3, -- Scimitar
        16535,   246, 3, -- Bronze Sword
        16517,  9406, 3, -- Degen
        16551,   713, 3, -- Sapara
        16530,   618, 3, -- Xiphos
        16565,  1711, 3, -- Spatha
        16512,  3215, 3, -- Bilbo
    }

    player:showText(npc, ID.text.ZHIKKOM_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
