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

local regenTable =
{
    { spell = xi.magic.spell.REGEN_III, level = 66, mpCost = 64 },
    { spell = xi.magic.spell.REGEN_II,  level = 44, mpCost = 36 },
    { spell = xi.magic.spell.REGEN,     level = 21, mpCost = 15 },
}

local cureTable =
{
    { spell = xi.magic.spell.CURE_V,   level = 61, mpCost = 135, hpThreshold = 450 },
    { spell = xi.magic.spell.CURE_IV,  level = 41, mpCost =  88, hpThreshold = 350 },
    { spell = xi.magic.spell.CURE_III, level = 21, mpCost =  46, hpThreshold = 250 },
    { spell = xi.magic.spell.CURE_II,  level = 11, mpCost =  24, hpThreshold = 150 },
    { spell = xi.magic.spell.CURE,     level =  1, mpCost =   8, hpThreshold = 50  },
}

local debuffTable =
{
    { effect = xi.effect.SILENCE,   spell = xi.magic.spell.SILENCE,  level = 15, mpCost = 16, immunity = xi.immunity.SILENCE,  check = true },
    { effect = xi.effect.PARALYSIS, spell = xi.magic.spell.PARALYZE, level =  4, mpCost = 6,  immunity = xi.immunity.PARALYZE, check = true },
    { effect = xi.effect.SLOW,      spell = xi.magic.spell.SLOW,     level = 13, mpCost = 15, immunity = xi.immunity.SLOW,     check = true },
    { effect = xi.effect.DIA,       spell = xi.magic.spell.DIA_II,   level = 36, mpCost = 30, immunity = xi.immunity.NONE,     check = true },
    { effect = xi.effect.DIA,       spell = xi.magic.spell.DIA,      level =  3, mpCost =  7, immunity = xi.immunity.NONE,     check = true },
}

local buffTable =
{
    { effect = xi.effect.REFRESH,   spell = xi.magic.spell.REFRESH,       level = 41, mpCost = 40, targetMaster =  true },
    { effect = xi.effect.HASTE,     spell = xi.magic.spell.HASTE,         level = 40, mpCost = 40, targetMaster =  true },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_IV,  level = 68, mpCost = 65, targetMaster = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_III, level = 47, mpCost = 46, targetMaster = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_II,  level = 27, mpCost = 28, targetMaster = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA,     level =  7, mpCost =  9, targetMaster = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_IV,    level = 68, mpCost = 75, targetMaster = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_III,   level = 57, mpCost = 56, targetMaster = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_II,    level = 37, mpCost = 37, targetMaster = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA,       level = 17, mpCost = 18, targetMaster = false },
    { effect = xi.effect.STONESKIN, spell = xi.magic.spell.STONESKIN,     level = 28, mpCost = 29, targetMaster = false },
    { effect = xi.effect.BLINK,     spell = xi.magic.spell.BLINK,         level = 19, mpCost = 20, targetMaster = false },
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
    [0]   = 20,
    [1]   = 25,
    [2]   = 30,
    [3]   = 35,
    [4]   = 40,
    [5]   = 45,
    [6]   = 50,
    [7]   = 55,
    [8]   = 60,
    [9]   = 65,
    [10]  = 70,
    [11]  = 75,
}

