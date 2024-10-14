-----------------------------------
-- Trust: Pieuje UC
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
    mob:addMod(xi.mod.MP, mob:getMainLvl() * 4) -- Fix terrible elvaan MP

    player:PrintToPlayer("Dear white mage, I have answered your call.", xi.msg.channel.PARTY, "Pieuje")
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
    player:PrintToPlayer("I have matters to deal with in my nation. Please, excuse me.", xi.msg.channel.PARTY, "Pieuje")
end

spellObject.onMobDespawn = function(mob)
end

return spellObject