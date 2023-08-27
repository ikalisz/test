local QBCore = exports['qb-core']:GetCoreObject()
--============================================================================ Items

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
 		TriggerClientEvent('fishing:fishstart', source)
    end
end)

QBCore.Functions.CreateUseableItem("fishbait", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent('fishing:client:useFishingBox', source, item.info.boxid)  
    end
end)


QBCore.Functions.CreateUseableItem("fishingloot", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local randomcash = math.random(150, 600)
	local kasarandom = math.random(1, 100)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		if Player.Functions.RemoveItem("fishingkey", 1) then
		TriggerClientEvent("fishing:client:attemptTreasureChest", src)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "remove", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingkey'], "remove", 1)
		Wait(4500)
		Player.Functions.RemoveItem("fishingloot", 1)
			if kasarandom >= 1 and kasarandom <= 30 then
				Player.Functions.AddItem("pearlscard", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a fishing card", "success")
			elseif kasarandom >= 31 and kasarandom <= 69 then
				Player.Functions.AddMoney('cash', randomcash)
				TriggerClientEvent('QBCore:Notify', src, "" ..randomcash.. "$ Found Money", "success")
			elseif kasarandom >= 70 and kasarandom <= 100 then
				Player.Functions.AddItem("yuzuk", 1) 
				TriggerClientEvent('QBCore:Notify', src, "You found a precious ring $", "success")
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["yuzuk"], "add", 1)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "Do You Need A Key To Open The Safe?r", "error")
		end
    end
end)
--============================================================================ Events

