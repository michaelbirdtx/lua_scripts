local MODULE_NAME = "Eluna newToon"
local MODULE_VERSION = '1.4'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Skills = {

    -- Warrior (1)
    {class = 1, entry =   264}, -- Bows
    {class = 1, entry =  5011}, -- Crossbow
    {class = 1, entry = 15590}, -- Fists
    {class = 1, entry =   266}, -- Guns
    {class = 1, entry =   200}, -- Polearms
    {class = 1, entry =   199}, -- 2H Mace
    {class = 1, entry =   227}, -- Staves

    -- Paladin (2)
    {class = 2, entry = 196}, -- Axes
    {class = 2, entry = 200}, -- Polearms
    {class = 2, entry = 197}, -- 2H Axe
    {class = 2, entry = 199}, -- 2H Mace

    -- Hunter (3)
    {class = 3, entry = 15590}, -- Fists
    {class = 3, entry =   264}, -- Bows
    {class = 3, entry =   266}, -- Guns
    {class = 3, entry =   200}, -- Polearms
    {class = 3, entry =   227}, -- Staves
    {class = 3, entry =   202}, -- 2H Swords

    -- Rogue (4)
    {class = 4, entry = 264},   -- Bows
    {class = 4, entry = 5011},  -- Crossbow
    {class = 4, entry = 15590}, -- Fists
    {class = 4, entry = 266},   -- Guns
    {class = 4, entry = 196},   -- Axes
    {class = 4, entry = 198},   -- Maces
    {class = 4, entry = 201},   -- Swords

    -- Priest (5)
    {class = 5, entry = 1180}, -- Daggers

    -- Shaman (7)
    {class = 7, entry = 15590}, -- Fists
    {class = 7, entry =   196}, -- Axes
    {class = 7, entry =   197}, -- 2H Axe
    {class = 7, entry =   199}, -- 2H Mace

    -- Mage (8)
    {class = 8, entry = 201}, -- Swords

    -- Warlock (9)
    {class = 9, entry =   201}, -- Swords
    {class = 9, entry =  5784}, -- Felsteed
    {class = 9, entry = 23161}, -- Dreadsteed

    -- Druid (11)
    {class = 11, entry =  1180}, -- Daggers
    {class = 11, entry = 15590}, -- Fists
    {class = 11, entry =   198}, -- Guns
    {class = 11, entry =   200}, -- Axes
    {class = 11, entry =   227}, -- Maces
    {class = 11, entry =   199}, -- Swords

}

local Mounts = {
    {race =  1, entry = 63232}, -- (Human) Stormwind Steed
    {race =  2, entry = 63640}, -- (Orc) Orgrimmar Wolf
    {race =  3, entry = 63636}, -- (Dwarf) Ironforge Ram
    {race =  4, entry = 63637}, -- (Night Elf) Darnassian Nightsaber
    {race =  5, entry = 63643}, -- (Undead) Forsaken Warhorse
    {race =  6, entry = 63641}, -- (Tauren) Thunder Bluff Kodo
    {race =  7, entry = 63638}, -- (Gnome) Gnomeregan Mechanostrider
    {race =  8, entry = 63635}, -- (Troll) Darkspear Raptor
    {race = 10, entry = 63642}, -- (Blood Elf) Silvermoon Hawkstrider
    {race = 11, entry = 63639}, -- (Draenei) Exodar Elekk
}

