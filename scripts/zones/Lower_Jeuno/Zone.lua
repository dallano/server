-----------------------------------
-- Zone: Lower_Jeuno (245)
-----------------------------------
local ID = require('scripts/zones/Lower_Jeuno/IDs')
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
require('scripts/globals/events/starlight_celebrations')
require("scripts/globals/teleports")
require('scripts/globals/conquest')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/pathfind')
require('scripts/globals/settings')
require('scripts/globals/chocobo')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 23, 0, -43, 44, 7, -39) -- Inside Tenshodo HQ. TODO: Find out if this is used other than in ZM 17 (not anymore). Remove if not.
    xi.chocobo.initZone(zone)

    -- Crag Tele NPCs
    local holly = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Holly",
        x        = -13.57,
        y        = 0.000,
        z        = 0.04,
        rotation = 45,
        look     = 1403,
        releaseIdOnDisappear = true,
        specialSpawnAnimation = true,
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, { { "gil", 1000 } }) then
                player:confirmTrade()
                npc:injectActionPacket(player:getID(), 4, 122, 0, 0, 0, 10, 1)
                player:PrintToPlayer("*gasp*", 0, "Holly")
                player:PrintToPlayer("You rock! I can finally afford that scroll I've been eyeing on the auction house.", 0, "Holly")

                npc:timer(3500, function(x)
                    xi.teleport.to(player, xi.teleport.id.HOLLA)
                end)
            end
        end,
        onTrigger = function(player, npc)
            player:PrintToPlayer("Hi! I'm Holly. Your local teleport gal!", 0, "Holly")
            player:PrintToPlayer("With a generous donation, I will teleport you straight to the crag of Holla!", 0, "Holly")
        end,
    })
    local dolly = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Dolly",
        x        = -15.75,
        y        = 0.000,
        z        = -0.22,
        rotation = 69,
        look     = 1404,
        releaseIdOnDisappear = true,
        specialSpawnAnimation = true,
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, { { "gil", 1000 } }) then
                player:confirmTrade()
                npc:injectActionPacket(player:getID(), 4, 122, 0, 0, 0, 10, 1)
                player:PrintToPlayer("Really?! You won't regret it. Up up and ~away!", 0, "Dolly")

                npc:timer(3500, function(x)
                    xi.teleport.to(player, xi.teleport.id.DEM)
                end)
            end
        end,
        onTrigger = function(player, npc)
            player:PrintToPlayer("~Hello! I'm Dolly. Another one of your local teleport gals!", 0, "Dolly")
            player:PrintToPlayer("With a boastful donation, I'd gladly teleport you to the Crag of Dem!", 0, "Dolly")
        end,
    })
    local molly = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Molly",
        x        = -11.73,
        y        = 0.000,
        z        = 1.78,
        rotation = 29,
        look     = 1405,
        releaseIdOnDisappear = true,
        specialSpawnAnimation = true,
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, { { "gil", 1000 } }) then
                player:confirmTrade()
                npc:injectActionPacket(player:getID(), 4, 122, 0, 0, 0, 10, 1)
                player:PrintToPlayer("tyvm", 0, "Molly")

                npc:timer(3500, function(x)
                    xi.teleport.to(player, xi.teleport.id.MEA)
                end)
            end
        end,
        onTrigger = function(player, npc)
            player:PrintToPlayer("(Teleport-Mea) (Do you need it?) 1k", 0, "Molly")
        end,
    })
    holly:setStatus(xi.status.NORMAL)
    molly:setStatus(xi.status.NORMAL)
    dolly:setStatus(xi.status.NORMAL)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))

    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:changeMusic(0, 239)
        player:changeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(41.2, -5, 84, 85)
    end

    xi.moghouse.exitJobChange(player, prevZone)

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.moghouse.afterZoneIn(player)
    xi.chocobo.confirmRentalAfterZoneIn(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vanadielHour = VanadielHour()
    local playerOnQuestId = GetServerVariable("[JEUNO]CommService")

    -- Community Service Quest
    -- 7AM: it's daytime. turn off all the lights
    if vanadielHour == 7 then
        for i = 0, 11 do
            local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
            lamp:setAnimation(xi.anim.CLOSE_DOOR)
        end

    -- 8PM: make quest available
    -- notify anyone in zone with membership card that zauko is recruiting
    elseif vanadielHour == 18 then
        SetServerVariable("[JEUNO]CommService", 0)
        local players = zone:getPlayers()
        for name, player in pairs(players) do
            if player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) then
                player:messageSpecial(ID.text.ZAUKO_IS_RECRUITING)
            end
        end

    -- 9PM: notify the person on the quest that they can begin lighting lamps
    elseif vanadielHour == 21 then
        local playerOnQuest = GetPlayerByID(GetServerVariable("[JEUNO]CommService"))
        if playerOnQuest then
            playerOnQuest:startEvent(114)
        end

    -- 1AM: if nobody has accepted the quest yet, NPC Vhana Ehgaklywha takes up the task
    -- she starts near Zauko and paths all the way to the Rolanberry exit.
    -- xi.path.flag.WALLHACK because she gets stuck on some terrain otherwise.
    elseif vanadielHour == 1 then
        if playerOnQuestId == 0 then
            local npc = GetNPCByID(ID.npc.VHANA_EHGAKLYWHA)
            local startPath = lowerJeunoGlobal.lampPath[1]
            npc:clearPath()
            npc:setStatus(0)
            npc:setLocalVar("path", 1)
            npc:initNpcAi()
            npc:setPos(xi.path.first(startPath))
            npc:pathThrough(startPath, bit.bor(xi.path.flag.COORDS, xi.path.flag.WALLHACK))
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

return zoneObject
