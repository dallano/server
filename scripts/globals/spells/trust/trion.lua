-----------------------------------
-- Trust: Trion
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    local player = mob:getMaster()
    local power  = 0

    xi.autoparty.onTankSpawn(mob, power)
end

spellObject.onMobRoam = function(mob)
    xi.autoparty.onTankRoam(mob)
end

spellObject.onMobFight = function(mob, target)
    xi.autoparty.onTankFight(mob, target)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
