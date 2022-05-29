local MODULE_NAME = "Eluna glyphMaster"
local MODULE_VERSION = '2.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local DisplayIDs = {
    {class = 1, type = 1, id = 58842},
    {class = 1, type = 2, id = 58843},
    {class = 2, type = 1, id = 58832},
    {class = 2, type = 2, id = 58833},
    {class = 4, type = 1, id = 58829},
    {class = 4, type = 2, id = 59343},
    {class = 8, type = 1, id = 58836},
    {class = 8, type = 2, id = 58837},
    {class = 16, type = 1, id = 58834},
    {class = 16, type = 2, id = 58835},
    {class = 32, type = 1, id = 58825},
    {class = 32, type = 2, id = 58826},
    {class = 64, type = 1, id = 58839},
    {class = 64, type = 2, id = 58838},
    {class = 128, type = 1, id = 58830},
    {class = 128, type = 2, id = 58831},
    {class = 256, type = 1, id = 58841},
    {class = 256, type = 2, id = 58840},
    {class = 1024, type = 1, id = 58828},
    {class = 1024, type = 2, id = 58827},
}

local GlyphMaster = {
    entry = 667100
}

function findDisplayID(class, type)
    for i, v in ipairs(DisplayIDs) do
        if v.class==class and v.type==type then
            return v.id
        end
    end
end

function GlyphMaster.OnHello(event, player, unit)
    player:GossipMenuAddItem(0, "I need a Major Glyph", 0, 1)
    player:GossipMenuAddItem(0, "I'm looking for a Minor Glyph", 0, 2)
    player:GossipSetText("Greetings, "..player:GetClassAsString()..".\n\nWhat type of Glyph do you seek?")
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function GlyphMaster.OnSelect(event, player, unit, sender, intid, code)
    local class = player:GetClassMask()
    if sender == 0 then
        local displayID = findDisplayID(class, intid)
        local Query = WorldDBQuery("SELECT `name`, `entry`, `RequiredLevel` FROM item_template WHERE `name` LIKE '%Glyph of%' AND `AllowableClass` = "..class.." AND displayid = "..displayID.." ORDER BY `name`;")
        if Query then
            repeat
                player:GossipMenuAddItem(3, Query:GetString(0).. " (Lvl "..Query:GetString(2)..")", 1, Query:GetInt32(1))
            until not Query:NextRow()
            player:GossipSetText("Choose wisely...")
            player:GossipSendMenu(0x7FFFFFFF, unit)
        end
    else
        player:AddItem(intid)
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(GlyphMaster.entry, 1, GlyphMaster.OnHello)
RegisterCreatureGossipEvent(GlyphMaster.entry, 2, GlyphMaster.OnSelect)
