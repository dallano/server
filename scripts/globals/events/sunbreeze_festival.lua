------------------------------------
-- Starlight Celebration
------------------------------------
require("scripts/globals/settings")
------------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.sunbreeze_festival = xi.events.sunbreeze_festival or {}

local event = SeasonalEvent:new("SunbreezeFestival")

xi.events.sunbreeze_festival.enabledCheck = function()
    local month = tonumber(os.date("%m"))
    return month == 6 -- 8
end

event:setEnableCheck(xi.events.sunbreeze_festival.enabledCheck)

local sunbreezeEntites =
{
    -- Goldfish NPCs
    17789025, -- Mei (Rabao)
    17187570, -- Saradorial (West Ronfaure)
    17216210, -- Fish Eyes (North Gustaberg)
    17253106, -- Kesha Shopehllok (East Sarutabaruta)

    -- Bastok Markets
    17740130,                                                             -- Moogle
    17740051, 17740052, 17740053, 17740054, 17740055, 17740056, 17740057, -- Tree Decor
    17740058, 17740059, 17740060, 17740061, 17740121, 17740122, 17740123, -- Tree Decor
    17740124, 17740125, 17740126, 17740127, 17740105,                     -- Tree Decor
    17740035, 17740036, 17740037, 17740038, 17740039, 17740040, 17740041, -- Dancers
    17740042, 17740043, 17740044, 17740045, 17740046, 17740047, 17740048, -- Dancers
    17740049, 17740050,                                                   -- Dancers
    -- Bastok Mines
    17736004, 17736005, 17736006, -- Moogles
    17735962,                     -- Event Stall
    -- Port Bastok
    17744084, 17744085, 17744086, 17744087, 17744088, 17744089, 17744090, -- Tree Decor
    17744091, 17744092, 17744093, 17744094, 17744095, 17744096, 17744097, -- Tree Decor
    17744098, 17744099, 17744100, 17744101, 17744102, 17744103, 17744104, -- Tree Decor
    17744105, 17744106, 17744107, 17744108, 17744109, 17744082, 17744083, -- Tree Decor

    -- Windurst Woods
    -- Windurst Walls
    -- Windurst Waters
    -- Port Windurst

    -- Northern San d'Oria
    -- Southern San d'Oria
    -- Port San d'Oria
}

local sunbreezeFireworks =
{
    [xi.zone.WEST_RONFAURE]         = { 17187571, 17187569 },
    [xi.zone.EAST_RONFAURE]         = { 17191555 },
    [xi.zone.NORTH_GUSTABERG]       = { 17212131 },
    [xi.zone.SOUTH_GUSTABERG]       = { 17216209 },
    [xi.zone.EASTERN_ALTEPA_DESERT] = { 17244668 },
    [xi.zone.WESTERN_ALTEPA_DESERT] = { 17289818 },
    [xi.zone.WEST_SARUTABARUTA]     = { 17248881 },
    [xi.zone.EAST_SARUTABARUTA]     = { 17253105 },
    [xi.zone.SOUTHERN_SAN_DORIA]    = { 17719783 },
    [xi.zone.PORT_SAN_DORIA]        = { 17727646 },
    [xi.zone.NORTHERN_SAN_DORIA]    = { 17723780 },
    [xi.zone.BASTOK_MINES]          = { 17735938 },
    [xi.zone.BASTOK_MARKETS]        = { 17740146, 17740091 },
    [xi.zone.PORT_BASTOK]           = { 17744126 },
    [xi.zone.WINDURST_WATERS]       = { 17752515 },
    [xi.zone.WINDURST_WALLS]        = { 17756373 },
    [xi.zone.PORT_WINDURST]         = { 17760486 },
    [xi.zone.WINDURST_WOODS]        = { 17764738 },
    [xi.zone.RABAO]                 = { 17788993 },
}

