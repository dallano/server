
-----------------------------------
-- Auto Party
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.autoparty = {}

xi.autoparty.buildTable = function(player)
    local party   = {}
    local tank    = {}
    local damage  = {}
    local support = {}
    local healer  = {}
    local range   = {}

    -- Tank Section -----------------------------------------------
    -- Unlock DRG
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) then
        table.insert(tank, 951) -- Rahal (PLD)
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
    -- WAR AF
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN) then
        table.insert(damage, 917) -- Iron Eater (WAR)
    end
    -- --------------------------------------------------------------

    -- Support Section -----------------------------------------------
    -- RDM Final AF
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) then
        table.insert(support, 920) -- Rainemard (RDM)
    end
    -- Unlock COR
    if player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW) then
        table.insert(support, 967) -- Qultada (COR)
    end
    -- --------------------------------------------------------------

    -- Range Section -----------------------------------------------
    -- Unlock Smn
    if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) then
        table.insert(healer, 904) -- Ajido-Marujido (BLM)
    end
    -- --------------------------------------------------------------

    -- Healer Section -----------------------------------------------
    -- BLM Final AF
    if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM) then
        table.insert(healer, 952) -- Koru-Moru (WHM)
    end
    -- WHM Final AF
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION) then
        table.insert(healer, 953) -- Pieuje (WHM)
    end
    -- --------------------------------------------------------------

    -- Build final party from random members
    if #tank > 0 then
        table.insert(party, tank[math.random(1, #tank)])
    end
    if #damage > 0 then
        table.insert(party, damage[math.random(1, #damage)])
    end
    if #range > 0 then
        table.insert(party, range[math.random(1, #range)])
    end
    if #support > 0 then
        table.insert(party, support[math.random(1, #support)])
    end
    if #healer > 0 then
        table.insert(party, healer[math.random(1, #healer)])
    end

    return party
end

xi.autoparty.createParty = function(player)
    local party = xi.autoparty.buildTable(player)
    local counter = 0

    player:clearTrusts()

    for _, id in pairs(party) do
        counter = counter + 1
        player:spawnTrust(id)
    end
end

xi.autoparty.onTankRoam = function(trust)
    xi.autoparty.checkCure(trust)
end

xi.autoparty.onTankFight = function(trust, target)
    if trust:actionQueueEmpty() then
        xi.autoparty.checkProvoke(trust, target)
    end
end

xi.autoparty.checkCure = function(trust)
    local master = trust:getMaster()
end

xi.autoparty.checkProvoke = function(trust, target)
    local master = trust:getMaster()
    if
        (trust:getHPP() > 25 or
        master:getHPP() < 10) and
        trust:getLocalVar("provoke") < os.time()
    then
        if
            target:getTarget():getID() ~= trust:getID() or
            target:isNM()
        then
            trust:useJobAbility(xi.jobAbility.PROVOKE, target)
            trust:setLocalVar("provoke", os.time() + 30)
        end

        if
            trust:getTarget():getID() ~= trust:getID() or
            trust:getMainLvl() >= 37 and
            trust:getMP() > 25 and
            trust:getLocalVar("flash") < os.time()
        then
            trust:castSpell(xi.magic.spell.FLASH, target)
            trust:setLocalVar("flash", os.time() + 45)
        end
    end
end
