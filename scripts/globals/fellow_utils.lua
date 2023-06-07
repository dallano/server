-----------------------------------
-- Fellow Utils (Used by fellows and scripts who trigger fellow related CSs)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.fellow_utils = {}

local fellowTypes =
{
    NONE     = 0,
    SHIELD   = 1,
    ATTACKER = 2,
    HEALER   = 3,
    STALWART = 4,
    FIERCE   = 5,
    SOOTHING = 6,
}

local fellowMessageOffsets =
{
    WS_READY         =   0,
    HP_LOW_NOTICE    =  15,
    MP_LOW_NOTICE    =  30,
    TIME_EXPIRED     =  75,
    LEAVE            =  90,
    PROVOKE          = 135,
    FIVE_MIN_WARNING = 165,
    WEAPONSKILL      = 211,
    WEAPONSKILL2     = 463,
}

-- spellid, lvl, mpcost
local cures =
{
    [1] = { xi.magic.spell.CURE_V,   61, 135 },
    [2] = { xi.magic.spell.CURE_IV,  41,  88 },
    [3] = { xi.magic.spell.CURE_III, 21,  46 },
    [4] = { xi.magic.spell.CURE_II,  11,  24 },
    [5] = { xi.magic.spell.CURE_I,    1,   8 },
}

local accuracy =
{ -- hpp, fellowType, accuracy(chance to use full pwr), validity(does this type cast at this hpp)
    [1] = { hpp = 30, job = { [3] = { 95,  true }, [4] = { 100, true }, [6] = { 100, true } } },
    [2] = { hpp = 50, job = { [3] = { 70,  true }, [4] = { 100, true }, [6] = { 90,  true } } },
    [3] = { hpp = 60, job = { [3] = { 50,  true }, [4] = { 100, true }, [6] = { 80,  true } } },
    [4] = { hpp = 70, job = { [3] = { 0,  false }, [4] = {  0, true  }, [6] = { 10,  true } } },
    [5] = { hpp = 80, job = { [3] = { 0,  false }, [4] = {  0, true  }, [6] = {  0,  true } } },
}

