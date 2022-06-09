local MODULE_NAME = "Eluna newToon"
local MODULE_VERSION = '1.1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Skills = {

    -- Warrior (1)
    {class = 1, entry = 264},   -- Bows
    {class = 1, entry = 5011},  -- Crossbow
    {class = 1, entry = 15590}, -- Fists
    {class = 1, entry = 266},   -- Guns
    {class = 1, entry = 200},   -- Polearms
    {class = 1, entry = 199},   -- 2H Mace
    {class = 1, entry = 227},   -- Staves

    -- Paladin (2)
    {class = 2, entry = 196}, -- Axes
    {class = 2, entry = 200}, -- Polearms
    {class = 2, entry = 197}, -- 2H Axe
    {class = 2, entry = 199}, -- 2H Mace

    -- Hunter (4)
    {class = 4, entry = 15590}, -- Fists
    {class = 4, entry = 264},   -- Bows
    {class = 4, entry = 266},   -- Guns
    {class = 4, entry = 200},   -- Polearms
    {class = 4, entry = 227},   -- Staves
    {class = 4, entry = 202},   -- 2H Swords

    -- Rogue (8)
    {class = 8, entry = 264},   -- Bows
    {class = 8, entry = 5011},  -- Crossbow
    {class = 8, entry = 15590}, -- Fists
    {class = 8, entry = 266},   -- Guns
    {class = 8, entry = 196},   -- Axes
    {class = 8, entry = 198},   -- Maces
    {class = 8, entry = 201},   -- Swords

    -- Priest (16)
    {class = 16, entry = 1180}, -- Daggers

    -- Shaman (64)
    {class = 64, entry = 15590}, -- Fists
    {class = 64, entry = 196},   -- Axes
    {class = 64, entry = 197},   -- 2H Axe
    {class = 64, entry = 199},   -- 2H Mace

    -- Mage (128)
    {class = 128, entry = 201}, -- Swords

    -- Warlock (256)
    {class = 256, entry = 201}, -- Swords

    -- Druid (1024)
    {class = 1024, entry = 1180},  -- Daggers
    {class = 1024, entry = 15590}, -- Fists
    {class = 1024, entry = 198},   -- Guns
    {class = 1024, entry = 200},   -- Axes
    {class = 1024, entry = 227},   -- Maces
    {class = 1024, entry = 199},   -- Swords

}

