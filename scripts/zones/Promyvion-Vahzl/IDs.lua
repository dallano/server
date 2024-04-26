-----------------------------------
-- Area: Promyvion-Vahzl
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PROMYVION_VAHZL] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        OVERFLOWING_MEMORIES          = 7222, -- It appears to be a barrier woven from the energy of overflowing memories...
        ON_NM_SPAWN                   = 7226, -- You sense a dark, empty presence...
        EERIE_GREEN_GLOW              = 7228, -- The sphere is emitting an eerie green glow.
        AMULET_RETURNED               = 7271, -- The <item> has been returned to you.
        LIGHT_OF_VAHZL                = 7272, -- You cannot remember when exactly, but you have obtained <item>!
        POPPED_NM_OFFSET              = 7308, -- Remnants of a cerebrator lie scattered about the area.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16867388] = { group = 1, strays = 3, stream = 16867719 },
            [16867393] = { group = 1, strays = 3, stream = 16867720 },
            [16867440] = { group = 2, strays = 5, stream = 16867717 },
            [16867447] = { group = 2, strays = 5, stream = 16867718 },
            [16867505] = { group = 3, strays = 5, stream = 16867722 },
            [16867512] = { group = 3, strays = 5, stream = 16867723 },
            [16867519] = { group = 3, strays = 5, stream = 16867724 },
            [16867526] = { group = 3, strays = 5, stream = 16867725 },
            [16867602] = { group = 4, strays = 7, stream = 16867721 },
            [16867611] = { group = 4, strays = 7, stream = 16867726 },
            [16867620] = { group = 4, strays = 7, stream = 16867727 },
        },

        PONDERER   = 16867329,
        PROPAGATOR = 16867330,
        SOLICITOR  = 16867333,
        DEVIATOR   = 16867465,
        WAILER     = 16867554,
        PROVOKER   = 16867657,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = { triggerArea = {   -2, -2, -122,    2, 2, -117 }, destinations = { 45 } }, -- floor 1 return
            [21]        = { triggerArea = {  -40, -2,  197,  -37, 2,  202 }, destinations = { 41 } }, -- floor 2 return
            [31]        = { triggerArea = {  317, -2, -282,  322, 2, -277 }, destinations = { 42 } }, -- floor 3 return
            [41]        = { triggerArea = {  277, -2,   38,  282, 2,   42 }, destinations = { 43 } }, -- floor 4 return
            [51]        = { triggerArea = {  -42, -2,   -2,  -36, 2,    2 }, destinations = { 44 } }, -- floor 5 return
            [16867720]  = { triggerArea = {  -43, -2, -362,  -36, 2, -356 }, destinations = { 33 } }, -- floor 1 MR1
            [16867721]  = { triggerArea = {   76, -2,  -43,   82, 2,  -37 }, destinations = { 32 } }, -- floor 1 MR2
            [16867718]  = { triggerArea = { -163, -2,  197, -156, 2,  203 }, destinations = { 30 } }, -- floor 2 MR1
            [16867719]  = { triggerArea = { -162, -2,  117, -156, 2,  123 }, destinations = { 31 } }, -- floor 2 MR2
            [16867723]  = { triggerArea = {  155, -2, -163,  163, 2, -156 }, destinations = { 37 } }, -- floor 3 MR1
            [16867724]  = { triggerArea = {  236, -2,  -43,  243, 2,  -36 }, destinations = { 35 } }, -- floor 3 MR2
            [16867725]  = { triggerArea = {  236, -2, -243,  243, 2, -236 }, destinations = { 38 } }, -- floor 3 MR3
            [16867726]  = { triggerArea = {  356, -2,  -82,  362, 2,  -76 }, destinations = { 36 } }, -- floor 3 MR4
            [16867722]  = { triggerArea = {  116, -2,   37,  122, 2,   42 }, destinations = { 39 } }, -- floor 4 MR1
            [16867727]  = { triggerArea = {  435, -2,   38,  443, 2,   41 }, destinations = { 40 } }, -- floor 4 MR2
            [16867728]  = { triggerArea = {  436, -2,  276,  443, 2,  283 }, destinations = { 34 } }, -- floor 4 MR3
        },
    },
}

return zones[xi.zone.PROMYVION_VAHZL]