local weaponskills =
{
    [xi.skill.HAND_TO_HAND] =
    {
        [1] = { 1, false }, -- combo
        [2] = { 13, false }, -- shoulder tackle
        [3] = { 24, false }, -- one inch punch
        [4] = { 33, false }, -- backhand blow
        [5] = { 41, false }, -- raging fists
        [6] = { 49, true }, -- spinning attack
        [7] = { 60, false }, -- howling fist
        [8] = { 65, false }, -- dragon kick
    },
    [xi.skill.DAGGER] =
    {
        [16] = { 1, false }, -- wasp sting
        [17] = { 13, false }, -- gust slash
        [18] = { 23, false }, -- shadowstitch
        [19] = { 33, false }, -- viper bite
        [20] = { 41, true }, -- cyclone
        [21] = { 49, false }, -- energy steal
        [22] = { 55, false }, -- energy drain
        [23] = { 60, false }, -- dancing edge
        [24] = { 66, false }, -- shark bite
    },
    [xi.skill.SWORD] =
    {
        [32] = { 1, false }, -- fast blade
        [33] = { 9, false }, -- burning blade
        [34] = { 16, false }, -- red lotus blade
        [35] = { 24, false }, -- flat blade
        [36] = { 33, false }, -- shining blade
        [37] = { 41, false }, -- seraph blade
        [38] = { 49, true }, -- circle blade
        [39] = { 55, false }, -- spirits within
        [40] = { 60, false }, -- vorpal blade
        [41] = { 65, false }, -- swift blade
    },
    [xi.skill.GREAT_SWORD] =
    {
        [48] = { 1, false }, -- hard slash
        [49] = { 9, false }, -- power slash
        [50] = { 23, false }, -- frostbite
        [51] = { 33, false }, -- freezebite
        [52] = { 49, true }, -- shockwave
        [53] = { 55, false }, -- crescent moon
        [54] = { 60, false }, -- sickle moon
        [55] = { 65, false }, -- spinning slash
    },
    [xi.skill.AXE] =
    {
        [64] = { 1, false }, -- raging axe
        [65] = { 13, false }, -- smash axe
        [66] = { 23, false }, -- gale axe
        [67] = { 33, false }, -- avalanche axe
        [68] = { 49, false }, -- spinning axe
        [69] = { 55, false }, -- rampage
        [70] = { 60, false }, -- calamity
        [71] = { 66, false }, -- mistral axe
    },
    [xi.skill.GREAT_AXE] =
    {
        [80] = { 1, false }, -- shield break
        [81] = { 13, false }, -- iron tempest
        [82] = { 23, false }, -- sturmwind
        [83] = { 33, false }, -- armor break
        [84] = { 49, false }, -- keen edge
        [85] = { 55, false }, -- weapon break
        [86] = { 60, false }, -- raging rush
        [87] = { 65, false }, -- full break
    },
    [xi.skill.SCYTHE] =
    {
        [96] = { 1, false }, -- slice
        [97] = { 9, false }, -- dark harvest
        [98] = { 23, false }, -- shadow of death
        [99] = { 33, false }, -- nightmare scythe
        [100] = { 41, true }, -- spinning scythe
        [101] = { 49, false }, -- vorpal scythe
        [102] = { 60, false }, -- guillotine
        [103] = { 65, false }, -- cross reaper
    },
    [xi.skill.POLEARM] =
    {
        [112] = { 1, false }, -- double thrust
        [113] = { 9, false }, -- thunder thrust
        [114] = { 23, false }, -- raiden thrust
        [115] = { 33, false }, -- leg sweep
        [116] = { 49, false }, -- penta thrust
        [117] = { 55, false }, -- vorpal thrust
        [118] = { 60, false }, -- skewer
        [119] = { 65, false }, -- wheeling thrust
    },
    [xi.skill.KATANA] =
    {
        [128] = { 1, false }, -- blade: rin
        [129] = { 9, false }, -- blade: retsu
        [130] = { 23, false }, -- blade: teki
        [131] = { 33, false }, -- blade: to
        [132] = { 49, false }, -- blade: chi
        [133] = { 55, false }, -- blade: ei
        [134] = { 60, false }, -- blade: jin
        [135] = { 66, false }, -- blade: ten
    },
    [xi.skill.GREAT_KATANA] =
    {
        [144] = { 1, false }, -- tachi: enpi
        [145] = { 9, false }, -- tachi: hobaku
        [146] = { 23, false }, -- tachi: goten
        [147] = { 33, false }, -- tachi: kagero
        [148] = { 49, false }, -- tachi: jinpu
        [149] = { 55, false }, -- tachi: koki
        [150] = { 60, false }, -- tachi: yukikaze
        [151] = { 65, false }, -- tachi: gekko
    },
    [xi.skill.CLUB] =
    {
        [160] = { 1, false }, -- shining strike
        [161] = { 13, false }, -- seraph strike
        [162] = { 23, false }, -- brainshaker
        [163] = { 33, false }, -- starlight
        [164] = { 41, false }, -- moonlight
        [165] = { 49, false }, -- skullbreaker
        [166] = { 55, false }, -- true strike
        [167] = { 60, false }, -- judgment
        [168] = { 67, false }, -- hexa strike
    },
    [xi.skill.STAFF] =
    {
        [176] = { 1, false }, -- heavy swing
        [177] = { 13, false }, -- rock crusher
        [178] = { 23,  true }, -- earth crusher
        [179] = { 33, false }, -- starburst
        [180] = { 49, false }, -- sunburst
        [181] = { 55, false }, -- shell crusher
        [182] = { 60, false }, -- full swing
        [183] = { 63, false }, -- spirit taker
    },
}

