local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire') == 1) then
        --local pet = PerformIngameSpawn(1, sender, unit:GetMapId(), unit:GetInstanceId(), unit:GetX(), unit:GetY(), unit:GetZ(), unit:GetO(), false, 5000)
        hLevel = player:GetLevel()+math.random(1,3)
        hHealth = (player:GetMaxHealth()/player:GetLevel()) * hLevel
        hireling = PerformIngameSpawn(1, 669001, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 2400000)
        print("Player Level: "..player:GetLevel())
        print("Player Max Health: "..player:GetMaxHealth())
        print("Player Min Damage: "..player:GetFloatValue(70))
        print("Player Max Damage: "..player:GetFloatValue(71))
        print("Hireling Starting Level: "..hireling:GetLevel())
        hireling:SetFaction(35)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        hireling:SetLevel(hLevel)
        hireling:SetMaxHealth(hHealth)
        hireling:SetHealth(hHealth)
        hireling:SetFloatValue(70, player:GetFloatValue(70)*1.5)
        hireling:SetFloatValue(71, player:GetFloatValue(71)*1.5)
        hireling:SetDefaultMovementType(14)
        hireling:MoveFollow(player, 3, 60)
        hireling:SetEquipmentSlots(11786, 0, 0)
        print("Hireling Matched Level: "..hireling:GetLevel())
        print("Hireling Max Health: "..hireling:GetMaxHealth())
        print("Hireling Min Damage: "..hireling:GetFloatValue(70))
        print("Hireling Max Damage: "..hireling:GetFloatValue(71))
    end
end

local function onEnterCombat(event, creature, target)
    creature:CastSpell(target, 355, true)
end

local function onLeaveCombat(event, creature)
    creature:SetHealth(creature:GetMaxHealth())
    creature:SetSheath(0)
end

RegisterPlayerEvent(18, onChatMessage)
RegisterCreatureEvent(669001, 1, onEnterCombat)
RegisterCreatureEvent(669001, 2, onLeaveCombat)
