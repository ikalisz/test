

AddEventHandler('playerDropped', function(reasons) 
	local src = source
	local reason = reasons
	if src == nil then return end
	local Name = GetPlayerName(src)
	local Ip = GetPlayerEP(src)
	local discord = nil
	local idedentifier = {}
	local idedentifier = GetPlayerIdentifiers(source) 
	for i=1, #idedentifier do
		if string.find(idedentifier[i], "discord") then
			discord = string.sub(idedentifier[i], 9)
		end
	end

	if idedentifier[1] == nil then idedentifier[1] = "Identifier Unknown" end
	if reason == nil then reason = "Why Not Known" end
	if discord == nil then discord = "DC Unknown" end
	if Ip == nil then Ip = "IP Unknown" end
	if Name == nil then Name = "Name Unknown" end
	if reason ~= "Reconnecting" and src > 60000 then return false end
	local player = QBCore.Players[src]
	if(src==nil or (player == nil)) then return false end
	local gircik = player.PlayerData.metadata.sure
	if gircik == nil then gircik = 0 end
	QBCore.Players[src].PlayerData.metadata.surefull = QBCore.Players[src].PlayerData.metadata.surefull + gircik
	local sure = "**".. gircik .. " / " .. player.PlayerData.metadata.surefull .."** "
	-- QBCore.Debug(GetCurrentResourceName(), 'error', '^7["'..src..'"/"'..Name..'"/"'..Ip..'"/"'..idedentifier[1]..'"]^1 Sunucudan ayrildi! Neden: '..reason)
	TriggerEvent("DiscordBot:ToDiscord", 'giriscikis', '**ID: '..src..'** **Steam Name:** '..Name..' **Steam Hex:** '..idedentifier[1]..'\n**Discord:** <@'.. discord ..'> **Ayrılma Nedeni:** '..reason..' **Dakika(Gir Çık/Full):** '.. sure ..' Sunucudan ayrıldı!')
	player.PlayerData.metadata.sure = 0
	player.Functions.Save()
	QBCore.Players[src] = nil
end)



RegisterServerEvent("QBCore:server:CloseServer")
AddEventHandler('QBCore:server:CloseServer', function(reason)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if QBCore.Functions.HasPermission(source, "admin") or QBCore.Functions.HasPermission(source, "god") then 
        local reason = reason ~= nil and reason or "No reason given..."
        QBCore.Config.Server.closed = true
        QBCore.Config.Server.closedReason = reason
        TriggerClientEvent("qbadmin:client:SetServerStatus", -1, true)
	else
		QBCore.Functions.Kick(src, "You are not authorized to use this command!", nil, nil)
    end
end)

RegisterServerEvent("QBCore:server:OpenServer")
AddEventHandler('QBCore:server:OpenServer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if QBCore.Functions.HasPermission(source, "admin") or QBCore.Functions.HasPermission(source, "god") then
        QBCore.Config.Server.closed = false
        TriggerClientEvent("qbadmin:client:SetServerStatus", -1, false)
    else
        QBCore.Functions.Kick(src, "You are not authorized to use this command!", nil, nil)
    end
end)

RegisterServerEvent("QBCore:UpdatePlayer")
AddEventHandler('QBCore:UpdatePlayer', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.PlayerData.position = data.position
		local newHunger = Player.PlayerData.metadata["hunger"] - 2
		local newThirst = Player.PlayerData.metadata["thirst"] - 4
		if newHunger <= 0 then newHunger = 0 end
		if newThirst <= 0 then newThirst = 0 end
		Player.Functions.SetMetaData("thirst", newThirst)
		Player.Functions.SetMetaData("hunger", newHunger)
		TriggerClientEvent("hud:client:UpdateNeeds", src, newHunger, newThirst)
		Player.Functions.Save()
	end
end)

RegisterServerEvent("QBCore:job-money")
AddEventHandler('QBCore:job-money', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local citizenid = Player.PlayerData.citizenid
	if Player ~= nil then
		local money = Player.PlayerData.job.payment
		if Player.PlayerData.job.paySafe then
			if QBCore.Functions.removeJobMoney(Player.PlayerData.job.name, money) then
				TriggerEvent('ra1derPaycheck:server:AddMoneyToPayCheck', citizenid,money,Player.PlayerData.job.name)
				TriggerClientEvent('QBCore:Notify', src, "Your salary of " ..money.. "$ is Deposited to the Central Bank")
			else
				TriggerClientEvent('QBCore:Notify', src, "Your Salary Could Not Be Deposited Because There Is Not Enough Money In The Company Account!")
			end
		else
            TriggerEvent('ra1derPaycheck:server:AddMoneyToPayCheck', citizenid,money,Player.PlayerData.job.name)
			TriggerClientEvent('QBCore:Notify', src, "Your Salary" ..money.. "Deposited in the Central Bank as $")
		end
	end
end)




RegisterServerEvent("QBCore:UpdatePlayerPosition")
AddEventHandler("QBCore:UpdatePlayerPosition", function(position)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.PlayerData.position = position
	end
end)

RegisterServerEvent("QBCore:Server:TriggerCallback")
AddEventHandler('QBCore:Server:TriggerCallback', function(name, requestId, ...)
	local src = source
	QBCore.Functions.TriggerCallback(name, requestId, src, function(...)
		TriggerClientEvent("QBCore:Client:TriggerCallback", src, requestId, ...)
	end, ...)
end)

