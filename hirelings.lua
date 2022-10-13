local MODULE_NAME = "Eluna hirelings"
local MODULE_VERSION = '2.5.4'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local FAIL_SOUND = 847
local HIRE_AURA = 19746
local HIRE_AURA = 62109
local PASSIVE_AURA = 31260
local HEAL_THRESHOLD = 90
local HEAL_REST_THRESHOLD = 95
local HEALTH_CRITICAL_THRESHOLD = 20
local RESET_EMOTE = 7 -- Eat
local NECROMANCER_GUARDIAN = 669030 -- Risen Foe

local BROKER = 669000

local SELLSWORD  = 669001
local SELLSWORD1 = 17214 -- Female Draenei
local SELLSWORD2 = 3054 -- Male Dwarf
local SELLSWORD3 = 1314 -- Male Orc
local SELLSWORD4 = 17671 -- Female Blood Elf

local BATTLEMAGE  = 669002
local BATTLEMAGE1 = 29869 -- Female Blood Elf
local BATTLEMAGE2 = 26073 -- Female Blood Elf
local BATTLEMAGE3 = 28160 -- Female Gnome
local BATTLEMAGE4 = 3876  -- Male Undead

local WITCHDOCTOR  = 669003
local WITCHDOCTOR1 = 11764 -- Female Troll
local WITCHDOCTOR2 = 11762 -- Male Troll
local WITCHDOCTOR3 = 0
local WITCHDOCTOR4 = 0

local NECROMANCER  = 669004
local NECROMANCER1 = 10576 -- Male Undead
local NECROMANCER2 = 7597 -- Male Undead
local NECROMANCER3 = 4056 -- Female Undead
local NECROMANCER4 = 9353 -- Male Undead

local GLADIATOR  = 669011
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
    ["wave"] = "\n\n/wave\n    If I'm nearby but can't get to your position, wave at me and I will teleport to you, unless I'm in the middle of a fight.\n    If I'm dead, waving at me will revive me, if you are not in combat.",
    ["macros"] = "\n\nYou can also use these commands in macros. Here's a sample macro:\n\n    /tar Battle Mage\n    /tar Sellsword\n    /follow\n    /targetlasttarget\n\nThis will target your hireling (of either type), issue the /follow command, and then retarget your previous target, if any.",
    ["outro"] = "\n\nP.S.: When I have been instructed not to attack anything, I will have a pulsing blue circle around me, thanks to that clever and handsome Wizard, Mykal.\n\n",
}

local hireRef = "Command '#hire' help:\n#hire sword\n#hire mage\n#hire doc\n#hire necro\n#hire gladiator\n#hire revive\n#hire summon\n#hire dismiss\n#hire abandon\n#hire aura\n#hire loc\n#hire info\n#hire cast me\n#hire cast self\n#hire emote\n#hire checkgroup"

local baseFees = {
    [SELLSWORD] = 12,
    [BATTLEMAGE] = 18,
    [WITCHDOCTOR] = 21,
    [NECROMANCER] = 25,
    [GLADIATOR] = 1000,
}

local followDistance = {
    [SELLSWORD] = 3,
    [BATTLEMAGE] = 1.2,
    [WITCHDOCTOR] = 3,
    [NECROMANCER] = 3,
    [GLADIATOR] = 3,
}

local followOrientation = {
    [SELLSWORD] = 5.7,
    [BATTLEMAGE] = 5,
    [WITCHDOCTOR] = 4,
    [NECROMANCER] = 5,
    [GLADIATOR] = 6,
}

local modMinLevelBoost = {
    [SELLSWORD] =  0,
    [BATTLEMAGE] = 1,
    [WITCHDOCTOR] = 1,
    [NECROMANCER] = 1,
    [GLADIATOR] =  3,
}

local modMaxLevelBoost = {
    [SELLSWORD] =  2,
    [BATTLEMAGE] = 3,
    [WITCHDOCTOR] = 3,
    [NECROMANCER] = 3,
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
    [BATTLEMAGE4] = 2766,
    [WITCHDOCTOR1] = 2863,
    [WITCHDOCTOR2] = 2852,
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [NECROMANCER1] = 2766,
    [NECROMANCER2] = 2766,
    [NECROMANCER3] = 2780,
    [NECROMANCER4] = 2766,
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
    [NECROMANCER1] = 6422,
    [NECROMANCER2] = 6422,
    [NECROMANCER3] = 6413,
    [NECROMANCER4] = 6422,
    [GLADIATOR1] = 6115,
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
}

