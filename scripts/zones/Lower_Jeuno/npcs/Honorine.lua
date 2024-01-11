-----------------------------------
-- Area: Lower Jeuno
--  NPC: Honorine
-----------------------------------
local entity = {}

local shopStock =
{
    12702, 32143, -- Tiger gloves
    12958, 29421, -- Tiger Ledelsens

}

entity.onTrade = function(player, npc, trade)
    local result   = math.random(1, 100)
    local hqChance = 5
    local HQ       = 0

    -- Dusk Gloves (Behemoth Hide + Tiger Gloves)
    if npcUtil.tradeHasExactly(trade, { 12702, 860 }) then
        if result < hqChance then
            npcUtil.giveItem(player, 14825)
            HQ = 1
        else
            npcUtil.giveItem(player, 12701)
        end

    -- Dusk Ledelsens
    elseif npcUtil.tradeHasExactly(trade, { 12958, 860 }) then
        if result < hqChance then
            npcUtil.giveItem(player, 14188)
            HQ = 1
        else
            npcUtil.giveItem(player, 12957)
        end
    end

    if HQ == 1 then
        player:PrintToPlayer("Congratulations!! You've received an HQ item!", xi.msg.channel.SAY, npc:getName())
    else
        player:PrintToPlayer("Here is your item. Enjoy!", xi.msg.channel.SAY, npc:getName())
    end

    player:confirmTrade()
end

entity.onTrigger = function(player, npc)
    xi.shop.general(player, shopStock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