xi.fellow_utils.onTrigger = function(player, fellow)
    local fellowChatGeneral = 1

    local ID            = require("scripts/zones/"..player:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(fellow)
    if personality > 5 then
        personality = personality - 1
    end

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        player:getCharVar("[Quest]Looking_Glass") == 3
    then
        player:setLocalVar("triggerFellow", 0)
        player:setCharVar("[Quest]Looking_Glass", 4)
        player:showText(fellow, ID.text.GIRL_BACK_TO_JEUNO + personality)
        player:timer(6000, function(playerArg)
            playerArg:despawnFellow()
        end)
    else
        player:triggerFellowChat(fellowChatGeneral)
    end
end

xi.fellow_utils.weaponskill = function(fellow, target, master)
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(fellow)
    local optionsMask   = master:getFellowValue("optionsMask")
    local wsReady       = fellow:getLocalVar("wsReady")
    local wsTime        = fellow:getLocalVar("wsTime")
    local fellowType    = master:getFellowValue("job")
    local fellowLvl     = fellow:getMainLvl()
    local wsSignals     = false
    local otherSignals  = false

    if bit.band(optionsMask, bit.lshift(1, 4)) == 16 then
        otherSignals = true
    end

    if bit.band(optionsMask, bit.lshift(1, 3)) == 8 then
        wsSignals = true
    end

    if
        (fellowType == fellowTypes.ATTACKER or
        fellowType == fellowTypes.FIERCE) and
        fellow:checkDistance(target) <= 5
    then
        if fellow:getTP() == 3000 then
            if
                xi.fellow_utils.checkWeaponSkill(fellow, target, fellowLvl) and
                otherSignals
            then
                master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
            end

        elseif fellow:getTP() > 1000 then
            if
                wsSignals and
                wsReady == 0 and
                master:getTP() < 1000 and
                master:getTP() > 500
            then
                master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WS_READY + personality)
                fellow:setLocalVar("wsReady", 1)

            elseif
                (fellowType == fellowTypes.ATTACKER and
                (master:getTP() > 1000 or
                master:getTP() < 500)) or
                (fellowType == fellowTypes.FIERCE and
                master:getTP() < 500)
            then
                if
                    xi.fellow_utils.checkWeaponSkill(fellow, target, fellowLvl) and
                    otherSignals
                then
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                end

            elseif
                fellowType == fellowTypes.FIERCE and
                master:getTP() > 1000 and
                wsReady == 0 and
                target:getHPP() > 15
            then
                master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL2 + personality)
                fellow:setLocalVar("wsTime", os.time() + 5)
                fellow:setLocalVar("wsReady", 1)

            elseif
                fellowType == fellowTypes.FIERCE and
                master:getTP() > 1000 and
                wsTime <= os.time()
            then
                if
                    xi.fellow_utils.checkWeaponSkill(fellow, target, fellowLvl) and
                    otherSignals
                then
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                end
            end
        end

    elseif fellow:getTP() > 1000 then
        if
            xi.fellow_utils.checkWeaponSkill(fellow, target, fellowLvl) and
            otherSignals
        then
            master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
        end
    end
end

