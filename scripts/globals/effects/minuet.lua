-----------------------------------
-- xi.effect.MINUET
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()

    -- xiSP Bards receive increased effects from their songs
    if
        target:getMainJob() == xi.job.BRD and
        target:isPC()
    then
        power = power * 1.5
    end

    target:addMod(xi.mod.ATT, power)
    target:addMod(xi.mod.RATT, power)
    target:addMod(xi.mod.STR, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()

    if
        target:getMainJob() == xi.job.BRD and
        target:isPC()
    then
        power = power * 1.5
    end

    target:delMod(xi.mod.ATT, power)
    target:delMod(xi.mod.RATT, power)
    target:delMod(xi.mod.STR, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effectObject
