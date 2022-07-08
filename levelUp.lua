local MODULE_NAME = "Eluna levelUp"
local MODULE_VERSION = '1.6.1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Gold = {
    [20] = 1000000,
    [40] = 10000000,
    [60] = 100000000,
    [80] = 1000000000,
}

local Pets = {
    [1]  = 13582, -- Zergling
    [2]  = 13584, -- Mini Diablo
    [3]  = 25535, -- Netherwhelp
    [4]  = 39656, -- Mini Tyrael
    [5]  = 46767, -- Warbot
    [6]  = 46892, -- Murkimus the Gladiator
    [7]  = 49646, -- Core Hound Pup
    [8]  = 49693, -- Lil' K.T.
    [9]  = 34492, -- Rocket Chicken
    [10] = 49663, -- Wind Rider Cub
    [11] = 48527, -- Onyx Panther
    [12] = 54847, -- Lil' XT
    [13] = 34955, -- Scorched Stone
    [14] = 39286, -- Frosty
    [15] = 54810, -- Celestial Dragon
    [16] = 54436, -- Blue Clockwork Rocket Bot
    [17] = 49662, -- Gryphon Hatchling
    [18] = 49665, -- Pandaren Monk
    [19] = 39973, -- Ghostly Skull
    [20] = 35504, -- Phoenix Hatchling
}

local Titles = {
    [1]  = 143,   -- Jenkins
    [2]  = 155,   -- the Noble
    [3]  = 134,   -- the Merrymaker
    [4]  =  22,   -- Legionnaire
    [5]  = 125,   -- Loremaster
    [6]  = 172,   -- the Patient
    [7]  =  27,   -- Warlord
    [8]  =   4,   -- Master Sergeant
    [9]  =  76,   -- Flame Keeper
    [10] =  11,   -- Commander
    [11] = 174,   -- Bane of the Fallen King
    [12] =  47,   -- Conqueror
    [13] =  72,   -- Battlemaster
    [14] = 145,   -- the Insane
    [15] =   9,   -- Knight-Champion
    [16] =  77,   -- the Exalted
    [17] = 141,   -- the Immortal
    [18] = 124,   -- the Hallowed
    [19] =  83,   -- Salty
    [20] = 154,   -- of the Undercity
}

local Spells = {
    -- All Classes (0)
    {class = 0, level = 20, type = 1, entry = 63624}, -- Dual Talent Specialization
    {class = 0, level = 20, type = 3, entry = 43},    -- Duelist
    {class = 0, level = 20, type = 1, entry = 33389}, -- Apprentice Riding
    {class = 0, level = 20, type = 0, entry = 64731}, -- Sea Turtle
    {class = 0, level = 40, type = 0, entry = 75614}, -- Celestial Steed
    {class = 0, level = 40, type = 1, entry = 33392}, -- Journeyman Riding
    {class = 0, level = 60, type = 1, entry = 34092}, -- Expert Riding
    {class = 0, level = 60, type = 0, entry = 48025}, -- Headless Horseman's Mount
    {class = 0, level = 68, type = 0, entry = 54197}, -- Cold Weather Flying
    {class = 0, level = 70, type = 1, entry = 34093}, -- Artisan Riding
    {class = 0, level = 80, type = 0, entry = 72286}, -- Invincible
    -- Warrior (1)
    {class = 1, level = 10, type = 1, entry = 8121}, -- Path of Defense
    {class = 1, level = 30, type = 1, entry = 8616}, -- Path of the Berserker
    {class = 1, level = 40, type = 0, entry = 750},  -- Plate Armor
    -- Paladin (2)
    {class = 2, level = 40, type = 0, entry = 750},   -- Plate Armor
    -- Hunter (3)
    {class = 3, level = 10, type = 1, entry = 1579}, -- Tame Beast
    {class = 3, level = 10, type = 1, entry = 5300}, -- Beast Training
    {class = 3, level = 40, type = 0, entry = 8737},  -- Mail Armor
    -- Shaman (7)
    {class = 7, level = 4, type = 1, entry  = 8073}, -- Stoneskin Totem
    {class = 7, level = 4, type = 2, entry  = 5175}, -- Earth Totem
    {class = 7, level = 10, type = 1, entry = 2075}, -- Searing Totem
    {class = 7, level = 10, type = 2, entry = 5176}, -- Fire Totem
    {class = 7, level = 20, type = 1, entry = 5396}, -- Healing Stream Totem
    {class = 7, level = 20, type = 2, entry = 5177}, -- Water Totem
    {class = 7, level = 30, type = 2, entry = 5178}, -- Air Totem
    {class = 7, level = 40, type = 0, entry = 8737},  -- Mail Armor
    -- Warlock (9)
    {class = 9, level = 10, type = 1, entry = 11520}, -- Summon Voidwalker
    {class = 9, level = 20, type = 1, entry = 11519}, -- Summon Succubus
    {class = 9, level = 20, type = 1, entry = 5785},  -- Summon Felsteed
    {class = 9, level = 20, type = 2, entry = 22243}, -- Small Soul Pouch
    {class = 9, level = 30, type = 1, entry = 1373},  -- Summon Felhunter
    {class = 9, level = 30, type = 2, entry = 22244}, -- Box of Souls
    {class = 9, level = 40, type = 1, entry = 23160}, -- Summon Dreadsteed
    -- Druid (11)
    {class = 11, level = 10, type = 1, entry = 19027}, -- Teleport: Moonglade
    {class = 11, level = 10, type = 1, entry = 19179}, -- Bear Form
    {class = 11, level = 10, type = 1, entry = 8947},  -- Cure Poison
}

