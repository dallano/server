-----------------------------------
-- Area: Bastok Markets
--  NPC: Sororo
-- Standard Merchant NPC
-- !pos -220.217 -2.824 51.542 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4641,  1165, 3, -- Diaga
        4662,  7025, 3, -- Stoneskin
        4664,   837, 3, -- Slow
        4610,   585, 3, -- Cure II
        4636,   140, 3, -- Banish
        4646,  1165, 3, -- Banishga
        4661,  2097, 3, -- Blink
        4609,    61, 3, -- Cure
        4615,  1363, 3, -- Curaga
        4622,   180, 3, -- Poisona
        4623,   324, 3, -- Paralyna
        4624,   990, 3, -- Blindna
        4631,    82, 3, -- Dia
        4651,   219, 3, -- Protect
        4656,  1584, 3, -- Shell
        4721, 29700, 3, -- Repose
    }

    player:showText(npc, ID.text.SORORO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
