-------------------------------
-- xiSP Teleport System
-- Jeuno Outpost Warps
-------------------------------
require("scripts/globals/conquest")
-------------------------------
xi = xi or { }
xi.teleport = xi.teleport or { }

local dialogTable =
{
    tooLow = "Analyzing adventurer's capabilities... Unqualified for designated location.",
    noOPs =
    {
        text1 = 'Greetings. I am %s. I am authorized for allowing adventures ease of access within Vanadiel.',
        text2 = 'I have been instructed by the Archduke of Jeuno to conduct a fee on my services',
        text3 = 'However, I am only authorized to assist Ambassadors and those who serve their nation.',
        text6 = 'I am unable to offer you my services. Please come again when you are eligible.',
    },
    welcome               = 'Hello, adventurer.',
    teleport              = 'This is where you will be heading?',
    teleportControlled    = "Your home nation is in operation in that area. I charge %s gil to transfer you.",
    teleportNotControlled = "Your nation home has no presence in the area. I charge %s gil to transfer you.",
    noteleport            = 'Come again',
    thanks                = 'Thank you, adventurer. Safe travels.',
    noGil                 = 'I am not authorized to teleport without the proper funds.',
}

local npcTable =
{
    [xi.zone.LOWER_JEUNO]        = { nation = xi.nation.OTHER,    nationString = "Jeuno",      name = "Mammet-6" },
}

local outposts =
{
    [xi.region.RONFAURE]        = { ki = xi.ki.RONFAURE_SUPPLIES,              lvlOrg = 10, lvlRed = 10, },
    [xi.region.ZULKHEIM]        = { ki = xi.ki.ZULKHEIM_SUPPLIES,              lvlOrg = 10, lvlRed = 10, },
    [xi.region.NORVALLEN]       = { ki = xi.ki.NORVALLEN_SUPPLIES,             lvlOrg = 15, lvlRed = 15, },
    [xi.region.GUSTABERG]       = { ki = xi.ki.GUSTABERG_SUPPLIES,             lvlOrg = 10, lvlRed = 10, },
    [xi.region.DERFLAND]        = { ki = xi.ki.DERFLAND_SUPPLIES,              lvlOrg = 15, lvlRed = 15, },
    [xi.region.SARUTABARUTA]    = { ki = xi.ki.SARUTABARUTA_SUPPLIES,          lvlOrg = 10, lvlRed = 10, },
    [xi.region.KOLSHUSHU]       = { ki = xi.ki.KOLSHUSHU_SUPPLIES,             lvlOrg = 10, lvlRed = 10, },
    [xi.region.ARAGONEU]        = { ki = xi.ki.ARAGONEU_SUPPLIES,              lvlOrg = 15, lvlRed = 15, },
    [xi.region.FAUREGANDI]      = { ki = xi.ki.FAUREGANDI_SUPPLIES,            lvlOrg = 35, lvlRed = 35, },
    [xi.region.VALDEAUNIA]      = { ki = xi.ki.VALDEAUNIA_SUPPLIES,            lvlOrg = 40, lvlRed = 40, },
    [xi.region.QUFIMISLAND]     = { ki = xi.ki.QUFIM_SUPPLIES,                 lvlOrg = 15, lvlRed = 15, },
    [xi.region.LITELOR]         = { ki = xi.ki.LITELOR_SUPPLIES,               lvlOrg = 25, lvlRed = 25, },
    [xi.region.KUZOTZ]          = { ki = xi.ki.KUZOTZ_SUPPLIES,                lvlOrg = 30, lvlRed = 30, },
    [xi.region.VOLLBOW]         = { ki = xi.ki.VOLLBOW_SUPPLIES,               lvlOrg = 50, lvlRed = 50, },
    [xi.region.ELSHIMOLOWLANDS] = { ki = xi.ki.ELSHIMO_LOWLANDS_SUPPLIES,      lvlOrg = 25, lvlRed = 25, },
    [xi.region.ELSHIMOUPLANDS]  = { ki = xi.ki.ELSHIMO_UPLANDS_SUPPLIES,       lvlOrg = 35, lvlRed = 35, },
    [xi.region.TAVNAZIANARCH]   = { ki = xi.ki.TAVNAZIAN_ARCHIPELAGO_SUPPLIES, lvlOrg = 30, lvlRed = 30, },
}

local outpostOptions =
{
    [xi.region.RONFAURE]        = { optionString = "Ronfaure",         fee = 100 },
    [xi.region.ZULKHEIM]        = { optionString = "Zulkheim",         fee = 100 },
    [xi.region.NORVALLEN]       = { optionString = "Norvallen",        fee = 150 },
    [xi.region.GUSTABERG]       = { optionString = "Gustaberg",        fee = 100 },
    [xi.region.DERFLAND]        = { optionString = "Derfland",         fee = 150 },
    [xi.region.SARUTABARUTA]    = { optionString = "Sarutabaruta",     fee = 100 },
    [xi.region.KOLSHUSHU]       = { optionString = "Kolshushu",        fee = 100 },
    [xi.region.ARAGONEU]        = { optionString = "Aragoneu",         fee = 150 },
    [xi.region.FAUREGANDI]      = { optionString = "Fauregandi",       fee = 350 },
    [xi.region.VALDEAUNIA]      = { optionString = "Valdeaunia",       fee = 400 },
    [xi.region.QUFIMISLAND]     = { optionString = "Qufim",            fee = 150 },
    [xi.region.LITELOR]         = { optionString = "Li'Telor",         fee = 250 },
    [xi.region.KUZOTZ]          = { optionString = "Kuzotz",           fee = 300 },
    [xi.region.VOLLBOW]         = { optionString = "Vollbow",          fee = 500 },
    [xi.region.ELSHIMOLOWLANDS] = { optionString = "Elshimo Lowlands", fee = 250 },
    [xi.region.ELSHIMOUPLANDS]  = { optionString = "Elshimo Uplands",  fee = 350 },
    [xi.region.TAVNAZIANARCH]   = { optionString = "Tavnazia",         fee = 300 },
}

