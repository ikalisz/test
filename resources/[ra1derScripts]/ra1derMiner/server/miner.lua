local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.MinerItem, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ra1derMiner:serverStartMine', src)
end)

RegisterServerEvent('stone:add')
AddEventHandler('stone:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("stone", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stone'], "add", 1)
    TriggerClientEvent('QBCore:Notify', src,  Config.Text["found_stone"], 'primary')
end)

RegisterServerEvent('scrapmetal:add')
AddEventHandler('scrapmetal:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("crudemetal", Config.Metalvalue)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crudemetal'], "add", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_metal"], 'primary')
end)

RegisterServerEvent('scrapcopper:add')
AddEventHandler('scrapcopper:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("crudecopper", Config.Coppervalue)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crudecopper'], "add", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_copper"], 'primary')
end)

RegisterServerEvent('scrapiron:add')
AddEventHandler('scrapiron:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("crudeiron", Config.Ironvalue)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crudeiron'], "add", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_iron"], 'primary')
end)

RegisterServerEvent('scrapgold:add')
AddEventHandler('scrapgold:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("crudegold", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crudegold'], "add", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_gold"], 'primary')
end)

RegisterServerEvent('diamond:add')
AddEventHandler('diamond:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("crudediamond", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crudediamond'], "add")
    TriggerClientEvent('QBCore:Notify', src, Config.Text["diamond"], 'primary')
end)

RegisterServerEvent('case:add')
AddEventHandler('case:add', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Wait(3000)
    Player.Functions.AddItem("case", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['case'], "add")
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_case"], 'primary')
end)


QBCore.Functions.CreateUseableItem("case", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local luck = math.random(1, 100)
    TriggerClientEvent("fishing:client:attemptTreasureChest", src)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["case_open"], 'primary', 3000)
    Wait(3600)
    if luck >= 0 and luck < 35 then	
    Player.Functions.AddItem("rolex", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rolex'], "add", 1)
    Wait(100)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["case"], "remove", 1)
    Player.Functions.RemoveItem("case", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_rolex"], 'primary')
    elseif luck >= 36 and luck < 65 then	
    Player.Functions.AddItem("altinkolye", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['altinkolye'], "add", 1)
    Wait(100)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["case"], "remove", 1)
    Player.Functions.RemoveItem("case", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_necklace"], 'primary')
    elseif luck >= 66 and luck < 100 then	
    Player.Functions.AddMoney("cash", Config.Cashvalue)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["case"], "remove", 1)
    Player.Functions.RemoveItem("case", 1)
    TriggerClientEvent('QBCore:Notify', src, Config.Text["found_cash"], 'primary')
    end
end)



RegisterServerEvent('ra1derMiner:server:RentMinerCar')
AddEventHandler('ra1derMiner:server:RentMinerCar', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney("bank", Config.MinerCarPrice) then
        TriggerClientEvent('ra1derMiner:client:GiveCar', source, modelHash)
        TriggerClientEvent('QBCore:Notify', src,  Config.Text["rent_car_message"], "success", 10000)
    else
        TriggerClientEvent('QBCore:Notify', src,  Config.Text["not_enought_money"], "error", 4000)
    end
end)

RegisterServerEvent('ra1derMiner:server:BuyPickaxe')
AddEventHandler('ra1derMiner:server:BuyPickaxe', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money.bank
    if bank >= Config.PickaxePrice then
        Player.Functions.RemoveMoney("bank", Config.PickaxePrice)
        Wait(500)
        Player.Functions.AddItem(Config.MinerItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.MinerItem], "add", 1)
        TriggerClientEvent('QBCore:Notify', src,  Config.Text["buy_pickaxe"], "success", 10000)
    else
        TriggerClientEvent('QBCore:Notify', src,  Config.Text["not_enought_money"], "error", 4000)
    end
end)

RegisterServerEvent('ra1derMiner:server:AddMoney')
AddEventHandler('ra1derMiner:server:AddMoney', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    
	Player.Functions.AddMoney("bank", 250)
end)

