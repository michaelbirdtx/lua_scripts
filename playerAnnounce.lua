local MODULE_NAME = "Eluna playerAnnounce"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function getTeamColor(player)
    if player:GetTeam() == 0 then
        return "CFF00B4FF"
    else
        return "CFFFF9900"
    end
end

local function getTeamName(player)
    if player:GetTeam() == 0 then
        return "Alliance"
    else
        return "Horde"
    end
end

local function announce(player, action)
    msg = getTeamName(player).." player "..player:GetName().." ("..player:GetAccountName()..") has "..action.."."
    print("["..MODULE_NAME.."]: "..msg)
    SendWorldMessage("|"..getTeamColor(player)..msg.."|r")
end

local function listPlayers(player)
    player:SendBroadcastMessage("|CFF99E472Currently online:|r")
    allPlayers = GetPlayersInWorld(2)
    for k, v in pairs(allPlayers) do
        player:SendBroadcastMessage("|"..getTeamColor(v)..v:GetName().." of the "..getTeamName(v).." ("..v:GetAccountName()..")|r")
    end
end

local function onLogin(event, player)
    announce(player, "logged in")
    listPlayers(player)
end

local function onLogout(event, player)
    announce(player, "logged out")
end

RegisterPlayerEvent(3, onLogin)
RegisterPlayerEvent(4, onLogout)
