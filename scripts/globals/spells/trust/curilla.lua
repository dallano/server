-----------------------------------
-- Trust: Curilla
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
    player:PrintToPlayer("Citizen of San d'Oria, I am here to protect you.", xi.msg.channel.PARTY, "Curilla")

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
    player:PrintToPlayer("I must retreat for now.", xi.msg.channel.PARTY, "Curilla")
end

return spellObject
