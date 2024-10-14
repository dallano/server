-----------------------------------
-- Mortal Ray
--
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local targetType = target:getObjType()

    -- Spell fails 75% of the time against fellows and trusts
    if targetType == xi.objType.FELLOW or targetType == xi.objType.TRUST then
        if math.random(0, 100) > 25 then
            return xi.msg.basic.SKILL_MISS
        end
    end
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end

return mobskillObject
