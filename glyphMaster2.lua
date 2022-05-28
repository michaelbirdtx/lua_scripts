--[[

2.0
GlyphMaster for WotLK
by Shermer

Adapted from Eluna SQL Teleporter

]]

local GlyphMaster = {
    entry = 667100
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
