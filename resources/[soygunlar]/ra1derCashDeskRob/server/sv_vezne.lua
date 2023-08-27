QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Functions.CreateUseableItem('lockpick3', function(source)
	local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("ra1derCashDeskRob:attemp", src)
end)

CreateThread(function()
    while true do 
        local time = 10000
        for k, v in pairs(cashdeskrob.Bank) do 
            if v.time and os.time() - v.time >= cashdeskrob.time then 
                time = 2000
                v.time = false
                v.status = false
            end
        end
        Wait(time)
    end
end)

QBCore.Functions.CreateCallback("ra1derCashDeskRob:soyguncheck", function(source, cb, bank, durum, durum2)
    if durum then 
        cashdeskrob.Bank[bank].status = durum2
        if durum2 then 
            cashdeskrob.Bank[bank].time = os.time() 
        else
            cashdeskrob.Bank[bank].time = false
        end
    else
        cb(cashdeskrob.Bank[bank].status)
    end 
end)

RegisterServerEvent('ra1derCashDeskRob:giveMoney')
AddEventHandler('ra1derCashDeskRob:giveMoney', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local hecomestthemoney = math.random(5500, 6500)

	xPlayer.Functions.AddMoney('cash', hecomestthemoney)
	-- TriggerEvent('DiscordBot:ToDiscord', 'market', 'Vezne Soygunu: $'..hecomestthemoney, source)
end)

RegisterServerEvent('ra1derCashDeskRob:kart')
AddEventHandler('ra1derCashDeskRob:kart', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local random = math.random(1, 100)
	if random > 65 then 
	    xPlayer.Functions.AddItem("guvenlik_karti_c", 1)
	end
end)

RegisterServerEvent('ra1derCashDeskRob:deleteItem')
AddEventHandler('ra1derCashDeskRob:deleteItem', function(item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem(item, 1)
end)