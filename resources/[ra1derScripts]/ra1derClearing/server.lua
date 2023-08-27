QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("ra1der:para")
AddEventHandler("ra1der:para", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney('bank', Config.Para)
    local random = math.random(0, 100)
    local random2 = math.random(3, 7)
    if random > 70 then 
        xPlayer.Functions.AddMoney('cash', random2)
        TriggerClientEvent("QBCore:Notify", src, "" ..random2.. "$ You got a tip")
    end
end)    

