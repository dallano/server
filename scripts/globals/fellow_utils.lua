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
    { ability = xi.jobAbility.BERSERK,      level = 15, recast = 380,  hppThreshold = 100, isValid = true, self = true,  recastVar = "[FELLOW]berserkRecast"    },
    { ability = xi.jobAbility.BLOOD_WEAPON, level = 1,  recast = 7200, hppThreshold = 45,  isValid = true, self = true,  recastVar = "[FELLOW]twoHourRecast"    },
}

local mageJobAbilityTable =
{
    { ability = xi.jobAbility.COMPOSURE,   level = 50, recast = 350,  hppThreshold = 100, isValid = true,  recastVar = "[FELLOW]composureRecast" },
    { ability = xi.jobAbility.CONVERT,     level = 40, recast = 600,  hppThreshold = 100, isValid = false, recastVar = "[FELLOW]convertRecast"   },
    { ability = xi.jobAbility.BENEDICTION, level = 1,  recast = 7200, hppThreshold = 25,  isValid = true,  recastVar = "[FELLOW]twoHourRecast"   },
}

local regenTable =
{
    { spell = xi.magic.spell.REGEN_III, level = 66, mpCost = 64 },
    { spell = xi.magic.spell.REGEN_II,  level = 44, mpCost = 36 },
    { spell = xi.magic.spell.REGEN,     level = 21, mpCost = 15 },
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
    { effect = xi.effect.SILENCE,   spell = xi.magic.spell.SILENCE,  level = 15, mpCost = 16, immunity = xi.immunity.SILENCE,  check = true },
    { effect = xi.effect.DIA,       spell = xi.magic.spell.DIA_II,   level = 36, mpCost = 30, immunity = xi.immunity.NONE,     check = true },
    { effect = xi.effect.DIA,       spell = xi.magic.spell.DIA,      level =  3, mpCost =  7, immunity = xi.immunity.NONE,     check = true },
    { effect = xi.effect.PARALYSIS, spell = xi.magic.spell.PARALYZE, level =  4, mpCost =  6, immunity = xi.immunity.PARALYZE, check = true },
    { effect = xi.effect.SLOW,      spell = xi.magic.spell.SLOW,     level = 13, mpCost = 15, immunity = xi.immunity.SLOW,     check = true },
}

