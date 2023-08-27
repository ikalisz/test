local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-spawn:girislog", function()
    local src = source
    if src == nil then return end
    local Name = GetPlayerName(src)
    local discord = nil
    local idedentifier = {}
    local idedentifier = GetPlayerIdentifiers(source) 
    for i=1, #idedentifier do
        if string.find(idedentifier[i], "discord") then
            discord = string.sub(idedentifier[i], 9)
        end
    end

    if idedentifier[1] == nil then idedentifier[1] = "Identifier Unknown" end
    if discord == nil then discord = "Dc Unknown" end
    if Name == nil then Name = "Name Unknown" end
    TriggerEvent("DiscordBot:ToDiscord", 'giriscikis', '**ID: '..src..'** **Steam Name:** '..Name..' **Steam Hex:** '..idedentifier[1]..'\n**Discord:** <@'.. discord ..'> He entered the server!')
end)



