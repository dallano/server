-----------------------------------
-- Auto Party Buff tables
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.autopartybuffs = {}

-- The following is a table of equipment detailed in priority
-- meaning that the better the equipment, the higher on the list it is
-- Ex. Should an item be selected to be equipped, the loop will then break and
-- move onto the next slot. Meaning higher tabled items will be equipped
-- in this fashion.
local tankEquipmentTable =
{
    [1] = -- Head
    {
        { lvl = 73, id = 12421 }, -- Koenig Schaller
        { lvl = 75, id = 15270 }, -- Walahra Turban
    },

    [2] = -- Body
    {
        { lvl = 73, id = 12549 }, -- Koenig Cuirass
        { lvl = 73, id = 12557 }, -- Adaman Hauberk
        { lvl = 69, id = 13793 }, -- Hauberk +1
        { lvl = 69, id = 12556 }, -- Hauberk
        { lvl = 59, id = 13735 }, -- Haubergeon +1
        { lvl = 57, id = 13734 }, -- Scorpion Harness +1
        { lvl = 59, id = 12555 }, -- Haubergeon
        { lvl = 57, id = 12579 }, -- Scorpion Harness
    },

    [3] = -- Hands
    {
        { lvl = 73, id = 12677 }, -- Koenig Handschuhs
        { lvl = 71, id = 14825 }, -- Dusk Gloves +1
        { lvl = 71, id = 12701 }, -- Dusk Gloves
    },

    [4] = -- Legs
    {
        { lvl = 73, id = 12805 }, -- Koenig Diechlings
    },

    [5] = -- Feet
    {
        { lvl = 73, id = 12933 }, -- Koenig Schuhs
        { lvl = 7,  id = 13014 }, -- Leaping Boots
    },

    [6] = -- Back
    {
        { lvl = 75, id = 16212 }, -- Cerberus Mantle
        { lvl = 71, id = 13690 }, -- Forager's Mantle
        { lvl = 40, id = 15468 }, -- Resentment Cape
    },
}

local dmgEquipmentTable =
{
    [1] = -- Head
    {
        { lvl = 74, id = 15223 }, -- Ace's Helm
        { lvl = 75, id = 15270 }, -- Walahra Turban
    },

    [2] = -- Body
    {
        { lvl = 73, id = 12557 }, -- Adaman Hauberk
        { lvl = 69, id = 13793 }, -- Hauberk +1
        { lvl = 69, id = 12556 }, -- Hauberk
        { lvl = 59, id = 13735 }, -- Haubergeon +1
        { lvl = 59, id = 12555 }, -- Haubergeon
        { lvl = 57, id = 13734 }, -- Scorpion Harness +1
        { lvl = 57, id = 12579 }, -- Scorpion Harness
    },

    [3] = -- Hands
    {
        { lvl = 71, id = 14825 }, -- Dusk Gloves +1
        { lvl = 71, id = 12701 }, -- Dusk Gloves
        { lvl = 34, id = 14874 }, -- Horomusha Kote
    },

    [4] = -- Legs
    {

    },

    [5] = -- Feet
    {
        { lvl = 7, id = 13014 }, -- Leaping Boots
    },

    [6] = -- Back
    {
        { lvl = 71, id = 13690 }, -- Forager's Mantle
    },
}

local mageEquipmentTable =
{
    [1] = -- Main
    {
        { lvl = 55, id = 18633 }, -- Chatoyant Staff
        { lvl = 51, id = 18632 }, -- Iridal Staff
    },

    [2] = -- Head
    {
        { lvl = 75, id = 15270 }, -- Walahra Turban
    },

    [3] = -- Body
    {
        { lvl = 59, id = 13748 }, -- Vermillion Cloak
    },

    [4] = -- Hands
    {
    },

    [5] = -- Legs
    {
    },

    [6] = -- Feet
    {
        { lvl = 7, id = 13014 }, -- Leaping Boots
    },

    [7] = -- Earring1
    {
        { lvl = 47, id = 14724 }, -- Moldavite Earring
    },
}

