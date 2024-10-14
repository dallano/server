-----------------------------------
-- Area: Lower Jeuno
--  NPC: Honorine
-----------------------------------
local entity = {}

local shopStock =
{
    -- Leathercraft
    12702, 32143, -- Tiger gloves
    12958, 29421, -- Tiger Ledelsens
    855, 5326,    -- Tiger Leather

    -- Bonecraft
    896, 2436,    -- Scorpion Shell
    1163, 8965,   -- Manticore Hair

    -- Clothcraft
    834, 243,     -- Saruta Cotton
    822, 1413,    -- Silver Thread
    829, 3152,    -- Silk Cloth
    828, 4253,    -- Velvet Cloth
    823, 5103,    -- Gold Thread
    2287, 13578,  -- Karakul Thread
    830, 14658,   -- Rainbow Cloth

    -- Smithing
    654, 12546,  -- Darksteel Ingot

    -- Woodworking
    717, 6600,  -- Mahogany Lumber
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

    -- Dusk Ledelsens (Behemoth Hide)
    elseif npcUtil.tradeHasExactly(trade, { 12958, 860 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 14188)
            HQ = 1
        else
            npcUtil.giveItem(player, 12957)
        end

    -- Blessed Briault
    elseif npcUtil.tradeHasExactly(trade, { 822, 823, 823, 828, 828, 830, 1769, 1769 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 14438)
            HQ = 1
        else
            npcUtil.giveItem(player, 14436)
        end

    -- Blessed Mitts
    elseif npcUtil.tradeHasExactly(trade, { 823, 823, 828, 834, 1769 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 14877)
            HQ = 1
        else
            npcUtil.giveItem(player, 14875)
        end

    -- Blessed Trousers
    elseif npcUtil.tradeHasExactly(trade, { 823, 823, 828, 830, 1769 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 15393)
            HQ = 1
        else
            npcUtil.giveItem(player, 15391)
        end

    -- Blessed Pumps
    elseif npcUtil.tradeHasExactly(trade, { 1163, 823, 828, 1767, 855 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 15329)
            HQ = 1
        else
            npcUtil.giveItem(player, 15331)
        end

    -- Vermillion Cloak
    elseif npcUtil.tradeHasExactly(trade, { 836, 836, 836, 823, 823, 829, 828, 828 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 13749)
            HQ = 1
        else
            npcUtil.giveItem(player, 13748)
        end

    -- Scorpion Harness
    elseif npcUtil.tradeHasExactly(trade, { 896, 896, 851, 851, 901 }) then
        if result < easyHqChance then
            npcUtil.giveItem(player, 13734)
            HQ = 1
        else
            npcUtil.giveItem(player, 12579)
        end

    -- Cerberus Mantle
    elseif npcUtil.tradeHasExactly(trade, { 2169, 2287 }) then
        if result < toughHqChance then
            npcUtil.giveItem(player, 16216)
            HQ = 1
        else
            npcUtil.giveItem(player, 16212)
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
