local Users = {}

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('esx_thief:getValue', function(source, cb, targetSID)
	if Users[targetSID] then
		cb(Users[targetSID])
	else
		cb({value = false, time = 0})
	end
end)

RegisterServerEvent('esx_thief:update')
AddEventHandler('esx_thief:update', function(bool)
	local src = source
	Users[src] = {value = bool, time = os.time()}
end)

RegisterServerEvent('esx_thief:getValue')
AddEventHandler('esx_thief:getValue', function(targetSID)
	local src = source
	if Users[targetSID] then
		TriggerClientEvent('esx_thief:returnValue', src, Users[targetSID])
	else
		TriggerClientEvent('esx_thief:returnValue', src, Users[targetSID])
	end
end)

RegisterServerEvent('tgiann:ust-ara-bildirim')
AddEventHandler('tgiann:ust-ara-bildirim', function(target_id)
	TriggerClientEvent("QBCore:Notify", target_id, 'Supreme Wanted by a Person')
end)

RegisterServerEvent('tgiann:ust-ara-bildirim-polis')
AddEventHandler('tgiann:ust-ara-bildirim-polis', function(target_id)
	TriggerClientEvent("QBCore:Notify", target_id, 'Superior Wanted by Police')
end)

RegisterServerEvent('tgiann-oyuncu-soygun:discord-log')
AddEventHandler('tgiann-oyuncu-soygun:discord-log', function(soyulan, soyan)
    TriggerEvent('DiscordBot:ToDiscord', 'diger', 'By Top Searched'.. os.date("%H:%M:%S"), soyan, soyulan)
end)

RegisterServerEvent('tgiann-oyuncu-soygun:discord-log-polis')
AddEventHandler('tgiann-oyuncu-soygun:discord-log-polis', function(soyulan, soyan)
    TriggerEvent('DiscordBot:ToDiscord', 'diger', 'By Top Searched (Police)'.. os.date("%H:%M:%S"), soyan, soyulan)
end)

QBCore.Commands.Add("stealmoney", "Steal Nearby Player's money", {{name="id", help="Player ID"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	local PlayerPos = GetEntityCoords(GetPlayerPed(source))
	local TargetId = tonumber(args[1])
	local Target = QBCore.Functions.GetPlayer(TargetId)
	local TargetPos = GetEntityCoords(GetPlayerPed(TargetId))

	if Target ~= nil then
		if #(PlayerPos - TargetPos) < 3 then
			if Target.PlayerData.money.cash >= 1 then
				if TargetId ~= source then
					TriggerClientEvent('tgiann-thief:SteelMoney', source, TargetId, Target.PlayerData.money.cash)
				else
					TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You Can't Undress Yourself!")
				end
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "The Player Has No Money!")
			end
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "The Player You Will Rob Is Not With You")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player Not Online")
	end    
end)

QBCore.Commands.Add("checkmoney", "Check Player's Money", {{name="id", help="Player ID"}}, true, function(source, args)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" then 
		local PlayerPos = GetEntityCoords(GetPlayerPed(source))
		local TargetId = tonumber(args[1])
		local Target = QBCore.Functions.GetPlayer(TargetId)
		local TargetPos = GetEntityCoords(GetPlayerPed(TargetId))
		if #(PlayerPos - TargetPos) < 3 then
			TriggerClientEvent('chatMessage', source, "Police Systems", "primary", "Player have ".. Target.PlayerData.money.cash .. "$")
		else
			TriggerClientEvent('chatMessage', source, "Police Systems", "error", "The player is not near")
		end
	else
		TriggerClientEvent('chatMessage', source, "Police Systems", "error", "Only Cops Can Use This Command")
	end
end)

RegisterServerEvent('tgiann-thief:server:stellMoney')
AddEventHandler('tgiann-thief:server:stellMoney', function(trgtId, money)
	local Target = QBCore.Functions.GetPlayer(trgtId)
	local Player = QBCore.Functions.GetPlayer(source)
	if Target then
		local amount = money
		Target.Functions.RemoveMoney('cash', amount)
		Player.Functions.AddMoney('cash', amount)
		TriggerClientEvent('QBCore:Notify', trgtId, "A Player $" .. amount .. " You Get Your Cash", 'success')
		TriggerClientEvent('QBCore:Notify', source, "You Receive A Player's $" .. amount .. " Cash", 'success')
		TriggerEvent('DiscordBot:ToDiscord', 'diger', 'Stole His Money $'..amount, source, trgtId)
	end
end)