-----------------------------------
-- func: !onslaught
-- desc: Causes player's trusts to attack all mobs in area
-----------------------------------
require("scripts/globals/fellow_utils")
-----------------------------------
cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player)
    player:PrintToPlayer("You do not have a party.")
end

function lvlError(player)
    player:PrintToPlayer("You must be level 75 in order to use the onslaught function.")
end

function onTrigger(player)
    local party = player:getPartyWithTrusts()

    if player:getMainLvl() < 75 then
        lvlError(player)
    elseif #party > 1 then
        local var = 0
        
        if player:getLocalVar("[AUTO]onslaught") == 0 then
            var = 1
        end

        player:setLocalVar("[AUTO]onslaught", var)
    else
        error(player)
    end
end