local sunbreezeMusicZones =
{
    xi.zone.SOUTHERN_SAN_DORIA,
    xi.zone.PORT_SAN_DORIA,
    xi.zone.NORTHERN_SAN_DORIA,
    xi.zone.WINDURST_WOODS,
    xi.zone.WINDURST_WATERS,
    xi.zone.WINDURST_WALLS,
    xi.zone.PORT_WINDURST,
    xi.zone.BASTOK_MARKETS,
    xi.zone.BASTOK_MINES,
    xi.zone.PORT_BASTOK,
    xi.zone.RABAO,
    xi.zone.WEST_RONFAURE,
    xi.zone.EAST_RONFAURE,
    xi.zone.NORTH_GUSTABERG,
    xi.zone.SOUTH_GUSTABERG,
    xi.zone.EAST_SARUTABARUTA,
    xi.zone.WEST_SARUTABARUTA,
}

local originalMusic =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 107,
    [xi.zone.PORT_SAN_DORIA]     = 107,
    [xi.zone.NORTHERN_SAN_DORIA] = 107,
    [xi.zone.WINDURST_WOODS]     = 151,
    [xi.zone.WINDURST_WATERS]    = 151,
    [xi.zone.WINDURST_WALLS]     = 151,
    [xi.zone.PORT_WINDURST]      = 151,
    [xi.zone.BASTOK_MARKETS]     = 152,
    [xi.zone.BASTOK_MINES]       = 152,
    [xi.zone.PORT_BASTOK]        = 152,
    [xi.zone.RABAO]              = 208,
    [xi.zone.WEST_RONFAURE]      = 109,
    [xi.zone.EAST_RONFAURE]      = 109,
    [xi.zone.NORTH_GUSTABERG]    = 116,
    [xi.zone.SOUTH_GUSTABERG]    = 116,
    [xi.zone.EAST_SARUTABARUTA]  = 113,
    [xi.zone.WEST_SARUTABARUTA]  = 113,
}

local goldfishRewardTable =
{
    [10] = { points = 5,  item = xi.items.SUPER_SCOOP,     amount = 1  },
    [11] = { points = 15, item = xi.items.CRACKLER,        amount = 3  },
    [14] = { points = 25, item = xi.items.FESTIVE_FAN,     amount = 5  },
    [12] = { points = 30, item = xi.items.RED_DROP,        amount = 1  },
    [13] = { points = 50, item = xi.items.SPIRIT_MASQUE,   amount = 12 },
    [17] = { points = 60, item = xi.items.PUNY_PLANET_KIT, amount = 1  },
    [15] = { points = 65, item = xi.items.GOLDFISH_SET,    amount = 1  },
    [16] =
    {
        [55]  = { points = 70, item = xi.items.GLOWFLY,         amount = 5 },
        [115] = { points = 70, item = xi.items.WHITE_BUTTERFLY, amount = 5 },
        [139] = { points = 70, item = xi.items.WHITE_BUTTERFLY, amount = 5 },
        [903] = { points = 70, item = xi.items.BELL_CRICKET,    amount = 5 },
    },
}

local moogleVendorStock =
{
    [2004] = -- No retail information
    {
        -- I dunnno, a popstar?
    },

    [2005] =
    {
        xi.items.HUME_GILET,           7500,
        xi.items.HUME_GILET_P1,       10000,
        xi.items.HUME_TRUNKS,          7500,
        xi.items.HUME_TRUNKS_P1,      10000,
        xi.items.HUME_TOP,             7500,
        xi.items.HUME_TOP_P1,         10000,
        xi.items.HUME_SHORTS,          7500,
        xi.items.HUME_SHORTS_P1,      10000,
        xi.items.ELVAAN_GILET,         7500,
        xi.items.ELVAAN_GILET_P1,     10000,
        xi.items.ELVAAN_TRUNKS,        7500,
        xi.items.ELVAAN_TRUNKS_P1,    10000,
        xi.items.ELVAAN_TOP,           7500,
        xi.items.ELVAAN_TOP_P1,       10000,
        xi.items.ELVAAN_SHORTS,        7500,
        xi.items.ELVAAN_SHORTS_P1,    10000,
        xi.items.TARUTARU_MAILLOT,     7500,
        xi.items.TARUTARU_MAILLOT_P1, 10000,
        xi.items.TARUTARU_TRUNKS,      7500,
        xi.items.TARUTARU_TRUNKS_P1,  10000,
        xi.items.TARUTARU_TOP,         7500,
        xi.items.TARUTARU_TOP_P1,     10000,
        xi.items.MITHRA_TOP,           7500,
        xi.items.MITHRA_TOP_P1,       10000,
        xi.items.MITHRA_SHORTS,        7500,
        xi.items.MITHRA_SHORTS_P1,    10000,
        xi.items.GALKA_GILET,          7500,
        xi.items.GALKA_GILET_P1,      10000,
        xi.items.GALKA_TRUNKS,         7500,
        xi.items.GALKA_TRUNKS_P1,     10000,
    },
}

