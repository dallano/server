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

function error(player)
    player:PrintToPlayer("Target is not valid.")
end

function onTrigger(player)
    local target = player:getCursorTarget()
    local party = player:getPartyWithTrusts()

    if
        target ~= nil and
        target:isMob()
    then
        player:fellowAttack(target)
        player:setCharVar("fellowAttackControl", 1)

        for _, member in pairs(party) do
            if member:getObjType() == xi.objType.TRUST then
                member:engage(target:getID())
            end
        end
    else
        error(player)
    end
end
