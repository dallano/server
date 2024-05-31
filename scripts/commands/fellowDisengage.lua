-----------------------------------
-- func: fellowDisengage
-- desc: Commands the player's fellow to attack
-----------------------------------
-----------------------------------
require("scripts/globals/fellow_utils")
-----------------------------------
cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("")
end

function onTrigger(player)
    local party = player:getPartyWithTrusts()

    player:fellowRetreat()
    player:setCharVar("fellowAttackControl", 0)

    for _, member in pairs(party) do
        if member:getObjType() == xi.objType.TRUST then
            member:trustRetreat()
        end
    end
end
