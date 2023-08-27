gsrData = {}

RegisterCommand("gsr",function(source, args)
    local Source = source
    local xPlayer = QBCore.Functions.GetPlayer(Source)
   
    if args[1] then 
        local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if tPlayer then
            if xPlayer.PlayerData.job.name == 'police' then
                gsrcheck(source, tPlayer)
            else
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Only Cops Can Use This Command')
            end
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "No Player With This ID")
        end
	else
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Use /gsr (Player ID)')
	end
end)

--[[ AddEventHandler('playerDropped', function(source)
    local Source = source
    local citizenid = QBCore.Functions.GetPlayer(Source).PlayerData.citizenid
    if gsrData[citizenid] then
        gsrData[citizenid] = nil
    end
end) ]]

RegisterNetEvent("GSR:Remove")
AddEventHandler("GSR:Remove", function()
    local Source = source
    local citizenid = QBCore.Functions.GetPlayer(Source).PlayerData.citizenid
    if gsrData[citizenid] then
        gsrData[citizenid] = nil
    end
end)

RegisterServerEvent('GSR:SetGSR')
AddEventHandler('GSR:SetGSR', function()
    local Source = source
    local citizenid = QBCore.Functions.GetPlayer(Source).PlayerData.citizenid
    gsrData[citizenid] = os.time(os.date("!*t")) + Config.gsrTime
end)

function gsrcheck(source, tPlayer)
    local citizenid = tPlayer.PlayerData.citizenid
    if gsrData[citizenid] then
        TriggerClientEvent("QBCore:Notify", source, 'Test Positive (Fired) for ' ..tPlayer.PlayerData.charinfo.firstname .. " ".. tPlayer.PlayerData.charinfo.lastname , "success")
    else
        TriggerClientEvent("QBCore:Notify", source, 'Test Negative (Unfired) for' ..tPlayer.PlayerData.charinfo.firstname .. " ".. tPlayer.PlayerData.charinfo.lastname , "error")
    end
end

QBCore.Functions.CreateCallback('GSR:Status', function(source, cb)
    local Source = source
    local citizenid = QBCore.Functions.GetPlayer(Source).PlayerData.citizenid
    if gsrData[citizenid] ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

function removeGSR()
    for k, v in pairs(gsrData) do
        if v <= os.time(os.date("!*t")) then
            gsrData[k] = nil
        end
    end
end

function gsrTimer()
    removeGSR()
    SetTimeout(Config.gsrAutoRemove, gsrTimer)
end

gsrTimer()