RegisterServerEvent("QBCore:Server:UseItem")
AddEventHandler('QBCore:Server:UseItem', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if item ~= nil and item.amount > 0 then
		if QBCore.Functions.CanUseItem(item.name) then
			TriggerEvent('DiscordBot:ToDiscord', 'itemkul', "Item Used: "..item.label, src)
			QBCore.Functions.UseItem(src, item)
		end
	end
end)

RegisterServerEvent("QBCore:Server:RemoveItem")
AddEventHandler('QBCore:Server:RemoveItem', function(itemName, amount, slot)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(itemName, amount, slot)
	-- TriggerClientEvent('inventory:client:ItemBox', src, , itemName, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
end)

RegisterServerEvent("QBCore:Server:AddItem")
AddEventHandler('QBCore:Server:AddItem', function(itemName, amount, slot, info)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(itemName, amount, slot, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add")
end)

RegisterServerEvent('QBCore:Server:SetMetaData')
AddEventHandler('QBCore:Server:SetMetaData', function(meta, data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if meta == "hunger" or meta == "thirst" then
		if data > 100 then
			data = 100
		end
	end
	if Player ~= nil then 
		Player.Functions.SetMetaData(meta, data)
	end
	TriggerClientEvent("hud:client:UpdateNeeds", src, Player.PlayerData.metadata["hunger"], Player.PlayerData.metadata["thirst"])
end)

AddEventHandler('chatMessage', function(source, n, message)
	if string.sub(message, 1, 1) == "/" then
		local args = QBCore.Shared.SplitStr(message, " ")
		local command = string.gsub(args[1]:lower(), "/", "")
		CancelEvent()
		if QBCore.Commands.List[command] ~= nil then
			local Player = QBCore.Functions.GetPlayer(tonumber(source))
			if Player ~= nil then
				table.remove(args, 1)
				if (QBCore.Functions.HasPermission(source, "admin") or (QBCore.Functions.HasPermission(source, "god") or QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission))) then
					if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
					    TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Argümanlar Boş Olamaz!")
					    local agus = ""
					    for name, help in pairs(QBCore.Commands.List[command].arguments) do
					    	agus = agus .. " ["..help.name.."]"
					    end
				        TriggerClientEvent('chatMessage', source, "/"..command, false, agus)
					else
						QBCore.Commands.List[command].callback(source, args)
					end
				else
					-- TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Bu Komutu Kullanmak İçin Yetkin Yok!")
					TriggerClientEvent('QBCore:Notify', source, "You Are Not Authorized To Use This Command!", "error", 5000)
				end
			end
		end
	end
end)


RegisterServerEvent('QBCore:CallCommand')
AddEventHandler('QBCore:CallCommand', function(command, args)
	if QBCore.Commands.List[command] ~= nil then
		local Player = QBCore.Functions.GetPlayer(tonumber(source))
		if Player ~= nil then
			if (QBCore.Functions.HasPermission(source, "god")) or (QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission)) or (QBCore.Commands.List[command].permission == Player.PlayerData.job.name) then
				if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
					TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Arguments Cannot Be Empty!")
					local agus = ""
					for name, help in pairs(QBCore.Commands.List[command].arguments) do
						agus = agus .. " ["..help.name.."]"
					end
					TriggerClientEvent('chatMessage', source, "/"..command, false, agus)
				else
					QBCore.Commands.List[command].callback(source, args)
				end
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Not Authorized to Use This Command!")
			end
		end
	end
end)

RegisterServerEvent("QBCore:AddCommand")
AddEventHandler('QBCore:AddCommand', function(name, help, arguments, argsrequired, callback, persmission)
	QBCore.Commands.Add(name, help, arguments, argsrequired, callback, persmission)
end)

RegisterServerEvent("QBCore:ToggleDuty")
AddEventHandler('QBCore:ToggleDuty', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.onduty then
		Player.Functions.SetJobDuty(false)
		TriggerClientEvent('QBCore:Notify', src, "You're now OFF DUTY!", "error")
	else
		Player.Functions.SetJobDuty(true)
		TriggerClientEvent('QBCore:Notify', src, "You're now ON DUTY!", "success")
	end
	TriggerClientEvent("QBCore:Client:SetDuty", src, Player.PlayerData.job.onduty)
end)

Citizen.CreateThread(function()
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `permissions`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				QBCore.Config.Server.PermissionList[v.steam] = {
					steam = v.steam,
					license = v.license,
					permission = v.permission,
					optin = true,
				}
			end
		end
	end)
end)

QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, itemName)
	local retval = false
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)	

QBCore.Functions.CreateCallback('QBCore:HasAdminPerm', function(source, cb, perm)
	if QBCore.Functions.HasPermission(source, "god") or QBCore.Functions.HasPermission(source, "admin") or QBCore.Functions.HasPermission(source, "mod") then 
		cb(true)
	else
		cb(false)
	end
end)

QBCore.Functions.CreateCallback("QBCore:SpawnCar", function(source, cb, model, coords)
	local spawned_car = CreateVehicle(model, coords.x, coords.y, coords.z, coords.h, true, true)
	local osTime = os.time()
	while not DoesEntityExist(spawned_car) do 
		Citizen.Wait(0) 
		if os.time() > osTime + 5 then break end
	end
    cb(NetworkGetNetworkIdFromEntity(spawned_car))
end)