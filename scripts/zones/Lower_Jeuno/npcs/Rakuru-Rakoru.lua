-----------------------------------
-- Area: Lower Jeuno
--  NPC: Honorine
-----------------------------------
local entity = {}

local shopStock =
{
    -- Beads
    1306, 95896, -- Dark Bead
    1305, 98178, -- Light Bead
    1299, 92533, -- Fire Bead
    1300, 84325, -- Ice Bead
    1301, 64762, -- Wind Bead
    1302, 75123, -- Earth Bead
    1303, 89652, -- Lightning Bead
    1304, 55389, -- Water Bead

    -- Staff
    719, 15462, -- Ebony Lumber
}

entity.onTrade = function(player, npc, trade)
    local result   = math.random(1, 100)
    local toughHqChance = 5
    local medHqChance = 10
    local easyHqChance = 25
    local HQ       = 0

    -- Iridal Staff
    if npcUtil.tradeHasExactly(trade, { 17559, 17557, 17545, 17547, 17549, 17551, 17553, 17555 }) then
        if result < easyHqChance then
            npcUtil.giveItem(player, 18633) -- Chatoyant
            HQ = 1
        else
            npcUtil.giveItem(player, 18632) -- Iridal
        end

    -- Dark Staff
    elseif npcUtil.tradeHasExactly(trade, { 1306, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17560)
            HQ = 1
        else
            npcUtil.giveItem(player, 17559)
        end

    -- Light Staff
    elseif npcUtil.tradeHasExactly(trade, { 1305, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17558)
            HQ = 1
        else
            npcUtil.giveItem(player, 17557)
        end

    -- Fire Staff
    elseif npcUtil.tradeHasExactly(trade, { 1299, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17546)
            HQ = 1
        else
            npcUtil.giveItem(player, 17545)
        end

    -- Ice Staff
    elseif npcUtil.tradeHasExactly(trade, { 1300, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17548)
            HQ = 1
        else
            npcUtil.giveItem(player, 17547)
        end

    -- Wind Staff
    elseif npcUtil.tradeHasExactly(trade, { 1301, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17550)
            HQ = 1
        else
            npcUtil.giveItem(player, 17549)
        end

    -- Earth Staff
    elseif npcUtil.tradeHasExactly(trade, { 1302, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17552)
            HQ = 1
        else
            npcUtil.giveItem(player, 17551)
        end

    -- Thunder Staff
    elseif npcUtil.tradeHasExactly(trade, { 1303, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17554)
            HQ = 1
        else
            npcUtil.giveItem(player, 17553)
        end

    -- Water Staff
    elseif npcUtil.tradeHasExactly(trade, { 1304, 719 }) then
        if result < medHqChance then
            npcUtil.giveItem(player, 17556)
            HQ = 1
        else
            npcUtil.giveItem(player, 17555)
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
    player:PrintToPlayer("Welcome to the elemental ore services.",xi.msg.channel.SAY, npc:getName())
    xi.shop.general(player, shopStock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
