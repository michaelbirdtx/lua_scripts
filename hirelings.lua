local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = 'Beta 1.3'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local hireAura = 62109
local followDistance = 2

local BROKER = 669000

local SELLSWORD = 669001
local SELLSWORD1 = 17214 -- Female Draenei
local SELLSWORD2 = 3054 -- Male Dwarf
local SELLSWORD3 = 1314 -- Male Orc
local SELLSWORD4 = 17671 -- Female Blood Elf

local BATTLEMAGE = 669002
local BATTLEMAGE1 = 29869 -- Female Blood Elf
local BATTLEMAGE2 = 26073 -- Female Blood Elf
local BATTLEMAGE3 = 28160 -- Female Gnome
local BATTLEMAGE4 = 25166 -- Male Human

local HIRELING_DURATION = 1000*60*60 -- Milliseconds*Seconds*Minutes

local baseFees = {
    [SELLSWORD] = 12,
    [BATTLEMAGE] = 18,
}

local modHP = {
    [SELLSWORD] = 1.8,
    [BATTLEMAGE] = 1.2,
}

local modMana = {
    [SELLSWORD] = 1,
    [BATTLEMAGE] = 1,
}

local modDamage = {
    [SELLSWORD] = 1.6,
    [BATTLEMAGE] = 1.2,
}

local modMaxLevel = {
    [SELLSWORD] = 3,
    [BATTLEMAGE] = 5,
}

local Mounts = {
    [SELLSWORD1] = 14582, -- Swift Palomino
    [SELLSWORD2] = 22350, -- SWift Brewfest Ram
    [SELLSWORD3] = 2326, -- Red Wolf
    [SELLSWORD4] = 21074, -- Dark Riding Talbuk
    [BATTLEMAGE1] = 2410, -- White Riding Stallion
    [BATTLEMAGE2] = 28889, -- Sunreaver Hawkstrider
    [BATTLEMAGE3] = 14372, -- Black Battlestrider
    [BATTLEMAGE4] = 2402, -- Black Stallion
}

local Spells = {
    [SELLSWORD1] = 355, -- Taunt
    [SELLSWORD2] = 11578, -- Charge
    [SELLSWORD3] = 4336, -- Jump Jets
    [SELLSWORD4] = 57755, -- Heroic Throw
    [BATTLEMAGE1] = 31589, -- Slow
    [BATTLEMAGE2] = 31589, -- Slow
    [BATTLEMAGE3] = 31589, -- Slow
    [BATTLEMAGE4] = 31589, -- Slow
}

local rankedSpells = {

    {name = 'frostbolt', rank = '1', entry = 837},
    {name = 'frostbolt', rank = '2', entry = 7322},
    {name = 'frostbolt', rank = '3', entry = 8407},
    {name = 'frostbolt', rank = '4', entry = 10179},
    {name = 'frostbolt', rank = '5', entry = 10181},
    {name = 'frostbolt', rank = '6', entry = 27072},
    {name = 'frostbolt', rank = '7', entry = 42841},
    {name = 'frostbolt', rank = '8', entry = 42842},

    {name = 'fireball', rank = '1', entry = 145},
    {name = 'fireball', rank = '2', entry = 8400},
    {name = 'fireball', rank = '3', entry = 8402},
    {name = 'fireball', rank = '4', entry = 10149},
    {name = 'fireball', rank = '5', entry = 10150},
    {name = 'fireball', rank = '6', entry = 27070},
    {name = 'fireball', rank = '7', entry = 42832},
    {name = 'fireball', rank = '8', entry = 42833},

    {name = 'shadowbolt', rank = '1', entry = 695},
    {name = 'shadowbolt', rank = '2', entry = 1106},
    {name = 'shadowbolt', rank = '3', entry = 7641},
    {name = 'shadowbolt', rank = '4', entry = 11659},
    {name = 'shadowbolt', rank = '5', entry = 11661},
    {name = 'shadowbolt', rank = '6', entry = 27209},
    {name = 'shadowbolt', rank = '7', entry = 47808},
    {name = 'shadowbolt', rank = '8', entry = 47809},

    {name = 'lightningbolt', rank = '1', entry = 548},
    {name = 'lightningbolt', rank = '2', entry = 943},
    {name = 'lightningbolt', rank = '3', entry = 10391},
    {name = 'lightningbolt', rank = '4', entry = 15207},
    {name = 'lightningbolt', rank = '5', entry = 15208},
    {name = 'lightningbolt', rank = '6', entry = 25449},
    {name = 'lightningbolt', rank = '7', entry = 49237},
    {name = 'lightningbolt', rank = '8', entry = 49238},

}

