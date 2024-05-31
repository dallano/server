-----------------------------------
-- Area: Port Windurst
--  NPC: Hohbiba-Mubiba
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
        17051,  1440, 3,    -- Yew Wand
        17090,  3642, 3,    -- Elm Staff
        17097, 18422, 3,    -- Elm Pole
        17026,  4945, 3,    -- Bone Cudgel
        17096,  4669, 3,    -- Holly Pole
        17049,    47, 3,    -- Maple Wand
        17050,   340, 3,    -- Willow Wand
        17059,    91, 3,    -- Bronze Rod
        17024,    66, 3,    -- Ash Club
        17025,  1600, 3,    -- Chestnut Club
        17052, 10325, 3,    -- Chestnut Wand (xiSP)
        17053, 25362, 3,    -- Rose Wand (xiSP)
        17054, 38045, 3,    -- Ebony Wand (xiSP)
        17088,    58, 3,    -- Ash Staff
        17089,   584, 3,    -- Holly Staff
        17095,   386, 3,    -- Ash Pole
    }

    player:showText(npc, ID.text.HOHBIBAMUBIBA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
