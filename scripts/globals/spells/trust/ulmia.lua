-----------------------------------
-- Trust: Ulmia
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    local master = mob:getMaster()

    -- Dialogue
    -- Complete CoP 2-4 An Eternal Memory
    if master:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY) then
        master:PrintToPlayer("I wish to aid you in your endeavors, adventurer.", xi.msg.channel.PARTY, "Ulmia")
    end

    mob:setAutoAttackEnabled(false)
    xi.autoparty.onTrustSpawn(mob)
end

spellObject.onMobRoam = function(mob)
    xi.autoparty.onBardRoam(mob)
end

spellObject.onMobFight = function(mob, target)
    xi.autoparty.onBardFight(mob, target)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
