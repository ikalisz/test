QBCore = nil


TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason, key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local targetSrc = QBCore.Functions.GetPlayer(targetSrc)
		TriggerClientEvent("esx-qalle-jail:jailPlayer", targetSrc.PlayerData.source, jailTime)
		EditJailTime(targetSrc, jailTime)
		TriggerClientEvent("QBCore:Notify", src, targetSrc.PlayerData.charinfo.firstname .." ".. targetSrc.PlayerData.charinfo.lastname .. " " .. jailTime .." Sentenced")
		TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Hapis Cezası Verdi! Adet: '..jailTime, src,  targetSrc.PlayerData.source)
	end
end)




RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier, key)
	local src = source
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local tPlayer = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
		if tPlayer  then
			TriggerClientEvent("esx-qalle-jail:unJailPlayer", tPlayer.PlayerData.source)
			EditJailTime(tPlayer, 0)
			TriggerClientEvent("QBCore:Notify", tPlayer.PlayerData.source, " Released!")
			TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Hapis Cezasını İptal Etti!', src, tPlayer.PlayerData.source)
		end	
	end
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local src = source
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			local para = math.random(1, 5)
			xPlayer.Functions.AddMoney('cash', para, "Jail money")
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "By Prison Administration ".. para .. "$ Cash Given!")
			EditJailTime(xPlayer, newJailTime)
		end
	end
end)

function EditJailTime(jailPlayer, jailTime)
	jailPlayer.Functions.SetMetaData("jailtime", jailTime)
	if jailTime == 0 then
		jailPlayer.Functions.SetMetaData("injail", false)
	else
		jailPlayer.Functions.SetMetaData("injail", true)
	end
end

QBCore.Functions.CreateCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	local jailedPersons = {}
	for k, id in pairs(QBCore.Functions.GetPlayers()) do
		local xPlayer = QBCore.Functions.GetPlayer(id)
		if xPlayer.PlayerData.metadata.injail then
			table.insert(jailedPersons, { name = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname, jailTime = xPlayer.PlayerData.metadata.jailtime, identifier = xPlayer.PlayerData.citizenid })
		end
	end
	cb(jailedPersons)
end)

RegisterServerEvent("esx-qalle-jail:server:closest-player-un-jail")
AddEventHandler("esx-qalle-jail:server:closest-player-un-jail", function(GetClosestPlayer, coord)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(GetClosestPlayer)
	if xPlayer then
		TriggerClientEvent("esx-qalle-jail:client:closest-player-un-jail", GetClosestPlayer, src, xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname, coord)
	end
end)

RegisterServerEvent("esx-qalle-jail:server:closest-player-un-jail-confrim")
AddEventHandler("esx-qalle-jail:server:closest-player-un-jail-confrim", function(player)
	local xPlayer = QBCore.Functions.GetPlayer(player)
	TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Kidnapped Nearby Player From Jail!")
	xPlayer.Functions.RemoveItem('hackcoin', 1)
end)

RegisterServerEvent("jail:yiyecekal", function()
	src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	info = {}
	info.type = "yemek"
	info.durubality = os.time() - math.random(145000, 155000)
	xPlayer.Functions.AddItem("friesxl", 1, nil, info)
	xPlayer.Functions.AddItem("kola", 1, nil, info)
end)

RegisterServerEvent("jail:phoneverabi", function()
	local src = source 
	local PlayerData = QBCore.Functions.GetPlayer(src)
	if PlayerData.Functions.RemoveMoney("cash", 100) then 
	Wait(100)
	TriggerClientEvent("QBCore:Notify", src, "100$ You got a phone in return")
	PlayerData.Functions.AddItem("white_phone", 1)
	else
		TriggerClientEvent("QBCore:Notify", src, "You do not have money")
	end
end)


RegisterServerEvent("jail:removemoney", function()
	src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	xPlayer.Functions.RemoveMoney("cash", 8, "Jail Money Removed!")
end)

