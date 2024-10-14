
-----------------------------------
-- Auto Party
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.autoparty = {}

local cureTablePLD =
{
    { spell = xi.magic.spell.CURE_IV,  level = 55, mpCost =  88, hpThreshold = 400 },
    { spell = xi.magic.spell.CURE_III, level = 30, mpCost =  46, hpThreshold = 200 },
    { spell = xi.magic.spell.CURE_II,  level = 17, mpCost =  24, hpThreshold = 110 },
    { spell = xi.magic.spell.CURE,     level =  5, mpCost =   8, hpThreshold = 45  },
}

local cureTableWHM =
{
    { spell = xi.magic.spell.CURE_IV,  level = 61, mpCost = 135, hpThreshold = 600 },
    { spell = xi.magic.spell.CURE_IV,  level = 41, mpCost =  88, hpThreshold = 400 },
    { spell = xi.magic.spell.CURE_III, level = 21, mpCost =  46, hpThreshold = 200 },
    { spell = xi.magic.spell.CURE_II,  level = 11, mpCost =  24, hpThreshold = 110 },
    { spell = xi.magic.spell.CURE,     level =  1, mpCost =   8, hpThreshold = 45  },
}

local cureTableRDM =
{
    { spell = xi.magic.spell.CURE_IV,  level = 48, mpCost =  88, hpThreshold = 400 },
    { spell = xi.magic.spell.CURE_III, level = 26, mpCost =  46, hpThreshold = 200 },
    { spell = xi.magic.spell.CURE_II,  level = 14, mpCost =  24, hpThreshold = 110 },
    { spell = xi.magic.spell.CURE,     level =  3, mpCost =   8, hpThreshold = 50  },
}

local cureTableSJ =
{
    { spell = xi.magic.spell.CURE_III, level = 60, mpCost =  46, hpThreshold = 200 },
    { spell = xi.magic.spell.CURE_II,  level = 24, mpCost =  24, hpThreshold = 120 },
    { spell = xi.magic.spell.CURE,     level =  6, mpCost =   8, hpThreshold = 45  },
}

local ailmentTable =
{
    { effect = xi.effect.DOOM,          spell = xi.magic.spell.ERASE,    level = 32, mpCost = 18, selfTarget =  true },
    { effect = xi.effect.SLEEP_I,       spell = xi.magic.spell.CURE,     level =  1, mpCost =  8, selfTarget = false },
    { effect = xi.effect.SLEEP_II,      spell = xi.magic.spell.CURE,     level =  1, mpCost =  8, selfTarget = false },
    { effect = xi.effect.LULLABY,       spell = xi.magic.spell.CURE,     level =  1, mpCost =  8, selfTarget = false },
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

local regenTable =
{
    { effect = xi.effect.REGEN, spell = xi.magic.spell.REGEN_III, level = 66, mpCost = 64 },
    { effect = xi.effect.REGEN, spell = xi.magic.spell.REGEN_II,  level = 44, mpCost = 36 },
    { effect = xi.effect.REGEN, spell = xi.magic.spell.REGEN,     level = 21, mpCost = 15 },
}

local healerBuffTable =
{
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_V,   level = 75, mpCost = 84, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_IV,  level = 68, mpCost = 65, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_III, level = 47, mpCost = 46, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA_II,  level = 27, mpCost = 28, targetOther = false },
    { effect = xi.effect.PROTECT,   spell = xi.magic.spell.PROTECTRA,     level =  7, mpCost =  9, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_V,     level = 75, mpCost = 93, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_IV,    level = 68, mpCost = 75, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_III,   level = 57, mpCost = 56, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA_II,    level = 37, mpCost = 37, targetOther = false },
    { effect = xi.effect.SHELL,     spell = xi.magic.spell.SHELLRA,       level = 17, mpCost = 18, targetOther = false },
    { effect = xi.effect.HASTE,     spell = xi.magic.spell.HASTE,         level = 40, mpCost = 40, targetOther = true  },
    { effect = xi.effect.STONESKIN, spell = xi.magic.spell.STONESKIN,     level = 28, mpCost = 29, targetOther = false },
    { effect = xi.effect.BLINK,     spell = xi.magic.spell.BLINK,         level = 19, mpCost = 20, targetOther = false },
}

