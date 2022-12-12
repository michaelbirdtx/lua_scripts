local MODULE_NAME = "Eluna magicSlate"
local MODULE_VERSION = '1.0.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

SLATE_ENTRY = 25750

local Songs = {
    [1]  = 11812,
    [2]  = 11811,
    [3]  = 12135,
    [4]  = 12319,
    [5]  = 12325,
    [6]  = 12828,
    [7]  = 15925,
    [8]  = 17280,
    [9]  = 17487,
    [10] = 17346,
    [11] = 11729,
    [12] = 15885,
}

local function randomSong()
    local song = math.random(1,#Songs)
    return song
end

local function randomDelay(maxMinutes)
    delay = math.random(1,maxMinutes) * 60
    return delay
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#magicbank') == 1) and player:GetGMRank() > 0 then
        player:SendShowBank(player)
        return false
    end
    if (msg:find('#magicmail') == 1) and player:GetGMRank() > 0 then
        player:SendShowMailBox(player:GetGUID())
        return false
    end
    if (msg:find('#magicmusic') == 1) and player:GetGMRank() > 0 then
        player:PlayDirectSound(randomSong(), player)
        return false
    end
end

local function onHelloMagicSlate(event, player, object)
    player:GossipClearMenu()
    player:GossipSetText("\"Hey Magic Slate, I would like to...\"")
    player:GossipMenuAddItem(6, "\"...access my bank.\"", 1, 1)
    player:GossipMenuAddItem(7, "\"...read my mail.\"", 1, 2)
    player:GossipMenuAddItem(4, "\"...listen to some music.\"", 1, 3)
    player:GossipMenuAddItem(2, "\"...order some more of The Stuff!\"", 1, 4)
    player:GossipSendMenu(0x7FFFFFFF, player, SLATE_ENTRY)
end

local function onSelectMagicSlate(event, player, object, sender, intid, code, menu_id)
    player:GossipComplete()
    if intid == 1 then
        player:SendShowBank(player)
    elseif intid == 2 then
        player:SendShowMailBox(player:GetGUID())
    elseif intid == 3 then
        local randomSong = math.random(1,#Songs)
        player:PlayDirectSound(Songs[randomSong], player)
        player:SendBroadcastMessage("A song that only you can hear begins playing...")
    elseif intid == 4 then
        SendMail(
            "Thank you for your order!",
            "",
            player:GetGUIDLow(),
            0,
            61,
            randomDelay(3), -- Delay
            0,
            100, -- COD
            23364,
            1000
        )
        player:SendBroadcastMessage("Your order of The Stuff is being prepared, and will arrive in your mailbox in just a few minutes.")
    end
end

RegisterPlayerEvent(18, onChatMessage)
RegisterItemGossipEvent(SLATE_ENTRY, 1, onHelloMagicSlate)
RegisterPlayerGossipEvent(SLATE_ENTRY, 2, onSelectMagicSlate)