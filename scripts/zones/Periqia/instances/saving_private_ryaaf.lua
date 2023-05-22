-----------------------------------
-- Assault: Saving Private Ryaaf
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local instanceObject = {}

local savingPrivateRyaafDialogue =
{
    [17006811] = ID.text.RYAAF_DIALOGUE,
    [17006812] = ID.text.BALARAHB_DIALOGUE,
    [17006813] = ID.text.RHAGMAKAH_DIALOGUE,
}

-- Helper function for assault: "Saving Private Ryaaf"
local savingPrivateRyaaf = function(player, npc, instance)
    print(3)
    local id = npc:getID()

    print(3)
    npc:hideName(false)
    npc:setUntargetable(false)
    npc:setAnimation(1)
    print(3)

    npc:showText(npc, savingPrivateRyaafDialogue[id])
    npc:lookAt(player:getPos())

    print(3)
    npc:timer(2000, function(npcArg1)
        npcArg1:showText(npc, savingPrivateRyaafDialogue[id] + 1)

        npcArg1:timer(4000, function(npcArg2)
            npcArg2:showText(npc, savingPrivateRyaafDialogue[id] + 2)

            npcArg2:timer(2000, function(npcArg3)
                npcArg3:showText(npc, savingPrivateRyaafDialogue[id] + 3)
                npcArg3:setStatus(xi.status.DISAPPEAR)
                instance:progressInstance(instance:getProgress() + 1)
            end)
        end)
    end)
end

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SAVING_PRIVATE_RYAAF and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 70
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SAVING_PRIVATE_RYAAF and
        player:getCharVar("assaultEntered") == 0 and
        player:getMainLvl() > 70
end

local ryaafMobs =
{
    17006650, 17006651, 17006652, 17006653, 17006654, 17006655, 17006656, 17006657,
}

local ryaafNPCs =
{
    17006811, 17006812, 17006813,
}

local setTables =
{
    [1] =
    {
        -- Mobs
        [17006650] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry Center)
        [17006651] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry Center)
        [17006652] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006653] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006654] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry East)
        [17006655] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry East)
        [17006656] = { x = -46.800, y = -16.250, z = 295.000, rot = 254 }, -- Experimental Undead (South,  East)
        [17006657] = { x = -229.00, y = -19.250, z = 448.000, rot = 254 }, -- Experimental Undead (West,   East)
        -- NPCs
        [17006811] = { { x = -70.000, y = -19.250, z = 412.000, rot = 60  }, 5 }, -- Ryaaf        (Center, South)
        [17006812] = { { x = -71.000, y = -19.250, z = 588.000, rot = 192 }, 1 }, -- Balarahb     (North,  North)
        [17006813] = { { x = 109.000, y = -19.250, z = 449.000, rot = 254 }, 2 }, -- Rhagmakah    (East,   East)
    },

    [2] =
    {
        -- Mobs
        [17006650] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006651] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006652] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry Center)
        [17006653] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry Center)
        [17006654] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006655] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006656] = { x = 109.000, y = -19.250, z = 449.000, rot = 254 }, -- Experimental Undead (East,   East)
        [17006657] = { x = -46.800, y = -16.250, z = 295.000, rot = 254 }, -- Experimental Undead (South,  East)
        -- NPCs
        [17006811] = { { x = -229.00, y = -19.250, z = 448.000, rot = 128 }, 4 }, -- Ryaaf        (West,   West)
        [17006812] = { { x = -70.000, y = -19.250, z = 412.000, rot = 60  }, 5 }, -- Balarahb     (Center, South)
        [17006813] = { { x = -71.000, y = -19.250, z = 588.000, rot = 192 }, 1 }, -- Rhagmakah    (North,  North)
    },

    [3] =
    {
        -- Mobs
        [17006650] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006651] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry North)
        [17006652] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry East)
        [17006653] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry East)
        [17006654] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry South)
        [17006655] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry South)
        [17006656] = { x = -229.00, y = -19.250, z = 448.000, rot = 254 }, -- Experimental Undead (West,   East)
        [17006657] = { x = -70.000, y = -19.250, z = 412.000, rot = 254 }, -- Experimental Undead (Center, East)
        -- NPCs
        [17006811] = { { x = -71.000, y = -19.250, z = 588.000, rot = 192 }, 1 }, -- Ryaaf        (North,  North)
        [17006812] = { { x = 109.000, y = -19.250, z = 449.000, rot = 254 }, 2 }, -- Balarahb     (East,   East)
        [17006813] = { { x = -46.800, y = -16.250, z = 295.000, rot = 128 }, 3 }, -- Rhagmakah    (South,  West)
    },

    [4] =
    {
        -- Mobs
        [17006650] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry South)
        [17006651] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry South)
        [17006652] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry West)
        [17006653] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry West)
        [17006654] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry Center)
        [17006655] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry Center)
        [17006656] = { x = -70.000, y = -19.250, z = 588.000, rot = 254, }, -- Experimental Undead (North,  East)
        [17006657] = { x = 109.000, y = -19.250, z = 449.000, rot = 254, }, -- Experimental Undead (East,   East)
        -- NPCs
        [17006811] = { { x = 46.800,  y = -16.250, z = 295.000, rot = 128 }, 3 }, -- Ryaaf        (South,  West)
        [17006812] = { { x = 229.00,  y = -19.250, z = 448.000, rot = 128 }, 4 }, -- Balarahb     (West,   West)
        [17006813] = { { x = -70.000, y = -19.250, z = 412.000, rot = 60  }, 5 }, -- Rhagmakah    (Center, South)
    },

    [5] =
    {
        -- Mobs
        [17006650] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry)
        [17006651] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry)
        [17006652] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry)
        [17006653] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry)
        [17006654] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry)
        [17006655] = { x = 0, y = 0, z = 0, rot = 0 }, -- Experimental Undead (Sentry)
        [17006656] = { x = -71.000, y = -19.250, z = 588.000, rot = 254 }, -- Experimental Undead (North,  East)
        [17006657] = { x = -70.000, y = -19.250, z = 412.000, rot = 254 }, -- Experimental Undead (Center, East)
        -- NPCs
        [17006811] = { { x = 109.000, y = -19.250, z = 449.000, rot = 254 }, 2 }, -- Ryaaf        (East,   East)
        [17006812] = { { x = -46.800, y = -16.250, z = 295.000, rot = 128 }, 3 }, -- Balarahb     (South,  West)
        [17006813] = { { x = -229.00, y = -19.250, z = 448.000, rot = 128 }, 4 }, -- Rhagmakah    (West,   West)
    },
}

