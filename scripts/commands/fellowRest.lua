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
    local fellow = player:getFellow()

    if fellow:hasStatusEffect(xi.effect.HEALING) then
        fellow:delStatusEffect(xi.effect.HEALING)
        print("I'm no longer healing")
    else
        fellow:addStatusEffect(xi.effect.HEALING)
        print("I'm starting to heal")
    end
end