xi.fellow_utils.checkWeaponSkill = function(fellow, target, fellowLvl)
    local master = fellow:getMaster()
    if master == nil then
        return false
    end

    local skill         = fellow:getWeaponSkillType(xi.slot.MAIN)
    local optionsMask   = master:getFellowValue("optionsMask")
    local randomWS      = {}
    local aoeEnabled    = false
    if bit.band(optionsMask, bit.lshift(1, 0)) == 1 then
        aoeEnabled = true
    end

    for i, ws in pairs(weaponskills[skill]) do
        if
            fellowLvl >= ws[1] and
            (aoeEnabled == ws[2] or
            not ws[2])
        then
            table.insert(randomWS, i)
        end
    end

    -- Building in a delay as on local this can be triggered fast enough that
    -- fellow:actionQueueEmpty() is false for 2-3 calls in a row, letting the fellow queue up to 3 ws
    -- Also accounting for disengage/re-engage
    local wsTime = fellow:getLocalVar("wsTime")
    if
        fellow:getBattleTime() > wsTime + 10 or
        wsTime > fellow:getBattleTime() + 30
    then
        fellow:setLocalVar("wsTime", 0)
    end

    if
        fellow:actionQueueEmpty() and
        fellow:getLocalVar("wsTime") == 0
    then
        fellow:setLocalVar("wsTime", fellow:getBattleTime())
        local ws = randomWS[math.random(#randomWS)]

        -- Starlight and Moonlight target the fellow
        if ws == 163 or ws == 164 then
            target = fellow
        end

        fellow:useMobAbility(ws, target)

        fellow:setLocalVar("wsReady", 0)
        return true
    end

    return false
end

xi.fellow_utils.checkProvoke = function(fellow, target, master)
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(fellow)
    local optionsMask   = master:getFellowValue("optionsMask")
    local provoke       = fellow:getLocalVar("provoke")
    local fellowType    = master:getFellowValue("job")
    local otherSignals  = false

    if bit.band(optionsMask, bit.lshift(1, 4)) == 16 then
        otherSignals = true
    end

    if master == nil then
        return false
    end

    if
        (fellowType == fellowTypes.SHIELD or
        fellowType == fellowTypes.STALWART or
        master:getHPP() < 25) and
        provoke < os.time() and
        otherSignals
    then
        if
            fellow:actionQueueEmpty() and
            (fellow:getHPP() > 25 or
            master:getHPP() < 10)
        then
            if target:isEngaged() then
                if target:getTarget():getID() ~= fellow:getID() then
                    fellow:useJobAbility(35, target)
                    fellow:setLocalVar("provoke", os.time() + math.random(30, 60))
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)
                end
            else -- edge case for independent fellow attacking (quest bcnms)
                fellow:useJobAbility(35, target)
                fellow:setLocalVar("provoke", os.time() + math.random(30, 60))
                master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)
            end
        end
    end

    return false
end

xi.fellow_utils.spellCheck = function(fellow, master)
    local castCool      = fellow:getLocalVar("castingCoolDown")
    local fellowType    = master:getFellowValue("job")
    local fellowLvl     = fellow:getMainLvl()
    local mp            = fellow:getMP()
    local mpp           = mp / fellow:getMaxMP() * 100
    local mpNotice      = fellow:getLocalVar("mpNotice")

    if castCool <= os.time() then
        if
            fellowType == fellowTypes.HEALER or
            fellowType == fellowTypes.SOOTHING
        then
            if
                math.random(10) < fellowType + 3 and
                xi.fellow_utils.checkCure(fellow, master, fellowLvl, mp, fellowType)
            then
                fellow:setLocalVar("castingCoolDown", os.time() + 5) -- Can recast cure much faster (spXI)
            elseif
                math.random(10) < fellowType + 1 and
                xi.fellow_utils.checkAilment(fellow, master, fellowLvl, mp)
            then
                fellow:setLocalVar("castingCoolDown", os.time() + math.random(15, 20))
            elseif
                math.random(10) < fellowType - 1 and
                xi.fellow_utils.checkBuff(fellow, master, fellowLvl, mp, fellowType)
            then
                fellow:setLocalVar("castingCoolDown", os.time() + math.random(15, 20))
            end
        end
    end

    if
        mpp < 50 and
        mpNotice == 0
    then
        fellow:setLocalVar("mpNotice", 1)
    end
end

xi.fellow_utils.checkCure = function(fellow, master, fellowLvl, mp, fellowType)
    if master == nil then
        return false
    end

    local cureSpell = 0

    for i, cure in ipairs(cures) do
        if
            fellowLvl >= cure[2] and
            mp >= cure[3]
        then
            cureSpell = cure[1]
            break
        end
    end

    if cureSpell > 0 then
        if fellowType == 3 then
            if
                xi.fellow_utils.doFellowCure(fellow, fellowType, cureSpell) or
                xi.fellow_utils.doMasterCure(fellow, master, fellowType, cureSpell)
            then
                return true
            end
        elseif fellowType == 4 then
            if xi.fellow_utils.doFellowCure(fellow, fellowType, cureSpell) then
                return true
            end
        elseif fellowType == 6 then
            if
                xi.fellow_utils.doMasterCure(fellow, master, cureSpell) or
                xi.fellow_utils.doFellowCure(fellow, fellowType, cureSpell)
            then
                return true
            end
        end
    end

    return false
