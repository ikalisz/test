QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('tgiann-hacker:hackparasi')
AddEventHandler('tgiann-hacker:hackparasi', function(verilenPara, key)
    local source = source
    if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            xPlayer.Functions.AddMoney("cash", verilenPara)
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'You Won Some Money $'.. verilenPara)
            TriggerEvent('DiscordBot:ToDiscord', 'eventpara', 'tgiann-hacker paraver ' .. verilenPara.. '$', source)
        end
    end
end)

RegisterServerEvent('tgiann-hacker:coin')
AddEventHandler('tgiann-hacker:coin', function(key)
    local source = source
    if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            local item = xPlayer.Functions.GetItemByName("hackcoin")
            local amount = item.amount
            if amount > 0 then
                if xPlayer.Functions.RemoveItem("hackcoin", amount) then
                    xPlayer.Functions.AddMoney('cash', math.random(90,110)*amount)
                end
            else
                TriggerClientEvent("QBCore:Notify", source, 'No V Coins On It!')
            end
        end
    end
end)

RegisterServerEvent('tgiann-hacker:tabletsil')
AddEventHandler('tgiann-hacker:tabletsil', function(item)
	local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.Functions.RemoveItem(item, 1, xPlayer.Functions.GetItemByName(item).slot)
    end
end)

QBCore.Functions.CreateCallback('elixir-base:hack-kontrol', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        cb(os.time() - xPlayer.PlayerData.metadata["fallouthacktime"])
    end
end)

RegisterServerEvent('tgiann-hacker:pc-hack-guncelle')
AddEventHandler('tgiann-hacker:pc-hack-guncelle', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.SetMetaData("fallouthacktime", os.time())
end)

QBCore.Functions.CreateCallback('tgiann-hacker:numara-kontrol', function(source, cb, number)
    local xPlayer = QBCore.Functions.GetPlayerByPhone(number)
    if xPlayer then
        cb(xPlayer)
    else
        cb(false)
    end
end)

RegisterServerEvent('tgiann-hacker:hacksayiekle')
AddEventHandler('tgiann-hacker:hacksayiekle', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name then -- QBCore.Key
        xPlayer.Functions.SetMetaData("hackcount", xPlayer.PlayerData.metadata["hackcount"] + 1)
    end
end)

QBCore.Functions.CreateUseableItem('hackv1', function(source)
    TriggerClientEvent("tgiann-hacker:open-tablet", source, "hackv1")
end)

QBCore.Functions.CreateUseableItem('hackv2', function(source)
    TriggerClientEvent("tgiann-hacker:open-tablet", source, "hackv2")
end)

QBCore.Functions.CreateUseableItem('hackv3', function(source)
    TriggerClientEvent("tgiann-hacker:open-tablet", source, "hackv3")
end)

QBCore.Commands.Add("sethack", "Set Player's Hack Number", {{name="id", help="Player ID"}, {name="seviye", help="Hack Seviyesi"}}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if tPlayer then
        tPlayer.Functions.SetMetaData("hackcount", tonumber(args[2]))
        TriggerClientEvent("QBCore:Notify", source, "Level Given")
        TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/sethack '..args[1]..' '..args[2], source, tonumber(args[1]))
    else
        TriggerClientEvent("QBCore:Notify", source, "There is no such id!")
    end
end, "admin")