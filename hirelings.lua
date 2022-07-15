local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Spells = {
    [669001] = 335, -- Taunt
}

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire sword') == 1) then
        hLevel = player:GetLevel()+math.random(1,3)
        hHealth = (player:GetMaxHealth()/player:GetLevel()) * hLevel
        hireling = PerformIngameSpawn(1, 669001, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 600000)
        hireling:SetFaction(35)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        hireling:SetLevel(hLevel)
        hireling:SetMaxHealth(hHealth)
        hireling:SetHealth(hHealth)
        hireling:SetFloatValue(70, player:GetFloatValue(70)*1.5) -- Set MinDamage based on player
        hireling:SetFloatValue(71, player:GetFloatValue(71)*1.5) -- Set MaxDamage based on player
        --hireling:SetDefaultMovementType(14)
        hireling:MoveFollow(player, 3, 60)
        hireling:SetEquipmentSlots(11786, 0, 0)
    end
end

local function onEnterCombat(event, creature, target)
    spell = Spells[creature:GetEntry()]
    print("Hireling casts "..spell)
    creature:CastSpell(target, spell, true)
end

local function onLeaveCombat(event, creature)
    player = creature:GetOwner()
    creature:SetHealth(creature:GetMaxHealth())
    creature:SetSheath(0)
    creature:MoveFollow(player, 3, 60)
end

local function onRemove(event, creature)
    player = creature:GetOwner()
    creature:SendUnitSay("Fair well, "..player:GetName()..".", 0)
    creature:PerformEmote(3)
end

local function hirelingOnHello(event, player, unit)
    player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nWhat can I do for you?")
    player:GossipMenuAddItem(0, "Follow me, there's killing to be done.", 0, 1)
    player:GossipMenuAddItem(0, "Wait here, I'll bring them to you.", 0, 2)
    player:GossipMenuAddItem(0, "You have completed your work here. I release you from your contract.", 0, 3)
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function hirelingOnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then
        unit:MoveExpire()
        unit:MoveIdle()
        unit:MoveFollow(player, 3, 60)
        player:GossipComplete()
    end
    if intid == 2 then
        unit:MoveExpire()
        unit:MoveIdle()
        player:GossipComplete()
    end
    if intid == 3 then
        unit:DespawnOrUnsummon(0)
    end
end

RegisterPlayerEvent(18, onChatMessage)
RegisterCreatureEvent(669001, 1, onEnterCombat)
RegisterCreatureEvent(669001, 2, onLeaveCombat)
RegisterCreatureEvent(669001, 37, onRemove)
RegisterCreatureGossipEvent(669001, 1, hirelingOnHello)
RegisterCreatureGossipEvent(669001, 2, hirelingOnSelect)
