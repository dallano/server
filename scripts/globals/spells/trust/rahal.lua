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
    player:PrintToPlayer("I've come to aid you, sir dragoon.", xi.msg.channel.PARTY, "Rahal")

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.FLASH,
                        ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75,
                        ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)
end

spellObject.onMobRoam = function(mob)
end

spellObject.onMobFight = function(mob, target)
end

spellObject.onMobDespawn = function(mob)
end

spellObject.onMobDeath = function(mob)
    local player = mob:getMaster()
    player:PrintToPlayer("Please... Don't give up on your wyvern. Do not let it turn to evil!", xi.msg.channel.PARTY, "Rahal")
end

return spellObject
