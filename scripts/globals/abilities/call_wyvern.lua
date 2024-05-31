-----------------------------------
-- Ability: Call Wyvern
-- Summons a Wyvern to fight by your side.
-- Obtained: Dragoon Level 1
-- Recast Time: 20:00
-- Duration: Instant
-- Special: Only available if Dragoon is your main class.
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- if
        -- player:getMainJob() ~= xi.job.DRG and
        -- player:getJobLvl(xi.job.DRG) < 75
    -- then
        -- player:PrintToPlayer("You haven't mastered this ability yet. Keep training.", xi.msg.channel.SYSTEM_3, "")
        -- return
    -- else
        return xi.job_utils.dragoon.abilityCheckCallWyvern(player, target, ability)
    -- end
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dragoon.useCallWyvern(player, target, ability)
end

return abilityObject
