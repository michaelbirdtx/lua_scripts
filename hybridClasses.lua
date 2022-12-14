local MODULE_NAME = "Eluna hybridClasses"
local MODULE_VERSION = '1.0.3'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

XP_MODIFIER = 4

-- Hybrid Class IDs
BATTLEMAGE = 801
HIGHWAYMAN = 401

local Spells = {
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
    for i, v in ipairs(Spells) do
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

local function getHybridClass(player)
    local Query = CharDBQuery("select class from eluna_hybrid_classes where guid = "..tostring(player:GetGUID()).." limit 1;")
    if Query then
        return Query:GetUInt32(0)
    else
        return 0
    end
end

local function onGainXP(event, player, amount, victim)
    -- local hybridClass = getHybridClass(player)
    -- print(player:GetName().." gained "..tostring(amount).." XP for Hybrid Class: "..hybridClass)
    if getHybridClass(player) ~= 0 then
        --print("XP adjusted to "..tostring(amount*XP_MODIFIER))
        return amount * XP_MODIFIER
    --else
        --return amount
    end
end

local function onLevelUp(event, player, oldLevel)
    --local hybridClass = getHybridClass(player)
    if getHybridClass(player) ~= 0 then
        checkSpells(hybridClass, player)
    end
end

local function onLogout(event, player)
    -- Check for Dual Wield, delete from table to avoid SQL error on logout
    if getHybridClass(player) == 801 then
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
