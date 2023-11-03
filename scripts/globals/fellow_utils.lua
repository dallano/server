-----------------------------------
-- Fellow Utils (Used by fellows and scripts who trigger fellow related CSs)
-----------------------------------
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

local tankJobAbilityTable =
{
    { ability = xi.jobAbility.RAMPART,     level = 62, recast = 180,  hppThreshold = 45,  isValid = true,  self = true,  recastVar = "[FELLOW]rampartRecast"    },
    { ability = xi.jobAbility.SENTINEL,    level = 30, recast = 300,  hppThreshold = 60,  isValid = true,  self = true,  recastVar = "[FELLOW]sentinelRecast"   },
    { ability = xi.jobAbility.DEFENDER,    level = 25, recast = 180,  hppThreshold = 100, isValid = true,  self = true,  recastVar = "[FELLOW]defenderRecast"   },
    { ability = xi.jobAbility.SHIELD_BASH, level = 15, recast = 300,  hppThreshold = 100, isValid = false, self = false, recastVar = "[FELLOW]shieldBashRecast" },
    -- { ability = xi.jobAbility.HOLY_CIRCLE, level = 5,  recast = 300,  hppThreshold = 100, isValid = false, self = true,  recastVar = "[FELLOW]holyCircleRecast" },
    { ability = xi.jobAbility.INVINCIBLE,  level = 1,  recast = 7200, hppThreshold = 25,  isValid = true,  self = true,  recastVar = "[FELLOW]twoHourRecast"    },
}

local meleeJobAbilityTable =
{
    { ability = xi.jobAbility.BERSERK,      level = 15, recast = 380,  hppThreshold = 100, isValid = true, self = true,  recastVar = "[FELLOW]berserkRecast" },
    { ability = xi.jobAbility.BLOOD_WEAPON, level = 1,  recast = 7200, hppThreshold = 45,  isValid = true, self = true,  recastVar = "[FELLOW]twoHourRecast" },
    { ability = xi.jobAbility.AGGRESSOR,    level = 45, recast = 300,  hppThreshold = 100, isValid = true, self = true,  recastVar = "[FELLOW]agressorRecast" },
}

local mageJobAbilityTable =
{
    { ability = xi.jobAbility.COMPOSURE,   level = 50, recast = 350,  hppThreshold = 100, isValid = true,  recastVar = "[FELLOW]composureRecast" },
    { ability = xi.jobAbility.CONVERT,     level = 40, recast = 600,  hppThreshold = 100, isValid = false, recastVar = "[FELLOW]convertRecast"   },
    { ability = xi.jobAbility.BENEDICTION, level = 1,  recast = 7200, hppThreshold = 25,  isValid = true,  recastVar = "[FELLOW]twoHourRecast"   },
}

local regenTable =
{
    { effect = xi.effect.REGEN, spell = xi.magic.spell.REGEN_III, level = 66, mpCost = 64 },
    { effect = xi.effect.REGEN, spell = xi.magic.spell.REGEN_II,  level = 44, mpCost = 36 },
    { effect = xi.effect.REGEN, spell = xi.magic.spell.REGEN,     level = 21, mpCost = 15 },
}

local cureTable =
{
    { spell = xi.magic.spell.CURE_V,   level = 61, mpCost = 135, hpThreshold = 500 },
    { spell = xi.magic.spell.CURE_IV,  level = 41, mpCost =  88, hpThreshold = 350 },
    { spell = xi.magic.spell.CURE_III, level = 21, mpCost =  46, hpThreshold = 180 },
    { spell = xi.magic.spell.CURE_II,  level = 11, mpCost =  24, hpThreshold = 120 },
    { spell = xi.magic.spell.CURE,     level =  1, mpCost =   8, hpThreshold = 45  },
}

local debuffTable =
{
    { effect = xi.effect.SILENCE,   spell = xi.magic.spell.SILENCE,  level = 15, mpCost = 16, immunity = xi.immunity.SILENCE,  check = false },
    { effect = xi.effect.DIA,       spell = xi.magic.spell.DIA_II,   level = 36, mpCost = 30, immunity = xi.immunity.NONE,     check = true },
    { effect = xi.effect.DIA,       spell = xi.magic.spell.DIA,      level =  3, mpCost =  7, immunity = xi.immunity.NONE,     check = true },
    { effect = xi.effect.PARALYSIS, spell = xi.magic.spell.PARALYZE, level =  4, mpCost =  6, immunity = xi.immunity.PARALYZE, check = true },
    { effect = xi.effect.SLOW,      spell = xi.magic.spell.SLOW,     level = 13, mpCost = 15, immunity = xi.immunity.SLOW,     check = true },
}

local buffTable =
{
    { effect = xi.effect.REFRESH,   spell = xi.magic.spell.REFRESH,       level = 41, mpCost = 40, targetOther = true  },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_IV,  level = 68, mpCost = 65, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_III, level = 47, mpCost = 46, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_II,  level = 27, mpCost = 28, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA,     level =  7, mpCost =  9, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_IV,    level = 68, mpCost = 75, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_III,   level = 57, mpCost = 56, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_II,    level = 37, mpCost = 37, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA,       level = 17, mpCost = 18, targetOther = false },
    { effect = xi.effect.HASTE,     spell = xi.magic.spell.HASTE,         level = 40, mpCost = 40, targetOther = true  },
    { effect = xi.effect.STONESKIN, spell = xi.magic.spell.STONESKIN,     level = 28, mpCost = 29, targetOther = false },
    { effect = xi.effect.BLINK,     spell = xi.magic.spell.BLINK,         level = 19, mpCost = 20, targetOther = false },
}

