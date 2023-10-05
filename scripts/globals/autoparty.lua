-----------------------------------
-- Auto Party - Used in creating autonomous parties that players can join in with to EXP
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.autoparty = {}

local tankLook =
{
    [10] =
    {

    },

    [20] =
    {

    },

    [30] =
    {

    },

    [40] =
    {

    },

    [50] =
    {

    },

    [60] =
    {

    },

    [70] =
    {

    },
}

local mageLook =
{

}

local dmgLook =
{

}

local thfLook =
{

}

xi.autoparty.createParty = function(zone, lvl)
    local party = {}

    -- Tank
    -- Healer
    -- DMG
    -- Puller
end

xi.autoparty.onSpawn = function(member)
end

xi.autoparty.onRoam = function(member)
end

xi.autoparty.onFight = function(member, target)
end

xi.autoparty.setTarget = function(mobList)
end

xi.autoparty.getTarget = function()
end