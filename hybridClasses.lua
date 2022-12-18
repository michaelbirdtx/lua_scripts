local MODULE_NAME = "Eluna hybridClasses"
local MODULE_VERSION = '1.1.1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

-- Configuration
local MIN_ADOPTION_LEVEL = 1 -- The level at which characters can become a Hybrid
local START_LEVEL = 10 -- The level to which characters will be reset when they become Hybrids
local XP_MODIFIER = 5 -- Multiplier for Hybrid bonus XP

-- Hybrid Class IDs
local BATTLEMAGE = 801
local HIGHWAYMAN = 401

local gear = {
    -- Battlemage (801)
    {class = 801, entry = 42985, pos = EQUIPMENT_SLOT_SHOULDERS}, -- Tattered Dreadmist Mantle
    {class = 801, entry = 48691, pos = EQUIPMENT_SLOT_CHEST},     -- Tattered Dreadmist Robe
    {class = 801, entry =  4309, pos = EQUIPMENT_SLOT_LEGS},      -- Handstitched Linen Britches
    {class = 801, entry =  2283, pos = EQUIPMENT_SLOT_WAIST},     -- Rat Cloth Belt
    {class = 801, entry =  4768, pos = EQUIPMENT_SLOT_HANDS},     -- Adept's Gloves
    {class = 801, entry =  3307, pos = EQUIPMENT_SLOT_FEET},      -- Barbaric Cloth Boots
    {class = 801, entry =  4308, pos = EQUIPMENT_SLOT_WRISTS},    -- Green Linen Bracers
    {class = 801, entry =  2308, pos = EQUIPMENT_SLOT_BACK},      -- Fine Leather Cloak
    {class = 801, entry = 42945, pos = EQUIPMENT_SLOT_MAINHAND},  -- Venerable Dal'Rend's Sacred Charge
    {class = 801, entry = 44096, pos = EQUIPMENT_SLOT_OFFHAND},   -- Battleworn Thrash Blade
    {class = 801, entry =  5069, pos = EQUIPMENT_SLOT_RANGED},    -- Stillpine Stinger
    {class = 801, entry = 50255, pos = EQUIPMENT_SLOT_FINGER1},   -- Dread Pirate Ring
    {class = 801, entry = 42991, pos = EQUIPMENT_SLOT_TRINKET1},  -- Swift Hand of Justice
    {class = 801, entry = 44098, pos = EQUIPMENT_SLOT_TRINKET2},  -- Inherited Insignia of the Alliance
    {class = 801, entry = 44097, pos = EQUIPMENT_SLOT_TRINKET2},  -- Inherited Insignia of the Horde

    -- Highwayman (401)
    {class = 401, entry = 42952, pos = EQUIPMENT_SLOT_SHOULDERS}, -- Stained Shadowcraft Shoulders
    {class = 401, entry = 48689, pos = EQUIPMENT_SLOT_CHEST},     -- Stained Shadowcraft Tunic
    {class = 401, entry =  4242, pos = EQUIPMENT_SLOT_LEGS},      -- Embossed Leather Pants
    {class = 401, entry =  6558, pos = EQUIPMENT_SLOT_WAIST},     -- Bard's Belt
    {class = 401, entry =  4239, pos = EQUIPMENT_SLOT_HANDS},     -- Embossed Leather Gloves
    {class = 401, entry =  2309, pos = EQUIPMENT_SLOT_FEET},      -- Embossed Leather Boots
    {class = 401, entry =  7281, pos = EQUIPMENT_SLOT_WRISTS},    -- Light Leather Bracers
    {class = 401, entry =  2310, pos = EQUIPMENT_SLOT_BACK},      -- Embossed Leather Cloak
    {class = 401, entry = 42944, pos = EQUIPMENT_SLOT_MAINHAND},  -- Balanced Heartseeker
    {class = 401, entry = 42944, pos = EQUIPMENT_SLOT_OFFHAND},   -- Balanced Heartseeker
    {class = 401, entry = 44093, pos = EQUIPMENT_SLOT_RANGED},    -- Upgraded Dwarven Hand Cannon
    {class = 401, entry = 50255, pos = EQUIPMENT_SLOT_FINGER1},   -- Dread Pirate Ring
    {class = 401, entry = 42991, pos = EQUIPMENT_SLOT_TRINKET1},  -- Swift Hand of Justice
    {class = 401, entry = 44098, pos = EQUIPMENT_SLOT_TRINKET2},  -- Inherited Insignia of the Alliance
    {class = 401, entry = 44097, pos = EQUIPMENT_SLOT_TRINKET2},  -- Inherited Insignia of the Horde
}

