-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Jakaka
-- Type: ENM
-- !pos -144.711 6.246 -250.309 7
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- -- Trade Parradamo Stones
    -- if trade:hasItemQty(1778, 1) and trade:getItemCount() == 1 then
    --     player:tradeComplete()
    --     player:startEvent(12)
    -- end
end

entity.onTrigger = function(player, npc)
    local miasmaFilterCD = player:getCharVar("[ENM]MiasmaFilter")

    if player:hasKeyItem(xi.ki.MIASMA_FILTER) then
        player:setPos(-709.5, 20.5, 456, 24, 8)
    else
        if miasmaFilterCD >= VanadielTime() then
            -- Both Vanadiel time and unix timestamps are based on seconds. Add the difference to the event.
            player:startEvent(14, miasmaFilterCD)
        else
            player:startEvent(12)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 12 then
        player:addKeyItem(xi.ki.MIASMA_FILTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MIASMA_FILTER)
        player:setCharVar("[ENM]MiasmaFilter", VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
    elseif csid == 13 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1777) -- Flaxen Pouch
            return
        else
            player:addItem(1777)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1777) -- Flaxen Pouch
        end
    end
end

return entity
