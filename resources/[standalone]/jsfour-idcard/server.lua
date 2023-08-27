QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(citizenid, targetID, type)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
	local xTarget = QBCore.Functions.GetPlayer(targetID)
	local show = false

	if type == 'driver' then
		if xPlayer.PlayerData.metadata["licences"]["drive"] or xPlayer.PlayerData.metadata["licences"]["drive_bike"] or xPlayer.PlayerData.metadata["licences"]["hunting"] or xPlayer.PlayerData.metadata["licences"]["drive_truck"] or xPlayer.PlayerData.metadata["licences"]["aircraft"] then 
			show = true
		end
	else
		if xPlayer.PlayerData.metadata["licences"]["weapon"] then
			show = true
		end
	end

	if show or not type then
		local licences = {}
		local user = {
			name = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname,
			dob = xPlayer.PlayerData.charinfo.birthdate, 
			sex = xPlayer.PlayerData.charinfo.gender, 
			lastdigits = xPlayer.PlayerData.charinfo.account,
			photo = xPlayer.PlayerData.charinfo.photo
		}
		for name,data in pairs(xPlayer.PlayerData.metadata["licences"]) do 
			if data then
				licences[name] = name
			end
		end
		local array = {
			user = user,
			licenses = licences
		}
		TriggerClientEvent('jsfour-idcard:open', xTarget.PlayerData.source, array, type)
		TriggerClientEvent("oyuncuanim", src)
	else
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You don't have a license/license so you can't show it.", "error")
	end
end)

RegisterServerEvent('jsfour-idcard:server:open-pd')
AddEventHandler('jsfour-idcard:server:open-pd', function(targetID)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local data = {
		name = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname,
		photo = xPlayer.PlayerData.charinfo.photo,
		rank = QBCore.Shared.Jobs["police"]["grade"][xPlayer.PlayerData.job.grade].label
	}
	TriggerClientEvent("jsfour-idcard:open-pd", targetID, data)
end)