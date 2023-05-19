-----------------------------------
-- Zone: Periqia
-----------------------------------
local ID = require('scripts/zones/Periqia/IDs')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1)
    zone:registerTriggerArea(2)
    zone:registerTriggerArea(3)
    zone:registerTriggerArea(5)
    zone:registerTriggerArea(5)
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
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function (x)
        end,
        [2] = function (x)
        end,
        [3] = function (x)
        end,
        [4] = function (x)
        end,
        [5] = function (x)
        end,
    }
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
