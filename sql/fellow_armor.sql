SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `fellow_armor`;
CREATE TABLE IF NOT EXISTS `fellow_armor` (
  `rank` int(3) unsigned NOT NULL,
  `body` int(3) unsigned NOT NULL,
  `hands` int(3) unsigned NOT NULL,
  `legs` int(3) unsigned NOT NULL,
  `feet` int(3) unsigned NOT NULL,
  PRIMARY KEY (`rank`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- heavy armor
INSERT INTO `fellow_armor` VALUES (  0,  28,  28,  28,  28); -- scale mail, scale f.gauntlets, scale cuisses, scale greaves
INSERT INTO `fellow_armor` VALUES (  1,   2,   2,   2,   2); -- breastplate, gauntlets, cuisses, plate leggings
INSERT INTO `fellow_armor` VALUES (  2,  29,  29,  29,  29); -- mythril breastplate, mythril gauntlets, mythril cuisses, mythril leggings
INSERT INTO `fellow_armor` VALUES (  3, 138, 138, 138, 138); -- eisenbrust, eisenhentzes, eisendiechlings, eisenschuhs
INSERT INTO `fellow_armor` VALUES (  4, 108, 108,  52,  52); -- carap. breastplate, carap. gauntlets, iron cuisses, iron greaves
INSERT INTO `fellow_armor` VALUES (  5,  25,  25,  25,  25); -- i.m. cuirass, i.m. gauntlets, i.m. cuisses, i.m. sabatons
INSERT INTO `fellow_armor` VALUES (  6,   9,   9,   9,   9); -- hara-ate, kote, haidate, sune-ate
INSERT INTO `fellow_armor` VALUES (  7, 114, 114,  53,  53); -- scorp. breastplate, scorp. gauntlets, steel cuisses, steel greaves
INSERT INTO `fellow_armor` VALUES (  8,  22,  22,  22,  22); -- darksteel cuirass, darksteel gauntlets, darksteel cuisses, darksteel sabatons
INSERT INTO `fellow_armor` VALUES (  9,  76,  76,  76,  76); -- Paladin AF
INSERT INTO `fellow_armor` VALUES ( 10,  55,  55,  55,  55); -- Adaman Cuirass
INSERT INTO `fellow_armor` VALUES ( 11,  41,  55,  55,  76); -- Mix and Match <3
-- light armor
INSERT INTO `fellow_armor` VALUES (100,   6,   6,   6,   6); -- lizard jerkin, lizard gloves, lizard trousers, lizard ledelsens
INSERT INTO `fellow_armor` VALUES (101,   5,   5,   5,   5); -- chainmail, chain mittens, chain hose, greaves
INSERT INTO `fellow_armor` VALUES (102,  26,  26,  27,  26); -- coral scale mail, coral f.gauntlets, coral cuisses, coral greaves
INSERT INTO `fellow_armor` VALUES (103, 129, 129, 129, 129); -- Shade Gear
INSERT INTO `fellow_armor` VALUES (104,  44,  13,  13,  13); -- Brigandine + Royal Knight
INSERT INTO `fellow_armor` VALUES (105,  12,  12,  12,  12); -- banded mail, mufflers, breeches, sollerets
INSERT INTO `fellow_armor` VALUES (106,  52,  52,  52,  52); -- Iron Armor
INSERT INTO `fellow_armor` VALUES (107,  13,  13,  13,  13); -- Royal Knight Gear
INSERT INTO `fellow_armor` VALUES (108,  78,  78,  78,  78); -- DRK AF
INSERT INTO `fellow_armor` VALUES (109, 150,  78,  78,  78); -- Alumine Haubert + DRK AF
INSERT INTO `fellow_armor` VALUES (110,  40, 150, 150, 150); -- Haubergeon, alumine moufles, alumine brayettes, alumine sollerets
INSERT INTO `fellow_armor` VALUES (111,  58,  58,  58,  58); -- Hauberk Gear
-- mage armor
INSERT INTO `fellow_armor` VALUES (200,  20,  20,  20,  20); -- doublet, cuffs, slops, ash clogs
INSERT INTO `fellow_armor` VALUES (201, 149, 149, 149, 149); -- trader saio, trader cuffs, trader slops, trader pigaches
INSERT INTO `fellow_armor` VALUES (202, 131, 131, 131, 131); -- seer tunic, seer mitts, seer slacks, seer pumps
INSERT INTO `fellow_armor` VALUES (203,  23,  23,  23,  23); -- gambison, bracers, hose, socks
INSERT INTO `fellow_armor` VALUES (204,  18,  18,  18,  18); -- wool robe, wool cuffs, wool slops, chestnut sabots
INSERT INTO `fellow_armor` VALUES (205,  97,  21,  21,  21); -- holy breastplate, gloves, brais, gaiters
INSERT INTO `fellow_armor` VALUES (206,  11,  19,  19,  19); -- White Cloak, t.m. cuffs, t.m. slops, t.m. pigaches
INSERT INTO `fellow_armor` VALUES (207,  19,  19,  19,  19); -- t.m. coat, t.m. cuffs, t.m. slops, t.m. pigaches
INSERT INTO `fellow_armor` VALUES (208,  49,  49,  49,  49); -- Cool Mage armor idk
INSERT INTO `fellow_armor` VALUES (209,  47, 101, 101, 101); -- Vermillion Cloak + errant gear
INSERT INTO `fellow_armor` VALUES (210,  57,  57,  57,  57); -- noble gear
INSERT INTO `fellow_armor` VALUES (211, 142, 142, 142, 142); -- blessed briault, blessed mitts, blessed trousers, blessed pumps
-- freestyle armor
INSERT INTO `fellow_armor` VALUES (300,   8,   8,   8,   8); -- lvl 1 rse, lvl 1 rse, lvl 1 rse, lvl 1 rse
INSERT INTO `fellow_armor` VALUES (301, 103, 102, 104, 105); -- chocobo j.coat, fish gloves, vagabond hose, field boots
INSERT INTO `fellow_armor` VALUES (302,  15,   0,  15,   3); -- bronze harness, no armor, bronze subligar, solea
INSERT INTO `fellow_armor` VALUES (303,  31,  31,  31,  31); -- lvl 30 rse, lvl 30 rse, lvl 30 rse, lvl 30 rse
INSERT INTO `fellow_armor` VALUES (304,  48, 103, 102, 104); -- blue cotehardie, chocobo gloves, fish hose, vagabond hose
INSERT INTO `fellow_armor` VALUES (305,  34, 117,  32,   0); -- scorpion harness, carpenter gloves, zodiac subligar, no armor
INSERT INTO `fellow_armor` VALUES (306,  45,  24,  24,  24); -- justaucorps, battle bracers, battle hose, battle boots
INSERT INTO `fellow_armor` VALUES (307,  56,  56,  56,  56); -- coral harness, coral mittens, coral subligar, coral leggings
INSERT INTO `fellow_armor` VALUES (308,  33,   3,   3,  10); -- cardinal vest, mitts, slacks, shoes
INSERT INTO `fellow_armor` VALUES (309,  35,  15,  33,  15); -- demon harness, bronze mittens, femina subligar, bronze leggings
INSERT INTO `fellow_armor` VALUES (310, 134, 134, 134, 134); -- bison jacket, bison wristbands, bison kecks, bison gamashes
INSERT INTO `fellow_armor` VALUES (311, 161, 161, 161, 161); -- black trader gear

-- Gear Chart
-- 1 Leather Tunic
-- 2 Breastplate
-- 3 Tunic
-- 4 Shinobi Gi
-- 5 Chainmail
-- 6 Lizard Jerkin
-- 7 Raptor Jerkin1
-- 8 Lvl. 1 RSE Gear
-- 9 Hara-ate
-- 10 Silk Robe
-- 11 White Cloak *******
-- 12 Banded Mail
-- 13 Royal Knight Chainmail
-- 14 Iron Harness
-- 15 Bronze Harness
-- 16 Bone Harness
-- 17 Kenpogi
-- 18 Wool Robe
-- 19 T.M. Coat
-- 20 Doublet
-- 21 Linen
-- 22 Darksteel Cuirass
-- 23 Gambison
-- 24 Battle Harness
-- 25 Imperial Musketeer Cuirass
-- 26 Coral Scale Mail
-- 27 Gavial Mail
-- 28 Scale Mail
-- 29 Mythril Breastplate
-- 30 Studded Harness
-- 31 Lvl. 30 RSE
-- 32 Zodiac Gear
-- 33 Cardinal Vest
-- 34 Scorpion Harness
-- 35 Demon Harness
-- 36 Lord's Cuirass
-- 37 Jujitsu Gi
-- 38 San d'Orian Aketon
-- 39 Blue Aketon
-- 40 Haubergeon *******
-- 41 Orange Hauby? lol
-- 42 Blue Samurai Armor
-- 43 Earth Doublet
-- 44 Brigadine ******
-- 45 Justaucorps
-- 46 Vampire Cloak
-- 47 Vermillion Cloak*******
-- 48 Blue Cotehardie
-- 49 Some silk cool mage armor****
-- 50 Black Leather?
-- 51 Crazy Ass sorceror armor
-- 52 Iron Scale Mail********
-- 53 Same as above but lighter
-- 54 Jack-o-Lantern
-- 55 Adaman Cuirass
-- 56 Coral Harness
-- 57 Noble Tunic
-- 58 Hauberk********
-- 59 Purple Ninja Armor?
-- 60 Dragon Cuirass**
-- 61 Grey Ninja Armor?
-- 62 Red Dragon Armor*****
-- 63 Adaman Hauberk******
-- 64 Warrior AF
-- 65 Warrior Relic
-- 66 Monk AF
-- 67 Monk Relic
-- 68 Thief AF
-- 69 etc.
-- 70
-- 71
-- 72 Whitemage AF
-- 73 Whitemage Relic
-- 74
-- 75
-- 76 Paladin AF
-- 78 Paladin Relic
-- 79 DRK AF
-- 80 DRK Relic
-- 81
-- 82
-- 83
-- 84
-- 85
-- 86
-- 87
-- 88
-- 89
-- 90 Dragoon AF
-- 91 Dragoon Relic
-- 92 Summoner AF
-- 93 Summoner Relic
-- 94 Jack-o-Lantern
-- 95 Koenig Cuirass*********
-- 96 Purple prissy piece
-- 97 Holy Breastplate
-- 98 Yasha Samue
-- 99 Kirin's Osode
-- 100 Neptunal Armor*******
-- 101 Errant Robe
-- 102 Fishierman's Tunic
-- 103 Chocobo J. Coat
-- 104 Vagabond Tunic
-- 105 Field Tunic
-- 106 Shura Togi****
-- 107 Dalmatica********
-- 108 Carapace Breastplate
-- 109 Purple Leather?
-- 110 Dragon Harness*******
-- 111 San d'Orian
-- 112 Windurstian
-- 113 Bastokan
-- 114 Scorpion Breastplate
-- 115 Austere Robe
-- 116 Leather again tf
-- 117 Carpenter's Apron
-- 118 Smithing Apron
-- 119 craft
-- 120 craft
-- 121 craft
-- 122 craft
-- 123 craft
-- 124 Cooking
-- 125 craft
-- 126 Sunbreeze Gear
-- 127 More Leather
-- 128 Red Shade Harness
-- 129 Shade Harness
-- 130 Red Seer Tunic
-- 131 Seer Tunic
-- 132 Red Ranged gear lol
-- 134 Bison Jacket
-- 135 That beefed out BRD gear
-- 136 Barone Gear******
-- 137 Yigit (BLM gear)
-- 138 Eisenbrust
-- 139 Lords Cuirass
-- 140 Christmas Gear
-- 141 Hachiman Domaru
-- 142 Blessed Briault
-- 143 ZNM Mage Gear
-- 144 Woodwork apron wtf
-- 145 Synth Gear
-- 146 Apron
-- 147 Apron
-- 148 Cool ass DD Gear********
-- 149 Trader Saio
-- 150 Alumine Haubert
-- 151 Plastron Gear******
-- 152 Bone Apron
-- 153
-- 154
-- 155
-- 156
-- 157 Swimming Trunks
-- 158 Leather again wtf
-- 159 COP Omega gGear*******
-- 160 COP Ultima Gear
-- 161 Black Trader Saio
-- 162
-- 164 Cool ass red DD Gear
-- 165 Bluemage AF
-- 166 Bluemage Relic
