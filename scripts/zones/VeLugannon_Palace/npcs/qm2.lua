-----------------------------------
-- Area: VeLugannon Palace
--  NPC: qm2 (???)
-- Note: Used to spawn Brigandish Blade
-- !pos 0.1 0.1 -286 177
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.CURTANA) and
        npcUtil.popFromQM(player, npc, ID.mob.BRIGANDISH_BLADE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    if GetServerVariable("[SPAWN]brigandishBlade") < os.time () then
        SetServerVariable("[SPAWN]brigandishBlade", os.time() + math.random(10800, 21600)) -- 3 to 6 hrs
        npcUtil.popFromQM(player, npc, ID.mob.BRIGANDISH_BLADE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
