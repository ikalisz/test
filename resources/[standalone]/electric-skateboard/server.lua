QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem("rc_car", function(source, item)
    TriggerClientEvent("kfzeu:rcCar", source)
end)

QBCore.Functions.CreateUseableItem("kaykay", function(source, item)
    TriggerClientEvent("longboard:start", source)
end)

RegisterNetEvent('electric-skateboard:item')
AddEventHandler('electric-skateboard:item', function(remove)
    local xPlayer = QBCore.Functions.GetPlayer(source)
	if remove then
        xPlayer.Functions.RemoveItem("kaykay", 1)
    else
        xPlayer.Functions.AddItem("kaykay", 1)
    end
end)