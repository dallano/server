-----------------------------------
-- xi.effect.MADRIGAL
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()

    -- xiSP Bards receive increased effects from their songs
    if
        target:getMainJob() == xi.job.BRD and
        target:isPC()
    then
        power = power * 1.25
    end

    target:addMod(xi.mod.ACC, power)
    target:addMod(xi.mod.DEX, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()

    if
        target:getMainJob() == xi.job.BRD and
        target:isPC()
    then
        power = power * 1.25
    end

    target:delMod(xi.mod.ACC, power)
    target:delMod(xi.mod.DEX, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effectObject
