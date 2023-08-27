QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function(key)
	local src = source 
	if QBCore.Functions.kickHacKer(src, key) then
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			xPlayer.Functions.SetMetaData("communityservice", 0)
			TriggerClientEvent('esx_communityservice:finishCommunityService', xPlayer.PlayerData.source)
		end
	end
end)

RegisterServerEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(player, count, key)
	local src = source 
	if QBCore.Functions.kickHacKer(src, key) then
		local tPlayer = QBCore.Functions.GetPlayer(player)
		TriggerClientEvent("esx_communityservice:inCommunityService", player, count)
		tPlayer.Functions.SetMetaData("communityservice", count)
		TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Kamu Cezası Verdi! Adet: '..count, src, player)
	end
end)

RegisterServerEvent('esx_communityservice:completeService')
AddEventHandler('esx_communityservice:completeService', function(key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			xPlayer.Functions.SetMetaData("communityservice", xPlayer.PlayerData.metadata["communityservice"] - 1)
		end
	end
end)

RegisterServerEvent('esx_communityservice:extendService') -- Alandan Uzaklaşınca Kamu Arttırma
AddEventHandler('esx_communityservice:extendService', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		xPlayer.Functions.SetMetaData("communityservice", xPlayer.PlayerData.metadata["communityservice"] + Config.ServiceExtensionOnEscape)
	end
end)

QBCore.Commands.Add("comserv", "Punish a Player with a Public Penalty", {{name="id", help="Player ID"}, {name="Amount", help="Amount of Command Penalty to be Given"}}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.job.name == "police" then
		local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if tPlayer then
			local count = tonumber(args[2])
			TriggerClientEvent("esx_communityservice:inCommunityService", tPlayer.PlayerData.source, count)
			tPlayer.Functions.SetMetaData("communityservice", count)
			TriggerClientEvent("QBCore:Notify", src, "Player Sentenced to Public Penalty")
			TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Kamu Cezası Verdi! Adet: '..count, src, tonumber(args[1]))
		else
			TriggerClientEvent("QBCore:Notify", src, "There Is No Such Player!", "error")
		end
	else
		TriggerClientEvent("QBCore:Notify", src, "You have to be a cop to give public?", "error")
	end
end)

--RegisterCommand('kamutest', function(source)
--	local tPlayer = QBCore.Functions.GetPlayer(source)
--	TriggerClientEvent("esx_communityservice:inCommunityService", tPlayer.PlayerData.source, 1)
--	tPlayer.Functions.SetMetaData("communityservice", 1)
--end)

QBCore.Commands.Add("endcomserv", "Cancel a Player's Public Penalty", {{name="id", help="Player ID"}}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" then
		local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if tPlayer then
			tPlayer.Functions.SetMetaData("communityservice", 0)
			TriggerClientEvent('esx_communityservice:finishCommunityService', tPlayer.PlayerData.source)
			TriggerClientEvent("QBCore:Notify", source, "Player's Public Sentence Cancelled")
			TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Kamu Cezası İptal Etti!', source, tonumber(args[1]))
		else
			TriggerClientEvent("QBCore:Notify", source, "There Is No Such Player!", "error")
		end
	else
		TriggerClientEvent("QBCore:Notify", src, "You have to be a cop to lift a public fine!!", "error")
	end
end)