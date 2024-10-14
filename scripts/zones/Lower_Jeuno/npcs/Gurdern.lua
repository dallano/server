-----------------------------------
-- Area: Lower Jeuno
--  NPC: Gurdern
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local shopStock =
{
    1823,   97636, -- Shrimp Lantern
    1825,  102365, -- Antlion Trap
    18014,  94356, -- Odorous Knife
    18016, 196126, -- Odorous Knife +1
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatJeuno, 14)
    then
        player:startEvent(10052)
    else
        -- player:startEvent(112)
        player:PrintToPlayer("Monster lures! Come get your monster lures! Ah, adventurer. What can I do for you?", xi.msg.channel.SAY, "Gurdern")
        xi.shop.general(player, shopStock)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.ontFinish = function(player, csid, option)
    if csid == 10052 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 14, true))
    elseif csid == 112 then
    end
end

return entity
