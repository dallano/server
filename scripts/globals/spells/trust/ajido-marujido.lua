-----------------------------------
-- Trust: Ajido-Marujido
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
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

    if master:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED then
        master:PrintToPlayer("Hm... Perhaps the 'seven colors' represents the cycles of the moon.", xi.msg.channel.PARTY, "Ajido-Marujido")
    else
        if math.random(1, 2) == 1 then
            master:PrintToPlayer("Oh, dear summoner! Wait until I tell you what I've learned from the Rhinostery.", xi.msg.channel.PARTY, "Ajido-Marujido")
        else
            master:PrintToPlayer("So very good to see you summoner. I've been lost to my studies as of late.", xi.msg.channel.PARTY, "Ajido-Marujido")
        end
    end

    mob:setAutoAttackEnabled(false)
    xi.autoparty.onTrustSpawn(mob)
end

spellObject.onMobRoam = function(mob)
end

spellObject.onMobFight = function(mob, target)
    xi.autoparty.onMageFight(mob, target)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
