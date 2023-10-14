-----------------------------------
-- Hypnic Lamp
-- Description: 16' AoE sleep
-- Note: Ability is only usable if Orobon have their lures
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 45))

    return xi.effect.SLEEP_I
end

return mobskillObject
