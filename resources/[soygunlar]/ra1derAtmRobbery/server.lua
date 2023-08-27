QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local Cooldown = false



QBCore.Functions.CreateUseableItem('trojan_usb', function(source)
	local Player = QBCore.Functions.GetPlayer(source)
   TriggerClientEvent('hack:trojan_usb',source)
end)


RegisterServerEvent("ra1derAtmRobbery:success")
AddEventHandler("ra1derAtmRobbery:success",function()
    local src = source
	local Player =  QBCore.Functions.GetPlayer(source)
    local random = math.random(150, 600)
    Player.Functions.RemoveItem("trojan_usb", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['trojan_usb'], "remove")
    Wait(300)
    Player.Functions.AddMoney("cash", random)
end)

-- Cooldown
RegisterServerEvent('ra1derAtmRobbery:Server:BeginCooldown')
AddEventHandler('ra1derAtmRobbery:Server:BeginCooldown', function()
    Cooldown = true
    local timer = 60000 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback("ra1derAtmRobbery:Cooldown",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false)
        
    end
end)


