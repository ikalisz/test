QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Commands.Add("hostage", "Embrace Nearby Player", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    TriggerClientEvent("tgiann-kucakla:kontrol", source, "kucak")
end)

QBCore.Commands.Add("carry", "Back Nearby Player", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    TriggerClientEvent("tgiann-kucakla:kontrol", source, "sirt")
end)





RegisterServerEvent('tgiann-kucakla:server:oyuncu-2-anim')
AddEventHandler('tgiann-kucakla:server:oyuncu-2-anim', function(targetSource, tip)
    TriggerClientEvent("tgiann-kucakla:client:oyuncu-2-anim", targetSource, tip, source)
end)

RegisterServerEvent('tgiann-kucakla:server:anim-iptal')
AddEventHandler('tgiann-kucakla:server:anim-iptal', function(targetSource)
    TriggerClientEvent("tgiann-kucakla:client:anim-iptal", targetSource)
end)

RegisterServerEvent('tgiann-kucakla:server:rehin-birak')
AddEventHandler('tgiann-kucakla:server:rehin-birak', function(targetSource, tip)
    TriggerClientEvent("tgiann-kucakla:client:rehin-birak", targetSource, tip)
end)
