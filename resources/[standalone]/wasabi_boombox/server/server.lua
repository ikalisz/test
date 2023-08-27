QBCore = nil

local Webhook = "WEBHOOK_HERE" -- Put your Discord webhook here to log Play and Saves
local BotUsername = "Wasabi Boombox" -- Name for the Bot


    QBCore = exports['qb-core']:GetCoreObject()



    QBCore.Functions.CreateUseableItem(Config.BoomboxItem, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('wasabi_boombox:useBoombox', source)
        Player.Functions.RemoveItem(Config.BoomboxItem, 1)
    end)


RegisterServerEvent('wasabi_boombox:deleteObj', function(netId)
    TriggerClientEvent('wasabi_boombox:deleteObj', -1, netId)
end)

    RegisterServerEvent('wasabi_boombox:objDeleted', function()
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.BoomboxItem, 1)
    end)


RegisterNetEvent("wasabi_boombox:soundStatus")
AddEventHandler("wasabi_boombox:soundStatus", function(type, musicId, data)
    TriggerClientEvent("wasabi_boombox:soundStatus", -1, type, musicId, data)
end)

RegisterNetEvent("wasabi_boombox:syncActive")
AddEventHandler("wasabi_boombox:syncActive", function(activeRadios)
    TriggerClientEvent("wasabi_boombox:syncActive", -1, activeRadios)
end)

    RegisterServerEvent('wasabi_boombox:save')
    AddEventHandler('wasabi_boombox:save', function(name, link)
        local Player = QBCore.Functions.GetPlayer(source)
        local CitizenId = Player.PlayerData.citizenid
        SongConfirmed(16448250, "Save Song Log", "Player Name: **"..GetPlayerName(source).."**\n  Player CitizenID: " .. CitizenId .."**\n Song Name: **"..name.."**\n Song Link: **"..link.."**\n Date: "..os.date("** Time: %H:%M Date: %d.%m.%y **").."", "Made by Andistyler")
        exports.oxmysql:execute('INSERT INTO `boombox_songs` (`citizenid`, `label`, `link`) VALUES (@citizenid, @label, @link)', {
            ['@citizenid'] = CitizenId,
            ['@label'] = name,
            ['@link'] = link
        })
    end)



    RegisterServerEvent('wasabi_boombox:deleteSong')
    AddEventHandler('wasabi_boombox:deleteSong', function(data)
        local Player = QBCore.Functions.GetPlayer(source)
        exports.oxmysql:execute('DELETE FROM `boombox_songs` WHERE `citizenid` = @citizenid AND label = @label AND link = @link', {
            ["@citizenid"] = Player.PlayerData.citizenid,
            ["@label"] = data.label,
            ["@link"] = data.link,
        })
    end)

    QBCore.Functions.CreateCallback('wasabi_boombox:getSavedSongs', function(source, cb)
        local savedSongs = {}
        local Player = QBCore.Functions.GetPlayer(source)
        exports.oxmysql:execute('SELECT label, link FROM boombox_songs WHERE citizenid = @citizenid', {
            ['@citizenid'] = Player.PlayerData.citizenid
        }, function(result)
            if result[1] then
                for i=1, #result do
                    table.insert(savedSongs, {label = result[i].label, link = result[i].link})
                end
            end
            if savedSongs then
                cb(savedSongs)
            else
                cb(false)
            end
        end)
    end)




    RegisterNetEvent("wasabi_boombox:DiscordKnows")
    AddEventHandler("wasabi_boombox:DiscordKnows", function(link)
        local Player = QBCore.Functions.GetPlayer(source)
        local CitizenId = Player.PlayerData.citizenid
        SongConfirmed(16448250, "Play Song Log", "Player Name: **"..GetPlayerName(source).."**\n  Player CitizenID: " .. CitizenId .."**\n Song Link: **"..link.."**\n Date: "..os.date("** Time: %H:%M Date: %d.%m.%y **").."", "Made by Andistyler")
    end)


----- Boom Box Discord Hook System -----

SongConfirmed = function(color, name, message, footer)
    if Webhook and Webhook ~= 'WEBHOOK_HERE' then
        local SongConfirmed = {
                {
                    ["color"] = color,
                    ["title"] = "**".. name .."**",
                    ["description"] = message,
                    ["footer"] = {
                        ["text"] = footer,
                    },
                }
            }

          PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = BotUsername, embeds = SongConfirmed}), { ['Content-Type'] = 'application/json' })
    end
end