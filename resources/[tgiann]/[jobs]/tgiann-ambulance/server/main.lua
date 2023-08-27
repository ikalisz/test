QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', "Hastane", true, true)

Citizen.CreateThread(function()
	exports.oxmysql:execute("DELETE FROM `stashitemsnew` WHERE `stash` = @stash" , {["stash"] = "emstrash"})
end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == 'ambulance' or xPlayer.PlayerData.job.name == 'police' then
		TriggerClientEvent('esx_ambulancejob:revive', target, true)
		TriggerEvent('DiscordBot:ToDiscord', 'diger', 'EMS Bir Oyuncuyu iyileştirdi'.. os.date("%H:%M:%S"), source, target)
		xPlayer.Functions.AddMoney('bank', 50)
	end
end)

RegisterServerEvent('esx_ambulancejob:igne')
AddEventHandler('esx_ambulancejob:igne', function(target, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		TriggerClientEvent('tgiann-basicneeds:igne', target)
	end
end)

RegisterServerEvent('esx_ambulancejob:payFine')
AddEventHandler('esx_ambulancejob:payFine', function(clear)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if clear then
		xPlayer.Functions.ClearInventory()
		local cash = xPlayer.PlayerData.money["cash"]
		xPlayer.Functions.RemoveMoney('cash', cash)
	end
	xPlayer.Functions.RemoveMoney('bank', Config.EarlyRespawnFineAmount)
end)

QBCore.Commands.Add("revive", "Revive the Player.", {{name="id", help="Player ID"}}, false, function(source, args)
	if args[1] == nil then
		TriggerClientEvent('esx_ambulancejob:revive', source, true)
		TriggerEvent("QBCore:Notify", src, "komut", "primary")
	else
		TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]), true)
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', 'Admin revived a player', source, target)
	end
end, "admin")

QBCore.Functions.CreateUseableItem('bandage', function(source, item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemBySlot(item.slot) then
		TriggerClientEvent('esx_ambulancejob:user-bandage', xPlayer.PlayerData.source)
	end
end)

QBCore.Functions.CreateUseableItem('medikit', function(source, item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemBySlot(item.slot) then
		TriggerClientEvent('esx_ambulancejob:user-medikit', xPlayer.PlayerData.source)
	end
end)

--[[ QBCore.Functions.CreateUseableItem('adrenalin', function(source, item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemBySlot(item.slot) then
		TriggerClientEvent('esx_ambulancejob:user-adrenalin', xPlayer.PlayerData.source)
	end
end) ]]

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	xPlayer.Functions.RemoveItem(item, 1, xPlayer.Functions.GetItemByName(item).slot)
end)

RegisterServerEvent('tgiann-ambulance:cloeset-adrenalin')
AddEventHandler('tgiann-ambulance:cloeset-adrenalin', function(otherPlayer, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		TriggerClientEvent("tgiann-ambulance:adrenalin-effect", otherPlayer)
	end
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		xPlayer.Functions.SetMetaData("isdead", isDead)
	else
		-- DropPlayer(src, "Karakter bilgileriniz bulunamadı oyuna tekrar giriniz!")
		TriggerClientEvent("QBCore:Notify", src, 'Your character information could not be found, please try exiting the game and logging in again..', "primary", 15000)
	end
end)

RegisterServerEvent('esx_ambulancejob_hastakayit')
AddEventHandler('esx_ambulancejob_hastakayit', function(hasta, aciklama, doktorisim)
	local src = source
	exports.oxmysql:execute("INSERT INTO tgiann_hastane_kayit (`doktor`, `hasta`, `aciklama`, `tarih`) VALUES(@doktor, @hasta, @aciklama, @tarih);", {
		['@doktor'] = doktorisim,
		['@hasta'] = hasta,
		['@aciklama'] = aciklama,
		['@tarih'] = os.date('%Y-%m-%d %H:%M:%S', os.time()),
	}, function()
		TriggerClientEvent("QBCore:Notify", src, 'Registered Patient Named' .. hasta)
	end)
end)

QBCore.Functions.CreateCallback('esx_ambulancejob_hastakayitdata', function(source, cb)
	exports.oxmysql:execute('SELECT * FROM tgiann_hastane_kayit ORDER BY `id` DESC LIMIT 30', {}, function(results)
		cb(results)
    end)
end)

Citizen.CreateThread(function()
	exports.oxmysql:execute('SELECT * FROM tgiann_hastane_kayit', {}, function(results)
		if #results - 30 > 0 then
			for i=1, #results - 30 do
				exports.oxmysql:scalar("DELETE FROM tgiann_hastane_kayit WHERE id = @id", {
					['@id'] = results[i].id
				}) 
			end
		end
    end)
end)

QBCore.Functions.CreateCallback('tgiann-ambulance:check-player-name', function(source, cb, target)
	local xPlayer = QBCore.Functions.GetPlayer(target)
	cb(xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname)
end)