local healerEquipmentTable =
{
    [1] = -- Main
    {
        { lvl = 55, id = 17108 }, -- Healing Staff
        { lvl = 51, id = 17557 }, -- Light Staff
    },

    [2] = -- Head pieces
    {
        { lvl = 75, id = 15270 }, -- Walahra Turban
        { lvl = 70, id = 15195 }, -- Faerie Hairpin
        { lvl = 50, id = 12494 }, -- Gold Hairpin
        { lvl = 20, id = 12495 }, -- Silver Hairpin
        { lvl = 10, id = 12497 }, -- Brass Hairpin
    },

    [3] = -- Body pieces
    {
        { lvl = 73, id = 13787 }, -- Dalmatica
        { lvl = 68, id = 12605 }, -- Noble's Tunic
        { lvl = 59, id = 13748 }, -- Vermillion Cloak
        { lvl = 29, id = 14424 }, -- Seer's Tunic
    },

    [4] = -- Hands
    {
        { lvl = 73, id = 14006 }, -- Zenith Mitts
    },

    [5] = -- Legs
    {
        { lvl = 73, id = 14247 }, -- Zenith Slacks
    },

    [6] = -- Feet
    {
        { lvl = 73, id = 14123 }, -- Zenith Pumps
    },

    [7] = -- Back
    {
        { lvl = 68, id = 13578 }, -- Blue Cape
    },

    [8] = -- Ring1
    {
        { lvl = 40, id = 15547 }, -- Vilma's Ring
        { lvl = 10, id = 13548 }, -- Astral Ring
    },

    [9] = -- Ring2
    {
        { lvl = 51, id = 13552 }, -- Serket Ring
        { lvl = 40, id = 13549 }, -- Ether Ring
        { lvl = 40, id = 14651 }, -- Mana Ring
    },

    [10] = -- Earring1
    {
        { lvl = 45, id = 14782 }, -- Astral Earring
    },

    [11] = -- Earring2
    {
        { lvl = 0, id = 1 }, -- NULL
    },
}

local supportEquipmentTable =
{
}

