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

local spells = {
    {class = 401, level = 10, type = 0, entry = 75},    -- Auto Shot
    {class = 401, level = 10, type = 0, entry = 19434}, -- Aimed Shot 1
    {class = 401, level = 10, type = 2, entry = 44093}, -- Gun
    {class = 401, level = 20, type = 0, entry = 20900}, -- Aimed Shot 2
    {class = 401, level = 20, type = 0, entry = 2643},  -- Multishot
    {class = 401, level = 30, type = 0, entry = 20901}, -- Aimed Shot 3
    {class = 401, level = 30, type = 0, entry = 781},   -- Disengage
    {class = 401, level = 40, type = 0, entry = 20902}, -- Aimed Shot 4
    {class = 401, level = 40, type = 0, entry = 3045},  -- Rapid Fire
    {class = 801, level = 10, type = 0, entry = 674},   -- Dual Wield
    {class = 801, level = 10, type = 0, entry = 31994}, -- Shoulder Charge
    {class = 801, level = 10, type = 0, entry = 59607}, -- Heroic Strike
    {class = 801, level = 10, type = 2, entry = 42945}, -- Weapon 1
    {class = 801, level = 10, type = 2, entry = 44096}, -- Weapon 2
    {class = 801, level = 20, type = 0, entry = 56909}, -- Cleave (weak)
    {class = 801, level = 30, type = 0, entry = 8078},  -- Thunderclap
    {class = 801, level = 40, type = 0, entry = 55866}, -- Thunderblade
}

local function checkSpells(class, player)
    level = player:GetLevel()
    for i, v in ipairs(spells) do
        if v.class==class and v.level<=level then
            if v.type==0 then
                if not player:HasSpell(v.entry) then
                    player:LearnSpell(v.entry)
                    player:SendNotification("You have learned a new Hybrid Class ability!")
                end
            elseif v.type==1 then
                player:CastSpell(player, v.entry, true)
                player:SendNotification("You have learned a new Hybrid Class ability!")
            elseif v.type==2 and player:HasItem(v.entry)==false then
                player:AddItem(v.entry)
                player:SendNotification("You have received a new Hybrid Class item!")
            elseif v.type==3 then
                player:SetKnownTitle(v.entry)
                player:SendNotification("You have received a new Hybrid Class title!")
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
        UnlearnSkills(player, START_LEVEL, player:GetLevel())
        player:SetLevel(2)
        player:SetLevel(START_LEVEL)
        checkSpells(hybridClass, player)
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
end

local function onGainXP(event, player, amount, victim)
    --print(player:GetName().." gained "..tostring(amount).." XP for Hybrid Class: "..tostring(hybridClass))
    if GetHybridClass(player) ~= 0 then
        --print("XP adjusted to "..tostring(amount*XP_MODIFIER))
        return amount * XP_MODIFIER
    end
end

local function onLevelUp(event, player, oldLevel)
    if GetHybridClass(player) ~= 0 then
        checkSpells(hybridClass, player)
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
