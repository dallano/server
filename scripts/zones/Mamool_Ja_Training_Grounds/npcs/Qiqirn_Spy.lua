-----------------------------------
-- Area: Mamool Ja Training Grounds (The Double Agent)
--  Mob: Qiqirn Spy
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npc:setLocalVar("doubleAgentLie", math.random(0, 14))
    npc:setLocalVar("doubleAgentLieDistance", math.random(5, 150))
    npc:setLocalVar("hintType", math.random(0, 6))
    local sPos = npc:getPos()

    local pathNodes =
    {
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
        { x = sPos.x + math.random(-8, 8), y = sPos.y, z = sPos.z + math.random(-8, 8), wait = 5 },
    }

    npc:initNpcAi()
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    local instance       = npc:getInstance()
    local doubleAgent    = GetNPCByID(instance:getLocalVar("doubleAgentID"), instance)
    local offset         = 17047521

    if instance:getProgress() >= 1 then
        if doubleAgent:getID() == npc:getID() then
            player:messageSpecial(ID.text.COMPLETE + 1)
        else
            player:messageSpecial(ID.TEXT.COMPLETE)
        end
    else
        player:startEvent(npc:getID() - offset)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local instance       = npc:getInstance()
    local doubleAgent    = GetNPCByID(instance:getLocalVar("doubleAgentID"), instance)
    local doubleAgentLie = npc:getLocalVar("doubleAgentLie")
    local dPos           = doubleAgent:getPos()
    local mPos           = npc:getPos()
    local hint           = npc:getLocalVar("hintType")
    local distance       = npc:checkDistance(doubleAgent)

    -- Option 2 == asking for information
    if option == 2 then
        if doubleAgent:getID() ~= npc:getID() then
            -- Nonsense
            if hint <= 1 then
                player:messageSpecial(ID.text.DOUBLE_AGENT_NO_HINT + math.random(0, 7))
                return

            -- Give direction hint
            elseif hint <= 3 then
                if dPos.x - mPos.x <= 15 then
                    if dPos.x > mPos.x then
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 5) -- North
                    else
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 7) -- east
                    end

                elseif dPos.x - mPos.x <= 15 then
                    if dPos.x < mPos.x then
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 8) -- South
                    else
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 9) -- West
                    end

                elseif dPos.x < mPos.x then
                    if dPos.z < mPos.z then
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION) -- SE
                    else
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 1) -- SW
                    end

                elseif dPos.x < mPos.x then
                    if dPos.z > mPos.z then
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 2) -- NW
                    else
                        player:messageSpecial(ID.text.DOUBLE_AGENT_DIRECTION + 4) -- NE
                    end
                end
                return

            -- Give general distance hint
            elseif hint <= 5 then
                if distance < 20 then
                    player:messageSpecial(ID.text.DOUBLE_AGENT_DISTANCE)
                elseif distance < 70 then
                    player:messageSpecial(ID.text.DOUBLE_AGENT_DISTANCE - 1)
                elseif distance < 150 then
                    player:messageSpecial(ID.text.DOUBLE_AGENT_DISTANCE + 1)
                else
                    player:messageSpecial(ID.text.DOUBLE_AGENT_DISTANCE + 2)
                end
                return

            -- Give exact yalm distance
            else
                player:messageSpecial(ID.text.DOUBLE_AGENT_EXACT, distance)
            end
        else
            if doubleAgentLie == 0 then
                player:messageSpecial(ID.text.DOUBLE_AGENT_EXACT, npc:getLocalVar("doubleAgentLieDistance"))
            else
                player:messageSpecial(ID.text.DOUBLE_AGENT_EXACT + doubleAgentLie)
            end
        end

    -- Option 1 == Attempting a capture
    elseif option == 1 then
        if npc:getID() == instance:getLocalVar("doubleAgentID") then
            player:messageSpecial(ID.text.DOUBLE_AGENT_CAUGHT)

            npc:timer(3000, function(npcArg)
                instance:setProgress(1)
            end)
        else
            xi.assault.addBonusPoints(instance, -75)
        end
    end
end

return entity
