QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("cam", "Toggle Cam", {},  false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == "news" then
        TriggerClientEvent("Cam:ToggleCam", src)
    else
        TriggerClientEvent("QBCore:Notify", src, "Only News Can Use This Command", "error", 5000)
    end
end)

QBCore.Commands.Add("bmic", "News Takes Out Its Big Microphone", {},  false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == "news" then
        TriggerClientEvent("Mic:ToggleBMic", src)
    else
        TriggerClientEvent("QBCore:Notify", src, "Only News Can Use This Command", "error", 5000)
    end
end)

QBCore.Commands.Add("mic", "Takes Off The News Microphone", {},  false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == "news" then
        TriggerClientEvent("Mic:ToggleMic", src)
    else
        TriggerClientEvent("QBCore:Notify", src, "Only News Can Use This Command", "error", 5000)
    end
end)