local spells = {
    -- Highwayman
    {class = 401, level = 10, type = 0, entry = 19434, name = "Aimed Shot (1)"},
    {class = 401, level = 10, type = 0, entry = 75,    name = "Auto Shot"},
    {class = 401, level = 10, type = 0, entry = 19431, name = "Lethal Shots"},
    {class = 401, level = 10, type = 0, entry = 19490, name = "Mortal Shots"},
    {class = 401, level = 10, type = 0, entry = 55531, name = "Mechano-Hog"},
    {class = 401, level = 10, type = 3, entry = 45,    name = "Challenger"},
    {class = 401, level = 20, type = 0, entry = 20900, name = "Aimed Shot (2)"},
    {class = 401, level = 20, type = 0, entry = 19506, name = "Trueshot Aura"},
    {class = 401, level = 30, type = 0, entry = 20901, name = "Aimed Shot (3)"},
    {class = 401, level = 30, type = 0, entry = 61508, name = "Disengage"},
    {class = 401, level = 30, type = 0, entry = 79187, name = "Multi-Shadow Shot"},
    {class = 401, level = 30, type = 0, entry = 19883, name = "Track Humanoids"},
    {class = 401, level = 40, type = 0, entry = 20902, name = "Aimed Shot (4)"},
    {class = 401, level = 40, type = 0, entry = 53301, name = "Explosive Shot (1)"},
    {class = 401, level = 40, type = 3, entry = 44,    name = "Rival"},
    {class = 401, level = 50, type = 0, entry = 20903, name = "Aimed Shot (5)"},
    {class = 401, level = 50, type = 0, entry = 60051, name = "Explosive Shot (2)"},
    {class = 401, level = 60, type = 0, entry = 20904, name = "Aimed Shot (6)"},
    {class = 401, level = 60, type = 0, entry = 60052, name = "Explosive Shot (3)"},
    {class = 401, level = 60, type = 3, entry = 163,   name = "Vanquisher"},
    {class = 401, level = 70, type = 0, entry = 27065, name = "Aimed Shot (7)"},
    {class = 401, level = 70, type = 0, entry = 60053, name = "Explosive Shot (4)"},
    {class = 401, level = 80, type = 3, entry = 27,    name = "Warlord"},
    -- Battlemage
    {class = 801, level = 10, type = 0, entry = 50573, name = "Arcane Cleave"},
    {class = 801, level = 10, type = 0, entry = 73313, name = "Crimson Deathcharger"},
    {class = 801, level = 10, type = 0, entry = 674,   name = "Dual Wield"},
    {class = 801, level = 10, type = 0, entry = 7302,  name = "Ice Armor (1)"},
    {class = 801, level = 10, type = 0, entry = 1243,  name = "Power Word: Fortitude (1)"},
    {class = 801, level = 10, type = 0, entry = 31994, name = "Shoulder Charge"},
    {class = 801, level = 10, type = 0, entry = 12764, name = "Toughness (Armor)"},
    {class = 801, level = 10, type = 0, entry = 16309, name = "Toughness (Stamina)"},
    {class = 801, level = 10, type = 3, entry = 45,    name = "Challenger"},
    {class = 801, level = 20, type = 0, entry = 7320,  name = "Ice Armor (2)"},
    {class = 801, level = 20, type = 0, entry = 1244,  name = "Power Word: Fortitude (2)"},
    {class = 801, level = 20, type = 0, entry = 8078,  name = "Thunderclap"},
    {class = 801, level = 30, type = 0, entry = 16170, name = "Bloodlust"},
    {class = 801, level = 30, type = 0, entry = 10219, name = "Ice Armor (3)"},
    {class = 801, level = 30, type = 0, entry = 1245,  name = "Power Word: Fortitude (3)"},
    {class = 801, level = 40, type = 0, entry = 10220, name = "Ice Armor 4"},
    {class = 801, level = 40, type = 0, entry = 2791,  name = "Power Word: Fortitude (4)"},
    {class = 801, level = 40, type = 0, entry = 55866, name = "Thunderblade"},
    {class = 801, level = 40, type = 3, entry = 44,    name = "Rival"},
    {class = 801, level = 50, type = 0, entry = 27124, name = "Ice Armor (5)"},
    {class = 801, level = 50, type = 0, entry = 10937, name = "Power Word: Fortitude (5)"},
    {class = 801, level = 60, type = 0, entry = 43008, name = "Ice Armor (6)"},
    {class = 801, level = 60, type = 0, entry = 10938, name = "Power Word: Fortitude (6)"},
    {class = 801, level = 60, type = 3, entry = 163,   name = "Vanquisher"},
    {class = 801, level = 70, type = 0, entry = 25389, name = "Power Word: Fortitude (7)"},
    {class = 801, level = 80, type = 0, entry = 48161, name = "Power Word: Fortitude (8)"},
    {class = 801, level = 80, type = 3, entry = 27,    name = "Warlord"},
}