xi.teleport.customMenu = function(player, contextTable)
    if
        player:getLocalVar("[Teleporter]Triggered") == 1 and
        player:getLocalVar("[Teleporter]Warping") ~= 1
    then
        player:customMenu(contextTable)
        player:setLocalVar("[Teleporter]Triggered", 0)
    end
end

xi.teleport.triggerOPWarp = function(player, npc)
    player:setLocalVar("[Teleporter]Triggered", 1)
    local zoneId = player:getZoneID()
    local name = npcTable[zoneId].name
    local availableWarps = { }
    local mainLvl = player:getMainLvl()
    local teleportMenu =
    {
        onStart = function(playerArg)
        end,

        title = "Which region would you like to teleport to?",
        options = { },
        onEnd = function(playerArg)
        end,
    }

    player:setLocalVar('[OP_Warp]npcId', npc:getID())

    player:PrintToPlayer(dialogTable.welcome, 0, name)

    for region, data in pairs(outposts) do
        if player:hasTeleport(player:getNation(), region + 5) then
            if data.lvlRed <= mainLvl then
                table.insert(availableWarps, region)
            end
        end
    end

    if availableWarps[1] == nil then
        player:timer(250, function(playerArg)
            playerArg:PrintToPlayer(string.format(dialogTable.noOPs.text1, name), 0, name)
        end)

        player:timer(250, function(playerArg)
            playerArg:PrintToPlayer(dialogTable.noOPs.text2, 0, name)
        end)

        player:timer(250, function(playerArg)
            playerArg:PrintToPlayer(dialogTable.noOPs.text3, 0, name)
        end)

        player:timer(250, function(playerArg)
            playerArg:PrintToPlayer(dialogTable.noOPs.text6, 0, name)
        end)

        return
    end

    local pagesTable = xi.teleport.createRegionMenus(player, availableWarps)
    teleportMenu.options = pagesTable[1]

    player:timer(50, function(playerArg)
        xi.teleport.customMenu(playerArg, teleportMenu)
    end)
end

xi.teleport.createRegionMenus = function(player, availableWarps)
    local warpIndex = 1
    local pagesNeeded = math.ceil(#availableWarps / 3)
    local pagesTable =
    {
        [1] = { },
        [2] = { },
        [3] = { },
        [4] = { },
        [5] = { },
        [6] = { },
    }
    local teleportMenu =
    {
        onStart = function(playerArg)
        end,

        title = "Which region would you like to teleport to?",
        options = { },
        onEnd = function(playerArg)
        end,
    }

    for page = 1, pagesNeeded, 1 do
        local pageArg = { }

        for optionIndex = 3, 1, -1 do
            local region = availableWarps[warpIndex]
            if region then
                local optionArg =
                {
                    outpostOptions[region].optionString,
                    function(playerArg)
                        xi.teleport.sendPriceMenu(playerArg, region)
                    end
                }

                table.insert(pageArg, optionArg)
                warpIndex = warpIndex + 1
            end
        end

        local nextPageArg = { }

        if page == pagesNeeded then
            nextPageArg =
            {
                "Go Back",
                function(playerArg)
                    teleportMenu.options = pagesTable[1]
                    playerArg:timer(50, function(playerAr)
                        playerAr:customMenu(teleportMenu)
                    end)
                end
            }
        else
            nextPageArg =
            {
                "Next Page",
                function(playerArg)
                    teleportMenu.options = pagesTable[page + 1]
                    playerArg:timer(50, function(playerAr)
                        playerAr:customMenu(teleportMenu)
                    end)
                end
            }
        end

        table.insert(pageArg, nextPageArg)
        pagesTable[page] = pageArg
    end

    return pagesTable
end

xi.teleport.sendPriceMenu = function(player, region)
    local price = outpostOptions[region].fee
    local name = npcTable[player:getZoneID()].name
    local owner = GetRegionOwner(region)
    local priceMenu =
    {
        onStart = function(playerArg)
        end,

        title = "",
        options = { },
        onEnd = function(playerArg)
        end,
    }

    priceMenu.title = string.format(dialogTable.teleport, price)
    priceMenu.options =
    {
        {
            "Yes",
            function(playerArg)
                xi.teleport.handleOPWarp(playerArg, region)
            end
        },
        {
            "No",
            function(playerArg)
                player:PrintToPlayer(dialogTable.noteleport, 0, name)
            end
        },
    }

    player:timer(50, function(playerArg)
        playerArg:customMenu(priceMenu)
    end)

    if owner == player:getNation() then
        player:PrintToPlayer(string.format(dialogTable.teleportControlled, price), 0, name)
    else
        player:PrintToPlayer(string.format(dialogTable.teleportNotControlled, price), 0, name)
    end
end

xi.teleport.handleOPWarp = function(player, region)
    local cost = outpostOptions[region].fee
    local npc = GetNPCByID(player:getLocalVar('[OP_Warp]npcId'))
    local name = npcTable[player:getZoneID()].name

    if player:getGil() >= cost then
        player:PrintToPlayer(dialogTable.thanks, 0, name)
        if player:delGil(cost) then
            player:setLocalVar("[Teleporter]Warping", 1)
            npc:independentAnimation(player, 122, 0)
            player:timer(750, function(playerArg)
                playerArg:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.OUTPOST, 0, 1, 0, region)
            end)
        end
    else
        player:PrintToPlayer(dialogTable.noGil, 0, name)
    end
end
