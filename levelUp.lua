local MODULE_NAME = "Eluna levelUp"
local MODULE_VERSION = '1.2'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Gold = {
    [20] = 100000,
    [40] = 1000000,
    [60] = 10000000,
    [80] = 100000000,
}

local Pets = {
    [1]  = 13582, -- Zergling
    [2]  = 13584, -- Mini Diablo
    [3]  = 25535, -- Netherwhelp
    [4]  = 39656, -- Mini Tyrael
    [5]  = 46767, -- Warbot
    [6]  = 46892, -- Murkimus the Gladiator
    [7]  = 49646, -- Core Hound Pup
    [8]  = 49693, -- Lil' K.T.
    [9]  = 54857, -- Murkimus the Gladiator
    [10] = 49663, -- Wind Rider Cub
    [11] = 48527, -- Onyx Panther
    [12] = 54847, -- Lil' XT
    [13] = 34955, -- Scorched Stone
    [14] = 39286, -- Frosty
    [15] = 41133, -- Mr. Chilly
    [16] = 43517, -- Pengu
    [17] = 49662, -- Gryphon Hatchling
    [18] = 49665, -- Pandaren Monk
    [19] = 39973, -- Ghostly Skull
    [20] = 35504, -- Phoenix Hatchling
}
print("["..MODULE_NAME.."]: # of Pets: "..#Pets)

local Titles = {
    [1]  = 143,   -- Jenkins
    [2]  = 155,   -- the Noble
    [3]  = 134,   -- the Merrymaker
    [4]  =  22,   -- Legionnaire
    [5]  = 125,   -- Loremaster
    [6]  = 172,   -- the Patient
    [7]  =  27,   -- Warlord
    [8]  =  43,   -- Duelist
    [9]  =  76,   -- Flame Keeper
    [10] =  11,   -- Commander
    [11] = 174,   -- Bane of the Fallen King
    [12] =  47,   -- Conqueror
    [13] = 127,   -- of the Horde
    [14] = 145,   -- the Insane
    [15] =   9,   -- Knight-Champion
    [16] =  77,   -- the Exalted
    [17] = 158,   -- Death's Demise
    [18] = 124,   -- the Hallowed
    [19] =  83,   -- Salty
    [20] = 154,   -- of the Undercity
}
print("["..MODULE_NAME.."]: # of Titles: "..#Titles)

local Gear = {
    -- Druid
    {class = 1024, level = 20, item = 1, entry = 30419},
    {class = 1024, level = 20, item = 2, entry = 20428},
    {class = 1024, level = 20, item = 3, entry = 10410},
    {class = 1024, level = 20, item = 4, entry = 10412},
    {class = 1024, level = 20, item = 5, entry = 10413},
    {class = 1024, level = 20, item = 6, entry = 10411},
    {class = 1024, level = 20, item = 7, entry = 12999},

    {class = 1024, level = 40, item = 1, entry = 8345},
    {class = 1024, level = 40, item = 2, entry = 10776},
    {class = 1024, level = 40, item = 3, entry = 1718},
    {class = 1024, level = 40, item = 4, entry = 20104},
    {class = 1024, level = 40, item = 5, entry = 10765},
    {class = 1024, level = 40, item = 6, entry = 20101},
    {class = 1024, level = 40, item = 7, entry = 19590},

    {class = 1024, level = 60, item = 1, entry = 16834},
    {class = 1024, level = 60, item = 2, entry = 21409},
    {class = 1024, level = 60, item = 3, entry = 16835},
    {class = 1024, level = 60, item = 4, entry = 16828},
    {class = 1024, level = 60, item = 5, entry = 16831},
    {class = 1024, level = 60, item = 6, entry = 16829},
    {class = 1024, level = 60, item = 7, entry = 16830},

    -- Hunter
    {class = 4, level = 20, item = 1, entry = 30419},
    {class = 4, level = 20, item = 2, entry = 5193},
    {class = 4, level = 20, item = 3, entry = 10410},
    {class = 4, level = 20, item = 4, entry = 6468},
    {class = 4, level = 20, item = 5, entry = 7348},
    {class = 4, level = 20, item = 6, entry = 1121},
    {class = 4, level = 20, item = 7, entry = 4794},

    {class = 4, level = 40, item = 1, entry = 1624},
    {class = 4, level = 40, item = 2, entry = 13121},
    {class = 4, level = 40, item = 3, entry = 9396},
    {class = 4, level = 40, item = 4, entry = 20089},
    {class = 4, level = 40, item = 5, entry = 8347},
    {class = 4, level = 40, item = 6, entry = 20092},
    {class = 4, level = 40, item = 7, entry = 19584},

    {class = 4, level = 60, item = 1, entry = 16846},
    {class = 4, level = 60, item = 2, entry = 21403},
    {class = 4, level = 60, item = 3, entry = 16847},
    {class = 4, level = 60, item = 4, entry = 16851},
    {class = 4, level = 60, item = 5, entry = 16852},
    {class = 4, level = 60, item = 6, entry = 16849},
    {class = 4, level = 60, item = 7, entry = 16850},

    -- Mage
    {class = 128, level = 20, item = 1, entry = 30419},
    {class = 128, level = 20, item = 2, entry = 12979},
    {class = 128, level = 20, item = 3, entry = 12987},
    {class = 128, level = 20, item = 4, entry = 2911},
    {class = 128, level = 20, item = 5, entry = 12977},
    {class = 128, level = 20, item = 6, entry = 4320},
    {class = 128, level = 20, item = 7, entry = 14375},

    {class = 128, level = 40, item = 1, entry = 7720},
    {class = 128, level = 40, item = 2, entry = 23178},
    {class = 128, level = 40, item = 3, entry = 9407},
    {class = 128, level = 40, item = 4, entry = 20098},
    {class = 128, level = 40, item = 5, entry = 10019},
    {class = 128, level = 40, item = 6, entry = 20095},
    {class = 128, level = 40, item = 7, entry = 19597},

    {class = 128, level = 60, item = 1, entry = 16795},
    {class = 128, level = 60, item = 2, entry = 21415},
    {class = 128, level = 60, item = 3, entry = 16796},
    {class = 128, level = 60, item = 4, entry = 16802},
    {class = 128, level = 60, item = 5, entry = 16801},
    {class = 128, level = 60, item = 6, entry = 16800},
    {class = 128, level = 60, item = 7, entry = 16799},

    -- Paladin
    {class = 2, level = 20, item = 1, entry = 30419},
    {class = 2, level = 20, item = 2, entry = 20428},
    {class = 2, level = 20, item = 3, entry = 6087},
    {class = 2, level = 20, item = 4, entry = 12978},
    {class = 2, level = 20, item = 5, entry = 12994},
    {class = 2, level = 20, item = 6, entry = 12982},
    {class = 2, level = 20, item = 7, entry = 2868},

    {class = 2, level = 40, item = 1, entry = 10763},
    {class = 2, level = 40, item = 2, entry = 10776},
    {class = 2, level = 40, item = 3, entry = 33258},
    {class = 2, level = 40, item = 4, entry = 20107},
    {class = 2, level = 40, item = 5, entry = 7938},
    {class = 2, level = 40, item = 6, entry = 20110},
    {class = 2, level = 40, item = 7, entry = 19581},

    {class = 2, level = 60, item = 1, entry = 16854},
    {class = 2, level = 60, item = 2, entry = 21397},
    {class = 2, level = 60, item = 3, entry = 16855},
    {class = 2, level = 60, item = 4, entry = 16858},
    {class = 2, level = 60, item = 5, entry = 16860},
    {class = 2, level = 60, item = 6, entry = 16859},
    {class = 2, level = 60, item = 7, entry = 16857},

    -- Priest
    {class = 16, level = 20, item = 1, entry = 30419},
    {class = 16, level = 20, item = 2, entry = 20428},
    {class = 16, level = 20, item = 3, entry = 23173},
    {class = 16, level = 20, item = 4, entry = 2911},
    {class = 16, level = 20, item = 5, entry = 12977},
    {class = 16, level = 20, item = 6, entry = 4320},
    {class = 16, level = 20, item = 7, entry = 14375},

    {class = 16, level = 40, item = 1, entry = 20969},
    {class = 16, level = 40, item = 2, entry = 19532},
    {class = 16, level = 40, item = 3, entry = 7709},
    {class = 16, level = 40, item = 4, entry = 20098},
    {class = 16, level = 40, item = 5, entry = 10019},
    {class = 16, level = 40, item = 6, entry = 20095},
    {class = 16, level = 40, item = 7, entry = 19597},

    {class = 16, level = 60, item = 1, entry = 16813},
    {class = 16, level = 60, item = 2, entry = 21412},
    {class = 16, level = 60, item = 3, entry = 16814},
    {class = 16, level = 60, item = 4, entry = 16817},
    {class = 16, level = 60, item = 5, entry = 16812},
    {class = 16, level = 60, item = 6, entry = 16811},
    {class = 16, level = 60, item = 7, entry = 16819},

    -- Rogue
    {class = 8, level = 20, item = 1, entry = 30419},
    {class = 8, level = 20, item = 2, entry = 5193},
    {class = 8, level = 20, item = 3, entry = 10410},
    {class = 8, level = 20, item = 4, entry = 6468},
    {class = 8, level = 20, item = 5, entry = 14572},
    {class = 8, level = 20, item = 6, entry = 1121},
    {class = 8, level = 20, item = 7, entry = 4794},

    {class = 8, level = 40, item = 1, entry = 8176},
    {class = 8, level = 40, item = 2, entry = 13121},
    {class = 8, level = 40, item = 3, entry = 9414},
    {class = 8, level = 40, item = 4, entry = 20116},
    {class = 8, level = 40, item = 5, entry = 34417},
    {class = 8, level = 40, item = 6, entry = 20113},
    {class = 8, level = 40, item = 7, entry = 19590},

    {class = 8, level = 60, item = 1, entry = 16821},
    {class = 8, level = 60, item = 2, entry = 21406},
    {class = 8, level = 60, item = 3, entry = 16822},
    {class = 8, level = 60, item = 4, entry = 16827},
    {class = 8, level = 60, item = 5, entry = 16826},
    {class = 8, level = 60, item = 6, entry = 16824},
    {class = 8, level = 60, item = 7, entry = 16825},

    -- Shaman
    {class = 64, level = 20, item = 1, entry = 30419},
    {class = 64, level = 20, item = 2, entry = 20428},
    {class = 64, level = 20, item = 3, entry = 10410},
    {class = 64, level = 20, item = 4, entry = 10412},
    {class = 64, level = 20, item = 5, entry = 10413},
    {class = 64, level = 20, item = 6, entry = 10411},
    {class = 64, level = 20, item = 7, entry = 12999},

    {class = 64, level = 40, item = 1, entry = 4080},
    {class = 64, level = 40, item = 2, entry = 10776},
    {class = 64, level = 40, item = 3, entry = 9396},
    {class = 64, level = 40, item = 4, entry = 20119},
    {class = 64, level = 40, item = 5, entry = 8347},
    {class = 64, level = 40, item = 6, entry = 20122},
    {class = 64, level = 40, item = 7, entry = 19584},

    {class = 64, level = 60, item = 1, entry = 16842},
    {class = 64, level = 60, item = 2, entry = 21400},
    {class = 64, level = 60, item = 3, entry = 16843},
    {class = 64, level = 60, item = 4, entry = 16838},
    {class = 64, level = 60, item = 5, entry = 16839},
    {class = 64, level = 60, item = 6, entry = 16837},
    {class = 64, level = 60, item = 7, entry = 16840},

    -- Warlock
    {class = 256, level = 20, item = 1, entry = 30419},
    {class = 256, level = 20, item = 2, entry = 12979},
    {class = 256, level = 20, item = 3, entry = 23173},
    {class = 256, level = 20, item = 4, entry = 2911},
    {class = 256, level = 20, item = 5, entry = 12977},
    {class = 256, level = 20, item = 6, entry = 4320},
    {class = 256, level = 20, item = 7, entry = 14375},

    {class = 256, level = 40, item = 1, entry = 9429},
    {class = 256, level = 40, item = 2, entry = 10776},
    {class = 256, level = 40, item = 3, entry = 2277},
    {class = 256, level = 40, item = 4, entry = 20098},
    {class = 256, level = 40, item = 5, entry = 10019},
    {class = 256, level = 40, item = 6, entry = 20095},
    {class = 256, level = 40, item = 7, entry = 19597},

    {class = 256, level = 60, item = 1, entry = 16808},
    {class = 256, level = 60, item = 2, entry = 21418},
    {class = 256, level = 60, item = 3, entry = 16810},
    {class = 256, level = 60, item = 4, entry = 16806},
    {class = 256, level = 60, item = 5, entry = 16805},
    {class = 256, level = 60, item = 6, entry = 16803},
    {class = 256, level = 60, item = 7, entry = 16804},

    -- Warrior
    {class = 1, level = 20, item = 1, entry = 30419},
    {class = 1, level = 20, item = 2, entry = 5193},
    {class = 1, level = 20, item = 3, entry = 6087},
    {class = 1, level = 20, item = 4, entry = 12978},
    {class = 1, level = 20, item = 5, entry = 12994},
    {class = 1, level = 20, item = 6, entry = 12982},
    {class = 1, level = 20, item = 7, entry = 2868},

    {class = 1, level = 40, item = 1, entry = 10763},
    {class = 1, level = 40, item = 2, entry = 13121},
    {class = 1, level = 40, item = 3, entry = 7921},
    {class = 1, level = 40, item = 4, entry = 20125},
    {class = 1, level = 40, item = 5, entry = 7938},
    {class = 1, level = 40, item = 6, entry = 20128},
    {class = 1, level = 40, item = 7, entry = 19581},

    {class = 1, level = 60, item = 1, entry = 16866},
    {class = 1, level = 60, item = 2, entry = 21394},
    {class = 1, level = 60, item = 3, entry = 16867},
    {class = 1, level = 60, item = 4, entry = 16864},
    {class = 1, level = 60, item = 5, entry = 16863},
    {class = 1, level = 60, item = 6, entry = 16862},
    {class = 1, level = 60, item = 7, entry = 16861},
}

function findGear(class, level, item)
    for i, v in ipairs(Gear) do
        if v.class==class and v.level==level and v.item==item then
            return v.entry
        end
    end
end

function levelCheck(event, player, oldLevel)
    class = player:GetClassMask()
    level = player:GetLevel()
    print("["..MODULE_NAME.."]: Level: "..level.." Class: "..class)
    if (level==20 or level==40 or level==60) and class ~= 32 then
        player:SendNotification("Congrats on Level "..level.."!")
        player:PlayDirectSound(8572)
        randomPet = math.random(1,#Pets)
        randomTitle = math.random(1,#Titles)
        player:SetKnownTitle(Titles[randomTitle])
        SendMail(
            "Congrats!", "Congratulations on reaching level "..level..", "..player:GetName().."! Here are some tokens of our appreciation!",
            player:GetGUIDLow(),
            0,
            61,
            0,
            Gold[level],
            0,
            Pets[randomPet],
            1,
            findGear(class,level,1),
            1,
            findGear(class,level,2),
            1,
            findGear(class,level,3),
            1,
            findGear(class,level,4),
            1,
            findGear(class,level,5),
            1,
            findGear(class,level,6),
            1,
            findGear(class,level,7),
            1
        )
    end
end

RegisterPlayerEvent(13, levelCheck)
