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
    player:PrintToPlayer("No fellow detected.")
end

function onTrigger(player)
    local fellow = player:getFellow()
    local var    = fellow:getLocalVar("onslaught")

    if fellow ~= nil then
        if var == 1 then
            fellow:setLocalVar("onslaught", 0)
        else
            fellow:setLocalVar("onslaught", 1)
        end
    else
        error(player)
    end
end