end

xi.fellow_utils.doMasterCure = function(fellow, master, fellowType, cureSpell)
    for i, v in ipairs(accuracy) do
        if
            master:getHPP() <= v.hpp and
            v.job[fellowType][2]
        then
            if
                cureSpell > 1 and
                math.random(100) > v.job[fellowType][1]
            then
                fellow:castSpell(cureSpell -1, master)
                return true
            else
                fellow:castSpell(cureSpell, master)
                return true
            end
        end
    end
end

xi.fellow_utils.doFellowCure = function(fellow, fellowType, cureSpell)
    for i, v in ipairs(accuracy) do
        if
            fellow:getHPP() <= v.hpp and
            v.job[fellowType][2]
        then
            if
                cureSpell > 1 and
                math.random(100) > v.job[fellowType][1]
            then
                fellow:castSpell(cureSpell -1, fellow)
                return true
            else
                fellow:castSpell(cureSpell, fellow)
                return true
            end
        end
    end
end

xi.fellow_utils.checkAilment = function(fellow, master, fellowLvl, mp)
    if master == nil then
        return false
    end

    local ailments =
    {                                   -- spellid,         lvl, mpcost, selfcast
        [xi.effect.PETRIFICATION] = { xi.magic.spell.STONA,   40, 12, false },
        [xi.effect.BLINDNESS]     = { xi.magic.spell.BLINDNA, 14, 16,  true },
        [xi.effect.PARALYSIS]     = { xi.magic.spell.BLINDNA,  9, 12,  true },
        [xi.effect.CURSE_II]      = { xi.magic.spell.CURSNA,  29, 30,  true },
        [xi.effect.CURSE_I]       = { xi.magic.spell.CURSNA,  29, 30,  true },
        [xi.effect.DISEASE]       = { xi.magic.spell.VIRUNA , 34, 48,  true },
        [xi.effect.SILENCE]       = { xi.magic.spell.SILENA,  19, 24, false },
        [xi.effect.POISON]        = { xi.magic.spell.POISONA,  6,  8,  true },
        [xi.effect.ATTACK_DOWN]   = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.DEFENSE_DOWN]  = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.ACCURACY_DOWN] = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.WEIGHT]        = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.BIND]          = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.SLOW]          = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.DOOM]          = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.DIA]           = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.BIO]           = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.BURN]          = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.DROWN]         = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.CHOKE]         = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.RASP]          = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.FROST]         = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.SHOCK]         = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.REQUIEM]       = { xi.magic.spell.ERASE,   32, 18,  true }, -- (spXI)
        [xi.effect.SLEEP_I]       = { xi.magic.spell.CURE_I,   1,  8, false }, -- (spXI)
        [xi.effect.SLEEP_II]      = { xi.magic.spell.CURE_I,   1,  8, false }, -- (spXI)
        [xi.effect.LULLABY]       = { xi.magic.spell.CURE_I,   1,  8, false }, -- (spXI)
    }

    for status, spell in pairs(ailments) do
        if
            fellow:hasStatusEffect(status) and
            fellowLvl >= spell[2] and
            mp >= spell[3] and spell[4]
        then
            fellow:castSpell(spell[1], fellow)
            return true
        elseif
            master:hasStatusEffect(status) and
            fellowLvl >= spell[2] and
            mp >= spell[3]
        then
            fellow:castSpell(spell[1], master)
            return true
        end
    end

    return false
end

