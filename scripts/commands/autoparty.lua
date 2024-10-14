-----------------------------------
-- func: Auto Party
-- desc: Spawns a party in which the player can camp from
-----------------------------------
cmdprops =
{
    permission = 0,
    parameters = ""
}

function cooldownError(player)
    player:PrintToPlayer("Auto party cooldown in effect.")
    print((player:getLocalVar("[AUTO]cooldown") - os.time()) / 60)
end

function inCombat(player)
    player:PrintToPlayer("You cannot call forth a party while in combat.")
end

function levelRequirement(player)
    player:PrintToPlayer("You must be level 10 in order to summon forth a party.")
end

function onTrigger(player)
    local cooldown = 900 -- time in seconds (15 min)

    if player:isEngaged() then
        inCombat(player)

    elseif player:getMainLvl() < 10 then
        levelRequirement(player)

    -- elseif GetServerVariable("[AUTO]cooldown") < os.time() then
    elseif player:getLocalVar("[AUTO]cooldown") < os.time() then
        player:setLocalVar("[AUTO]cooldown", os.time() + cooldown)
        xi.autoparty.createParty(player)

    else
        cooldownError(player)
    end
end
