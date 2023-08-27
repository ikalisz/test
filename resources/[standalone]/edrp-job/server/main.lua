QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("edrp-job:give-item")
AddEventHandler("edrp-job:give-item", function(item, items)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if items > 1 then 
        local random = math.random(1,100)
        for i=1, #item do 
            if random <= item[i]["oran"] then 
                local randomItemCount = math.random(1, item[i]["maxRandomItemCount"])
                if not xPlayer.Functions.AddItem(item[i]["item"], randomItemCount) then
                    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Are Too Heavy", "error")
                end
                break
            end
        end
    else
        local randomItemCount = math.random(1, item[1]["maxRandomItemCount"]) 
        if not xPlayer.Functions.AddItem(item[1]["item"], randomItemCount) then
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Are Too Heavy", "error")
        end
    end
end)