instanceObject.onInstanceCreated = function(instance)
    local set = math.random(1, 5)

    -- Set mob spawn points based on set
    for i = 1, 2 do
        local mob = GetMobByID(ryaafMobs[i], instance)
        local id = mob:getID()
        local spawn = setTables[set][id]

        mob:setSpawn(spawn.x, spawn.y, spawn.z, spawn.rot)
        mob:setPos(spawn)
    end

    for i = 1, 3 do
        local npc = GetNPCByID(ryaafNPCs[i], instance)
        local id = npc:getID()
        local spawn = setTables[set][id][1]

        npc:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)

        -- See zone.lua for use of this variable
        instance:setLocalVar(string.format("%s", setTables[set][id][2]), id)
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_REEF_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-495.000, -9.695, -72.000, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-490.000, -9.900, -72.000, 0)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onTriggerAreaEnter = function(player, triggerArea)
    local instance = player:getInstance()

    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function (x)
            print(1)
            local var = instance:getLocalVar("1")
            if var > 0 then
                print(2)
                savingPrivateRyaaf(player, GetNPCByID(var, instance), instance)
            end
        end,
        [2] = function (x)
            print(1)
            local var = instance:getLocalVar("2")
            if var > 0 then
                print(2)
                savingPrivateRyaaf(player, GetNPCByID(var, instance), instance)
            end
        end,
        [3] = function (x)
            print(1)
            local var = instance:getLocalVar("3")
            if var > 0 then
                print(2)
                savingPrivateRyaaf(player, GetNPCByID(var, instance), instance)
            end
        end,
        [4] = function (x)
            print(1)
            local var = instance:getLocalVar("4")
            if var > 0 then
                print(2)
                savingPrivateRyaaf(player, GetNPCByID(var, instance), instance)
            end
        end,
        [5] = function (x)
            print(1)
            local var = instance:getLocalVar("5")
            if var > 0 then
                print(2)
                savingPrivateRyaaf(player, GetNPCByID(var, instance), instance)
            end
        end,
    }
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 3 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8)
end

instanceObject.onEventFinish = function(player, csid, option)
end

return instanceObject
