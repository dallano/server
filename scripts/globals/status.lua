-----------------------------------
-- STATUSES AND MODS
-- Contains variable-ized definitions of things like core enums for use in lua scripts.
-----------------------------------

-----------------------------------
-- SC masks (not currently used in code base)
-----------------------------------

-- EFFECT_SKILLCHAIN0    = 0x200
-- EFFECT_SKILLCHAIN1    = 0x400
-- EFFECT_SKILLCHAIN2    = 0x800
-- EFFECT_SKILLCHAIN3    = 0x1000
-- EFFECT_SKILLCHAIN4    = 0x2000
-- EFFECT_SKILLCHAIN5    = 0x4000
-- EFFECT_SKILLCHAINMASK = 0x7C00

-----------------------------------
-- These values are the codes that represent any statistic possible on an entity.
-- These are NOT the actual status effects such as weakness or silence,
-- but rather arbitrary codes chosen to represent different modifiers to the effected characters and mobs.
--
-- Even if the particular mod is not completely (or at all) implemented yet, you can still script the effects using these codes.
--
-- Example: target:getMod(xi.mod.STR) will get the sum of STR bonuses/penalties from gear, food, STR Etude, Absorb-STR, and any other STR-related buff/debuff.
-- Note that the above will ignore base statistics, and that getStat() should be used for stats, Attack, and Defense, while getACC(), getRACC(), and getEVA() also exist.
-----------------------------------