RegisterNetEvent('fishing:server:removeFishingBait', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('fishbait', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishbait'], "remove", 1)
end)


RegisterNetEvent('fishing:server:catch', function() 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

    if itemFound then
        for i = 1, itemCount, 1 do
            if luck == 100 then
				local weight = math.random(850,1000)
				local info = {species = "Orca",lbs = weight,type = "Exotic"}
			elseif luck >= 95 and luck <= 100 then
				local weight = math.random(4,9)
				local info = {species = "Manta ray", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 5)
				Player.Functions.AddItem('stingray', weight, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stingray'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, ""..weight.. " KG You caught a stingray !", "success")
			elseif luck >= 85 and luck <= 95 then
				local weight = math.random(10,15)
				local info = {species = "Flounder", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('flounder', weight, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['flounder'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "".. weight .. " KG You Caught Flounder", "success")
			elseif luck >= 75 and luck <= 85 then
				local weight = math.random(1,5)
				local info = {species = "Mackerel", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('mackerel', weight, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['mackerel'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "" .. weight .. " KG You caught tuna", "success")
			elseif luck >= 65 and luck <= 75 then
				local weight = math.random(1,6)
				local info = {species = "Bass", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('bass', weight, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bass'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src,  "" .. weight .. " KG You Caught Perch", "success")
			elseif luck >= 55 and luck <= 65 then
				Player.Functions.AddItem('fishingloot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a small treasure box", "success")
				Player.Functions.AddItem('fishingkey', 1, nil, {["quality"] = 100})
			elseif luck >= 45 and luck <= 55 then
				local weight = math.random(5,7)
				local info = {species = "Cod", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('codfish', weight, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['codfish'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src,  "" .. weight .. " KG You Caught Cod", "success")
			elseif luck >= 35 and luck <= 45 then
				Player.Functions.AddItem('fishingtin', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingtin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a rusted tin!", "primary")
			elseif luck >= 0 and luck <= 35 then
				Player.Functions.AddItem('fishingboot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingboot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a mossy boat", "primary")

            end
            Citizen.Wait(500)
        end
    end
end)

-- -- RegisterNetEvent('fishing:server:SellillegalFish', function(args)
-- -- 	local src = source
-- --     local Player = QBCore.Functions.GetPlayer(src)
-- -- 	local args = tonumber(args)
-- -- 	if args == 1 then 
-- -- 		if Player.Functions.GetItemByName("dolphin").amount > 0 then
-- -- 			local payment = Config.dolphinPrice
-- -- 			Player.Functions.RemoveItem("dolphin", 1, k)
-- -- 			Player.Functions.AddMoney('cash', payment)
-- -- 			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['dolphin'], "remove", 1)
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Yunus Satıldı $"..payment, "success")
-- -- 			TriggerClientEvent("doj:client:SellillegalFish", source)
-- -- 		else
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Satacak bir yunus balığı yok", 'error')
-- -- 		end
-- -- 	elseif args == 2 then 
-- -- 		if Player.Functions.GetItemByName("sharktiger").amount > 0 then
-- -- 			local payment = Config.sharktigerPrice
-- -- 			Player.Functions.RemoveItem("sharktiger", 1, k)
-- -- 			Player.Functions.AddMoney('cash', payment)
-- -- 			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sharktiger'], "remove", 1)
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Kaplan köpek balığı satıldı $"..payment, "success")
-- -- 			TriggerClientEvent("doj:client:SellillegalFish", source)
-- -- 		else
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Satabileceğin bir kaplan köpek balığı yok", 'error')
-- -- 		end
-- -- 	elseif args == 3 then 
-- -- 		if Player.Functions.GetItemByName("sharkhammer").amount > 0 then
-- -- 			local payment = Config.sharkhammerPrice
-- -- 			Player.Functions.RemoveItem("sharkhammer", 1, k)
-- -- 			Player.Functions.AddMoney('cash', payment)
-- -- 			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sharkhammer'], "remove", 1)
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Çekiç Köpek Balığı Satıldı $"..payment, "success")
-- -- 			TriggerClientEvent("doj:client:SellillegalFish", source)
-- -- 		else
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Satabileceğin Çekic Köpek Balığı Yok", 'error')
-- -- 		end
-- -- 	else
-- -- 		if Player.Functions.GetItemByName("killerwhale").amount > 0 then
-- -- 			local payment = Config.killerwhalePrice
-- -- 			Player.Functions.RemoveItem("killerwhale", 1, k)
-- -- 			Player.Functions.AddMoney('cash', payment)
-- -- 			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['killerwhale'], "remove", 1)
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Katil Balına Balığı Satıldı $"..payment, "success")
-- -- 			TriggerClientEvent("doj:client:SellillegalFish", source)
-- -- 		else
-- -- 			TriggerClientEvent('QBCore:Notify', src, "Satabileceğin Katil Balına Balığı Yok", "error")
-- -- 		end
-- -- 	end
-- -- end)

RegisterNetEvent('fishing:server:SellLegalFish', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
		-- local mackerel = Player.Functions.GetItemByName("mackerel")
		-- if mackerel ~= nil then
		if Player.Functions.GetItemByName("mackerel").amount >= 1 then
			local payment = Config.mackerelPrice
			Player.Functions.RemoveItem("mackerel", 1)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mackerel'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "Mackerel Sold $"..payment, "success")
			TriggerClientEvent("doj:client:SellLegalFish", source)
		else
		    TriggerClientEvent('QBCore:Notify', src, "No Tuna You Can Sell", "error")
		end
	elseif args == 2 then
		if Player.Functions.GetItemByName("codfish").amount >= 1 then
			local payment = Config.codfishPrice
			Player.Functions.RemoveItem("codfish", 1, k)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['codfish'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "Cod Fish Sold"..payment, "success")
			TriggerClientEvent("doj:client:SellLegalFish", source)
		else
		    TriggerClientEvent('QBCore:Notify', src, "No Cod You Can Sell", "error")
		end
	elseif args == 3 then
		if Player.Functions.GetItemByName("bass").amount >= 1 then
			local payment = Config.bassPrice
			Player.Functions.RemoveItem("bass", 1, k)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['bass'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "Sea Bass Sold $"..payment, "success")
			TriggerClientEvent("doj:client:SellLegalFish", source)
		else
			TriggerClientEvent('QBCore:Notify', src, "No Sea Bass You Can Sell", "error")
		end
	elseif args == 4 then
		if Player.Functions.GetItemByName("flounder").amount >= 1 then
			local payment = Config.flounderPrice
			Player.Functions.RemoveItem("flounder", 1, k)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['flounder'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "Flounder Sold $"..payment, "success")
			TriggerClientEvent("doj:client:SellLegalFish", source)
		else
		    TriggerClientEvent('QBCore:Notify', src, "No Flounder You Can Sell", "error")
		end
	else
		if Player.Functions.GetItemByName("stingray").amount >= 1 then
			local payment = Config.stingrayPrice
			Player.Functions.RemoveItem("stingray", 1, k)
			Player.Functions.AddMoney('cash', payment)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['stingray'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "Stingray Fish Sold $"..payment, "success")
			TriggerClientEvent("doj:client:SellLegalFish", source)
		else
		    TriggerClientEvent('QBCore:Notify', src, "No Stingray Fish You Can Sell", "error")
		end
	end
end)

RegisterNetEvent('fishing:server:BuyFishingGear', function(args)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	local bankBalance = Player.PlayerData.money["bank"]

	if args == 1 then 
		if bankBalance >= Config.fishingBaitPrice then
			Player.Functions.RemoveMoney('bank', Config.fishingBaitPrice, "fishbait")
			Player.Functions.AddItem('fishbait', 1, nil, {["quality"] = 100})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishbait'], "add", 1)
			TriggerClientEvent("doj:client:buyFishingGear", source)
		else
			TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Money.", "error")
		end
	elseif args == 2 then 
		if bankBalance >= Config.fishingRodPrice then
			Player.Functions.RemoveMoney('bank', Config.fishingRodPrice, "fishingrod")
			Player.Functions.AddItem('fishingrod', 1, nil, {["quality"] = 100})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingrod'], "add", 1)
			TriggerClientEvent("doj:client:buyFishingGear", source)
		else
			TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Money.", "error")
		end
	-- elseif args == 3 then 
	-- 	if bankBalance >= Config.BoatAnchorPrice then
	-- 		Player.Functions.RemoveMoney('bank', Config.BoatAnchorPrice, "anchor")
	-- 		Player.Functions.AddItem('anchor', 1, nil, {["quality"] = 100})
	-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['anchor'], "add", 1)
	-- 		TriggerClientEvent("doj:client:buyFishingGear", source)
	-- 	else
	-- 		TriggerClientEvent('QBCore:Notify', src, "Yeteri Kadar Paran Yok.", "error")
	-- 	end
	else
		if bankBalance >= Config.BoatAnchorPrice then
			Player.Functions.RemoveMoney('bank', Config.BoatAnchorPrice, "fishicebox")
			local info = {
				boxid = math.random(111,999),
				boxOwner = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname,
			}
			Player.Functions.AddItem('fishicebox', 1, nil, info, {["quality"] = 100})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishicebox'], "add", 1)
			TriggerClientEvent("doj:client:buyFishingGear", source)
		else
			TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Money.", "error")
		end
	end
end)


--============================================================================ Callbacks
QBCore.Functions.CreateCallback('fishing:server:checkMoney', function(source, cb)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local bankBalance = pData.PlayerData.money["bank"]
	local price = Config.BoatPrice
    if bankBalance >= price then
        pData.Functions.RemoveMoney('bank', Config.BoatPrice, "boat-rental")
		TriggerClientEvent('QBCore:Notify', src, "Boat Rented, Fee : $"..price, "success")
        cb(true)
    else
        TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Money", "error")
        cb(false)
    end
end)