xi.autopartybuffs.applyEquipmentBuffs = function(trust, job)
    local table = {}
    local lvl = trust:getMainLvl()
    local player = trust:getMaster()
    local refreshPower = lvl / 10
    local job = trust:getMainJob()

    if job == xi.job.PLD then
        trust:addMod(xi.mod.CURE_CAST_TIME, player:getMerit(xi.merit.CURE_CAST_TIME))
        table = tankEquipmentTable

    elseif
        job == xi.job.SAM or
        job == xi.job.DRK or
        job == xi.job.WAR or
        job == xi.job.DRG
    then
        table = dmgEquipmentTable

    elseif job == xi.job.BLM then
        trust:setMod(xi.mod.REFRESH, refreshPower) -- Simulate ability to rest during combat
        table = mageEquipmentTable

    elseif job == xi.job.WHM or job == xi.job.RDM then
        trust:setMod(xi.mod.REFRESH, refreshPower) -- Simulate ability to rest during combat
        trust:addMod(xi.mod.CURE_CAST_TIME, player:getMerit(xi.merit.CURE_CAST_TIME))
        table = healerEquipmentTable

    else
        table = supportEquipmentTable
    end

    -- Equipment Buffs
    for _, slot in pairs(table) do -- Move through each slot
        for _, item in pairs(slot) do -- Move through all items available per slot
            if lvl >= item.lvl and player:hasItem(item.id) then -- Is trust correct level and does player have item
                local item = GetReadOnlyItem(item.id)

                trust:addMod(xi.mod.HP, item:getMod(xi.mod.HP))
                trust:addMod(xi.mod.HPP, item:getMod(xi.mod.HPP))
                trust:addMod(xi.mod.MP, item:getMod(xi.mod.MP))
                trust:addMod(xi.mod.MPP, item:getMod(xi.mod.MPP))

                trust:addMod(xi.mod.STR, item:getMod(xi.mod.STR))
                trust:addMod(xi.mod.DEX, item:getMod(xi.mod.DEX))
                trust:addMod(xi.mod.VIT, item:getMod(xi.mod.VIT))
                trust:addMod(xi.mod.AGI, item:getMod(xi.mod.AGI))
                trust:addMod(xi.mod.INT, item:getMod(xi.mod.INT))
                trust:addMod(xi.mod.MND, item:getMod(xi.mod.MND))
                trust:addMod(xi.mod.CHR, item:getMod(xi.mod.CHR))

                trust:addMod(xi.mod.ATT, item:getMod(xi.mod.ATT))
                trust:addMod(xi.mod.RATT, item:getMod(xi.mod.RATT))
                trust:addMod(xi.mod.MATT, item:getMod(xi.mod.MATT))
                trust:addMod(xi.mod.ACC, item:getMod(xi.mod.ACC))
                trust:addMod(xi.mod.RACC, item:getMod(xi.mod.RACC))
                trust:addMod(xi.mod.MACC, item:getMod(xi.mod.MACC))
                trust:addMod(xi.mod.DOUBLE_ATTACK, item:getMod(xi.mod.DOUBLE_ATTACK))

                trust:addMod(xi.mod.EVA, item:getMod(xi.mod.EVA))
                trust:addMod(xi.mod.ENMITY, item:getMod(xi.mod.ENMITY))
                trust:addMod(xi.mod.STORETP, item:getMod(xi.mod.STORETP))
                trust:addMod(xi.mod.MDEF, item:getMod(xi.mod.MDEF))
                trust:addMod(xi.mod.PARRY, item:getMod(xi.mod.PARRY))
                trust:addMod(xi.mod.SHIELD, item:getMod(xi.mod.SHIELD))
                trust:addMod(xi.mod.DMG, item:getMod(xi.mod.DMG))
                trust:addMod(xi.mod.DMGPHYS, item:getMod(xi.mod.DMGPHYS))
                trust:addMod(xi.mod.DMGMAGIC, item:getMod(xi.mod.DMGMAGIC))

                trust:addMod(xi.mod.HEALING, item:getMod(xi.mod.HEALING))
                trust:addMod(xi.mod.ENFEEBLE, item:getMod(xi.mod.ENFEEBLE))
                trust:addMod(xi.mod.ELEM, item:getMod(xi.mod.ELEM))
                trust:addMod(xi.mod.SINGING, item:getMod(xi.mod.SINGING))
                trust:addMod(xi.mod.STRING, item:getMod(xi.mod.STRING))
                trust:addMod(xi.mod.WIND, item:getMod(xi.mod.WIND))

                trust:addMod(xi.mod.REFRESH, item:getMod(xi.mod.REFRESH))
                trust:addMod(xi.mod.REGEN, item:getMod(xi.mod.REGEN))
                trust:addMod(xi.mod.CURE_POTENCY, item:getMod(xi.mod.CURE_POTENCY))

                trust:addMod(xi.mod.HASTE_GEAR, item:getMod(xi.mod.HASTE_GEAR))
                trust:addMod(xi.mod.IRIDESCENCE, item:getMod(xi.mod.IRIDESCENCE))

                trust:addMod(xi.mod.FIRE_MEVA, item:getMod(xi.mod.FIRE_MEVA))
                trust:addMod(xi.mod.ICE_MEVA, item:getMod(xi.mod.ICE_MEVA))
                trust:addMod(xi.mod.WIND_MEVA, item:getMod(xi.mod.WIND_MEVA))
                trust:addMod(xi.mod.EARTH_MEVA, item:getMod(xi.mod.EARTH_MEVA))
                trust:addMod(xi.mod.THUNDER_MEVA, item:getMod(xi.mod.THUNDER_MEVA))
                trust:addMod(xi.mod.WATER_MEVA, item:getMod(xi.mod.WATER_MEVA))
                trust:addMod(xi.mod.LIGHT_MEVA, item:getMod(xi.mod.LIGHT_MEVA))
                trust:addMod(xi.mod.DARK_MEVA, item:getMod(xi.mod.MEVA))

                trust:addMod(xi.mod.FIRE_AFFINITY_DMG, item:getMod(xi.mod.FIRE_AFFINITY_DMG))
                trust:addMod(xi.mod.ICE_AFFINITY_DMG, item:getMod(xi.mod.ICE_AFFINITY_DMG))
                trust:addMod(xi.mod.WIND_AFFINITY_DMG, item:getMod(xi.mod.WIND_AFFINITY_DMG))
                trust:addMod(xi.mod.EARTH_AFFINITY_DMG, item:getMod(xi.mod.EARTH_AFFINITY_DMG))
                trust:addMod(xi.mod.THUNDER_AFFINITY_DMG, item:getMod(xi.mod.THUNDER_AFFINITY_DMG))
                trust:addMod(xi.mod.WATER_AFFINITY_DMG, item:getMod(xi.mod.WATER_AFFINITY_DMG))
                trust:addMod(xi.mod.LIGHT_AFFINITY_DMG, item:getMod(xi.mod.LIGHT_AFFINITY_DMG))
                trust:addMod(xi.mod.DARK_AFFINITY_DMG, item:getMod(xi.mod.DARK_AFFINITY_DMG))

                trust:addMod(xi.mod.FIRE_AFFINITY_ACC, item:getMod(xi.mod.FIRE_AFFINITY_ACC))
                trust:addMod(xi.mod.ICE_AFFINITY_ACC, item:getMod(xi.mod.ICE_AFFINITY_ACC))
                trust:addMod(xi.mod.WIND_AFFINITY_ACC, item:getMod(xi.mod.WIND_AFFINITY_ACC))
                trust:addMod(xi.mod.EARTH_AFFINITY_ACC, item:getMod(xi.mod.EARTH_AFFINITY_ACC))
                trust:addMod(xi.mod.THUNDER_AFFINITY_ACC, item:getMod(xi.mod.THUNDER_AFFINITY_ACC))
                trust:addMod(xi.mod.WATER_AFFINITY_ACC, item:getMod(xi.mod.WATER_AFFINITY_ACC))
                trust:addMod(xi.mod.LIGHT_AFFINITY_ACC, item:getMod(xi.mod.LIGHT_AFFINITY_ACC))
                trust:addMod(xi.mod.DARK_AFFINITY_ACC, item:getMod(xi.mod.DARK_AFFINITY_ACC))
                break -- Continue to next slot if we found an item to equip
            end
        end
    end