xi.fellow_utils.checkDebuff = function(fellow, target, master, fellowLvl, mp)
    if master == nil then
        return false
    end

    local dS = {}
    local dias =
    { -- spellid, lvl, mpcost
        [1] = { 24, 36, 30 }, -- dia II
        [2] = { 23,  3,  7 }, -- dia I
    }
    for i, dia in ipairs(dias) do
        if fellowLvl >= dia[2] then
            dS = dias[i]
            break
        end
    end

    local debuffs =
    {                       -- spellid, lvl, mpcost, priority, immunity
        [xi.effect.PARALYSIS] = {   58,     4,     6, 25,  32 },
        [xi.effect.SILENCE]   = {   59,    15,    16, 60,  16 },
        [xi.effect.SLOW]      = {   56,    13,    15, 25, 128 },
        [xi.effect.DIA]       = { dS[1], dS[2], dS[3], 75,   0 },
    }

    if not target:hasSpellList() then
        debuffs[xi.effect.SILENCE] = nil
    end

    for status, spell in pairs(debuffs) do
        if
            math.random(100) < spell[4] and
            not target:hasImmunity(spell[5])
        then
            if
                not target:hasStatusEffect(status) and
                fellowLvl >= spell[2] and
                mp >= spell[3]
            then
                fellow:castSpell(spell[1], target)
                return true
            end
        end
    end

    return false
end

xi.fellow_utils.checkBuff = function(fellow, master, fellowLvl, mp, fellowType)
    if master == nil then
        return false
    end

    local mpp = fellow:getMP() / fellow:getMaxMP() * 100
    local pS = {}
    local sS = {}
    local protects =
    { --                 spellid,             lvl, mpcost
        [1] = { xi.magic.spells.PROTECTRA_IV,  63, 65 },
        [2] = { xi.magic.spells.PROTECTRA_III, 47, 46 },
        [3] = { xi.magic.spells.PROTECTRA_II,  27, 28 },
        [4] = { xi.magic.spells.PROTECTRA_I,    7,  9 },
    }
    for i, protect in ipairs(protects) do
        if fellowLvl >= protect[2] then
            pS = protects[i]
            break
        end
    end

    local shells =
    { --                spellid,            lvl, mpcost
        [1] = { xi.magic.spells.SHELLRA_IV , 68, 75 },
        [2] = { xi.magic.spells.SHELLRA_III, 57, 56 },
        [3] = { xi.magic.spells.SHELLRA_II,  37, 37 },
        [4] = { xi.magic.spells.SHELLRA_I,   17, 18 },
    }
    for i, shell in ipairs(shells) do
        if fellowLvl >= shell[2] then
            sS = shells[i]
            break
        end
    end

    local buffs =
    {                        -- spellid, lvl, mpcost, canTarget, job, priority, cutoff
        [xi.effect.STONESKIN] = { 54,    28,    29,    false, job = { [3] = { 10, 0 }, [6] = { 20, 60 } } },
        [xi.effect.PROTECT]   = { pS[1], pS[2], pS[3],  true, job = { [3] = { 50, 0 }, [6] = { 50,  0 } } },
        [xi.effect.SHELL]     = { sS[1], sS[2], sS[3],  true, job = { [3] = { 50, 0 }, [6] = { 50,  0 } } },
        [xi.effect.BLINK]     = { 53,    19,    20,    false, job = { [3] = { 10, 0 }, [6] = { 20, 60 } } },
        [xi.effect.HASTE]     = { 57,    40,    40,     true, job = { [3] = { 65, 0 }, [6] = { 65, 30 } } },
    }

    if master:getFellowValue("job") == fellowTypes.SOOTHING then
        switch (master:getMainJob()) : caseof
        {
            [xi.job.WHM] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.BLM] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.RDM] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.BRD] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.RNG] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.SMN] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.COR] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.SCH] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,
        }
    end

    for status, spell in pairs(buffs) do
        if
            math.random(100) < spell.job[fellowType][1] and
            mpp > spell.job[fellowType][2]
        then
            if
                not fellow:hasStatusEffect(status) and
                fellowLvl >= spell[2] and mp >= spell[3]
            then
                fellow:castSpell(spell[1], fellow)
                return true
            end
        elseif
            math.random(100) < spell.job[fellowType][1] and
            mpp > spell.job[fellowType][2] and spell[4]
        then
            if
                not master:hasStatusEffect(status) and
                fellowLvl >= spell[2] and
                mp >= spell[3]
            then
                fellow:castSpell(spell[1], master)
                return true
            end
        end
    end

    return false