local buffTable =
{
    { effect = xi.effect.REFRESH,   spell = xi.magic.spell.REFRESH,       level = 41, mpCost = 40, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_IV,  level = 68, mpCost = 65, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_III, level = 47, mpCost = 46, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_II,  level = 27, mpCost = 28, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA,     level =  7, mpCost =  9, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_IV,    level = 68, mpCost = 75, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_III,   level = 57, mpCost = 56, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_II,    level = 37, mpCost = 37, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA,       level = 17, mpCost = 18, targetOther = false },
    { effect = xi.effect.HASTE,     spell = xi.magic.spell.HASTE,         level = 40, mpCost = 40, targetOther = false },
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
        [1] = { 1,  false }, -- combo
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
        [16] = { 1,  false }, -- wasp sting
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
        [32] = { 1,  false }, -- fast blade
        [33] = { 9, false }, -- burning blade
        [34] = { 16, false }, -- red lotus blade
        -- [35] = { 24, false }, -- flat blade
        -- [36] = { 33, false }, -- shining blade
        [37] = { 41, false }, -- seraph blade
        [38] = { 49, true },  -- circle blade
        [39] = { 55, false }, -- spirits within
        [40] = { 60, false }, -- vorpal blade
        [41] = { 65, false }, -- swift blade
    },
    [xi.skill.GREAT_SWORD] =
    {
        [48] = { 1,  false }, -- hard slash
        [49] = { 9,  false }, -- power slash
        [50] = { 23, false }, -- frostbite
        [51] = { 33, false }, -- freezebite
        [52] = { 49,  true }, -- shockwave
        [53] = { 55, false }, -- crescent moon
        [54] = { 60, false }, -- sickle moon
        [55] = { 65, false }, -- spinning slash
    },
    [xi.skill.AXE] =
    {
        [64] = { 1,  false }, -- raging axe
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
        [80] = { 1,  false }, -- shield break
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
        [96]  = { 1,  false }, -- slice
        [97]  = { 9,  false }, -- dark harvest
        [98]  = { 23, false }, -- shadow of death
        [99]  = { 33, false }, -- nightmare scythe
        [100] = { 41,  true }, -- spinning scythe
        [101] = { 49, false }, -- vorpal scythe
        [102] = { 60, false }, -- guillotine
        [103] = { 65, false }, -- cross reaper
    },
    [xi.skill.POLEARM] =
    {
        [112] = { 1,  false }, -- double thrust
        [113] = { 9,  false }, -- thunder thrust
        [114] = { 23, false }, -- raiden thrust
        [115] = { 33, false }, -- leg sweep
        [116] = { 49, false }, -- penta thrust
        [117] = { 55, false }, -- vorpal thrust
        [118] = { 60, false }, -- skewer
        [119] = { 65, false }, -- wheeling thrust
    },
    [xi.skill.KATANA] =
    {
        [128] = { 1,  false }, -- blade: rin
        [129] = { 9,  false }, -- blade: retsu
        [130] = { 23, false }, -- blade: teki
        [131] = { 33, false }, -- blade: to
        [132] = { 49, false }, -- blade: chi
        [133] = { 55, false }, -- blade: ei
        [134] = { 60, false }, -- blade: jin
        [135] = { 66, false }, -- blade: ten
    },
    [xi.skill.GREAT_KATANA] =
    {
        [144] = { 1,  false }, -- tachi: enpi
        [145] = { 9,  false }, -- tachi: hobaku
        [146] = { 23, false }, -- tachi: goten
        [147] = { 33, false }, -- tachi: kagero
        [148] = { 49, false }, -- tachi: jinpu
        [149] = { 55, false }, -- tachi: koki
        [150] = { 60, false }, -- tachi: yukikaze
        [151] = { 65, false }, -- tachi: gekko
    },
    [xi.skill.CLUB] =
    {
        [160] = { 1,  false }, -- shining strike
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
        [176] = { 1,  false }, -- heavy swing
        [177] = { 13, false }, -- rock crusher
        [178] = { 23,  true }, -- earth crusher
        [179] = { 33, false }, -- starburst
        [180] = { 49, false }, -- sunburst
        [181] = { 55, false }, -- shell crusher
        [182] = { 60, false }, -- full swing
        [183] = { 63, false }, -- spirit taker
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
    local level         = fellow:getMainLvl()
    local refreshPower  = math.ceil(level * 0.05)
    fellow:setLocalVar("masterID", master:getID())
    fellow:setLocalVar("castingCoolDown", os.time() + 15)
    master:setLocalVar("chatCounter", 0)
    master:setFellowValue("spawnTime", os.time())

    -- Adjust Position
    local mPos = master:getPos()
    fellow:setPos(mPos.x + math.random(-1.0, 1.0), mPos.y, mPos.z + math.random(-1.0, 1.0))

    if fellowType == fellowTypes.ATTACKER then
        fellow:setMobMod(xi.mobMod.WEAPON_BONUS, fellow:getMainLvl())
        fellow:setMod(xi.mod.ATT,  50 + fellow:getMainLvl())
        fellow:setMod(xi.mod.HASTE_GEAR, 100)
        fellow:setMod(xi.mod.ACC,  10)
        fellow:setMod(xi.mod.STR,   7)
        fellow:setMod(xi.mod.DEX,   7)

    elseif fellowType == fellowTypes.FIERCE then
        fellow:setMobMod(xi.mobMod.WEAPON_BONUS, fellow:getMainLvl() * 1.15)
        fellow:setMod(xi.mod.ATT,  50 + fellow:getMainLvl())
        fellow:setMod(xi.mod.DOUBLE_ATTACK, 10)
        fellow:setMod(xi.mod.HASTE_GEAR, 1500)
        fellow:setMod(xi.mod.STORETP, 15)
        fellow:setMod(xi.mod.GKATANA, 15)
        fellow:setMod(xi.mod.POLEARM, 15)
        fellow:setMod(xi.mod.GSWORD,  15)
        fellow:setMod(xi.mod.SCYTHE,  15)
        fellow:setMod(xi.mod.KATANA,  15)
        fellow:setMod(xi.mod.GAXE,    15)
        fellow:setMod(xi.mod.AXE,     15)
        fellow:setMod(xi.mod.HTH,     15)
        fellow:setMod(xi.mod.PARRY,    5)
        fellow:setMod(xi.mod.ACC,     25)
        fellow:setMod(xi.mod.STR,     15)
        fellow:setMod(xi.mod.DEX,     15)

    elseif fellowType == fellowTypes.SHIELD then
        fellow:setMod(xi.mod.REFRESH, 1)
        fellow:setMod(xi.mod.ENMITY,  5)
        fellow:setMod(xi.mod.ATTP,  -10)

    elseif fellowType == fellowTypes.STALWART then
        fellow:setMod(xi.mod.REFRESH, refreshPower)
        fellow:setMod(xi.mod.SHIELD, 15)
        fellow:setMod(xi.mod.ENMITY, 10)
        fellow:setMod(xi.mod.SWORD,  15)
        fellow:setMod(xi.mod.DEFP,   20)

    elseif fellowType == fellowTypes.HEALER then
        fellow:setMod(xi.mod.REFRESH, refreshPower)
        fellow:setMod(xi.mod.ENMITY, -5)
        fellow:setMod(xi.mod.ATTP,  -20)
        fellow:setMod(xi.mod.DEFP,  -15)
        fellow:setMod(xi.mod.MDEF,   10)
        fellow:setMod(xi.mod.MACC,    7)

    elseif fellowType == fellowTypes.SOOTHING then
        fellow:setMod(xi.mod.REFRESH, refreshPower)
        fellow:setMod(xi.mod.ATTP,     -10)
        fellow:setMod(xi.mod.CLUB,      15)
        fellow:setMod(xi.mod.SWORD,     15)
        fellow:setMod(xi.mod.STAFF,     15)
        fellow:setMod(xi.mod.DIVINE,    15)
        fellow:setMod(xi.mod.HEALING,   15)
        fellow:setMod(xi.mod.ENFEEBLE,  15)
        fellow:setMod(xi.mod.ENMITY,   -10)
        fellow:setMod(xi.mod.DEFP,     -10)
        fellow:setMod(xi.mod.MDEF,      20)
        fellow:setMod(xi.mod.MACC,      15)
    end

    -- local mob = fellow:getZone():insertDynamicEntity({
    --     objtype = xi.objType.MOB,
    --     allegiance = xi.allegiance.PLAYER,
    --     name = "Moblin Boi",
    --     x = fellow:getPos().x + math.random(-1, 1),
    --     y = fellow:getPos().y,
    --     z = fellow:getPos().z + math.random(-1, 1),
    --     rotation = fellow:getPos().rotation,
    --     look = 699,

    --     releaseIdOnDisappear = true,
    --     specialSpawnAnimation = true,
    -- })

    -- local pos = mob:getPos()

    -- mob:setSpawn(pos.x, pos.y, pos.z)
    -- mob:spawn()
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

    if fellow:checkDistance(master) >= 50 then
        local mPos = master:getPos()
        fellow:setPos(mPos.x + math.random(-1, 1), mPos.y, mPos.z + math.random(-1, 1))
    end

    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.checkJobAbility(fellow, master)
    xi.fellow_utils.timeWarning(fellow, master)
    xi.fellow_utils.onslaught(fellow, master)
end

xi.fellow_utils.onslaught = function(fellow, master)
    if
        fellow:getLocalVar("onslaught") == 1 and
        fellow:getHPP() >= 60
    then
        local zone    = fellow:getZone()
        local mobs    = zone:getMobs()

        for _, mob in pairs(mobs) do
            local yOffset = master:getPos().y - mob:getPos().y

            if
                master:checkDistance(mob) < 40 and
                master:getMainLvl() - mob:getMainLvl() >= 2 and
                yOffset >= -5 and
                yOffset <= 5 and
                not mob:isNM()
            then
                master:fellowAttack(mob)
            end
        end
    end
end

xi.fellow_utils.onFellowFight = function(fellow, target)
    local master = fellow:getMaster()

    xi.fellow_utils.checkJobAbility(fellow, master)
    xi.fellow_utils.checkProvoke(fellow, target, master)
    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.weaponskill(fellow, target, master)
    xi.fellow_utils.battleMessaging(fellow, master)
    xi.fellow_utils.timeWarning(fellow, master)
end

xi.fellow_utils.buildPartyTable = function(master)
    local party = master:getParty()

    for _, member in pairs(party) do
        if
            member:isPC() and
            member:getFellow() ~= nil
        then
            table.insert(party, member:getFellow())
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

    xi.fellow_utils.checkAilment(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkRegen(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkCure(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkBuff(fellow, master, fellowLvl, mp, fellowType)
    xi.fellow_utils.checkDebuff(fellow, master, fellowLvl, mp, fellowType)

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
                local action = fellow:getTarget():getCurrentAction()

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
    local thresholdMod  = 1

    if
        fellowType == fellowTypes.ATTACKER or
        fellowType == fellowTypes.FIERCE
    then
        return

    elseif
        (fellowType == fellowTypes.HEALER or
        fellowType == fellowTypes.SOOTHING) and
        fellow:getMainLvl() >= 41 and
        not fellow:hasStatusEffect(xi.effect.REFRESH)
    then
        return
    end

    if cooldown < os.time() then
        recast = xi.fellow_utils.calculateRecast(fellow, fellowType)

        for _, cure in pairs(cureTable) do
            if
                cure.level <= fellowLvl and
                cure.mpCost <= mp
            then
                for _, member in pairs(party) do
                    -- Prioritize poison if target is okay HP wise
                    if
                        member:hasStatusEffect(xi.effect.POISON) and
                        member:getHPP() > 50
                    then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(xi.magic.spell.POISONA, member)
                        return
                    end

                    -- Heal more slowly on PLDs to allow them to heal themselves in order to maintain hate
                    -- PLDs heal others and themselves less effectively
                    -- Heal a little less effectively if target already has Regen
                    if member:getMainJob() == xi.job.PLD and member:getHPP() > 40 then
                        thresholdMod = thresholdMod + 1
                    elseif
                        fellow:getMainJob() == xi.job.PLD and
                        member ~= fellow and
                        member:getHPP() > 40
                    then
                        thresholdMod = thresholdMod + 1.5
                    elseif
                        fellow:getMainJob() == xi.job.PLD and
                        member == fellow and
                        member:getHPP() > 40
                    then
                        thresholdMod = thresholdMod + 0.5
                    elseif
                        member:hasStatusEffect(xi.effect.REGEN) and
                        member:getHPP() > 50
                    then
                        thresholdMod = thresholdMod + 0.5
                    end

                    -- Final Check before healing party member
                    if (member:getMaxHP() - member:getHP()) > cure.hpThreshold then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(cure.spell, member)
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

    if
        (fellowType ~= fellowTypes.HEALER and
        fellowType ~= fellowTypes.SOOTHING) or
        master:getHPP() < 40
    then
        return

    elseif
        fellow:getMainLvl() >= 41 and
        not fellow:hasStatusEffect(xi.effect.REFRESH)
    then
        return
    end

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
                    -- Don't cast refresh if member has near full MP
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

                    if not fellow:hasStatusEffect(buff.effect) then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(buff.spell, fellow)
                        return

                    elseif
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
    local engaged  = false
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

    if
        coolDown < os.time() and
        fellow:getMPP() > 30
    then
        for _, member in pairs(party) do
            if member:isEngaged() then
                target = member:getTarget()
            end
        end

        if -- Return if mob is a weakling and not an NM
            target ~= nil and
            fellow:checkDistance(target) <= 20 and
            target:getMainLvl() - master:getMainLvl() < -6 and
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
                        not target:hasSpellList()
                    then
                        debuff.check = false
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
        fellowType == fellowTypes.FIERCE)
    then
        if fellow:getTP() == 3000 then
            if
                xi.fellow_utils.checkWeaponSkill(fellow, target, fellowLvl) and
                otherSignals
            then
                if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                end
            end

        elseif fellow:getTP() > 1000 then
            if
                wsSignals and
                wsReady == 0 and
                master:getTP() < 1000 and
                master:getTP() > 500
            then
                if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WS_READY + personality)
                end
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
                    if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                    end
                end

            elseif
                fellowType == fellowTypes.FIERCE and
                master:getTP() > 1000 and
                wsReady == 0 and
                target:getHPP() > 15
            then
                if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL2 + personality)
                end
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
                    if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                        master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                    end
                end
            end
        end

    elseif fellow:getTP() > 1000 then
        if
            xi.fellow_utils.checkWeaponSkill(fellow, target, fellowLvl) and
            otherSignals
        then
            if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
                master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
            end
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
        fellow:getLocalVar("wsTime") == 0 and
        fellow:checkDistance(target) < 5
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
        recast = recast + math.random(2, 4)
    elseif fellowType == fellowTypes.HEALER then
        recast = recast + math.random(4, 6)
    elseif fellowType == fellowTypes.STALWART then
        recast = recast + math.random(6, 8)
    elseif fellowType == fellowTypes.SHIELD then
        recast = recast + math.random(8, 12)
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
        if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
            master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.FIVE_MIN_WARNING + personality)
        end
        fellow:setLocalVar("timeWarning", 1)
    elseif
        os.time() > spawnTime + maxTime - 4 and
        timeWarning == 1
    then
        if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
            master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.TIME_EXPIRED + personality)
        end
        fellow:setLocalVar("timeWarning", 2)
    elseif
        os.time() > spawnTime + maxTime and
        timeWarning == 2
    then
        if ID.text.FELLOW_MESSAGE_OFFSET ~= nil then
            master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.LEAVE + personality)
        end
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

    if master ~= nil then
        xi.fellow_utils.upgradeArmor(fellow, master)
    end
end

-- Players must kill a number of mobs greater than 15x the selected
-- armor rank. This scales from 15 -> 165. Requiring 3,960 kills for
-- completion - as well as lvl 75.
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
        if fellow:getMainLvl() >= armorLevel[1] then
            for i = 1, #unlocked do
                master:setFellowValue(i, armorLevel[2] + offset)
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