local Gear = {

    -- Warrior (1)
    {class = 1, item =  1, team = -1, entry = 42949}, -- Polished Spaulders of Valor
    {class = 1, item =  2, team = -1, entry = 48685}, -- Polished Breastplate of Valor
    {class = 1, item =  3, team =  0, entry =  2381}, -- Tarnished Chain Leggings
    {class = 1, item =  4, team =  0, entry =  2380}, -- Tarnished Chain Belt
    {class = 1, item =  5, team =  0, entry =  2385}, -- Tarnished Chain Gloves
    {class = 1, item =  6, team =  0, entry =  2383}, -- Tarnished Chain Boots
    {class = 1, item =  7, team =  0, entry =  2384}, -- Tarnished Chain Bracers
    {class = 1, item =  3, team =  1, entry = 20918}, -- Unadorned Chain Leggings
    {class = 1, item =  4, team =  1, entry = 20914}, -- Unadorned Chain Belt
    {class = 1, item =  5, team =  1, entry = 20917}, -- Unadorned Chain Gloves
    {class = 1, item =  6, team =  1, entry = 20915}, -- Unadorned Chain Boots
    {class = 1, item =  7, team =  1, entry = 20916}, -- Unadorned Chain Bracers
    {class = 1, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 1, item =  9, team = -1, entry = 44092}, -- Reforged Truesilver Champion
    {class = 1, item = 10, team = -1, entry = 42945}, -- Venerable Dal'Rend's Sacred Charge
    {class = 1, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 1, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 1, item = 13, team =  0, entry = 44098}, -- Inherited Insignia of the Alliance
    {class = 1, item = 13, team =  1, entry = 44097}, -- Inherited Insignia of the Horde

    -- Paladin (2)
    {class = 2, item =  1, team = -1, entry = 42949}, -- Polished Spaulders of Valor
    {class = 2, item =  2, team = -1, entry = 48685}, -- Polished Breastplate of Valor
    {class = 2, item =  3, team =  0, entry =  2381}, -- Tarnished Chain Leggings
    {class = 2, item =  4, team =  0, entry =  2380}, -- Tarnished Chain Belt
    {class = 2, item =  5, team =  0, entry =  2385}, -- Tarnished Chain Gloves
    {class = 2, item =  6, team =  0, entry =  2383}, -- Tarnished Chain Boots
    {class = 2, item =  7, team =  0, entry =  2384}, -- Tarnished Chain Bracers
    {class = 2, item =  3, team =  1, entry = 20918}, -- Unadorned Chain Leggings
    {class = 2, item =  4, team =  1, entry = 20914}, -- Unadorned Chain Belt
    {class = 2, item =  5, team =  1, entry = 20917}, -- Unadorned Chain Gloves
    {class = 2, item =  6, team =  1, entry = 20915}, -- Unadorned Chain Boots
    {class = 2, item =  7, team =  1, entry = 20916}, -- Unadorned Chain Bracers
    {class = 2, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 2, item =  9, team = -1, entry = 48718}, -- Repurposed Lava Dredger
    {class = 2, item = 10, team = -1, entry = 42948}, -- Devout Aurastone Hammer
    {class = 2, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 2, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 2, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

    -- Hunter (3)
    {class = 3, item =  1, team = -1, entry = 42950}, -- Champion Herod's Shoulder
    {class = 3, item =  2, team = -1, entry = 48677}, -- Champion's Deathdealer Breastplate
    {class = 3, item =  3, team =  0, entry =  2126}, -- Cracked Leather Pants
    {class = 3, item =  4, team =  0, entry =  2122}, -- Cracked Leather Belt
    {class = 3, item =  5, team =  0, entry =  2125}, -- Cracked Leather Gloves
    {class = 3, item =  6, team =  0, entry =  2123}, -- Cracked Leather Boots
    {class = 3, item =  7, team =  0, entry =  2124}, -- Cracked Leather Bracers
    {class = 3, item =  3, team =  1, entry = 20924}, -- Sun Cured Pants
    {class = 3, item =  4, team =  1, entry = 20920}, -- Sun Cured Belt
    {class = 3, item =  5, team =  1, entry = 20923}, -- Sun Cured Gloves
    {class = 3, item =  6, team =  1, entry = 20921}, -- Sun Cured Boots
    {class = 3, item =  7, team =  1, entry = 20922}, -- Sun Cured Bracers
    {class = 3, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 3, item =  9, team = -1, entry = 42943}, -- Bloodied Arcanite Reaper
    {class = 3, item = 10, team = -1, entry = 42946}, -- Charmed Ancient Bone Bow
    {class = 3, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 3, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 3, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

    -- Rogue (4)
    {class = 4, item =  1, team = -1, entry = 42952}, -- Stained Shadowcraft Shoulders
    {class = 4, item =  2, team = -1, entry = 48689}, -- Stained Shadowcraft Tunic
    {class = 4, item =  3, team =  0, entry =  2126}, -- Cracked Leather Pants
    {class = 4, item =  4, team =  0, entry =  2122}, -- Cracked Leather Belt
    {class = 4, item =  5, team =  0, entry =  2125}, -- Cracked Leather Gloves
    {class = 4, item =  6, team =  0, entry =  2123}, -- Cracked Leather Boots
    {class = 4, item =  7, team =  0, entry =  2124}, -- Cracked Leather Bracers
    {class = 4, item =  3, team =  1, entry = 20924}, -- Sun Cured Pants
    {class = 4, item =  4, team =  1, entry = 20920}, -- Sun Cured Belt
    {class = 4, item =  5, team =  1, entry = 20923}, -- Sun Cured Gloves
    {class = 4, item =  6, team =  1, entry = 20921}, -- Sun Cured Boots
    {class = 4, item =  7, team =  1, entry = 20922}, -- Sun Cured Bracers
    {class = 4, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 4, item =  9, team = -1, entry = 42944}, -- Balanced Heartseeker
    {class = 4, item = 10, team = -1, entry = 42944}, -- Balanced Heartseeker
    {class = 4, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 4, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 4, item = 13, team =  0, entry = 44098}, -- Inherited Insignia of the Alliance
    {class = 4, item = 13, team =  1, entry = 44097}, -- Inherited Insignia of the Horde

    -- Priest (5)
    {class = 5, item =  1, team = -1, entry = 42985}, -- Tattered Dreadmist Mantle
    {class = 5, item =  2, team = -1, entry = 48691}, -- Tattered Dreadmist Robe
    {class = 5, item =  3, team =  0, entry =  2120}, -- Thin Cloth Pants
    {class = 5, item =  4, team =  0, entry =  3599}, -- Thin Cloth Belt
    {class = 5, item =  5, team =  0, entry =  2119}, -- Thin Cloth Gloves
    {class = 5, item =  6, team =  0, entry =  2117}, -- Thin Cloth Shoes
    {class = 5, item =  7, team =  0, entry =  3600}, -- Thin Cloth Bracers
    {class = 5, item =  3, team =  1, entry = 20986}, -- Light Cloth Pants
    {class = 5, item =  4, team =  1, entry = 20989}, -- Light Cloth Belt
    {class = 5, item =  5, team =  1, entry = 20987}, -- Light Cloth Gloves
    {class = 5, item =  6, team =  1, entry = 20985}, -- Light Cloth Shoes
    {class = 5, item =  7, team =  1, entry = 20988}, -- Light Cloth Bracers
    {class = 5, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 5, item =  9, team = -1, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 5, item = 10, team = -1, entry = 27403}, -- Stillpine Stinger
    {class = 5, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 5, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 5, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

    -- Shaman (7)
    {class = 7, item =  1, team = -1, entry = 42951}, -- Mystical Pauldrons of the Elements
    {class = 7, item =  2, team = -1, entry = 48683}, -- Mystical Vest of the Elements
    {class = 7, item =  3, team =  0, entry =  2126}, -- Cracked Leather Pants
    {class = 7, item =  4, team =  0, entry =  2122}, -- Cracked Leather Belt
    {class = 7, item =  5, team =  0, entry =  2125}, -- Cracked Leather Gloves
    {class = 7, item =  6, team =  0, entry =  2123}, -- Cracked Leather Boots
    {class = 7, item =  7, team =  0, entry =  2124}, -- Cracked Leather Bracers
    {class = 7, item =  3, team =  1, entry = 20924}, -- Sun Cured Pants
    {class = 7, item =  4, team =  1, entry = 20920}, -- Sun Cured Belt
    {class = 7, item =  5, team =  1, entry = 20923}, -- Sun Cured Gloves
    {class = 7, item =  6, team =  1, entry = 20921}, -- Sun Cured Boots
    {class = 7, item =  7, team =  1, entry = 20922}, -- Sun Cured Bracers
    {class = 7, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 7, item =  9, team = -1, entry = 48718}, -- Repurposed Lava Dredger
    {class = 7, item = 10, team = -1, entry = 42948}, -- Devout Aurastone Hammer
    {class = 7, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 7, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 7, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

    -- Mage (8)
    {class = 8, item =  1, team = -1, entry = 42985}, -- Tattered Dreadmist Mantle
    {class = 8, item =  2, team = -1, entry = 48691}, -- Tattered Dreadmist Robe
    {class = 8, item =  3, team =  0, entry =  2120}, -- Thin Cloth Pants
    {class = 8, item =  4, team =  0, entry =  3599}, -- Thin Cloth Belt
    {class = 8, item =  5, team =  0, entry =  2119}, -- Thin Cloth Gloves
    {class = 8, item =  6, team =  0, entry =  2117}, -- Thin Cloth Shoes
    {class = 8, item =  7, team =  0, entry =  3600}, -- Thin Cloth Bracers
    {class = 8, item =  3, team =  1, entry = 20986}, -- Light Cloth Pants
    {class = 8, item =  4, team =  1, entry = 20989}, -- Light Cloth Belt
    {class = 8, item =  5, team =  1, entry = 20987}, -- Light Cloth Gloves
    {class = 8, item =  6, team =  1, entry = 20985}, -- Light Cloth Shoes
    {class = 8, item =  7, team =  1, entry = 20988}, -- Light Cloth Bracers
    {class = 8, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 8, item =  9, team = -1, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 8, item = 10, team = -1, entry = 27403}, -- Stillpine Stinger
    {class = 8, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 8, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 8, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

    -- Warlock (9)
    {class = 9, item =  1, team = -1, entry = 42985}, -- Tattered Dreadmist Mantle
    {class = 9, item =  2, team = -1, entry = 48691}, -- Tattered Dreadmist Robe
    {class = 9, item =  3, team =  0, entry =  2120}, -- Thin Cloth Pants
    {class = 9, item =  4, team =  0, entry =  3599}, -- Thin Cloth Belt
    {class = 9, item =  5, team =  0, entry =  2119}, -- Thin Cloth Gloves
    {class = 9, item =  6, team =  0, entry =  2117}, -- Thin Cloth Shoes
    {class = 9, item =  7, team =  0, entry =  3600}, -- Thin Cloth Bracers
    {class = 9, item =  3, team =  1, entry = 20986}, -- Light Cloth Pants
    {class = 9, item =  4, team =  1, entry = 20989}, -- Light Cloth Belt
    {class = 9, item =  5, team =  1, entry = 20987}, -- Light Cloth Gloves
    {class = 9, item =  6, team =  1, entry = 20985}, -- Light Cloth Shoes
    {class = 9, item =  7, team =  1, entry = 20988}, -- Light Cloth Bracers
    {class = 9, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 9, item =  9, team = -1, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 9, item = 10, team = -1, entry = 27403}, -- Stillpine Stinger
    {class = 9, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 9, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 9, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

    -- Druid (11)
    {class = 11, item =  1, team = -1, entry = 42984}, -- Preened Ironfeather Shoulders
    {class = 11, item =  2, team = -1, entry = 48687}, -- Preened Ironfeather Breastplate
    {class = 11, item =  3, team =  0, entry =  2126}, -- Cracked Leather Pants
    {class = 11, item =  4, team =  0, entry =  2122}, -- Cracked Leather Belt
    {class = 11, item =  5, team =  0, entry =  2125}, -- Cracked Leather Gloves
    {class = 11, item =  6, team =  0, entry =  2123}, -- Cracked Leather Boots
    {class = 11, item =  7, team =  0, entry =  2124}, -- Cracked Leather Bracers
    {class = 11, item =  3, team =  1, entry = 20924}, -- Sun Cured Pants
    {class = 11, item =  4, team =  1, entry = 20920}, -- Sun Cured Belt
    {class = 11, item =  5, team =  1, entry = 20923}, -- Sun Cured Gloves
    {class = 11, item =  6, team =  1, entry = 20921}, -- Sun Cured Boots
    {class = 11, item =  7, team =  1, entry = 20922}, -- Sun Cured Bracers
    {class = 11, item =  8, team = -1, entry = 14385}, -- Durability Cloak
    {class = 11, item =  9, team = -1, entry = 48716}, -- Venerable Mass of McGowan
    {class = 11, item = 10, team = -1, entry = 42947}, -- Dignified Headmaster's Charge
    {class = 11, item = 11, team = -1, entry = 50255}, -- Dread Pirate Ring
    {class = 11, item = 12, team = -1, entry = 42991}, -- Swift Hand of Justice
    {class = 11, item = 13, team = -1, entry = 42992}, -- Discerning Eye of the Beast

}

local function findGear(class, item, team)
    for i, v in ipairs(Gear) do
        if v.class==class and v.item==item and (v.team == team or v.team == -1) then
            return v.entry
        end
    end
end

local function grantSkills(player, class)
    print("["..MODULE_NAME.."]: Grant Skills to "..player:GetName())
    for i, v in ipairs(Skills) do
        if v.class==class or v.class==0 then
            player:LearnSpell(v.entry)
            print("["..MODULE_NAME.."]: "..player:GetName().." learned "..v.entry)
        end
    end
end

local function grantMounts(player, race)
    print("["..MODULE_NAME.."]: Grant Mounts to "..player:GetName())

    -- Riding Skills
    player:CastSpell(player, 33389, true)
    player:CastSpell(player, 33392, true)
    player:CastSpell(player, 34092, true)
    player:CastSpell(player, 34093, true)
    player:LearnSpell(54197)

    -- Mounts
    for i, v in ipairs(Mounts) do
        if v.race==race or v.race==0 then
            player:LearnSpell(v.entry)
            print("["..MODULE_NAME.."]: "..player:GetName().." learned "..v.entry.." (mount)")
        end
    end

end

local function firstLogin(event, player)
    class = player:GetClass()
    level = player:GetLevel()
    race = player:GetRace()
    team = player:GetTeam()
    if level > 1 then
        return
    end
    print("["..MODULE_NAME.."]: "..player:GetName().." created by "..player:GetAccountName().." on team "..team)
    player:SetKnownTitle(1)
    grantSkills(player, class)
    grantMounts(player, race)
    emailTo = player:GetGUIDLow()
    emailStationery = 61
    emailFrom = 0
    bagEntry = 41599
    foodEntry = 23364
    SendMail(
        "Bags, Money, and The Stuff!",
        "Because who doesn't need more of all that Stuff?",
        emailTo,
        emailFrom,
        emailStationery,
        0, -- Delay
        100000, -- 10 Gold
        0, -- COD
        bagEntry,
        1,
        bagEntry,
        1,
        bagEntry,
        1,
        bagEntry,
        1,
        32618,
        1,
        foodEntry,
        1000
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
        findGear(class,1, team),
        1,
        findGear(class,2, team),
        1,
        findGear(class,3, team),
        1,
        findGear(class,4, team),
        1,
        findGear(class,5, team),
        1,
        findGear(class,6, team),
        1,
        findGear(class,7, team),
        1,
        findGear(class,8, team),
        1,
        findGear(class,9, team),
        1,
        findGear(class,10, team),
        1,
        findGear(class,11, team),
        1,
        findGear(class,12, team),
        1,
        findGear(class,13, team),
        1
    )
    player:CastSpell(player, 54710, true)
end

RegisterPlayerEvent(30, firstLogin)
