local MODULE_NAME = "Eluna loginAnnounce"
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

local function sendMsg(msg, color)
    print("["..MODULE_NAME.."]: "..msg)
    SendWorldMessage("|"..color..msg.."|r")
end

local function onLogin(event, player)
    sendMsg(getTeamName(player).." player "..player:GetName().." has logged in.", getTeamColor(player))
end

local function onLogout(event, player)
    sendMsg(getTeamName(player).." player "..player:GetName().." has logged out.", getTeamColor(player))
end

RegisterPlayerEvent(3, onLogin)
RegisterPlayerEvent(4, onLogout)
