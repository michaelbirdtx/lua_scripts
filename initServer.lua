local MODULE_NAME = "Eluna initServer"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function onZoneUpdate(event, player, newZone, newArea)
    player:RemoveFlag(150, 32)
    print("["..MODULE_NAME.."]: Player: "..player:GetName().." New Zone: "..newZone.." Flags: "..player:GetInt32Value(150))
    if newZone == 616 or newZone == 876 then
        player:SetFlag(150, 32)
        print(player:GetName().." has arrived at the Guild House.")
    end
end

RegisterPlayerEvent(27, onZoneUpdate)