local ailmentTable =
{
    { effect = xi.effect.DOOM,          spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.SLEEP_I,       spell = xi.magic.spell.CURE_I,   level =  1, mpCost =  8, selfTarget = false },
    { effect = xi.effect.SLEEP_II,      spell = xi.magic.spell.CURE_I,   level =  1, mpCost =  8, selfTarget = false },
    { effect = xi.effect.LULLABY,       spell = xi.magic.spell.CURE_I,   level =  1, mpCost =  8, selfTarget = false },
    { effect = xi.effect.PETRIFICATION, spell = xi.magic.spell.STONA,    level = 40, mpCost = 12, selfTarget = false },
    { effect = xi.effect.CURSE_II,      spell = xi.magic.spell.CURSNA,   level = 29, mpCost = 30, selfTarget =  true },
    { effect = xi.effect.CURSE_I,       spell = xi.magic.spell.CURSNA,   level = 29, mpCost = 30, selfTarget =  true },
    { effect = xi.effect.SILENCE,       spell = xi.magic.spell.SILENA,   level = 19, mpCost = 24, selfTarget = false },
    { effect = xi.effect.BIND,          spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.PARALYSIS,     spell = xi.magic.spell.PARALYNA, level =  9, mpCost = 12, selfTarget =  true },
    { effect = xi.effect.BLINDNESS,     spell = xi.magic.spell.BLINDNA,  level = 14, mpCost = 16, selfTarget =  true },
    { effect = xi.effect.POISON,        spell = xi.magic.spell.POISONA,  level =  6, mpCost =  8, selfTarget =  true },
    { effect = xi.effect.ATTACK_DOWN,   spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.DEFENSE_DOWN,  spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.ACCURACY_DOWN, spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.WEIGHT,        spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.SLOW,          spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.DIA,           spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.BIO,           spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.BURN,          spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.DROWN,         spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.CHOKE,         spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.RASP,          spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.FROST,         spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.SHOCK,         spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.REQUIEM,       spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.ELEGY,         spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.DISEASE,       spell = xi.magic.spell.VIRUNA ,  level = 34, mpCost = 48, selfTarget =  true },
}