local bardRoamTable =
{
    { spell = xi.magic.spell.MAGES_BALLAD_II, effect = xi.effect.BALLAD,  level = 55 },
    { spell = xi.magic.spell.MAGES_BALLAD,    effect = xi.effect.BALLAD,  level = 25 },
}

local bardFightTable =
{
    -- { spell = xi.magic.spell.VICTORY_MARCH,   effect = xi.effect.MARCH,    level = 60 },
    { spell = xi.magic.spell.MAGES_BALLAD_II, effect = xi.effect.BALLAD,   level = 55 },
    { spell = xi.magic.spell.BLADE_MADRIGAL,  effect = xi.effect.MADRIGAL, level = 51 },
    -- { spell = xi.magic.spell.ADVANCING_MARCH, effect = xi.effect.MARCH,    level = 29 },
    { spell = xi.magic.spell.MAGES_BALLAD,    effect = xi.effect.BALLAD,   level = 25 },
    { spell = xi.magic.spell.SWORD_MADRIGAL,  effect = xi.effect.MADRIGAL, level = 11 },
}

local bardDebuffTable =
{
    { spell = xi.magic.spell.CARNAGE_ELEGY,     effect = xi.effect.ELEGY, level = 59 },
    { spell = xi.magic.spell.BATTLEFIELD_ELEGY, effect = xi.effect.ELEGY, level = 39 },
}

local blmSpellTable =
{
    [1] =
    {
        { spell = xi.magic.spell.QUAKE_II,  level = 75, hpp = 70 },
        { spell = xi.magic.spell.QUAKE,     level = 54, hpp = 70 },
        { spell = xi.magic.spell.STONE_IV,  level = 68, hpp = 40 },
        { spell = xi.magic.spell.STONE_III, level = 51, hpp = 10 },
        { spell = xi.magic.spell.STONE_II,  level = 26, hpp = 0  },
        { spell = xi.magic.spell.STONE,     level = 1,  hpp = 0  },
    },
    [2] =
    {
        { spell = xi.magic.spell.FLOOD_II,  level = 75, hpp = 70 },
        { spell = xi.magic.spell.WATER_IV,  level = 70, hpp = 70 },
        { spell = xi.magic.spell.FLOOD,     level = 58, hpp = 40 },
        { spell = xi.magic.spell.WATER_III, level = 55, hpp = 10 },
        { spell = xi.magic.spell.WATER_II,  level = 30, hpp = 0  },
        { spell = xi.magic.spell.WATER,     level = 5,  hpp = 0  },
    },
    [3] =
    {
        { spell = xi.magic.spell.TORNADO_II, level = 75, hpp = 70 },
        { spell = xi.magic.spell.AERO_IV,    level = 72, hpp = 70 },
        { spell = xi.magic.spell.TORNADO,    level = 52, hpp = 40 },
        { spell = xi.magic.spell.AERO_III,   level = 59, hpp = 10 },
        { spell = xi.magic.spell.AERO_II,    level = 34, hpp = 0  },
        { spell = xi.magic.spell.AERO,       level = 9,  hpp = 0  },
    },
    [4] =
    {
        { spell = xi.magic.spell.FLARE_II, level = 75, hpp = 70 },
        { spell = xi.magic.spell.FLARE,    level = 60, hpp = 70 },
        { spell = xi.magic.spell.FIRE_IV,  level = 73, hpp = 40 },
        { spell = xi.magic.spell.FIRE_III, level = 62, hpp = 10 },
        { spell = xi.magic.spell.FIRE_II,  level = 38, hpp = 0  },
        { spell = xi.magic.spell.FIRE,     level = 13, hpp = 0  },
    },
    [5] =
    {
        { spell = xi.magic.spell.FREEZE_II,    level = 75, hpp = 70 },
        { spell = xi.magic.spell.FREEZE,       level = 50, hpp = 70 },
        { spell = xi.magic.spell.BLIZZARD_IV,  level = 74, hpp = 40 },
        { spell = xi.magic.spell.BLIZZARD_III, level = 64, hpp = 10 },
        { spell = xi.magic.spell.BLIZZARD_II,  level = 42, hpp = 0  },
        { spell = xi.magic.spell.BLIZZARD,     level = 17, hpp = 0  },
    },
    [6] =
    {
        { spell = xi.magic.spell.BURST_II,    level = 75, hpp = 70 },
        { spell = xi.magic.spell.BURST,       level = 56, hpp = 70 },
        { spell = xi.magic.spell.THUNDER_IV,  level = 75, hpp = 40 },
        { spell = xi.magic.spell.THUNDER_III, level = 66, hpp = 10 },
        { spell = xi.magic.spell.THUNDER_II,  level = 46, hpp = 0  },
        { spell = xi.magic.spell.THUNDER,     level = 21, hpp = 0  },
    },
}

