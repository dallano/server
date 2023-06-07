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
    player:fellowRetreat()
end
