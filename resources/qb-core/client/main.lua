QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.Key = "Bilinmiyor"
QBCore.CKey = "Bilinmiyor"
QBCore.ServerCallbacks = {}
local busy = false
isLoggedIn = false

function GetCoreObject()
	return QBCore
end

local loadedQBRes = 0 
local res = 113
RegisterNetEvent('QBCore:GetObject')
AddEventHandler('QBCore:GetObject', function(cb)
	if not busy then
		if QBCore.Key == "Bilinmiyor" then
			busy = true
			QBCore.Functions.TriggerCallback("qb-core:check-key", function(key1, key2)
				QBCore.Key = key1
				QBCore.CKey = key2
			end)
			while QBCore.Key == "Bilinmiyor" and QBCore.CKey == "Bilinmiyor" do
				Citizen.Wait(1)
			end
			busy = false
		end
		loadedQBRes = loadedQBRes + 1
		if loadedQBRes <= res then
			cb(GetCoreObject())
		else
			QBCore.Functions.TriggerCallback("QBCore:HasAdminPerm", function(result)
				if result then
					cb(GetCoreObject())
				end
			end)
		end
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	ShutdownLoadingScreenNui()
	isLoggedIn = true
	TriggerEvent("sc-backitems:loop")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()