local mounts = {
    [SELLSWORD1] = 14582, -- Swift Palomino
    [SELLSWORD2] = 22350, -- SWift Brewfest Ram
    [SELLSWORD3] = 2326, -- Red Wolf
    [SELLSWORD4] = 21074, -- Dark Riding Talbuk
    [BATTLEMAGE1] = 2410, -- White Riding Stallion
    [BATTLEMAGE2] = 28889, -- Sunreaver Hawkstrider
    [BATTLEMAGE3] = 14372, -- Black Battlestrider
    [BATTLEMAGE4] = 10718, -- Rivendare's Deathcharger
    [WITCHDOCTOR1] = 6469, -- Mottled Red Raptor
    [WITCHDOCTOR2] = 6469, -- Mottled Red Raptor
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [NECROMANCER1] = 28605, -- White Skeletal Warhorse
    [NECROMANCER2] = 10718, -- Black Skeletal Warhorse
    [NECROMANCER3] = 10719, -- Red Skeletal Warhorse
    [NECROMANCER4] = 29754, -- Ochre Skeletal Warhorse
    [GLADIATOR1] = 22350, -- SWift Brewfest Ram
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
}

local initSpell = { --onPlayerEnterCombat
    [SELLSWORD] = 33096, -- Threaten
    [BATTLEMAGE] = 0,
    [WITCHDOCTOR] = 8362, -- Renew (non-ranked)
    [NECROMANCER] = 0,
    [GLADIATOR] = 33096, -- Threaten
}

local openingSpell = { -- onEnterCombat
    [SELLSWORD1] = 64382, -- Shattering Throw 33096, -- Threaten --355, -- Taunt
    [SELLSWORD2] = 11578, -- Charge
    [SELLSWORD3] = 4336, -- Jump Jets
    [SELLSWORD4] = 36554, -- Shadow Step
    [BATTLEMAGE1] = 31589, -- Slow
    [BATTLEMAGE2] = 31589, -- Slow
    [BATTLEMAGE3] = 31589, -- Slow
    [BATTLEMAGE4] = 31589, -- Slow
    [WITCHDOCTOR1] = 0,
    [WITCHDOCTOR2] = 0,
    [WITCHDOCTOR3] = 0,
    [WITCHDOCTOR4] = 0,
    [NECROMANCER1] = 64153, --18270, -- Dark Plague
    [NECROMANCER2] = 64153, --18270, -- Dark Plague
    [NECROMANCER3] = 64153, --18270, -- Dark Plague
    [NECROMANCER4] = 64153, --18270, -- Dark Plague
    [GLADIATOR1] = 11578, -- Charge
    [GLADIATOR2] = 0,
    [GLADIATOR3] = 0,
    [GLADIATOR4] = 0,
}

local defenseSpell = { -- onDamageTaken
    [SELLSWORD] = 0,
    [BATTLEMAGE] = 0,
    [WITCHDOCTOR] = 586, -- Fade
    [NECROMANCER] = 34355, -- Poison Shield
    [GLADIATOR] = 33096, -- Threaten
}

local retaliateSpell = { -- onHitBySpell
    [SELLSWORD] = 61044, -- Demoralizing Shout
    [BATTLEMAGE] = 2139, -- Counterspell
    [WITCHDOCTOR] = 0, -- Not implemented
    [NECROMANCER] = 3436, -- Wandering Plague
    [GLADIATOR] = 8078, -- Thunderclap
}

local buffSpell = { -- onPreCombat
    [SELLSWORD] = 35361,   -- Thorns (non-ranked)
    [BATTLEMAGE] = 12042,  -- Arcane Power (non-ranked)
    [WITCHDOCTOR] = 0,     -- (Uses ranked spell instead)
    [NECROMANCER] = 49222, -- Bone Shield
    [GLADIATOR] = 53307,   -- Thorns (Rank 8)
}

local weapons = {
    [SELLSWORD] = 11786,   -- Stone of the Earth
    [BATTLEMAGE] = 31334,  -- Staff of Natural Fury
    [WITCHDOCTOR] = 22799, -- Soulseeker
    [NECROMANCER] = 22799, -- Soulseeker
    [GLADIATOR] = 47069,   -- Justicebringer
}