local weaponskills =
{
    [xi.skill.HAND_TO_HAND] =
    {
        { id = 8, level = 65, }, -- dragon kick
        { id = 7, level = 60, }, -- howling fist
        { id = 5, level = 41, }, -- raging fists
        { id = 1, level = 1,  }, -- combo
        -- [2] = { 13, false }, -- shoulder tackle
        -- [3] = { 24, false }, -- one inch punch
        -- [4] = { 33, false }, -- backhand blow
        -- [6] = { 49, true  }, -- spinning attack
    },
    [xi.skill.DAGGER] =
    {
        { id = 24, level = 66, }, -- shark bite
        { id = 23, level = 60, }, -- dancing edge
        { id = 19, level = 33, }, -- viper bite
        { id = 16, level = 1,  }, -- wasp sting
        -- [17] = { 13, false }, -- gust slash
        -- [18] = { 23, false }, -- shadowstitch
        -- [20] = { 41, true  }, -- cyclone
        -- [21] = { 49, false }, -- energy steal
        -- [22] = { 55, false }, -- energy drain
    },
    [xi.skill.SWORD] =
    {
        { id = 41, level = 65, }, -- swift blade
        { id = 40, level = 60, }, -- vorpal blade
        { id = 34, level = 16, }, -- red lotus blade
        { id = 32, level = 1,  }, -- fast blade
        -- [38] = { 49, true  },  -- circle blade
        -- [33] = { 9,  false }, -- burning blade
        -- [35] = { 24, false }, -- flat blade
        -- [36] = { 33, false }, -- shining blade
        -- [37] = { 41, false }, -- seraph blade
        -- [39] = { 55, false }, -- spirits within
    },
    [xi.skill.GREAT_SWORD] =
    {
        { id = 55, level = 65, }, -- spinning slash
        { id = 53, level = 55, }, -- crescent moon
        { id = 51, level = 33, }, -- freezebite
        { id = 48, level = 1,  }, -- hard slash
        -- [49] = { 9,  false }, -- power slash
        -- [50] = { 23, false }, -- frostbite
        -- [52] = { 49,  true }, -- shockwave
        -- [54] = { 60, false }, -- sickle moon
    },
    [xi.skill.AXE] =
    {
        { id = 71, level = 66, }, -- mistral axe
        { id = 69, level = 55, }, -- rampage
        { id = 67, level = 33, }, -- avalanche axe
        { id = 64, level = 1,  }, -- raging axe
        -- [65] = { 13, false }, -- smash axe
        -- [66] = { 23, false }, -- gale axe
        -- [68] = { 49, false }, -- spinning axe
        -- [70] = { 60, false }, -- calamity
    },
    [xi.skill.GREAT_AXE] =
    {
        { id = 87, level = 65, }, -- full break
        { id = 86, level = 60, }, -- raging rush
        { id = 83, level = 33, }, -- armor break
        { id = 82, level = 23, }, -- sturmwind
        { id = 80, level = 1,  }, -- shield break
        -- [81] = { 13, false }, -- iron tempest
        -- [84] = { 49, false }, -- keen edge
        -- [85] = { 55, false }, -- weapon break
    },
    [xi.skill.SCYTHE] =
    {
        { id = 103, level = 65, }, -- cross reaper
        { id = 102, level = 60, }, -- guillotine
        { id = 99,  level = 33, }, -- nightmare scythe
        { id = 96,  level = 1,  }, -- slice
        -- [98]  = { 23, false }, -- shadow of death
        -- [97]  = { 9,  false }, -- dark harvest
        -- [100] = { 41,  true }, -- spinning scythe
        -- [101] = { 49, false }, -- vorpal scythe
    },
    [xi.skill.POLEARM] =
    {
        { id = 119, level = 65, }, -- wheeling thrust
        { id = 116, level = 49, }, -- penta thrust
        { id = 114, level = 23, }, -- raiden thrust
        { id = 112, level = 1,  }, -- double thrust
        -- [113] = { 9,  false }, -- thunder thrust
        -- [115] = { 33, false }, -- leg sweep
        -- [117] = { 55, false }, -- vorpal thrust
        -- [118] = { 60, false }, -- skewer
    },
    [xi.skill.KATANA] =
    {
        { id = 135, level = 66, }, -- blade: ten
        { id = 134, level = 60, }, -- blade: jin
        { id = 133, level = 55, }, -- blade: ei
        { id = 132, level = 49, }, -- blade: chi
        { id = 131, level = 33, }, -- blade: to
        { id = 130, level = 23, }, -- blade: teki
        { id = 129, level = 9,  }, -- blade: retsu
        { id = 128, level = 1,  }, -- blade: rin
    },
    [xi.skill.GREAT_KATANA] =
    {
        { id = 151, level = 65, }, -- tachi: gekko
        { id = 150, level = 60, }, -- tachi: yukikaze
        { id = 149, level = 55, }, -- tachi: koki
        { id = 148, level = 49, }, -- tachi: jinpu
        { id = 147, level = 33, }, -- tachi: kagero
        { id = 146, level = 23, }, -- tachi: goten
        { id = 145, level = 9,  }, -- tachi: hobaku
        { id = 144, level = 1,  }, -- tachi: enpi
    },
    [xi.skill.CLUB] =
    {
        { id = 168, level = 67, }, -- hexa strike
        { id = 167, level = 60, }, -- judgment
        { id = 164, level = 41, }, -- moonlight
        { id = 163, level = 33, }, -- starlight
        { id = 160, level = 1,  }, -- shining strike
        -- [161] = { 13, false }, -- seraph strike
        -- [162] = { 23, false }, -- brainshaker
        -- [165] = { 49, false }, -- skullbreaker
        -- [166] = { 55, false }, -- true strike
    },
    [xi.skill.STAFF] =
    {
        { id = 183, level = 63, }, -- spirit taker
        { id = 182, level = 60, }, -- full swing
        { id = 181, level = 55, }, -- shell crusher
        { id = 180, level = 49, }, -- sunburst
        { id = 179, level = 33, }, -- starburst
        { id = 178, level = 23, }, -- earth crusher
        { id = 177, level = 13, }, -- rock crusher
        { id = 176, level = 1,  }, -- heavy swing
    },
}

local armorIndex =
{
    { 75, 11 },
    { 70, 10 },
    { 65, 9  },
    { 60, 8  },
    { 55, 7  },
    { 50, 6  },
    { 45, 5  },
    { 40, 4  },
    { 35, 3  },
    { 30, 2  },
    { 25, 1  },
}