end

xi.fellow_utils.battleMessaging = function(fellow, master)
    local personality   = xi.fellow_utils.checkPersonality(fellow)
    local optionsMask   = master:getFellowValue("optionsMask")
    local hpWarning     = fellow:getLocalVar("hpWarning")
    local mpWarning     = fellow:getLocalVar("mpWarning")
    local mpNotice      = fellow:getLocalVar("mpNotice")
    local mp            = fellow:getMP()
    local mpp           = mp / fellow:getMaxMP() * 100
    local hpSignals     = false
    local mpSignals     = false

    if bit.band(optionsMask, bit.lshift(1, 2)) == 4 then
        mpSignals = true
    end

    if bit.band(optionsMask, bit.lshift(1, 1)) == 2 then
        hpSignals = true
    end

    if
        fellow:getHPP() <= 25 and
        hpWarning == 0 and
        hpSignals
    then
        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.HP_LOW_NOTICE + personality)
        fellow:setLocalVar("hpWarning", 1)
    elseif
        fellow:getHPP() > 25 and
        hpWarning ~= 0
    then
        fellow:setLocalVar("hpWarning", 0)
    elseif
        mpp <= 25 and
        mpWarning == 0 and
        mpSignals
    then
        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.MP_LOW_NOTICE + personality)
        fellow:setLocalVar("mpWarning", 1)
    elseif
        mpp > 25 and
        mpWarning ~= 0
    then
        fellow:setLocalVar("mpWarning", 0)
    end

    if
        mpp < 67 and
        mpNotice ~= 1
    then
        fellow:setLocalVar("mpNotice", 1)
    end
end

xi.fellow_utils.timeWarning = function(fellow, master)
    local master        = fellow:getMaster()
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(fellow)
    local maxTime       = master:getFellowValue("maxTime")
    local spawnTime     = master:getFellowValue("spawnTime")
    local timeWarning   = fellow:getLocalVar("timeWarning")
    if
        os.time() > spawnTime + maxTime - 300 and
        timeWarning == 0
    then
        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.FIVE_MIN_WARNING + personality)
        fellow:setLocalVar("timeWarning", 1)
    elseif
        os.time() > spawnTime + maxTime - 4 and
        timeWarning == 1
    then
        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.TIME_EXPIRED + personality)
        fellow:setLocalVar("timeWarning", 2)
    elseif
        os.time() > spawnTime + maxTime and
        timeWarning == 2
    then
        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.LEAVE + personality)
        fellow:setLocalVar("timeWarning", 3)
        master:despawnFellow()
    end
end

xi.fellow_utils.onDeath = function(fellow)
    local master = GetPlayerByID(fellow:getLocalVar("masterID"))

    if master ~= nil then
        local ID = require("scripts/zones/"..master:getZoneName().."/IDs")
        local bf = master:getBattlefield()

        if bf ~= nil then
            if bf:getID() == 37 then -- mirror mirror
                local players = bf:getPlayers()
                bf:lose()
                for i, player in pairs(players) do
                    if player:getFellow() ~= nil then
                        player:despawnFellow()
                    end

                    player:messageSpecial(ID.text.UNABLE_TO_PROTECT)
                end
            end
        end
    end
end

