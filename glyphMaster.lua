--Adapted from Eluna SQL Teleporter
local MODULE_NAME = "Eluna glyphMaster"
local MODULE_VERSION = '1.1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local GlyphMaster = {
    entry = 667100 -- Unit entry
}

function GlyphMaster.OnHello(event, player, unit)
    for k, v in pairs(GlyphMaster["Options"]) do
        if( v["parent"] == 0) then
            player:GossipMenuAddItem(v["icon"], v["name"], 0, k)
        end
    end
    player:GossipSetText("Greetings, "..player:GetClassAsString()..". What type of Glyph do you seek?")
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function GlyphMaster.OnSelect(event, player, unit, sender, intid, code)
    local t = GlyphMaster["Options"]

    if(intid == 0) then -- Special handling for "Back" option in case parent is 0
        GlyphMaster.OnHello(event, player, unit)
    elseif(t[intid]["type"] == 1) then
        local limit = 1
        for k, v in pairs(t) do
            if limit > 30 then
                break
            end
            if(v["parent"] == intid) then
                player:GossipMenuAddItem(v["icon"], v["name"], 0, k)
                limit = limit + 1
            end
        end
        player:GossipMenuAddItem(7, "[Back]", 0, t[intid]["parent"])
        player:GossipSetText("Please choose which Glyph you would like me to grant to you:")
        player:GossipSendMenu(0x7FFFFFFF, unit)
    elseif(t[intid]["type"] == 2) then
        player:AddItem(t[intid]["glyph_id"])
        player:GossipComplete()
    end
end

function GlyphMaster.LoadCache()
    GlyphMaster["Options"] = {}

    if not(WorldDBQuery("SHOW TABLES LIKE 'eluna_glyphmaster';")) then
        print("[E-SQL GlyphMaster]: eluna_glyphmaster table missing from world database.")
        print("[E-SQL GlyphMaster]: Inserting table structure, initializing cache.")
        WorldDBQuery("CREATE TABLE `eluna_glyphmaster` (`id` int(5) NOT NULL AUTO_INCREMENT,`parent` int(5) NOT NULL DEFAULT '0',`type` int(1) NOT NULL DEFAULT '1',`icon` int(2) NOT NULL DEFAULT '0',`name` char(50) NOT NULL DEFAULT '',`glyph_id` int(10) DEFAULT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;")
        return GlyphMaster.LoadCache();
    end

    local Query = WorldDBQuery("SELECT * FROM eluna_glyphmaster;")
    if(Query) then
        repeat
            GlyphMaster["Options"][Query:GetUInt32(0)] = {
                parent = Query:GetUInt32(1),
                type = Query:GetUInt32(2),
                icon = Query:GetInt32(3),
                name = Query:GetString(4),
                glyph_id = Query:GetUInt32(5),
            };
        until not Query:NextRow()
        print("["..MODULE_NAME.."]: Cache initialized. Loaded "..Query:GetRowCount().." results")
    else
        print("["..MODULE_NAME.."]: Cache initialized. No results found")
    end
end

GlyphMaster.LoadCache()
RegisterCreatureGossipEvent(GlyphMaster.entry, 1, GlyphMaster.OnHello)
RegisterCreatureGossipEvent(GlyphMaster.entry, 2, GlyphMaster.OnSelect)
