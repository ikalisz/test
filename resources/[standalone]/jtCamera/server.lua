local QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem('camera', function(source)
  TriggerClientEvent('foto:client:kullankamera', source)
end)

QBCore.Functions.CreateUseableItem('resim', function(source, item)
    TriggerClientEvent('foto:client:kullanfoti', source, item.info.link)
end)

RegisterServerEvent('foto:server:fotiekle')
AddEventHandler('foto:server:fotiekle', function(url)
    local xKisi = QBCore.Functions.GetPlayer(source)
    local info = {
      link = url,
    }

    xKisi.Functions.AddItem("resim", 1, nil, info)
end)