xi.fellow_utils.onFellowSpawn = function(fellow)
    local master        = fellow:getMaster()
    local fellowType    = master:getFellowValue("job")
    local wepBonus      = master:getFellowValue("weaponlvl") * 5
    local lvl           = fellow:getMainLvl()
    fellow:setLocalVar("masterID", master:getID())
    fellow:setLocalVar("castingCoolDown", os.time() + 15)
    master:setLocalVar("chatCounter", 0)
    master:setFellowValue("spawnTime", os.time())

    -- Adjust Position
    local mPos = master:getPos()
    fellow:setPos(mPos.x + math.random(-1.0, 1.0), mPos.y, mPos.z + math.random(-1.0, 1.0))

    if fellowType == fellowTypes.ATTACKER then
        fellow:addMobMod(xi.mobMod.WEAPON_BONUS, fellow:getMainLvl())
        fellow:setMod(xi.mod.ATTP, 50 + lvl * 0.75 + wepBonus)
        fellow:setMod(xi.mod.ATT, lvl + wepBonus)
        fellow:addMod(xi.mod.ACC, lvl + 125 + wepBonus)
        fellow:addMod(xi.mod.HASTE_GEAR, 100)
        fellow:addMod(xi.mod.STR, lvl * 0.25)
        fellow:addMod(xi.mod.DEX, lvl * 0.25)

    elseif fellowType == fellowTypes.FIERCE then
        fellow:addMobMod(xi.mobMod.WEAPON_BONUS, fellow:getMainLvl() * 1.15)
        fellow:addMod(xi.mod.ATTP, 75 + lvl * 1.25 + wepBonus)
        fellow:addMod(xi.mod.ATT, lvl * 1.25 + wepBonus)
        fellow:addMod(xi.mod.ACC, lvl + 150 + wepBonus)
        fellow:addMod(xi.mod.DOUBLE_ATTACK, 10)
        fellow:addMod(xi.mod.HASTE_GEAR, 1500)
        fellow:addMod(xi.mod.STR, lvl * 0.5)
        fellow:addMod(xi.mod.DEX, lvl * 0.5)
        fellow:addMod(xi.mod.STORETP, 15)
        fellow:addMod(xi.mod.GKATANA, 15)
        fellow:addMod(xi.mod.POLEARM, 15)
        fellow:addMod(xi.mod.GSWORD,  15)
        fellow:addMod(xi.mod.SCYTHE,  15)
        fellow:addMod(xi.mod.KATANA,  15)
        fellow:addMod(xi.mod.GAXE,    15)
        fellow:addMod(xi.mod.AXE,     15)
        fellow:addMod(xi.mod.HTH,     15)
        fellow:addMod(xi.mod.PARRY,    5)

    elseif fellowType == fellowTypes.SHIELD then
        fellow:addMod(xi.mod.SPELLINTERRUPT, 50)
        fellow:addMod(xi.mod.ATT, wepBonus)
        fellow:addMod(xi.mod.ACC, wepBonus)
        fellow:addMod(xi.mod.REFRESH, 1)
        fellow:addMod(xi.mod.ENMITY,  5)
        fellow:addMod(xi.mod.ATTP,  -10)

    elseif fellowType == fellowTypes.STALWART then
        fellow:addMod(xi.mod.ATT, wepBonus * 1.25)
        fellow:addMod(xi.mod.ACC, 100 + wepBonus * 1.25)
        fellow:addMod(xi.mod.SPELLINTERRUPT, 85)
        fellow:addMod(xi.mod.REFRESH, 2)
        fellow:addMod(xi.mod.SHIELD, 15)
        fellow:addMod(xi.mod.ENMITY, 10)
        fellow:addMod(xi.mod.SWORD,  15)
        fellow:addMod(xi.mod.DEFP,   20)

    elseif fellowType == fellowTypes.HEALER then
        fellow:addMod(xi.mod.MACC, wepBonus * 0.5 + 7)
        fellow:addMod(xi.mod.ATT, wepBonus * 0.75)
        fellow:addMod(xi.mod.ACC, wepBonus * 0.75)
        fellow:addMod(xi.mod.SPELLINTERRUPT, 50)
        fellow:addMod(xi.mod.REFRESH, 1)
        fellow:addMod(xi.mod.ENMITY, -5)
        fellow:addMod(xi.mod.ATTP,  -20)
        fellow:addMod(xi.mod.DEFP,  -15)
        fellow:addMod(xi.mod.MDEF,   10)
        fellow:addMod(xi.mod.MND, lvl * 0.25)

    elseif fellowType == fellowTypes.SOOTHING then
        fellow:addMod(xi.mod.MACC,      wepBonus * 0.25 + 15)
        fellow:addMod(xi.mod.ATT, wepBonus)
        fellow:addMod(xi.mod.ACC, wepBonus)
        fellow:addMod(xi.mod.SPELLINTERRUPT, 65)
        fellow:addMod(xi.mod.REFRESH,    2)
        fellow:addMod(xi.mod.ATTP,     -10)
        fellow:addMod(xi.mod.CLUB,      15)
        fellow:addMod(xi.mod.SWORD,     15)
        fellow:addMod(xi.mod.STAFF,     15)
        fellow:addMod(xi.mod.DIVINE,    15)
        fellow:addMod(xi.mod.HEALING,   15)
        fellow:addMod(xi.mod.ENFEEBLE,  15)
        fellow:addMod(xi.mod.ENMITY,   -10)
        fellow:addMod(xi.mod.DEFP,     -10)
        fellow:addMod(xi.mod.MDEF,      20)
        fellow:addMod(xi.mod.MND, lvl * 0.5)
    end
end

xi.fellow_utils.onTrigger = function(player, fellow)
    local ID                = require("scripts/zones/"..player:getZoneName().."/IDs")
    local personality       = xi.fellow_utils.checkPersonality(fellow)
    local fellowChatGeneral = 1

    if personality > 5 then
        personality = personality - 1
    end

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        player:getCharVar("[Quest]Looking_Glass") == 3
    then
        player:setLocalVar("triggerFellow", 0)
        player:setCharVar("[Quest]Looking_Glass", 4)
        if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
            player:showText(fellow, ID.text.GIRL_BACK_TO_JEUNO + personality)
        end
        player:timer(6000, function(playerArg)
            playerArg:despawnFellow()
        end)
    else
        player:triggerFellowChat(fellowChatGeneral)
    end
end

xi.fellow_utils.onFellowRoam = function(fellow)
    local master = fellow:getMaster()

    if master == nil then
        return
    end

    if
        master:isEngaged() and
        master:getTarget():isEngaged() and
        master:getCharVar("fellowAttackControl") == 1
    then
        master:fellowAttack(master:getTarget())
    end

    if fellow:checkDistance(master) >= 50 then
        local mPos = master:getPos()
        fellow:setPos(mPos.x + math.random(-1, 1), mPos.y, mPos.z + math.random(-1, 1))
    end

    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.checkJobAbility(fellow, master)
end

