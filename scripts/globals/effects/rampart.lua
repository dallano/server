-----------------------------------
-- xi.effect.RAMPART
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEF, 23)
    target:addMod(xi.mod.DMG, -3500)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEF, 23)
    target:setMod(xi.mod.DMG, -3500)
end

return effectObject
