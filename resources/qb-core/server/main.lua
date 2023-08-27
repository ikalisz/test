QBCore = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ServerCallbacks = {}
QBCore.UseableItems = {}
QBCore.Key = math.random(1,999)..math.random(20,500).."KEY"..math.random(1,1000).."JT"
QBCore.CKey = "JT"..math.random(1,999)..math.random(20,500).."JTKEY"..math.random(1,1000)

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
	SetGameType('Roleplay')
end)

function GetCoreObject()
	return QBCore
end

RegisterServerEvent('QBCore:GetObject')
AddEventHandler('QBCore:GetObject', function(cb)
	cb(GetCoreObject())
end)

function generateNumber()
	repeat
		local numBase0 = math.random(100,999)
        local numBase1 = math.random(1000,9999)
        myPhoneNumber = string.format("%03d-%04d", numBase0, numBase1 )
        local id = getCitizenIdNumber(myPhoneNumber)
    until id == false
	return myPhoneNumber
end

function getCitizenIdNumber(phone_number) 
    local result = exports.oxmysql:executeSync("SELECT citizenid FROM players WHERE number = @number", {
        ['@number'] = phone_number
    })
    if result[1] then
        return true
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        local saat = os.date("*t")
        if saat.hour == 10 and saat.min > 30 and saat.min < 40 then 
            TriggerEvent("QBCore:Restart-job")
            break
        end
    end
end)

RegisterCommand("restartjob", function(source)
    if source == 0 then
        TriggerEvent("QBCore:Restart-job")
    end
end, true)

RegisterServerEvent('QBCore:Restart-job')
AddEventHandler('QBCore:Restart-job', function(cb)
    exports.oxmysql:execute("SELECT citizenid, jobcd FROM players", {}, function(result)
        for i=1, #result do
            local xPlayer = QBCore.Functions.GetPlayerByCitizenId(result[i].citizenid)
            if xPlayer then
                xPlayer.Functions.Reset()
            else
                exports.oxmysql:execute("UPDATE players SET jobcd = @jobcd WHERE citizenid = @citizenid", { 
                    ['@citizenid'] = result[i].citizenid,
                    ['@jobcd'] = "{}",
                })

                exports.oxmysql:execute("UPDATE players SET evjob = @evjob WHERE citizenid = @citizenid", { 
                    ['@citizenid'] = result[i].citizenid,
                    ['@evjob'] = 0,
                })
            end
        end
    end)
end)