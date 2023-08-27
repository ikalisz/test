local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("ra1der_carcolor", function(source, cb, para)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.Functions.GetMoney('cash') >= para then
        xPlayer.Functions.RemoveMoney('cash', para )
        cb(true)
      else
        cb(false)
      end
end)

RegisterServerEvent("ra1der_paraiade")
AddEventHandler("ra1der_paraiade", function(para)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney("cash", para)
end)