local Gear = {

    -- Warrior (1)
    {class = 1, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 1, level = 20, item = 2, entry = 5193},  -- Cape of the Brotherhood
    {class = 1, level = 20, item = 3, entry = 6087},  -- Chausses of Westfall
    {class = 1, level = 20, item = 4, entry = 12978}, -- Stormbringer Belt
    {class = 1, level = 20, item = 5, entry = 12994}, -- Thorbia's Gauntlets
    {class = 1, level = 20, item = 6, entry = 12982}, -- Silver-linked Footguards
    {class = 1, level = 20, item = 7, entry = 2868},  -- Patterned Bronze Bracers

    {class = 1, level = 40, item = 1, entry = 10763}, -- Icemetal Barbute
    {class = 1, level = 40, item = 2, entry = 13121}, -- Wing of the Whelpling
    {class = 1, level = 40, item = 3, entry = 7921},  -- Heavy Mithril Pants
    {class = 1, level = 40, item = 4, entry = 13145}, -- Enormous Ogre Belt
    {class = 1, level = 40, item = 5, entry = 7938},  -- Truesilver Gauntlets
    {class = 1, level = 40, item = 6, entry = 13068}, -- Obsidian Greaves
    {class = 1, level = 40, item = 7, entry = 19581}, -- Berserker Bracers

    {class = 1, level = 60, item = 1, entry = 16866}, -- Helm of Might
    {class = 1, level = 60, item = 2, entry = 21394}, -- Drape of Unyielding Strength
    {class = 1, level = 60, item = 3, entry = 16867}, -- Legplates of Might
    {class = 1, level = 60, item = 4, entry = 16864}, -- Belt of Might
    {class = 1, level = 60, item = 5, entry = 16863}, -- Gauntlets of Might
    {class = 1, level = 60, item = 6, entry = 16862}, -- Sabatons of Might
    {class = 1, level = 60, item = 7, entry = 16861}, -- Bracers of Might

    {class = 1, level = 80, item =  1, entry = 41350}, -- Savage Saronite Skullshield
    {class = 1, level = 80, item =  2, entry = 41351}, -- Savage Saronite Pauldrons
    {class = 1, level = 80, item =  3, entry = 41353}, -- Savage Saronite Hauberk
    {class = 1, level = 80, item =  4, entry = 41347}, -- Savage Saronite Legplates
    {class = 1, level = 80, item =  5, entry = 41352}, -- Savage Saronite Waistguard
    {class = 1, level = 80, item =  6, entry = 41349}, -- Savage Saronite Gauntlets
    {class = 1, level = 80, item =  7, entry = 41348}, -- Savage Saronite Walkers
    {class = 1, level = 80, item =  8, entry = 41354}, -- Savage Saronite Bracers
    {class = 1, level = 80, item =  9, entry = 45811}, -- Frotguard Drape
    {class = 1, level = 80, item = 10, entry = 41182}, -- Savage Cobalt Slicer
    {class = 1, level = 80, item = 11, entry = 41182}, -- Savage Cobalt Slicer
    {class = 1, level = 80, item = 12, entry = 41113}, -- Saronite Bulwark

    -- Paladin (2)
    {class = 2, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 2, level = 20, item = 2, entry = 6629},  -- Sporid Cape
    {class = 2, level = 20, item = 3, entry = 6087},  -- Chausses of Westfall
    {class = 2, level = 20, item = 4, entry = 12978}, -- Stormbringer Belt
    {class = 2, level = 20, item = 5, entry = 12994}, -- Thorbia's Gauntlets
    {class = 2, level = 20, item = 6, entry = 12982}, -- Silver-linked Footguards
    {class = 2, level = 20, item = 7, entry = 2868},  -- Patterned Bronze Bracers

    {class = 2, level = 40, item = 1, entry = 10763}, -- Icemetal Barbute
    {class = 2, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 2, level = 40, item = 3, entry = 33258}, -- Protective Engineer's Leggings
    {class = 2, level = 40, item = 4, entry = 13145}, -- Enormous Ogre Belt
    {class = 2, level = 40, item = 5, entry = 7938},  -- Truesilver Gauntlets
    {class = 2, level = 40, item = 6, entry = 13068}, -- Obsidian Greaves
    {class = 2, level = 40, item = 7, entry = 19581}, -- Berserker Bracers

    {class = 2, level = 60, item = 1, entry = 16854}, -- Lawbringer Helm
    {class = 2, level = 60, item = 2, entry = 21397}, -- Cape of Eternal Justice
    {class = 2, level = 60, item = 3, entry = 16855}, -- Lawbringer Legplates
    {class = 2, level = 60, item = 4, entry = 16858}, -- Lawbringer Belt
    {class = 2, level = 60, item = 5, entry = 16860}, -- Lawbringer Gauntlets
    {class = 2, level = 60, item = 6, entry = 16859}, -- Lawbringer Boots
    {class = 2, level = 60, item = 7, entry = 16857}, -- Lawbringer Bracers

    {class = 2, level = 80, item =  1, entry = 42728}, -- Ornate Saronite Skullshield
    {class = 2, level = 80, item =  2, entry = 42727}, -- Ornate Saronite Pauldrons
    {class = 2, level = 80, item =  3, entry = 42725}, -- Ornate Saronite Hauberk
    {class = 2, level = 80, item =  4, entry = 42726}, -- Ornate Saronite Legplates
    {class = 2, level = 80, item =  5, entry = 42729}, -- Ornate Saronite Waistguard
    {class = 2, level = 80, item =  6, entry = 42724}, -- Ornate Saronite Gauntlets
    {class = 2, level = 80, item =  7, entry = 42730}, -- Ornate Saronite Walkers
    {class = 2, level = 80, item =  8, entry = 42723}, -- Ornate Saronite  Bracers
    {class = 2, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 2, level = 80, item = 10, entry = 41257}, -- Titansteel Destroyer
    {class = 2, level = 80, item = 11, entry = 42443}, -- Cudgel of Saronite Justice
    {class = 2, level = 80, item = 12, entry = 41117}, -- Saronite Protector

    -- Hunter (3)
    {class = 3, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 3, level = 20, item = 2, entry = 5193},  -- Cape of the Brotherhood
    {class = 3, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 3, level = 20, item = 4, entry = 6468},  -- Deviate Scale Belt
    {class = 3, level = 20, item = 5, entry = 7348},  -- Fletcher's Gloves
    {class = 3, level = 20, item = 6, entry = 1121},  -- Feet of the Lynx
    {class = 3, level = 20, item = 7, entry = 4794},  -- Wolf Bracers

    {class = 3, level = 40, item = 1, entry = 1624},  -- Skullsplitter Helm
    {class = 3, level = 40, item = 2, entry = 13121}, -- Wing of the Whelpling
    {class = 3, level = 40, item = 3, entry = 9396},  -- Legguards of the Vault
    {class = 3, level = 40, item = 4, entry = 20089}, -- Highlander's Chain Girdle
    {class = 3, level = 40, item = 5, entry = 8347},  -- Dragonscale Gauntlets
    {class = 3, level = 40, item = 6, entry = 20092}, -- Highlander's Chain Greaves
    {class = 3, level = 40, item = 7, entry = 19584}, -- Windtalker's Wristguards

    {class = 3, level = 60, item = 1, entry = 16846}, -- Giantstalker's Helmet
    {class = 3, level = 60, item = 2, entry = 21403}, -- Cloak of the Unseen Path
    {class = 3, level = 60, item = 3, entry = 16847}, -- Giantstalker's Leggings
    {class = 3, level = 60, item = 4, entry = 16851}, -- Giantstalker's Belt
    {class = 3, level = 60, item = 5, entry = 16852}, -- Giantstalker's Gloves
    {class = 3, level = 60, item = 6, entry = 16849}, -- Giantstalker's Boots
    {class = 3, level = 60, item = 7, entry = 16850}, -- Giantstalker's Bracers

    {class = 3, level = 80, item =  1, entry = 43447}, -- Swiftarrow Helm
    {class = 3, level = 80, item =  2, entry = 43449}, -- Swiftarrow Shoulderguards
    {class = 3, level = 80, item =  3, entry = 43445}, -- Swiftarrow Hauberk
    {class = 3, level = 80, item =  4, entry = 43448}, -- Swiftarrow Leggins
    {class = 3, level = 80, item =  5, entry = 43442}, -- Swiftarrow Belt
    {class = 3, level = 80, item =  6, entry = 43446}, -- Swiftarrow Gauntlets
    {class = 3, level = 80, item =  7, entry = 43443}, -- Swiftarrow Boots
    {class = 3, level = 80, item =  8, entry = 43444}, -- Swiftarrow Bracers
    {class = 3, level = 80, item =  9, entry = 38441}, -- Cloak of Harsh Winds
    {class = 3, level = 80, item = 10, entry = 37615}, -- Titanium Compound Bow
    {class = 3, level = 80, item = 11, entry = 36962}, -- Wyrmclaw Battleaxe
    {class = 3, level = 80, item = 12, entry = 41167}, -- Heartseeker Scope

    -- Rogue (4)
    {class = 4, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 4, level = 20, item = 2, entry = 5193},  -- Cape of the Brotherhood
    {class = 4, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 4, level = 20, item = 4, entry = 6468},  -- Deviate Scale Belt
    {class = 4, level = 20, item = 5, entry = 14572}, -- Bristlebark Gloves
    {class = 4, level = 20, item = 6, entry = 1121},  -- Feet of the Lynx
    {class = 4, level = 20, item = 7, entry = 4794},  -- Wolf Bracers

    {class = 4, level = 40, item = 1, entry = 8176},  -- Nightscape Headband
    {class = 4, level = 40, item = 2, entry = 13121}, -- Wing of the Whelpling
    {class = 4, level = 40, item = 3, entry = 9414},  -- Oilskin Leggings
    {class = 4, level = 40, item = 4, entry = 20116}, -- Highlander's Leather Girdle
    {class = 4, level = 40, item = 5, entry = 34417}, -- Marauder's Handwraps
    {class = 4, level = 40, item = 6, entry = 20113}, -- Highlander's Leather Boots
    {class = 4, level = 40, item = 7, entry = 19590}, -- Forest Stalker's Bracers

    {class = 4, level = 60, item = 1, entry = 16821}, -- Nightslayer Cover
    {class = 4, level = 60, item = 2, entry = 21406}, -- Cloak of Veiled Shadows
    {class = 4, level = 60, item = 3, entry = 16822}, -- Nightslayer Pants
    {class = 4, level = 60, item = 4, entry = 16827}, -- Nightslayer Belt
    {class = 4, level = 60, item = 5, entry = 16826}, -- Nightslayer Gloves
    {class = 4, level = 60, item = 6, entry = 16824}, -- Nightslayer Boots
    {class = 4, level = 60, item = 7, entry = 16825}, -- Nightslayer Bracelets

    {class = 4, level = 80, item =  1, entry = 43260}, -- Eviscerator's Facemask
    {class = 4, level = 80, item =  2, entry = 43433}, -- Eviscerator's Shoulderpads
    {class = 4, level = 80, item =  3, entry = 43434}, -- Eviscerator's Chestguard
    {class = 4, level = 80, item =  4, entry = 43438}, -- Eviscerator's Legguards
    {class = 4, level = 80, item =  5, entry = 43437}, -- Eviscerator's Waistguard
    {class = 4, level = 80, item =  6, entry = 43436}, -- Eviscerator's Gauntlets
    {class = 4, level = 80, item =  7, entry = 43439}, -- Eviscerator's Treads
    {class = 4, level = 80, item =  8, entry = 43435}, -- Eviscerator's Bindings
    {class = 4, level = 80, item =  9, entry = 38441}, -- Cloak of Harsh Winds
    {class = 4, level = 80, item = 10, entry = 41184}, -- Saronite Shiv
    {class = 4, level = 80, item = 11, entry = 41184}, -- Saronite Shiv
    {class = 4, level = 80, item = 12, entry = 41245}, -- Deadly Saronite Dirk

    -- Priest (5)
    {class = 5, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 5, level = 20, item = 2, entry = 6629},  -- Sporid Cape
    {class = 5, level = 20, item = 3, entry = 23173}, -- Abomination Skin Leggings
    {class = 5, level = 20, item = 4, entry = 2911},  -- Keller's Girdle
    {class = 5, level = 20, item = 5, entry = 12977}, -- Magefist Gloves
    {class = 5, level = 20, item = 6, entry = 4320},  -- Spidersilk Boots
    {class = 5, level = 20, item = 7, entry = 14375}, -- Sanguine Cuffs

    {class = 5, level = 40, item = 1, entry = 20969}, -- Ruby Crown of Restoration
    {class = 5, level = 40, item = 2, entry = 6629},  -- Sporid Cape
    {class = 5, level = 40, item = 3, entry = 7709},  -- Blighted Leggings
    {class = 5, level = 40, item = 4, entry = 20098}, -- Highlander's Cloth Girdle
    {class = 5, level = 40, item = 5, entry = 10019}, -- Dreamweave Gloves
    {class = 5, level = 40, item = 6, entry = 20095}, -- Highlander's Cloth Boots
    {class = 5, level = 40, item = 7, entry = 19597}, -- Dryad's Wrist Bindings

    {class = 5, level = 60, item = 1, entry = 16813}, -- Circlet of Prophecy
    {class = 5, level = 60, item = 2, entry = 21412}, -- Shroud of Infinite Wisdom
    {class = 5, level = 60, item = 3, entry = 16814}, -- Pants of Prophecy
    {class = 5, level = 60, item = 4, entry = 16817}, -- Girdle of Prophecy
    {class = 5, level = 60, item = 5, entry = 16812}, -- Gloves of Prophecy
    {class = 5, level = 60, item = 6, entry = 16811}, -- Boots of Prophecy
    {class = 5, level = 60, item = 7, entry = 16819}, -- Vambraces of Prophecy

    {class = 5, level = 80, item =  1, entry = 43971}, -- Frostsavage Cowl
    {class = 5, level = 80, item =  2, entry = 43973}, -- Frostsavage Shoulders
    {class = 5, level = 80, item =  3, entry = 43972}, -- Frostsavage Shoulders
    {class = 5, level = 80, item =  4, entry = 43975}, -- Frostsavage Shoulders
    {class = 5, level = 80, item =  5, entry = 43969}, -- Frostsavage Belt
    {class = 5, level = 80, item =  6, entry = 41516}, -- Frostsavage Gloves
    {class = 5, level = 80, item =  7, entry = 43970}, -- Frostsavage Boots
    {class = 5, level = 80, item =  8, entry = 43974}, -- Frostsavage Bracers
    {class = 5, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 5, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 5, level = 80, item = 11, entry = 37626}, -- Wand of Sseratus
    {class = 5, level = 80, item = 12, entry = 37177}, -- Wand of the San'layn

    -- Shaman (7)
    {class = 7, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 7, level = 20, item = 2, entry = 6629},  -- Sporid Cape
    {class = 7, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 7, level = 20, item = 4, entry = 10412}, -- Belt of the Fang
    {class = 7, level = 20, item = 5, entry = 10413}, -- Gloves of the Fang
    {class = 7, level = 20, item = 6, entry = 10411}, -- Footpads of the Fang
    {class = 7, level = 20, item = 7, entry = 12999}, -- Drakewing Bands

    {class = 7, level = 40, item = 1, entry = 4080},  -- Blackforge Cowl
    {class = 7, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 7, level = 40, item = 3, entry = 9396},  -- Legguards of the Vault
    {class = 7, level = 40, item = 4, entry = 20119}, -- Highlander's Mail Girdle
    {class = 7, level = 40, item = 5, entry = 8347},  -- Dragonscale Gauntlets
    {class = 7, level = 40, item = 6, entry = 20122}, -- Highlander's Mail Greaves
    {class = 7, level = 40, item = 7, entry = 19584}, -- Windtalker's Wristguards

    {class = 7, level = 60, item = 1, entry = 16842}, -- Earthfury Helmet
    {class = 7, level = 60, item = 2, entry = 21400}, -- Cloak of the Gathering Storm
    {class = 7, level = 60, item = 3, entry = 16843}, -- Earthfury Legguards
    {class = 7, level = 60, item = 4, entry = 16838}, -- Earthfury Belt
    {class = 7, level = 60, item = 5, entry = 16839}, -- Earthfury Gauntlets
    {class = 7, level = 60, item = 6, entry = 16837}, -- Earthfury Boots
    {class = 7, level = 60, item = 7, entry = 16840}, -- Earthfury Bracers

    {class = 7, level = 80, item =  1, entry = 43455}, -- Stormhide Crown
    {class = 7, level = 80, item =  2, entry = 43457}, -- Stormhide Shoulders
    {class = 7, level = 80, item =  3, entry = 43453}, -- Stormhide Hauberk
    {class = 7, level = 80, item =  4, entry = 43456}, -- Stormhide Legguards
    {class = 7, level = 80, item =  5, entry = 43450}, -- Stormhide Belt
    {class = 7, level = 80, item =  6, entry = 43454}, -- Stormhide Grips
    {class = 7, level = 80, item =  7, entry = 43451}, -- Stormhide Stompers
    {class = 7, level = 80, item =  8, entry = 43452}, -- Stormhide Wristguards
    {class = 7, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 7, level = 80, item = 10, entry = 36962}, -- Wyrmclaw Battleaxe
    {class = 7, level = 80, item = 11, entry = 42443}, -- Cudgel of Saronite Justice
    {class = 7, level = 80, item = 12, entry = 41117}, -- Saronite Protector

    -- Mage (8)
    {class = 8, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 8, level = 20, item = 2, entry = 12979}, -- Firebane Cloak
    {class = 8, level = 20, item = 3, entry = 12987}, -- Darkweave Breeches
    {class = 8, level = 20, item = 4, entry = 2911},  -- Keller's Girdle
    {class = 8, level = 20, item = 5, entry = 12977}, -- Magefist Gloves
    {class = 8, level = 20, item = 6, entry = 4320},  -- Spidersilk Boots
    {class = 8, level = 20, item = 7, entry = 14375}, -- Sanguine Cuffs

    {class = 8, level = 40, item = 1, entry = 7720},  -- Whitemane's Chapeau
    {class = 8, level = 40, item = 2, entry = 23178}, -- Mantle of Lady Falther'ess
    {class = 8, level = 40, item = 3, entry = 9407},  -- Stoneweaver Leggings
    {class = 8, level = 40, item = 4, entry = 20098}, -- Highlander's Cloth Girdle
    {class = 8, level = 40, item = 5, entry = 10019}, -- Dreamweave Gloves
    {class = 8, level = 40, item = 6, entry = 20095}, -- Highlander's Cloth Boots
    {class = 8, level = 40, item = 7, entry = 19597}, -- Dryad's Wrist Bindings

    {class = 8, level = 60, item = 1, entry = 16795}, -- Arcanist Crown
    {class = 8, level = 60, item = 2, entry = 21415}, -- Drape of Vaulted Secrets
    {class = 8, level = 60, item = 3, entry = 16796}, -- Arcanist Leggings
    {class = 8, level = 60, item = 4, entry = 16802}, -- Arcanist Belt
    {class = 8, level = 60, item = 5, entry = 16801}, -- Arcanist Gloves
    {class = 8, level = 60, item = 6, entry = 16800}, -- Arcanist Boots
    {class = 8, level = 60, item = 7, entry = 16799}, -- Arcanist Bindings

    {class = 8, level = 80, item =  1, entry = 43971}, -- Frostsavage Cowl
    {class = 8, level = 80, item =  2, entry = 43973}, -- Frostsavage Shoulders
    {class = 8, level = 80, item =  3, entry = 43972}, -- Frostsavage Shoulders
    {class = 8, level = 80, item =  4, entry = 43975}, -- Frostsavage Shoulders
    {class = 8, level = 80, item =  5, entry = 43969}, -- Frostsavage Belt
    {class = 8, level = 80, item =  6, entry = 41516}, -- Frostsavage Gloves
    {class = 8, level = 80, item =  7, entry = 43970}, -- Frostsavage Boots
    {class = 8, level = 80, item =  8, entry = 43974}, -- Frostsavage Bracers
    {class = 8, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 8, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 8, level = 80, item = 11, entry = 37626}, -- Wand of Sseratus
    {class = 8, level = 80, item = 12, entry = 37177}, -- Wand of the San'layn

    -- Warlock (9)
    {class = 9, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 9, level = 20, item = 2, entry = 12979}, -- Firebane Cloak
    {class = 9, level = 20, item = 3, entry = 23173}, -- Abomination Skin Leggings
    {class = 9, level = 20, item = 4, entry = 2911},  -- Keller's Girdle
    {class = 9, level = 20, item = 5, entry = 12977}, -- Magefist Gloves
    {class = 9, level = 20, item = 6, entry = 4320},  -- Spidersilk Boots
    {class = 9, level = 20, item = 7, entry = 14375}, -- Sanguine Cuffs

    {class = 9, level = 40, item = 1, entry = 9429},  -- Miner's Hat of the Deep
    {class = 9, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 9, level = 40, item = 3, entry = 2277},  -- Necromancer Leggings
    {class = 9, level = 40, item = 4, entry = 20098}, -- Highlander's Cloth Girdle
    {class = 9, level = 40, item = 5, entry = 10019}, -- Dreamweave Gloves
    {class = 9, level = 40, item = 6, entry = 20095}, -- Highlander's Cloth Boots
    {class = 9, level = 40, item = 7, entry = 19597}, -- Dryad's Wrist Bindings

    {class = 9, level = 60, item = 1, entry = 16808}, -- Felheart Horns
    {class = 9, level = 60, item = 2, entry = 21418}, -- Shroud of Unspoken Names
    {class = 9, level = 60, item = 3, entry = 16810}, -- Felheart Pants
    {class = 9, level = 60, item = 4, entry = 16806}, -- Felheart Belt
    {class = 9, level = 60, item = 5, entry = 16805}, -- Felheart Gloves
    {class = 9, level = 60, item = 6, entry = 16803}, -- Felheart Slippers
    {class = 9, level = 60, item = 7, entry = 16804}, -- Felheart Bracers

    {class = 9, level = 80, item =  1, entry = 43971}, -- Frostsavage Cowl
    {class = 9, level = 80, item =  2, entry = 43973}, -- Frostsavage Shoulders
    {class = 9, level = 80, item =  3, entry = 43972}, -- Frostsavage Shoulders
    {class = 9, level = 80, item =  4, entry = 43975}, -- Frostsavage Shoulders
    {class = 9, level = 80, item =  5, entry = 43969}, -- Frostsavage Belt
    {class = 9, level = 80, item =  6, entry = 41516}, -- Frostsavage Gloves
    {class = 9, level = 80, item =  7, entry = 43970}, -- Frostsavage Boots
    {class = 9, level = 80, item =  8, entry = 43974}, -- Frostsavage Bracers
    {class = 9, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 9, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 9, level = 80, item = 11, entry = 37626}, -- Wand of Sseratus
    {class = 9, level = 80, item = 12, entry = 37177}, -- Wand of the San'layn

    -- Druid (11)
    {class = 11, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 11, level = 20, item = 2, entry = 6629},  -- Sporid Cape
    {class = 11, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 11, level = 20, item = 4, entry = 10412}, -- Belt of the Fang
    {class = 11, level = 20, item = 5, entry = 10413}, -- Gloves of the Fang
    {class = 11, level = 20, item = 6, entry = 10411}, -- Footpads of the Fang
    {class = 11, level = 20, item = 7, entry = 12999}, -- Drakewing Bands

    {class = 11, level = 40, item = 1, entry = 8345},  -- Wolfshead Helm
    {class = 11, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 11, level = 40, item = 3, entry = 1718},  -- Basilisk Hide Pants
    {class = 11, level = 40, item = 4, entry = 20104}, -- Highlander's Lizardhide Girdle
    {class = 11, level = 40, item = 5, entry = 10765}, -- Bonefingers
    {class = 11, level = 40, item = 6, entry = 20101}, -- Highlander's Lizardhide Boots
    {class = 11, level = 40, item = 7, entry = 19590}, -- Forest Stalker's Bracers

    {class = 11, level = 60, item = 1, entry = 16834}, -- Cenarion Helm
    {class = 11, level = 60, item = 2, entry = 21409}, -- Cloak of Unending Life
    {class = 11, level = 60, item = 3, entry = 16835}, -- Cenarion Leggings
    {class = 11, level = 60, item = 4, entry = 16828}, -- Cenarion Belt
    {class = 11, level = 60, item = 5, entry = 16831}, -- Cenarion Gloves
    {class = 11, level = 60, item = 6, entry = 16829}, -- Cenarion Boots
    {class = 11, level = 60, item = 7, entry = 16830}, -- Cenarion Bracers

    {class = 11, level = 80, item =  1, entry = 43261}, -- Overcast Headguard
    {class = 11, level = 80, item =  2, entry = 43262}, -- Overcast Spaulders
    {class = 11, level = 80, item =  3, entry = 43263}, -- Overcast Chestguard
    {class = 11, level = 80, item =  4, entry = 43271}, -- Overcast Leggings
    {class = 11, level = 80, item =  5, entry = 43266}, -- Overcast Belt
    {class = 11, level = 80, item =  6, entry = 43265}, -- Overcast Handwraps
    {class = 11, level = 80, item =  7, entry = 43273}, -- Overcast Boots
    {class = 11, level = 80, item =  8, entry = 43264}, -- Overcast Bracers
    {class = 11, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 11, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 11, level = 80, item = 11, entry = 37190}, -- Enraged Feral Staff
    {class = 11, level = 80, item = 12, entry = 32387}, -- Idol of the Raven Goddesss

}