local Weapons = {
    [SELLSWORD] = 11786, -- Stone of the Earth
    [BATTLEMAGE] = 31334, -- Staff of Natural Fury
}

local function getRankedSpell(name, caster)
    rank = string.sub(caster:GetLevel(), 1, 1)
    for i, v in ipairs(rankedSpells) do
        if v.name==name and v.rank==rank then
            return v.entry
        end
    end
end

local function getBaseStats(unit)
    entry = unit:GetEntry()
    class = unit:GetClass()
    level = unit:GetLevel()
    stats = {
        ['hp'] = 0,
        ['mana'] = 0,
        ['armor'] = 0,
        ['minDamage'] = 0,
        ['maxDamage'] = 0,
    }
    local Query = WorldDBQuery("SELECT `basehp0`, `basemana`, `basearmor`, `attackpower`, `damage_base` FROM creature_classlevelstats WHERE `class` = "..class.." AND level = "..level..";")
    if Query then
        stats['hp'] = Query:GetString(0)*modHP[entry]
        stats['mana'] = Query:GetString(1)*modMana[entry]
        stats['armor'] = Query:GetString(2)
        stats['attackPower'] = Query:GetString(4)
        stats['minDamage'] = ((Query:GetString(4) + (Query:GetString(3)/14)) * modDamage[entry]) * 2
        stats['maxDamage'] = (((Query:GetString(4)*1.5) + (Query:GetString(3)/14)) * modDamage[entry]) * 2
    end
    return stats
end

local function summonHireling(entry, player)
    if player:HasAura(hireAura) then
        player:SendBroadcastMessage("Sorry, you already have a hireling.")
    else
        local hLevel = player:GetLevel()+math.random(1,modMaxLevel[entry])
        local hHealth = (player:GetMaxHealth()/player:GetLevel()) * hLevel
        local hireling = PerformIngameSpawn(1, entry, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, HIRELING_DURATION)
        hireling:SetFaction(35)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        hireling:SetLevel(hLevel)
        local hStats = getBaseStats(hireling)
        hireling:SetMaxHealth(hStats['hp'])
        hireling:SetHealth(hStats['hp'])
        hireling:SetInt32Value(25, hStats['mana'])
        hireling:SetInt32Value(33, hStats['mana'])
        hireling:SetFloatValue(70, hStats['minDamage'])
        hireling:SetFloatValue(71, hStats['maxDamage'])
        hireling:SetFlag(79, 2) -- Set trackable on minimap
        hireling:SetInt32Value(123, hStats['attackPower'])
        hireling:MoveFollow(player, followDistance, 60)
        hireling:SetEquipmentSlots(Weapons[entry], 0, 0)
        hireling:SetSheath(0)
        hireling:SendUnitSay("Greetings, "..player:GetName()..".", 0)
        local aura = player:AddAura(hireAura, player)
        aura:SetMaxDuration(2147483647)
        aura:SetDuration(2147483647)
    end
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire sword') == 1) then
        summonHireling(SELLSWORD, player)
        return false
    end
    if (msg:find('#hire mage') == 1) then
        summonHireling(BATTLEMAGE, player)
        return false
    end
    if (msg:find('#hire aura') == 1) then
        player:SendBroadcastMessage("Aura status: "..tostring(player:HasAura(hireAura)))
        return false
    end
    if (msg:find('#hire fly') == 1) then
        player:SendBroadcastMessage("Can fly: "..tostring(player:CanFly()))
        return false
    end
end

local function onEnterCombat(event, creature, target)
    local spell = Spells[creature:GetDisplayId()]
    creature:CastSpell(target, spell, true)
end

local function onLeaveCombat(event, creature)
    local player = creature:GetOwner()
    creature:SetHealth(creature:GetMaxHealth())
    creature:CastSpell(creature, 52895, true)
    creature:SetSheath(0)
    creature:MoveFollow(player, followDistance, 60)
end

local function onSpellHitTarget(event, creature, target, spellid)
    local spell
    if creature:GetDisplayId() == BATTLEMAGE1 then
        spell = getRankedSpell("frostbolt", creature)
    elseif creature:GetDisplayId() == BATTLEMAGE2 then
        spell = getRankedSpell("fireball", creature)
    elseif creature:GetDisplayId() == BATTLEMAGE3 then
        spell = getRankedSpell("shadowbolt", creature)
    elseif creature:GetDisplayId() == BATTLEMAGE4 then
        spell = getRankedSpell("lightningbolt", creature)
    end
    creature:CastSpell(target, spell, false)