local function checkSpells(player, hybridClass)
    local level = player:GetLevel()
    for i, v in ipairs(spells) do
        if v.class==hybridClass and v.level<=level then
            if v.type==0 then
                if not player:HasSpell(v.entry) then
                    player:LearnSpell(v.entry)
                    player:SendNotification("You have learned a new Hybrid Class ability: "..v.name)
                end
            elseif v.type==1 then
                player:CastSpell(player, v.entry, true)
                player:SendNotification("You have learned a new Hybrid Class ability: "..v.name)
            elseif v.type==2 and player:HasItem(v.entry)==false then
                player:AddItem(v.entry)
                player:SendNotification("You have received a new Hybrid Class item: "..v.name)
            elseif v.type==3 then
                if not player:HasTitle(v.entry) then
                    player:SetKnownTitle(v.entry)
                    player:SendNotification("You have received a new Hybrid Class title: "..v.name)
                end
            end
        end
    end
end

local function dbInsertHybridClass(player, hybridClass)
    if GetHybridClass(player) == 0 then
        CharDBExecute("INSERT INTO eluna_hybrid_classes(guid,class) VALUES("..tostring(player:GetGUID())..","..hybridClass..");")
        return true
    else
        return false
    end
end

local function setEquipment(player, hybridClass)
    for i = 0, 17 do
        local item = player:GetItemByPos(255, i)
        if item then
            player:AddItem(item:GetEntry())
            player:RemoveItem(item, 1)
        end
    end
    for i, v in ipairs(gear) do
        if v.class == hybridClass then
            player:EquipItem(v.entry, v.pos)
        end
    end
    if hybridClass == HIGHWAYMAN then
        player:AddItem(2519, 1000)
        player:AddItem(6947, 20)
        player:AddItem(2892, 20)
    end
end

function GetHybridClass(player)
    local Query = CharDBQuery("SELECT class FROM eluna_hybrid_classes WHERE guid = "..tostring(player:GetGUID()).." LIMIT 1;")
    if Query then
        return Query:GetUInt32(0)
    else
        return 0
    end
end

function GrantHybridClass(player, hybridClass)
    if GetHybridClass(player) ~= 0 then
        player:SendBroadcastMessage("You are already a Hybrid.")
        return false
    end
    if player:GetLevel() < MIN_ADOPTION_LEVEL then
        player:SendBroadcastMessage("You are too inexperienced to become a Hybrid.")
        return false
    end
    if hybridClass == BATTLEMAGE then
        if player:GetClass() ~= 8 then
            player:SendBroadcastMessage("Only a Mage can become a Battlemage.")
            return false
        end
    end
    if hybridClass == HIGHWAYMAN then
        if player:GetClass() ~= 4 then
            player:SendBroadcastMessage("Only a Rogue can become a Highwayman.")
            return false
        end
    end
    local result = dbInsertHybridClass(player, hybridClass)
    if result then
        if player:GetLevel() > START_LEVEL then
            UnlearnClassSpells(player, START_LEVEL+1, 80)
        end
        if player:GetLevel() ~= START_LEVEL then
            player:SetLevel(START_LEVEL)
        end
        checkSpells(player, hybridClass)
        setEquipment(player, hybridClass)
        print("["..MODULE_NAME.."]: "..player:GetName().." has been granted Hybrid status.")
        player:PlayDirectSound(8960, player)
    end
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find("#grant battlemage") == 1) and player:GetGMRank() > 0 then
        if GrantHybridClass(player, BATTLEMAGE) then
            player:SendBroadcastMessage("You are now a Battlemage!")
        end
        return false
    end
    if (msg:find("#grant highwayman") == 1) and player:GetGMRank() > 0 then
        if GrantHybridClass(player, HIGHWAYMAN) then
            player:SendBroadcastMessage("You are now a Highwayman!")
        end
        return false
    end
    if (msg:find("#set equipment") == 1) and player:GetGMRank() > 0 then
        setEquipment(player, GetHybridClass(player))
        return false
    end
end

local function onGainXP(event, player, amount, victim)
    if GetHybridClass(player) ~= 0 then
        return amount * XP_MODIFIER
    end
end

local function onLevelUp(event, player, oldLevel)
    local hybridClass = GetHybridClass(player)
    if hybridClass ~= 0 then
        checkSpells(player, hybridClass)
    end
end

local function onLogout(event, player)
    -- Check for Dual Wield, delete from table to avoid SQL error on logout
    if GetHybridClass(player) == 801 then
        CharDBExecute("DELETE FROM character_skills WHERE guid = "..tostring(player:GetGUID()).." and skill = 118")
    end
end

CharDBQuery([[
CREATE TABLE IF NOT EXISTS `eluna_hybrid_classes` (
`guid` INT(10) UNSIGNED NOT NULL COMMENT 'Character GUID',
`class` INT(10) UNSIGNED NOT NULL COMMENT 'Hybrid Class',
PRIMARY KEY (`guid`)
)
COMMENT='version 4.0'
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;
]])

RegisterPlayerEvent(4, onLogout)
RegisterPlayerEvent(12, onGainXP)
RegisterPlayerEvent(13, onLevelUp)
RegisterPlayerEvent(18, onChatMessage)