xi.fellow_utils.onFellowFight = function(fellow, target)
    local master = fellow:getMaster()

    xi.fellow_utils.checkJobAbility(fellow, master)
    xi.fellow_utils.checkProvoke(fellow, target, master)
    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.checkWeaponskill(fellow, target, master)
    xi.fellow_utils.battleMessaging(fellow, master)
end

xi.fellow_utils.buildPartyTable = function(master)
    local members = master:getParty()
    local party = {}

    for _, member in pairs(members) do
        if member:isPC() then
            table.insert(party, member)
        end
    end

    return party
end

---------------------------------------------------
-- Logic for spell casting is as follows:
---------------------------------------------------
xi.fellow_utils.spellCheck = function(fellow, master)
    local fellowType = master:getFellowValue("job")
    local fellowLvl  = fellow:getMainLvl()
    local mp         = fellow:getMP()

    -- Prevent queuing of spells
    if fellow:getCurrentAction() == xi.act.MAGIC_CASTING then
        return
    end

    xi.fellow_utils.checkAilment(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkCure(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkRegen(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkDebuff(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkBuff(fellow, master, fellowLvl, mp, fellowType)

    if
        fellow:getLocalVar("mpNotice") == 0 and
        mp / fellow:getMaxMP() * 100 < 25
    then
        fellow:setLocalVar("mpNotice", 1)
    end
end

xi.fellow_utils.checkJobAbility = function(fellow, master)
    local fellowType    = master:getFellowValue("job")
    local fellowLvl     = fellow:getMainLvl()
    local hpp           = fellow:getHPP()
    local target        = fellow:getTarget()
    local recast        = fellow:getLocalVar("abilityRecast")

    if recast < os.time() then
        -- Case for Tank Fellow
        if fellowType == fellowTypes.SHIELD or fellowType == fellowTypes.STALWART then
            for _, ability in pairs(tankJobAbilityTable) do
                local recast = master:getCharVar(ability.recastVar)
                local action

                if fellow:getTarget() ~= nil then
                    local action = fellow:getTarget():getCurrentAction()
                end

                if
                    fellowLvl > ability.level and
                    hpp <= ability.hppThreshold and
                    recast < os.time()
                then
                    if
                        ability.ability == xi.jobAbility.SHIELD_BASH and
                        (action == xi.action.MAGIC_CASTING or action == xi.action.MOBABILITY_START)
                    then
                        ability.isValid = true
                    end

                    if ability.isValid then
                        if ability.self then
                            target = fellow
                        end
                        fellow:setLocalVar("abilityRecast", os.time() + math.random(3, 4))
                        master:setCharVar(ability.recastVar, os.time() + ability.recast)
                        fellow:useJobAbility(ability.ability, target)
                    end
                end
            end
        -- Case for Melee Fellow
        elseif fellowType == fellowTypes.ATTACKER or fellowType == fellowTypes.FIERCE then
            for _, ability in pairs(meleeJobAbilityTable) do
                local recast = master:getCharVar(ability.recastVar)

                if
                    fellowLvl > ability.level and
                    hpp <= ability.hppThreshold and
                    recast < os.time() and
                    fellow:isEngaged()
                then
                    fellow:setLocalVar("abilityRecast", os.time() + math.random(3, 4))
                    master:setCharVar(ability.recastVar, os.time() + ability.recast)
                    fellow:useJobAbility(ability.ability, fellow)
                end
            end
        -- Case for Mage Fellow
        else
            for _, ability in pairs(mageJobAbilityTable) do
                local recast = master:getCharVar(ability.recastVar)

                if
                    fellowLvl >= ability.level and
                    hpp <= ability.hppThreshold and
                    recast < os.time()
                then
                    if
                        ability.ability == xi.jobAbility.CONVERT and
                        fellow:getMPP() <= 15
                    then
                        ability.isValid = true
                    elseif
                        ability.ability == xi.jobAbility.CONVERT and
                        fellow:getMPP() > 15
                    then
                        ability.isValid = false
                    end

                    if ability.isValid then
                        fellow:setLocalVar("abilityRecast", os.time() + math.random(3, 4))
                        master:setCharVar(ability.recastVar, os.time() + ability.recast)
                        fellow:useJobAbility(ability.ability, fellow)
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Function: checkRegen
--    Notes: Fellows prioritize themselves if their HPP > and master HPP > 60
--           They also won't cast regen on the player if they're below 50%, they
--           will instead priotize a cure at that low of HP.
-------------------------------------------------------------------------------
xi.fellow_utils.checkRegen = function(fellow, master, fellowLvl, mp, fellowType)
    local cooldown  = fellow:getLocalVar("castingCoolDown")
    local recast    = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local party     = xi.fellow_utils.buildPartyTable(master)

    -- Include fellows in this party list as fellows can inter-cast regen
    for _, member in pairs(party) do
        if
            member:isPC() and
            member:getFellow() ~= nil and
            member:getFellow() ~= fellow
        then
            table.insert(party, member:getFellow())
            break
        end
    end

    if
        fellowType ~= fellowTypes.HEALER and
        fellowType ~= fellowTypes.SOOTHING
    then
        return
    end

    if cooldown <= os.time() then
        for _, regen in pairs(regenTable) do
            if
                regen.level <= fellowLvl and
                regen.mpCost <= mp
            then
                for _, member in pairs(party) do
                    if
                        not member:hasStatusEffect(regen.effect) and
                        member:getHPP() <= 90
                    then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(regen.spell, member)
                        return

                    elseif
                        not fellow:hasStatusEffect(regen.effect) and
                        fellow:getHPP() <= 90
                    then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(regen.spell, fellow)
                        return
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Function: checkCure
--    Notes: CheckCure loops through the table of available cures from
--           strongest to weakest. This achieves the effect of the fellow
--           using the most powerful cure only when needed by comparing the
--           targets missing HP to the cure's required threshold HP to cast.
--
--           Fellows will prioritze themselves if under 30% HP while master's HP
--           is greater than 40%. They will otherwise cure themselves if master's
--           HP doesn't fall below a cure's HP threshold.
--
--           Fellows will heal PLD and DRK at a slower rate to allow them to
--           use abilities to heal themselves to better balance / maintain hate
--
--    TODO: Prioritize target by HP percentage
-------------------------------------------------------------------------------
xi.fellow_utils.checkCure = function(fellow, master, fellowLvl, mp, fellowType)
    local cooldown      = fellow:getLocalVar("castingCoolDown")
    local party         = xi.fellow_utils.buildPartyTable(master)
    local recast        = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local thresholdMod  = 1


    if
        fellowType == fellowTypes.ATTACKER or
        fellowType == fellowTypes.FIERCE
    then
        return
    end

    if cooldown < os.time() then
        for _, cure in pairs(cureTable) do
            if
                cure.level <= fellowLvl and
                cure.mpCost <= mp
            then
                for _, member in pairs(party) do

                    if
                        cure.spell == xi.magic.spell.CURE and
                        (member:getMainLvl() >= 35 or
                        fellow:getMainLvl() >= 35)
                    then
                        return
                    end

                    if
                        member:getMainJob() == xi.job.PLD and
                        member:getHPP() > 40
                    then
                        thresholdMod = thresholdMod + 0.75
                    end

                    if
                        member:hasStatusEffect(xi.effect.REGEN) and
                        member:getHPP() > 50 or
                        fellow:hasStatusEffect(xi.effect.REGEN) and
                        fellow:getHPP() > 50
                    then
                        thresholdMod = thresholdMod + 0.25
                    end

                    if member:getHPP() < 50 then
                        thresholdMod = 1
                    end

                    -- Final Check before healing party member
                    if (member:getMaxHP() - member:getHP()) > cure.hpThreshold * thresholdMod then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(cure.spell, member)
                        return
                    end

                    if fellow:getHPP() < 40 then
                        thresholdMod = 1
                    end

                    if (fellow:getMaxHP() - fellow:getHP()) > cure.hpThreshold * thresholdMod then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(cure.spell, fellow)
                        return
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Function: checkAilment
--    Notes: checkAilment loops through the table of potential ailments that the
--           fellow will attempt to remedy. This table is sorted by priority.
--           fellows will prioritize their master before themselves. Therefore
--           this table is looped through twice.
-------------------------------------------------------------------------------
xi.fellow_utils.checkAilment = function(fellow, master, fellowLvl, mp, fellowType)
    local coolDown = fellow:getLocalVar("castingCoolDown")
    local recast   = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local party    = xi.fellow_utils.buildPartyTable(master)

    if coolDown < os.time() then
        for _, debuff in pairs(ailmentTable) do
            if
                debuff.level <= fellowLvl and
                debuff.mpCost <= mp
            then
                -- Prioritize self if we can remove the effect
                if debuff.selfTarget then
                    if fellow:hasStatusEffect(debuff.effect) then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(debuff.spell, fellow)
                        return
                    end
                end

                for _, member in pairs(party) do
                    if member:hasStatusEffect(debuff.effect) then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(debuff.spell, member)
                        return
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Function: checkBuff
--    Notes: checkBuff loops through the table of potential buffs that the
--           fellow will attempt to cast. This table is sorted by priority.
-------------------------------------------------------------------------------
xi.fellow_utils.checkBuff = function(fellow, master, fellowLvl, mp, fellowType)
    local coolDown = fellow:getLocalVar("castingCoolDown")
    local recast   = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local party    = xi.fellow_utils.buildPartyTable(master)

    if
        fellowType ~= fellowTypes.HEALER and
        fellowType ~= fellowTypes.SOOTHING
    then
        return
    end

    if coolDown < os.time() then
        for _, buff in pairs(buffTable) do

            if buff.effect == xi.effect.STONESKIN or buff.effect == xi.effect.BLINK then
                recast = recast * 2
            end

            for _, member in pairs(party) do
                local check = true

                if
                    buff.level <= fellowLvl and
                    buff.mpCost <= mp
                then
                    if
                        buff.effect == xi.effect.REFRESH and
                        member:getMPP() > 90
                    then
                        check = false

                    elseif
                        buff.effect == xi.effect.HASTE and
                        not member:isEngaged()
                    then
                        check = false
                    end

                    if
                        not fellow:hasStatusEffect(buff.effect) and
                        (not buff.targetOther or buff.effect == xi.effect.REFRESH)
                    then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(buff.spell, fellow)
                        return
                    end

                    if
                        not member:hasStatusEffect(buff.effect) and
                        buff.targetOther and
                        check
                    then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(buff.spell, member)
                        return
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Function: checkDebuff
--    Notes: checkDebuff loops through the table of potential debuffs that the
--           fellow will attempt to cast. This table is sorted by priority.
--           Fellows will prioritize their target if they are engaged. Otherwise,
--           they will target the player's current target.
-------------------------------------------------------------------------------
xi.fellow_utils.checkDebuff = function(fellow, master, fellowLvl, mp, fellowType)
    local coolDown = fellow:getLocalVar("castingCoolDown")
    local recast   = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local target   = nil
    local party    = xi.fellow_utils.buildPartyTable(master)

    if -- Return if not mage
        (fellowType ~= fellowTypes.HEALER and
        fellowType ~= fellowTypes.SOOTHING)
    then
        return

    elseif -- Return if we don't have refresh
        fellow:getMainLvl() >= 41 and
        not fellow:hasStatusEffect(xi.effect.REFRESH)
    then
        return
    end

    if coolDown < os.time() then
        for _, member in pairs(party) do
            if member:isEngaged() then
                target = member:getTarget()
            end
        end

        if target == nil then
            return

        elseif -- Return if mob is almost dead and isn't an NM
            target:getHPP() < 15 and
            not target:isNM()
        then
            return
        end

        for _, debuff in pairs(debuffTable) do
            if
                debuff.level <= fellowLvl and
                debuff.mpCost <= mp and
                target ~= nil
            then
                if
                    not target:hasStatusEffect(debuff.effect) and
                    not target:hasImmunity(debuff.immunity) and
                    target:isEngaged()
                then
                    if
                        debuff.effect == xi.effect.SILENCE and
                        target:hasSpellList() and
                        (target:getMainJob() == xi.job.RDM or
                        target:getMainJob() == xi.job.WHM or
                        target:getMainJob() == xi.job.RDM or
                        target:getMainJob() == xi.job.BRD or
                        target:getMainJob() == xi.job.DRK)
                    then
                        debuff.check = true
                    elseif
                        target:hasStatusEffect(xi.effect.BIO) and
                        debuff.effect == xi.effect.DIA
                    then
                        debuff.check = false
                    end

                    if debuff.check then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(debuff.spell, target)
                        return
                    end
                end
            end
        end
    end
end

xi.fellow_utils.getWSDelay = function(fellow)
    local fellowType = fellow:getMaster():getFellowValue("job")
    local delay      = 5

    if
        fellowType == fellowTypes.FIERCE or
        fellowType == fellowTypes.ATTACKER
    then
        delay = 15
    end

    return delay
end

xi.fellow_utils.checkWeaponskill = function(fellow, target, fellowLvl)
    local weaponskillTable = weaponskills[fellow:getWeaponSkillType(xi.slot.MAIN)]
    local skillControl     = fellow:getLocalVar("skillControl")
    local chatControl      = fellow:getLocalVar("chatControl")
    local master           = fellow:getMaster()
    local wsDelay          = utils.clamp(fellow:getBattleTime() - xi.fellow_utils.getWSDelay(fellow), 0, 15)
    local tp               = fellow:getTP()
    local party            = xi.fellow_utils.buildPartyTable(master)
    local chosenSkill      = 0

    -- Include fellows in this party list
    for _, member in pairs(party) do
        if
            member:isPC() and
            member:getFellow() ~= nil and
            member:getFellow() ~= fellow
        then
            table.insert(party, member:getFellow())
            break
        end
    end

    if
        chatControl == 0 and
        tp >= 1000 and
        skillControl < os.time()
    then
        fellow:setLocalVar("wsWait", os.time() + 3)
        fellow:setLocalVar("chatControl", 1)

        for _, member in pairs(master:getParty()) do
            if member:isPC() then
                member:PrintToPlayer("Ready to weaponskill!", xi.msg.channel.PARTY, fellow:getName())
            end
        end
    end

    -- Proceed to WS if we've warned party of our TP, it's been 3 seconds, and we're sufficient time into party
    if
        fellow:getLocalVar("chatControl") == 1 and
        fellow:getLocalVar("wsWait") < os.time() and
        wsDelay < fellow:getBattleTime()
    then
        -- Waits for party member to have TP if said member is also engaged to the same target as fellow
        for _, member in pairs(party) do
            if
                member:isPC() and
                member:isEngaged() and
                member:getTP() >= 1000 and
                target:getHPP() > 15
            then
                for _, member in pairs(master:getParty()) do
                    if member:isPC() then
                        member:PrintToPlayer("Using weaponskill. Let's roll!", xi.msg.channel.PARTY, fellow:getName())
                    end
                end

                -- Finds highest level WS to use
                for _, skill in pairs(weaponskillTable) do
                    if fellow:getMainLvl() > skill.level then
                        chosenSkill = skill.id
                        break
                    end
                end

                -- Use skill control to ensure this isn't called multiple times for extra measure
                if
                    fellow:getLocalVar("skillControl") < os.time() and
                    chosenSkill > 0
                then
                    fellow:useMobAbility(chosenSkill, target)
                    fellow:setLocalVar("chatControl", 0)
                    fellow:setLocalVar("skillControl", os.time() + 5)
                    return
                end
            end
        end
    end
end

xi.fellow_utils.checkProvoke = function(fellow, target, master)
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(fellow)
    local optionsMask   = master:getFellowValue("optionsMask")
    local provoke       = fellow:getLocalVar("provoke")
    local fellowType    = master:getFellowValue("job")
    local flash         = fellow:getLocalVar("flash")
    local otherSignals  = false
    local recast        = 30

    if fellowType == fellowTypes.SHIELD then
        recast = recast + math.random(5, 10)
    end

    if bit.band(optionsMask, bit.lshift(1, 4)) == 16 then
        otherSignals = true
    end

    if
        (fellowType == fellowTypes.SHIELD or
        fellowType == fellowTypes.STALWART) and
        fellow:checkDistance(target) <= 12 and
        provoke < os.time() and
        otherSignals
    then
        if
            fellow:actionQueueEmpty() and
            (fellow:getHPP() > 25 or
            master:getHPP() < 10)
        then
            if target:isEngaged() then
                -- Provoke only if target isn't attacking fellow
                if
                    target:getTarget():getID() ~= fellow:getID() or
                    target:isNM()
                then
                    fellow:useJobAbility(xi.jobAbility.PROVOKE, target)
                    fellow:setLocalVar("provoke", os.time() + recast)
                    if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)
                    end
                end
            end
        end

    elseif
        (fellowType == fellowTypes.SHIELD or
        fellowType == fellowTypes.STALWART) and
        fellow:checkDistance(target) <= 20 and
        flash < os.time()
    then
        -- Use Flash if provoke timer is down and we still don't have enmity
        -- TODO: Add a misc spell container for Paladin
        if
            fellow:getTarget():getID() ~= fellow:getID() or
            fellow:getMainLvl() >= 37 and
            fellow:getMP() > 25 and
            target:isNM()
        then
            fellow:castSpell(xi.magic.spell.FLASH, target)
            fellow:setLocalVar("flash", os.time() + 45)

            if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)
            end
        end
    end

    return false
end

xi.fellow_utils.calculateRecast = function(fellow, fellowType)
    local recast = math.random(4, 6)

    if fellowType == fellowTypes.SOOTHING then
        recast = recast - math.random(2, 4)
    elseif fellowType == fellowTypes.HEALER then
        recast = recast - math.random(1, 2)
    elseif fellowType == fellowTypes.STALWART then
        recast = recast + math.random(1, 2)
    elseif fellowType == fellowTypes.SHIELD then
        recast = recast + math.random(2, 4)
    end

    return recast
end

xi.fellow_utils.battleMessaging = function(fellow, master)
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
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
        if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
            master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.HP_LOW_NOTICE + personality)
        end
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
        if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
            master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.MP_LOW_NOTICE + personality)
        end
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

    if master ~= nil then
        xi.fellow_utils.upgradeArmor(fellow, master)
    end
