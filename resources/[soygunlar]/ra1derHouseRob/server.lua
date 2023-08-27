
robberies = {}

cf = {}
-- discord webhook --
cf.EnableDiscordLog = true
cf.DiscordWebhook = ''
cf.WebhookName = 'ElixirFW' --webhook name
cf.WebhookAvatarUrl = 'https://media.discordapp.net/attachments/896336475661152287/1112160815164952617/elixir.png' -- webhook avatar url
---------------------
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.TriggerCallback('ra1derHouseRob:checkItemCopsCount', function(source, cb, id)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xPlayers = QBCore.Functions.GetPlayers()

	copConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.job.name == 'police' then
			copConnected = copConnected + 1
		end
	end

	if copConnected >= Config.NeededCops then
		local levercount = xPlayer.Functions.GetItemByName(DoorItemDatabaseName)
		if levercount > 0 then
			local rob = robberExist(xPlayer.identifier, id)
			if not rob then
				cb(true)
				xPlayer.Functions.RemoveItem(Config.DoorItemDatabaseName, 1)
				TriggerEvent('DiscordBot:ToDiscord', 'evsoygunu', "Actress Tried To Break Into A House To Rob", xPlayer.PlayerData.source)
			else
				local remainingtime = os.time() - rob.robtime 
				if os.time() - rob.robtime <= Config.TimeBetween2Robs then
					cb(false)
					
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Remaining time: '.. math.floor((Config.TimeBetween2Robs - remainingtime) / 60) .. ' minutes!', "primary")
				elseif os.time() - rob.robtime > Config.TimeBetween2Robs then
					cb(true)
					xPlayer.Functions.RemoveItem(Config.DoorItemDatabaseName, 1)
					if cf.EnableDiscordLog then
						TriggerEvent('DiscordBot:ToDiscord', 'evsoygunu', "Actress Tried to Rob a House", xPlayer.PlayerData.source)
					end
				end
			end
		else
			cb(false)
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "No Pickle Bro", "error")
		end
	else
		cb(false)
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "There are not enough police in the city!", "error")
	end
end)

RegisterNetEvent("lockpicksil", function();;
	local Player = QBCore.Functions.GetPlayer(source)
	 local random = math.random(1, 10)
	 TriggerEvent('DiscordBot:ToDiscord', 'evsoygunu', "Actress Tried To Break Into A House To Rob", Player.PlayerData.source)
	 if random > 5 then 
		Player.Functions.RemoveItem("lockpick2", 1)
		TriggerClientEvent("QBCore:Notify", Player.PlayerData.source, "Pickaxe Broken", "primary")
	 end
end)



function robberExist(identifier, id)
	for k, v in ipairs(robberies) do
		if v.robber == identifier and v.houseid == id then
			return v
		end
	end
	return false
end

RegisterServerEvent('ra1derHouseRob:copsNotify')
AddEventHandler('ra1derHouseRob:copsNotify', function()
	local xPlayers = QBCore.Functions.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		end
	end
end)


RegisterServerEvent('ra1derHouseRob:copsBlip')
AddEventHandler('ra1derHouseRob:copsBlip', function(coords)
	local xPlayers = QBCore.Functions.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			TriggerClientEvent('ra1derHouseRob:copsBlipC', coords)
		end
	end
end)

RegisterServerEvent('ra1derHouseRob:kasaiptal')
AddEventHandler('ra1derHouseRob:kasaiptal', function()
		local src = source
		local kasa = math.random(950, 1800)
		local PlayerData = QBCore.Functions.GetPlayer(source)
		PlayerData.Functions.AddMoney("cash", kasa, QBCore.Key)
		TriggerClientEvent("QBCore:Notify", PlayerData.PlayerData.source, "" ..kasa.."$ out of the safe!", "success")
		TriggerEvent('DiscordBot:ToDiscord', 'evsoygunu', "İsimli Oyuncu Ev Soygununda ki kasayı açabildi ve " ..kasa.. "$ Para Buldu", PlayerData.PlayerData.source)
		local random2 = math.random(1, 100)
		if random2 > 50 then
			PlayerData.Functions.AddItem("guvenlik_karti_a", 1, QBCore.Key)
			TriggerClientEvent("QBCore:Notify", PlayerData.PlayerData.source, "You found the security card under the safe!", "success")
			TriggerEvent('DiscordBot:ToDiscord', 'evsoygunu', "İsimli Oyuncu Ev Soygununda ki kasayı açabildi ve ``Güvenlik Kartı A`` Çıkarttı", PlayerData.PlayerData.source)
		end
end)




RegisterServerEvent('ra1derHouseRob:giveItem')
AddEventHandler('ra1derHouseRob:giveItem', function(name, count, label)
		local _source = source
		local xPlayer = QBCore.Functions.GetPlayer(_source)
		xPlayer.Functions.AddItem(name, count)
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, count..'x '..label..' buldunuz.', "primary")
		TriggerEvent('DiscordBot:ToDiscord', 'evsoygunu', "İsimli Oyuncu ``" ..count.. "`` x ``" ..label.. "`` Eşyasından Buldu", xPlayer.PlayerData.source)
end)

RegisterServerEvent('ra1derHouseRob:updateRobTime')
AddEventHandler('ra1derHouseRob:updateRobTime', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	table.insert(robberies, {robber = xPlayer.identifier, robtime = os.time()})

	Citizen.Wait(Config.TimeBetween2Robs * 60000)

	for k, v in pairs(robberies) do
		if robberies[k].robber == xPlayer.identifier then
			table.remove(robberies, k)
			return
		end
	end
end)




function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end
