-----------------------------------
-- Spell: Stoneskin
-----------------------------------
-- http://wiki.ffxiclopedia.org/wiki/Stoneskin
-- Max 350 damage absorbed
-- (before cap bonus gear, with no settings.lua adjustment)
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:isMob() and target:hasStatusEffect(xi.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    local pMod = 0
    if caster:isPC() then
        local skill = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC)

        pMod = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC) / 2 + caster:getStat(xi.mod.MND) * 1.25
    else
        pMod = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC) / 3 + caster:getStat(xi.mod.MND)
    end
    local pAbs = 0
    local pEquipMods = caster:getMod(xi.mod.STONESKIN_BONUS_HP)
    if pMod < 80 then
        pAbs = pMod
    elseif pMod <= 130 then
        pAbs = 2 * pMod
    elseif pMod > 130 then
        pAbs = 3 * pMod
    end

    -- hard cap of 1000 from natural power
    -- pAbs = utils.clamp(1, xi.settings.main.STONESKIN_CAP) This just always sets it to 350, let's use the actual value, shall we?
    pAbs = utils.clamp(pAbs, 1, xi.settings.main.STONESKIN_CAP)

    local duration = xi.magic.calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = xi.magic.calculateDurationForLvl(duration, 28, target:getMainLvl())

    local final = pAbs + pEquipMods
    if target:addStatusEffect(xi.effect.STONESKIN, final, 0, duration, 0, 0, 4) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return spellObject
