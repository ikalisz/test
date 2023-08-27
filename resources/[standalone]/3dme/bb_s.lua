QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("me", "", {}, false, function(source, args)
	local src = source
	local xPlayer =  QBCore.Functions.GetPlayer(source)
	local name = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
	args = table.concat(args, ' ')
	TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, src, args, "me", name)
    TriggerEvent('DiscordBot:ToDiscord', 'medo', '/me ' .. args, src)
end)

QBCore.Commands.Add("do", "", {}, false, function(source, args)
	local src = source
	local xPlayer =  QBCore.Functions.GetPlayer(source)
	local name = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
	args = table.concat(args, ' ')
	TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, src, args, "do", name)
	TriggerEvent('DiscordBot:ToDiscord', 'medo', '/do ' .. args, src)
end)

RegisterServerEvent('3dme:display')
AddEventHandler('3dme:display', function(text, key, mod, name, target, mask)
    local src = source
	if name == "self" then
		local Player = QBCore.Functions.GetPlayer(src)
		name = Player.PlayerData.charinfo.firstname .." ".. Player.PlayerData.charinfo.lastname
	end
	if target ~= nil then src = target end
    -- if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		if mod == nil then mod = "me" end
        TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, src, text, mod, name)
		-- TriggerEvent('DiscordBot:ToDiscord', 'medo', '/'..mod..' ' .. text, src)s
    -- end
end)

RegisterServerEvent('3dme:server:tgiann-doctor')
AddEventHandler('3dme:server:tgiann-doctor', function(text, coords, key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		TriggerClientEvent('3dme:client:tgiann-doctor', -1, text, coords)
	end
end)


-- RegisterServerEvent('3dme:shareDisplay')
-- AddEventHandler('3dme:shareDisplay', function(text, target, meOrdo)
-- 	local src = source
-- 	local srcCoords = GetEntityCoords(GetPlayerPed(src))
-- 	local targetCoords = GetEntityCoords(GetPlayerPed(target))
-- 	local dist = #(srcCoords - targetCoords)
-- 	if dist > 30.0 then 
-- 		-- print('^1'..src..' - '..GetPlayerIdentifier(src, 0)..' - '..text..'^0')
-- 		return
-- 	end
-- 	local xPlayer = QBCore.Functions.GetPlayer(src)
-- 	local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
-- 	if xPlayer ~= nil then
-- 		TriggerClientEvent('chat:addMessage', target, {
-- 			template = '<div class="chat-message ooc"><b>{0}</b></div>',
-- 			args = {'OOC | '..name..': '..text}
-- 		})
-- 	end
-- end)