xi.mod =
{
    -- IF YOU ADD ANY NEW MODIFIER HERE, ADD IT IN src/map/modifier.h ASWELL!

    NONE                            = 0,
    DEF                             = 1,
    HP                              = 2,
    HPP                             = 3,
    CONVMPTOHP                      = 4,
    MP                              = 5,
    MPP                             = 6,
    CONVHPTOMP                      = 7,
    STR                             = 8,
    DEX                             = 9,
    VIT                             = 10,
    AGI                             = 11,
    INT                             = 12,
    MND                             = 13,
    CHR                             = 14,
    FIRE_MEVA                       = 15,
    ICE_MEVA                        = 16,
    WIND_MEVA                       = 17,
    EARTH_MEVA                      = 18,
    THUNDER_MEVA                    = 19,
    WATER_MEVA                      = 20,
    LIGHT_MEVA                      = 21,
    DARK_MEVA                       = 22,
    ATT                             = 23,
    RATT                            = 24,
    ACC                             = 25,
    RACC                            = 26,
    ENMITY                          = 27,
    ENMITY_LOSS_REDUCTION           = 427,
    MATT                            = 28,
    MDEF                            = 29,
    MACC                            = 30, -- This is NOT item level "magic accuracy skill" ! That happens in item_weapon.sql instead
    MEVA                            = 31,
    FIREATT                         = 32,
    ICEATT                          = 33,
    WINDATT                         = 34,
    EARTHATT                        = 35,
    THUNDERATT                      = 36,
    WATERATT                        = 37,
    LIGHTATT                        = 38,
    DARKATT                         = 39,
    FIREACC                         = 40,
    ICEACC                          = 41,
    WINDACC                         = 42,
    EARTHACC                        = 43,
    THUNDERACC                      = 44,
    WATERACC                        = 45,
    LIGHTACC                        = 46,
    DARKACC                         = 47,
    WSACC                           = 48,
    SLASH_SDT                       = 49,
    PIERCE_SDT                      = 50,
    IMPACT_SDT                      = 51,
    HTH_SDT                         = 52,
    FIRE_SDT                        = 54,
    ICE_SDT                         = 55,
    WIND_SDT                        = 56,
    EARTH_SDT                       = 57,
    THUNDER_SDT                     = 58,
    WATER_SDT                       = 59,
    LIGHT_SDT                       = 60,
    DARK_SDT                        = 61,
    ATTP                            = 62,
    DEFP                            = 63,
    COMBAT_SKILLUP_RATE             = 64, -- % increase in skillup combat rate
    MAGIC_SKILLUP_RATE              = 65, -- % increase in skillup magic rate
    RATTP                           = 66,
    EVA                             = 68,
    RDEF                            = 69,
    REVA                            = 70,
    MPHEAL                          = 71,
    HPHEAL                          = 72,
    STORETP                         = 73,

    -- These are NOT item Level skill, they are skill in your status menu. iLvl "skill" happens in item_weapon.sql
    HTH                             = 80,
    DAGGER                          = 81,
    SWORD                           = 82,
    GSWORD                          = 83,
    AXE                             = 84,
    GAXE                            = 85,
    SCYTHE                          = 86,
    POLEARM                         = 87,
    KATANA                          = 88,
    GKATANA                         = 89,
    CLUB                            = 90,
    STAFF                           = 91,

    RAMPART_DURATION                = 92,  -- Rampart duration in seconds
    FLEE_DURATION                   = 93,  -- Flee duration in seconds
    MEDITATE_DURATION               = 94,  -- Meditate duration in seconds
    WARDING_CIRCLE_DURATION         = 95,  -- Warding Circle duration in seconds
    SOULEATER_EFFECT                = 96,  -- Souleater power in percents
    SOULEATER_EFFECT_II             = 53,  -- Uncapped additive Souleaterbonus in percents, 10 = .1
    DESPERATE_BLOWS                 = 906, -- Adds ability haste to Last Resort
    STALWART_SOUL                   = 907, -- Reduces damage taken from Souleater
    BOOST_EFFECT                    = 97,  -- Boost power in tenths
    CAMOUFLAGE_DURATION             = 98,  -- Camouflage duration in percents

    -- These are NOT item Level skill, they are skill in your status menu. iLvl "skill" happens in item_weapon.sql
    AUTO_MELEE_SKILL                = 101,
    AUTO_RANGED_SKILL               = 102,
    AUTO_MAGIC_SKILL                = 103,
    ARCHERY                         = 104,
    MARKSMAN                        = 105,
    THROW                           = 106,
    GUARD                           = 107,
    EVASION                         = 108,
    SHIELD                          = 109,
    PARRY                           = 110,

    -- Magic Skill modifiers
    DIVINE                          = 111,
    HEALING                         = 112,
    ENHANCE                         = 113,
    ENFEEBLE                        = 114,
    ELEM                            = 115,
    DARK                            = 116,
    SUMMONING                       = 117,
    NINJUTSU                        = 118,
    SINGING                         = 119,
    STRING                          = 120,
    WIND                            = 121,
    BLUE                            = 122,
    GEOMANCY_SKILL                  = 123,
    HANDBELL_SKILL                  = 124,

    CHAKRA_MULT                     = 1026, -- Chakra multiplier increase
    CHAKRA_REMOVAL                  = 1027, -- Extra statuses removed by Chakra
    SUPPRESS_OVERLOAD               = 125, -- Kenkonken "Suppresses Overload" mod. Unclear how this works exactly. Requires testing on retail.
    BP_DAMAGE                       = 126, -- Blood Pact: Rage Damage increase percentage
    FISH                            = 127,
    WOOD                            = 128,
    SMITH                           = 129,
    GOLDSMITH                       = 130,
    CLOTH                           = 131,
    LEATHER                         = 132,
    BONE                            = 133,
    ALCHEMY                         = 134,
    COOK                            = 135,
    SYNERGY                         = 136,
    RIDING                          = 137,
    ANTIHQ_WOOD                     = 144,
    ANTIHQ_SMITH                    = 145,
    ANTIHQ_GOLDSMITH                = 146,
    ANTIHQ_CLOTH                    = 147,
    ANTIHQ_LEATHER                  = 148,
    ANTIHQ_BONE                     = 149,
    ANTIHQ_ALCHEMY                  = 150,
    ANTIHQ_COOK                     = 151,
    DMG                             = 160, -- All damage modifiers are base 10000, so 375 = 3.75% YES WE KNOW retail is using base 256.
    DMGPHYS                         = 161, -- We're using a % with extra decimal places. We don't need you to do converting in script.
    DMGPHYS_II                      = 190, -- Physical Damage Taken II % (Burtgang)
    DMGBREATH                       = 162,
    DMGMAGIC                        = 163,
    DMGMAGIC_II                     = 831, -- Magic Damage Taken II % (Aegis)
    DMGRANGE                        = 164,
    UDMGPHYS                        = 387,
    UDMGBREATH                      = 388,
    UDMGMAGIC                       = 389,
    UDMGRANGE                       = 390,
    CRITHITRATE                     = 165,
    CRIT_DMG_INCREASE               = 421,
    RANGED_CRIT_DMG_INCREASE        = 964, -- Increases ranged critical damage by a percent
    ENEMYCRITRATE                   = 166,
    CRIT_DEF_BONUS                  = 908, -- Reduces crit hit damage
    MAGIC_CRITHITRATE               = 562,
    MAGIC_CRIT_DMG_INCREASE         = 563,
    HASTE_MAGIC                     = 167,
    SPELLINTERRUPT                  = 168,
    MOVE                            = 169, -- % Movement Speed
    MOUNT_MOVE                      = 972, -- % Mount Movement Speed
    FASTCAST                        = 170,
    UFASTCAST                       = 407,
    CURE_CAST_TIME                  = 519,
    ELEMENTAL_CELERITY              = 901, -- Quickens Elemental Magic Casting
    DELAY                           = 171,
    RANGED_DELAY                    = 172,
    MARTIAL_ARTS                    = 173,
    SKILLCHAINBONUS                 = 174,
    SKILLCHAINDMG                   = 175,
    MAX_SWINGS                      = 978,
    ADDITIONAL_SWING_CHANCE         = 979,
    FOOD_HPP                        = 176,
    FOOD_HP_CAP                     = 177,
    FOOD_MPP                        = 178,
    FOOD_MP_CAP                     = 179,
    FOOD_ATTP                       = 180,
    FOOD_ATT_CAP                    = 181,
    FOOD_DEFP                       = 182,
    FOOD_DEF_CAP                    = 183,
    FOOD_ACCP                       = 184,
    FOOD_ACC_CAP                    = 185,
    FOOD_RATTP                      = 186,
    FOOD_RATT_CAP                   = 187,
    FOOD_RACCP                      = 188,
    FOOD_RACC_CAP                   = 189,
    FOOD_MACCP                      =  99,
    FOOD_MACC_CAP                   = 100,
    FOOD_DURATION                   = 937, -- Percentage to increase food duration
    VERMIN_KILLER                   = 224,
    BIRD_KILLER                     = 225,
    AMORPH_KILLER                   = 226,
    LIZARD_KILLER                   = 227,
    AQUAN_KILLER                    = 228,
    PLANTOID_KILLER                 = 229,
    BEAST_KILLER                    = 230,
    UNDEAD_KILLER                   = 231,
    ARCANA_KILLER                   = 232,
    DRAGON_KILLER                   = 233,
    DEMON_KILLER                    = 234,
    EMPTY_KILLER                    = 235,
    HUMANOID_KILLER                 = 236,
    LUMORIAN_KILLER                 = 237,
    LUMINION_KILLER                 = 238,
    WYRMAL_ABJ_KILLER_EFFECT        = 1178, -- Wyrmal Abjuration (Crimson/Blood) which makes players susceptible to Dragon Killer effects
    SLEEPRES                        = 240,
    POISONRES                       = 241,
    PARALYZERES                     = 242,
    BLINDRES                        = 243,
    SILENCERES                      = 244,
    VIRUSRES                        = 245,
    PETRIFYRES                      = 246,
    BINDRES                         = 247,
    CURSERES                        = 248,
    GRAVITYRES                      = 249,
    SLOWRES                         = 250,
    STUNRES                         = 251,
    CHARMRES                        = 252,
    AMNESIARES                      = 253,
    LULLABYRES                      = 254,
    DEATHRES                        = 255,
    STATUSRES                       = 958, -- "Resistance to All Status Ailments"
    AFTERMATH                       = 256,
    PARALYZE                        = 257,
    MIJIN_RERAISE                   = 258,
    DUAL_WIELD                      = 259,
    DOUBLE_ATTACK                   = 288,
    DOUBLE_ATTACK_DMG               = 1038, -- Increases "Double Attack" damage/"Double Attack" damage + (in percents, e.g. +20 = +20% damage)
    SUBTLE_BLOW                     = 289,
    SUBTLE_BLOW_II                  = 973, -- Subtle Blow II Effect (Cap 50%) Total Effect (SB + SB_II cap 75%)
    ENF_MAG_POTENCY                 = 290, -- Increases Enfeebling magic potency %
    COUNTER                         = 291,
    KICK_ATTACK_RATE                = 292,
    AFFLATUS_SOLACE                 = 293,
    AFFLATUS_MISERY                 = 294,
    CLEAR_MIND                      = 295,
    CONSERVE_MP                     = 296,
    ENHANCES_SABOTEUR               = 297, -- Increases Saboteur Potency %
    STEAL                           = 298,
    DESPOIL                         = 896,
    PERFECT_DODGE                   = 883, -- Increases Perfect Dodge duration in seconds
    BLINK                           = 299,
    STONESKIN                       = 300,
    PHALANX                         = 301,
    TRIPLE_ATTACK                   = 302,
    TRIPLE_ATTACK_DMG               = 1039, -- Increases "Triple Attack" damage/"Triple Attack" damage + (in percents, e.g. +20 = +20% damage)
    TREASURE_HUNTER                 = 303,
    TREASURE_HUNTER_PROC            = 1048, -- TODO: Increases Treasure Hunter proc rate (percent)
    TREASURE_HUNTER_CAP             = 1049, -- TODO: Increases the Treasure Hunter Cap (e.g. THF JP Gift)
    TAME                            = 304,
    RECYCLE                         = 305,
    ZANSHIN                         = 306,
    UTSUSEMI                        = 307,
    UTSUSEMI_BONUS                  = 900, -- Extra shadows from gear
    NINJA_TOOL                      = 308,
    BLUE_POINTS                     = 309, -- Tracks extra blue points
    BLUE_LEARN_CHANCE               = 945, -- Additional chance to learn blue magic
    DMG_REFLECT                     = 316,
    ROLL_ROGUES                     = 317,
    ROLL_GALLANTS                   = 318,
    ROLL_CHAOS                      = 319,
    ROLL_BEAST                      = 320,
    ROLL_CHORAL                     = 321,
    ROLL_HUNTERS                    = 322,
    ROLL_SAMURAI                    = 323,
    ROLL_NINJA                      = 324,
    ROLL_DRACHEN                    = 325,
    ROLL_EVOKERS                    = 326,
    ROLL_MAGUS                      = 327,
    ROLL_CORSAIRS                   = 328,
    ROLL_PUPPET                     = 329,
    ROLL_DANCERS                    = 330,
    ROLL_SCHOLARS                   = 331,
    -- Corsair Rolls Level 65+
    ROLL_BOLTERS                    = 869,
    ROLL_CASTERS                    = 870,
    ROLL_COURSERS                   = 871,
    ROLL_BLITZERS                   = 872,
    ROLL_TACTICIANS                 = 873,
    ROLL_ALLIES                     = 874,
    ROLL_MISERS                     = 875,
    ROLL_COMPANIONS                 = 876,
    ROLL_AVENGERS                   = 877,
    ROLL_NATURALISTS                = 878,
    ROLL_RUNEISTS                   = 879,
    BUST                            = 332,
    FINISHING_MOVES                 = 333,
    SAMBA_DURATION                  = 490, -- Samba duration bonus
    WALTZ_POTENCY                   = 491, -- Waltz Potency Bonus
    JIG_DURATION                    = 492, -- Jig duration bonus in percents
    VFLOURISH_MACC                  = 493, -- Violent Flourish accuracy bonus
    STEP_FINISH                     = 494, -- Bonus finishing moves from steps
    STEP_ACCURACY                   = 403, -- Accuracy bonus for steps
    WALTZ_DELAY                     = 497, -- Waltz Ability Delay modifier (-1 mod is -1 second)
    SAMBA_PDURATION                 = 498, -- Samba percent duration bonus
    WIDESCAN                        = 340,
    BARRAGE_ACC                     = 420,
    ENSPELL                         = 341,
    SPIKES                          = 342,
    ENSPELL_DMG                     = 343,
    ENSPELL_CHANCE                  = 856,
    SPIKES_DMG                      = 344,
    TP_BONUS                        = 345,

    -- Warrior
    BERSERK_POTENCY                 = 948,  -- Augments "Berserk"/Enhances "Berserk" effect (Conqueror)
    BERSERK_DURATION                = 954,  -- Berserk Duration
    AGGRESSOR_DURATION              = 955,  -- Aggressor Duration
    DEFENDER_DURATION               = 956,  -- Defender Duration
    ENHANCES_RESTRAINT              = 1045, -- Enhances "Restraint" effect/"Restraint" + (Increases the damage bonus of Restraint by XXX%)
    ENHANCES_BLOOD_RAGE             = 1046, -- Enhances "Blood Rage" effect/"Blood Rage" duration +

    -- Paladin
    ENHANCES_CHIVALRY               = 1061, -- Enhances "Chivalry" effect (increases the base TP modifier by the provided value / 100, e.g. mod value 5 = +0.05)
    ENHANCES_DIVINE_EMBLEM          = 1062, -- Enhances "Divine Emblem" effect/"Divine Emblem" + (increases the ability's special enmity bonus by the provided value)
    ENHANCES_FEALTY                 = 1063, -- Enhances "Fealty" effect (increases Fealty's duration by 4 seconds per Fealty merit)
    ENHANCES_IRON_WILL              = 1064, -- Enhances "Iron Will" effect (adds +3% Fast Cast per Iron Will merit to Rampart)
    ENHANCES_GUARDIAN               = 1065, -- Enhances "Guardian" effect (increases Sentinel's duration by 2 seconds per Guardian merit)
    PALISADE_BLOCK_BONUS            = 1066, -- Increases base block rate while under the effects of Palisade (additive, not multiplicative)
    REPRISAL_BLOCK_BONUS            = 1067, -- Increases block rate while under the effects of Reprisal (multiplicative, not additive)
    REPRISAL_SPIKES_BONUS           = 1068, -- Increases Reprisal spikes damage by percentage (e.g. mod value of 50 will increase spikes damage by 50%)

    -- Dark Knight
    ARCANE_CIRCLE_POTENCY           = 1069, -- Increases the potency of the Arcane Circle effect (e.g. mod value 2 = +2% Arcana Killer)
    ENHANCES_BLOOD_WEAPON           = 1070, -- Enhances "Blood Weapon" effect (increases Blood Weapon's duration in seconds)
    DARK_MAGIC_CAST                 = 1071, -- Reduces Dark Magic Casting Time by percentage (e.g. mod value -10 = -10% cast time)
    DARK_MAGIC_DURATION             = 1072, -- Increases Dark Magic spell durations by percentage (e.g. mod value 10 = +10% duration)
    ENHANCES_DARK_SEAL              = 1073, -- Enhances "Dark Seal" effect (Increases Dark Magic spell durations by 10% per Dark Seal merit while Dark Seal active)

    -- Dragoon
    WYVERN_LVL_BONUS                = 1043, -- Wyvern: Lv.+ (Increases wyvern's base level above 99)

    -- Summoner
    AVATAR_LVL_BONUS                = 1040, -- Avatar: Lv. ###/+ (Increases all avatar's base level above 99)
    CARBUNCLE_LVL_BONUS             = 1041, -- Carbuncle: Lv.+ (Increases Carbuncle's base level above 99)
    CAIT_SITH_LVL_BONUS             = 1042, -- Cait Sith: Lv.+ (Increases Cait Sith's base level above 99)
    PERPETUATION_REDUCTION          = 346,
    SPIRIT_SPELLCAST_DELAY          = 1179, -- Reduces the time between spellcasts of a summoned spirit by seconds provided

    -- Puppetmaster
    AUTOMATON_LVL_BONUS             = 1044, -- Automaton: Lv. (Increases automaton's base level above 99)

    -- Geomancer
    FULL_CIRCLE                     = 1025, -- Increases the initial multiplier on MP returned via Full Circle
    BOLSTER_EFFECT                  = 1028, -- Adds bonus duration as +N seconds
    LIFE_CYCLE_EFFECT               = 1029, -- Adds bonus HP% returned to the luopan when using Life Cycle
    AURA_SIZE                       = 1030, -- Used to extend aura size, the formula is 6.25 + (PEntity->getMod(Mod::AURA_SIZE) / 100) so adding 100 will make this 7.25

    -- Rune Fencer
    ENHANCES_BATTUTA            = 1004, -- Used by RUN merit point cat 2 to add +N% bonus damage to parry spikes during Battuta effect
    ENHANCES_ELEMENTAL_SFORZO   = 1005, -- Bonus duration
    ENHANCES_SLEIGHT_OF_SWORD   = 1006, -- Used by RUN merit point cat 2 to add +N Subtle Blow to Swordplay
    ENHANCES_INSPIRATION        = 1007, -- Used by RUN merit point cat 2 to add +N Fast Cast to Vallation/Valiance
    SWORDPLAY                   = 1008, -- Adds bonus starting ticks to Swordplay
    LIEMENT                     = 1009, -- Adds bonus duration as +N seconds
    VALIANCE_VALLATION_DURATION = 1010, -- Adds bonus duration as +N seconds
    PFLUG                       = 1011, -- Adds flat additional all-resist rate in +N%
    VIVACIOUS_PULSE_POTENCY     = 1012, -- Adds final HP bonus +N% to calculation of Vivacious Pulse
    AUGMENTS_VIVACIOUS_PULSE    = 1013, -- Adds random erase/-na to Vivacious Pulse
    RAYKE_DURATION              = 1014, -- Adds bonus duration as +N seconds
    ODYLLIC_SUBTERFUGE_DURATION = 1015, -- Adds bonus duration as +N seconds
    SWIPE                       = 1016, -- Adds bonus damage to the Swipe/Lunge magic damage calculation
    LIEMENT_DURATION            = 1017, -- Adds bonus duration as +N seconds
    GAMBIT_DURATION             = 1018, -- Adds bonus duration as +N seconds
    EMBOLDEN_DURATION           = 1019, -- Adds bonus duration as +N seconds
    LIEMENT_EXTENDS_TO_AREA     = 1020, -- Epeolatry's (RUN Ergon weapon) special effect, makes Liement AoE to party instead of self target only.
    INSPIRATION_FAST_CAST       = 1021, -- Inspiration's fast cast, additive with normal fast cast for a cap beyond 80%
    PARRY_SPIKES                = 1022, -- Battuta parry spikes rate
    PARRY_SPIKES_DMG            = 1023, -- Battuta parry spikes damage
    SPECIAL_ATTACK_EVASION      = 1024, -- Foil "Special Attack" evasion

    FIRE_AFFINITY_DMG               = 347,
    ICE_AFFINITY_DMG                = 348,
    WIND_AFFINITY_DMG               = 349,
    EARTH_AFFINITY_DMG              = 350,
    THUNDER_AFFINITY_DMG            = 351,
    WATER_AFFINITY_DMG              = 352,
    LIGHT_AFFINITY_DMG              = 353,
    DARK_AFFINITY_DMG               = 354,

    FIRE_AFFINITY_ACC               = 544,
    ICE_AFFINITY_ACC                = 545,
    WIND_AFFINITY_ACC               = 546,
    EARTH_AFFINITY_ACC              = 547,
    THUNDER_AFFINITY_ACC            = 548,
    WATER_AFFINITY_ACC              = 549,
    LIGHT_AFFINITY_ACC              = 550,
    DARK_AFFINITY_ACC               = 551,

    FIRE_AFFINITY_PERP              = 553,
    ICE_AFFINITY_PERP               = 554,
    WIND_AFFINITY_PERP              = 555,
    EARTH_AFFINITY_PERP             = 556,
    THUNDER_AFFINITY_PERP           = 557,
    WATER_AFFINITY_PERP             = 558,
    LIGHT_AFFINITY_PERP             = 559,
    DARK_AFFINITY_PERP              = 560,

    ADDS_WEAPONSKILL                = 355,
    ADDS_WEAPONSKILL_DYN            = 356,
    BP_DELAY                        = 357,
    STEALTH                         = 358,
    RAPID_SHOT                      = 359,
    CHARM_TIME                      = 360,
    JUMP_TP_BONUS                   = 361, -- bonus tp player receives when using jump
    JUMP_SPIRIT_TP_BONUS            = 285, -- bonus tp player receives when using jump for spirit jump only
    JUMP_ATT_BONUS                  = 362, -- ATT% bonus for all jumps
    JUMP_SOUL_SPIRIT_ATT_BONUS      = 286, -- ATT% bonus for Soul & Spirit jump only
    JUMP_ACC_BONUS                  = 936, -- accuracy bonus for all jumps
    JUMP_DOUBLE_ATTACK              = 888, -- DA% bonus for all jumps
    HIGH_JUMP_ENMITY_REDUCTION      = 363, -- for gear that reduces more enmity from high jump
    ENHANCES_STRAFE                 = 282, -- Strafe merit augment, +50 TP gained per merit level on breath use.
    ENHANCES_SPIRIT_LINK            = 281, -- Adds erase/-na to Spirit Link
    REWARD_HP_BONUS                 = 364,
    SNAP_SHOT                       = 365,

    DMG_RATING                      = 287, -- adds damage rating to weapon (+DMG augments, maneater/blau dolch etc hidden effects)
    MAIN_DMG_RATING                 = 366, -- adds damage rating to mainhand weapon
    SUB_DMG_RATING                  = 367, -- adds damage rating to off hand weapon
    RANGED_DMG_RATING               = 376, -- adds damage rating to ranged weapon
    MAIN_DMG_RANK                   = 377, -- adds weapon rank to main weapon http://wiki.bluegartr.com/bg/Weapon_Rank
    SUB_DMG_RANK                    = 378, -- adds weapon rank to sub weapon
    RANGED_DMG_RANK                 = 379, -- adds weapon rank to ranged weapon

    REGAIN                          = 368,
    REFRESH                         = 369,
    REGEN                           = 370,
    AVATAR_PERPETUATION             = 371,
    WEATHER_REDUCTION               = 372,
    DAY_REDUCTION                   = 373,
    CURE_POTENCY                    = 374,
    CURE_POTENCY_II                 = 260, -- % cure potency II | bonus from gear is capped at 30
    CURE_POTENCY_RCVD               = 375,
    CURE_POTENCY_BONUS              = 1051, -- TODO: Increases amount healed by Cure spells (fixed amount)
    DELAYP                          = 380,
    RANGED_DELAYP                   = 381,
    EXP_BONUS                       = 382,
    HASTE_ABILITY                   = 383,
    HASTE_GEAR                      = 384,
    SHIELD_BASH                     = 385,
    KICK_DMG                        = 386,
    CHARM_CHANCE                    = 391,
    WEAPON_BASH                     = 392,
    BLACK_MAGIC_COST                = 393,
    WHITE_MAGIC_COST                = 394,
    BLACK_MAGIC_CAST                = 395,
    WHITE_MAGIC_CAST                = 396,
    BLACK_MAGIC_RECAST              = 397,
    WHITE_MAGIC_RECAST              = 398,
    ALACRITY_CELERITY_EFFECT        = 399,
    LIGHT_ARTS_EFFECT               = 334,
    DARK_ARTS_EFFECT                = 335,
    LIGHT_ARTS_SKILL                = 336,
    DARK_ARTS_SKILL                 = 337,
    LIGHT_ARTS_REGEN                = 338, -- Regen bonus HP from Light Arts and Tabula Rasa
    REGEN_DURATION                  = 339,
    HELIX_EFFECT                    = 478,
    HELIX_DURATION                  = 477,
    STORMSURGE_EFFECT               = 400,
    SUBLIMATION_BONUS               = 401,
    GRIMOIRE_SPELLCASTING           = 489, -- "Grimoire: Reduces spellcasting time" bonus
    WYVERN_BREATH                   = 402,
    UNCAPPED_WYVERN_BREATH          = 284, -- Uncapped wyvern breath boost. Used on retail for augments, normal gear should use WYVERN_BREATH.
    REGEN_DOWN                      = 404, -- poison
    REFRESH_DOWN                    = 405, -- plague, reduce mp
    REGAIN_DOWN                     = 406, -- plague, reduce tp
    MAGIC_DAMAGE                    = 311, --  Magic damage added directly to the spell's base damage

    -- Gear set modifiers
    DA_DOUBLE_DMG_RATE              = 408,  -- Double attack's double damage chance %.
    TA_TRIPLE_DMG_RATE              = 409,  -- Triple attack's triple damage chance %.
    ZANSHIN_DOUBLE_DAMAGE           = 410,  -- Zanshin's double damage chance %.
    RAPID_SHOT_DOUBLE_DAMAGE        = 479,  -- Rapid shot's double damage chance %.
    ABSORB_DMG_CHANCE               = 480,  -- Chance to absorb damage %
    EXTRA_DUAL_WIELD_ATTACK         = 481,  -- Chance to land an extra attack when dual wielding
    EXTRA_KICK_ATTACK               = 482,  -- Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
    SAMBA_DOUBLE_DAMAGE             = 415,  -- Double damage chance when samba is up.
    NULL_PHYSICAL_DAMAGE            = 416,  -- Occasionally annuls damage from physical attacks, in percents
    QUICK_DRAW_TRIPLE_DAMAGE        = 417,  -- Chance to do triple damage with quick draw.
    BAR_ELEMENT_NULL_CHANCE         = 418,  -- Bar Elemental spells will occasionally nullify damage of the same element.
    GRIMOIRE_INSTANT_CAST           = 419,  -- Spells that match your current Arts will occasionally cast instantly, without recast.
    COUNTERSTANCE_EFFECT            = 543,  -- Counterstance effect in percents
    DODGE_EFFECT                    = 552,  -- Dodge effect in percents
    FOCUS_EFFECT                    = 561,  -- Focus effect in percents
    MUG_EFFECT                      = 835,  -- Mug effect as multiplier
    ACC_COLLAB_EFFECT               = 884,  -- Increases amount of enmity transferred
    HIDE_DURATION                   = 885,  -- Hide duration increase (percentage based
    GILFINDER                       = 897,  -- Gil % increase
    REVERSE_FLOURISH_EFFECT         = 836,  -- Reverse Flourish effect in tenths of squared term multiplier
    SENTINEL_EFFECT                 = 837,  -- Sentinel effect in percents
    REGEN_MULTIPLIER                = 838,  -- Regen base multiplier
    AUGMENT_SONG_STAT               = 1003, -- Stat MOD Value based on song element

    DOUBLE_SHOT_RATE                = 422, -- The rate that double shot can proc
    VELOCITY_SNAPSHOT_BONUS         = 423, -- Increases Snapshot whilst Velocity Shot is up.
    VELOCITY_RATT_BONUS             = 424, -- Increases Ranged Attack whilst Velocity Shot is up.
    SHADOW_BIND_EXT                 = 425, -- Extends the time of shadowbind
    ABSORB_PHYSDMG_TO_MP            = 426, -- Absorbs a percentage of physical damage taken to MP.
    SHIELD_MASTERY_TP               = 485, -- Shield mastery TP bonus when blocking with a shield
    PERFECT_COUNTER_ATT             = 428, -- Raises weapon damage by 20 when countering while under the Perfect Counter effects. This also affects Weapon Rank (though not if fighting barehanded).
    FOOTWORK_ATT_BONUS              = 429, -- Raises the attack bonus of Footwork. (Tantra Gaiters +2 raise 100/1024 to 152/1024)

    MINNE_EFFECT                    = 433, --
    MINUET_EFFECT                   = 434, --
    PAEON_EFFECT                    = 435, --
    REQUIEM_EFFECT                  = 436, --
    THRENODY_EFFECT                 = 437, --
    MADRIGAL_EFFECT                 = 438, --
    MAMBO_EFFECT                    = 439, --
    LULLABY_EFFECT                  = 440, --
    ETUDE_EFFECT                    = 441, --
    BALLAD_EFFECT                   = 442, --
    MARCH_EFFECT                    = 443, --
    FINALE_EFFECT                   = 444, --
    CAROL_EFFECT                    = 445, --
    MAZURKA_EFFECT                  = 446, --
    ELEGY_EFFECT                    = 447, --
    PRELUDE_EFFECT                  = 448, --
    HYMNUS_EFFECT                   = 449, --
    VIRELAI_EFFECT                  = 450, --
    SCHERZO_EFFECT                  = 451, --
    ALL_SONGS_EFFECT                = 452, --
    MAXIMUM_SONGS_BONUS             = 453, --
    SONG_DURATION_BONUS             = 454, --
    SONG_SPELLCASTING_TIME          = 455, --

    AVATARS_FAVOR_ENHANCE           = 630, -- Adds 1 rank to avatars favor

    QUICK_DRAW_DMG                  = 411, --
    QUICK_DRAW_MACC                 = 191, -- Quick draw magic accuracy
    QUAD_ATTACK                     = 430, -- Quadruple attack chance.

    ENSPELL_DMG_BONUS               = 432,

    FIRE_ABSORB                     = 459, -- Occasionally absorbs fire elemental damage, in percents
    ICE_ABSORB                      = 460, -- Occasionally absorbs ice elemental damage, in percents
    WIND_ABSORB                     = 461, -- Occasionally absorbs wind elemental damage, in percents
    EARTH_ABSORB                    = 462, -- Occasionally absorbs earth elemental damage, in percents
    LTNG_ABSORB                     = 463, -- Occasionally absorbs thunder elemental damage, in percents
    WATER_ABSORB                    = 464, -- Occasionally absorbs water elemental damage, in percents
    LIGHT_ABSORB                    = 465, -- Occasionally absorbs light elemental damage, in percents
    DARK_ABSORB                     = 466, -- Occasionally absorbs dark elemental damage, in percents

    FIRE_NULL                       = 467, --
    ICE_NULL                        = 468, --
    WIND_NULL                       = 469, --
    EARTH_NULL                      = 470, --
    LTNG_NULL                       = 471, --
    WATER_NULL                      = 472, --
    LIGHT_NULL                      = 473, --
    DARK_NULL                       = 474, --

    MAGIC_ABSORB                    = 475, -- Occasionally absorbs magic damage taken, in percents
    MAGIC_NULL                      = 476, -- Occasionally annuls magic damage taken, in percents
    NULL_RANGED_DAMAGE              = 239, -- Occasionally annuls ranged damage taken, in percents
    PHYS_ABSORB                     = 512, -- Occasionally absorbs physical damage taken, in percents
    ABSORB_DMG_TO_MP                = 516, -- Unlike PLD gear mod, works on all damage types (Ethereal Earring)

    WARCRY_DURATION                 = 483, -- Warcy duration bonus from gear
    AUSPICE_EFFECT                  = 484, -- Auspice Subtle Blow Bonus
    TACTICAL_PARRY                  = 486, -- Tactical Parry TP Bonus
    MAG_BURST_BONUS                 = 487, -- Magic Burst Bonus
    INHIBIT_TP                      = 488, -- Inhibits TP Gain (percent)

    GOV_CLEARS                      = 496, -- Tracks GoV page completion (for 4% bonus on rewards).

    -- Reraise (Auto Reraise, will be used by ATMA)
    RERAISE_I                       = 456, -- Reraise.
    RERAISE_II                      = 457, -- Reraise II.
    RERAISE_III                     = 458, -- Reraise III.

    ITEM_ADDEFFECT_TYPE     = 431,  -- see procType table in scripts\globals\additional_effects.lua
    ITEM_SUBEFFECT          = 499,  -- Animation ID of Spikes and Additional Effects
    ITEM_ADDEFFECT_DMG      = 500,  -- Damage of an items Additional Effect or Spikes
    ITEM_ADDEFFECT_CHANCE   = 501,  -- Chance of an items Additional Effect or Spikes
    ITEM_ADDEFFECT_ELEMENT  = 950,  -- Element of the Additional Effect or Spikes, for resist purposes
    ITEM_ADDEFFECT_STATUS   = 951,  -- Status Effect ID to try to apply via Additional Effect or Spikes
    ITEM_ADDEFFECT_POWER    = 952,  -- Base Power for effect in MOD_ITEM_ADDEFFECT_STATUS
    ITEM_ADDEFFECT_DURATION = 953,  -- Base Duration for effect in MOD_ITEM_ADDEFFECT_STATUS
    ITEM_ADDEFFECT_OPTION   = 1180, -- Additional parameters for more specific latents required to proc

    FERAL_HOWL_DURATION             = 503, -- +20% duration per merit when wearing augmented Monster Jackcoat +2
    MANEUVER_BONUS                  = 504, -- Maneuver Stat Bonus
    OVERLOAD_THRESH                 = 505, -- Overload Threshold Bonus
    BURDEN_DECAY                    = 847, -- Increases amount of burden removed per tick
    REPAIR_EFFECT                   = 853, -- Removes # of status effects from the Automaton
    REPAIR_POTENCY                  = 854, -- Note: Only affects amount regenerated by a %, not the instant restore!
    PREVENT_OVERLOAD                = 855, -- Overloading erases a water maneuver (except on water overloads) instead, if there is one
    EXTRA_DMG_CHANCE                = 506, -- Proc rate of OCC_DO_EXTRA_DMG. 111 would be 11.1%
    OCC_DO_EXTRA_DMG                = 507, -- Multiplier for "Occasionally do x times normal damage". 250 would be 2.5 times damage.

    REM_OCC_DO_DOUBLE_DMG           = 863, -- Proc rate for REM Aftermaths that apply "Occasionally do double damage"
    REM_OCC_DO_TRIPLE_DMG           = 864, -- Proc rate for REM Aftermaths that apply "Occasionally do triple damage"

    REM_OCC_DO_DOUBLE_DMG_RANGED    = 867, -- Ranged attack specific
    REM_OCC_DO_TRIPLE_DMG_RANGED    = 868, -- Ranged attack specific

    MYTHIC_OCC_ATT_TWICE            = 865, -- Proc rate for "Occasionally attacks twice"
    MYTHIC_OCC_ATT_THRICE           = 866, -- Proc rate for "Occasionally attacks thrice"

    EAT_RAW_FISH                    = 412, --
    EAT_RAW_MEAT                    = 413, --

    ENHANCES_CURSNA_RCVD            = 67,   -- Potency of "Cursna" effects received
    ENHANCES_CURSNA                 = 310,  -- Raises success rate of Cursna when removing effect (like Doom) that are not 100% chance to remove
    ENHANCES_HOLYWATER              = 495,  -- Used by gear with the "Enhances Holy Water" or "Holy Water+" attribute
    ENHANCES_PROT_SHELL_RCVD        = 977,  -- Enhances Protect and Shell Effects Received (Binary MOD)
    ENHANCES_PROT_RCVD              = 1050, -- TODO: Enhances Protect Received (Percent)

    RETALIATION                     = 414, -- Increases damage of Retaliation hits
    THIRD_EYE_COUNTER_RATE          = 508, -- Adds counter to 3rd eye anticipates & if using Seigan counter rate is increased by 15%
    THIRD_EYE_ANTICIPATE_RATE       = 839, -- Adds anticipate rate in percents

    CLAMMING_IMPROVED_RESULTS       = 509, --
    CLAMMING_REDUCED_INCIDENTS      = 510, --
    CHOCOBO_RIDING_TIME             = 511, -- Increases chocobo riding time
    HARVESTING_RESULT               = 513, -- Improves harvesting results
    LOGGING_RESULT                  = 514, -- Improves logging results
    MINING_RESULT                   = 515, -- Improves mining results
    EGGHELM                         = 517, -- Egg Helm (Chocobo Digging)

    SHIELDBLOCKRATE                 = 518, -- Affects shield block rate, percent based
    SCAVENGE_EFFECT                 = 312, --
    DIA_DOT                         = 313, -- Increases the DoT damage of Dia
    SHARPSHOT                       = 314, -- Sharpshot accuracy bonus
    ENH_DRAIN_ASPIR                 = 315, -- % damage boost to Drain and Aspir
    SNEAK_ATK_DEX                   = 830, -- % DEX boost to Sneak Attack (if gear mod, needs to be equipped on hit)
    TRICK_ATK_AGI                   = 520, -- % AGI boost to Trick Attack (if gear mod, needs to be equipped on hit)
    NIN_NUKE_BONUS                  = 522, -- magic attack bonus for NIN nukes
    DAKEN                           = 911, -- Chance to throw shuriken on attack
    AMMO_SWING                      = 523, -- Extra swing rate w/ ammo (ie. Jailer weapons). Use gearsets, and does nothing for non-players.
    AMMO_SWING_TYPE                 = 826, -- For the handedness of the weapon - 1h (1) vs. 2h/h2h (2). h2h can safely use the same function as 2h.
    ROLL_RANGE                      = 528, -- Additional range for COR roll abilities.
    PHANTOM_ROLL                    = 881, -- Phantom Roll+ Effect from SOA Rings.
    PHANTOM_DURATION                = 882, -- Phantom Roll Duration +.

    ENHANCES_REFRESH                = 529, -- "Enhances Refresh" adds +1 per modifier to spell's tick result.
    NO_SPELL_MP_DEPLETION           = 530, -- % to not deplete MP on spellcast.
    FORCE_FIRE_DWBONUS              = 531, -- Set to 1 to force fire day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_ICE_DWBONUS               = 532, -- Set to 1 to force ice day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_WIND_DWBONUS              = 533, -- Set to 1 to force wind day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_EARTH_DWBONUS             = 534, -- Set to 1 to force earth day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_LIGHTNING_DWBONUS         = 535, -- Set to 1 to force lightning day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_WATER_DWBONUS             = 536, -- Set to 1 to force water day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_LIGHT_DWBONUS             = 537, -- Set to 1 to force light day/weather spell bonus/penalty. Do not have it total more than 1.
    FORCE_DARK_DWBONUS              = 538, -- Set to 1 to force dark day/weather spell bonus/penalty. Do not have it total more than 1.
    STONESKIN_BONUS_HP              = 539, -- Bonus "HP" granted to Stoneskin spell.
    ENHANCES_ELEMENTAL_SIPHON       = 540, -- Bonus Base MP added to Elemental Siphon skill.
    BP_DELAY_II                     = 541, -- Blood Pact Delay Reduction II
    JOB_BONUS_CHANCE                = 542, -- Chance to apply job bonus to COR roll without having the job in the party.
    DAY_NUKE_BONUS                  = 565, -- Bonus damage from "Elemental magic affected by day" (Sorc. Tonban)
    IRIDESCENCE                     = 566, -- Iridescence trait (additional weather damage/penalty)
    BARSPELL_AMOUNT                 = 567, -- Additional elemental resistance granted by bar- spells
    BARSPELL_MDEF_BONUS             = 827, -- Extra magic defense bonus granted to the bar- spell effect
    RAPTURE_AMOUNT                  = 568, -- Bonus amount added to Rapture effect
    EBULLIENCE_AMOUNT               = 569, -- Bonus amount added to Ebullience effect
    WYVERN_EFFECTIVE_BREATH         = 829, -- Increases the threshold for triggering healing breath
    ENHANCE_DEEP_BREATHING          = 283, -- Add 5/256 to deep breathing bonus per merit level when calculating healing breath
    AQUAVEIL_COUNT                  = 832, -- Modifies the amount of hits that Aquaveil absorbs before being removed
    SONG_RECAST_DELAY               = 833, -- Reduces song recast time in seconds.
    ENH_MAGIC_DURATION              = 890, -- Enhancing Magic Duration increase %
    ENHANCES_COURSERS_ROLL          = 891, -- Courser's Roll Bonus % chance
    ENHANCES_CASTERS_ROLL           = 892, -- Caster's Roll Bonus % chance
    ENHANCES_BLITZERS_ROLL          = 893, -- Blitzer's Roll Bonus % chance
    ENHANCES_ALLIES_ROLL            = 894, -- Allies' Roll Bonus % chance
    ENHANCES_TACTICIANS_ROLL        = 895, -- Tactician's Roll Bonus % chance
    OCCULT_ACUMEN                   = 902, -- Grants bonus TP when dealing damage with elemental or dark magic

    QUICK_MAGIC                     = 909, -- Percent chance spells cast instantly (also reduces recast to 0, similar to Chainspell)

    -- Automaton mods
    AUTO_DECISION_DELAY             = 842, -- Reduces the Automaton's global decision delay
    AUTO_SHIELD_BASH_DELAY          = 843, -- Reduces the Automaton's global shield bash delay
    AUTO_MAGIC_DELAY                = 844, -- Reduces the Automaton's global magic delay
    AUTO_HEALING_DELAY              = 845, -- Reduces the Automaton's global healing delay
    AUTO_HEALING_THRESHOLD          = 846, -- Increases the healing trigger threshold
    AUTO_SHIELD_BASH_SLOW           = 848, -- Adds a slow effect to Shield Bash
    AUTO_TP_EFFICIENCY              = 849, -- Causes the Automaton to wait to form a skillchain when its master is > 90% TP
    AUTO_SCAN_RESISTS               = 850, -- Causes the Automaton to scan a target's resistances
    AUTO_STEAM_JACKET               = 938, -- Causes the Automaton to mitigate damage from successive attacks of the same type
    AUTO_STEAM_JACKET_REDUCTION     = 939, -- Amount of damage reduced with Steam Jacket
    AUTO_SCHURZEN                   = 940, -- Prevents fatal damage leaving the automaton at 1HP and consumes an Earth manuever
    AUTO_EQUALIZER                  = 941, -- Reduces damage received according to damage taken
    AUTO_PERFORMANCE_BOOST          = 942, -- Increases the performance of other attachments by a percentage
    AUTO_ANALYZER                   = 943, -- Causes the Automaton to mitigate damage from a special attack a number of times
    AUTO_RANGED_DELAY               = 1001, -- Decreases the amount of time between ranged attacks
    AUTO_RANGED_DAMAGEP             = 1002, -- Increases Automaton Ranged Weapon damage by a %

    -- Mythic Weapon Mods
    AUGMENTS_ABSORB                 = 521, -- Direct Absorb spell increase while Liberator is equipped (percentage based)
    AOE_NA                          = 524, -- Set to 1 to make -na spells/erase always AoE w/ Divine Veil
    AUGMENTS_CONVERT                = 525, -- Convert HP to MP Ratio Multiplier. Value = MP multiplier rate.
    AUGMENTS_SA                     = 526, -- Adds Critical Attack Bonus to Sneak Attack, percentage based.
    AUGMENTS_TA                     = 527, -- Adds Critical Attack Bonus to Trick Attack, percentage based.
    AUGMENTS_FEINT                  = 502, -- Feint will give another -10 Evasion per merit level
    AUGMENTS_ASSASSINS_CHARGE       = 886, -- Gives Assassin's Charge +1% Critical Hit Rate per merit level
    AUGMENTS_AMBUSH                 = 887, -- Gives +1% Triple Attack per merit level when Ambush conditions are met
    AUGMENTS_AURA_STEAL             = 889, -- 20% chance of 2 effects to be dispelled or stolen per merit level
    AUGMENTS_CONSPIRATOR            = 912, -- Applies Conspirator benefits to player at the top of the hate list
    JUG_LEVEL_RANGE                 = 564, -- Decreases the level range of spawned jug pets. Maxes out at 2.
    FORCE_JUMP_CRIT                 = 828, -- Force critical hit for all jumps
    QUICK_DRAW_DMG_PERCENT          = 834, -- Percentage increase to QD damage

    -- Crafting food effects
    SYNTH_SUCCESS                   = 851, -- Rate of synthesis success
    SYNTH_SKILL_GAIN                = 852, -- Synthesis skill gain rate
    SYNTH_FAIL_RATE                 = 861, -- Synthesis failure rate (percent)
    SYNTH_HQ_RATE                   = 862, -- High-quality success rate (not a percent)
    DESYNTH_SUCCESS                 = 916, -- Rate of desynthesis success
    SYNTH_FAIL_RATE_FIRE            = 917, -- Amount synthesis failure rate is reduced when using a fire crystal
    SYNTH_FAIL_RATE_ICE             = 918, -- Amount synthesis failure rate is reduced when using a ice crystal
    SYNTH_FAIL_RATE_WIND            = 919, -- Amount synthesis failure rate is reduced when using a wind crystal
    SYNTH_FAIL_RATE_EARTH           = 920, -- Amount synthesis failure rate is reduced when using a earth crystal
    SYNTH_FAIL_RATE_LIGHTNING       = 921, -- Amount synthesis failure rate is reduced when using a lightning crystal
    SYNTH_FAIL_RATE_WATER           = 922, -- Amount synthesis failure rate is reduced when using a water crystal
    SYNTH_FAIL_RATE_LIGHT           = 923, -- Amount synthesis failure rate is reduced when using a light crystal
    SYNTH_FAIL_RATE_DARK            = 924, -- Amount synthesis failure rate is reduced when using a dark crystal
    SYNTH_FAIL_RATE_WOOD            = 925, -- Amount synthesis failure rate is reduced when doing woodworking
    SYNTH_FAIL_RATE_SMITH           = 926, -- Amount synthesis failure rate is reduced when doing smithing
    SYNTH_FAIL_RATE_GOLDSMITH       = 927, -- Amount synthesis failure rate is reduced when doing goldsmithing
    SYNTH_FAIL_RATE_CLOTH           = 928, -- Amount synthesis failure rate is reduced when doing clothcraft
    SYNTH_FAIL_RATE_LEATHER         = 929, -- Amount synthesis failure rate is reduced when doing leathercraft
    SYNTH_FAIL_RATE_BONE            = 930, -- Amount synthesis failure rate is reduced when doing bonecraft
    SYNTH_FAIL_RATE_ALCHEMY         = 931, -- Amount synthesis failure rate is reduced when doing alchemy
    SYNTH_FAIL_RATE_COOK            = 932, -- Amount synthesis failure rate is reduced when doing cooking

    WEAPONSKILL_DAMAGE_BASE         = 570, -- Specific to 1 Weaponskill: See modifier.h for how this is used
    ALL_WSDMG_ALL_HITS              = 840, -- Generic (all Weaponskills) damage, on all hits.
    -- Per https://www.bg-wiki.com/bg/Weapon_Skill_Damage we need all 3..
    ALL_WSDMG_FIRST_HIT             = 841, -- Generic (all Weaponskills) damage, first hit only.
    WS_NO_DEPLETE                   = 949, -- % chance a Weaponskill depletes no TP.
    INQUARTATA                      = 963, -- additive % bonus to base parry rate
    WS_STR_BONUS                    = 980, -- % bonus to str_wsc.
    WS_DEX_BONUS                    = 957, -- % bonus to dex_wsc.
    WS_VIT_BONUS                    = 981, -- % bonus to vit_wsc.
    WS_AGI_BONUS                    = 982, -- % bonus to agi_wsc.
    WS_INT_BONUS                    = 983, -- % bonus to int_wsc.
    WS_MND_BONUS                    = 984, -- % bonus to mnd_wsc.
    WS_CHR_BONUS                    = 985, -- % bonus to chr_wsc.

    PET_ATK_DEF                     = 990, -- Increases pet physical attack, ranged attack, and physical defense
    PET_ACC_EVA                     = 991, -- Increases pet physical accuracy, ranged accuracy, and evasion
    PET_MAB_MDB                     = 992, -- Increases pet magic attack and magic defense
    PET_MACC_MEVA                   = 993, -- Increases pet magic accuracy and evasion
    PET_ATTR_BONUS                  = 994, -- Increases pet attributes
    PET_TP_BONUS                    = 995, -- Increases pet TP bonus

    -- Circle Abilities Extended Duration from AF/AF+1
    HOLY_CIRCLE_DURATION            = 857,
    ARCANE_CIRCLE_DURATION          = 858,
    ANCIENT_CIRCLE_DURATION         = 859,

    -- Other
    CURE2MP_PERCENT                 = 860, -- Converts % of "Cure" amount to MP
    DIVINE_BENISON                  = 910, -- Adds fast cast and enmity reduction to -Na spells (includes Erase). Enmity reduction is half of the fast cast amount
    SAVETP                          = 880, -- SAVETP Effect for Miser's Roll / ATMA / Hagakure.
    SMITE                           = 898, -- Att increase with H2H or 2H weapons
    TACTICAL_GUARD                  = 899, -- Tp gain increase when guarding
    GUARD_PERCENT                   = 976, -- Guard Percent
    COUNTER_DAMAGE                  = 1047, -- TODO: Increases Damage from Counter Attacks (Percent)
    FENCER_TP_BONUS                 = 903, -- TP Bonus to weapon skills from Fencer Trait
    FENCER_CRITHITRATE              = 904, -- Increased Crit chance from Fencer Trait
    SHIELD_DEF_BONUS                = 905, -- Shield Defense Bonus
    SNEAK_DURATION                  = 946, -- Additional duration in seconds
    INVISIBLE_DURATION              = 947, -- Additional duration in seconds
    CARDINAL_CHANT                  = 959,
    INDI_DURATION                   = 960,
    GEOMANCY_BONUS                  = 961, -- Used to increase potency of "Geomancy +" items (only the highest value is counted)
    WIDENED_COMPASS                 = 962,
    MENDING_HALATION                = 968, -- This mod should never exceed 1 as the multiplier is the merit, this is basicaly just a bool mod
    RADIAL_ARCANA                   = 969,
    CURATIVE_RECANTATION            = 970,
    PRIMEVAL_ZEAL                   = 971,
    COVER_TO_MP                     = 965, -- Converts a successful cover's phsyical damage to MP
    COVER_MAGIC_AND_RANGED          = 966, -- Redirects ranged and single target magic attacks to the cover ability user
    COVER_DURATION                  = 967, -- Increases Cover Duration
    WYVERN_SUBJOB_TRAITS            = 974, -- Adds subjob traits to wyvern
    GARDENING_WILT_BONUS            = 975, -- Increases the number of Vanadays a plant can survive before it wilts

    WYVERN_BREATH_MACC              = 986,
    REGEN_BONUS                     = 989,

    SUPERIOR_LEVEL  = 997, -- SU0..5
    ONE_HOUR_RECAST = 996, -- Decreases the recast time of one-hour abilities by n minutes.

    DREAD_SPIKES_EFFECT = 998,

    PENGUIN_RING_EFFECT   = 152, -- +2 on fishing arrow delay / fish movement for mini - game
    ALBATROSS_RING_EFFECT = 153, -- adds 30 seconds to mini - game time
    PELICAN_RING_EFFECT   = 154, -- adds extra skillup roll for fishing
    FISHING_SKILL_GAIN    = 155, -- food increase for fishing skill ups

    BLOOD_BOON                   = 913, -- Occasionally cuts down MP cost of Blood Pact abilities. Does not affect abilities that require Astral Flow.
    EXPERIENCE_RETAINED          = 914, -- Experience points retained upon death (this is a percentage)
    CAPACITY_BONUS               = 915, -- Capacity point bonus granted

    CONQUEST_BONUS               = 933, -- Conquest points bonus granted (percentage)
    CONQUEST_REGION_BONUS        = 934, -- Increases the influence points awarded to the player's nation when receiving conquest points
    CAMPAIGN_BONUS               = 935, -- Increases the evaluation for allied forces by percentage

    CONSERVE_TP                  = 944, -- Conserve TP trait, random chance between 10 and 200 TP

    AUTO_ELEM_CAPACITY           = 987, -- Increases the automaton's elemental capacity for attachments
    MAX_FINISHING_MOVE_BONUS     = 988, -- Increases the maximum number of finishing moves that may be stored

    TRIPLE_SHOT_RATE             = 999, -- Percent increase to Triple Shot Rate
    NINJUTSU_DURATION            = 1000,

    -- AF3 Set Bonus Modifiers
    AUGMENT_CONSERVE_MP    = 1031, -- Percent chance to deal extra damage based on Conserve MP Amount (BLM AF3 Sets)
    AUGMENT_COMPOSURE      = 1032, -- Percent Enhancing Duration Extension for Others (RDM AF3 Sets)
    AUGMENT_DAMAGE_HP      = 1033, -- Percent chance to increase damage based on player HP% (DRK AF3 Sets)
    AUGMENT_DAMAGE_PET_HP  = 1034, -- Percent chance to increase damage based on pet HP% (BST/DRG AF3 Sets)
    AUGMENT_BLOOD_BOON     = 1035, -- Percent chance to deal extra damage based on Blood Boon Amount (SMN AF3 Sets)
    AUGMENT_BLU_MAGIC      = 1036, -- Percent chance for BLU magic to receive 3x WSC value for spell (BLU AF3 Sets)
    GEOMANCY_MP_NO_DEPLETE = 1037, -- Percent chance for Geomancy to cost 0 MP (GEO AF3 Sets)

    -- Job Point Gifts
    SIC_READY_RECAST        = 1052, -- TODO: SIC/Ready recast reduction (seconds)
    TRUE_SHOT_EFFECT        = 1053, -- TODO: True Shot Ranged Damage increase (percent)
    DEAD_AIM_EFFECT         = 1054, -- TODO: Dead Aim Critical Damage increase (percent)
    THIRD_EYE_BONUS         = 1055, -- TODO: Bonus Third Eye Evasions (count)
    WYVERN_ATTRIBUTE_DA     = 1056, -- Adds an amount of Double Attack to Dragoon each time Wyverns Attributes Increase (percent)
    DRAGOON_BREATH_RECAST   = 1057, -- Restoring/Smithing Breath Recast Reduction (seconds)
    BLUE_JOB_TRAIT_BONUS    = 1058, -- TODO: Increases job traits gained from equipped blue magic (percent)
    BLUE_MAGIC_EFFECT       = 1059, -- TODO: Bonus to Attribute Value of spell (percent)
    QUICK_DRAW_RECAST       = 1060, -- TODO: Quick Draw Charge Reduction (seconds)

    -- Permanent Resistance Build Modifiers
    SLEEPRESBUILD                 = 1138, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    POISONRESBUILD                = 1139, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    PARALYZERESBUILD              = 1140, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    BLINDRESBUILD                 = 1141, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    SILENCERESBUILD               = 1142, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    VIRUSRESBUILD                 = 1143, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    PETRIFYRESBUILD               = 1144, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    BINDRESBUILD                  = 1145, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    CURSERESBUILD                 = 1146, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    GRAVITYRESBUILD               = 1147, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    SLOWRESBUILD                  = 1148, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    STUNRESBUILD                  = 1149, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    CHARMRESBUILD                 = 1150, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    AMNESIARESBUILD               = 1151, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    LULLABYRESBUILD               = 1152, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    DEATHRESBUILD                 = 1153, -- Used to create a resbuild for the appropriate effect. Will decrease overall duration of effect. (Out of 1000)
    PET_DMG_TAKEN_PHYSICAL        = 1154, -- Percent increase/decrease in pet physical damage taken for the target.
    PET_DMG_TAKEN_MAGICAL         = 1155, -- Percent increase/decrease in pet magical damage taken for the target.
    PET_DMG_TAKEN_BREATH          = 1156, -- Percent increase/decrease in pet breath damage taken for the target.
    DIG_BYPASS_FATIGUE            = 1157, -- Chocobo digging modifier found in "Blue Race Silks". Modifier works as a direct percent. Used in Chocobo_Digging.lua

    FIRE_EEM                      = 1158, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    ICE_EEM                       = 1159, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    WIND_EEM                      = 1160, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    EARTH_EEM                     = 1161, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    THUNDER_EEM                   = 1162, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    WATER_EEM                     = 1163, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    LIGHT_EEM                     = 1164, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    DARK_EEM                      = 1165, -- Elemental Evasion Multiplier (Known as SDT in common magic accuracy formulas) (out of 100)
    TAME_SUCCESS_RATE             = 1166, -- Tame Success Rate +
    RAMPART_MAGIC_SHIELD          = 1167, -- Rampart Magic Shield
    CRITHITRATE_SLOT              = 1168, -- CRITHITRATE for slot
    ATT_SLOT                      = 1169, -- ATT for slot
    UDMG                          = 1170, -- Uncapped dmg taken (all types)
    SLEEP_MEVA                    = 1171, -- Sleep MEVA from Barspells
    POISON_MEVA                   = 1172, -- Poison MEVA from Barspells
    PARALYZE_MEVA                 = 1173, -- Paralyze MEVA from Barspells
    BLIND_MEVA                    = 1174, -- Blind MEVA from Barspells
    SILENCE_MEVA                  = 1175, -- Silence MEVA from Barspells
    VIRUS_MEVA                    = 1176, -- Virus MEVA from Barspells
    PETRIFY_MEVA                  = 1177, -- Petrify MEVA from Barspells

    -- New ASB section created per PR comment, starting at 2000
    TANDEM_STRIKE = 2000, -- Beastmaster trait - provides acc/macc to master and pet when both engage the same target
    TANDEM_BLOW   = 2001, -- Beastmaster trait - provides subtle blow to master and pet when both engage the same target

    -- IF YOU ADD ANY NEW MODIFIER HERE, ADD IT IN src/map/modifier.h ASWELL!

    -- The spares take care of finding the next ID to use so long as we don't forget to list IDs that have been freed up by refactoring.
    -- 570 - 825 used by WS DMG mods these are not spares.
    -- For Next ID, see modifier.h
    -- Spares start at: 1166
}

xi.immunity =
{
    NONE        = 0,
    SLEEP       = 1,
    GRAVITY     = 2,
    BIND        = 4,
    STUN        = 8,
    SILENCE     = 16,
    PARALYZE    = 32,
    BLIND       = 64,
    SLOW        = 128,
    POISON      = 256,
    ELEGY       = 512,
    REQUIEM     = 1024,
    LIGHT_SLEEP = 2048,
    DARK_SLEEP  = 4096,
    ASPIR       = 8192,
    TERROR      = 16384,
    DISPEL      = 32768,
}

xi.latent =
{
    HP_UNDER_PERCENT           = 0,  -- hp less than or equal to % - PARAM: HP PERCENT
    HP_OVER_PERCENT            = 1,  -- hp more than % - PARAM: HP PERCENT
    HP_UNDER_TP_UNDER_100      = 2,  -- hp less than or equal to %, tp under 100 - PARAM: HP PERCENT
    HP_OVER_TP_UNDER_100       = 3,  -- hp more than %, tp over 100 - PARAM: HP PERCENT
    MP_UNDER_PERCENT           = 4,  -- mp less than or equal to % - PARAM: MP PERCENT
    MP_UNDER                   = 5,  -- mp less than # - PARAM: MP #
    TP_UNDER                   = 6,  -- tp under # and during WS - PARAM: TP VALUE
    TP_OVER                    = 7,  -- tp over # - PARAM: TP VALUE
    SUBJOB                     = 8,  -- subjob - PARAM: JOBTYPE
    PET_ID                     = 9,  -- pettype - PARAM: PETID
    WEAPON_DRAWN               = 10, -- weapon drawn
    WEAPON_SHEATHED            = 11, -- weapon sheathed
    SIGNET_BONUS               = 12, -- While in conquest region and engaged to an even match or less target
    STATUS_EFFECT_ACTIVE       = 13, -- status effect on player - PARAM: EFFECTID
    NO_FOOD_ACTIVE             = 14, -- no food effects active on player
    PARTY_MEMBERS              = 15, -- party size # - PARAM: # OF MEMBERS
    PARTY_MEMBERS_IN_ZONE      = 16, -- party size # and members in zone - PARAM: # OF MEMBERS
    SANCTION_REGEN_BONUS       = 17, -- While in besieged region and HP is less than PARAM%
    SANCTION_REFRESH_BONUS     = 18, -- While in besieged region and MP is less than PARAM%
    SIGIL_REGEN_BONUS          = 19, -- While in campaign region and HP is less than PARAM%
    SIGIL_REFRESH_BONUS        = 20, -- While in campaign region and MP is less than PARAM%
    AVATAR_IN_PARTY            = 21, -- party has a specific avatar - PARAM: same as globals/pets.lua (21 for any avatar)
    JOB_IN_PARTY               = 22, -- party has job - PARAM: JOBTYPE
    ZONE                       = 23, -- in zone - PARAM: zoneid
    SYNTH_TRAINEE              = 24, -- synth skill under 40 + no support
    SONG_ROLL_ACTIVE           = 25, -- any song or roll active
    TIME_OF_DAY                = 26, -- PARAM: 0: DAYTIME 1: NIGHTTIME 2: DUSK-DAWN
    HOUR_OF_DAY                = 27, -- PARAM: 1: NEW DAY, 2: DAWN, 3: DAY, 4: DUSK, 5: EVENING, 6: DEAD OF NIGHT
    FIRESDAY                   = 28,
    EARTHSDAY                  = 29,
    WATERSDAY                  = 30,
    WINDSDAY                   = 31,
    DARKSDAY                   = 32,
    ICEDAY                     = 34,
    LIGHTNINGSDAY              = 35,
    LIGHTSDAY                  = 36,
    MOON_PHASE                 = 37, -- PARAM: 0: New Moon, 1: Waxing Crescent, 2: First Quarter, 3: Waxing Gibbous, 4: Full Moon, 5: Waning Gibbous, 6: Last Quarter, 7: Waning Crescent
    JOB_MULTIPLE               = 38, -- PARAM: 0: ODD, 2: EVEN, 3-99: DIVISOR
    JOB_MULTIPLE_AT_NIGHT      = 39, -- PARAM: 0: ODD, 2: EVEN, 3-99: DIVISOR
    EQUIPPED_IN_SLOT           = 40, -- When item is equipped in the specified slot (e.g. Dweomer Knife, Erlking's Sword, etc.) PARAM: slotID
    -- 41 free to use
    -- 42 free to use
    WEAPON_DRAWN_HP_UNDER      = 43, -- PARAM: HP PERCENT
    HP_BASE_UNDER_TP_UNDER_100 = 44, -- Base HP (no convert or +% taken into account) <= %, TP < 100
    MP_UNDER_VISIBLE_GEAR      = 45, -- mp less than or equal to %, calculated using MP bonuses from visible gear only
    HP_OVER_VISIBLE_GEAR       = 46, -- hp more than or equal to %, calculated using HP bonuses from visible gear only
    WEAPON_BROKEN              = 47,
    IN_DYNAMIS                 = 48,
    FOOD_ACTIVE                = 49, -- food effect (foodId) active - PARAM: FOOD ITEMID
    JOB_LEVEL_BELOW            = 50, -- PARAM: level
    JOB_LEVEL_ABOVE            = 51, -- PARAM: level
    WEATHER_ELEMENT            = 52, -- PARAM: 0: NONE, 1: FIRE, 2: ICE, 3: WIND, 4: EARTH, 5: THUNDER, 6: WATER, 7: LIGHT, 8: DARK
    NATION_CONTROL             = 53, -- checks if player region is under nation's control - PARAM: 0: Under own nation's control, 1: Outside own nation's control
    ZONE_HOME_NATION           = 54, -- in zone and citizen of nation (aketons)
    MP_OVER                    = 55, -- mp greater than # - PARAM: MP #
    WEAPON_DRAWN_MP_OVER       = 56, -- while weapon is drawn and mp greater than # - PARAM: MP #
    ELEVEN_ROLL_ACTIVE         = 57, -- corsair roll of 11 active
    IN_ASSAULT                 = 58, -- is in an Instance battle in a TOAU zone
    VS_ECOSYSTEM               = 59, -- Vs. Specific Ecosystem ID (e.g. Vs. Plantoid: Accuracy+3)
    VS_FAMILY                  = 60, -- Vs. Specific Family ID (e.g. Vs. Korrigan: Accuracy+3)
    VS_SUPERFAMILY             = 61, -- Vs. Specific Family ID (e.g. Vs. Mandragora: Accuracy+3)
    CITIZEN_OF_NATION          = 70, -- Player is a citizen of the provided nation
}

-----------------------------------
-- Merits
-----------------------------------

local meritCategory =
{
    HP_MP      = 0x0040,
    ATTRIBUTES = 0x0080,
    COMBAT     = 0x00C0,
    MAGIC      = 0x0100,
    OTHERS     = 0x0140,

    WAR_1 = 0x0180,
    MNK_1 = 0x01C0,
    WHM_1 = 0x0200,
    BLM_1 = 0x0240,
    RDM_1 = 0x0280,
    THF_1 = 0x02C0,
    PLD_1 = 0x0300,
    DRK_1 = 0x0340,
    BST_1 = 0x0380,
    BRD_1 = 0x03C0,
    RNG_1 = 0x0400,
    SAM_1 = 0x0440,
    NIN_1 = 0x0480,
    DRG_1 = 0x04C0,
    SMN_1 = 0x0500,
    BLU_1 = 0x0540,
    COR_1 = 0x0580,
    PUP_1 = 0x05C0,
    DNC_1 = 0x0600,
    SCH_1 = 0x0640,

    WS = 0x0680,

    GEO_1 = 0x06C0,
    RUN_1 = 0x0700,

    -- UNK_1 = 0x0740,
    -- UNK_2 = 0x0780,
    -- UNK_3 = 0x07C0,

    WAR_2 = 0x0800,
    MNK_2 = 0x0840,
    WHM_2 = 0x0880,
    BLM_2 = 0x08C0,
    RDM_2 = 0x0900,
    THF_2 = 0x0940,
    PLD_2 = 0x0980,
    DRK_2 = 0x09C0,
    BST_2 = 0x0A00,
    BRD_2 = 0x0A40,
    RNG_2 = 0x0A80,
    SAM_2 = 0x0AC0,
    NIN_2 = 0x0B00,
    DRG_2 = 0x0B40,
    SMN_2 = 0x0B80,
    BLU_2 = 0x0BC0,
    COR_2 = 0x0C00,
    PUP_2 = 0x0C40,
    DNC_2 = 0x0C80,
    SCH_2 = 0x0CC0,
    -- UNK_4 = 0x0D00,
    GEO_2 = 0x0D40,
    RUN_2 = 0x0D80,

    -- START = 0x0040,
    -- COUNT = 0x0D80,
}

xi.merit =
{
    -- HP
    MAX_HP                      = meritCategory.HP_MP + 0x00,
    MAX_MP                      = meritCategory.HP_MP + 0x02,

    -- ATTRIBUTES
    STR                         = meritCategory.ATTRIBUTES + 0x00,
    DEX                         = meritCategory.ATTRIBUTES + 0x02,
    VIT                         = meritCategory.ATTRIBUTES + 0x04,
    AGI                         = meritCategory.ATTRIBUTES + 0x08,
    INT                         = meritCategory.ATTRIBUTES + 0x0A,
    MND                         = meritCategory.ATTRIBUTES + 0x0C,
    CHR                         = meritCategory.ATTRIBUTES + 0x0E,

    -- COMBAT SKILLS
    H2H                         = meritCategory.COMBAT + 0x00,
    DAGGER                      = meritCategory.COMBAT + 0x02,
    SWORD                       = meritCategory.COMBAT + 0x04,
    GSWORD                      = meritCategory.COMBAT + 0x06,
    AXE                         = meritCategory.COMBAT + 0x08,
    GAXE                        = meritCategory.COMBAT + 0x0A,
    SCYTHE                      = meritCategory.COMBAT + 0x0C,
    POLEARM                     = meritCategory.COMBAT + 0x0E,
    KATANA                      = meritCategory.COMBAT + 0x10,
    GKATANA                     = meritCategory.COMBAT + 0x12,
    CLUB                        = meritCategory.COMBAT + 0x14,
    STAFF                       = meritCategory.COMBAT + 0x16,
    ARCHERY                     = meritCategory.COMBAT + 0x18,
    MARKSMANSHIP                = meritCategory.COMBAT + 0x1A,
    THROWING                    = meritCategory.COMBAT + 0x1C,
    GUARDING                    = meritCategory.COMBAT + 0x1E,
    EVASION                     = meritCategory.COMBAT + 0x20,
    SHIELD                      = meritCategory.COMBAT + 0x22,
    PARRYING                    = meritCategory.COMBAT + 0x24,

    -- MAGIC SKILLS
    DIVINE                      = meritCategory.MAGIC + 0x00,
    HEALING                     = meritCategory.MAGIC + 0x02,
    ENHANCING                   = meritCategory.MAGIC + 0x04,
    ENFEEBLING                  = meritCategory.MAGIC + 0x06,
    ELEMENTAL                   = meritCategory.MAGIC + 0x08,
    DARK                        = meritCategory.MAGIC + 0x0A,
    SUMMONING                   = meritCategory.MAGIC + 0x0C,
    NINJITSU                    = meritCategory.MAGIC + 0x0E,
    SINGING                     = meritCategory.MAGIC + 0x10,
    STRING                      = meritCategory.MAGIC + 0x12,
    WIND                        = meritCategory.MAGIC + 0x14,
    BLUE                        = meritCategory.MAGIC + 0x16,
    GEOMANCY                    = meritCategory.MAGIC + 0x18,
    HANDBELL                    = meritCategory.MAGIC + 0x1A,

    -- OTHERS
    ENMITY_INCREASE             = meritCategory.OTHERS + 0x00,
    ENMITY_DECREASE             = meritCategory.OTHERS + 0x02,
    CRIT_HIT_RATE               = meritCategory.OTHERS + 0x04,
    ENEMY_CRIT_RATE             = meritCategory.OTHERS + 0x06,
    SPELL_INTERUPTION_RATE      = meritCategory.OTHERS + 0x08,

    -- WAR 1
    BERSERK_RECAST              = meritCategory.WAR_1 + 0x00,
    DEFENDER_RECAST             = meritCategory.WAR_1 + 0x02,
    WARCRY_RECAST               = meritCategory.WAR_1 + 0x04,
    AGGRESSOR_RECAST            = meritCategory.WAR_1 + 0x06,
    DOUBLE_ATTACK_RATE          = meritCategory.WAR_1 + 0x08,

    -- MNK 1
    FOCUS_RECAST                = meritCategory.MNK_1 + 0x00,
    DODGE_RECAST                = meritCategory.MNK_1 + 0x02,
    CHAKRA_RECAST               = meritCategory.MNK_1 + 0x04,
    COUNTER_RATE                = meritCategory.MNK_1 + 0x06,
    KICK_ATTACK_RATE            = meritCategory.MNK_1 + 0x08,

    -- WHM 1
    DIVINE_SEAL_RECAST          = meritCategory.WHM_1 + 0x00,
    CURE_CAST_TIME              = meritCategory.WHM_1 + 0x02,
    BAR_SPELL_EFFECT            = meritCategory.WHM_1 + 0x04,
    BANISH_EFFECT               = meritCategory.WHM_1 + 0x06,
    REGEN_EFFECT                = meritCategory.WHM_1 + 0x08,

    -- BLM 1
    ELEMENTAL_SEAL_RECAST       = meritCategory.BLM_1 + 0x00,
    FIRE_MAGIC_POTENCY          = meritCategory.BLM_1 + 0x02,
    ICE_MAGIC_POTENCY           = meritCategory.BLM_1 + 0x04,
    WIND_MAGIC_POTENCY          = meritCategory.BLM_1 + 0x06,
    EARTH_MAGIC_POTENCY         = meritCategory.BLM_1 + 0x08,
    LIGHTNING_MAGIC_POTENCY     = meritCategory.BLM_1 + 0x0A,
    WATER_MAGIC_POTENCY         = meritCategory.BLM_1 + 0x0C,

    -- RDM 1
    CONVERT_RECAST              = meritCategory.RDM_1 + 0x00,
    FIRE_MAGIC_ACCURACY         = meritCategory.RDM_1 + 0x02,
    ICE_MAGIC_ACCURACY          = meritCategory.RDM_1 + 0x04,
    WIND_MAGIC_ACCURACY         = meritCategory.RDM_1 + 0x06,
    EARTH_MAGIC_ACCURACY        = meritCategory.RDM_1 + 0x08,
    LIGHTNING_MAGIC_ACCURACY    = meritCategory.RDM_1 + 0x0A,
    WATER_MAGIC_ACCURACY        = meritCategory.RDM_1 + 0x0C,

    -- THF 1
    FLEE_RECAST                 = meritCategory.THF_1 + 0x00,
    HIDE_RECAST                 = meritCategory.THF_1 + 0x02,
    SNEAK_ATTACK_RECAST         = meritCategory.THF_1 + 0x04,
    TRICK_ATTACK_RECAST         = meritCategory.THF_1 + 0x06,
    TRIPLE_ATTACK_RATE          = meritCategory.THF_1 + 0x08,

    -- PLD 1
    SHIELD_BASH_RECAST          = meritCategory.PLD_1 + 0x00,
    HOLY_CIRCLE_RECAST          = meritCategory.PLD_1 + 0x02,
    SENTINEL_RECAST             = meritCategory.PLD_1 + 0x04,
    COVER_EFFECT_LENGTH         = meritCategory.PLD_1 + 0x06,
    RAMPART_RECAST              = meritCategory.PLD_1 + 0x08,

    -- DRK 1
    SOULEATER_RECAST            = meritCategory.DRK_1 + 0x00,
    ARCANE_CIRCLE_RECAST        = meritCategory.DRK_1 + 0x02,
    LAST_RESORT_RECAST          = meritCategory.DRK_1 + 0x04,
    LAST_RESORT_EFFECT          = meritCategory.DRK_1 + 0x06,
    WEAPON_BASH_EFFECT          = meritCategory.DRK_1 + 0x08,

    -- BST 1
    KILLER_EFFECTS              = meritCategory.BST_1 + 0x00,
    REWARD_RECAST               = meritCategory.BST_1 + 0x02,
    CALL_BEAST_RECAST           = meritCategory.BST_1 + 0x04,
    SIC_RECAST                  = meritCategory.BST_1 + 0x06,
    TAME_RECAST                 = meritCategory.BST_1 + 0x08,

    -- BRD 1
    LULLABY_RECAST              = meritCategory.BRD_1 + 0x00,
    FINALE_RECAST               = meritCategory.BRD_1 + 0x02,
    MINNE_EFFECT                = meritCategory.BRD_1 + 0x04,
    MINUET_EFFECT               = meritCategory.BRD_1 + 0x06,
    MADRIGAL_EFFECT             = meritCategory.BRD_1 + 0x08,

    -- RNG 1
    SCAVENGE_EFFECT             = meritCategory.RNG_1 + 0x00,
    CAMOUFLAGE_RECAST           = meritCategory.RNG_1 + 0x02,
    SHARPSHOT_RECAST            = meritCategory.RNG_1 + 0x04,
    UNLIMITED_SHOT_RECAST       = meritCategory.RNG_1 + 0x06,
    RAPID_SHOT_RATE             = meritCategory.RNG_1 + 0x08,

    -- SAM 1
    THIRD_EYE_RECAST            = meritCategory.SAM_1 + 0x00,
    WARDING_CIRCLE_RECAST       = meritCategory.SAM_1 + 0x02,
    STORE_TP_EFFECT             = meritCategory.SAM_1 + 0x04,
    MEDITATE_RECAST             = meritCategory.SAM_1 + 0x06,
    ZASHIN_ATTACK_RATE          = meritCategory.SAM_1 + 0x08,

    -- NIN 1
    SUBTLE_BLOW_EFFECT          = meritCategory.NIN_1 + 0x00,
    KATON_EFFECT                = meritCategory.NIN_1 + 0x02,
    HYOTON_EFFECT               = meritCategory.NIN_1 + 0x04,
    HUTON_EFFECT                = meritCategory.NIN_1 + 0x06,
    DOTON_EFFECT                = meritCategory.NIN_1 + 0x08,
    RAITON_EFFECT               = meritCategory.NIN_1 + 0x0A,
    SUITON_EFFECT               = meritCategory.NIN_1 + 0x0C,

    -- DRG 1
    ANCIENT_CIRCLE_RECAST       = meritCategory.DRG_1 + 0x00,
    JUMP_RECAST                 = meritCategory.DRG_1 + 0x02,
    HIGH_JUMP_RECAST            = meritCategory.DRG_1 + 0x04,
    SUPER_JUMP_RECAST           = meritCategory.DRG_1 + 0x06,
    SPIRIT_LINK_RECAST          = meritCategory.DRG_1 + 0x08,

    -- SMN 1
    AVATAR_PHYSICAL_ACCURACY    = meritCategory.SMN_1 + 0x00,
    AVATAR_PHYSICAL_ATTACK      = meritCategory.SMN_1 + 0x02,
    AVATAR_MAGICAL_ACCURACY     = meritCategory.SMN_1 + 0x04,
    AVATAR_MAGICAL_ATTACK       = meritCategory.SMN_1 + 0x06,
    SUMMONING_MAGIC_CAST_TIME   = meritCategory.SMN_1 + 0x08,

    -- BLU 1
    CHAIN_AFFINITY_RECAST       = meritCategory.BLU_1 + 0x00,
    BURST_AFFINITY_RECAST       = meritCategory.BLU_1 + 0x02,
    MONSTER_CORRELATION         = meritCategory.BLU_1 + 0x04,
    PHYSICAL_POTENCY            = meritCategory.BLU_1 + 0x06,
    MAGICAL_ACCURACY            = meritCategory.BLU_1 + 0x08,

    -- COR 1
    PHANTOM_ROLL_RECAST         = meritCategory.COR_1 + 0x00,
    QUICK_DRAW_RECAST           = meritCategory.COR_1 + 0x02,
    QUICK_DRAW_ACCURACY         = meritCategory.COR_1 + 0x04,
    RANDOM_DEAL_RECAST          = meritCategory.COR_1 + 0x06,
    BUST_DURATION               = meritCategory.COR_1 + 0x08,

    -- PUP 1
    AUTOMATON_SKILLS            = meritCategory.PUP_1 + 0x00,
    MAINTENACE_RECAST           = meritCategory.PUP_1 + 0x02,
    REPAIR_EFFECT               = meritCategory.PUP_1 + 0x04,
    ACTIVATE_RECAST             = meritCategory.PUP_1 + 0x06,
    REPAIR_RECAST               = meritCategory.PUP_1 + 0x08,

    -- DNC 1
    STEP_ACCURACY               = meritCategory.DNC_1 + 0x00,
    HASTE_SAMBA_EFFECT          = meritCategory.DNC_1 + 0x02,
    REVERSE_FLOURISH_EFFECT     = meritCategory.DNC_1 + 0x04,
    BUILDING_FLOURISH_EFFECT    = meritCategory.DNC_1 + 0x06,

    -- SCH 1
    GRIMOIRE_RECAST             = meritCategory.SCH_1 + 0x00,
    MODUS_VERITAS_DURATION      = meritCategory.SCH_1 + 0x02,
    HELIX_MAGIC_ACC_ATT         = meritCategory.SCH_1 + 0x04,
    MAX_SUBLIMATION             = meritCategory.SCH_1 + 0x06,

    -- GEO 1
    FULL_CIRCLE_EFFECT          = meritCategory.GEO_1 + 0x00,
    ECLIPTIC_ATT_RECAST         = meritCategory.GEO_1 + 0x02,
    LIFE_CYCLE_RECAST           = meritCategory.GEO_1 + 0x04,
    BLAZE_OF_GLORY_RECAST       = meritCategory.GEO_1 + 0x06,
    DEMATERIALIZE_RECAST        = meritCategory.GEO_1 + 0x08,

    -- RUN 1
    MERIT_RUNE_ENHANCE          = meritCategory.RUN_1 + 0x00,
    MERIT_VALLATION_EFFECT      = meritCategory.RUN_1 + 0x02,
    MERIT_LUNGE_EFFECT          = meritCategory.RUN_1 + 0x04,
    MERIT_PFLUG_EFFECT          = meritCategory.RUN_1 + 0x06,
    MERIT_GAMBIT_EFFECT         = meritCategory.RUN_1 + 0x08,

    -- WAR 2
    WARRIORS_CHARGE             = meritCategory.WAR_2 + 0x00,
    TOMAHAWK                    = meritCategory.WAR_2 + 0x02,
    SAVAGERY                    = meritCategory.WAR_2 + 0x04,
    AGGRESSIVE_AIM              = meritCategory.WAR_2 + 0x06,

    -- MNK 2
    MANTRA                      = meritCategory.MNK_2 + 0x00,
    FORMLESS_STRIKES            = meritCategory.MNK_2 + 0x02,
    INVIGORATE                  = meritCategory.MNK_2 + 0x04,
    PENANCE                     = meritCategory.MNK_2 + 0x06,

    -- WHM 2
    MARTYR                      = meritCategory.WHM_2 + 0x00,
    DEVOTION                    = meritCategory.WHM_2 + 0x02,
    PROTECTRA_V                 = meritCategory.WHM_2 + 0x04,
    SHELLRA_V                   = meritCategory.WHM_2 + 0x06,
    ANIMUS_SOLACE               = meritCategory.WHM_2 + 0x08,
    ANIMUS_MISERY               = meritCategory.WHM_2 + 0x0A,

    -- BLM 2
    FLARE_II                    = meritCategory.BLM_2 + 0x00,
    FREEZE_II                   = meritCategory.BLM_2 + 0x02,
    TORNADO_II                  = meritCategory.BLM_2 + 0x04,
    QUAKE_II                    = meritCategory.BLM_2 + 0x06,
    BURST_II                    = meritCategory.BLM_2 + 0x08,
    FLOOD_II                    = meritCategory.BLM_2 + 0x0A,
    ANCIENT_MAGIC_ATK_BONUS     = meritCategory.BLM_2 + 0x0C,
    ANCIENT_MAGIC_BURST_DMG     = meritCategory.BLM_2 + 0x0E,
    ELEMENTAL_MAGIC_ACCURACY    = meritCategory.BLM_2 + 0x10,
    ELEMENTAL_DEBUFF_DURATION   = meritCategory.BLM_2 + 0x12,
    ELEMENTAL_DEBUFF_EFFECT     = meritCategory.BLM_2 + 0x14,
    ASPIR_ABSORPTION_AMOUNT     = meritCategory.BLM_2 + 0x16,

    -- RDM 2
    DIA_III                     = meritCategory.RDM_2 + 0x00,
    SLOW_II                     = meritCategory.RDM_2 + 0x02,
    PARALYZE_II                 = meritCategory.RDM_2 + 0x04,
    PHALANX_II                  = meritCategory.RDM_2 + 0x06,
    BIO_III                     = meritCategory.RDM_2 + 0x08,
    BLIND_II                    = meritCategory.RDM_2 + 0x0A,
    ENFEEBLING_MAGIC_DURATION   = meritCategory.RDM_2 + 0x0C,
    MAGIC_ACCURACY              = meritCategory.RDM_2 + 0x0E,
    ENHANCING_MAGIC_DURATION    = meritCategory.RDM_2 + 0x10,
    IMMUNOBREAK_CHANCE          = meritCategory.RDM_2 + 0x12,
    ENSPELL_DAMAGE              = meritCategory.RDM_2 + 0x14,
    ACCURACY                    = meritCategory.RDM_2 + 0x16,

    -- THF 2
    ASSASSINS_CHARGE            = meritCategory.THF_2 + 0x00,
    FEINT                       = meritCategory.THF_2 + 0x02,
    AURA_STEAL                  = meritCategory.THF_2 + 0x04,
    AMBUSH                      = meritCategory.THF_2 + 0x06,

    -- PLD 2
    FEALTY                      = meritCategory.PLD_2 + 0x00,
    CHIVALRY                    = meritCategory.PLD_2 + 0x02,
    IRON_WILL                   = meritCategory.PLD_2 + 0x04,
    GUARDIAN                    = meritCategory.PLD_2 + 0x06,

    -- DRK 2
    DARK_SEAL                   = meritCategory.DRK_2 + 0x00,
    DIABOLIC_EYE                = meritCategory.DRK_2 + 0x02,
    MUTED_SOUL                  = meritCategory.DRK_2 + 0x04,
    DESPERATE_BLOWS             = meritCategory.DRK_2 + 0x06,

    -- BST 2
    FERAL_HOWL                  = meritCategory.BST_2 + 0x00,
    KILLER_INSTINCT             = meritCategory.BST_2 + 0x02,
    BEAST_AFFINITY              = meritCategory.BST_2 + 0x04,
    BEAST_HEALER                = meritCategory.BST_2 + 0x06,

    -- BRD 2
    NIGHTINGALE                 = meritCategory.BRD_2 + 0x00,
    TROUBADOUR                  = meritCategory.BRD_2 + 0x02,
    FOE_SIRVENTE                = meritCategory.BRD_2 + 0x04,
    ADVENTURERS_DIRGE           = meritCategory.BRD_2 + 0x06,
    CON_ANIMA                   = meritCategory.BRD_2 + 0x08,
    CON_BRIO                    = meritCategory.BRD_2 + 0x0A,

    -- RNG 2
    STEALTH_SHOT                = meritCategory.RNG_2 + 0x00,
    FLASHY_SHOT                 = meritCategory.RNG_2 + 0x02,
    SNAPSHOT                    = meritCategory.RNG_2 + 0x04,
    RECYCLE                     = meritCategory.RNG_2 + 0x06,

    -- SAM 2
    SHIKIKOYO                   = meritCategory.SAM_2 + 0x00,
    BLADE_BASH                  = meritCategory.SAM_2 + 0x02,
    IKISHOTEN                   = meritCategory.SAM_2 + 0x04,
    OVERWHELM                   = meritCategory.SAM_2 + 0x06,

    -- NIN 2
    SANGE                       = meritCategory.NIN_2 + 0x00,
    NINJA_TOOL_EXPERTISE        = meritCategory.NIN_2 + 0x02,
    KATON_SAN                   = meritCategory.NIN_2 + 0x04,
    HYOTON_SAN                  = meritCategory.NIN_2 + 0x06,
    HUTON_SAN                   = meritCategory.NIN_2 + 0x08,
    DOTON_SAN                   = meritCategory.NIN_2 + 0x0A,
    RAITON_SAN                  = meritCategory.NIN_2 + 0x0C,
    SUITON_SAN                  = meritCategory.NIN_2 + 0x0E,
    YONIN_EFFECT                = meritCategory.NIN_2 + 0x10,
    INNIN_EFFECT                = meritCategory.NIN_2 + 0x12,
    NIN_MAGIC_ACCURACY          = meritCategory.NIN_2 + 0x14,
    NIN_MAGIC_BONUS             = meritCategory.NIN_2 + 0x16,

    -- DRG 2
    DEEP_BREATHING              = meritCategory.DRG_2 + 0x00,
    ANGON                       = meritCategory.DRG_2 + 0x02,
    EMPATHY                     = meritCategory.DRG_2 + 0x04,
    STRAFE_EFFECT               = meritCategory.DRG_2 + 0x06,

    -- SMN 2
    METEOR_STRIKE               = meritCategory.SMN_2 + 0x00,
    HEAVENLY_STRIKE             = meritCategory.SMN_2 + 0x02,
    WIND_BLADE                  = meritCategory.SMN_2 + 0x04,
    GEOCRUSH                    = meritCategory.SMN_2 + 0x06,
    THUNDERSTORM                = meritCategory.SMN_2 + 0x08,
    GRANDFALL                   = meritCategory.SMN_2 + 0x0A,

    -- BLU 2
    CONVERGENCE                 = meritCategory.BLU_2 + 0x00,
    DIFFUSION                   = meritCategory.BLU_2 + 0x02,
    ENCHAINMENT                 = meritCategory.BLU_2 + 0x04,
    ASSIMILATION                = meritCategory.BLU_2 + 0x06,

    -- COR 2
    SNAKE_EYE                   = meritCategory.COR_2 + 0x00,
    FOLD                        = meritCategory.COR_2 + 0x02,
    WINNING_STREAK              = meritCategory.COR_2 + 0x04,
    LOADED_DECK                 = meritCategory.COR_2 + 0x06,

    -- PUP 2
    ROLE_REVERSAL               = meritCategory.PUP_2 + 0x00,
    VENTRILOQUY                 = meritCategory.PUP_2 + 0x02,
    FINE_TUNING                 = meritCategory.PUP_2 + 0x04,
    OPTIMIZATION                = meritCategory.PUP_2 + 0x06,

    -- DNC 2
    SABER_DANCE                 = meritCategory.DNC_2 + 0x00,
    FAN_DANCE                   = meritCategory.DNC_2 + 0x02,
    NO_FOOT_RISE                = meritCategory.DNC_2 + 0x04,
    CLOSED_POSITION             = meritCategory.DNC_2 + 0x06,

    -- SCH 2
    ALTRUISM                    = meritCategory.SCH_2 + 0x00,
    FOCALIZATION                = meritCategory.SCH_2 + 0x02,
    TRANQUILITY                 = meritCategory.SCH_2 + 0x04,
    EQUANIMITY                  = meritCategory.SCH_2 + 0x06,
    ENLIGHTENMENT               = meritCategory.SCH_2 + 0x08,
    STORMSURGE                  = meritCategory.SCH_2 + 0x0A,

    -- GEO 2
    MENDING_HALATION            = meritCategory.GEO_2 + 0x00,
    RADIAL_ARCANA               = meritCategory.GEO_2 + 0x02,
    CURATIVE_RECANTATION        = meritCategory.GEO_2 + 0x04,
    PRIMEVAL_ZEAL               = meritCategory.GEO_2 + 0x06,

    -- RUN 2
    MERIT_BATTUTA               = meritCategory.RUN_2 + 0x00,
    MERIT_RAYKE                 = meritCategory.RUN_2 + 0x02,
    MERIT_INSPIRATION           = meritCategory.RUN_2 + 0x04,
    MERIT_SLEIGHT_OF_SWORD      = meritCategory.RUN_2 + 0x06,
}

-----------------------------------
-- Inventory locations
-----------------------------------

xi.inventoryLocation =
{
    INVENTORY        = 0,
    MOGSAFE          = 1,
    STORAGE          = 2,
    TEMPITEMS        = 3,
    MOGLOCKER        = 4,
    MOGSATCHEL       = 5,
    MOGSACK          = 6,
    MOGCASE          = 7,
    WARDROBE         = 8,
    MOGSAFE2         = 9,
    WARDROBE2        = 10,
    WARDROBE3        = 11,
    WARDROBE4        = 12,
    WARDROBE5        = 13,
    WARDROBE6        = 14,
    WARDROBE7        = 15,
    WARDROBE8        = 16,
    RECYCLEBIN       = 17,
    MAX_CONTAINER_ID = 18,
}
xi.inv = xi.inventoryLocation

-----------------------------------
-- Equipment Slots
-----------------------------------

xi.slot =
{
    MAIN   = 0,
    SUB    = 1,
    RANGED = 2,
    AMMO   = 3,
    HEAD   = 4,
    BODY   = 5,
    HANDS  = 6,
    LEGS   = 7,
    FEET   = 8,
    NECK   = 9,
    WAIST  = 10,
    EAR1   = 11,
    EAR2   = 12,
    RING1  = 13,
    RING2  = 14,
    BACK   = 15,
}
xi.MAX_SLOTID  = 15

-----------------------------------
-- Objtype Definitions
-----------------------------------

xi.objType =
{
    PC     = 0x01,
    NPC    = 0x02,
    MOB    = 0x04,
    PET    = 0x08,
    SHIP   = 0x10,
    TRUST  = 0x20,
    FELLOW = 0x40,
}

-----------------------------------
-- Attack Type
-----------------------------------

xi.attackType =
{
    NONE     = 0,
    PHYSICAL = 1,
    MAGICAL  = 2,
    RANGED   = 3,
    SPECIAL  = 4,
    BREATH   = 5,
}

-----------------------------------
-- Damage Type
-----------------------------------

xi.damageType =
{
    NONE      = 0,
    PIERCING  = 1,
    SLASHING  = 2,
    BLUNT     = 3,
    HTH       = 4,
    ELEMENTAL = 5,
    FIRE      = 6,
    ICE       = 7,
    WIND      = 8,
    EARTH     = 9,
    LIGHTNING = 10,
    WATER     = 11,
    LIGHT     = 12,
    DARK      = 13,
}

-----------------------------------
-- Drop Type (not currently used in code base)
-----------------------------------

-- DROP_NORMAL  = 0x00
-- DROP_GROUPED = 0x01
-- DROP_STEAL   = 0x02
-- DROP_DESPOIL = 0x04