local function findGear(class, level, item)
    for i, v in ipairs(Gear) do
        if v.class==class and v.level==level and v.item==item then
            return v.entry
        end
    end
end

local function checkSpells(class, level, player)
    for i, v in ipairs(Spells) do
        if ((v.class==class or v.class==0) and v.level<=level) then
            if (v.type==0) then
                player:LearnSpell(v.entry)
            elseif (v.type==1) then
                player:CastSpell(player, v.entry, true)
            elseif (v.type==2 and player:HasItem(v.entry)==false) then
                player:AddItem(v.entry)
            elseif (v.type==3) then
                player:SetKnownTitle(v.entry)
            end
            print("["..MODULE_NAME.."]: "..player:GetName()..": Level: "..level.." Class: "..v.class.." Spell: "..v.entry)
        end
    end
end

local function checkRank(level, player)
    local guild = player:GetGuild()
    if(guild) then
        local rank = player:GetGuildRank()
        print("CheckRank entered for "..player:GetName()..", Rank: "..rank.." in Guild: "..guild:GetName())
        if level>=20 and level<40 and rank>3 then
            guild:SetMemberRank(player,3)
            print("Player "..player:GetName().." Rank Changed to: "..player:GetGuildRank())
        end
        if level>=40 and level<60 and rank>2 then
            guild:SetMemberRank(player,2)
            print("Player "..player:GetName().." Rank Changed to: "..player:GetGuildRank())
        end
    end
