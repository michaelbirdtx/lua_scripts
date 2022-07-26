local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = '2.1.6'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local FAIL_SOUND = 847
local HIRE_AURA = 62109
local PASSIVE_AURA = 31260
local HEAL_THRESHOLD = 90
local HEAL_REST_THRESHOLD = 95
local HEALTH_CRITICAL_THRESHOLD = 20
local RESET_EMOTE = 7 -- Eat

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
local BATTLEMAGE4 = 3876  -- Male Undead

local WITCHDOCTOR = 669003
local WITCHDOCTOR1 = 11764 -- Female Troll
local WITCHDOCTOR2 = 11762 -- Male Troll
local WITCHDOCTOR3 = 0
local WITCHDOCTOR4 = 0

local GLADIATOR = 669011
local GLADIATOR1 = 27154
local GLADIATOR2 = 0
local GLADIATOR3 = 0
local GLADIATOR4 = 0

local faq = {
    ["intro"] = "Here are some commands you can give me (you must target me first):",
    ["follow"] = "\n\n/follow\n    If you are mounted, I will mount up and follow you, not attacking anything, even if you or I am attacked.\n    If you are not mounted, I will follow you and attack anything you attack or are attacked by.",
    ["wait"] = "\n\n/wait\n    I will stay where I am and not attack anything until you tell me otherwise.",
    ["flee"] = "\n\n/flee\n    I will stop my attack and follow you, not starting any new attacks until you tell me otherwise.",
    ["healme"] = "\n\n/healme\n    I will cast a healing spell on you, if I have one.",
    ["macros"] = "\n\nYou can also use these commands in macros. Here's a sample macro:\n\n    /tar Battle Mage\n    /tar Sellsword\n    /follow\n    /targetlasttarget\n\nThis will target your hireling (of either type), issue the /follow command, and then retarget your previous target, if any.",
    ["outro"] = "\n\nP.S.: When I have been instructed not to attack anything, I will have a pulsing blue circle around me, thanks to that clever and handsome Wizard, Mykal.\n\n",
}

local baseFees = {
    [SELLSWORD] = 12,
    [BATTLEMAGE] = 18,
    [WITCHDOCTOR] = 21,
    [GLADIATOR] = 1000,
}

local followDistance = {
    [SELLSWORD] = 3,
    [BATTLEMAGE] = 1.2,
    [WITCHDOCTOR] = 2,
    [GLADIATOR] = 3,
}

local followOrientation = {
    [SELLSWORD] = 6,
    [BATTLEMAGE] = 5,
    [WITCHDOCTOR] = 4,
    [GLADIATOR] = 6,
}

local modMinLevelBoost = {
    [SELLSWORD] =  0,
    [BATTLEMAGE] = 1,
    [WITCHDOCTOR] = 1,
    [GLADIATOR] =  3,
}

local modMaxLevelBoost = {
    [SELLSWORD] =  2,
    [BATTLEMAGE] = 3,
    [WITCHDOCTOR] = 3,
    [GLADIATOR] =  6,
}

local talkAttack = {
    [SELLSWORD1] = 9680,
    [SELLSWORD2] = 2718, 
    [SELLSWORD3] = 2694,
    [SELLSWORD4] = 9625,
    [BATTLEMAGE1] = 9625,
    [BATTLEMAGE2] = 9625,
    [BATTLEMAGE3] = 2840,
    [BATTLEMAGE4] = 2694,
    [WITCHDOCTOR1] = 2863,
    [WITCHDOCTOR2] = 2852,
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [GLADIATOR1] = 2718,
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
}

local talkJoke = {
    [SELLSWORD1] = 9695,
    [SELLSWORD2] = 6115, 
    [SELLSWORD3] = 6368,
    [SELLSWORD4] = 9643,
    [BATTLEMAGE1] = 9643,
    [BATTLEMAGE2] = 9643,
    [BATTLEMAGE3] = 6124,
    [BATTLEMAGE4] = 6422,
    [WITCHDOCTOR1] = 6395,
    [WITCHDOCTOR2] = 6404,
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [GLADIATOR1] = 6115,
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
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
    [WITCHDOCTOR1] = 6469, -- Mottled Red Raptor
    [WITCHDOCTOR2] = 6469, -- Mottled Red Raptor
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [GLADIATOR1] = 22350, -- SWift Brewfest Ram
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
}