local fishValue =
{
    [xi.items.TINY_GOLDFISH]    = 1,
    [xi.items.BLACK_BUBBLE_EYE] = 2,
    [xi.items.LIONHEAD]         = 10,
    [xi.items.PEARLSCALE]       = 30,
    [xi.items.CALICO_COMET]     = 30,
}

xi.events.sunbreeze_festival.goldfishVendorOnTrade = function(player, npc, trade, csid)
    local hasBasket = player:hasItem(xi.items.GOLDFISH_BASKET) and 1 or 0
    local points    = 0
    local itemQty
    local itemID

    -- Manually handles the trade in order to calculate the points rewarded
    for i = 0, trade:getSlotCount() - 1 do
        itemID  = trade:getItemId(i)
        itemQty = trade:getItemQty(itemID)

        if fishValue[itemID] == nil then
            break
        else
            trade:confirmItem(itemID, itemQty)
            points = points + fishValue[itemID] * itemQty
        end
    end

    if points > 0 then
        player:setCharVar("[SUNBREEZE]goldfishPoints", player:getCharVar("[SUNBREEZE]goldfishPoints") + points)
        player:startEvent(csid + 1, points, hasBasket, 4)
    end
end

xi.events.sunbreeze_festival.goldfishVendorOnTrigger = function(player, npc, csid)
    local hasBasket = player:hasItem(xi.items.GOLDFISH_BASKET) and 1 or 0
    local points    = player:getCharVar("[SUNBREEZE]goldfishPoints")

    player:startEvent(csid, hasBasket, points)
end

xi.events.sunbreeze_festival.goldfishVendorOnEventUpdate = function(player, csid, option)
    local hasBasket = player:hasItem(xi.items.GOLDFISH_BASKET) and 1 or 0
    local points    = player:getCharVar("[SUNBREEZE]goldfishPoints")
    local cost

    if option == 16 then
        cost = goldfishRewardTable[option][csid].points
    else
        cost = goldfishRewardTable[option].points
    end

    if
        points >= cost and
        option >= 10 and
        option <= 17
    then
        player:updateEvent({ [0] = 247, [1] = hasBasket, [6] = 100 })
    end
end