local tankJobAbilityTable =
{
    { ability = xi.jobAbility.RAMPART,     level = 62, recast = 180,  hppThreshold = 45,  isValid = true,  self = true,  recastVar = "[TRUST]rampartRecast"    },
    { ability = xi.jobAbility.SENTINEL,    level = 30, recast = 300,  hppThreshold = 60,  isValid = true,  self = true,  recastVar = "[TRUST]sentinelRecast"   },
    { ability = xi.jobAbility.DEFENDER,    level = 25, recast = 180,  hppThreshold = 100, isValid = true,  self = true,  recastVar = "[TRUST]defenderRecast"   },
    -- { ability = xi.jobAbility.SHIELD_BASH, level = 15, recast = 300,  hppThreshold = 100, isValid = false, self = false, recastVar = "[TRUST]shieldBashRecast" },
    { ability = xi.jobAbility.INVINCIBLE,  level = 1,  recast = 7200, hppThreshold = 25,  isValid = true,  self = true,  recastVar = "[TRUST]twoHourRecast"    },
}

xi.autoparty.buildTable = function(player)
    local party   = {}
    local tank    = {}
    local damage  = {}
    local support = {}
    local healer  = {}
    local mage    = {}

    -- Tank Section -----------------------------------------------
    -- Rank 10 San d'Orian
    if player:getRank(xi.nation.SANDORIA) == 10 then
        table.insert(tank, 905) -- Trion (PLD)
    else
        -- Unlock DRG
        if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) then
            table.insert(tank, 951) -- Rahal (PLD)
        end
        -- Complete San d'Orian Mission 3-1
        if player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.INFILTRATE_DAVOI) then
            table.insert(tank, 902) -- Curilla (PLD)
        end
    end

    -- Damage Section -----------------------------------------------
    -- Unlock DRK
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) then
        table.insert(damage, 906) -- Zeid (DRK)
    end
    -- Finish Bastok Mission 3-1
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_FOUR_MUSKETEERS) then
        table.insert(damage, 900) -- Ayame (SAM)
    end
    -- Finish Darkness Named
    if
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and
        player:getCurrentMission(xi.mission.log_id.COP) ~= xi.mission.id.cop.THE_WARRIORS_PATH
    then
        table.insert(damage, 908) -- Tenzen (SAM)
    end
    -- WAR AF
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN) then
        table.insert(damage, 917) -- Iron Eater (WAR)
    end

    -- -- Support Section -----------------------------------------------
    -- Unlock COR
    if player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW) then
        table.insert(support, 967) -- Qultada (COR)
    end
    -- Complete CoP 2-4 An Eternal Memory
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY) then
        table.insert(support, 914) -- Ulmia (BRD)
    end

    -- Mage Section -----------------------------------------------
    -- Begin SMN quest
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) >= QUEST_ACCEPTED then
        table.insert(mage, 904) -- Ajido-Marujido (BLM)
    end

    -- Healer Section -----------------------------------------------
    -- BLM Final AF
    if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM) then
        table.insert(healer, 952) -- Koru-Moru (WHM)
    end
    -- WHM Final AF
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION) then
        table.insert(healer, 953) -- Pieuje (WHM)
    end
    -- Complete Madragora mad a certain amount of times
    if player:getCharVar("[TRUST]yoranCount") >= 10 then
        table.insert(healer, 980) -- Yoran-Oran (WHM)
    end
    -- RDM Final AF
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) then
        table.insert(support, 920) -- Rainemard (RDM)
    end
    -- --------------------------------------------------------------

    -- Build final party from random members
    if #tank > 0 then
        table.insert(party, tank[math.random(1, #tank)])
    end
    if #damage > 0 then
        table.insert(party, damage[math.random(1, #damage)])
    end
    if #mage > 0 then
        table.insert(party, mage[math.random(1, #mage)])
    end
    if #healer > 0 then
        table.insert(party, healer[math.random(1, #healer)])
    end
    if #support > 0 then
        table.insert(party, support[math.random(1, #support)])
    end

    return party
end

xi.autoparty.createParty = function(player)
    local party = xi.autoparty.buildTable(player)
    local counter = 1

    player:clearTrusts()

    for _, id in pairs(party) do
        player:timer(counter * 1000, function(playerArg)
            playerArg:spawnTrust(id)
        end)
        counter = counter + 4
    end
end

xi.autoparty.onTrustSpawn = function(trust)
    trust:setLocalVar("spellRecast", os.time() + 5)
    xi.autopartybuffs.applyEquipmentBuffs(trust)
end

xi.autoparty.onTankSpawn = function(trust, power)
    xi.autoparty.onTrustSpawn(trust)
    local lvl = trust:getMainLvl()

    trust:addMod(xi.mod.ATT, -25 + lvl)
    trust:addMod(xi.mod.ENMITY, power + 5)
end

xi.autoparty.onHealerRoam = function(trust)
    local master = trust:getMaster()
    local lvl    = trust:getMainLvl()
    local mp     = trust:getMP()

    if trust:actionQueueEmpty() then
        if trust:getCurrentAction() == xi.act.MAGIC_CASTING then
            return
        end

        xi.autoparty.healercheckAilment(trust, master, lvl, mp)
        xi.autoparty.healercheckRegen(trust, master, lvl, mp)
        xi.autoparty.healercheckBuff(trust, master, lvl, mp)
        xi.autoparty.checkCure(trust, master)
    end
end

xi.autoparty.onHealerFight = function(trust, target)
    local master = trust:getMaster()
    local lvl    = trust:getMainLvl()
    local mp     = trust:getMP()

    if trust:actionQueueEmpty() and target:isAlive() then
        xi.autoparty.healercheckAilment(trust, master, lvl, mp)
        xi.autoparty.checkCure(trust, master)
        xi.autoparty.healercheckRegen(trust, master, lvl, mp)
        xi.autoparty.healercheckBuff(trust, master, lvl, mp)
    end
end

xi.autoparty.healercheckAilment = function(trust, master, trustLvl, mp)
    if trust:getCurrentAction() == xi.act.MAGIC_CASTING then
        return
    end

    local party = master:getPartyWithTrusts()
    local job   = trust:getMainJob()

    -- Check first to see if anyone is in danger
    for _, member in pairs(party) do
        if member:getHPP() < 60 then
            return
        end
    end

    if trust:getLocalVar("spellRecast") < os.time() then
        for _, debuff in pairs(ailmentTable) do
            if
                debuff.level <= trustLvl and
                debuff.mpCost <= mp
            then
                -- Prioritize self if we can remove the effect
                if debuff.selfTarget then
                    if trust:hasStatusEffect(debuff.effect) then
                        trust:castSpell(debuff.spell, trust)
                        xi.autoparty.calculateRecast(trust, job)
                        return
                    end
                end

                for _, member in pairs(party) do
                    if member:hasStatusEffect(debuff.effect) then
                        trust:castSpell(debuff.spell, member)
                        xi.autoparty.calculateRecast(trust, job)
                        return
                    end
                end
            end
        end
    end
end

xi.autoparty.healercheckRegen = function(trust, master, trustLvl, mp)
    if trust:getCurrentAction() == xi.act.MAGIC_CASTING then
        return
    end

    if trust:getLocalVar("spellRecast") < os.time() then
        local party = master:getPartyWithTrusts()

        -- Check first if a member is in drastic need of curing
        for _, member in pairs(party) do
            if member:getHPP() < 40 then
                return
            end
        end

        for _, regen in pairs(regenTable) do
            if
                regen.level <= trustLvl and
                regen.mpCost <= mp
            then
                for _, member in pairs(party) do
                    if
                        not member:hasStatusEffect(regen.effect) and
                        member:getHPP() <= 85
                    then
                        trust:castSpell(regen.spell, member)
                        xi.autoparty.calculateRecast(trust, trust:getMainJob())
                        return
                    end
                end
            end
        end
    end
end

xi.autoparty.healercheckBuff = function(trust, master, trustLvl, mp)
    if trust:getCurrentAction() == xi.act.MAGIC_CASTING then
        return
    end

    if trust:getLocalVar("spellRecast") < os.time() then
        local party = master:getPartyWithTrusts()

        for _, buff in pairs(healerBuffTable) do
            for _, member in pairs(party) do
                local check = true
                local target = trust
                local job = target:getMainJob()

                if
                    buff.level <= trustLvl and
                    buff.mpCost <= mp
                then
                    if buff.targetOther then
                        target = member
                    end

                    if
                        buff.effect == xi.effect.HASTE and
                        not target:isEngaged()
                    then
                        check = false

                        if not target:isPC() and (job ~= xi.job.WHM or job ~= xi.job.BRD or job ~= xi.job.BLM or job ~= xi.job.RDM) then
                            check = false
                        end
                    end

                    if check and not target:hasStatusEffect(buff.effect) then
                        trust:castSpell(buff.spell, target)
                        xi.autoparty.calculateRecast(trust, trust:getMainJob())
                        return
                    end
                end
            end
        end
    end
end

xi.autoparty.onTankRoam = function(trust)
    local master   = trust:getMaster()
    local party    = master:getPartyWithTrusts()
    local mobs     = master:getZone():getMobs()
    local distance = 45

    if
        master:getLocalVar("[AUTO]onslaught") == 1 and
        trust:getHPP() > 65
    then

        if #mobs > 0 then
            for _, target in pairs(mobs) do
                if
                    master:checkDistance(target) < distance and
                    target:isAlive() and
                    not target:isNM()
                then
                    for _, member in pairs(party) do
                        if member:getObjType() == xi.objType.TRUST then
                            member:trustAttack(target)
                        end
                    end
                    -- return
                end
            end
        end
    else
        for _, member in pairs(party) do
            if member:getObjType() == xi.objType.TRUST then
                member:trustRetreat()
            end
        end
    end
end

xi.autoparty.onTankFight = function(trust, target)
    local master = trust:getMaster()

    if trust:actionQueueEmpty() and target:isAlive() then
        xi.autoparty.checkProvoke(trust, target, master)
        xi.autoparty.checkCure(trust, master)
        xi.autoparty.tankJobAbility(trust, master)
    end
end

xi.autoparty.tankJobAbility = function(trust, master)
    target = trust:getTarget()

    if trust:getLocalVar("abilityRecast") < os.time() then
        for _, ability in pairs(tankJobAbilityTable) do
            local recast = master:getCharVar(ability.recastVar)

            if
                trust:getMainLvl() > ability.level and
                trust:getHPP() <= ability.hppThreshold and
                recast < os.time()
            then
                trust:useJobAbility(ability.ability, trust)
                trust:setLocalVar("abilityRecast", os.time() + math.random(5, 10))
            end
        end
    end
end

xi.autoparty.checkCure = function(trust, master)
    if trust:getCurrentAction() == xi.act.MAGIC_CASTING then
        return
    end

    local party        = master:getPartyWithTrusts()
    local job          = trust:getMainJob()
    local table        = {}
    local thresholdMod = 1

    -- Choose table based on job.
    if job == xi.job.PLD then
        table = cureTablePLD
    elseif job == xi.job.WHM then
        table = cureTableWHM
    elseif job == xi.job.RDM then
        table = cureTableRDM
    else
        table = cureTableSJ
    end

    if trust:getLocalVar("spellRecast") < os.time() then
        for _, cure in pairs(table) do
            if
                cure.level <= trust:getMainLvl() and
                cure.mpCost <= trust:getMP()
            then
                for _, member in pairs(party) do
                    -- Don't cast cure at higher levels
                    if
                        cure.spell == xi.magic.spell.CURE and
                        trust:getMainLvl() >= 35
                    then
                        return
                    end
                    -- Heal self more wilingly than others if PLD.
                    -- RDM and WHM will prioritize cures normally
                    -- Otherwise have less prioritization on cures
                    if
                        (member == trust and
                        job == xi.job.PLD)
                    then
                        thresholdMod = 0.9
                    elseif job == xi.job.RDM or job == xi.job.WHM then
                        thresholMod = 1.0
                    else
                        thresholdMod = 1.35
                    end

                    -- Heal less if target has casted regen effect
                    if
                        member:hasStatusEffect(xi.effect.REGEN) and
                        member:getHPP() > 35
                    then
                        thresholdMod = thresholdMod + 0.35
                    end

                    -- If target is in danger. Cure ASAP!
                    if member:getHPP() < 35 then
                        thresholdMod = 1
                    end

                    -- Core check to cure.
                    -- Final Check before healing party member
                    if member:getMaxHP() - member:getHP() > cure.hpThreshold * thresholdMod then
                        xi.autoparty.calculateRecast(trust, job)
                        trust:castSpell(cure.spell, member)
                        return
                    end
                end
            end
        end
    end
end

xi.autoparty.checkProvoke = function(trust, target, master)
    if
        (trust:getHPP() > 25 or
        master:getHPP() < 10) and
        trust:getLocalVar("provoke") < os.time() and
        trust:checkDistance(target) <= 15
    then
        if
            target:getTarget() ~= trust or
            target:isNM()
        then
            trust:useJobAbility(xi.jobAbility.PROVOKE, target)
            trust:setLocalVar("provoke", os.time() + 30)
        end

        if
            trust:getMainLvl() >= 37 and
            trust:getMP() > 25 and
            trust:getLocalVar("flash") < os.time()
        then
            trust:castSpell(xi.magic.spell.FLASH, target)
            trust:setLocalVar("flash", os.time() + 45)
        end
    end
end

xi.autoparty.onBardRoam = function(trust)
    if trust:actionQueueEmpty() then
        if trust:getCurrentAction() == xi.act.MAGIC_CASTING then
            return
        end

        if
            trust:getLocalVar("spellRecast") < os.time() and
            trust:checkDistance(trust:getMaster()) <= 11
        then
            for _, spell in pairs(bardRoamTable) do
                if
                    not trust:hasStatusEffect(spell.effect) and
                    trust:getMainLvl() >= spell.level
                then
                    trust:getMaster():PrintToPlayer("Gather together! Casting a ballad spell.", xi.msg.channel.PARTY, "Ulmia")
                    trust:castSpell(spell.spell, trust)
                    xi.autoparty.calculateRecast(trust, trust:getMainJob())
                    return
                end
            end
        end
    end
end

xi.autoparty.onBardFight = function(trust, target)
    if
        trust:getLocalVar("spellRecast") < os.time() and
        trust:checkDistance(target) <= 9
    then
        for _, spell in pairs(bardFightTable) do
            if
                not trust:hasStatusEffect(spell.effect) and
                trust:getMainLvl() >= spell.level
            then
                trust:castSpell(spell.spell, trust)
                trust:setLocalVar("spellRecast", 5 + os.time())
                return
            end
        end

        for _, spell in pairs(bardDebuffTable) do
            if
                not target:hasStatusEffect(spell.effect) and
                trust:getMainLvl() >= spell.level and
                target
            then
                trust:castSpell(spell.spell, target)
                trust:setLocalVar("spellRecast", 5 + os.time())
                return
            end
        end
    end
end

xi.autoparty.onMageFight = function(trust, target)
    local job   = trust:getMainJob()
    local table = blmSpellTable[math.random(1, 6)]

    if trust:getLocalVar("spellRecast") < os.time() then
        for _, spell in pairs(table) do
            if
                target:getTarget() ~= trust and       -- Don't attack if we have agro
                trust:getMainLvl() >= spell.level and -- Check if we can cast spell
                target:getHPP() > spell.hpp and       -- Check for tier of spell that we can cast
                trust:getBattleTime() >= 15 and       -- Only cast 15 seconds into battle
                trust:getHPP() > 75
            then
                trust:castSpell(spell.spell, target)
                xi.autoparty.calculateRecast(trust, job)
                return
            end
        end
    end
end

xi.autoparty.calculateRecast = function(trust, job)
    local recast

    if job == xi.job.WHM or job == xi.job.RDM then
        recast = math.random(1, 2)
    elseif job == xi.job.PLD then
        recast = math.random(7, 12)
    elseif job == xi.job.BLM then
        recast = math.random(18, 25)
        recast = trust:getMainLvl() / 2 -- BLM get way too much hate at higher levels
    else
        recast = math.random(18, 25)
    end

    trust:setLocalVar("spellRecast", recast + os.time())
end