end

local function levelCheck(event, player, oldLevel)
    local class = player:GetClass()
    local level = player:GetLevel()
    local name = player:GetName()
    checkSpells(class, level, player)
    local emailSubject = "Congrats on "..level.."!"
    local emailBody = "Congratulations on reaching level "..level..", "..name.."! Here are some tokens of our appreciation!"
    local emailTo = player:GetGUIDLow()
    local emailStationery = 61
    local emailFrom = 0
    if (level==20 or level==40 or level==60) and class~=6 then
        print("["..MODULE_NAME.."]: "..name..": Level: "..level.." Class: "..class)
        player:SendNotification("Congrats on Level "..level.."!")
        player:PlayDirectSound(8572)
        local randomPet = math.random(1,#Pets)
        local randomTitle = math.random(1,#Titles)
        player:SetKnownTitle(Titles[randomTitle])
        SendMail(
            emailSubject,
            emailBody,
            emailTo,
            emailFrom,
            emailStationery,
            0, -- Delay
            Gold[level],
            0, -- COD
            Pets[randomPet],
            1,
            findGear(class,level,1),
            1,
            findGear(class,level,2),
            1,
            findGear(class,level,3),
            1,
            findGear(class,level,4),
            1,
            findGear(class,level,5),
            1,
            findGear(class,level,6),
            1,
            findGear(class,level,7),
            1
        )
    end
    if level==80 and class~=6 then
        print("["..MODULE_NAME.."]: "..player:GetName()..": Level: "..level.." Class: "..class)
        player:SendNotification("Congrats on Level "..level.."!")
        player:PlayDirectSound(8572)
        player:SetKnownTitle(142) -- the Undying
        SendMail(
            emailSubject,
            emailBody,
            emailTo,
            emailFrom,
            emailStationery,
            0, -- Delay
            Gold[level],
            0, -- COD
            56806, -- Mini Thor
            1,
            findGear(class,level,1),
            1,
            findGear(class,level,2),
            1,
            findGear(class,level,3),
            1,
            findGear(class,level,4),
            1,
            findGear(class,level,5),
            1,
            findGear(class,level,6),
            1,
            findGear(class,level,7),
            1,
            findGear(class,level,8),
            1,
            findGear(class,level,9),
            1,
            findGear(class,level,10),
            1,
            findGear(class,level,11),
            1,
            findGear(class,level,12),
            1
        )
    end
    if level==58 and class==6 then
        print("["..MODULE_NAME.."]: "..name..": Level: "..level.." Class: "..class)
        local randomPet = math.random(1,#Pets)
        player:SendNotification("Congrats on Level "..level.."!")
        player:PlayDirectSound(8572)
        player:SetKnownTitle(158) -- Death's Demise
        SendMail(
            emailSubject,
            emailBody,
            emailTo,
            emailFrom,
            emailStationery,
            10000, -- Delay
            Gold[20] + Gold[40] + Gold[60],
            0, -- COD
            35227, -- Goblin Weather Machine
            1,
            Pets[randomPet],
            1,
            41599,
            1,
            41599,
            1,
            41599,
            1,
            41599,
            1,
            23364,
            1000
        )
        player:CastSpell(player, 65292, true) -- Grand Master First Aid
        player:LearnSpell(54729) -- Winged Steed of the Ebon Blade
        player:LearnSpell(54197) -- Cold Weather Flying
        player:SetSkill(129, 375, 375, 375) -- First Aid
        player:SetSkill(762, 300, 300, 300) -- Riding
    end
    if level==80 and class==6 then
        print("["..MODULE_NAME.."]: "..name..": Level: "..level.." Class: "..class)
        player:SendNotification("Congrats on Level "..level.."!")
        player:PlayDirectSound(8572)
        player:SetKnownTitle(142) -- the Undying
        SendMail(
            emailSubject,
            emailBody,
            emailTo,
            emailFrom,
            emailStationery,
            0, -- Delay
            Gold[level],
            0, -- COD
            56806, -- Mini Thor
            1
        )
    end
    if level==80 then
        SendMail(
            "Bags!",
            "These are the best bags Azeroth has to offer. Enjoy!",
            emailTo,
            emailFrom,
            emailStationery,
            0, -- Delay
            0, -- Gold
            0, -- COD
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1,
            23162, -- Foror's Crate of Endless Resist Gear Storage
            1
        )
    end
checkRank(level, player)
end

RegisterPlayerEvent(13, levelCheck)
