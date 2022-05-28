--[[
1.1
dressMe Transmog Backend for WotLK (requires modified DressMe AddOn)
by Shermer

Based on Transmogrification for Classic & TBC & WotLK - Gossip Menu
by Rochet2

]]

local copperCost                    = 1
local EQUIPMENT_SLOT_START          = 0
local EQUIPMENT_SLOT_HEAD           = 0
local EQUIPMENT_SLOT_NECK           = 1
local EQUIPMENT_SLOT_SHOULDERS      = 2
local EQUIPMENT_SLOT_BODY           = 3
local EQUIPMENT_SLOT_CHEST          = 4
local EQUIPMENT_SLOT_WAIST          = 5
local EQUIPMENT_SLOT_LEGS           = 6
local EQUIPMENT_SLOT_FEET           = 7
local EQUIPMENT_SLOT_WRISTS         = 8
local EQUIPMENT_SLOT_HANDS          = 9
local EQUIPMENT_SLOT_FINGER1        = 10
local EQUIPMENT_SLOT_FINGER2        = 11
local EQUIPMENT_SLOT_TRINKET1       = 12
local EQUIPMENT_SLOT_TRINKET2       = 13
local EQUIPMENT_SLOT_BACK           = 14
local EQUIPMENT_SLOT_MAINHAND       = 15
local EQUIPMENT_SLOT_OFFHAND        = 16
local EQUIPMENT_SLOT_RANGED         = 17
local EQUIPMENT_SLOT_TABARD         = 18
local EQUIPMENT_SLOT_END            = 19
local INVENTORY_SLOT_BAG_0          = 255
local PLAYER_VISIBLE_ITEM_1_ENTRYID = 283
local ITEM_SLOT_MULTIPLIER          = 2
local entryMap                      = {}
local dataMap                       = {}

print("[Eluna dressMe]: Loaded")

local function GetFakeEntry(item)
    local guid = item and item:GetGUIDLow()
    if guid and dataMap[guid] then
        if entryMap[dataMap[guid]] then
            return entryMap[dataMap[guid]][guid]
        end
    end
end

local function LoadPlayer(player)
    local playerGUID = player:GetGUIDLow()
    entryMap[playerGUID] = {}
    local result = CharDBQuery("SELECT GUID, FakeEntry FROM eluna_transmog WHERE Owner = "..playerGUID)
    if result then
        repeat
            local itemGUID = result:GetUInt32(0)
            local fakeEntry = result:GetUInt32(1)
            dataMap[itemGUID] = playerGUID
            entryMap[playerGUID][itemGUID] = fakeEntry
        until not result:NextRow()

        for slot = EQUIPMENT_SLOT_START, EQUIPMENT_SLOT_END-1 do
            local item = player:GetItemByPos(INVENTORY_SLOT_BAG_0, slot)
            if item then
                if entryMap[playerGUID] then
                    if entryMap[playerGUID][item:GetGUIDLow()] then
                        player:UpdateUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (item:GetSlot() * ITEM_SLOT_MULTIPLIER), entryMap[playerGUID][item:GetGUIDLow()])
                    end
                end
            end
        end
    end
    print("[Eluna dressMe]: Player "..playerGUID.." Loaded")
end

local function DeleteFakeFromDB(itemGUID)
    if dataMap[itemGUID] then
        if entryMap[dataMap[itemGUID]] then
            entryMap[dataMap[itemGUID]][itemGUID] = nil
        end
        dataMap[itemGUID] = nil
    end
    CharDBExecute("DELETE FROM eluna_transmog WHERE GUID = "..itemGUID)
end

local function DeleteFakeEntry(item)
    if not GetFakeEntry(item) then
        return false
    end
    item:GetOwner():UpdateUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (item:GetSlot() * ITEM_SLOT_MULTIPLIER), item:GetEntry())
    if item then
        DeleteFakeFromDB(item:GetGUIDLow())
    end
    return true
end

local function SetFakeEntry(player, item, entry)
    if item then
        local pGUID = player:GetGUIDLow()
        local iGUID = item:GetGUIDLow()
        player:UpdateUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (item:GetSlot() * ITEM_SLOT_MULTIPLIER), entry)
        if not entryMap[pGUID] then
            entryMap[pGUID] = {}
        end
        entryMap[pGUID][iGUID] = entry
        dataMap[iGUID] = pGUID
        CharDBExecute("REPLACE INTO eluna_transmog (GUID, FakeEntry, Owner) VALUES ("..iGUID..", "..entry..", "..pGUID..")")
    end
end

local function DeleteAllTransmogs(player)
    print("[Eluna dressMe]: Reset All")
    player:SendAreaTriggerMessage("Transmogs have been reset")
    for slot = EQUIPMENT_SLOT_START, EQUIPMENT_SLOT_END-1 do
        local item = player:GetItemByPos(INVENTORY_SLOT_BAG_0, slot)
        if item then
            DeleteFakeEntry(item)
        end
    end
    --CharDBExecute("DELETE FROM custom_transmogrification WHERE Owner = "..player:GetGUIDLow())
end

local function ProcessCopper(player)
    player:ModifyMoney(1)
    player:ModifyMoney(-1)
end

function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

local function onChatMessage(event, player, msg, _, lang)
    if (msg:find('#transmog reset') == 1) then
        player:PlayDirectSound(3337)
        --wait(5)
        ProcessCopper(player)
        DeleteAllTransmogs(player)
        LoadPlayer(player)
    elseif (msg:find('#transmog') == 1) then
        local slotID = string.sub(msg, 10, 12)
        local entry = string.sub(msg, 14)
        local item = player:GetItemByPos(INVENTORY_SLOT_BAG_0, slotID)
        player:PlayDirectSound(3337)
        ProcessCopper(player)
        SetFakeEntry(player, item, entry)
    end
end

local function onLogin(event, player)
    LoadPlayer(player)
end

local function onLogout(event, player)
    local pGUID = player:GetGUIDLow()
    entryMap[pGUID] = nil
end

local function onEquip(event, player, item, bag, slot)
    local fentry = GetFakeEntry(item)
    if fentry then
        if item:GetOwnerGUID() ~= player:GetGUID() then
            DeleteFakeFromDB(item:GetGUIDLow())
            return
        end
        player:SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * ITEM_SLOT_MULTIPLIER), fentry)
    end
end

CharDBQuery([[
CREATE TABLE IF NOT EXISTS `eluna_transmog` (
`GUID` INT(10) UNSIGNED NOT NULL COMMENT 'Item guidLow',
`FakeEntry` INT(10) UNSIGNED NOT NULL COMMENT 'Item entry',
`Owner` INT(10) UNSIGNED NOT NULL COMMENT 'Player guidLow',
PRIMARY KEY (`GUID`)
)
COMMENT='version 4.0'
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;
]])

print("Deleting non-existing transmogrification entries...")
CharDBQuery("DELETE FROM eluna_transmog WHERE NOT EXISTS (SELECT 1 FROM item_instance WHERE item_instance.guid = eluna_transmog.GUID)")

RegisterPlayerEvent(18, onChatMessage)
RegisterPlayerEvent(3, onLogin)
RegisterPlayerEvent(4, onLogout)
RegisterPlayerEvent(29, onEquip)
