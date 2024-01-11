-----------------------------------
-- Area: Hall of Transference
--  NPC: Large Apparatus (Right) - Dem
-- !pos -243.723 -41.482 -289.937 14
-----------------------------------
local ID = require("scripts/zones/Hall_of_Transference/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("DemChipRegistration") == 0 and
        player:getCharVar("skyShortcut") == 1 and
        trade:hasItemQty(478, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(168)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("DemChipRegistration") == 0 then
        player:startEvent(168)
    else
        player:messageSpecial(ID.text.YOU_MUST_MOVE_CLOSER)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 168 then
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 4, 478) -- You fit..
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 5) -- Device has been repaired
        player:setCharVar("DemChipRegistration", 1)
        player:tradeComplete()
    end
end

return entity
