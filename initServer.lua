local MODULE_NAME = "Eluna initServer"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function onUseInstastone(event, player, item, target)
    print("Instahearth! clicked")
    player:CastSpell(player, 8690, true)
end

RegisterItemEvent(41605, 2, onUseInstastone)
