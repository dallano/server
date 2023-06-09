-----------------------------------
-- Area: Bastok Mines
--  NPC: Conrad
-- Outpost Teleporter NPC
-- !pos 94.457 -0.375 -66.161 234
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}
local teleporterEvent  = 581

entity.onTrigger = function(player, npc)
    local teleporterNation = player:getNation()
    xi.conquest.teleporterOnTrigger(player, teleporterNation, teleporterEvent)
end

entity.onEventUpdate = function(player, csid, option)
    xi.conquest.teleporterOnEventUpdate(player, csid, option, teleporterEvent)
end

entity.onEventFinish = function(player, csid, option)
    xi.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
end

return entity
