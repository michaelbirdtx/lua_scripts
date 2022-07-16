local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = 'Beta 1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local hireAura = 62109
local baseFee = 32
local followDistance = 2

local SELLSWORD = 669001
local SELLSWORD1 = 17214
local SELLSWORD2 = 3054
local SELLSWORD3 = 1314
local SELLSWORD4 = 17671

local BATTLEMAGE = 669002
local BATTLEMAGE1 = 29869

local modHP = {
    [SELLSWORD] = 1.6,
    [BATTLEMAGE] = 1,
}

local modMana = {
    [SELLSWORD] = 1,
    [BATTLEMAGE] = 1.3,
}

local modDamage = {
    [SELLSWORD] = 1.6,
    [BATTLEMAGE] = 1,
}

local Spells = {
    [SELLSWORD1] = 335, -- Taunt
    [SELLSWORD2] = 11578, -- Charge
    [SELLSWORD3] = 57755, -- Heroic Throw
    [SELLSWORD4] = 12328, -- Sweeping Strikes
    [BATTLEMAGE1] = 31589, -- Slow
    --[29869] = 31117, -- Blood Elf - Unstable Affliction
    --[29869] = 8406, -- Blood Elf - Frostbolt
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

    --[[
    {name = , rank = 1, entry = },
    {name = , rank = 2, entry = },
    {name = , rank = 3, entry = },
    {name = , rank = 4, entry = },
    {name = , rank = 5, entry = },
    {name = , rank = 6, entry = },
    {name = , rank = 7, entry = },
    {name = , rank = 8, entry = },
    ]]

}

local Weapons = {
    [SELLSWORD] = 11786, -- Stone of the Earth
    [BATTLEMAGE] = 31334, -- Staff of Natural Fury
}

local function getRankedSpell(name, caster)
    rank = string.sub(caster:GetLevel(), 1, 1)
    --print("Spell Rank: "..rank)
    for i, v in ipairs(rankedSpells) do
        if v.name==name and v.rank==rank then
            print("Spell Name: "..v.name.." Rank: "..v.rank.." Entry: "..v.entry)
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
        print("entry: "..entry)
        print("class: "..class)
        print("level: "..level)
        print("health: "..stats['hp'])
        print("mana: "..stats['mana'])
        print("armor: "..stats['armor'])
        print("attackpower: "..Query:GetString(3))
        print("damage_base: "..Query:GetString(4))
        print("minDamage: "..stats['minDamage'])
        print("maxDamage: "..stats['maxDamage'])
        print("Power type: "..unit:GetPowerType())
    end
    return stats
end

local function summonHireling(entry, player)
    if player:HasAura(hireAura) then
        player:SendBroadcastMessage("Sorry, you already have a hireling.")
    else
        hLevel = player:GetLevel()+math.random(1,3)
        hHealth = (player:GetMaxHealth()/player:GetLevel()) * hLevel
        hireling = PerformIngameSpawn(1, entry, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 1800000)
        hireling:SetFaction(35)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        hireling:SetLevel(hLevel)
        hStats = getBaseStats(hireling)
        hireling:SetMaxHealth(hStats['hp'])
        hireling:SetHealth(hStats['hp'])
        --hireling:SetPower(hStats['mana'], POWER_ALL)
        --hireling:SetFloatValue(25, hStats['mana'])
        hireling:SetInt32Value(25, hStats['mana'])
        hireling:SetInt32Value(33, hStats['mana'])
        hireling:SetFloatValue(70, hStats['minDamage'])
        hireling:SetFloatValue(71, hStats['maxDamage'])
        hireling:SetInt32Value(123, hStats['attackPower'])
        hireling:MoveFollow(player, followDistance, 60)
        hireling:SetEquipmentSlots(Weapons[entry], 0, 0)
        hireling:SetSheath(0)
        hireling:SendUnitSay("Greetings, "..player:GetName()..".", 0)
        aura = player:AddAura(hireAura, player)
        aura:SetMaxDuration(2147483647)
        aura:SetDuration(2147483647)
    end
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire sword') == 1) then
        summonHireling(SELLSWORD, player)
    end
    if (msg:find('#hire mage') == 1) then
        summonHireling(BATTLEMAGE, player)
    end
    if (msg:find('#hire aura') == 1) then
        player:SendBroadcastMessage("Aura status: "..tostring(player:HasAura(hireAura)))
    end
end

local function onEnterCombat(event, creature, target)
    spell = Spells[creature:GetDisplayId()]
    print("Hireling casts "..spell)
    creature:CastSpell(target, spell, true)
end

local function onLeaveCombat(event, creature)
    player = creature:GetOwner()
    creature:SetHealth(creature:GetMaxHealth())
    creature:SetSheath(0)
    creature:MoveFollow(player, followDistance, 60)
end

local function onSpellHitTarget(event, creature, target, spellid)
    spell = getRankedSpell("frostbolt", creature)
    --print("Hireling casts "..spell)
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
        player:GossipMenuAddItem(0, "I'd like to hire a Sellsword.", 0, 1, null, "The fee for this hireling is...", baseFee*player:GetLevel())
        player:GossipMenuAddItem(0, "I'd like to hire a Battle Mage.", 0, 2, null, "The fee for this hireling is...", baseFee*player:GetLevel())
        player:GossipMenuAddItem(0, "Never mind, I'll do it by myself.", 0, 3)
        player:GossipSendMenu(0x7FFFFFFF, unit)
    end
end

local function brokerOnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then
        summonHireling(SELLSWORD, player)
        player:ModifyMoney(-(baseFee*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 2 then
        summonHireling(BATTLEMAGE, player)
        player:ModifyMoney(-(baseFee*player:GetLevel()))
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
        player:GossipMenuAddItem(0, "Wait here, I'll bring them to you.", 0, 2)
        player:GossipMenuAddItem(0, "You have completed your work here. I release you from your contract.", 0, 3)
        player:GossipSendMenu(0x7FFFFFFF, unit)
    else
        player:SendBroadcastMessage("That's not your hireling!")
    end
end

local function hirelingOnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then
        unit:MoveExpire()
        unit:MoveIdle()
        unit:MoveFollow(player, followDistance, 60)
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

local function onServerStartup(event)
    print("Server Startup event triggered.")
    CharDBExecute("DELETE FROM character_aura WHERE spell = 62109")
end

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

RegisterCreatureGossipEvent(669010, 1, brokerOnHello)
RegisterCreatureGossipEvent(669010, 2, brokerOnSelect)

--RegisterCreatureGossipEvent(669011, 1, brokerOnHello)
--RegisterCreatureGossipEvent(669011, 2, brokerOnSelect)

RegisterServerEvent(14, onServerStartup)