local Gear = {

    -- Warrior (1)
    {class = 1, item =  1, entry = 42949}, -- Polished Spaulders of Valor
    {class = 1, item =  2, entry = 48685}, -- Polished Breastplate of Valor
    {class = 1, item =  3, entry =  2381}, -- Tarnished Chain Leggings
    {class = 1, item =  4, entry =  2380}, -- Tarnished Chain Belt
    {class = 1, item =  5, entry =  2385}, -- Tarnished Chain Gloves
    {class = 1, item =  6, entry =  2383}, -- Tarnished Chain Boots
    {class = 1, item =  7, entry =  2384}, -- Tarnished Chain Bracers
    {class = 1, item =  8, entry = 14385}, -- Durability Cloak
    {class = 1, item =  9, entry = 44092}, -- Reforged Truesilver Champion
    {class = 1, item = 10, entry = 42945}, -- Venerable Dal'Rend's Sacred Charge
    {class = 1, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 1, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 1, item = 13, entry = 44098}, -- Inherited Insignia of the Alliance

    -- Paladin (2)
    {class = 2, item =  1, entry = 42949}, -- Polished Spaulders of Valor
    {class = 2, item =  2, entry = 48685}, -- Polished Breastplate of Valor
    {class = 2, item =  3, entry =  2381}, -- Tarnished Chain Leggings
    {class = 2, item =  4, entry =  2380}, -- Tarnished Chain Belt
    {class = 2, item =  5, entry =  2385}, -- Tarnished Chain Gloves
    {class = 2, item =  6, entry =  2383}, -- Tarnished Chain Boots
    {class = 2, item =  7, entry =  2384}, -- Tarnished Chain Bracers
    {class = 2, item =  8, entry = 14385}, -- Durability Cloak
    {class = 2, item =  9, entry = 48718}, -- Repurposed Lava Dredger
    {class = 2, item = 10, entry = 42948}, -- Devout Aurastone Hammer
    {class = 2, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 2, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 2, item = 13, entry = 42992}, -- Discerning Eye of the Beast

    -- Hunter (4)
    {class = 4, item =  1, entry = 42950}, -- Champion Herod's Shoulder
    {class = 4, item =  2, entry = 48677}, -- Champion's Deathdealer Breastplate
    {class = 4, item =  3, entry =  2126}, -- Cracked Leather Pants
    {class = 4, item =  4, entry =  2122}, -- Cracked Leather Belt
    {class = 4, item =  5, entry =  2125}, -- Cracked Leather Gloves
    {class = 4, item =  6, entry =  2123}, -- Cracked Leather Boots
    {class = 4, item =  7, entry =  2124}, -- Cracked Leather Bracers
    {class = 4, item =  8, entry = 14385}, -- Durability Cloak
    {class = 4, item =  9, entry = 42943}, -- Bloodied Arcanite Reaper
    {class = 4, item = 10, entry = 42946}, -- Charmed Ancient Bone Bow
    {class = 4, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 4, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 4, item = 13, entry = 42992}, -- Discerning Eye of the Beast

    -- Rogue (8)
    {class = 8, item =  1, entry = 42952}, -- Stained Shadowcraft Shoulders
    {class = 8, item =  2, entry = 48689}, -- Stained Shadowcraft Tunic
    {class = 8, item =  3, entry =  2126}, -- Cracked Leather Pants
    {class = 8, item =  4, entry =  2122}, -- Cracked Leather Belt
    {class = 8, item =  5, entry =  2125}, -- Cracked Leather Gloves
    {class = 8, item =  6, entry =  2123}, -- Cracked Leather Boots
    {class = 8, item =  7, entry =  2124}, -- Cracked Leather Bracers
    {class = 8, item =  8, entry = 14385}, -- Durability Cloak
    {class = 8, item =  9, entry = 42944}, -- Balanced Heartseeker
    {class = 8, item = 10, entry = 42944}, -- Balanced Heartseeker
    {class = 8, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 8, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 8, item = 13, entry = 44098}, -- Inherited Insignia of the Alliance

    -- Priest (16)
    {class = 16, item =  1, entry = 42985}, -- Tattered Dreadmist Mantle
    {class = 16, item =  2, entry = 48691}, -- Tattered Dreadmist Robe
    {class = 16, item =  3, entry =  2120}, -- Thin Cloth Pants
    {class = 16, item =  4, entry =  3599}, -- Thin Cloth Belt
    {class = 16, item =  5, entry =  2119}, -- Thin Cloth Gloves
    {class = 16, item =  6, entry =  2117}, -- Thin Cloth Shoes
    {class = 16, item =  7, entry =  3600}, -- Thin Cloth Bracers
    {class = 16, item =  8, entry = 14385}, -- Durability Cloak
    {class = 16, item =  9, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 16, item = 10, entry = 27403}, -- Stillpine Stinger
    {class = 16, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 16, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 16, item = 13, entry = 42992}, -- Discerning Eye of the Beast

    -- Shaman (64)
    {class = 64, item =  1, entry = 42951}, -- Mystical Pauldrons of the Elements
    {class = 64, item =  2, entry = 48683}, -- Mystical Vest of the Elements
    {class = 64, item =  3, entry =  2126}, -- Cracked Leather Pants
    {class = 64, item =  4, entry =  2122}, -- Cracked Leather Belt
    {class = 64, item =  5, entry =  2125}, -- Cracked Leather Gloves
    {class = 64, item =  6, entry =  2123}, -- Cracked Leather Boots
    {class = 64, item =  7, entry =  2124}, -- Cracked Leather Bracers
    {class = 64, item =  8, entry = 14385}, -- Durability Cloak
    {class = 64, item =  9, entry = 48718}, -- Repurposed Lava Dredger
    {class = 64, item = 10, entry = 42948}, -- Devout Aurastone Hammer
    {class = 64, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 64, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 64, item = 13, entry = 42992}, -- Discerning Eye of the Beast

    -- Mage (128)
    {class = 128, item =  1, entry = 42985}, -- Tattered Dreadmist Mantle
    {class = 128, item =  2, entry = 48691}, -- Tattered Dreadmist Robe
    {class = 128, item =  3, entry =  2120}, -- Thin Cloth Pants
    {class = 128, item =  4, entry =  3599}, -- Thin Cloth Belt
    {class = 128, item =  5, entry =  2119}, -- Thin Cloth Gloves
    {class = 128, item =  6, entry =  2117}, -- Thin Cloth Shoes
    {class = 128, item =  7, entry =  3600}, -- Thin Cloth Bracers
    {class = 128, item =  8, entry = 14385}, -- Durability Cloak
    {class = 128, item =  9, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 128, item = 10, entry = 27403}, -- Stillpine Stinger
    {class = 128, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 128, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 128, item = 13, entry = 42992}, -- Discerning Eye of the Beast

    -- Warlock (256)
    {class = 256, item =  1, entry = 42985}, -- Tattered Dreadmist Mantle
    {class = 256, item =  2, entry = 48691}, -- Tattered Dreadmist Robe
    {class = 256, item =  3, entry =  2120}, -- Thin Cloth Pants
    {class = 256, item =  4, entry =  3599}, -- Thin Cloth Belt
    {class = 256, item =  5, entry =  2119}, -- Thin Cloth Gloves
    {class = 256, item =  6, entry =  2117}, -- Thin Cloth Shoes
    {class = 256, item =  7, entry =  3600}, -- Thin Cloth Bracers
    {class = 256, item =  8, entry = 14385}, -- Durability Cloak
    {class = 256, item =  9, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 256, item = 10, entry = 27403}, -- Stillpine Stinger
    {class = 256, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 256, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 256, item = 13, entry = 42992}, -- Discerning Eye of the Beast

    -- Druid (1024)
    {class = 1024, item =  1, entry = 42984}, -- Preened Ironfeather Shoulders
    {class = 1024, item =  2, entry = 48687}, -- Preened Ironfeather Breastplate
    {class = 1024, item =  3, entry =  2126}, -- Cracked Leather Pants
    {class = 1024, item =  4, entry =  2122}, -- Cracked Leather Belt
    {class = 1024, item =  5, entry =  2125}, -- Cracked Leather Gloves
    {class = 1024, item =  6, entry =  2123}, -- Cracked Leather Boots
    {class = 1024, item =  7, entry =  2124}, -- Cracked Leather Bracers
    {class = 1024, item =  8, entry = 14385}, -- Durability Cloak
    {class = 1024, item =  9, entry = 48716}, -- Venerable Mass of McGowan
    {class = 1024, item = 10, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 1024, item = 11, entry = 50255}, -- Dread Pirate Ring
    {class = 1024, item = 12, entry = 42991}, -- Swift Hand of Justice
    {class = 1024, item = 13, entry = 42992}, -- Discerning Eye of the Beast

}