xi.fellow_utils.onFellowSpawn = function(fellow)
    local master        = fellow:getMaster()
    local fellowType    = master:getFellowValue("job")
    local level         = fellow:getMainLvl()
    local refreshPower  = math.ceil(level * 0.05)
    fellow:setLocalVar("masterID", master:getID())
    fellow:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
    master:setLocalVar("chatCounter", 0)
    master:setFellowValue("spawnTime", os.time())
    -- Attack now handled only by !fellowAttack <target>
    -- Disengage now handled only by !fellowDisengage

    if fellowType == fellowTypes.ATTACKER then
        fellow:setMod(xi.mod.ACC, 10)
        fellow:setMod(xi.mod.STR, 7)
        fellow:setMod(xi.mod.DEX, 7)

    elseif fellowType == fellowTypes.FIERCE then
        fellow:setMod(xi.mod.HTH,     15)
        fellow:setMod(xi.mod.GSWORD,  15)
        fellow:setMod(xi.mod.AXE,     15)
        fellow:setMod(xi.mod.GAXE,    15)
        fellow:setMod(xi.mod.SCYTHE,  15)
        fellow:setMod(xi.mod.POLEARM, 15)
        fellow:setMod(xi.mod.KATANA,  15)
        fellow:setMod(xi.mod.GKATANA, 15)
        fellow:setMod(xi.mod.STORETP, 15)
        fellow:setMod(xi.mod.PARRY,    5)
        fellow:setMod(xi.mod.ATTP, 20)
        fellow:setMod(xi.mod.ACC, 25)
        fellow:setMod(xi.mod.STR, 15)
        fellow:setMod(xi.mod.DEX, 15)

    elseif fellowType == fellowTypes.SHIELD then
        fellow:setMod(xi.mod.REFRESH, 1)
        fellow:setMod(xi.mod.ENMITY, 5)

    elseif fellowType == fellowTypes.STALWART then
        fellow:setMod(xi.mod.REFRESH, 1)
        fellow:setMod(xi.mod.SHIELD, 15)
        fellow:setMod(xi.mod.SWORD,  15)
        fellow:setMod(xi.mod.ENMITY,10)
        fellow:setMod(xi.mod.DEFP, 20)

    elseif fellowType == fellowTypes.HEALER then
        fellow:setMod(xi.mod.REFRESH, refreshPower)
        fellow:setMod(xi.mod.ENMITY, -5)
        fellow:setMod(xi.mod.DEFP, -15)
        fellow:setMod(xi.mod.MDEF, 10)
        fellow:setMod(xi.mod.MACC, 7)

    elseif fellowType == fellowTypes.SOOTHING then
        fellow:setMod(xi.mod.CLUB,    15)
        fellow:setMod(xi.mod.STAFF,   15)
        fellow:setMod(xi.mod.DIVINE,  15)
        fellow:setMod(xi.mod.HEALING, 15)
        fellow:setMod(xi.mod.ENFEEB,  15)
        fellow:setMod(xi.mod.REFRESH, refreshPower * 1.5)
        fellow:setMod(xi.mod.ENMITY, -10)
        fellow:setMod(xi.mod.RDEFP, -10)
        fellow:setMod(xi.mod.DEFP, -10)
        fellow:setMod(xi.mod.MDEF, 20)
        fellow:setMod(xi.mod.MACC, 15)
    end
end

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

xi.fellow_utils.onFellowRoam = function(fellow)
    local master = fellow:getMaster()

    if master == nil then
        return
    end

    xi.fellow_utils.timeWarning(fellow, master)
    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.onslaught(fellow, master)
end

xi.fellow_utils.onslaught = function(fellow, master)
    if
        fellow:getLocalVar("onslaught") == 1 and
        fellow:getHPP() >= 60
    then
        local zone = fellow:getZone()
        local mobs = zone:getMobs()

        for _, mob in pairs(mobs) do
            if
                master:checkDistance(mob) < 40 and
                master:getMainLvl() - mob:getMainLvl() >= 2 and
                not mob:isNM()
            then
                master:fellowAttack(mob)
            end
        end
    end
end

xi.fellow_utils.onFellowFight = function(fellow, target)
    local master = fellow:getMaster()

    if master == nil then
        return
    end

    xi.fellow_utils.checkProvoke(fellow, target, master)
    xi.fellow_utils.spellCheck(fellow, master)
    xi.fellow_utils.weaponskill(fellow, target, master)
    xi.fellow_utils.battleMessaging(fellow, master)
    xi.fellow_utils.timeWarning(fellow, master)
end

