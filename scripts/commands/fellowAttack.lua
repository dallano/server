-----------------------------------
-- func: fellowAttack <target>
-- desc: Commands the player's fellow to attack
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
    player:PrintToPlayer("Must target something before using command")
end

function onTrigger(player)
    local target = player:getCursorTarget()

    if target ~= nil then
        player:fellowAttack(target)
    end
end
