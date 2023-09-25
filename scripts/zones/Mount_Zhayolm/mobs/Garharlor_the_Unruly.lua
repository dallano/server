-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Garharlor the Unruly
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Give time for followers to spawn
    mob:timer(5000, function(mobArg)
        for i = 1, 2 do
            xi.follow.follow(GetMobByID(mobArg:getID() + i), mobArg)
        end
    end)

    -- mob:setMod(xi.mod.DEFP, 40)
end

entity.onMobFight = function(mob, target)
    -- Claimed to have extra defense when followers are alive. Requires verification.
    -- local defp = 0

    -- for i = 1, 2 do
    --     if GetMobByID(mob:getID() + i):isAlive() then
    --         defp = defp + 20
    --     end
    -- end

    -- mob:setMod(xi.mod.DEFP, defp)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