end

local function onRemove(event, creature)
    player = creature:GetOwner()
    creature:SendUnitSay("Fair well, "..player:GetName()..".", 0)
    creature:PerformEmote(2) -- Bow
    player:RemoveAura(hireAura)
end

local function brokerOnHello(event, player, unit)
    if player:HasAura(hireAura) then
        player:GossipSetText("Sorry, "..player:GetClassAsString()..". Due to high demand, I can't spare another hireling right now.")
        player:GossipSendMenu(0x7FFFFFFF, unit)
    else
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nAre you in need of assistance? Our hirelings will fight alongside you until death, or until they get bored.")
        player:GossipMenuAddItem(0, "I'd like to hire a Sellsword.", 0, 1, null, "The fee for this hireling is...", baseFees[SELLSWORD]*player:GetLevel())
        player:GossipMenuAddItem(0, "I'd like to hire a Battle Mage.", 0, 2, null, "The fee for this hireling is...", baseFees[BATTLEMAGE]*player:GetLevel())
        player:GossipMenuAddItem(0, "Never mind, I'll do it by myself.", 0, 3)
        player:GossipSendMenu(0x7FFFFFFF, unit)
    end
end

local function brokerOnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then
        summonHireling(SELLSWORD, player)
        player:ModifyMoney(-(baseFees[SELLSWORD]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 2 then
        summonHireling(BATTLEMAGE, player)
        player:ModifyMoney(-(baseFees[BATTLEMAGE]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 3 then
        player:GossipComplete()
    end
end

local function hirelingOnHello(event, player, unit)
    if player:GetGUID() == unit:GetOwnerGUID() then
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nWhat can I do for you?")
        player:GossipMenuAddItem(0, "Follow me, there's killing to be done.", 0, 1)
        player:GossipMenuAddItem(0, "Wait here, I'll take care of this. (Passive)", 0, 2)
        player:GossipMenuAddItem(0, "Mount up, it's time to move. (Passive)", 0, 3)
        player:GossipMenuAddItem(0, "You have completed your work here. I release you from your contract.", 0, 4)
        player:GossipSendMenu(0x7FFFFFFF, unit)
    else
        player:SendBroadcastMessage("That's not your hireling!")
    end
end

local function hirelingOnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then
        unit:Dismount()
        unit:MoveExpire()
        unit:MoveIdle()
        unit:MoveFollow(player, followDistance, 60)
        unit:SetAggroEnabled(true)
        player:GossipComplete()
    end
    if intid == 2 then
        unit:Dismount()
        unit:MoveExpire()
        unit:MoveIdle()
        unit:SetAggroEnabled(false)
        player:GossipComplete()
    end
    if intid == 3 then
        unit:Mount(Mounts[unit:GetDisplayId()])
        unit:MoveExpire()
        unit:MoveIdle()
        unit:MoveFollow(player, followDistance, 60)
        unit:SetAggroEnabled(false)
        player:GossipComplete()
    end
    if intid == 4 then
        unit:DespawnOrUnsummon(0)
    end
end

local function onServerStartup(event)
    CharDBExecute("DELETE FROM character_aura WHERE spell = 62109")
    print("["..MODULE_NAME.."]: Cleaned Auras table.")
end

RegisterServerEvent(14, onServerStartup)

RegisterPlayerEvent(18, onChatMessage)

RegisterCreatureEvent(SELLSWORD, 1, onEnterCombat)
RegisterCreatureEvent(SELLSWORD, 2, onLeaveCombat)
RegisterCreatureEvent(SELLSWORD, 37, onRemove)

RegisterCreatureEvent(BATTLEMAGE, 1, onEnterCombat)
RegisterCreatureEvent(BATTLEMAGE, 2, onLeaveCombat)
RegisterCreatureEvent(BATTLEMAGE, 15, onSpellHitTarget)
RegisterCreatureEvent(BATTLEMAGE, 37, onRemove)

RegisterCreatureGossipEvent(SELLSWORD, 1, hirelingOnHello)
RegisterCreatureGossipEvent(SELLSWORD, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(BATTLEMAGE, 1, hirelingOnHello)
RegisterCreatureGossipEvent(BATTLEMAGE, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(BROKER, 1, brokerOnHello)
RegisterCreatureGossipEvent(BROKER, 2, brokerOnSelect)
