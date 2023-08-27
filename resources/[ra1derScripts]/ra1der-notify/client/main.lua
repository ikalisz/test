local function SendAlert(text, textype, length)
    if type(text) == "table" then
        local ttext = text.text or 'Placeholder'
        local caption = text.caption or 'Placeholder'
        local ttype = textype or 'primary'
        local length = length or 3500
        SendNUIMessage({
            type = ttype,
            length = length,
            text = ttext,
            caption = caption
        })
    else
        local ttype = textype or 'primary'
        local length = length or 5000
        SendNUIMessage({
            type = ttype,
            length = length,
            text = text
        })
    end
end

exports('SendAlert', SendAlert)

RegisterNetEvent('torpak:notify', function(text, type, length)
    SendAlert(text, type, length)
end)

RegisterNUICallback('getNotifyConfig', function(data, cb)
    cb(json.encode(Config.Notify))
end)

RegisterCommand('main2', function()
    TriggerEvent('torpak:notify', src, 'Test Noti', 'error', 3500)
end) 

RegisterCommand('main', function()
    exports['elix1rBase']:SendAlert('This is an error message...', 'error', 5000)
    exports['elix1rBase']:SendAlert('This is an Success Message...', 'success', 5000)
    exports['elix1rBase']:SendAlert('This is an Primary Message!', 'primary', 10000) 
end)