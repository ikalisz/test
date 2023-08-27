QBCore.Commands = {}
QBCore.Commands.List = {}

QBCore.Commands.Add = function(name, help, arguments, argsrequired, callback, permission) -- [name] = command name (ex. /givemoney), [help] = help text, [arguments] = arguments that need to be passed (ex. {{name="id", help="ID of a player"}, {name="amount", help="amount of money"}}), [argsrequired] = set arguments required (true or false), [callback] = function(source, args) callback, [permission] = rank or job of a player
	QBCore.Commands.List[name:lower()] = {
		name = name:lower(),
		permission = permission ~= nil and permission:lower() or "user",
		help = help,
		arguments = arguments,
		argsrequired = argsrequired,
		callback = callback,
	}
end

function QBCore.Commands.Refresh(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local suggestions = {}
    if Player then
        for command, info in pairs(QBCore.Commands.List) do
            local hasPerm = IsPlayerAceAllowed(tostring(src), 'command.'..command)
            if hasPerm then
                suggestions[#suggestions + 1] = {
                    name = '/' .. command,
                    help = info.help,
                    params = info.arguments
                }
            else
                TriggerClientEvent('chat:removeSuggestion', src, '/'..command)
            end
        end
        TriggerClientEvent('chat:addSuggestions', src, suggestions)
    end
end


QBCore.Commands.Add('tp', "Teleportation", { { name = "X", help = " coordinate" }, { name = "Y", help = " coordinate" }, { name = "Z", help = "coordinate" } }, false, function(source, args)
    if args[1] and not args[2] and not args[3] then
        if tonumber(args[1]) then
        local target = GetPlayerPed(tonumber(args[1]))
        if target ~= 0 then
            local coords = GetEntityCoords(target)
            TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
        else
            TriggerClientEvent('QBCore:Notify', source, "Player Offline", 'error')
        end
    else
            local location = QBShared.Locations[args[1]]
            if location then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', source, location.x, location.y, location.z, location.w)
            else
                TriggerClientEvent('QBCore:Notify', source, "Teleport Location Wrong", 'error')
            end
        end
    else
        if args[1] and args[2] and args[3] then
            local x = tonumber((args[1]:gsub(",",""))) + .0
            local y = tonumber((args[2]:gsub(",",""))) + .0
            local z = tonumber((args[3]:gsub(",",""))) + .0
            if x ~= 0 and y ~= 0 and z ~= 0 then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
            else
                TriggerClientEvent('QBCore:Notify', source, "TP format is invalid", 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Wrong Argument", 'error')
        end
    end
end, 'admin')

QBCore.Commands.Add("setadmin", "Give a player admin or god privileges.", {{name="id", help="Player ID"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local permission = tostring(args[2]):lower()
	if Player ~= nil then
		QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/setadmin '..permission, source, Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "god")

QBCore.Commands.Add("removeadmin", "Remove permission from someone", {{name="id", help="Player ID"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		QBCore.Functions.RemovePermission(Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "god")

QBCore.Commands.Add("car", "Spawn Vehicle", {{name="model", help="Araç Modeli"}}, true, function(source, args)
	TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])
	TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/car '..args[1], source)
	-- TriggerClientEvent('QBCore:Notify', source, "" ..args[1].. " İsimli Araç Çıkartıldı", "success", 5000)
end, "admin")


QBCore.Commands.Add("debug", "Debug Mode", {}, false, function(source, args)
	TriggerClientEvent('koil-debug:toggle', source)
	TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/debug', source)
end, "admin")

QBCore.Commands.Add("dv", "Delete Vehicle", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:DeleteVehicle', source, args[1])
	TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/dv', source)
end, "admin")

QBCore.Commands.Add("tpm", "Teleport to marker", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:GoToMarker', source)
	TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/tpm', source)
end, "admin")

QBCore.Commands.Add("givemoney", "Give Money", {{name="id", help="PLAYER ID"},{name="moneytype", help="Type geld (cash, bank, crypto)"}, {name="amount", help="Amount"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/givemoney '..args[1]..' '..args[2]..' '.. args[3], source, Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("setmoney", "set money", {{name="id", help="Player ID"},{name="moneytype", help="(cash, bank)"}, {name="amount", help="Amount"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/setmoney '..args[1]..' '..args[2]..' '.. args[3], source, Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("setjob", "Give the player a job", {{name="id", help="Player ID"}, {name="job", help="Meslek"}, {name="grade", help="Rank"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		local successful = Player.Functions.SetJob(tostring(args[2]), args[3])
		if successful then 
			TriggerClientEvent('QBCore:Notify', source, "["..Player.PlayerData.name .."] New job/rank is " .. QBCore.Shared.Jobs[args[2]].grade[tonumber(args[3])].label .. "(".. QBCore.Shared.Jobs[args[2]].label ..")", "success", 15000)
			TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/setjob '..args[2]..' '..args[3], source, Player.PlayerData.source)
		else
			TriggerClientEvent('QBCore:Notify', source, "There is no such profession and there is no such level of the profession.", "error", 10000)
		end
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")


QBCore.Commands.Add("clearinv", "Empty your own or a player's inventory", {{name="id", help="Player ID"}}, false, function(source, args)
	local playerId = args[1] ~= nil and args[1] or source 
	local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
	if Player ~= nil then
		Player.Functions.ClearInventory()
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/clearinv '..playerId, source, Player.PlayerData.source)
		TriggerClientEvent('QBCore:Notify', source, "" ..playerId.. "The inventory of the player with the ID has been cleared.", "success")
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("announcement", "Do not use unless you are in a difficult situation!", {}, false, function(source, args)
	local message = table.concat(args, " ")
	local Players = QBCore.Functions.GetPlayer(source)

	TriggerClientEvent('chatMessage', -1, "Announcement | ", "success", message)
end, "admin")

QBCore.Commands.Add("hexwipe", "", {{name="hex", help="Offline Hex Wipe"}}, false, function(source, args)
    local hex = args[1] ~= nil and args[1] or source 

    exports.oxmysql:executeSync('DELETE FROM `players` WHERE `steam` = @steam', {
        ['@steam'] = hex,
    })
end, "admin")



QBCore.Commands.Add('job', 'Check Your Occupation', {}, false, function(source)
    local src = source
    local PlayerJob = QBCore.Functions.GetPlayer(src).PlayerData.job
	local Gorev = ""
    if PlayerJob.onduty == true then
        Gorev = 'On Duty'
    elseif PlayerJob.onduty == false then
        Gorev = 'Off Duty'
    end
    TriggerClientEvent('QBCore:Notify', source, string.format('Job: %s |  Rank: %s | Working Status: %s', PlayerJob.label, PlayerJob.gradelabel, Gorev ))
end)
