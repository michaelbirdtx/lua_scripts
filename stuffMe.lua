local MODULE_NAME = "Eluna stuffMe"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

local function doStuff(player)
    player:Say("I don't feel so good...", 0)
    player:SetDisplayId(18082)
    player:CastSpell(player, 27123, true)
end

local function undoStuff(player)
    player:Say("I just can't get enough... of The Stuff!", 0)
    player:DeMorph()
    player:CastSpell(player, 49867, true)
end

local function onEatStuff(event, player, item, target)
    if player:GetDisplayId() == 18082 then
        undoStuff(player)
    elseif math.random(1,100) == 1 and player:HasAura(50056) ~= true then
        doStuff(player)
    end
end

RegisterItemEvent(23364, 2, onEatStuff)