function findGear(class, item)
    for i, v in ipairs(Gear) do
        if v.class==class and v.item==item then
            return v.entry
        end
    end
end

function grantSkills(player, class)
    print("["..MODULE_NAME.."]: Grant Skills to "..player:GetName())
    for i, v in ipairs(Skills) do
        if v.class==class or v.class==0 then
            player:LearnSpell(v.entry)
            print("["..MODULE_NAME.."]: "..player:GetName().." learned "..v.entry)
        end
    end
end

function firstLogin(event, player)
    class = player:GetClassMask()
    level = player:GetLevel()
    if level > 1 then
        return
    end
    print("["..MODULE_NAME.."]: "..player:GetName().." created by "..player:GetAccountName())
    grantSkills(player, class)
    emailTo = player:GetGUIDLow()
    emailStationery = 61
    emailFrom = 0
    bagEntry = 41599
    SendMail(
        "Bags and money!",
        "Because who doesn't need more of those?",
        emailTo,
        emailFrom,
        emailStationery,
        0, -- Delay
        10000, -- 1 Gold
        0, -- COD
        bagEntry,
        1,
        bagEntry,
        1,
        bagEntry,
        1,
        bagEntry,
        1
    )
    SendMail(
        "Welcome!",
        "Congratulations on your new character! Here are some tokens of our appreciation!",
        emailTo,
        emailFrom,
        emailStationery,
        0, -- Delay
        0,
        0, -- COD
        findGear(class,1),
        1,
        findGear(class,2),
        1,
        findGear(class,3),
        1,
        findGear(class,4),
        1,
        findGear(class,5),
        1,
        findGear(class,6),
        1,
        findGear(class,7),
        1,
        findGear(class,8),
        1,
        findGear(class,9),
        1,
        findGear(class,10),
        1,
        findGear(class,11),
        1,
        findGear(class,12),
        1,
        findGear(class,13),
        1
    )
    player:CastSpell(player, 54710, true)
end

RegisterPlayerEvent(30, firstLogin)
