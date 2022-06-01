local MODULE_NAME = "Eluna levelUp"
local MODULE_VERSION = '1.2'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Gold = {
    [20] = 100000,
    [40] = 1000000,
    [60] = 10000000,
    [80] = 100000000,
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
    [9]  = 54857, -- Murkimus the Gladiator
    [10] = 49663, -- Wind Rider Cub
    [11] = 48527, -- Onyx Panther
    [12] = 54847, -- Lil' XT
    [13] = 34955, -- Scorched Stone
    [14] = 39286, -- Frosty
    [15] = 41133, -- Mr. Chilly
    [16] = 43517, -- Pengu
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
    [8]  =  43,   -- Duelist
    [9]  =  76,   -- Flame Keeper
    [10] =  11,   -- Commander
    [11] = 174,   -- Bane of the Fallen King
    [12] =  47,   -- Conqueror
    [13] = 127,   -- of the Horde
    [14] = 145,   -- the Insane
    [15] =   9,   -- Knight-Champion
    [16] =  77,   -- the Exalted
    [17] = 158,   -- Death's Demise
    [18] = 124,   -- the Hallowed
    [19] =  83,   -- Salty
    [20] = 154,   -- of the Undercity
}

local Gear = {
    -- Druid
    {class = 1024, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 1024, level = 20, item = 2, entry = 20428}, -- Caretaker's Cape
    {class = 1024, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 1024, level = 20, item = 4, entry = 10412}, -- Belt of the Fang
    {class = 1024, level = 20, item = 5, entry = 10413}, -- Gloves of the Fang
    {class = 1024, level = 20, item = 6, entry = 10411}, -- Footpads of the Fang
    {class = 1024, level = 20, item = 7, entry = 12999}, -- Drakewing Bands

    {class = 1024, level = 40, item = 1, entry = 8345},  -- Wolfshead Helm
    {class = 1024, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 1024, level = 40, item = 3, entry = 1718},  -- Basilisk Hide Pants
    {class = 1024, level = 40, item = 4, entry = 20104}, -- Highlander's Lizardhide Girdle
    {class = 1024, level = 40, item = 5, entry = 10765}, -- Bonefingers
    {class = 1024, level = 40, item = 6, entry = 20101}, -- Highlander's Lizardhide Boots
    {class = 1024, level = 40, item = 7, entry = 19590}, -- Forest Stalker's Bracers

    {class = 1024, level = 60, item = 1, entry = 16834}, -- Cenarion Helm
    {class = 1024, level = 60, item = 2, entry = 21409}, -- Cloak of Unending Life
    {class = 1024, level = 60, item = 3, entry = 16835}, -- Cenarion Leggings
    {class = 1024, level = 60, item = 4, entry = 16828}, -- Cenarion Belt
    {class = 1024, level = 60, item = 5, entry = 16831}, -- Cenarion Gloves
    {class = 1024, level = 60, item = 6, entry = 16829}, -- Cenarion Boots
    {class = 1024, level = 60, item = 7, entry = 16830}, -- Cenarion Bracers

    {class = 1024, level = 80, item =  1, entry = 43261}, -- Overcast Headguard
    {class = 1024, level = 80, item =  2, entry = 43262}, -- Overcast Spaulders
    {class = 1024, level = 80, item =  3, entry = 43263}, -- Overcast Chestguard
    {class = 1024, level = 80, item =  4, entry = 43271}, -- Overcast Leggings
    {class = 1024, level = 80, item =  5, entry = 43266}, -- Overcast Belt
    {class = 1024, level = 80, item =  6, entry = 43265}, -- Overcast Handwraps
    {class = 1024, level = 80, item =  7, entry = 43273}, -- Overcast Boots
    {class = 1024, level = 80, item =  8, entry = 43264}, -- Overcast Bracers
    {class = 1024, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 1024, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 1024, level = 80, item = 11, entry = 37190}, -- Enraged Feral Staff
    {class = 1024, level = 80, item = 12, entry = 32387}, -- Idol of the Raven Goddesss

    -- Hunter
    {class = 4, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 4, level = 20, item = 2, entry = 5193},  -- Cape of the Brotherhood
    {class = 4, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 4, level = 20, item = 4, entry = 6468},  -- Deviate Scale Belt
    {class = 4, level = 20, item = 5, entry = 7348},  -- Fletcher's Gloves
    {class = 4, level = 20, item = 6, entry = 1121},  -- Feet of the Lynx
    {class = 4, level = 20, item = 7, entry = 4794},  -- Wolf Bracers

    {class = 4, level = 40, item = 1, entry = 1624},  -- Skullsplitter Helm
    {class = 4, level = 40, item = 2, entry = 13121}, -- Wing of the Whelpling
    {class = 4, level = 40, item = 3, entry = 9396},  -- Legguards of the Vault
    {class = 4, level = 40, item = 4, entry = 20089}, -- Highlander's Chain Girdle
    {class = 4, level = 40, item = 5, entry = 8347},  -- Dragonscale Gauntlets
    {class = 4, level = 40, item = 6, entry = 20092}, -- Highlander's Chain Greaves
    {class = 4, level = 40, item = 7, entry = 19584}, -- Windtalker's Wristguards

    {class = 4, level = 60, item = 1, entry = 16846}, -- Giantstalker's Helmet
    {class = 4, level = 60, item = 2, entry = 21403}, -- Cloak of the Unseen Path
    {class = 4, level = 60, item = 3, entry = 16847}, -- Giantstalker's Leggings
    {class = 4, level = 60, item = 4, entry = 16851}, -- Giantstalker's Belt
    {class = 4, level = 60, item = 5, entry = 16852}, -- Giantstalker's Gloves
    {class = 4, level = 60, item = 6, entry = 16849}, -- Giantstalker's Boots
    {class = 4, level = 60, item = 7, entry = 16850}, -- Giantstalker's Bracers

    {class = 4, level = 80, item =  1, entry = 43447}, -- Swiftarrow Helm
    {class = 4, level = 80, item =  2, entry = 43449}, -- Swiftarrow Shoulderguards
    {class = 4, level = 80, item =  3, entry = 43445}, -- Swiftarrow Hauberk
    {class = 4, level = 80, item =  4, entry = 43448}, -- Swiftarrow Leggins
    {class = 4, level = 80, item =  5, entry = 43442}, -- Swiftarrow Belt
    {class = 4, level = 80, item =  6, entry = 43446}, -- Swiftarrow Gauntlets
    {class = 4, level = 80, item =  7, entry = 43443}, -- Swiftarrow Boots
    {class = 4, level = 80, item =  8, entry = 43444}, -- Swiftarrow Bracers
    {class = 4, level = 80, item =  9, entry = 38441}, -- Cloak of Harsh Winds
    {class = 4, level = 80, item = 10, entry = 37615}, -- Titanium Compound Bow
    {class = 4, level = 80, item = 11, entry = 36962}, -- Wyrmclaw Battleaxe
    {class = 4, level = 80, item = 12, entry = 41167}, -- Heartseeker Scope

    -- Mage
    {class = 128, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 128, level = 20, item = 2, entry = 12979}, -- Firebane Cloak
    {class = 128, level = 20, item = 3, entry = 12987}, -- Darkweave Breeches
    {class = 128, level = 20, item = 4, entry = 2911},  -- Keller's Girdle
    {class = 128, level = 20, item = 5, entry = 12977}, -- Magefist Gloves
    {class = 128, level = 20, item = 6, entry = 4320},  -- Spidersilk Boots
    {class = 128, level = 20, item = 7, entry = 14375}, -- Sanguine Cuffs

    {class = 128, level = 40, item = 1, entry = 7720},  -- Whitemane's Chapeau
    {class = 128, level = 40, item = 2, entry = 23178}, -- Mantle of Lady Falther'ess
    {class = 128, level = 40, item = 3, entry = 9407},  -- Stoneweaver Leggings
    {class = 128, level = 40, item = 4, entry = 20098}, -- Highlander's Cloth Girdle
    {class = 128, level = 40, item = 5, entry = 10019}, -- Dreamweave Gloves
    {class = 128, level = 40, item = 6, entry = 20095}, -- Highlander's Cloth Boots
    {class = 128, level = 40, item = 7, entry = 19597}, -- Dryad's Wrist Bindings

    {class = 128, level = 60, item = 1, entry = 16795}, -- Arcanist Crown
    {class = 128, level = 60, item = 2, entry = 21415}, -- Drape of Vaulted Secrets
    {class = 128, level = 60, item = 3, entry = 16796}, -- Arcanist Leggings
    {class = 128, level = 60, item = 4, entry = 16802}, -- Arcanist Belt
    {class = 128, level = 60, item = 5, entry = 16801}, -- Arcanist Gloves
    {class = 128, level = 60, item = 6, entry = 16800}, -- Arcanist Boots
    {class = 128, level = 60, item = 7, entry = 16799}, -- Arcanist Bindings

    {class = 128, level = 80, item =  1, entry = 43971}, -- Frostsavage Cowl
    {class = 128, level = 80, item =  2, entry = 43973}, -- Frostsavage Shoulders
    {class = 128, level = 80, item =  3, entry = 43972}, -- Frostsavage Shoulders
    {class = 128, level = 80, item =  4, entry = 43975}, -- Frostsavage Shoulders
    {class = 128, level = 80, item =  5, entry = 43969}, -- Frostsavage Belt
    {class = 128, level = 80, item =  6, entry = 41516}, -- Frostsavage Gloves
    {class = 128, level = 80, item =  7, entry = 43970}, -- Frostsavage Boots
    {class = 128, level = 80, item =  8, entry = 43974}, -- Frostsavage Bracers
    {class = 128, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 128, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 128, level = 80, item = 11, entry = 37626}, -- Wand of Sseratus
    {class = 128, level = 80, item = 12, entry = 37177}, -- Wand of the San'layn

    -- Paladin
    {class = 2, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 2, level = 20, item = 2, entry = 20428}, -- Caretaker's Cape
    {class = 2, level = 20, item = 3, entry = 6087},  -- Chausses of Westfall
    {class = 2, level = 20, item = 4, entry = 12978}, -- Stormbringer Belt
    {class = 2, level = 20, item = 5, entry = 12994}, -- Thorbia's Gauntlets
    {class = 2, level = 20, item = 6, entry = 12982}, -- Silver-linked Footguards
    {class = 2, level = 20, item = 7, entry = 2868},  -- Patterned Bronze Bracers

    {class = 2, level = 40, item = 1, entry = 10763}, -- Icemetal Barbute
    {class = 2, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 2, level = 40, item = 3, entry = 33258}, -- Protective Engineer's Leggings
    {class = 2, level = 40, item = 4, entry = 20107}, -- Highlander's Lamellar Girdle
    {class = 2, level = 40, item = 5, entry = 7938},  -- Truesilver Gauntlets
    {class = 2, level = 40, item = 6, entry = 20110}, -- Highlander's Lamellar Greaves
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
    {class = 2, level = 80, item = 10, entry = 41188}, -- Saronite Mindcrusher
    {class = 2, level = 80, item = 11, entry = 42443}, -- Cudgel of Saronite Justice
    {class = 2, level = 80, item = 12, entry = 41117}, -- Saronite Protector

    -- Priest
    {class = 16, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 16, level = 20, item = 2, entry = 20428}, -- Caretaker's Cape
    {class = 16, level = 20, item = 3, entry = 23173}, -- Abomination Skin Leggings
    {class = 16, level = 20, item = 4, entry = 2911},  -- Keller's Girdle
    {class = 16, level = 20, item = 5, entry = 12977}, -- Magefist Gloves
    {class = 16, level = 20, item = 6, entry = 4320},  -- Spidersilk Boots
    {class = 16, level = 20, item = 7, entry = 14375}, -- Sanguine Cuffs

    {class = 16, level = 40, item = 1, entry = 20969}, -- Ruby Crown of Restoration
    {class = 16, level = 40, item = 2, entry = 19532}, -- Caretaker's Cape
    {class = 16, level = 40, item = 3, entry = 7709},  -- Blighted Leggings
    {class = 16, level = 40, item = 4, entry = 20098}, -- Highlander's Cloth Girdle
    {class = 16, level = 40, item = 5, entry = 10019}, -- Dreamweave Gloves
    {class = 16, level = 40, item = 6, entry = 20095}, -- Highlander's Cloth Boots
    {class = 16, level = 40, item = 7, entry = 19597}, -- Dryad's Wrist Bindings

    {class = 16, level = 60, item = 1, entry = 16813}, -- Circlet of Prophecy
    {class = 16, level = 60, item = 2, entry = 21412}, -- Shroud of Infinite Wisdom
    {class = 16, level = 60, item = 3, entry = 16814}, -- Pants of Prophecy
    {class = 16, level = 60, item = 4, entry = 16817}, -- Girdle of Prophecy
    {class = 16, level = 60, item = 5, entry = 16812}, -- Gloves of Prophecy
    {class = 16, level = 60, item = 6, entry = 16811}, -- Boots of Prophecy
    {class = 16, level = 60, item = 7, entry = 16819}, -- Vambraces of Prophecy

    {class = 16, level = 80, item =  1, entry = 43971}, -- Frostsavage Cowl
    {class = 16, level = 80, item =  2, entry = 43973}, -- Frostsavage Shoulders
    {class = 16, level = 80, item =  3, entry = 43972}, -- Frostsavage Shoulders
    {class = 16, level = 80, item =  4, entry = 43975}, -- Frostsavage Shoulders
    {class = 16, level = 80, item =  5, entry = 43969}, -- Frostsavage Belt
    {class = 16, level = 80, item =  6, entry = 41516}, -- Frostsavage Gloves
    {class = 16, level = 80, item =  7, entry = 43970}, -- Frostsavage Boots
    {class = 16, level = 80, item =  8, entry = 43974}, -- Frostsavage Bracers
    {class = 16, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 16, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 16, level = 80, item = 11, entry = 37626}, -- Wand of Sseratus
    {class = 16, level = 80, item = 12, entry = 37177}, -- Wand of the San'layn

    -- Rogue
    {class = 8, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 8, level = 20, item = 2, entry = 5193},  -- Cape of the Brotherhood
    {class = 8, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 8, level = 20, item = 4, entry = 6468},  -- Deviate Scale Belt
    {class = 8, level = 20, item = 5, entry = 14572}, -- Bristlebark Gloves
    {class = 8, level = 20, item = 6, entry = 1121},  -- Feet of the Lynx
    {class = 8, level = 20, item = 7, entry = 4794},  -- Wolf Bracers

    {class = 8, level = 40, item = 1, entry = 8176},  -- Nightscape Headband
    {class = 8, level = 40, item = 2, entry = 13121}, -- Wing of the Whelpling
    {class = 8, level = 40, item = 3, entry = 9414},  -- Oilskin Leggings
    {class = 8, level = 40, item = 4, entry = 20116}, -- Highlander's Leather Girdle
    {class = 8, level = 40, item = 5, entry = 34417}, -- Marauder's Handwraps
    {class = 8, level = 40, item = 6, entry = 20113}, -- Highlander's Leather Boots
    {class = 8, level = 40, item = 7, entry = 19590}, -- Forest Stalker's Bracers

    {class = 8, level = 60, item = 1, entry = 16821}, -- Nightslayer Cover
    {class = 8, level = 60, item = 2, entry = 21406}, -- Cloak of Veiled Shadows
    {class = 8, level = 60, item = 3, entry = 16822}, -- Nightslayer Pants
    {class = 8, level = 60, item = 4, entry = 16827}, -- Nightslayer Belt
    {class = 8, level = 60, item = 5, entry = 16826}, -- Nightslayer Gloves
    {class = 8, level = 60, item = 6, entry = 16824}, -- Nightslayer Boots
    {class = 8, level = 60, item = 7, entry = 16825}, -- Nightslayer Bracelets

    {class = 8, level = 80, item =  1, entry = 43260}, -- Eviscerator's Facemask
    {class = 8, level = 80, item =  2, entry = 43433}, -- Eviscerator's Shoulderpads
    {class = 8, level = 80, item =  3, entry = 43434}, -- Eviscerator's Chestguard
    {class = 8, level = 80, item =  4, entry = 43438}, -- Eviscerator's Legguards
    {class = 8, level = 80, item =  5, entry = 43437}, -- Eviscerator's Waistguard
    {class = 8, level = 80, item =  6, entry = 43436}, -- Eviscerator's Gauntlets
    {class = 8, level = 80, item =  7, entry = 43439}, -- Eviscerator's Treads
    {class = 8, level = 80, item =  8, entry = 43435}, -- Eviscerator's Bindings
    {class = 8, level = 80, item =  9, entry = 38441}, -- Cloak of Harsh Winds
    {class = 8, level = 80, item = 10, entry = 41184}, -- Saronite Shiv
    {class = 8, level = 80, item = 11, entry = 41184}, -- Saronite Shiv
    {class = 8, level = 80, item = 12, entry = 41245}, -- Deadly Saronite Dirk

    -- Shaman
    {class = 64, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 64, level = 20, item = 2, entry = 20428}, -- Caretaker's Cape
    {class = 64, level = 20, item = 3, entry = 10410}, -- Leggings of the Fang
    {class = 64, level = 20, item = 4, entry = 10412}, -- Belt of the Fang
    {class = 64, level = 20, item = 5, entry = 10413}, -- Gloves of the Fang
    {class = 64, level = 20, item = 6, entry = 10411}, -- Footpads of the Fang
    {class = 64, level = 20, item = 7, entry = 12999}, -- Drakewing Bands

    {class = 64, level = 40, item = 1, entry = 4080},  -- Blackforge Cowl
    {class = 64, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 64, level = 40, item = 3, entry = 9396},  -- Legguards of the Vault
    {class = 64, level = 40, item = 4, entry = 20119}, -- Highlander's Mail Girdle
    {class = 64, level = 40, item = 5, entry = 8347},  -- Dragonscale Gauntlets
    {class = 64, level = 40, item = 6, entry = 20122}, -- Highlander's Mail Greaves
    {class = 64, level = 40, item = 7, entry = 19584}, -- Windtalker's Wristguards

    {class = 64, level = 60, item = 1, entry = 16842}, -- Earthfury Helmet
    {class = 64, level = 60, item = 2, entry = 21400}, -- Cloak of the Gathering Storm
    {class = 64, level = 60, item = 3, entry = 16843}, -- Earthfury Legguards
    {class = 64, level = 60, item = 4, entry = 16838}, -- Earthfury Belt
    {class = 64, level = 60, item = 5, entry = 16839}, -- Earthfury Gauntlets
    {class = 64, level = 60, item = 6, entry = 16837}, -- Earthfury Boots
    {class = 64, level = 60, item = 7, entry = 16840}, -- Earthfury Bracers

    {class = 64, level = 80, item =  1, entry = 43455}, -- Stormhide Crown
    {class = 64, level = 80, item =  2, entry = 43457}, -- Stormhide Shoulders
    {class = 64, level = 80, item =  3, entry = 43453}, -- Stormhide Hauberk
    {class = 64, level = 80, item =  4, entry = 43456}, -- Stormhide Legguards
    {class = 64, level = 80, item =  5, entry = 43450}, -- Stormhide Belt
    {class = 64, level = 80, item =  6, entry = 43454}, -- Stormhide Grips
    {class = 64, level = 80, item =  7, entry = 43451}, -- Stormhide Stompers
    {class = 64, level = 80, item =  8, entry = 43452}, -- Stormhide Wristguards
    {class = 64, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 64, level = 80, item = 10, entry = 36962}, -- Wyrmclaw Battleaxe
    {class = 64, level = 80, item = 11, entry = 42443}, -- Cudgel of Saronite Justice
    {class = 64, level = 80, item = 12, entry = 41117}, -- Saronite Protector

    -- Warlock
    {class = 256, level = 20, item = 1, entry = 30419}, -- Brilliant Necklace
    {class = 256, level = 20, item = 2, entry = 12979}, -- Firebane Cloak
    {class = 256, level = 20, item = 3, entry = 23173}, -- Abomination Skin Leggings
    {class = 256, level = 20, item = 4, entry = 2911},  -- Keller's Girdle
    {class = 256, level = 20, item = 5, entry = 12977}, -- Magefist Gloves
    {class = 256, level = 20, item = 6, entry = 4320},  -- Spidersilk Boots
    {class = 256, level = 20, item = 7, entry = 14375}, -- Sanguine Cuffs

    {class = 256, level = 40, item = 1, entry = 9429},  -- Miner's Hat of the Deep
    {class = 256, level = 40, item = 2, entry = 10776}, -- Silky Spider Cape
    {class = 256, level = 40, item = 3, entry = 2277},  -- Necromancer Leggings
    {class = 256, level = 40, item = 4, entry = 20098}, -- Highlander's Cloth Girdle
    {class = 256, level = 40, item = 5, entry = 10019}, -- Dreamweave Gloves
    {class = 256, level = 40, item = 6, entry = 20095}, -- Highlander's Cloth Boots
    {class = 256, level = 40, item = 7, entry = 19597}, -- Dryad's Wrist Bindings

    {class = 256, level = 60, item = 1, entry = 16808}, -- Felheart Horns
    {class = 256, level = 60, item = 2, entry = 21418}, -- Shroud of Unspoken Names
    {class = 256, level = 60, item = 3, entry = 16810}, -- Felheart Pants
    {class = 256, level = 60, item = 4, entry = 16806}, -- Felheart Belt
    {class = 256, level = 60, item = 5, entry = 16805}, -- Felheart Gloves
    {class = 256, level = 60, item = 6, entry = 16803}, -- Felheart Slippers
    {class = 256, level = 60, item = 7, entry = 16804}, -- Felheart Bracers

    {class = 256, level = 80, item =  1, entry = 43971}, -- Frostsavage Cowl
    {class = 256, level = 80, item =  2, entry = 43973}, -- Frostsavage Shoulders
    {class = 256, level = 80, item =  3, entry = 43972}, -- Frostsavage Shoulders
    {class = 256, level = 80, item =  4, entry = 43975}, -- Frostsavage Shoulders
    {class = 256, level = 80, item =  5, entry = 43969}, -- Frostsavage Belt
    {class = 256, level = 80, item =  6, entry = 41516}, -- Frostsavage Gloves
    {class = 256, level = 80, item =  7, entry = 43970}, -- Frostsavage Boots
    {class = 256, level = 80, item =  8, entry = 43974}, -- Frostsavage Bracers
    {class = 256, level = 80, item =  9, entry = 45810}, -- Cloak of Crimson Snow
    {class = 256, level = 80, item = 10, entry = 37384}, -- Staff of Wayward Principles
    {class = 256, level = 80, item = 11, entry = 37626}, -- Wand of Sseratus
    {class = 256, level = 80, item = 12, entry = 37177}, -- Wand of the San'layn

    -- Warrior
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
    {class = 1, level = 40, item = 4, entry = 20125}, -- Highlander's Plate Girdle
    {class = 1, level = 40, item = 5, entry = 7938},  -- Truesilver Gauntlets
    {class = 1, level = 40, item = 6, entry = 20128}, -- Highlander's Plate Greaves
    {class = 1, level = 40, item = 7, entry = 19581}, -- Berserker Bracers

    {class = 1, level = 60, item = 1, entry = 16866}, -- Helm of Might
    {class = 1, level = 60, item = 2, entry = 21394}, -- Drape of Unyielding Strength
    {class = 1, level = 60, item = 3, entry = 16867}, -- Legplates of Might
    {class = 1, level = 60, item = 4, entry = 16864}, -- Belt of Might
    {class = 1, level = 60, item = 5, entry = 16863}, -- Gauntlets of Might
    {class = 1, level = 60, item = 6, entry = 16862}, -- Sabatons of Might
    {class = 1, level = 60, item = 7, entry = 16861}, -- Bracers of Might

    {class = 1, level = 80, item =  1, entry = 41350}, -- Overcast Headguard
    {class = 1, level = 80, item =  2, entry = 41351}, -- Overcast Spaulders
    {class = 1, level = 80, item =  3, entry = 41353}, -- Overcast Chestguard
    {class = 1, level = 80, item =  4, entry = 41347}, -- Overcast Leggings
    {class = 1, level = 80, item =  5, entry = 41352}, -- Overcast Belt
    {class = 1, level = 80, item =  6, entry = 41349}, -- Overcast Handwraps
    {class = 1, level = 80, item =  7, entry = 41348}, -- Overcast Boots
    {class = 1, level = 80, item =  8, entry = 41354}, -- Overcast Bracers
    {class = 1, level = 80, item =  9, entry = 45811}, -- Cloak of Crimson Snow
    {class = 1, level = 80, item = 10, entry = 41186}, -- Staff of Wayward Principles
    {class = 1, level = 80, item = 11, entry = 41186}, -- Enraged Feral Staff
    {class = 1, level = 80, item = 12, entry = 41113}, -- Idol of the Raven Goddess
}

function findGear(class, level, item)
    for i, v in ipairs(Gear) do
        if v.class==class and v.level==level and v.item==item then
            return v.entry
        end
    end
end

function levelCheck(event, player, oldLevel)
    class = player:GetClassMask()
    level = player:GetLevel()
    emailSubject = "Congrats on "..level.."!"
    emailBody = "Congratulations on reaching level "..level..", "..player:GetName().."! Here are some tokens of our appreciation!"
    emailTo = player:GetGUIDLow()
    emailStationery = 61
    emailFrom = 0
    if (level==20 or level==40 or level==60) and class ~= 32 then
        print("["..MODULE_NAME.."]: Level: "..level.." Class: "..class)
        player:SendNotification("Congrats on Level "..level.."!")
        player:PlayDirectSound(8572)
        randomPet = math.random(1,#Pets)
        randomTitle = math.random(1,#Titles)
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
    if level==80 and class ~= 32 then
        print("["..MODULE_NAME.."]: Level: "..level.." Class: "..class)
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
end

RegisterPlayerEvent(13, levelCheck)
