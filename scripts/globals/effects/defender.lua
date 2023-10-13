-----------------------------------
-- xi.effect.DEFENDER
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local spxiPower = target:getSkillLevel(xi.skill.SHIELD) * 0.25

    target:addMod(xi.mod.DEFP, 25 + spxiPower)
    target:addMod(xi.mod.ENMITY, 5)
    target:addMod(xi.mod.RATTP, -25)
    target:addMod(xi.mod.ATTP, -25)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local spxiPower = target:getSkillLevel(xi.skill.SHIELD) * 0.25

    target:delMod(xi.mod.DEFP, 25 + spxiPower)
    target:delMod(xi.mod.ENMITY, 5)
    target:delMod(xi.mod.ATTP, -25 - (spxiPower / 2))
    target:delMod(xi.mod.RATTP, -25 - (spxiPower / 2))
end

return effectObject
