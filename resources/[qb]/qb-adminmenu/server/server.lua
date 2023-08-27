-- Variables
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local frozen = false
local permissions = {
    ['kill'] = 'god',
    ['ban'] = 'admin',
    ['noclip'] = 'admin',
    ['kickall'] = 'admin',
    ['kick'] = 'admin'
}


-- Get Dealers
QBCore.Functions.CreateCallback('test:getdealers', function(source, cb)
    cb(exports['qb-drugs']:GetDealers())
end)



-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source

        }
    end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(players, function(a, b)
            return a.id < b.id
        end)
        ------
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    local src = source
    if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions

local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Events

RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source
        }
    end
    TriggerClientEvent('qb-admin:client:Show', src, players)
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-adminmenu:kill', player.id)
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "Named Admin " ..player.id.. " ID player with admin Event **KILLED**", PlayerData.PlayerData.source)
end)

QBCore.Commands.Add('kill', 'Kill a player', {}, false, function(source, args)
    local PlayerData = QBCore.Functions.GetPlayer(source)
	if args[1] == nil then
		TriggerClientEvent('qb-adminmenu:kill', source)
        -- TriggerClientEvent('QBCore:Notify', src, "" ..source.. " ID'li oyuncu öldürüldü", 'success', 5000)
	else
        TriggerClientEvent('qb-adminmenu:kill', tonumber(args[1]))
        -- TriggerClientEvent('QBCore:Notify', src, "" ..args[1].. " ID'li oyuncu öldürüldü", 'success', 5000)
	end
end)


RegisterNetEvent('qb-admin:server:revive', function(player)
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('esx_ambulancejob:revive', player.id)
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin " ..player.id.. " **REVIEW** the player with the ID with the admin event", PlayerData.PlayerData.source)
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason, playerId)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    local xTarget = QBCore.Functions.GetPlayer(playerId)
    if QBCore.Functions.HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command')  then
        -- TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin" ..player.id.. "ID'li " ..GetPlayerName(player).. " İsimli Oyuncuyu " ..reason.. "Sebebiyle Kickledi", PlayerData.PlayerData.source)
        -- TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "Named Admin ``" ..player.id.. "`` with ID ``" ..GetPlayerName(src).. "`` Player Named Steam``" ..reason.. "`` Kicked because of ", PlayerData.PlayerData.source)
        DropPlayer(player.id, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. QBCore.Config.Server.discord)
    end
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    if QBCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
        exports.oxmysql:execute('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            QBCore.Functions.GetIdentifier(player.id, 'license'),
            QBCore.Functions.GetIdentifier(player.id, 'discord'),
            QBCore.Functions.GetIdentifier(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })
        TriggerClientEvent('chat:addMessage', -1, {
            template = "<div class=chat-message server'><strong>Announcement | {0} Banned:</strong> {1}</div>",
            args = {GetPlayerName(player.id), reason}
        })
        -- TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "Named Admin ``" ..player.id.. "`` Player ID ``" ..GetPlayerName(src).. "`` Player Named Steam ``" ..reason.. "`` Banned due to ", PlayerData.PlayerData.source)
        if banTime >= 2147483647 then
            DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. QBCore.Config.Server.discord)
        else
            DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
        end
    end
end)

RegisterNetEvent('qb-admin:server:spectate')
AddEventHandler('qb-admin:server:spectate', function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

-- QBCore.Commands.Add('spectate', 'Bir oyuncuyu izle.', {}, false, function(source, args)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local targetped = GetPlayerPed(args[1])
--     local coords = GetEntityCoords(targetped)
--     if Player ~= nil then
--         -- if targetped ~= then 
--         TriggerClientEvent('qb-admin:client:spectate', src, targetped, coords)
--         TriggerClientEvent('QBCore:Notify', src, ""..args[1].. " ID'li oyuncu izleniyor.")
--         -- else
--             -- TriggerClientEvent('QBCore:Notify', src, "Bir ID Girmelisin")
--         -- end
--     else
--         TriggerClientEvent('QBCore:Notify', src, "Oyuncu Aktif Değil!.")
--     end
-- end)

RegisterNetEvent('qb-admin:server:freeze')
AddEventHandler('qb-admin:server:freeze', function(player)
    local PlayerData = QBCore.Functions.GetPlayer(source)
    local target = GetPlayerPed(player.id)
    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
        TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "Named Admin " ..player.id.. " ``FREEZE`` the player with the ID with the admin event", PlayerData.PlayerData.source)
    else
        frozen = false
        FreezeEntityPosition(target, false)
    end
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    SetEntityCoords(admin, coords)
    -- TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
    TriggerClientEvent("noclip:open", src)
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "Named Admin " ..player.id.. " ``Teleported`` to the player with ID.", PlayerData.PlayerData.source)
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    -- local coords = GetEntityCoords(GetPlayerPed(player.id))
    local targetPed = GetPlayerPed(player.id)
    local vehicle = GetVehiclePedIsIn(targetPed,false)
    local seat = -1
    if vehicle ~= 0 then
        for i=0,8,1 do
            if GetPedInVehicleSeat(vehicle,i) == 0 then
                seat = i
                break
            end
        end
        if seat ~= -1 then
            SetPedIntoVehicle(admin,vehicle,seat)
            TriggerClientEvent('QBCore:Notify', src, Lang:t("sucess.entered_vehicle"), 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_free_seats"), 'danger', 5000)
        end
    end
end)


RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    SetEntityCoords(target, coords)
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin " ..player.id.. " ID'li oyuncuyu "..coords.. " Kordinatına ``Yanına Çekti``", PlayerData.PlayerData.source)
end)

QBCore.Commands.Add('bring', 'Help Text', {}, false, function(source, args, rawCommand)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(args[1])
    SetEntityCoords(target, coords)
    TriggerClientEvent('QBCore:Notify', src, "" ..args[1].. " ID'li oyuncu yanına getirildi", 'success', 5000)
end, "admin")

RegisterNetEvent('qb-admin:server:inventory', function(player)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:inventory', src, player.id)
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin " ..player.id.. " ID'li ``" ..PlayerData.PlayerData.name.."`` İsimli Oyuncunun ``ENVANTERİNİ AÇTI``", PlayerData.PlayerData.source)
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('raidClothing:adminEvent', player.id)
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin " ..player.id.. " ID'li oyuncuya ``Kıyafet Menüsü Verdi``", PlayerData.PlayerData.source)
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        QBCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.rank_level")..group[1].label)
        TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin " ..targetId.. " ID'li oyuncuya ``" ..group[1].rank.. ":`` İsimli Yetkiyi Verdi.", PlayerData.PlayerData.source)
    end
end)

RegisterNetEvent('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.admin_report")..name..' ('..targetSrc..')', msg}
            })
        end
    end
end)

RegisterNetEvent('qb-admin:server:Staffchat:addMessage', function(name, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, Lang:t("info.staffchat")..name, 'error', msg)
        end
    end
end)

QBCore.Commands.Add('staff', "Yetkili Mesajı Gönder", {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    local name = GetPlayerName(source)

    local plrs = QBCore.Functions.GetPlayers()

    for i = 1, #plrs, 1 do
        local plr = plrs[i]
        if QBCore.Functions.HasPermission(plr, 'admin') or IsPlayerAceAllowed(plr, 'command') then
            if QBCore.Functions.IsOptin(plr) then
                TriggerClientEvent('chat:addMessage', plr, {
                    color = {255, 255, 0},
                    multiline = true,
                    args = {"Yetkili Chat ; "..name, msg}
                })
            end
        end
    end
end, 'admin')



-- Commands

QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end, 'admin')

QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleNames', src)
end, 'admin')

QBCore.Commands.Add('coords', Lang:t("commands.coords_dev_command"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end, 'admin')

QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
end, 'admin')



QBCore.Commands.Add('adminmenu', Lang:t("commands.open_admin"), {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:openMenu1', source)
end, 'admin')

QBCore.Commands.Add('report', Lang:t("info.admin_report"), {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(src), src, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)

QBCore.Commands.Add('givenuifocus', Lang:t("commands.nui_focus"), {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')

-- QBCore.Commands.Add('warn', Lang:t("commands.warn_a_player"), {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
--     local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     local senderPlayer = QBCore.Functions.GetPlayer(source)
--     table.remove(args, 1)
--     local msg = table.concat(args, ' ')
--     local myName = senderPlayer.PlayerData.name
--     local warnId = 'WARN-'..math.random(1111, 9999)
--     if targetPlayer ~= nil then
-- 		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", Lang:t("info.warning_chat_message")..GetPlayerName(source).."," .. Lang:t("info.reason") .. ": "..msg }, color = 255, 0, 0 })
-- 		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", Lang:t("info.warning_staff_message")..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
--         exports.oxmysql:execute('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
--             senderPlayer.PlayerData.license,
--             targetPlayer.PlayerData.license,
--             msg,
--             warnId
--         })
--     else
--         TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
--     end
-- end, 'admin')

-- QBCore.Commands.Add('checkwarns', Lang:t("commands.check_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
--     if args[2] == nil then
--         local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--         local result = exports.oxmysql:execute('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
--         TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has '..tablelength(result)..' warnings!')
--     else
--         local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--         local warnings = exports.oxmysql:execute('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
--         local selectedWarning = tonumber(args[2])
--         if warnings[selectedWarning] ~= nil then
--             local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
--             TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason)
--         end
--     end
-- end, 'admin')

-- QBCore.Commands.Add('delwarn', Lang:t("commands.delete_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
--     local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     local warnings = exports.oxmysql:execute('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
--     local selectedWarning = tonumber(args[2])
--     if warnings[selectedWarning] ~= nil then
--         local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
--         TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason)
--         exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
--     end
-- end, 'admin')

QBCore.Commands.Add('reportr', Lang:t("commands.reply_to_report"), {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args, rawCommand)
    local src = source
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    if not QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') ~= 1 then return end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Reply Sent')
    -- TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end, 'admin')

QBCore.Commands.Add('pedver', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end
end, 'admin')


QBCore.Commands.Add('reporttoggle', Lang:t("commands.report_toggle"), {}, false, function(source, args)
    local src = source
    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.receive_reports"), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_receive_report"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('kickall', Lang:t("commands.kick_all"), {}, false, function(source, args)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
            if reason and reason ~= '' then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t("info.no_reason_specified"), 'error')
            end
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, Lang:t("info.server_restart") .. QBCore.Config.Server.digotoscord)
            end
        end
    end
end, 'god')

