-----------------------------------
-- Zone: Periqia
-----------------------------------
local ID = require('scripts/zones/Periqia/IDs')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Assault: "Saving Private Ryaaf" trigger areas
    zone:registerTriggerArea(1,   -70, 2, 588, 0, 0, 0) -- North
    zone:registerTriggerArea(2,   109, 2, 449, 0, 0, 0) -- East
    zone:registerTriggerArea(3, -46.8, 2, 295, 0, 0, 0) -- South
    zone:registerTriggerArea(4,  -229, 2, 448, 0, 0, 0) -- West
    zone:registerTriggerArea(5,   -70, 2, 412, 0, 0, 0) -- Center
    ------------------------------------------------
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 79)
        return cs
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 102 then
        local instance = player:getInstance()
        local chars = instance:getChars()
        for _, entity in pairs(chars) do
            entity:setPos(0, 0, 0, 0, xi.zone.CAEDARVA_MIRE)
        end
    end
end

zoneObject.onInstanceLoadFailed = function()
    return 79
end

return zoneObject
