QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

TriggerEvent('esx_phone:registerNumber', 'police', "Police Hotline", true, true)

Citizen.CreateThread(function()
	exports.oxmysql:execute("DELETE FROM `stashitemsnew` WHERE `stash` = @stash" , {["stash"] = "policetrash"})
end)

exports('checkPlate', function(plate)
	local plate = string.upper(plate)
	if kayitsizPlakalar[plate] == nil then
		kayitsizPlakalar[plate] = exports["elixir-base"]:randomName()
	end
	return kayitsizPlakalar[plate]
end)

QBCore.Functions.CreateCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	exports.oxmysql:execute('SELECT citizenid FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			exports.oxmysql:execute('SELECT firstname, lastname FROM players WHERE citizenid = @citizenid',  {
				['@citizenid'] = result[1].citizenid
			}, function(result2)
				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end
			end)
		else
			if kayitsizPlakalar[plate] == nil then
				kayitsizPlakalar[plate] = exports["elixir-base"]:randomName()
			end
			cb(kayitsizPlakalar[plate], false)
		end
	end)
end)

--[[ RegisterNetEvent('esx_policejob:mp7')
AddEventHandler('esx_policejob:mp7', function(key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer.PlayerData.job.name == 'police' then
			info = {
				serie = "T"..math.random(10,99).."GI"..math.random(100,999).."A"..math.random(1,9).."NN",
				durubality = os.time(),
				attachments = {
					{component = "COMPONENT_SMG_MK2_CLIP_02", label = "Sarjör"},
					{component = "COMPONENT_AT_AR_FLSH", label = "Fener"},
					{component = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2", label = "Dürbün"},
					{component = "COMPONENT_AT_SB_BARREL_02", label = "Gövde"},
				}
			}
			xPlayer.Functions.AddItem("weapon_smg_mk2", 1, false, info)
			TriggerClientEvent("weapon:add-ammo", source, "AMMO_SMG", 200, QBCore.Key)
		end
	end
end) ]]

RegisterNetEvent('tgiann-police:put-money')
AddEventHandler('tgiann-police:put-money', function(money)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.RemoveMoney('cash', money) then
		QBCore.Functions.addJobMoney("police", money)
	else
		TriggerClientEvent("QBCore:Notify", source, "You Don't Have That Much Cash!", "error")
	end
end)

local olumculGucler = {}

QBCore.Commands.Add("deadlypower", "Set Deadline for Death Power Release (Use Only If You're Managing the Event When Robbers Exit the Bank!)", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" then
		if not olumculGucler[xPlayer.PlayerData.citizenid] then
			local randomSure = math.random(27,45)
			olumculGucler[xPlayer.PlayerData.citizenid] = os.time() + (randomSure*60)
			TriggerClientEvent("QBCore:Notify", source, "Permission Requested for Deadly Force Permission", "primary", 25000)
			TriggerClientEvent("QBCore:Notify", source, "This Will Be Notified To You And The Police Around You When Permission Is Granted", "primary", 25000)
		else
			TriggerClientEvent("QBCore:Notify", source, "You've Already Requested Deadly Force Permission!", "error")
		end
	end
end)

QBCore.Commands.Add("canceldeadlypower", "Revoke Deadly Power Permission Received", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" then
		if olumculGucler[xPlayer.PlayerData.citizenid] then
			olumculGucler[xPlayer.PlayerData.citizenid] = nil
			TriggerClientEvent("QBCore:Notify", source, "Requested Deadly Power Permission Canceled!")
		else
			TriggerClientEvent("QBCore:Notify", source, "You Don't Have Deadly Force Permission Anyway!", "error")
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		for cid, time in pairs(olumculGucler) do
			if os.time() > time then
				local xPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
				if xPlayer then
					TriggerClientEvent("tgiann-police:olumculGuc", -1, GetEntityCoords(GetPlayerPed(xPlayer.PlayerData.source)))
				end
				olumculGucler[cid] = nil
			end
		end
	end
end)

otuz= {
	["id_card"] = {amount = 1, item = "id_card"},
}
-- Functions
local function baslangicesya(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for _, v in pairs(otuzbir) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        end
		Player.Functions.AddItem(v.item, 1, false, info) 
    end
end

RegisterNetEvent("kimligimiver", function()
	local src = source 
	local PlayerData = QBCore.Functions.GetPlayer(src)
	if PlayerData.Functions.RemoveMoney("cash", 100) then 
		baslangicesya(src)
		TriggerClientEvent("QBCore:Notify", src, "ID Received", "success")
	else
		TriggerClientEvent("QBCore:Notify", src, "You Don't Have Enough Money", "error")
	end
end)


RegisterNetEvent("huntinglicense:server", function()
	local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.metadata['huntinglicense'] == 1 then
       TriggerClientEvent('QBCore:Notify', src, 'Already Have a Hunting License', "error")
    elseif xPlayer.Functions.RemoveMoney('cash', 1000) then
        xPlayer.Functions.SetMetaData("huntinglicense", 1)
        TriggerClientEvent('QBCore:Notify', src, 'You Got Your Hunting License', "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Money!!", "error")
	end 
end)

-- QBCore.Functions.CreateCallback("huntinglicence:kontrol", function(source,cb,oyuncu)
QBCore.Commands.Add('controller', 'Help Text', {}, false, function(src, args)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.metadata.licences["huntinglicense"] == true  then
		TriggerClientEvent('QBCore:Notify', src, 'Done!', "error")
	else
		TriggerClientEvent('QBCore:Notify', src, 'no license type.', "error")
    end
end)

QBCore.Functions.CreateUseableItem('taser_ammo', function(source)
	local xPlayer  = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("taserreload", source)
	xPlayer.Functions.RemoveItem('taser_ammo', 1)
end)


QBCore.Commands.Add("license", "Give civilian a license", {{name = "id", help = 'Player ID'}, {name = "license", help = 'drive/weapon'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" then
        if args[2] == "drive" or args[2] == "weapon" or args[2] == "huntinglicense" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
            if licenseTable[args[2]] then
                TriggerClientEvent('QBCore:Notify', src, 'The person already has this license.', "error")
                return
            end
            licenseTable[args[2]] = true
            SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, 'You have been granted a license.', "success")
            TriggerClientEvent('QBCore:Notify', src, 'You gave a license.', "success")
        else
            TriggerClientEvent('QBCore:Notify', src, 'Invalid license type.', "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not at a high enough rank to grant a license.', "error")
    end
end)

QBCore.Commands.Add("revokelicense", 'Cancel license.', {{name = "id", help = 'Player ID'}, {name = "license", help = 'drive/weapon'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" then
        if args[2] == "drive" or args[2] == "weapon" or args[2] == "huntinglicense" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
            if not licenseTable[args[2]] then
                TriggerClientEvent('QBCore:Notify', src, 'There is no such license in person.', "error")
                return
            end
            licenseTable[args[2]] = false
            SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, 'A license has been revoked.', "error")
            TriggerClientEvent('QBCore:Notify', src, 'You revoked a license.', "success")
        else
            TriggerClientEvent('QBCore:Notify', src, 'Invalid license type', "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not at a high enough rank to grant a license', "error")
    end
end)