-----------------------------------
-- xi.effect.DEFENDER
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = 0

    if target:isPC() then
        power = target:getSkillLevel(xi.skill.SHIELD) * 0.25
        target:setCharVar("[DEFENDER]spxiPower", power)
    end

    target:addMod(xi.mod.DEFP, 25 + power)
    target:addMod(xi.mod.ENMITY, 5)
    target:addMod(xi.mod.RATTP, -25 - (power / 2))
    target:addMod(xi.mod.ATTP, -25 - power / 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = 0

    if target:isPC() then
        power = target:getCharVar("[DEFENDER]spxiPower")
    end

    target:delMod(xi.mod.DEFP, 25 + power)
    target:delMod(xi.mod.ENMITY, 5)
    target:delMod(xi.mod.ATTP, -25 - (power / 2))
    target:delMod(xi.mod.RATTP, -25 - (power / 2))
end

return effectObject
