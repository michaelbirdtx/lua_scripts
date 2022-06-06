-- Forked from Eluna SQL Teleporter

local MODULE_NAME = "Eluna teleporter"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local Teleporter = {
    entry = 667103 -- Unit entry
}

function Teleporter.OnHello(event, player, unit)
    for k, v in pairs(Teleporter["Options"]) do
        --print(MODULE_NAME..": Option "..k..": "..v["name"])
        if(player:GetTeam() == v["faction"] or v["faction"] == -1) and ( v["parent"] == 0) then
            player:GossipMenuAddItem(v["icon"], v["name"], 0, v["id"])
        end
    end
    player:GossipSetText("Greetings, "..player:GetName()..".\n\nTo what wondrous place may I send you?")
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function Teleporter.OnSelect(event, player, unit, sender, intid, code)
    local t = Teleporter["Options"]
    --print(MODULE_NAME..": Menu selected "..intid)

    if(intid == 0) then -- Special handling for "Back" option in case parent is 0
        Teleporter.OnHello(event, player, unit)
    elseif(t[intid]["type"] == 1) then
        for k, v in pairs(t) do
            if(v["parent"] == intid and (player:GetTeam() == v["faction"] or v["faction"] == -1)) then
                player:GossipMenuAddItem(v["icon"], v["name"], 0, k)
                --print(MODULE_NAME..": Menu Item added "..v["name"])
            end
        end
        player:GossipMenuAddItem(7, "[Back]", 0, t[intid]["parent"])
        player:GossipSetText("Be careful, "..player:GetClassAsString()..".\n\nNot all places are safe.")
        player:GossipSendMenu(0x7FFFFFFF, unit)
    elseif(t[intid]["type"] == 2) then
        player:Teleport(t[intid]["map"], t[intid]["x"], t[intid]["y"], t[intid]["z"], t[intid]["o"])
    end
end

function Teleporter.LoadCache()
    Teleporter["Options"] = {}

    if not(WorldDBQuery("SHOW TABLES LIKE 'eluna_teleporter';")) then
        print("["..MODULE_NAME.."]: eluna_teleporter table missing from world database.")
        print("["..MODULE_NAME.."]: Inserting table structure, initializing cache.")
        WorldDBQuery("CREATE TABLE `eluna_teleporter` (`id` int(5) NOT NULL AUTO_INCREMENT,`parent` int(5) NOT NULL DEFAULT '0',`type` int(1) NOT NULL DEFAULT '1',`faction` int(2) NOT NULL DEFAULT '-1',`icon` int(2) NOT NULL DEFAULT '0',`name` char(20) NOT NULL DEFAULT '',`map` int(5) DEFAULT NULL,`x` decimal(10,3) DEFAULT NULL,`y` decimal(10,3) DEFAULT NULL,`z` decimal(10,3) DEFAULT NULL,`o` decimal(10,3) DEFAULT NULL,PRIMARY KEY (`id`) ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;")
        return Teleporter.LoadCache();
    end

    local Query = WorldDBQuery("SELECT * FROM eluna_teleporter ORDER BY id;")
    if(Query) then
        local item = 1
        repeat
            Teleporter["Options"][item] = {
                id = Query:GetUInt32(0),
                parent = Query:GetUInt32(1),
                type = Query:GetUInt32(2),
                faction = Query:GetInt32(3),
                icon = Query:GetInt32(4),
                name = Query:GetString(5),
                map = Query:GetUInt32(6),
                x = Query:GetFloat(7),
                y = Query:GetFloat(8),
                z = Query:GetFloat(9),
                o = Query:GetFloat(10),
            };
            --print(MODULE_NAME..": Cache loaded "..Query:GetString(5))
            item = item + 1
        until not Query:NextRow()
        print("["..MODULE_NAME.."]: Cache initialized. Loaded "..Query:GetRowCount().." results.")
    else
        print("["..MODULE_NAME.."]: Cache initialized. No results found.")
    end
end

Teleporter.LoadCache()
RegisterCreatureGossipEvent(Teleporter.entry, 1, Teleporter.OnHello)
RegisterCreatureGossipEvent(Teleporter.entry, 2, Teleporter.OnSelect)
