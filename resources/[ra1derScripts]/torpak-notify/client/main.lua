local function SendAlert(text, textype, length)
    if type(text) == "table" then
        local ttext = text.text or 'Placeholder'
        local caption = text.caption or 'Placeholder'
        local ttype = textype or 'info'
        local length = length or 5000
        SendNUIMessage({
            type = ttype,
            length = length,
            text = ttext,
            caption = caption
        })
    else
        local ttype = textype or 'info'
        local length = length or 5000
        SendNUIMessage({
            type = ttype,
            length = length,
            text = text
        })
    end
end

exports('SendAlert', SendAlert)

RegisterNetEvent('ra1der:notify', function(text, type, length)
    SendAlert(text, type, length)
end)

RegisterNUICallback('getNotifyConfig', function(data, cb)
    cb(json.encode(Config.Notify))
end)


RegisterCommand('main2', function()
exports['elix1rBase']:SendAlert('ELIXIR#5596', 'success')
exports['elix1rBase']:SendAlert('ELIXIR#5596', 'error')
exports['elix1rBase']:SendAlert('ELIXIR#5596', 'warn')
exports['elix1rBase']:SendAlert('ElixirFW!', 'info')
exports['elix1rBase']:SendAlert('Attention! Leading the market..', 'warn')
end)
