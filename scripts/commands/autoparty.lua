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
end

function error(player)
    player:PrintToPlayer("An error occured.")
end

function onTrigger(player)
    local cooldown = 1800 -- time in seconds (30 min)

    if
        GetServerVariable("[AUTO]partyEnabled") == 0 and
        GetServerVariable("[AUTO]cooldown") < os.time()
    then
        SetServerVariable("[AUTO]partyEnabled", 1)
        SetServerVariable("[AUTO]cooldown", os.time() + cooldown)
        xi.autoparty.createParty(player, player:getZone(), player:getPos())
        -- Set as a safe guard. This will despawn the camp mobs when player zones away
        player:setLocalVar("[AUTO]debug", 1)

    elseif os.time() > GetServerVariable("[AUTO]cooldown") then
        cooldownError(player)

    elseif GetServerVariable("[AUTO]partyEnabled") == 1 then
        SetServerVariable("[AUTO]partyEnabled", 0)
        DespawnMob(player:getLocalVar("[AUTO]tank"))
        DespawnMob(player:getLocalVar("[AUTO]healer"))
        DespawnMob(player:getLocalVar("[AUTO]damage"))
        DespawnMob(player:getLocalVar("[AUTO]puller"))
        player:setLocalVar("[AUTO]debug", 0)

    else
        error(player)
    end
end