local Spells = {
    [SELLSWORD1] = 355, -- Taunt
    [SELLSWORD2] = 11578, -- Charge
    [SELLSWORD3] = 4336, -- Jump Jets
    [SELLSWORD4] = 64382, -- Shattering Throw
    [BATTLEMAGE1] = 31589, -- Slow
    [BATTLEMAGE2] = 31589, -- Slow
    [BATTLEMAGE3] = 31589, -- Slow
    [BATTLEMAGE4] = 31589, -- Slow
    [WITCHDOCTOR1] = 0,
    [WITCHDOCTOR2] = 0,
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [GLADIATOR1] = 11578, -- Charge
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
}

local defenseSpell = {
    [SELLSWORD] = 0,
    [BATTLEMAGE] = 0,
    [WITCHDOCTOR] = 586, -- Fade
    [GLADIATOR] = 0,
}

local retaliateSpells = {
    [SELLSWORD] = 61044, -- Demoralizing Shout
    [BATTLEMAGE] = 2139, -- Counterspell
    [WITCHDOCTOR] = 0,   -- Not implemented
    [GLADIATOR] =  8078, -- Thunderclap
}

local Buffs = {
    [SELLSWORD] = 35361,  -- Thorns (non-ranked)
    [BATTLEMAGE] = 12042, -- Arcane Power (non-ranked)
    [WITCHDOCTOR] = 0,    -- (Uses ranked spell instead)
    [GLADIATOR] = 53307,  -- Thorns (Rank 8)
}

local Weapons = {
    [SELLSWORD] = 11786,   -- Stone of the Earth
    [BATTLEMAGE] = 31334,  -- Staff of Natural Fury
    [WITCHDOCTOR] = 22799, -- Soulseeker
    [GLADIATOR] = 47069,   -- Justicebringer
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

    {name = 'arcanemissiles', rank = '1', entry = 5143},
    {name = 'arcanemissiles', rank = '2', entry = 5145},
    {name = 'arcanemissiles', rank = '3', entry = 8417},
    {name = 'arcanemissiles', rank = '4', entry = 10211},
    {name = 'arcanemissiles', rank = '5', entry = 25345},
    {name = 'arcanemissiles', rank = '6', entry = 38699},
    {name = 'arcanemissiles', rank = '7', entry = 42843},
    {name = 'arcanemissiles', rank = '8', entry = 42846},

    {name = 'lightningbolt', rank = '1', entry = 548},
    {name = 'lightningbolt', rank = '2', entry = 943},
    {name = 'lightningbolt', rank = '3', entry = 10391},
    {name = 'lightningbolt', rank = '4', entry = 15207},
    {name = 'lightningbolt', rank = '5', entry = 15208},
    {name = 'lightningbolt', rank = '6', entry = 25449},
    {name = 'lightningbolt', rank = '7', entry = 49237},
    {name = 'lightningbolt', rank = '8', entry = 49238},

    {name = 'earthshield', rank = '1', entry = 974},
    {name = 'earthshield', rank = '2', entry = 974},
    {name = 'earthshield', rank = '3', entry = 974},
    {name = 'earthshield', rank = '4', entry = 974},
    {name = 'earthshield', rank = '5', entry = 32593},
    {name = 'earthshield', rank = '6', entry = 32594},
    {name = 'earthshield', rank = '7', entry = 49283},
    {name = 'earthshield', rank = '8', entry = 49284},

    {name = 'healingwave', rank = '1', entry = 547},
    {name = 'healingwave', rank = '2', entry = 913},
    {name = 'healingwave', rank = '3', entry = 959},
    {name = 'healingwave', rank = '4', entry = 8005},
    {name = 'healingwave', rank = '5', entry = 10396},
    {name = 'healingwave', rank = '6', entry = 25357},
    {name = 'healingwave', rank = '7', entry = 25396},
    {name = 'healingwave', rank = '8', entry = 49273},

    {name = 'watershield', rank = '1', entry = 52127},
    {name = 'watershield', rank = '2', entry = 52129},
    {name = 'watershield', rank = '3', entry = 52131},
    {name = 'watershield', rank = '4', entry = 52136},
    {name = 'watershield', rank = '5', entry = 52138},
    {name = 'watershield', rank = '6', entry = 24398},
    {name = 'watershield', rank = '7', entry = 33736},
    {name = 'watershield', rank = '8', entry = 57960},

    {name = 'prayerofhealing', rank = '1', entry = 596},
    {name = 'prayerofhealing', rank = '2', entry = 596},
    {name = 'prayerofhealing', rank = '3', entry = 996},
    {name = 'prayerofhealing', rank = '4', entry = 10960},
    {name = 'prayerofhealing', rank = '5', entry = 10961},
    {name = 'prayerofhealing', rank = '6', entry = 25316},
    {name = 'prayerofhealing', rank = '7', entry = 25308},
    {name = 'prayerofhealing', rank = '8', entry = 48072},

    {name = 'chainheal', rank = '1', entry = 1064},
    {name = 'chainheal', rank = '2', entry = 10622},
    {name = 'chainheal', rank = '3', entry = 10623},
    {name = 'chainheal', rank = '4', entry = 10623},
    {name = 'chainheal', rank = '5', entry = 25422},
    {name = 'chainheal', rank = '6', entry = 25423},
    {name = 'chainheal', rank = '7', entry = 55458},
    {name = 'chainheal', rank = '8', entry = 55459},

}