end

xi.fellow_utils.upgradeArmor = function(fellow, master)
    local offset        = master:getCharVar("[FELLOW]armorOffset")
    local armorLock     = master:getFellowValue("armorLock")
    local unlocked      = {}
    local armorTable    =
    {
        [4] = { "body" },
        [3] = { "legs" },
        [2] = { "feet" },
        [1] = { "hands" },
    }

    for i, v in ipairs(armorTable) do
        if bit.band(armorLock, bit.lshift(1, i)) == 0 then
            table.insert(unlocked, v[1])
        end
    end

    for _, armorLevel in pairs(armorIndex) do
        if master:getFellowValue("level") >= armorLevel[1] then
            for i = 1, #unlocked do
                master:setFellowValue(unlocked[i], armorLevel[2] + offset)
            end

            return
        end
    end
end

xi.fellow_utils.changeJob = function(master, pJob, job)
    local armorLock    = master:getFellowValue("armorLock")
    local unlockedSlot = {}
    local offset       = 0
    local armorTable   =
    {
        [1] = { "body" },
        [2] = { "hands" },
        [3] = { "legs" },
        [4] = { "feet" },
    }

    if pJob ~= job then
        if job == 1 or job == 4 then
            if pJob == 2 or pJob == 5 then
                master:setCharVar("[FELLOW]armorOffset", -100)
            elseif pJob == 3 or pJob == 6 then
                master:setCharVar("[FELLOW]armorOffset", -200)
            end

        elseif job == 2 or job == 5 then
            if pJob == 1 or pJob == 4 then
                master:setCharVar("[FELLOW]armorOffset", 100)
            elseif pJob == 3 or pJob == 6 then
                master:setCharVar("[FELLOW]armorOffset", -100)
            end

        elseif job == 3 or job == 6 then
            if pJob == 2 or pJob == 5 then
                master:setCharVar("[FELLOW]armorOffset", 100)
            elseif pJob == 1 or pJob == 4 then
                master:setCharVar("[FELLOW]armorOffset", 200)
            end
        end

        offset = master:getCharVar("[FELLOW]armorOffset")

        for i, v in ipairs(armorTable) do
            if bit.band(armorLock, bit.lshift(1, i)) == 0 then
                table.insert(unlockedSlot, v[1])
            end
        end

        for i = 1, #unlockedSlot do
            master:setFellowValue(unlockedSlot[i], master:getFellowValue(unlockedSlot[i]) + offset)
        end
    end
end

xi.fellow_utils.checkPersonality = function(fellow)
    local personalityTable =
    {
        [4]  = 0,
        [8]  = 1,
        [12] = 2,
        [16] = 3,
        [40] = 4,
        [44] = 5,
        [20] = 7,
        [24] = 8,
        [28] = 9,
        [32] = 10,
        [36] = 11,
        [48] = 12,
    }

    return personalityTable[fellow:getMaster():getFellowValue("personality")]
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
