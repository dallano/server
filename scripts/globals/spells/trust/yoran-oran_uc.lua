-----------------------------------
-- Trust: Yoran-Oran UC
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
    player:PrintToPlayer("Let's bust some Mandi-wandies!", xi.msg.channel.PARTY, "Yoran-Oran")
    mob:setAutoAttackEnabled(false)
    xi.autoparty.onTrustSpawn(mob)
end

spellObject.onMobRoam = function(mob)
    xi.autoparty.onHealerRoam(mob)
end

spellObject.onMobFight = function(mob, target)
    xi.autoparty.onHealerFight(mob, target)
end

spellObject.onMobDeath = function(mob)
    local player = mob:getMaster()
    player:PrintToPlayer("Owie... I'm heading back to my manor...", xi.msg.channel.PARTY, "Yoran-Oran")
end

spellObject.onMobDespawn = function(mob)
end

return spellObject
