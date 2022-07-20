local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = '1.6.1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local FAIL_SOUND = 847
local FOLLOW_DISTANCE = 2
local HIRE_AURA = 62109

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

--local HIRELING_DURATION = 1000*60*360 -- Milliseconds*Seconds*Minutes

local baseFees = {
    [SELLSWORD] = 12,
    [BATTLEMAGE] = 18,
}

local modHP = {
    [SELLSWORD] = 2,
    [BATTLEMAGE] = 1.2,
}

local modMana = {
    [SELLSWORD] = 1,
    [BATTLEMAGE] = 1.5,
}

local modDamage = {
    [SELLSWORD] = 1.2,
    [BATTLEMAGE] = 1.6,
}

local modMaxLevel = {
    [SELLSWORD] = 3,
    [BATTLEMAGE] = 5,
}

local talkAttack = {
    [SELLSWORD1] = 9680,
    [SELLSWORD2] = 2718, 
    [SELLSWORD3] = 2694,
    [SELLSWORD4] = 9625,
    [BATTLEMAGE1] = 9625,
    [BATTLEMAGE2] = 9625,
    [BATTLEMAGE3] = 2840,
    [BATTLEMAGE4] = 2670,
}

local talkJoke = {
    [SELLSWORD1] = 9695,
    [SELLSWORD2] = 6115, 
    [SELLSWORD3] = 6368,
    [SELLSWORD4] = 9643,
    [BATTLEMAGE1] = 9643,
    [BATTLEMAGE2] = 9643,
    [BATTLEMAGE3] = 6124,
    [BATTLEMAGE4] = 6170,
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

local Buffs = {
    [SELLSWORD] = 35361,  -- Thorns
    [BATTLEMAGE] = 12042, -- Arcane Power
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

local function spawnHireling(entry, player)
    if player:HasAura(HIRE_AURA) then
        player:SendBroadcastMessage("Sorry, you already have a hireling.")
    else
        local hLevel = player:GetLevel()+math.random(1,modMaxLevel[entry])
        local hHealth = (player:GetMaxHealth()/player:GetLevel()) * hLevel
        local hireling = PerformIngameSpawn(1, entry, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false)
        hireling:SetFaction(35)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        hireling:SetLevel(hLevel)
        local hStats = getBaseStats(hireling)
        hireling:SetMaxHealth(hStats['hp'])
        hireling:SetHealth(hStats['hp'])
        hireling:SetInt32Value(25, hStats['mana']) -- Set max mana
        hireling:SetInt32Value(33, hStats['mana']) -- Set current mana
        hireling:SetFloatValue(70, hStats['minDamage'])
        hireling:SetFloatValue(71, hStats['maxDamage'])
        hireling:SetFlag(79, 2) -- Set trackable on minimap
        hireling:SetInt32Value(123, hStats['attackPower'])
        hireling:MoveFollow(player, FOLLOW_DISTANCE, 60)
        hireling:SetEquipmentSlots(Weapons[entry], 0, 0)
        hireling:SetSheath(0)
        hireling:SendUnitSay("Greetings, "..player:GetName()..".", 0)
        local aura = hireling:AddAura(HIRE_AURA, player)
        aura:SetMaxDuration(2147483647)
        aura:SetDuration(2147483647)
    end
end

local function summonHireling(player)
    aura = player:GetAura(HIRE_AURA)
    if aura then
        unit = aura:GetCaster()
        if unit then
            if unit:GetMapId() == player:GetMapId() then
                x, y, z, o = player:GetLocation()
                unit:NearTeleport( x, y, z, o )
            else
                player:SendBroadcastMessage("Your hireling is too far away to be summoned.")
                player:PlayDirectSound(FAIL_SOUND)
            end
        else
            player:SendBroadcastMessage("Your hireling is too far away to be summoned.")
            player:PlayDirectSound(FAIL_SOUND)
        end
    else
        player:SendBroadcastMessage("You don't have a hireling right now.")
        player:PlayDirectSound(FAIL_SOUND)
    end
end

local function dismissHireling(player)
    aura = player:GetAura(HIRE_AURA)
    unit = aura:GetCaster()
    if unit then
        --unit:PlayDistanceSound(9636, player)
        unit:DespawnOrUnsummon(0)
        player:RemoveAura(HIRE_AURA)
    else
        player:SendBroadcastMessage("Your hireling is too far away to be dismissed.")
        player:PlayDirectSound(FAIL_SOUND)
    end
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire') == 1) and player:GetGMRank() > 2 then
        if (msg:find('#hire sword') == 1) then
            spawnHireling(SELLSWORD, player)
            return false
        elseif (msg:find('#hire mage') == 1) then
            spawnHireling(BATTLEMAGE, player)
            return false
        elseif (msg:find('#hire aura') == 1) then
            player:SendBroadcastMessage("Aura status: "..tostring(player:HasAura(HIRE_AURA)))
            return false
        elseif (msg:find('#hire dismiss') == 1) then
            dismissHireling(player)
            return false
        elseif (msg:find('#hire loc') == 1) then
            aura = player:GetAura(HIRE_AURA)
            unit = aura:GetCaster()
            if unit then
                x, y, z, o = unit:GetLocation()
                player:SendBroadcastMessage("Hireling Location X:"..x.." Y:"..y.." Z:"..z.." O:"..o.." Map:"..unit:GetMapId())
            else
                player:SendBroadcastMessage("Hireling Location: Unknown")
            end
            return false
        elseif (msg:find('#hire summon') == 1) then
            summonHireling(player)
            return false
        else
            player:SendBroadcastMessage(msg.." command does not exist")
            return false
        end
    end
end

local function onPreCombat(event, creature, target)
    local buff = Buffs[creature:GetEntry()]
    if not creature:HasAura(buff) then
        creature:CastSpell(creature, buff, true)
    end
end    

local function onEnterCombat(event, creature, target)
    local player = creature:GetOwner()
    local spell = Spells[creature:GetDisplayId()]
    creature:CastSpell(target, spell, true)
    if math.random(1,5) == 1 then
        creature:PlayDistanceSound(talkAttack[creature:GetDisplayId()], player)
    end
end    

local function onLeaveCombat(event, creature)
    local player = creature:GetOwner()
    creature:SetHealth(creature:GetMaxHealth())
    creature:SetSheath(0)
    creature:SetInt32Value(33, creature:GetInt32Value(25)) -- Set mana to max
    creature:MoveFollow(player, FOLLOW_DISTANCE, 60)
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
    player:RemoveAura(HIRE_AURA)
end

local function brokerOnHello(event, player, unit)
    if player:HasAura(HIRE_AURA) then
        player:GossipSetText("What can I do for you today, "..player:GetClassAsString().."?")
            player:GossipMenuAddItem(0, "Please bring my minion here.", 0, 10)
            player:GossipMenuAddItem(0, "Please dismiss my hireling.", 0, 11, null, "Are you sure you want to dismiss your hireling?")
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
        spawnHireling(SELLSWORD, player)
        player:ModifyMoney(-(baseFees[SELLSWORD]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 2 then
        spawnHireling(BATTLEMAGE, player)
        player:ModifyMoney(-(baseFees[BATTLEMAGE]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 3 then
        player:GossipComplete()
    end
    if intid == 10 then
        summonHireling(player)
        player:GossipComplete()
    end
    if intid == 11 then
        dismissHireling(player)
        player:GossipComplete()
    end
end

local function hirelingSetFollow(unit, player)
    unit:Dismount()
    unit:MoveExpire()
    unit:MoveIdle()
    unit:MoveFollow(player, FOLLOW_DISTANCE, 60)
    unit:SetAggroEnabled(true)
end

local function hirelingSetStay(unit)
    unit:MoveExpire()
    unit:MoveIdle()
    unit:SetAggroEnabled(false)
end

local function hirelingSetMounted(unit, player)
    unit:Mount(Mounts[unit:GetDisplayId()])
    unit:MoveExpire()
    unit:MoveIdle()
    unit:MoveFollow(player, FOLLOW_DISTANCE, 60)
    unit:SetAggroEnabled(false)
end

local function hirelingOnHello(event, player, unit)
    if player:GetGUID() == unit:GetOwnerGUID() then
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nWhat can I do for you?")
        player:GossipMenuAddItem(0, "Follow me, there's killing to be done.", 0, 1)
        player:GossipMenuAddItem(0, "Wait here, I'll take care of this. (Passive)", 0, 2)
        player:GossipMenuAddItem(0, "Mount up and follow me, it's time to move. (Passive)", 0, 3)
        player:GossipMenuAddItem(0, "Do you know any good jokes?", 0, 4)
        player:GossipMenuAddItem(0, "You have completed your work here. I release you from your contract.", 0, 5, null, "Are you sure you want to dismiss this hireling?")
        player:GossipSendMenu(0x7FFFFFFF, unit)
    else
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nI'm with a client right now, but you can visit any Hireling Broker to get some help!")
        player:GossipSendMenu(0x7FFFFFFF, unit)
        --player:SendBroadcastMessage("That's not your hireling!")
    end
end

local function hirelingOnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then -- follow
        hirelingSetFollow(unit, player)
        player:GossipComplete()
    end
    if intid == 2 then -- stay
        hirelingSetStay(unit)
        player:GossipComplete()
    end
    if intid == 3 then -- mount
        hirelingSetMounted(unit, player)
        player:GossipComplete()
    end
    if intid == 4 then -- joke
        unit:PlayDistanceSound(talkJoke[unit:GetDisplayId()], player)
        player:GossipComplete()
    end
    if intid == 5 then -- dismiss
        dismissHireling(player)
    end
end

local function onServerStartup(event)
    CharDBExecute("DELETE FROM character_aura WHERE spell = 62109")
    print("["..MODULE_NAME.."]: Cleaned Auras table.")
end

RegisterServerEvent(14, onServerStartup)

RegisterPlayerEvent(18, onChatMessage)

RegisterCreatureEvent(SELLSWORD, 10, onPreCombat)
RegisterCreatureEvent(SELLSWORD, 1, onEnterCombat)
RegisterCreatureEvent(SELLSWORD, 2, onLeaveCombat)
RegisterCreatureEvent(SELLSWORD, 37, onRemove)

RegisterCreatureEvent(BATTLEMAGE, 10, onPreCombat)
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
