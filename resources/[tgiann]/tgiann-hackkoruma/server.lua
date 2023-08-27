QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local active = true

RegisterServerEvent('tgiann-hackkoruma:kick')
AddEventHandler('tgiann-hackkoruma:kick', function(url, hack)
    if active then
        local nick = GetPlayerName(source) 
        if nick == nil then nick = "Unknown" end
        local identifier = GetPlayerIdentifiers(source)[1]
        if identifier == nil then identifier = "Steam ID Unknown" end
        if url == nil then url = "No Picture Taken" end
        
        if hack ~= "AFK" then
            TriggerEvent('DiscordBot:ToDiscord', 'hile', '```Nick: ('.. nick .. ') Steam İd: (' .. identifier .. ') ' .. hack .. '```'.. url)
            -- DropPlayer(source, "Ups Ufak Bir Sorun Oldu. Yetkililer ile İletişime Geçin")   
        else
            DropPlayer(source, "You got kicked out for not moving in a long time!")
        end
    end
end)

RegisterCommand("hack", function(source)
    if source == 0 then
        active = not active
        print("System: ".. tostring(active))
    end
end)

QBCore.Functions.CreateCallback('tgiann-hackkoruma:GetPermissions', function(source, cb)
    local group = QBCore.Functions.GetPermission(source)
    cb(group)
end)