xi.events.sunbreeze_festival.goldfishVendorOnEventFinish = function(player, csid, option)
    local points = player:getCharVar("[SUNBREEZE]goldfishPoints")
    local reward = goldfishRewardTable[option]

    -- Open Shop
    if option == 1 then
        xi.shop.general(player, { xi.items.SUPER_SCOOP, 100 })

    -- Player's getting a new basket
    elseif
        option == 2 or
        option == 4
    then
        player:setCharVar("[SUNBREEZE]goldfishPoints", 0)
        if not player:hasItem(xi.items.GOLDFISH_BASKET) then
            npcUtil.giveItem(player, xi.items.GOLDFISH_BASKET)
        end

    -- Reward Points
    elseif option == 3 then
        player:messageSpecial(zones[player:getZoneID()].text.GOLDFISH_POINT_UPDATE, points)
        player:confirmTrade()

    -- Reward Items
    elseif
        option >= 10 and
        option <= 17
    then
        if option == 11 then -- Bag of Random Fireworks
            npcUtil.giveItem(player, { { reward.item + math.random(0, 3), math.random(1, reward.amount ) } })

        elseif option == 12 then -- Colored Drop (Red - Black)
            npcUtil.giveItem(player, { { reward.item + math.random(0, 7), reward.amount } })

        elseif option == 16 then -- Special case for biggest prize for each goldfish NPC
            if csid == 115 then -- If Mei, reward a random item
                npcUtil.giveItem(player, { { reward[csid].item + math.random(0, 2), math.random(1, reward[csid].amount) } })
            else
                npcUtil.giveItem(player, { { reward[csid].item, math.random(1, reward[csid].amount) } })
            end

            player:setCharVar("[SUNBREEZE]goldfishPoints", points - reward[csid].points)
            return
        else
            npcUtil.giveItem(player, { { reward.item, reward.amount } })
        end

        -- Only remove points if the player is successfully rewarded an item
        player:setCharVar("[SUNBREEZE]goldfishPoints", points - reward.points)
    end
end

xi.events.sunbreeze_festival.moogleVendorOnTrigger = function(player, npc)
    player:messageSpecial(zones[player:getZoneID()].text.SUNBREEZE_MOOGLE_VENDOR)

    xi.shop.general(player, moogleVendorStock[xi.settings.main.SUNBREEZE_VENDOR_ERA])

end

xi.events.sunbreeze_festival.setMusic = function(flag)
    local sunbreezeMusic = 227
    -- If true, set sunbreeze music
    if flag then
        for _, zoneId in pairs(sunbreezeMusicZones) do
            local zone = GetZone(zoneId)
            if zone then
                zone:setBackgroundMusicNight(sunbreezeMusic)

                for _, player in pairs(zone:getPlayers()) do
                    player:changeMusic(1, sunbreezeMusic)
                end
            end
        end

    -- Reset music to original tracks
    else
        for _, zoneId in pairs(sunbreezeMusicZones) do
            local zone = GetZone(zoneId)

            if zone then
                zone:setBackgroundMusicNight(originalMusic[zoneId])

                for _, player in pairs(zone:getPlayers()) do
                    player:changeMusic(1, originalMusic[zoneId])
                end
            end
        end
    end
end

xi.events.sunbreeze_festival.onZoneTick = function(zone)
    local npc = GetNPCByID(zones[zone:getID()].npc.GOLDFISH_NPC)

    if
        zone:getLocalVar("[SUNBREEZE]goldfishDialogueTimer") < os.time() and
        xi.settings.main.SUNBREEZE == 1
    then
        npc:showText(npc, zones[zone:getID()].text.GOLDFISH_NPC_DIALOGUE + math.random(0, 2))
        zone:setLocalVar("[SUNBREEZE]goldfishDialogueTimer", os.time() + 20)
    end
end

xi.events.sunbreeze_festival.spawnFireworks = function(zone)
    if xi.settings.main.SUNBREEZE == 1 then
        for _, firework in pairs(sunbreezeFireworks[zone:getID()]) do
            local fireworkNPC = GetNPCByID(firework)
            local hour = VanadielHour()

            if hour <= 6 or hour >= 18 then
                fireworkNPC:setStatus(xi.status.NORMAL)
            else
                fireworkNPC:setStatus(xi.status.INVISIBLE)
            end
        end
    end
end

xi.events.sunbreeze_festival.showEntities = function(enabled)
    for _, entityID in pairs(sunbreezeEntites) do
        local entity = GetNPCByID(entityID)

        if entity then
            if enabled then
                entity:setStatus(xi.status.NORMAL)
            else
                entity:setStatus(xi.status.INVISIBLE)
            end
        end
    end
end

event:setStartFunction(function()
    xi.events.sunbreeze_festival.setMusic(true)
    xi.events.sunbreeze_festival.showEntities(true)
end)

event:setEndFunction(function()
    xi.events.sunbreeze_festival.setMusic(false)
    xi.events.sunbreeze_festival.showEntities(false)
end)

return event
