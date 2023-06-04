-----------------------------------------
-- ID: 14810
-- Item: Signal Pearl
-- Calls forth an adventuring fellow
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if
        target:getFellow() ~= nil or
        xi.settings.main.ENABLE_ADVENTURING_FELLOWS == nil or
        not xi.settings.main.ENABLE_ADVENTURING_FELLOWS
    then
            return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if not target:canUseMisc(xi.zoneMisc.FELLOW) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:spawnFellow(target:getFellowValue("fellowid"))
    target:setFellowValue("bond", target:getFellowValue("bond") + 1)
end

return itemObject
