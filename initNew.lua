local MODULE_NAME = "Eluna initNew"
local MODULE_VERSION = '1.0'
local MODULE_AUTHOR = "Mpromptu Gaming"

print("["..MODULE_NAME.."]: Loaded, Version "..MODULE_VERSION.." Active")

function newCharacter(event, player)
    emailSubject = "Welcome!"
    emailBody = "Congratulations on your new character! Here are some tokens of our appreciation!"
    emailTo = player:GetGUIDLow()
    emailStationery = 61
    emailFrom = 0
    print("New Character")
    SendMail(
        emailSubject,
        emailBody,
        emailTo,
        emailFrom,
        emailStationery,
        0, -- Delay
        100000,
        0, -- COD
        56806, -- Mini Thor
        1
    )
end

RegisterPlayerEvent(1, newCharacter)
