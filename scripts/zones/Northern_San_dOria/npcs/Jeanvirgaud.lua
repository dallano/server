-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Jeanvirgaud
-- Outpost Teleporter NPC
-- !pos 111 -0.199 -6 231
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local teleporterEvent  = 716

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