local raidMaps = Set {
    509, -- AQ Ruins
    531, -- AQ Temple
    564, -- Black Temple
    229, -- Blackrock Spire
    469, -- Blackwing Lair
    615, -- Chamber of the Aspects: Obsidian Sanctum
    724, -- Chamber of the Aspects: Ruby Sanctum
    565, -- Gruul's Lair
    532, -- Karazhan
    409, -- Molten Core
    533, -- Naxxramas
    616, -- Nexus: Eye of Eternity
    249, -- Onyxia's Lair
    580, -- The Sunwell
    550, -- Tempest Keep
    649, -- Trial of the Crusader
    624, -- Vault of Archavon
    568, -- Zul'Aman
}

local function getRankedSpell(name, caster, stepdown)
    rank = string.sub(caster:GetLevel(), 1, 1) - stepdown
    if rank < 1 then
        rank = 1
    end
    for i, v in ipairs(rankedSpells) do
        if v.name==name and v.rank==tostring(rank) then
            return v.entry
        end
    end
end

local function getBaseStats(hireling)
    entry = hireling:GetEntry()
    class = hireling:GetClass()
    level = hireling:GetLevel()
    stats = {}
    local qryStats = WorldDBQuery("SELECT `basehp0`, `basemana`, `basearmor`, `attackpower`, `damage_base` FROM creature_classlevelstats WHERE `class` = "..class.." AND level = "..level..";")
    local qryNPC = WorldDBQuery("SELECT `damagemodifier`, `baseattacktime`, `basevariance`, `HealthModifier`, `ManaModifier` FROM creature_template WHERE `entry` = "..entry..";")
    if qryStats and qryNPC then
        stats['damageModifier'] = qryNPC:GetFloat(0)
        stats['baseAttackTime'] = qryNPC:GetInt32(1)
        stats['baseVariance'] = qryNPC:GetFloat(2)
        stats['HealthModifier'] = qryNPC:GetFloat(3)
        stats['ManaModifier'] = qryNPC:GetFloat(4)
        stats['health'] = qryStats:GetInt32(0)*stats['HealthModifier']
        stats['mana'] = qryStats:GetInt32(1)*stats['ManaModifier']
        stats['armor'] = qryStats:GetInt32(2)
        stats['attackPower'] = qryStats:GetInt32(3)
        stats['damageBase'] = qryStats:GetFloat(4)
        stats['minDamage'] = (((stats['damageBase'] + (stats['attackPower'] / 14) * stats['baseVariance']) * stats['damageModifier']) * (stats['baseAttackTime'] / 1000))
        stats['maxDamage'] = ((((stats['damageBase'] * 1.5) + (stats['attackPower'] / 14) * stats['baseVariance']) * stats['damageModifier']) * (stats['baseAttackTime'] / 1000))
    end
    return stats
end

