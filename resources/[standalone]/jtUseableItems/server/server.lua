QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

function removeItemHud(src, item)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    --xPlayer.Functions.RemoveItem(item, 1)
end

QBCore.Functions.CreateUseableItem('umbrella', function(source, item)
    TriggerClientEvent("dpemotes:play-anim", source, {"şemsiye"})
end)    

QBCore.Functions.CreateUseableItem('kahve', function(source, item)
    removeItemHud(source, "kahve")
    TriggerClientEvent("dpemotes:play-anim", source, {"kahve"})
end)

-- QBCore.Functions.CreateUseableItem('nos', function(source, item)
--     local xPlayer = QBCore.Functions.GetPlayer(source, item)
--     --xPlayer.Functions.RemoveItem('nos', 1)
--     TriggerClientEvent("QBCore:Notify", source, 'Böyle bir kullanım yöntemi de var tabi :D')
--     TriggerClientEvent('kfzeu-basicneeds:nosAnimation', source, item)
-- end)

QBCore.Functions.CreateUseableItem('abc', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('abc', 1)
    TriggerClientEvent('kfzeu-basicneeds:nosAnimation2', source, item)
end)

QBCore.Functions.CreateUseableItem('beer', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 800)
end)

QBCore.Functions.CreateUseableItem('grand_cru', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 4500)
end)

QBCore.Functions.CreateUseableItem('rhum', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 4000)
end)

QBCore.Functions.CreateUseableItem('golem', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 10000)
end)

QBCore.Functions.CreateUseableItem('jagerbomb', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 8000)
end)

QBCore.Functions.CreateUseableItem('whiskycoca', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5500)
end)

QBCore.Functions.CreateUseableItem('rhumcoca', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5500)
end)

QBCore.Functions.CreateUseableItem('tequila', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5500)
end)

QBCore.Functions.CreateUseableItem('vodkaenergy', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5500)
end)

QBCore.Functions.CreateUseableItem('vodkafruit', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5500)
end)

QBCore.Functions.CreateUseableItem('rhumfruit', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5500)
end)

QBCore.Functions.CreateUseableItem('teqpaf', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 7000)
end)

QBCore.Functions.CreateUseableItem('mojito', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 3000)
end)

QBCore.Functions.CreateUseableItem('jagercerbere', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 6000)
end)

QBCore.Functions.CreateUseableItem('vodka', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5000)
end)

QBCore.Functions.CreateUseableItem('whisky', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 4500)
end)

QBCore.Functions.CreateUseableItem('whitewine', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 2500)
end)

QBCore.Functions.CreateUseableItem('jager', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 7500)
end)

QBCore.Functions.CreateUseableItem('martini', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 5000)
end)

QBCore.Functions.CreateUseableItem('wine', function(source, item)
    TriggerClientEvent('tgiann-basicneeds:eatOrDrink', source, item.name, "drink", 2000, 0.1)
    TriggerClientEvent('tgiann-basicneeds:icki', source, 2500)
end)

QBCore.Functions.CreateUseableItem('fish', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('fish', 1)
    TriggerClientEvent("QBCore:Notify", source, 'My son, is this edible raw??')
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, -21, "yemek", "fish")
end)

QBCore.Functions.CreateUseableItem('asit', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('asit', 1)
    TriggerClientEvent("QBCore:Notify", source, 'Really :D?')
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, -51, "yemek", "asit")
end)

QBCore.Functions.CreateUseableItem('parasut', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    TriggerClientEvent("QBCore:Notify", source, "You Wear the Parachute! Be careful not to use a parachute again! (If you get a gun vs. your parachute will go away)", "error")
    TriggerClientEvent('tgiann-hud:parasut', source)
    Wait(7000)
    xPlayer.Functions.RemoveItem('parasut', 1)
end)

QBCore.Functions.CreateUseableItem('azot', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('azot', 1)
    TriggerClientEvent("QBCore:Notify", source, 'Someone tell the brothers carrying coffins...')
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, -51, "yemek", "azot")
end)

