local testPolice = false
local npcOn = true
local sifirPolis = false

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('evidence', 'Open the evidence store.', {}, true, function(source, args)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    -- if Player.job.name == 'police' then 
        TriggerClientEvent('wildEvidence:OpenMenu', source)
    -- else
        TriggerClientEvent("QBCore:Notify", src, "You Are Not a Police!")
    -- end
end, 'user')

QBCore.Commands.Add('heal', 'Get All Your Value', {}, false, function(source)
    local src = source 
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("healevent", src)
    TriggerClientEvent("QBCore:Notify", src, "Command Used")
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin: **HEAL** komutunu kullandı", PlayerData.PlayerData.source)
end, "admin", "god")    

QBCore.Commands.Add('carfix', 'Help Text', {}, false, function(source)
    local src = source 
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("carfix", src)
    TriggerClientEvent("QBCore:Notify", src, "Command Used")
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin: **carfix** komutunu kullandı", PlayerData.PlayerData.source)
end, "admin", "god")

QBCore.Commands.Add('die', 'Help Text', {}, false, function(source)
    local src = source 
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("dieEvent", src)
    TriggerClientEvent("QBCore:Notify", src, "Command Used")
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin: **die** komutunu kullandı", PlayerData.PlayerData.source)
end, "admin", "god")        

QBCore.Commands.Add('repairveh', 'Help Text', {}, false, function(source)
    local src = source 
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("aracfulle", src)
    TriggerClientEvent("QBCore:Notify", src, "Command Used")
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin: **araçfulle** komutunu kullandı", PlayerData.PlayerData.source)
end, "admin", "god")      


QBCore.Commands.Add("mechanic", "Opens the mechanics menu", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna 
    local src = source 
    local PlayerData = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("tgiann-mekanik:admin", source, QBCore.Key)
    TriggerClientEvent("QBCore:Notify", src, "Command Used")
    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "İsimli Admin: **mekanik** komutunu kullandı", PlayerData.PlayerData.source)
end, "god")

RegisterCommand("announce", function(source, args)
	local message = table.concat(args, " ")
	local Players = QBCore.Functions.GetPlayer(source)

	TriggerClientEvent('chatMessage', -1, "Announcement | ", "success", message)
end, true)