end

--[[ Equipment Tables:

--- Tank Equipment ---
-- Weapon --
-- Secondary --
-- Head --
    Koenig Schaller
    Walahra Turban
-- Body --
-- Hand --
-- Legs --
-- Feet --
-- Waist --
    Speed Belt
    Virtuoso Belt
    Swift Belt
    Til Belt
-- Neck --
-- Ear1 --
-- Ear2 --
-- Ring1 --
-- Ring2 --
-- Back --

--- Melee Equipment ---
-- Weapon --
-- Secondary --
-- Head --
    Ace's Helm
    Walahra Turban
    Optical Hat
    Voyager Sallet
    Emperor Hairpin
-- Body --
    Homam Corazza
    Adaman Hauberk
    Hauberk
    Assault Jerkin
    Haubergeon
    Scorpion Harness
    Brigandine
-- Hands --
    Homam Manopolas
    Dusk Gloves
    Pallas's Bracelets
    Spiked Finger Gauntlets
    Battle Gloves
-- Legs --
    Homam Cosciales
    Barone Cosciales
    Legionnaire's Subligar
-- Feet --
    Homam Gambieras
    Dusk Ledelsens
    Leaping Boots
-- Waist --
    Speed Belt
    Virtuoso Belt
    Swift Belt
    Til Belt
-- Neck --
    Peacock Charm
-- Ear1 --
    Brutal Earring
    Assault Earring
    Spike Earring
    Bone Earring
    -- Ear2 --
    Ethereal Earring
    Fowling Earring
-- Ring1 --
    Flame Ring
    Ruby Ring
    Sun Ring
    Courage Ring
-- Ring2 --
    Sniper's Ring
    Woodsman Ring
-- Back --
    Caerberus Mantle
    Forager's Mantle
    Amemet Mantle
    Spike Necklace
]]