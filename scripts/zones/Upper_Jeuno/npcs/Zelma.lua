-----------------------------------
-- Area: Upper Jeuno
--  NPC: Zelma
-----------------------------------
local entity = {}

local shopStock =
{
    1, 999999,
}

entity.onTrade = function(player, npc, trade)
    local result   = math.random(1, 100)
    local toughHqChance = 5
    local medHqChance = 10
    local easyHqChance = 25
    local HQ       = 0

    -- Dusk Gloves (Behemoth Hide)
    if npcUtil.tradeHasExactly(trade, { 12702, 860 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 14825)
            HQ = 1
        else
            npcUtil.giveItem(player, 12701)
        end

    -- Blessed Briault
    elseif npcUtil.tradeHasExactly(trade, { 822, 823, 823, 828, 828, 830, 1769, 1769 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 14438)
            HQ = 1
        else
            npcUtil.giveItem(player, 14436)
        end
    end

    if HQ == 1 then
        player:PrintToPlayer("Congratulations!! You've received an HQ item!", xi.msg.channel.SAY, npc:getName())
    else
        player:PrintToPlayer("Here is your item. Enjoy!", xi.msg.channel.SAY, npc:getName())
    end
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer("Need a weapon crafted? I can help you out with that.", xi.msg.channel.SAY, npc:getName())
    xi.shop.general(player, shopStock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