xi.fellow_utils.spellCheck = function(fellow, master)
    local fellowType    = master:getFellowValue("job")
    local fellowLvl     = fellow:getMainLvl()
    local mp            = fellow:getMP()

    if fellow:getCurrentAction() == xi.action.MAGIC_CASTING then
        fellow:setMobMod(xi.mobMod.NO_MOVE, 1)
    else
        fellow:setMobMod(xi.mobMod.NO_MOVE, 0)
    end

    if
        (fellowType == fellowTypes.SHIELD or
        fellowType == fellowTypes.STALWART or
        fellowType == fellowTypes.HEALER or
        fellowType == fellowTypes.SOOTHING) and
        master ~= nil
    then
        xi.fellow_utils.checkCure(fellow, master, fellowLvl, mp, fellowType)
    end

    if
        (fellowType == fellowTypes.HEALER or
        fellowType == fellowTypes.SOOTHING) and
        master ~= nil
    then
        xi.fellow_utils.checkRegen(fellow, master, fellowLvl, mp, fellowType)
        xi.fellow_utils.checkAilment(fellow, master, fellowLvl, mp, fellowType)
        xi.fellow_utils.checkBuff(fellow, master, fellowLvl, mp, fellowType)
        xi.fellow_utils.checkDebuff(fellow, master, fellowLvl, mp, fellowType)
    end

    if
        fellow:getLocalVar("mpNotice") == 0 and
        mp / fellow:getMaxMP() * 100 < 25
    then
        fellow:setLocalVar("mpNotice", 1)
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
    local fellowHPP = fellow:getHPP()
    local masterHPP = master:getHPP()

    if cooldown <= os.time() then
        for _, regen in pairs(regenTable) do
            if
                regen.level <= fellowLvl and
                regen.mpCost <= mp
            then
                if
                    not fellow:hasStatusEffect(xi.effect.REGEN) and
                    fellowHPP < 80 and
                    masterHPP > 60
                then
                    fellow:setLocalVar("castingCoolDown", os.time() + recast)
                    fellow:castSpell(regen.spell, fellow)

                elseif
                    not master:hasStatusEffect(xi.effect.REGEN) and
                    masterHPP <= 95 and
                    masterHPP >= 50
                then
                    fellow:setLocalVar("castingCoolDown", os.time() + recast)
                    fellow:castSpell(regen.spell, master)
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
-------------------------------------------------------------------------------
xi.fellow_utils.checkCure = function(fellow, master, fellowLvl, mp, fellowType)
    local coolDown      = fellow:getLocalVar("castingCoolDown")
    local recast        = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local masterHP      = master:getMaxHP() - master:getHP()
    local fellowHP      = fellow:getMaxHP() - fellow:getHP()

    if coolDown < os.time() then
        if
            fellowType == fellowTypes.SHIELD or
            fellowType == fellowTypes.STALWART
        then
            recast = recast + math.random(8, 12)
        end

        for _, cure in pairs(cureTable) do
            if
                cure.level <= fellowLvl and
                cure.mpCost <= mp
            then
                -- Get that weak shit out of here
                if
                    cure.spell == xi.magic.spell.CURE and
                    master:getMainLvl() > 30
                then
                    return

                elseif
                    (fellowType == fellowTypes.HEALER or
                    fellowType == fellowTypes.SOOTHING) and
                    fellow:getHPP() < 30 and
                    master:getHPP() > 40
                then

                    if cure.hpThreshold <= fellowHP then
                        fellow:setLocalVar("castingCoolDown", os.time() + recast)
                        fellow:castSpell(cure.spell, fellow)
                        return
                    end
                else
                    if
                        fellowType == fellowTypes.SHIELD or
                        fellowType == fellowTypes.STALWART
                    then
                        if cure.hpThreshold * 1.25 <= fellowHP then
                            fellow:setLocalVar("castingCoolDown", os.time() + recast)
                            fellow:castSpell(cure.spell, fellow)
                            return
                        elseif cure.hpThreshold * 2.5 <= masterHP then
                            fellow:setLocalVar("castingCoolDown", os.time() + recast)
                            fellow:castSpell(cure.spell, master)
                            return
                        end
                    else
                        if cure.hpThreshold <= masterHP then
                            fellow:setLocalVar("castingCoolDown", os.time() + recast)
                            fellow:castSpell(cure.spell, master)
                            return
                        elseif cure.hpThreshold <= fellowHP then
                            fellow:setLocalVar("castingCoolDown", os.time() + recast)
                            fellow:castSpell(cure.spell, fellow)
                            return
                        end
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
    local coolDown      = fellow:getLocalVar("castingCoolDown")
    local recast        = xi.fellow_utils.calculateRecast(fellow, fellowType)

    if coolDown < os.time() then
        for _, debuff in pairs(ailmentTable) do
            if
                debuff.level <= fellowLvl and
                debuff.mpCost <= mp
            then
                if master:hasStatusEffect(debuff.effect) then
                    fellow:setLocalVar("castingCoolDown", os.time() + recast)
                    fellow:castSpell(debuff.spell, master)
                    return
                end
            end
        end

        for _, debuff in pairs(ailmentTable) do
            if
                debuff.level <= fellowLvl and
                debuff.mpCost <= mp and
                debuff.selfTarget
            then
                if fellow:hasStatusEffect(debuff.effect) then
                    fellow:setLocalVar("castingCoolDown", os.time() + recast)
                    fellow:castSpell(debuff.spell, fellow)
                    return
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Function: checkBuff
--    Notes: checkBuff loops through the table of potential buffs that the
--           fellow will attempt to cast. This table is sorted by priority.
--           Fellows will not cast haste or refresh in certain cases. Fellows
--           will not cast refresh on the player if they have less than 40 MP or
--           they have full MP. Fellows will not cast haste on the following jobs:
--           BLM, RNG, SMN, COR, SCH
-------------------------------------------------------------------------------
xi.fellow_utils.checkBuff = function(fellow, master, fellowLvl, mp, fellowType)
    local coolDown = fellow:getLocalVar("castingCoolDown")
    local recast   = xi.fellow_utils.calculateRecast(fellow, fellowType)
    local job      = master:getMainJob()


    if coolDown < os.time() then
        for _, buff in pairs(buffTable) do
            if
                buff.level <= fellowLvl and
                buff.mpCost <= mp
            then
                -- Case for Refresh + Haste
                if
                    (buff.effect == xi.effect.REFRESH and
                    (master:getMP() < 40 or
                    master:getMP() == master:getMaxMP()))
                    or
                    (buff.effect == xi.effect.HASTE and
                    (job == xi.job.BLM or
                    job == xi.job.RNG or
                    job == xi.job.SMN or
                    job == xi.job.COR or
                    job == xi.job.SCH))
                    and
                    fellow:actionQueueEmpty()
                then
                    buff.targetMaster = false
                end

                if not fellow:hasStatusEffect(buff.effect) then
                    fellow:setLocalVar("castingCoolDown", os.time() + recast)
                    fellow:castSpell(buff.spell, fellow)
                    return

                elseif
                    not master:hasStatusEffect(buff.effect) and
                    buff.targetMaster
                then
                    fellow:setLocalVar("castingCoolDown", os.time() + recast)
                    fellow:castSpell(buff.spell, master)
                    return
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

    if coolDown < os.time() then
        if fellow:isEngaged() then
            target = fellow:getTarget()
        elseif master:isEngaged() then
            target = master:getTarget()
        end

        for _, debuff in pairs(debuffTable) do
            if
                debuff.level <= fellowLvl and
                debuff.mpCost <= mp and
                target ~= nil
            then
                if
                    not target:hasStatusEffect(debuff.effect) and
                    (not target:hasImmunity(debuff.immunity) or
                    debuff.immunity == 0) and
                    target:isEngaged()
                then
                    if
                        (debuff.effect == xi.effect.SILENCE and
                        not target:hasSpellList()) or
                        (target:hasStatusEffect(xi.effect.BIO) and
                        debuff.effect == xi.effect.DIA)
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
    local otherSignals  = false
    local recast        = 30

    if fellowType == fellowTypes.SHIELD then
        recast = recast + math.random(5, 10)
    end

    if bit.band(optionsMask, bit.lshift(1, 4)) == 16 then
        otherSignals = true
    end

    if master == nil then
        return false
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
                if target:getTarget():getID() ~= fellow:getID() then
                    fellow:useJobAbility(35, target)
                    fellow:setLocalVar("provoke", os.time() + recast)
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)

                -- Uses Provoke on NMs as frequently as possible
                elseif target:isNM() then
                    fellow:useJobAbility(35, target)
                    fellow:setLocalVar("provoke", os.time() + recast)
                    master:showText(fellow, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)
                end
            end
        end
    end

    return false
