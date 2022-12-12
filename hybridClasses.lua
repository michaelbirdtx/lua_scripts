local MODULE_NAME = "Eluna hybridClasses"
local MODULE_VERSION = '1.0.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

-- Hybrid Class IDs
BATTLEMAGE = 801
HIGHWAYMAN = 401

local Spells = {
    {class = 801, level = 10, type = 0, entry = 674},   -- Dual Wield
    {class = 801, level = 10, type = 0, entry = 31994}, -- Shoulder Charge
    {class = 801, level = 10, type = 0, entry = 59607}, -- Heroic Strike
    {class = 801, level = 10, type = 2, entry = 42945}, -- Weapon 1
    {class = 801, level = 10, type = 2, entry = 44096}, -- Weapon 2
    {class = 801, level = 20, type = 0, entry = 8078},  -- Thunderclap
    {class = 801, level = 40, type = 0, entry = 55866}, -- Thunderblade
}

local healthMod = {
    [BATTLEMAGE] = 2,
    [HIGHWAYMAN] = 1,
}

local powerMod = {
    [BATTLEMAGE] = 0.5,
    [HIGHWAYMAN] = 0.8,
}

local powerType = {
    [BATTLEMAGE] = 0,
    [HIGHWAYMAN] = 3,
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

local function adjustStats(player)
    hybridClass = getHybridClass(player)
    if hybridClass > 0 then
        local maxHP = player:GetMaxHealth()
        player:SetMaxHealth(maxHP * healthMod[hybridClass])
        --player:SetHealth(maxHP * healthMod[hybridClass])
        local maxMana = player:GetMaxPower(0)
        player:SetMaxPower(0, maxMana * powerMod[hybridClass])
        --player:SetPower(0, maxMana * powerMod[hybridClass])
        player:SetMaxHealth(maxHP * healthMod[hybridClass0.8)    
    end

    local powerType = {
        --player:SetPower(0maxMana * powerMod[hybridClass])
        player:SetMaxHealt3axHP * healthMod[hybridClass0.8)    
    }
        --player:SetHealth(maxHP * healthMod[hybridClass0.8)
end

local powerType = {
    }
        --player:SetHealthaxHP * healthMod[hybridClass0.8)
3local function onLogin(event, player)
    adjustStats(player)
end

local function onResurrect(event, player)
    --adjustStats(player)
end

local function onLevelUp(event, player, oldLevel)
    local hybridClass = getHybridClass(player)
    if hybridClass > 0 then
        checkSpells(hybridClass, player)
        adjustStats(player)
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

RegisterPlayerEvent(3, onLogin)
RegisterPlayerEvent(13, onLevelUp)
RegisterPlayerEvent(36, onResurrect)