xi.fellow_utils.onDespawn = function(fellow)
    local master = GetPlayerByID(fellow:getLocalVar("masterID"))
    local zone = fellow:getZoneID()
    if
        master ~= nil and
        fellow:getCurrentRegion() < 19
    then
        if
            zone ~= 16 and
            zone ~= 18 and
            zone ~= 20
        then -- no gear adjust in promys
            local maxKills      = fellow:getLocalVar("maxKills")
            local zoneKills     = fellow:getLocalVar("zoneKills")
            local kills         = master:getFellowValue("kills")
            print("master: "..fellow:getLocalVar("masterID").." zoneKills: "..zoneKills.." total kills: "..kills)
            local armorLock     = master:getFellowValue("armorLock")
            local regionOwner        = GetRegionOwner(fellow:getCurrentRegion())
            local unlocked      = {}
            local armorTable    =
            {
                [1] = { "body" },
                [2] = { "hands" },
                [3] = { "legs" },
                [4] = { "feet" },
            }
            for i, v in ipairs(armorTable) do
                if bit.band(armorLock, bit.lshift(1, i)) == 0 then
                    table.insert(unlocked, v[1])
                end
            end

            local randomArmor   = unlocked[math.random(#unlocked)]
            if randomArmor ~= nil then -- if everything is locked - this has a bad time
                local armor =  master:getFellowValue(randomArmor)
                if zoneKills >= 15 then
                    if
                        maxKills == kills and
                        kills ~= 0
                    then
                        if regionOwner == math.floor(armor / 100) then
                            armor = armor + 1
                        else
                            armor = 0 + (regionOwner * 100)
                        end

                        if armor % 100 == 12 then
                            armor = 0 + (regionOwner * 100)
                        end
                    else
                        if regionOwner == math.floor(armor / 100) then
                            armor = (armor % 100) - 1
                            if armor < 0 then
                                armor = 0
                            end

                            armor = armor + (regionOwner * 100)
                        else
                            armor = 0 + (regionOwner * 100)
                        end
                    end
                end

                master:setFellowValue(randomArmor, armor)
            end
        end
    end
end

xi.fellow_utils.checkPersonality = function(fellow)
    local master = fellow:getMaster()
    if master == nil then
        return
    end

    local personality   = master:getFellowValue("personality")

    switch (personality) : caseof
    {
        [4]  = function(x)
            personality = 0
        end,

        [8]  = function(x)
            personality = 1
        end,

        [12] = function(x)
            personality = 2
        end,

        [16] = function(x)
            personality = 3
        end,

        [40] = function(x)
            personality = 4
        end,

        [44] = function(x)
            personality = 5
        end,

        [20] = function(x)
            personality = 7
        end,

        [24] = function(x)
            personality = 8
        end,

        [28] = function(x)
            personality = 9
        end,

        [32] = function(x)
            personality = 10
        end,

        [36] = function(x)
            personality = 11
        end,

        [48] = function(x)
            personality = 12
        end,
    }

    return personality
end

xi.fellow_utils.getStyleParam = function(player)
    local body       = player:getFellowValue("body")
    local hands      = player:getFellowValue("hands")
    local legs       = player:getFellowValue("legs")
    local feet       = player:getFellowValue("feet")
    local styleParam = bit.lshift(math.floor(feet / 100), 12) +
                        bit.lshift(math.floor(legs / 100) * 4, 8) +
                        bit.lshift(math.floor(hands / 100), 8) +
                        bit.lshift(math.floor(body / 100) * 4, 4)
    return styleParam
end

xi.fellow_utils.getLookParam = function(player)
    local body      = player:getFellowValue("body")
    local hands     = player:getFellowValue("hands")
    local legs      = player:getFellowValue("legs")
    local feet      = player:getFellowValue("feet")
    local lookParam = bit.lshift(feet % 100, 16) +
                        bit.lshift(legs % 100, 12) +
                        bit.lshift(hands % 100, 8) +
                        bit.lshift(body % 100, 4) +
                        player:getFellowValue("head")
    return lookParam
end

xi.fellow_utils.getFellowParam = function(player)
    local fellowParam = bit.lshift(player:getFellowValue("face"), 20) +
                        bit.lshift(player:getFellowValue("size"), 16) +
                        bit.lshift(player:getFellowValue("personality"), 8) +
                        player:getFellowValue("fellowid")
    return fellowParam
end