end

xi.fellow_utils.calculateRecast = function(fellow, fellowType)
    local recast = math.random(4, 6)

    if fellowType == fellowTypes.HEALER then
        recast = recast + math.random(3, 4)
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
    local kills         = master:getFellowValue("kills")
    local unlocked      = {}
    local armorTable    =
    {
        [1] = { "hands" },
        [2] = { "feet" },
        [3] = { "legs" },
        [4] = { "body" },
    }

    for i, v in ipairs(armorTable) do
        if bit.band(armorLock, bit.lshift(1, i)) == 0 then
            table.insert(unlocked, v[1])
        end
    end

    for i = 1, #unlocked do
        local rank = master:getFellowValue(unlocked[i]) - offset

        if
            armorIndex[rank] <= fellow:getMainLvl() and
            kills >= rank * 15
        then
            master:setFellowValue(unlocked[i], rank + offset + 1)
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

    if job == 1 or job == 4 then
        if pJob == 2 or pJob == 5 then
            master:setCharVar("[FELLOW]armorOffset", -100)
        else
            master:setCharVar("[FELLOW]armorOffset", -200)
        end

    elseif job == 2 or job == 5 then
        if pJob == 1 or pJob == 4 then
            master:setCharVar("[FELLOW]armorOffset", 100)
        else
            master:setCharVar("[FELLOW]armorOffset", -100)
        end

    else
        if pJob == 2 or pJob == 5 then
            master:setCharVar("[FELLOW]armorOffset", 100)
        else
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