local rankedspells = {

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
    local rank = string.sub(caster:GetLevel(), 1, 1) - stepdown
    if rank < 1 then
        rank = 1
    end
    for i, v in ipairs(rankedspells) do
        if v.name==name and v.rank==tostring(rank) then
            return v.entry
        end
    end
end

local function getBaseStats(hireling)
    local entry = hireling:GetEntry()
    local class = hireling:GetClass()
    local level = hireling:GetLevel()
    local stats = {}
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

function SpawnHireling(entry, player)
    if player:HasAura(HIRE_AURA) then
        player:SendBroadcastMessage("Sorry, you already have a hireling.")
    else
        local hireling = PerformIngameSpawn(1, entry, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 4294967295, 1)
        hireling:SetCreatorGUID(player:GetGUID())
        hireling:SetOwnerGUID(player:GetGUID())
        InitHireling(hireling, player)
        hireling:SendUnitSay("Greetings, "..player:GetName()..".", 0)
        local aura = hireling:AddAura(HIRE_AURA, player)
        aura:SetMaxDuration(2147483647)
        aura:SetDuration(2147483647)
    end
end

function SpawnGuardian(entry, owner, duration)
    if not HasGuardian(owner, entry) then
        local guardian = PerformIngameSpawn(1, entry, owner:GetMapId(), owner:GetInstanceId(), owner:GetX(), owner:GetY(), owner:GetZ(), owner:GetO(), false, duration, 1)
        guardian:SetCreatorGUID(owner:GetGUID())
        guardian:SetOwnerGUID(owner:GetGUID())
        guardian:SetLevel(owner:GetLevel())
        guardian:SetFaction(35)
        local hStats = getBaseStats(guardian)
        guardian:SetMaxHealth(hStats['health'])
        guardian:SetHealth(hStats['health'])
        guardian:SetInt32Value(UNIT_FIELD_MAXPOWER1, hStats['mana']) -- Set max mana
        guardian:SetInt32Value(UNIT_FIELD_POWER1, hStats['mana']) -- Set current mana
        guardian:SetInt32Value(UNIT_FIELD_ATTACK_POWER, hStats['attackPower'])
        guardian:SetFloatValue(70, hStats['minDamage'])
        guardian:SetFloatValue(71, hStats['maxDamage'])
        guardian:SetFlag(79, 2) -- Set trackable on minimap
        guardian:MoveFollow(owner, 3, 5.7)
        guardian:SetAggroEnabled(true)
    end
end

function InitHireling(hireling, player)
    local hLevel = player:GetLevel()+math.random(modMinLevelBoost[hireling:GetEntry()],modMaxLevelBoost[hireling:GetEntry()])
    if hLevel > 80 then
        hLevel = 80
    end
    hireling:SetLevel(hLevel)
    hireling:SetFaction(35)
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
    hireling:SetEquipmentSlots(weapons[hireling:GetEntry()], 0, 0)
    hireling:SetSheath(0)
end

function SummonHireling(player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling then
            if hireling:GetMapId() == player:GetMapId() then
                x, y, z, o = player:GetLocation()
                hireling:NearTeleport( x, y, z, o )
                hireling:CastSpell(hireling, 75128, true) -- Teleport effect
                HirelingSetFollow(hireling, player)
                if hireling:GetEntry() == NECROMANCER then
                    guardian = GetGuardian(hireling, NECROMANCER_GUARDIAN)
                    if guardian then
                        guardian:NearTeleport( x, y, z, o )
                    end
                end
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

function ReviveHireling(player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling then
            if hireling:IsDead() and not player:IsInCombat() then
                x, y, z, o = hireling:GetLocation()
                hireling:Respawn()
                InitHireling(hireling, player)
                hireling:NearTeleport( x, y, z, o )
                HirelingSetFollow(hireling, player)
                hireling:CastSpell(hireling, 42704, true) -- Resurrection effect
                hireling:SendUnitSay("I live again!", 0)
                player:SendNotification("Your hireling has been revived.")
            end
        end
    end
end

function DismissHireling(player)
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

function AbandonHireling(player)
    player:RemoveAura(HIRE_AURA)
    player:SendBroadcastMessage("You have cancelled your hireling contract.")
end

function CheckContract(hireling, player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        if hireling:GetGUID() ~= aura:GetCaster():GetGUID() then
            return false
        else
            return true
        end
    else
        return false
    end
end

function HasSpecialist(player)
    if player:IsInGroup() then
        local groupPlayers = player:GetGroup():GetMembers()
        for k, v in pairs(groupPlayers) do
            if v:HasAura(HIRE_AURA) then
                if v:GetAura(HIRE_AURA):GetCaster():GetEntry() == GLADIATOR then
                    return true
                end
            end
        end
    else
        return false    
    end
end

function HasGuardian(owner, entry)
    local objects = owner:GetNearObjects(300, 0, entry, 2, 1)
    for k, v in pairs(objects) do
        if v:GetOwnerGUID() == owner:GetGUID() then
            return true
        end
    end
end

function GetGuardian(owner, entry)
    local objects = owner:GetNearObjects(300, 0, entry, 2, 1)
    for k, v in pairs(objects) do
        if v:GetOwnerGUID() == owner:GetGUID() then
            return v
        end
    end
end

function RemoveGuardians(owner, entry)
    local objects = owner:GetNearObjects(300, 0, entry, 2, 1)
    for k, v in pairs(objects) do
        if v:GetOwnerGUID() == owner:GetGUID() then
            v:DespawnOrUnsummon()
        end
    end
end

function HirelingSetFollow(hireling, player)
    if not hireling:IsDead() then
        if CheckContract(hireling, player) then
            hireling:SetAggroEnabled(true)
            hireling:RemoveAura(PASSIVE_AURA)
            hireling:SetRooted(false)
            hireling:Dismount()
            hireling:MoveExpire()
            hireling:MoveIdle()
            hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
        else
            hireling:DespawnOrUnsummon(0)
        end
    end
end

function HirelingSetStay(hireling, player)
    if not hireling:IsDead() then
        hireling:MoveExpire()
        hireling:MoveIdle()
        hireling:SetAggroEnabled(false)
        hireling:AddAura(PASSIVE_AURA, hireling)
    end
end

function HirelingSetMounted(hireling, player)
    if not hireling:IsDead() then
        hireling:SetRooted(false)
        hireling:Mount(mounts[hireling:GetDisplayId()])
        hireling:MoveExpire()
        hireling:MoveIdle()
        hireling:SetAggroEnabled(false)
        hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
        hireling:AddAura(PASSIVE_AURA, hireling)
    end
end

function HirelingSetFlee(hireling, player)
    if not hireling:IsDead() then
        hireling:SetRooted(false)
        hireling:AttackStop()
        hireling:MoveExpire()
        hireling:MoveIdle()
        hireling:SetAggroEnabled(false)
        hireling:MoveFollow(player, followDistance[hireling:GetEntry()], followOrientation[hireling:GetEntry()])
        hireling:AddAura(PASSIVE_AURA, hireling)
        hireling:CastSpell(hireling, 11305, true)
    end
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#hire') == 1) and player:GetGMRank() > 0 then
        if (msg:find('#hire sword') == 1) then
            SpawnHireling(SELLSWORD, player)
            return false
        elseif (msg:find('#hire mage') == 1) then
            SpawnHireling(BATTLEMAGE, player)
            return false
        elseif (msg:find('#hire doc') == 1) then
            SpawnHireling(WITCHDOCTOR, player)
            return false
        elseif (msg:find('#hire necro') == 1) then
            SpawnHireling(NECROMANCER, player)
            return false
        elseif (msg:find('#hire gladiator') == 1) then
            SpawnHireling(GLADIATOR, player)
            return false
        elseif (msg:find('#hire aura') == 1) then
            player:SendBroadcastMessage("Aura status: "..tostring(player:HasAura(HIRE_AURA)))
            return false
        elseif (msg:find('#hire dismiss') == 1) then
            DismissHireling(player)
            return false
        elseif (msg:find('#hire abandon') == 1) then
            AbandonHireling(player)
            return false
        elseif (msg:find('#hire loc') == 1) then
            local aura = player:GetAura(HIRE_AURA)
            local hireling = aura:GetCaster()
            if hireling then
                x, y, z, o = hireling:GetLocation()
                player:SendBroadcastMessage("Hireling Location X:"..x.." Y:"..y.." Z:"..z.." O:"..o.." Map:"..hireling:GetMapId())
            else
                player:SendBroadcastMessage("Hireling Location: Unknown")
            end
            return false
        elseif (msg:find('#hire summon') == 1) then
            SummonHireling(player)
            return false
        elseif (msg:find('#hire info') == 1) then
            local aura = player:GetAura(HIRE_AURA)
            local hireling = aura:GetCaster()
            player:SendBroadcastMessage("Hireling Info:")
            player:SendBroadcastMessage("  Entry: "..hireling:GetEntry())
            player:SendBroadcastMessage("  Owner GUID: "..tostring(hireling:GetOwnerGUID()))
            player:SendBroadcastMessage("  GUID: "..tostring(hireling:GetGUID()))
            player:SendBroadcastMessage("  DisplayID: "..hireling:GetInt32Value(UNIT_FIELD_DISPLAYID))
            player:SendBroadcastMessage("  Level: "..hireling:GetInt32Value(UNIT_FIELD_LEVEL))
            player:SendBroadcastMessage("  Health: "..hireling:GetInt32Value(UNIT_FIELD_HEALTH))
            player:SendBroadcastMessage("  Mana: "..hireling:GetInt32Value(UNIT_FIELD_POWER1))
            player:SendBroadcastMessage("  Min Damage: "..hireling:GetFloatValue(UNIT_FIELD_MINDAMAGE))
            player:SendBroadcastMessage("  Max Damage: "..hireling:GetFloatValue(UNIT_FIELD_MAXDAMAGE))
            player:SendBroadcastMessage("  Attack Power: "..hireling:GetInt32Value(UNIT_FIELD_ATTACK_POWER))
            return false
        elseif (msg:find('#hire cast self') == 1) then
            local spell = string.sub(msg, 17)
            local aura = player:GetAura(HIRE_AURA)
            local hireling = aura:GetCaster()
            hireling:CastSpell(hireling, spell, true)
            player:SendBroadcastMessage("Hireling Casts "..spell)
            return false
        elseif (msg:find('#hire cast targ') == 1) then
            local spell = string.sub(msg, 17)
            local aura = player:GetAura(HIRE_AURA)
            local hireling = aura:GetCaster()
            hireling:CastSpell(hireling:GetAITarget(0), spell, false)
            player:SendBroadcastMessage("Hireling Casts "..spell)
            return false
        elseif (msg:find('#hire cast me') == 1) then
            local spell = string.sub(msg, 15)
            local aura = player:GetAura(HIRE_AURA)
            local hireling = aura:GetCaster()
            hireling:CastSpell(player, spell, true)
            player:SendBroadcastMessage("Hireling Casts "..spell)
            return false
        elseif (msg:find('#hire emote') == 1) then
            local emote = string.sub(msg, 13)
            local aura = player:GetAura(HIRE_AURA)
            local hireling = aura:GetCaster()
            hireling:PerformEmote(emote)
            return false
        elseif (msg:find('#hire checkgroup') == 1) then
            local check = HasSpecialist(player)
            return false
        elseif (msg:find('#hire revive') == 1) then
            ReviveHireling(player)
            return false
        elseif (msg:find('#hire guard') == 1) then
            local entry = string.sub(msg, 13)
            SpawnGuardian(entry, player, 0)
            return false
        elseif (msg:find('#hire nearby') == 1) then
            local entry = string.sub(msg, 14)
            local objects = player:GetNearObjects(300, 0, entry, 2, 1)
            for k, v in pairs(objects) do
                player:SendBroadcastMessage("Unit: "..v:GetName()..", Owner: "..v:GetOwner():GetName())
            end
            return false
        else
            player:SendBroadcastMessage(hireRef)
            return false
        end
    elseif msg:find('#hire') == 1 then
        player:SendBroadcastMessage("Command '"..msg.."' does not exist")
        return false
    end
end

local function onPlayerDeath(event, killer, player)
    DismissHireling(player)
    player:RemoveAura(HIRE_AURA)
end

local function onPlayerEnterCombat(event, player, enemy)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling:CanAggro() then
            if hireling:GetEntry() ~= WITCHDOCTOR then
                hireling:AttackStart(enemy)
            end
            local spell = initSpell[hireling:GetEntry()]
            if spell ~= 0 then
                if hireling:GetEntry() == WITCHDOCTOR or hireling:GetEntry() == NECROMANCER then
                    hireling:CastSpell(player, spell, true)
                else
                    hireling:CastSpell(enemy, spell, true)
                end
            end
        end
    end
end

local function onPlayerLeaveCombat(event, player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling then
            if hireling:IsDead() then
                ReviveHireling(player)
            else
                if hireling:GetEntry() == WITCHDOCTOR and (player:HealthBelowPct(HEAL_REST_THRESHOLD) or hireling:HealthBelowPct(HEAL_REST_THRESHOLD)) then
                    local spell = getRankedSpell("chainheal", hireling, 0)
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
                    HirelingSetFollow(hireling, player)
                end
            end
        end
    end
end

local function onPlayerKillCreature(event, killer, killed)
    if killed:GetCreatureFamily() == 0 then
        local aura = killer:GetAura(HIRE_AURA)
        if aura then
            local hireling = aura:GetCaster()
            if hireling then
                if hireling:GetEntry() == NECROMANCER then
                    SpawnGuardian(NECROMANCER_GUARDIAN, hireling, 0)
                end
            end
        end
    end
end

local function onPreCombat(event, hireling, target)
    local buff
    if hireling:GetEntry() == WITCHDOCTOR then
        buff = getRankedSpell("watershield", hireling, 0)
    else
        buff = buffSpell[hireling:GetEntry()]
    end
    if not hireling:HasAura(buff) then
        hireling:CastSpell(hireling, buff, false)
    end
end    

local function onEnterCombat(event, hireling, target)
    local player = hireling:GetOwner()
    local spell
    if player then
        if CheckContract(hireling, player) then
            if hireling:CanAggro() then
                if hireling:GetEntry() == WITCHDOCTOR then
                    spell = getRankedSpell("earthshield", hireling, 0)
                    if player:HasAura(spell) then
                        spell = getRankedSpell("lightningbolt", hireling, 2)
                        hireling:CastSpell(target, spell, false)
                    else
                        hireling:CastSpell(player, spell, false)
                    end
                else
                    spell = openingSpell[hireling:GetDisplayId()]
                    hireling:CastSpell(target, spell, true)
                end
                if math.random(1,5) == 1 then
                    hireling:PlayDistanceSound(talkAttack[hireling:GetDisplayId()], player)
                end
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
            hireling:SetRooted(true)
            if hireling:GetOwner():HealthBelowPct(HEAL_THRESHOLD) then
                spell = getRankedSpell("chainheal", hireling, 0)
                hireling:CastSpell(hireling:GetOwner(), spell, false)
            elseif hireling:HealthBelowPct(HEAL_THRESHOLD - 20) then
                spell = getRankedSpell("healingwave", hireling, 0)
                hireling:CastSpell(hireling, spell, false)
            else
                spell = getRankedSpell("lightningbolt", hireling, 2)
                hireling:CastSpell(hireling:GetAITarget(0), spell, false)
            end
        end
    end
end

local function onHitBySpell(event, hireling, caster, spellid)
    if spellid ~= 31308 and caster:GetGUID() ~= hireling:GetOwnerGUID() then
        if not hireling:IsCasting() then
            local spell = retaliateSpell[hireling:GetEntry()]
            if spell ~= 0 then
                hireling:CastSpell(hireling:GetAITarget(0), spell, false)
            end
        end
    end
end

local function onDamageTaken(event, hireling, attacker, damage)
    local spell = defenseSpell[hireling:GetEntry()]
    if spell ~= 0 and not hireling:HasAura(spell) then
        if hireling:GetEntry() == GLADIATOR then
            hireling:CastSpell(attacker, spell, false)
        else
            hireling:CastSpell(hireling, spell, false)
        end
    end
end

local function onReceiveEmote(event, hireling, player, emoteid)
    if player:GetGUID() == hireling:GetOwnerGUID() then
        if emoteid == 324 then -- followme
            if player:IsMounted() then
                HirelingSetMounted(hireling, player)
            else
                HirelingSetFollow(hireling, player)
            end
        elseif emoteid == 325 then -- wait
            HirelingSetStay(hireling, player)
        elseif emoteid == 19 then -- bye
            DismissHireling(player)
        elseif emoteid == 306 then -- flee
            HirelingSetFlee(hireling, player)
        elseif emoteid == 21 then -- cheer
            hireling:PerformEmote(4)
        elseif emoteid == 264 then -- train
            hireling:PerformEmote(275)
        elseif emoteid == 326 then --healme
            if hireling:GetEntry() == SELLSWORD then
                hireling:SendUnitSay("Dammit, "..player:GetName()..", I'm a Sellsword, not a doctor!", 0)
            elseif hireling:GetEntry() == BATTLEMAGE or hireling:GetEntry() == GLADIATOR then
                hireling:SendUnitSay("Do I look like a healer, "..player:GetName().."?", 0)
            elseif hireling:GetEntry() == WITCHDOCTOR then
                hireling:CastSpell(player, getRankedSpell("chainheal", hireling, 0), false)
            elseif hireling:GetEntry() == NECROMANCER then
                hireling:SendUnitSay("Ask me again after you're dead.", 0)
            end
        elseif emoteid == 101 and not hireling:IsInCombat() then -- wave
            if hireling:IsDead() then
                ReviveHireling(player)
            else
                SummonHireling(player)
            end
        end
    end
    if emoteid == 34 then -- dance
        hireling:PerformEmote(10)
    elseif emoteid == 5 then -- applaud
        hireling:PerformEmote(2)
    elseif emoteid == 58 or emoteid == 78 then -- kiss, salute
        hireling:PerformEmote(66)
    elseif emoteid == 77 then -- rude
        hireling:PerformEmote(35)
    end
end

local function onLeaveCombat(event, hireling)
    if hireling:GetEntry() == WITCHDOCTOR and (hireling:GetOwner():HealthBelowPct(HEAL_REST_THRESHOLD) or hireling:HealthBelowPct(HEAL_REST_THRESHOLD)) then
        local spell = getRankedSpell("chainheal", hireling, 0)
        hireling:CastSpell(player, spell, false)
    end
    hireling:SetRooted(false)
end

local function onDeath(event, hireling, killer)
    hireling:GetOwner():SendNotification("Your hireling has perished.")
    hireling:PlayDirectSound(2544, hireling:GetOwner())
    hireling:SendUnitSay("I die... with... honor...", 0)
end

local function onRemove(event, hireling)
    local player = hireling:GetOwner()
    if not hireling:IsDead() then
        hireling:SendUnitSay("Fair well, "..player:GetName()..".", 0)
        hireling:PerformEmote(2) -- Bow
    end
    if CheckContract(hireling, player) then
        player:RemoveAura(HIRE_AURA)
    end
    if hireling:GetEntry() == NECROMANCER then
        RemoveGuardians(hireling, NECROMANCER_GUARDIAN)
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
        player:GossipMenuAddItem(0, "I'd like to hire a Necromancer.", 0, 4, null, "The fee for this hireling is...", baseFees[NECROMANCER]*player:GetLevel())
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
        SpawnHireling(SELLSWORD, player)
        player:ModifyMoney(-(baseFees[SELLSWORD]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 2 then
        SpawnHireling(BATTLEMAGE, player)
        player:ModifyMoney(-(baseFees[BATTLEMAGE]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 3 then
        SpawnHireling(WITCHDOCTOR, player)
        player:ModifyMoney(-(baseFees[WITCHDOCTOR]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 4 then
        SpawnHireling(NECROMANCER, player)
        player:ModifyMoney(-(baseFees[NECROMANCER]*player:GetLevel()))
        player:GossipComplete()
    end
    if intid == 11 then
        if not HasSpecialist(player) then
            SpawnHireling(GLADIATOR, player)
            player:ModifyMoney(-(baseFees[GLADIATOR]*player:GetLevel()))
        else
            player:SendBroadcastMessage("Thorngrim is already in your party.")
        end
        player:GossipComplete()
    end
    if intid == 20 then
        SummonHireling(player)
        player:GossipComplete()
    end
    if intid == 21 then
        DismissHireling(player)
        player:GossipComplete()
    end
    if intid == 22 then
        AbandonHireling(player)
        player:GossipComplete()
    end
end

local function hirelingOnHello(event, player, hireling)
    if CheckContract(hireling, player) then
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nWhat can I do for you?")
        player:GossipMenuAddItem(0, "Follow me, there's killing to be done.", 0, 1)
        player:GossipMenuAddItem(0, "Wait here, I'll take care of this. (Passive)", 0, 2)
        player:GossipMenuAddItem(0, "Mount up and follow me, it's time to move. (Passive)", 0, 3)
        player:GossipMenuAddItem(0, "What commands do you understand?", 0, 4)
            if hireling:GetEntry() ~= GLADIATOR then
            player:GossipMenuAddItem(0, "Do you know any good jokes?", 0, 5)
            if hireling:GetDisplayId() == SELLSWORD2 then
                player:GossipMenuAddItem(0, "May I have some ale, please?", 0, 9)
            end
        end
        player:GossipMenuAddItem(0, "You have completed your work here. I release you from your contract.", 0, 10, null, "Are you sure you want to dismiss this hireling?")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    else
        player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nI'm with a client right now, but you can visit any Hireling Broker to get some help!")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
end

local function hirelingOnSelect(event, player, hireling, sender, intid, code)
    if intid == 1 then -- follow
        HirelingSetFollow(hireling, player)
        player:GossipComplete()
    end
    if intid == 2 then -- stay
        HirelingSetStay(hireling, player)
        player:GossipComplete()
    end
    if intid == 3 then -- mount
        HirelingSetMounted(hireling, player)
        player:GossipComplete()
    end
    if intid == 4 then -- faq
        player:GossipSetText(faq["intro"]..faq["follow"]..faq["wait"]..faq["flee"]..faq["healme"]..faq["wave"]..faq["macros"]..faq["outro"])
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
    if intid == 5 then -- joke
        hireling:PlayDistanceSound(talkJoke[hireling:GetDisplayId()], player)
        player:GossipSetText("Have you heard that one before?")
        player:GossipSendMenu(0x7FFFFFFF, hireling)
    end
    if intid == 9 then -- ale
        player:AddItem(2686) -- Thunder Ale
        hireling:SendUnitSay("Enjoy!",0)
        player:GossipComplete()
    end
    if intid == 10 then -- dismiss
        DismissHireling(player)
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
RegisterPlayerEvent(33, onPlayerEnterCombat)
RegisterPlayerEvent(34, onPlayerLeaveCombat)
RegisterPlayerEvent(7, onPlayerKillCreature)

RegisterCreatureEvent(SELLSWORD, 10, onPreCombat)
RegisterCreatureEvent(SELLSWORD, 1, onEnterCombat)
RegisterCreatureEvent(SELLSWORD, 9, onDamageTaken)
RegisterCreatureEvent(SELLSWORD, 14, onHitBySpell)
RegisterCreatureEvent(SELLSWORD, 8, onReceiveEmote)
RegisterCreatureEvent(SELLSWORD, 2, onLeaveCombat)
RegisterCreatureEvent(SELLSWORD, 4, onDeath)
RegisterCreatureEvent(SELLSWORD, 37, onRemove)

RegisterCreatureEvent(BATTLEMAGE, 10, onPreCombat)
RegisterCreatureEvent(BATTLEMAGE, 1, onEnterCombat)
RegisterCreatureEvent(BATTLEMAGE, 9, onDamageTaken)
RegisterCreatureEvent(BATTLEMAGE, 15, onSpellHitTarget)
RegisterCreatureEvent(BATTLEMAGE, 14, onHitBySpell)
RegisterCreatureEvent(BATTLEMAGE, 8, onReceiveEmote)
RegisterCreatureEvent(BATTLEMAGE, 2, onLeaveCombat)
RegisterCreatureEvent(BATTLEMAGE, 4, onDeath)
RegisterCreatureEvent(BATTLEMAGE, 37, onRemove)

RegisterCreatureEvent(WITCHDOCTOR, 10, onPreCombat)
RegisterCreatureEvent(WITCHDOCTOR, 1, onEnterCombat)
RegisterCreatureEvent(WITCHDOCTOR, 15, onSpellHitTarget)
RegisterCreatureEvent(WITCHDOCTOR, 14, onHitBySpell)
RegisterCreatureEvent(WITCHDOCTOR, 9, onDamageTaken)
RegisterCreatureEvent(WITCHDOCTOR, 8, onReceiveEmote)
RegisterCreatureEvent(WITCHDOCTOR, 2, onLeaveCombat)
RegisterCreatureEvent(WITCHDOCTOR, 4, onDeath)
RegisterCreatureEvent(WITCHDOCTOR, 37, onRemove)

RegisterCreatureEvent(NECROMANCER, 10, onPreCombat)
RegisterCreatureEvent(NECROMANCER, 1, onEnterCombat)
RegisterCreatureEvent(NECROMANCER, 9, onDamageTaken)
RegisterCreatureEvent(NECROMANCER, 15, onSpellHitTarget)
RegisterCreatureEvent(NECROMANCER, 14, onHitBySpell)
RegisterCreatureEvent(NECROMANCER, 9, onDamageTaken)
RegisterCreatureEvent(NECROMANCER, 8, onReceiveEmote)
RegisterCreatureEvent(NECROMANCER, 2, onLeaveCombat)
RegisterCreatureEvent(NECROMANCER, 4, onDeath)
RegisterCreatureEvent(NECROMANCER, 37, onRemove)

RegisterCreatureEvent(GLADIATOR, 10, onPreCombat)
RegisterCreatureEvent(GLADIATOR, 1, onEnterCombat)
RegisterCreatureEvent(GLADIATOR, 14, onHitBySpell)
RegisterCreatureEvent(GLADIATOR, 9, onDamageTaken)
RegisterCreatureEvent(GLADIATOR, 8, onReceiveEmote)
RegisterCreatureEvent(GLADIATOR, 2, onLeaveCombat)
RegisterCreatureEvent(GLADIATOR, 4, onDeath)
RegisterCreatureEvent(GLADIATOR, 37, onRemove)

RegisterCreatureGossipEvent(SELLSWORD, 1, hirelingOnHello)
RegisterCreatureGossipEvent(SELLSWORD, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(BATTLEMAGE, 1, hirelingOnHello)
RegisterCreatureGossipEvent(BATTLEMAGE, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(WITCHDOCTOR, 1, hirelingOnHello)
RegisterCreatureGossipEvent(WITCHDOCTOR, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(NECROMANCER, 1, hirelingOnHello)
RegisterCreatureGossipEvent(NECROMANCER, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(GLADIATOR, 1, hirelingOnHello)
RegisterCreatureGossipEvent(GLADIATOR, 2, hirelingOnSelect)

RegisterCreatureGossipEvent(BROKER, 1, brokerOnHello)
RegisterCreatureGossipEvent(BROKER, 2, brokerOnSelect)