QBCore.Functions.CreateUseableItem('balon_baligi', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('balon_baligi', 1)
    TriggerClientEvent("QBCore:Notify", source, 'Thats a toxic bro')
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, -21, "yemek", "balon_baligi")
end)

QBCore.Functions.CreateUseableItem('madde_x', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('madde_x', 1)
    TriggerClientEvent("QBCore:Notify", source, 'You worked so hard was it worth it? :D?')
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, -101, "yemek", "madde_x")
end)

QBCore.Functions.CreateUseableItem('kuru_ot', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('kuru_ot', 1)
    TriggerClientEvent("QBCore:Notify", source, 'It doesnt go so dry :D')
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, -6, "yemek", "kuru_ot")
end)

QBCore.Functions.CreateUseableItem('su_alti', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('su_alti', 1)
	TriggerClientEvent('kfzeu-basicneeds:su_alti', source, 5, item.name)
end)

QBCore.Functions.CreateUseableItem('su_alti2', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('su_alti2', 1)
	TriggerClientEvent('kfzeu-basicneeds:su_alti', source, 15, item.name)
end)

QBCore.Functions.CreateUseableItem('cigarette', function(source, item)
	local xPlayer = QBCore.Functions.GetPlayer(source, item)
	--xPlayer.Functions.RemoveItem('cigarette', 1)
	TriggerClientEvent('tgiann-basicneeds:sigara', source, item)
end)

QBCore.Functions.CreateUseableItem('ab', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('ab', 1)
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "ot", "ab")
end)

QBCore.Functions.CreateUseableItem('pk', function(source, item)
        local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('pk', 1)
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "ot", "pk")
end)

QBCore.Functions.CreateUseableItem('sarma_ot', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('sarma_ot', 1)
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "doping", "sarma_ot")
    TriggerClientEvent("jointEffect", source)
    -- TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "ot", "sarma_ot")
end)

QBCore.Functions.CreateUseableItem("ifak",function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseiFak", source, item.name)
    Wait(250)
    Player.Functions.RemoveItem("ifak", 1)
end)

QBCore.Functions.CreateUseableItem('enerji_icecegi', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('enerji_icecegi', 1)
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "enerji", "enerji_icecegi")
end)

QBCore.Functions.CreateUseableItem('shark_doping', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('shark_doping', 1)
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "doping", "shark_doping")
end)

-- QBCore.Functions.CreateUseableItem('joint', function(source, item)
--     local xPlayer = QBCore.Functions.GetPlayer(source, item)
--     --xPlayer.Functions.RemoveItem('joint', 1)
--     TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "doping", "shark_doping")
-- end)

QBCore.Functions.CreateUseableItem('adrenalin', function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source, item)
    --xPlayer.Functions.RemoveItem('adrenalin', 1)
    TriggerClientEvent('kfzeu-basicneeds:zehir', source, 200, "adrenalin", "adrenalin")
end)


RegisterNetEvent("tgiann-basicneeds:esya-sil")
AddEventHandler("tgiann-basicneeds:esya-sil", function(item, item2)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.RemoveItem(item, 1)
        if item2 then
            xPlayer.Functions.RemoveItem(item2, 1)
        end
    end
end)

QBCore.Functions.CreateUseableItem('racingdongle', function(source)
    TriggerClientEvent('yarisciperm:amk', source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem("racingdongle", 1)
    TriggerClientEvent('QBCore:Notify', source, 'You can now access the Race app from your phone.', 'success')
    TriggerClientEvent('qb-phone:RefreshPhone', source)
end)

QBCore.Functions.CreateUseableItem('ot', function(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.Functions.RemoveItem("kagit", 1) then
        if xPlayer.Functions.RemoveItem("ogutucu", 1) then
            TriggerClientEvent('haso:joint', source)
            Citizen.Wait(15000)
            if xPlayer.Functions.RemoveItem("ot", 1) then
            xPlayer.Functions.AddItem("sarma_ot", 1)
            end
        else
            xPlayer.Functions.AddItem("kagit", 1)
            TriggerClientEvent('QBCore:Notify', source, 'You dont have the necessary items', "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have the necessary items', "error")
    end
end)


