-----------------------------------
-- Trust: Rahal
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
    local player = mob:getMaster()
    local power  = 0
    player:PrintToPlayer("I've come to aid you, sir dragoon.", xi.msg.channel.PARTY, "Rahal")

    xi.autoparty.onTankSpawn(mob, power)
end

spellObject.onMobRoam = function(mob)
    xi.autoparty.onTankRoam(mob)
end

spellObject.onMobFight = function(mob, target)
    xi.autoparty.onTankFight(mob, target)
end

spellObject.onMobDespawn = function(mob)
end

spellObject.onMobDeath = function(mob)
    local player = mob:getMaster()
    player:PrintToPlayer("Please... Don't give up on your wyvern. Do not let it turn to evil!", xi.msg.channel.PARTY, "Rahal")
end

return spellObject
