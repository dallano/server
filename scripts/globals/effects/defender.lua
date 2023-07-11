-----------------------------------
-- xi.effect.DEFENDER
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.DEFENDER_EFFECT)
    local spxiPower = target:getSkillLevel(xi.skill.SHIELD) * 0.25

    target:addMod(xi.mod.DEFP, 25 + spxiPower)
    target:addMod(xi.mod.RATTP, -25 + spxiPower)
    target:addMod(xi.mod.ATTP, -25 + spxiPower)

    -- JP Bonus
    target:addMod(xi.mod.DEF, jpLevel * 3)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.DEFENDER_EFFECT)
    local spxiPower = target:getSkillLevel(xi.skill.SHIELD) * 0.25

    target:delMod(xi.mod.DEF, jpLevel * 3)
    target:delMod(xi.mod.DEFP, 25 + spxiPower)
    target:delMod(xi.mod.ATTP, -25 + spxiPower)
    target:delMod(xi.mod.RATTP, -25 + spxiPower)
end

return effectObject