function spawnHireling(entry, player)
    if player:HasAura(HIRE_AURA) then
        player:SendBroadcastMessage("Sorry, you already have a hireling.")
    else
        hLevel = player:GetLevel()+math.random(modMinLevelBoost[entry],modMaxLevelBoost[entry])
        if hLevel > 80 then
            hLevel = 80
        end
        local hireling = PerformIngameSpawn(1, entry, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 4294967295, 1) --player:GetPhaseMaskForSpawn())
        hireling:SetFaction(35)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        hireling:SetLevel(hLevel)
        local hStats = getBaseStats(hireling)
        hireling:SetMaxHealth(hStats['health'])
        hireling:SetHealth(hStats['health'])
        hireling:SetInt32Value(UNIT_FIELD_MAXPOWER1, hStats['mana']) -- Set max mana
        hireling:SetInt32Value(UNIT_FIELD_POWER1, hStats['mana']) -- Set current mana
        hireling:SetInt32Value(UNIT_FIELD_ATTACK_POWER, hStats['attackPower'])
        hireling:SetFloatValue(70, hStats['minDamage'])
        hireling:SetFloatValue(71, hStats['maxDamage'])
        hireling:SetFlag(79, 2) -- Set trackable on minimap
        hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
        hireling:SetEquipmentSlots(Weapons[entry], 0, 0)
        hireling:SetSheath(0)
        hireling:SendUnitSay("Greetings, "..player:GetName()..".", 0)
        local aura = hireling:AddAura(HIRE_AURA, player)
        aura:SetMaxDuration(2147483647)
        aura:SetDuration(2147483647)
    end
end