QBCore.Commands.Add('stone', 'Help Text', {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("finishedstone").amount > 1 then
        local payment = Config.StonePrice
        Player.Functions.RemoveItem("finishedstone", 1)
        Wait(500)
        Player.Functions.AddMoney('cash', payment)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finishedstone'], "remove", 1)
        TriggerClientEvent('QBCore:Notify', src, "31", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "62", "error")
    end

end)

RegisterNetEvent('ra1derMiner:server:Sell', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
        if Player.Functions.GetItemByName("finishedstone").amount >= 1 then
            local payment = Config.StonePrice
            Player.Functions.RemoveItem("finishedstone", 1)
            Wait(250)
            Player.Functions.AddMoney('cash', payment)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finishedstone'], "remove", 1)
            TriggerClientEvent('QBCore:Notify', src, "You Sold 1 Piece of Worked Stone", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "No rough stones to sell?", "error")
        end
    elseif args == 2 then 
		if Player.Functions.GetItemByName("finishedmetal").amount >= 1 then
			local payment = Config.MetalPrice
			Player.Functions.RemoveItem("finishedmetal", 1)
            Wait(250)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finishedmetal'], "remove", 1)
            TriggerClientEvent('QBCore:Notify', src, "You Sold 1 Piece of Wrought Metal", "success")
		else
            TriggerClientEvent('QBCore:Notify', src, "No machined metal you can sell?", "error")
		end
	elseif args == 3 then
        if Player.Functions.GetItemByName("finishedcopper").amount >= 1 then
			local payment = Config.CopperPrice
			Player.Functions.RemoveItem("finishedcopper", 1)
            Wait(250)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finishedcopper'], "remove", 1)
            TriggerClientEvent('QBCore:Notify', src, "You Sell 1 Piece of Wrought Copper", "success")
		else
            TriggerClientEvent('QBCore:Notify', src, "No wrought copper you can sell?", "error")
		end
    elseif args == 4 then
        if Player.Functions.GetItemByName("finishediron").amount >= 1 then
			local payment = Config.IronPrice
			Player.Functions.RemoveItem("finishediron", 1)
            Wait(250)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finishediron'], "remove", 1)
            TriggerClientEvent('QBCore:Notify', src, "You Sold 1 Wrought Iron Ingot", "success")
		else
            TriggerClientEvent('QBCore:Notify', src, "No processed iron to sell?", "error")
		end
    elseif args == 5 then
        if Player.Functions.GetItemByName("finishedgold").amount >= 1 then
			local payment = Config.GoldPrice
			Player.Functions.RemoveItem("finishedgold", 1)
            Wait(250)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finishedgold'], "remove", 1)
            TriggerClientEvent('QBCore:Notify', src, "You Sold 1 Forged Gold Ingot", "success")
		else
            TriggerClientEvent('QBCore:Notify', src, "No processed gold you can sell?", "error")
		end
    elseif args == 6 then
        if Player.Functions.GetItemByName("finisheddiamond").amount >= 1 then
			local payment = Config.DiamondPrice
			Player.Functions.RemoveItem("finisheddiamond", 1)
            Wait(250)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['finisheddiamond'], "remove", 1)
            TriggerClientEvent('QBCore:Notify', src, "1 Piece of Machined Diamond Particle", "success")
		else
            TriggerClientEvent('QBCore:Notify', src, "No rough diamonds to sell?", "error")
		end
	end
end)





QBCore.Functions.CreateCallback("MadenIsleme", function(source, cb, item)
    local amount = 0
    local player = QBCore.Functions.GetPlayer(source)
    if player then 
        for k,v in pairs(player.PlayerData.items) do
            if v.name == item then
                amount = amount + v.amount
            end
        end
        cb(amount)
    else
        cb(0)
    end
end)

RegisterServerEvent('ra1derMiner:server:IslemeEsyaVer')
AddEventHandler('ra1derMiner:server:IslemeEsyaVer', function(miktar, item, fitem)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item, miktar) then 
    Citizen.Wait(1000)
    Player.Functions.AddItem(fitem, miktar / 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[fitem], "add", miktar / 5)
    Citizen.Wait(1000)
    else
        TriggerClientEvent('QBCore:Notify', src, "İşleyebilecek kadar eşyan yok!", "error")
    end
end)
