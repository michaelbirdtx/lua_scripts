local MODULE_NAME = "Eluna initItems"
local MODULE_VERSION = '1.0.1'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function onUseInstastone(event, player, item, target)
    if not player:IsInCombat() then
        player:CastSpell(player, 8690, true)
    end
end

RegisterItemEvent(41605, 2, onUseInstastone)
