local MODULE_NAME = "Eluna initServer"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function onZoneUpdate(event, player, newZone, newArea)
    player:RemoveFlag(150, 32)
    if newZone == 616 or newZone == 876 then
        player:SetFlag(150, 32)
    end
end

RegisterPlayerEvent(27, onZoneUpdate)