function summonHireling(player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling then
            if hireling:GetMapId() == player:GetMapId() then
                x, y, z, o = player:GetLocation()
                hireling:NearTeleport( x, y, z, o )
                hireling:CastSpell(hireling, 75128, true) -- Teleport effect
                hirelingSetFollow(hireling, player)
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

function dismissHireling(player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling then
            hireling:DespawnOrUnsummon(0)
            player:RemoveAura(HIRE_AURA)
        else
            player:SendBroadcastMessage("Your hireling is too far away to be dismissed.")
            player:PlayDirectSound(FAIL_SOUND)
        end
    else
        player:SendBroadcastMessage("You don't have a hireling.")
    end
end

function CheckContract(hireling, player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        if hireling:GetGUID() ~= aura:GetCaster():GetGUID() then
            --hireling:DespawnOrUnsummon(0)
            return false
        else
            return true
        end
    else
        --hireling:DespawnOrUnsummon(0)
        return false
    end
end

function hirelingSetFollow(hireling, player)
    if CheckContract(hireling, player) then
        hireling:Dismount()
        hireling:MoveExpire()
        hireling:MoveIdle()
        hireling:SetAggroEnabled(true)
        hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
        hireling:RemoveAura(PASSIVE_AURA)
    else
        hireling:DespawnOrUnsummon(0)
    end
end

function hirelingSetStay(hireling, player)
    hireling:MoveExpire()
    hireling:MoveIdle()
    hireling:SetAggroEnabled(false)
    hireling:AddAura(PASSIVE_AURA, hireling)
end

function hirelingSetMounted(hireling, player)
    hireling:Mount(Mounts[hireling:GetDisplayId()])
    hireling:MoveExpire()
    hireling:MoveIdle()
    hireling:SetAggroEnabled(false)
    hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
    hireling:AddAura(PASSIVE_AURA, hireling)
end

function hirelingFlee(hireling, player)
    hireling:AttackStop()
    hireling:MoveExpire()
    hireling:MoveIdle()
    hireling:SetAggroEnabled(false)
    hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
    hireling:AddAura(PASSIVE_AURA, hireling)
    hireling:CastSpell(hireling, 11305, true)
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire') == 1) and player:GetGMRank() > 0 then
        if (msg:find('#hire sword') == 1) then
            spawnHireling(SELLSWORD, player)
            return false
        elseif (msg:find('#hire mage') == 1) then
            spawnHireling(BATTLEMAGE, player)
            return false
        elseif (msg:find('#hire doc') == 1) then
            spawnHireling(WITCHDOCTOR, player)
            return false
        elseif (msg:find('#hire gladiator') == 1) then
            spawnHireling(GLADIATOR, player)
            return false
        elseif (msg:find('#hire aura') == 1) then
            player:SendBroadcastMessage("Aura status: "..tostring(player:HasAura(HIRE_AURA)))
            return false
        elseif (msg:find('#hire dismiss') == 1) then
            dismissHireling(player)
            return false
        elseif (msg:find('#hire loc') == 1) then
            aura = player:GetAura(HIRE_AURA)
            hireling = aura:GetCaster()
            if hireling then
                x, y, z, o = hireling:GetLocation()
                player:SendBroadcastMessage("Hireling Location X:"..x.." Y:"..y.." Z:"..z.." O:"..o.." Map:"..hireling:GetMapId())
            else
                player:SendBroadcastMessage("Hireling Location: Unknown")
            end
            return false
        elseif (msg:find('#hire summon') == 1) then
            summonHireling(player)
            return false
        elseif (msg:find('#hire info') == 1) then
            aura = player:GetAura(HIRE_AURA)
            hireling = aura:GetCaster()
            player:SendBroadcastMessage("Hireling Info:")
            player:SendBroadcastMessage("  Entry: "..hireling:GetEntry())
            player:SendBroadcastMessage("  DisplayID: "..hireling:GetInt32Value(UNIT_FIELD_DISPLAYID))
            player:SendBroadcastMessage("  Level: "..hireling:GetInt32Value(UNIT_FIELD_LEVEL))
            player:SendBroadcastMessage("  Health: "..hireling:GetInt32Value(UNIT_FIELD_HEALTH))
            player:SendBroadcastMessage("  Mana: "..hireling:GetInt32Value(UNIT_FIELD_POWER1))
            player:SendBroadcastMessage("  Min Damage: "..hireling:GetFloatValue(UNIT_FIELD_MINDAMAGE))
            player:SendBroadcastMessage("  Max Damage: "..hireling:GetFloatValue(UNIT_FIELD_MAXDAMAGE))
            player:SendBroadcastMessage("  Attack Power: "..hireling:GetInt32Value(UNIT_FIELD_ATTACK_POWER))
            return false
        elseif (msg:find('#hire cast self') == 1) then
            spell = string.sub(msg, 17)
            aura = player:GetAura(HIRE_AURA)
            hireling = aura:GetCaster()
            hireling:CastSpell(hireling, spell, false)
            player:SendBroadcastMessage("Hireling Casts "..spell)
            return false
        elseif (msg:find('#hire cast me') == 1) then
            spell = string.sub(msg, 15)
            aura = player:GetAura(HIRE_AURA)
            hireling = aura:GetCaster()
            hireling:CastSpell(player, spell, false)
            player:SendBroadcastMessage("Hireling Casts "..spell)
            return false
        elseif (msg:find('#hire emote') == 1) then
            emote = string.sub(msg, 13)
            aura = player:GetAura(HIRE_AURA)
            hireling = aura:GetCaster()
            hireling:PerformEmote(emote)
            return false
        else
            player:SendBroadcastMessage("Command '#hire' help:\n#hire sword\n#hire mage\n#hire gladiator\n#hire summon\n#hire dismiss\n#hire aura\n#hire loc\n#hire info\n#hire cast me\n#hire cast self\n#hire emote")
            return false
        end
    elseif msg:find('#hire') == 1 then
        player:SendBroadcastMessage("Command '"..msg.."' does not exist")
        return false
    end
end

local function onPlayerDeath(event, killer, player)
    dismissHireling(player)
end

local function onPlayerLeaveCombat(event, player)
    aura = player:GetAura(HIRE_AURA)
    if aura then
        hireling = aura:GetCaster()
        if hireling then
            if hireling:GetEntry() == WITCHDOCTOR and (player:HealthBelowPct(HEAL_REST_THRESHOLD) or hireling:HealthBelowPct(HEAL_REST_THRESHOLD)) then
                spell = getRankedSpell("chainheal", hireling, 0)
                hireling:CastSpell(player, spell, false)
            elseif hireling:HealthBelowPct(HEAL_REST_THRESHOLD) or hireling:GetInt32Value(UNIT_FIELD_POWER1) < hireling:GetInt32Value(UNIT_FIELD_MAXPOWER1) then
                hireling:PerformEmote(RESET_EMOTE)
            end
            hireling:SetSheath(0)
            hireling:SetHealth(hireling:GetMaxHealth())
            if hireling:GetInt32Value(UNIT_FIELD_MAXPOWER1) > 0 then
                hireling:SetInt32Value(UNIT_FIELD_POWER1, hireling:GetInt32Value(UNIT_FIELD_MAXPOWER1)) -- Set mana to max
            end
            if not hireling:HasAura(PASSIVE_AURA) then
                hirelingSetFollow(hireling, player)
                player:SendBroadcastMessage("Hireling is following.")
            end
        end
    end
end

local function onPreCombat(event, hireling, target)
    if hireling:GetEntry() == WITCHDOCTOR then
        buff = getRankedSpell("watershield", hireling, 0)
    else
        buff = Buffs[hireling:GetEntry()]
    end
    if not hireling:HasAura(buff) then
        hireling:CastSpell(hireling, buff, false)
    end
end    

local function onEnterCombat(event, hireling, target)
    player = hireling:GetOwner()
    if player then
        if CheckContract(hireling, player) then
            if hireling:GetEntry() == WITCHDOCTOR then
                spell = getRankedSpell("earthshield", hireling, 0)
                if player:HasAura(spell) then
                    spell = getRankedSpell("lightningbolt", hireling, 2)
                    hireling:CastSpell(target, spell, false)
                else
                    hireling:CastSpell(player, spell, false)
                end
            else
                spell = Spells[hireling:GetDisplayId()]
                hireling:CastSpell(target, spell, true)
            end
            if math.random(1,5) == 1 then
                hireling:PlayDistanceSound(talkAttack[hireling:GetDisplayId()], player)
            end
        else
            hireling:DespawnOrUnsummon()
        end
    end
end    

local function onSpellHitTarget(event, hireling, target, spellid)
    local spell
    if hireling:IsInCombat() then
        if hireling:GetEntry() == BATTLEMAGE then
            if hireling:GetDisplayId() == BATTLEMAGE1 then
                spell = getRankedSpell("frostbolt", hireling, 0)
            elseif hireling:GetDisplayId() == BATTLEMAGE2 then
                spell = getRankedSpell("fireball", hireling, 0)
            elseif hireling:GetDisplayId() == BATTLEMAGE3 then
                spell = getRankedSpell("arcanemissiles", hireling, 0)
            elseif hireling:GetDisplayId() == BATTLEMAGE4 then
                spell = getRankedSpell("shadowbolt", hireling, 0)
            end
            hireling:CastSpell(target, spell, false)
        elseif hireling:GetEntry() == WITCHDOCTOR then
            if hireling:GetOwner():HealthBelowPct(HEAL_THRESHOLD) or hireling:HealthBelowPct(HEAL_THRESHOLD) then
                spell = getRankedSpell("chainheal", hireling, 0)
                hireling:CastSpell(hireling:GetOwner(), spell, false)
            else
                spell = getRankedSpell("lightningbolt", hireling, 2)
                hireling:CastSpell(hireling:GetAITarget(0), spell, false)
            end
        end
    end
end

local function onHitBySpell(event, hireling, caster, spellid)
    if spellid ~= 31308 then
        if not hireling:IsCasting() then
            spell = retaliateSpells[hireling:GetEntry()]
            if spell ~= 0 then
                hireling:CastSpell(hireling:GetAITarget(0), spell, false)
            end
        end
    end
end

local function onDamageTaken(event, hireling, attacker, damage)
    spell = defenseSpell[hireling:GetEntry()]
    if spell ~= 0 and not hireling:HasAura(spell) then
        hireling:CastSpell(hireling, spell, false)
    end
end

local function onReceiveEmote(event, hireling, player, emoteid)
    if player:GetGUID() == hireling:GetOwnerGUID() and hireling:GetEntry() ~= GLADIATOR then
        if emoteid == 324 then -- followme
            if player:IsMounted() then
                hirelingSetMounted(hireling, player)
            else
                hirelingSetFollow(hireling, player)
            end
        elseif emoteid == 325 then -- wait
            hirelingSetStay(hireling, player)
        elseif emoteid == 19 then -- bye
            dismissHireling(player)
        elseif emoteid == 306 then -- flee
            hirelingFlee(hireling, player)
        elseif emoteid == 21 then -- cheer
            hireling:PerformEmote(4)
        elseif emoteid == 264 then -- train
            hireling:PerformEmote(275)
        elseif emoteid == 326 then --healme
            if hireling:GetEntry() == SELLSWORD then
                hireling:SendUnitSay("Dammit, "..player:GetName()..", I'm a Sellsword, not a doctor!", 0)
            elseif hireling:GetEntry() == BATTLEMAGE then
                hireling:SendUnitSay("Do I look like a healer, "..player:GetName().."?", 0)
            elseif hireling:GetEntry() == WITCHDOCTOR then
                hireling:CastSpell(player, getRankedSpell("healingwave", hireling, 0), false)
            end
        end
    end
    if emoteid == 34 then -- dance
        hireling:PerformEmote(10)
    elseif emoteid == 5 then -- applaud
        hireling:PerformEmote(2)
    elseif (emoteid == 58 or emoteid == 78 or emoteid == 101) then -- kiss, salute, wave
        hireling:PerformEmote(66)
    elseif emoteid == 77 then -- rude
        hireling:PerformEmote(35)
    end
end

local function onRemove(event, hireling)
    player = hireling:GetOwner()
    hireling:SendUnitSay("Fair well, "..player:GetName()..".", 0)
    hireling:PerformEmote(2) -- Bow
    if CheckContract(hireling, player) then
        player:RemoveAura(HIRE_AURA)
    end
end

local function brokerOnHello(event, player, hireling)
    if player:HasAura(HIRE_AURA) then
        player:GossipSetText("What can I do for you today, "..player:GetClassAsString().."?")
        player:GossipMenuAddItem(0, "Please bring my hireling here.", 0, 20)
        player:GossipMenuAddItem(0, "Please dismiss my hireling.", 0, 21, null, "Are you sure you want to dismiss your hireling?")
        player:GossipMenuAddItem(0, "I've lost my hireling. Can you help me?", 0, 22, null, "I can cancel your contract for you. If you do find your hireling, they will no longer follow you.")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    else
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nAre you in need of assistance? Our hirelings will fight alongside you until death, or until they get bored.")
        player:GossipMenuAddItem(0, "I'd like to hire a Sellsword.", 0, 1, null, "The fee for this hireling is...", baseFees[SELLSWORD]*player:GetLevel())
        player:GossipMenuAddItem(0, "I'd like to hire a Battle Mage.", 0, 2, null, "The fee for this hireling is...", baseFees[BATTLEMAGE]*player:GetLevel())
        player:GossipMenuAddItem(0, "I'd like to hire a Witch Doctor.", 0, 3, null, "The fee for this hireling is...", baseFees[WITCHDOCTOR]*player:GetLevel())
        if raidMaps[player:GetMapId()] then
            player:GossipMenuAddItem(0, "I'd like to hire Thorngrim, the\nRelentless Gladiator.", 0, 11, null, "The fee for this hireling is...", baseFees[GLADIATOR]*player:GetLevel())
        end
        player:GossipMenuAddItem(0, "Never mind, I'll do it by myself.", 0, 0)
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
end

local function brokerOnSelect(event, player, hireling, sender, intid, code)
    if intid == 0 then
        player:GossipComplete()
    end
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
        spawnHireling(WITCHDOCTOR, player)
        player:ModifyMoney(-(baseFees[WITCHDOCTOR]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 11 then
        spawnHireling(GLADIATOR, player)
        player:ModifyMoney(-(baseFees[GLADIATOR]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 20 then
        summonHireling(player)
        player:GossipComplete()
    end
    if intid == 21 then
        dismissHireling(player)
        player:GossipComplete()
    end
    if intid == 22 then
        player:RemoveAura(HIRE_AURA)
        player:GossipComplete()
    end
end

local function hirelingOnHello(event, player, hireling)
    if player:GetGUID() == hireling:GetOwnerGUID() then
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nWhat can I do for you?")
        player:GossipMenuAddItem(0, "Follow me, there's killing to be done.", 0, 1)
        if hireling:GetEntry() ~= GLADIATOR then
            player:GossipMenuAddItem(0, "Wait here, I'll take care of this. (Passive)", 0, 2)
            player:GossipMenuAddItem(0, "Mount up and follow me, it's time to move. (Passive)", 0, 3)
            player:GossipMenuAddItem(0, "What commands do you understand?", 0, 4)
            player:GossipMenuAddItem(0, "Do you know any good jokes?", 0, 5)
        end
        player:GossipMenuAddItem(0, "You have completed your work here. I release you from your contract.", 0, 6, null, "Are you sure you want to dismiss this hireling?")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    else
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nI'm with a client right now, but you can visit any Hireling Broker to get some help!")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
end

local function hirelingOnSelect(event, player, hireling, sender, intid, code)
    if intid == 1 then -- follow
        hirelingSetFollow(hireling, player)
        player:GossipComplete()
    end
    if intid == 2 then -- stay
        hirelingSetStay(hireling, player)
        player:GossipComplete()
    end
    if intid == 3 then -- mount
        hirelingSetMounted(hireling, player)
        player:GossipComplete()
    end
    if intid == 4 then -- faq
        player:GossipSetText(faq["intro"]..faq["follow"]..faq["wait"]..faq["flee"]..faq["healme"]..faq["macros"]..faq["outro"])
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
    if intid == 5 then -- joke
        hireling:PlayDistanceSound(talkJoke[hireling:GetDisplayId()], player)
        player:GossipSetText("Have you heard that one before?")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
    if intid == 6 then -- dismiss
        dismissHireling(player)
    end
end

local function onServerStartup(event)
    CharDBExecute("DELETE FROM character_aura WHERE spell = "..HIRE_AURA)
    print("["..MODULE_NAME.."]: Cleaned Auras table.")
end

RegisterServerEvent(14, onServerStartup)

RegisterPlayerEvent(18, onChatMessage)
RegisterPlayerEvent(6, onPlayerDeath)
RegisterPlayerEvent(8, onPlayerDeath)
RegisterPlayerEvent(34, onPlayerLeaveCombat)

RegisterCreatureEvent(SELLSWORD, 10, onPreCombat)
RegisterCreatureEvent(SELLSWORD, 1, onEnterCombat)
RegisterCreatureEvent(SELLSWORD, 9, onDamageTaken)
RegisterCreatureEvent(SELLSWORD, 14, onHitBySpell)
RegisterCreatureEvent(SELLSWORD, 8, onReceiveEmote)
RegisterCreatureEvent(SELLSWORD, 37, onRemove)

RegisterCreatureEvent(BATTLEMAGE, 10, onPreCombat)
RegisterCreatureEvent(BATTLEMAGE, 1, onEnterCombat)
RegisterCreatureEvent(BATTLEMAGE, 9, onDamageTaken)
RegisterCreatureEvent(BATTLEMAGE, 15, onSpellHitTarget)
RegisterCreatureEvent(BATTLEMAGE, 14, onHitBySpell)
RegisterCreatureEvent(BATTLEMAGE, 8, onReceiveEmote)
RegisterCreatureEvent(BATTLEMAGE, 37, onRemove)

RegisterCreatureEvent(WITCHDOCTOR, 10, onPreCombat)
RegisterCreatureEvent(WITCHDOCTOR, 1, onEnterCombat)
RegisterCreatureEvent(WITCHDOCTOR, 15, onSpellHitTarget)
RegisterCreatureEvent(BATTLEMAGE, 14, onHitBySpell)
RegisterCreatureEvent(WITCHDOCTOR, 9, onDamageTaken)
RegisterCreatureEvent(WITCHDOCTOR, 8, onReceiveEmote)
RegisterCreatureEvent(WITCHDOCTOR, 37, onRemove)

RegisterCreatureEvent(GLADIATOR, 10, onPreCombat)
RegisterCreatureEvent(GLADIATOR, 1, onEnterCombat)
RegisterCreatureEvent(GLADIATOR, 14, onHitBySpell)
RegisterCreatureEvent(GLADIATOR, 9, onDamageTaken)
RegisterCreatureEvent(GLADIATOR, 8, onReceiveEmote)
RegisterCreatureEvent(GLADIATOR, 37, onRemove)

RegisterCreatureGossipEvent(SELLSWORD, 1, hirelingOnHello)
RegisterCreatureGossipEvent(SELLSWORD, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(BATTLEMAGE, 1, hirelingOnHello)
RegisterCreatureGossipEvent(BATTLEMAGE, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(WITCHDOCTOR, 1, hirelingOnHello)
RegisterCreatureGossipEvent(WITCHDOCTOR, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(GLADIATOR, 1, hirelingOnHello)
RegisterCreatureGossipEvent(GLADIATOR, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(BROKER, 1, brokerOnHello)
RegisterCreatureGossipEvent(BROKER, 2, brokerOnSelect)
