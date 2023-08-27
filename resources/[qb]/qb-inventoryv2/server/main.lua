QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Drops = {}
Trunks = {}
Gloveboxes = {}
Stashes = {}
ShopItems = {}
craftingsItems = {}


function tablelength(T)
	local count = 0
	if T ~= nil then
		for _ in pairs(T) do count = count + 1 end
		return count
	else
		return 0
	end
  end

RegisterServerEvent("inventory:server:LoadDrops")
AddEventHandler("inventory:server:LoadDrops", function()
	local src = source
	if next(Drops) ~= nil then
		TriggerClientEvent("inventory:client:LoadDrops", src, Drops)
	end
end)

RegisterServerEvent("inventory:server:addTrunkItems")
AddEventHandler('inventory:server:addTrunkItems', function(plate, items, key) -- Client key yok
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		Trunks[plate] = {}
		Trunks[plate].items = items
	end
end)

RegisterServerEvent("inventory:server:combineItem")
AddEventHandler('inventory:server:combineItem', function(item, fromItem, toItem, key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local ply = QBCore.Functions.GetPlayer(src)

		ply.Functions.AddItem(item, 1)
		ply.Functions.RemoveItem(fromItem, 1)
		ply.Functions.RemoveItem(toItem, 1)
	end
end)

QBCore.Functions.CreateCallback("inventory:server:CraftItems", function(source, cb, itemName, itemCosts, amount, toSlot, points, key)
    local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local amount = tonumber(amount)
		if itemName ~= nil and itemCosts ~= nil then
			local xPlayer = QBCore.Functions.GetPlayer(src)
			local haveItems = false
			local haveItemCount = 0

			local requiredItem = {}
			for k, v in pairs(itemCosts) do
				table.insert(requiredItem, {item = k, count = v})
			end

			local itemCount = #requiredItem
			for i=1, #requiredItem do
				if xPlayer.Functions.GetItemByName(requiredItem[i].item).amount >= requiredItem[i].count*amount then
					haveItemCount = haveItemCount + 1 
				end
				if itemCount == haveItemCount then
					haveItems = true
				end
			end
			
			if haveItems then
				for i=1, #requiredItem do
					xPlayer.Functions.RemoveItem(requiredItem[i].item, requiredItem[i].count*amount)
				end
				xPlayer.Functions.AddItem(itemName, amount, toSlot)
				TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
			end
		end
	end
end)

RegisterServerEvent("inventory:server:SetIsOpenState")
AddEventHandler('inventory:server:SetIsOpenState', function(IsOpen, type, id)
	if not IsOpen then
		if type == "stash" then
			Stashes[id].isOpen = false
		elseif type == "trunk" then
			Trunks[id].isOpen = false
		elseif type == "glovebox" then
			Gloveboxes[id].isOpen = false
		end
	end
end)

RegisterServerEvent("inventory:server:resetTrunkGlovboxInv")
AddEventHandler('inventory:server:resetTrunkGlovboxInv', function(plate)
--[[ 	exports.oxmysql:execute("DELETE FROM `gloveboxitemsnew` WHERE `plate` = @plate" , {["plate"] = plate})
	exports.oxmysql:execute("DELETE FROM `trunkitemsnew` WHERE `plate` = @plate" , {["plate"] = plate})
	Gloveboxes[plate] = nil
	Trunks[plate] = nil ]]
end)
local openedInventory = {}
AddEventHandler('playerDropped', function (reason)
	local data = openedInventory[tostring(source)]
	if data then
		TriggerEvent("inventory:server:SaveInventory", data.name, data.id)
	end

	local stringSrc = tostring(source)
	if acikEnvanterler ~= nil then 
		for k, value in pairs(acikEnvanterler) do
			if value[stringSrc] then 
				acikEnvanterler[k] = nil
			end
		end
	end
end)

RegisterServerEvent("inventory:server:OpenInventory")
AddEventHandler('inventory:server:OpenInventory', function(name, id, other)
	local src = source
	local stringSrc = tostring(src)
	local Player = QBCore.Functions.GetPlayer(src)
	local PlayerAmmo = {}
	openedInventory[tostring(src)] = { name = name, id = id }
	if name ~= nil and id ~= nil then
		local secondInv = {}
		if name == "stash" then
				if Stashes[id] ~= nil then
					if Stashes[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Stashes[id].isOpen)
						if Target ~= nil then
							TriggerClientEvent('inventory:client:CheckOpenState', Stashes[id].isOpen, name, id, Stashes[id].label)
						else
							Stashes[id].isOpen = false
						end
					end
				end
				local maxweight = 1000000
				local slots = 50
				if other ~= nil then 
					maxweight = other.maxweight ~= nil and other.maxweight or 1000000
					slots = other.slots ~= nil and other.slots or 50
				end
				secondInv.name = "stash-"..id
				secondInv.label = "Stash-"..id
				secondInv.maxweight = maxweight
				secondInv.inventory = {}
				secondInv.slots = slots
				if Stashes[id] ~= nil and Stashes[id].isOpen then
					secondInv.name = "none-inv"
					secondInv.label = "Stash-Bulunamadi"
					secondInv.maxweight = 1000000
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					local stashItems = GetStashItems(id)
					if next(stashItems) ~= nil then
						secondInv.inventory = stashItems
						Stashes[id] = {}
						Stashes[id].items = stashItems
						Stashes[id].isOpen = src
						Stashes[id].label = secondInv.label
					else
						Stashes[id] = {}
						Stashes[id].items = {}
						Stashes[id].isOpen = src
						Stashes[id].label = secondInv.label
					end
				end
		elseif name == "trunk" then
			if Trunks[id] ~= nil then
				if Trunks[id].isOpen then
					local Target = QBCore.Functions.GetPlayer(Trunks[id].isOpen)
					if Target ~= nil then
						TriggerClientEvent('inventory:client:CheckOpenState', Trunks[id].isOpen, name, id, Trunks[id].label)
					else
						Trunks[id].isOpen = false
					end
				end
			end
			secondInv.name = "trunk-"..id
			secondInv.label = "Trunk-"..id
			secondInv.maxweight = other.maxweight ~= nil and other.maxweight or 60000
			secondInv.inventory = {}
			secondInv.slots = other.slots ~= nil and other.slots or 50
			if (Trunks[id] ~= nil and Trunks[id].isOpen) or (QBCore.Shared.SplitStr(id, "PLZ")[2] ~= nil and Player.PlayerData.job.name ~= "police") then
				secondInv.name = "none-inv"
				secondInv.label = "Trunk-None"
				secondInv.maxweight = other.maxweight ~= nil and other.maxweight or 60000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				if id ~= nil then 
					local ownedItems = GetOwnedVehicleItems(id)
					if IsVehicleOwned(id) and next(ownedItems) ~= nil then
						secondInv.inventory = ownedItems
						Trunks[id] = {}
						Trunks[id].items = ownedItems
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					elseif Trunks[id] ~= nil and not Trunks[id].isOpen then
						secondInv.inventory = Trunks[id].items
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					else
						Trunks[id] = {}
						Trunks[id].items = {}
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					end
				end
			end
		elseif name == "glovebox" then
			if Gloveboxes[id] ~= nil then
				if Gloveboxes[id].isOpen then
					local Target = QBCore.Functions.GetPlayer(Gloveboxes[id].isOpen)
					if Target ~= nil then
						TriggerClientEvent('inventory:client:CheckOpenState', Gloveboxes[id].isOpen, name, id, Gloveboxes[id].label)
					else
						Gloveboxes[id].isOpen = false
					end
				end
			end
			secondInv.name = "glovebox-"..id
			secondInv.label = "Glovebox-"..id
			secondInv.maxweight = 5000
			secondInv.inventory = {}
			secondInv.slots = 5
			if Gloveboxes[id] ~= nil and Gloveboxes[id].isOpen then
				secondInv.name = "none-inv"
				secondInv.label = "Glovebox-None"
				secondInv.maxweight = 5000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				local ownedItems = GetOwnedVehicleGloveboxItems(id)
				if IsVehicleOwned(id) and next(ownedItems) ~= nil then
					secondInv.inventory = ownedItems
					Gloveboxes[id] = {}
					Gloveboxes[id].items = ownedItems
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				elseif Gloveboxes[id] ~= nil and not Gloveboxes[id].isOpen then
					secondInv.inventory = Gloveboxes[id].items
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				else
					Gloveboxes[id] = {}
					Gloveboxes[id].items = {}
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				end
			end
		elseif name == "shop" then
			secondInv.name = "itemshop-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = SetupShopItems(id, other.items)
			ShopItems[id] = {}
			ShopItems[id].items = other.items
			secondInv.slots = #other.items
		elseif name == "traphouse" then
			secondInv.name = "traphouse-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = other.slots
		elseif name == "crafting" then
			secondInv.name = "crafting"
			craftingsItems = other
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = #other.items
		elseif name == "otherplayer" then
			local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(id))
			if OtherPlayer ~= nil then
				TriggerClientEvent("qb-inventory:freeze-player", OtherPlayer.PlayerData.source)
				TriggerClientEvent("qb-inventory:set-other-player", src, OtherPlayer.PlayerData.source)
				secondInv.name = "otherplayer-"..id
				secondInv.label = "Player-"..id
				secondInv.maxweight = QBCore.Config.Player.MaxWeight
				secondInv.inventory = OtherPlayer.PlayerData.items
				secondInv.slots = 40
				Citizen.Wait(250)
			end
		else
			if id ~= nil then
				if Drops[id] ~= nil and not Drops[id].isOpen then
					secondInv.name = id
					secondInv.label = "Dropped-"..tostring(id)
					secondInv.maxweight = 100000
					secondInv.inventory = Drops[id].items
					secondInv.slots = 30
					Drops[id].isOpen = src
					Drops[id].label = secondInv.label
					Drops[id].time = os.time()
				else
					secondInv.name = "none-inv"
					secondInv.label = "Dropped-None"
					secondInv.maxweight = 100000
					secondInv.inventory = {}
					secondInv.slots = 0
					--Drops[id].label = secondInv.label
				end
			else
				secondInv.name = "none-inv"
				secondInv.label = "Dropped-None"
				secondInv.maxweight = 100000
				secondInv.inventory = {}
				secondInv.slots = 0
				--Drops[id].label = secondInv.label
			end
		end
		TriggerClientEvent("inventory:client:OpenInventory", src, PlayerAmmo, Player.PlayerData.items, secondInv)
	else
		TriggerClientEvent("inventory:client:OpenInventory", src, PlayerAmmo, Player.PlayerData.items, nil)
	end
end)



RegisterServerEvent("inventory:server:SaveInventory")
AddEventHandler('inventory:server:SaveInventory', function(type, id)
	if openedInventory[tostring(source)] then openedInventory[tostring(source)] = nil end
	if type == "trunk" then
		if (IsVehicleOwned(id)) then
			SaveOwnedVehicleItems(id, Trunks[id].items)
		else
			Trunks[id].isOpen = false
		end
	elseif type == "glovebox" then
		if (IsVehicleOwned(id)) then
			SaveOwnedGloveboxItems(id, Gloveboxes[id].items)
		else
			Gloveboxes[id].isOpen = false
		end
	elseif type == "stash" then
		SaveStashItems(id, Stashes[id].items)
	elseif type == "otherPlayer" then
		TriggerClientEvent("qb-inventory:freeze-player", id)
		TriggerClientEvent("ra1der-dupecheck", id)
	elseif type == "drop" then
		if Drops[id] then
			Drops[id].isOpen = false
			Drops[id].time = os.time()
			if lengthCalculator(Drops[id].items) == 0 then
				Drops[id] = nil
				TriggerClientEvent("inventory:client:DropItemAnim", source)
				TriggerClientEvent("inventory:client:RemoveDropItem", -1, id)
			end
		end

	end
end)

RegisterServerEvent("inventory:server:UseItemSlot")
AddEventHandler('inventory:server:UseItemSlot', function(slot)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local itemData = Player.Functions.GetItemBySlot(slot)

	if itemData ~= nil then
		local itemInfo = QBCore.Shared.Items[itemData.name]
		if itemData.type == "weapon" then
			TriggerClientEvent("inventory:client:UseWeapon", src, itemData, os.time())
			TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
			if itemData.info.serie ~= nil then
				TriggerClientEvent("tgiann-dna:set-serial", src, itemData.info.serie)
			end
		elseif itemData.useable then
			TriggerClientEvent("QBCore:Client:UseItem", src, itemData)
			TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
		end
	end
end)

RegisterServerEvent("inventory:server:UseItem")
AddEventHandler('inventory:server:UseItem', function(inventory, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if inventory == "player" or inventory == "hotbar" then
		local itemData = Player.Functions.GetItemBySlot(item.slot)
		if itemData ~= nil then
			TriggerClientEvent("QBCore:Client:UseItem", src, itemData)
		end
	end
end)

-- RegisterServerEvent("qb-clothing:server:adjustfacewear")
-- AddEventHandler('qb-clothing:server:adjustfacewear', function(slot, type, giveItem, remove, data, id)
-- 	TriggerClientEvent("qb-clothing:client:adjustfacewear", tonumber(id), slot, type, giveItem, remove, data)
-- end)

RegisterServerEvent("inventory:server:SetInventoryData")
AddEventHandler('inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, toSlot, fromAmount, toAmount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local fromSlot = tonumber(fromSlot)
	local toSlot = tonumber(toSlot)

	if (fromInventory == "player" or fromInventory == "hotbar") and (QBCore.Shared.SplitStr(toInventory, "-")[1] == "itemshop" or toInventory == "crafting") then
		return
	end

	if fromInventory ~= "player" and fromInventory ~= "hotbar" and QBCore.Shared.SplitStr(fromInventory, "-")[1] ~= "crafting" and QBCore.Shared.SplitStr(fromInventory, "-")[1] ~= "itemshop" and QBCore.Shared.SplitStr(fromInventory, "-")[1] ~= "otherplayer" then
		fromSlot = tostring(fromSlot)
		toSlot = tostring(toSlot)
	end

	if fromInventory == "player" or fromInventory == "hotbar" then
		local fromItemData = Player.Functions.GetItemBySlot(fromSlot)
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:remove-item", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. The item he is trying to do: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   Replaced item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "otherplayer" then
				local playerId = tonumber(QBCore.Shared.SplitStr(toInventory, "-")[2])
				local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
				local toItemData = OtherPlayer.PlayerData.items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:remove-item", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, fromSlot)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount.. "** with player: **", src, OtherPlayer.PlayerData.source)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
    					TriggerClientEvent('QBCore:Notify', source,  "Şnot for now bro. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. The item he is trying to do: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   Replaced item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "left item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** to player: **", src, OtherPlayer.PlayerData.source)
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "trunk" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Trunks[plate].items[tostring(toSlot)]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:remove-item", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							RemoveFromTrunk(plate, fromSlot, itemInfo["name"], toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*", src)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "left item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*", src)
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "glovebox" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Gloveboxes[plate].items[tostring(toSlot)]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:remove-item", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*", src)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "left item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*", src)
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "stash" then
				
				local stashId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[tostring(toSlot)]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:remove-item", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							RemoveFromStash(stashId, fromSlot, itemInfo["name"], toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*", src)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "left item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*", src)
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				-- AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				if fromItemData.name == "bag" then
					if stashId == "canta".. fromItemData.info.stashName then
						RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
						Player.Functions.AddItem(fromItemData.name, fromAmount, fromSlot, fromItemData.info)
						TriggerClientEvent('qb-inventory:client:CloseInv', src)
						TriggerClientEvent('QBCore:Notify', src, "You can't put the same bag in the bag..", 'error')
					else
						AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
					end
				else
					AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				end
			else
				-- drop
				toInventory = tonumber(toInventory)
				if toInventory == nil or toInventory == 0 then
					CreateNewDrop(src, fromSlot, toSlot, fromAmount)
				else
					local toItemData = Drops[toInventory].items[tostring(toSlot)] -- Bug'un düzeltilmesi lazım value nill
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerClientEvent("inventory:client:remove-item", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							RemoveFromDrop(toInventory, fromSlot, itemInfo["name"], toAmount)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*", src)
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent('DiscordBot:ToDiscord', 'itemat', "left item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*", src)
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "You do not own this item!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "otherplayer" then
		local playerId = tonumber(QBCore.Shared.SplitStr(fromInventory, "-")[2])
		local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
		local fromItemData = OtherPlayer.PlayerData.items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:remove-item", OtherPlayer.PlayerData.source, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** from player: **", src, OtherPlayer.PlayerData.source)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "took item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** from player: **", src, OtherPlayer.PlayerData.source)
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = OtherPlayer.PlayerData.items[toSlot]
				OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					--Player.PlayerData.items[fromSlot] = toItemData
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, toSlot)
							OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. " Number of real items: ".. toItemData.amount .. " Item replaced: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "There is no such item on it.!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "trunk" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Trunks[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*", src)
						else
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "stacked item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** from plate: *" .. plate .. "*", src)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. " Number of real items: ".. toItemData.amount .. " Item replaced: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "Picked up from the ground name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** plate: *" .. plate .. "*", src)
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = Trunks[plate].items[toSlot]
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					--Player.PlayerData.items[fromSlot] = toItemData
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							RemoveFromTrunk(plate, toSlot, itemInfo["name"], toAmount)
							AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Snumber of items: " .. toAmount .. "  Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "There is no such item on it.!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "glovebox" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Gloveboxes[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*", src)
						else
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "stacked item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** from plate: *" .. plate .. "*", src)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Gnumber of real items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "Picked up from the ground name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** plate: *" .. plate .. "*", src)
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = Gloveboxes[plate].items[toSlot]
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					--Player.PlayerData.items[fromSlot] = toItemData
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							RemoveFromGlovebox(plate, toSlot, itemInfo["name"], toAmount)
							AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "There is no such item on it.!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "stash" then
		
		local stashId = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Stashes[stashId].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** stash: *" .. stashId .. "*", src)
						else
							TriggerEvent('DiscordBot:ToDiscord', 'itemat', "stacked item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** from stash: *" .. stashId .. "*", src)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					TriggerEvent('DiscordBot:ToDiscord', 'itemat', "Picked up from the ground name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** stash: *" .. stashId .. "*", src)
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = Stashes[stashId].items[toSlot]
				RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					--Player.PlayerData.items[fromSlot] = toItemData
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.amount >= toAmount then
						if toItemData.name ~= fromItemData.name then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
							AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						end
					else
						TriggerClientEvent('env:kapatamk', src)
						TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "There is no such item on it.!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "itemshop" then
		local shopType = QBCore.Shared.SplitStr(fromInventory, "-")[2]
	
		local itemData = ShopItems[shopType].items[fromSlot]
		local price = ShopItems[shopType].items[fromSlot].price
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local bankBalance = Player.PlayerData.money["bank"]
		local buyBank = false

		if price == nil then
			if shopType == "merry" then 
				price = exports["elixir-base"]:merryWeatherPrice(itemInfo["name"])
			elseif shopType == "police" then 
				price = exports["elixir-base"]:policePrice(itemInfo["name"])
			elseif shopType == "ambulance" then
				price = exports["elixir-base"]:ambulancePrice(itemInfo["name"])
			else
				price = exports["elixir-base"]:itemPrice(itemInfo["name"])
			end
		end

		if shopType == "merry" or shopType == "police" or shopType == "ambulance" or shopType == "Itemshop_Tequi_La_La" or shopType == "Itemshop_nightclub" then
			buyBank = true
		end

		if QBCore.Shared.SplitStr(shopType, "_")[1] == "Itemshop" then
			if not buyBank then
				if Player.Functions.RemoveMoney("cash", price*fromAmount, "itemshop-bought-item") then
					if Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info) then
						--TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2], itemData, fromAmount)
						TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " Purchased", "success")
						TriggerEvent('DiscordBot:ToDiscord', 'itemat', "bought: **" .. itemInfo["label"] .. "** Price: $"..price*fromAmount, src)
					else
						TriggerClientEvent('QBCore:Notify', src, "You Are Too Heavy", "error")
					end
				else
					TriggerClientEvent('QBCore:Notify', src, "Not Enough Cash On It!", "error")
					TriggerClientEvent('env:kapatamk', src)
				end
			else
				if Player.Functions.RemoveMoney("bank", price*fromAmount, "itemshop-bought-item") then
					if Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info) then
						--TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2], itemData, fromAmount)
						TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " Purchased", "success")
						TriggerEvent('DiscordBot:ToDiscord', 'itemat', "bought: **" .. itemInfo["label"] .. "** Price: $"..price*fromAmount, src)
					else
						TriggerClientEvent('QBCore:Notify', src, "You Are Too Heavy", "error")
					end
				else
					TriggerClientEvent('QBCore:Notify', src, "Not Enough Money in Your Bank!", "error")
					TriggerClientEvent('env:kapatamk', src)
				end
			end
		else
			if not buyBank then
				if Player.Functions.RemoveMoney("cash", price*fromAmount) then
					if Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info) then
						TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " Purchased", "success")
						TriggerEvent('DiscordBot:ToDiscord', 'itemat', "bought: **" .. itemInfo["label"] .. "** Price: $"..price*fromAmount, src)
					else
						TriggerClientEvent('QBCore:Notify', src, "You Are Too Heavy", "error")
					end
				else
					TriggerClientEvent('QBCore:Notify', src, "Not Enough Cash On It!", "error")
					TriggerClientEvent('env:kapatamk', src)
				end
			else
				if Player.Functions.RemoveMoney("bank", price*fromAmount) then
					if Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info) then
						TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " Purchased", "success")
						TriggerEvent('DiscordBot:ToDiscord', 'itemat', "bought: **" .. itemInfo["label"] .. "** Price: $"..price*fromAmount, src)
					else
						TriggerClientEvent('QBCore:Notify', src, "You Are Too Heavy", "error")
					end
				else
					TriggerClientEvent('QBCore:Notify', src, "Not Enough Money in Your Bank!", "error")
					TriggerClientEvent('env:kapatamk', src)
				end
			end
		end
	elseif fromInventory == "crafting" then
		local itemData = craftingsItems.items[fromSlot]
		if hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftItems", src, itemData.name, itemData.costs, fromAmount, toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent('QBCore:Notify', src, "You Don't Have the Right Items..", "error")
		end
	else
		-- drop
		fromInventory = tonumber(fromInventory)
		if Drops[fromInventory] then
			local fromItemData = Drops[fromInventory].items[fromSlot]
			local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
			if fromItemData ~= nil and fromItemData.amount >= fromAmount then
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				if toInventory == "player" or toInventory == "hotbar" then
					local toItemData = Player.Functions.GetItemBySlot(toSlot)
					RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
					if toItemData ~= nil then
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.amount >= toAmount then
							if toItemData.name ~= fromItemData.name then
								Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
								AddToDrop(fromInventory, fromSlot, toItemData.name, toAmount, toItemData.info)
								TriggerEvent('DiscordBot:ToDiscord', 'itemat', "changed; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** - dropid: *" .. fromInventory .. "*", src)
							else
								TriggerEvent('DiscordBot:ToDiscord', 'itemat', "stacked item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** - from dropid: *" .. fromInventory .. "*", src)
							end
						else
							TriggerClientEvent('env:kapatamk', src)
							TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
						end
					else
						TriggerEvent('DiscordBot:ToDiscord', 'itemat', "Picked up from the ground name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** -  dropid: *" .. fromInventory .. "*", src)
					end
					Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				else
					toInventory = tonumber(toInventory)
					local toItemData = Drops[toInventory].items[toSlot]
					RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
					--Player.PlayerData.items[toSlot] = fromItemData
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						--Player.PlayerData.items[fromSlot] = toItemData
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.amount >= toAmount then
							if toItemData.name ~= fromItemData.name then
								local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
								RemoveFromDrop(toInventory, toSlot, itemInfo["name"], toAmount)
								AddToDrop(fromInventory, fromSlot, itemInfo["name"], toAmount, toItemData.info)
							end
						else
							TriggerClientEvent('env:kapatamk', src)
							TriggerClientEvent('QBCore:Notify', source,  "Not for now, dude. to another time :/", "error")
                        TriggerEvent('DiscordBot:ToDiscord', 'hile', "Tried to dupe. trying to do item: " .. toItemData.name .. "   Number of fake items: " .. toAmount .. "   Actual number of items: ".. toItemData.amount .. "   changed item: " ..fromItemData.name, src, Player.PlayerData.source)
						end
					else
						--Player.PlayerData.items[fromSlot] = nil
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
				end
			else
				TriggerClientEvent("QBCore:Notify", src, "Item Not Found", "error")
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item Not Found", "error")
		end
	end
end)



function hasCraftItems(source, CostItems, amount)
	local Player = QBCore.Functions.GetPlayer(source)
	for k, v in pairs(CostItems) do
		if Player.Functions.GetItemByName(k) ~= nil then
			if Player.Functions.GetItemByName(k).amount < (v * amount) then
				return false
			end
		else
			return false
		end
	end
	return true
end

function IsVehicleOwned(plate)
	local val = false
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'", function(result)
		if (result[1] ~= nil) then
			val = true
		else
			val = false
		end
	end)
	return val
end

local function escape_str(s)
	local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
	local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
	for i, c in ipairs(in_char) do
	  s = s:gsub(c, '\\' .. out_char[i])
	end
	return s
end

-- Shop Items
-- function SetupShopItems(shop, shopItems)
-- 	local items = {}
-- 	if shopItems ~= nil and next(shopItems) ~= nil then
-- 		for k, item in pairs(shopItems) do
-- 			local itemInfo = QBCore.Shared.Items[item.name:lower()]
-- 			local prices = item.price
-- 			if prices == nil then
-- 				if shop == "merry" then 
-- 					prices = exports["elixir-base"]:merryWeatherPrice(itemInfo["name"])
-- 				elseif shop == "police" then 
-- 					prices = exports["elixir-base"]:policePrice(itemInfo["name"])
-- 				elseif shop == "ambulance" then 
-- 					prices = exports["elixir-base"]:ambulancePrice(itemInfo["name"])
-- 				elseif shop == "Itemshop_Ed_Market" then
-- 					prices = exports["elixir-base"]:esxkrshop(itemInfo["name"]) * 3
-- 				else
-- 					prices = exports["elixir-base"]:itemPrice(itemInfo["name"])
-- 				end
-- 			end

-- 			items[item.slot] = {
-- 				name = itemInfo["name"],
-- 				amount = tonumber(item.amount),
-- 				info = item.info ~= nil and item.info or "",
-- 				label = itemInfo["label"],
-- 				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
-- 				weight = itemInfo["weight"], 
-- 				type = itemInfo["type"], 
-- 				unique = itemInfo["unique"], 
-- 				useable = itemInfo["useable"], 
-- 				price = prices,
-- 				image = itemInfo["name"]..".png",
-- 				slot = item.slot,
-- 			}
-- 		end
-- 	end
-- 	return items
-- end

function SetupShopItems(shop, shopItems)
	local items = {}
	if shopItems ~= nil and next(shopItems) ~= nil then
		for k, item in pairs(shopItems) do
			local itemInfo = QBCore.Shared.Items[item.name:lower()]
			local prices = item.price
			
			items[item.slot] = {
				name = itemInfo["name"],
				amount = tonumber(item.amount),
				info = item.info ~= nil and item.info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				price = prices,
				image = itemInfo["name"]..".png",
				slot = item.slot,
			}
		end
	end
	return items
end

-- Stash Items
function GetStashItems(stashId)
	local items = {}
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `stashitems` WHERE `stash` = '"..stashId.."'", function(result)
		if result[1] ~= nil then
			for k, item in pairs(result) do
				
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				items[tostring(item.slot)] = {
					name = itemInfo["name"],
					amount = tonumber(item.amount),
					info = json.decode(item.info) ~= nil and json.decode(item.info) or "",
					label = itemInfo["label"],
					description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
					weight = itemInfo["weight"], 
					type = itemInfo["type"], 
					unique = itemInfo["unique"], 
					useable = itemInfo["useable"], 
					image = itemInfo["name"]..".png",
					slot = item.slot,
				}
			end
			QBCore.Functions.ExecuteSql(false, "DELETE FROM `stashitems` WHERE `stash` = '"..stashId.."'")
		else
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `stashitemsnew` WHERE `stash` = '"..stashId.."'", function(result)
				if result[1] ~= nil then 
					if result[1].items ~= nil then
						result[1].items = json.decode(result[1].items)
						if result[1].items ~= nil then 
							for k, item in pairs(result[1].items) do
								local itemInfo = QBCore.Shared.Items[item.name:lower()]
								items[tostring(item.slot)] = {
									name = itemInfo["name"],
									amount = tonumber(item.amount),
									info = item.info ~= nil and item.info or "",
									label = itemInfo["label"],
									description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
									weight = itemInfo["weight"], 
									type = itemInfo["type"], 
									unique = itemInfo["unique"], 
									useable = itemInfo["useable"], 
									image = itemInfo["name"]..".png",
									slot = item.slot,
								}
							end
						end
					end
				end
			end)
		end
	end)
	return items
end

QBCore.Functions.CreateCallback('qb-inventory:server:GetStashItems', function(source, cb, stashId)
	cb(GetStashItems(stashId))
end)

RegisterServerEvent('qb-inventory:server:SaveStashItems')
AddEventHandler('qb-inventory:server:SaveStashItems', function(stashId, items)
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `stashitemsnew` WHERE `stash` = '"..stashId.."'", function(result)
		if result[1] ~= nil then
			QBCore.Functions.ExecuteSql(false, "UPDATE `stashitemsnew` SET `items` = '"..json.encode(items).."' WHERE `stash` = '"..stashId.."'")
		else
			QBCore.Functions.ExecuteSql(false, "INSERT INTO `stashitemsnew` (`stash`, `items`) VALUES ('"..stashId.."', '"..json.encode(items).."')")
		end
	end)
end)

function SaveStashItems(stashId, items)
	if Stashes[stashId].label ~= "Stash-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
				item.image = nil
				item.useable = nil
				item.weight = nil
				item.label = nil
				item.type = nil
				item.unique = nil
				if item.info then
					if item.info["durubality"] == nil and item.info.type == nil then
						item.info = nil
					end
				end
			end

			QBCore.Functions.ExecuteSql(false, "SELECT * FROM `stashitemsnew` WHERE `stash` = '"..stashId.."'", function(result)
				if result[1] ~= nil then
					QBCore.Functions.ExecuteSql(false, "UPDATE `stashitemsnew` SET `items` = '"..json.encode(items).."' WHERE `stash` = '"..stashId.."'")
					Stashes[stashId].isOpen = false
				else
					QBCore.Functions.ExecuteSql(false, "INSERT INTO `stashitemsnew` (`stash`, `items`) VALUES ('"..stashId.."', '"..json.encode(items).."')")
					Stashes[stashId].isOpen = false
				end
			end)
		end
	end
end

function AddToStash(stashId, slot, otherslot, itemName, amount, info)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]
	local slot = tostring(slot)
	local otherslot = tostring(otherslot)
	if not ItemData.unique then
		if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
			Stashes[stashId].items[slot].amount = Stashes[stashId].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(slot),
			}
		end
	else
		if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(otherslot),
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(slot),
			}
		end
	end
end

function RemoveFromStash(stashId, slot, itemName, amount)
	local amount = tonumber(amount)
	local slot = tostring(slot)
	if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
		if Stashes[stashId].items[slot].amount > amount then
			Stashes[stashId].items[slot].amount = Stashes[stashId].items[slot].amount - amount
		else
			Stashes[stashId].items[slot] = nil
			if next(Stashes[stashId].items) == nil then
				Stashes[stashId].items = {}
			end
		end
	else
		Stashes[stashId].items[slot] = nil
		if Stashes[stashId].items == nil then
			Stashes[stashId].items[slot] = nil
		end
	end
end

-- Trunk items
function GetOwnedVehicleItems(plate)
	local items = {}
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `trunkitems` WHERE `plate` = '"..plate.."'", function(result)
		if result[1] ~= nil then
			for k, item in pairs(result) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				items[tostring(item.slot)] = {
					name = itemInfo["name"],
					amount = tonumber(item.amount),
					info = json.decode(item.info) ~= nil and json.decode(item.info) or "",
					label = itemInfo["label"],
					description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
					weight = itemInfo["weight"], 
					type = itemInfo["type"], 
					unique = itemInfo["unique"], 
					useable = itemInfo["useable"], 
					image = itemInfo["name"]..".png",
					slot = item.slot,
				}
			end
			QBCore.Functions.ExecuteSql(false, "DELETE FROM `trunkitems` WHERE `plate` = '"..plate.."'")
		else
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `trunkitemsnew` WHERE `plate` = '"..plate.."'", function(result)
				if result[1] ~= nil then
					if result[1].items ~= nil then
						result[1].items = json.decode(result[1].items)
						if result[1].items ~= nil then 
							for k, item in pairs(result[1].items) do
								local itemInfo = QBCore.Shared.Items[item.name:lower()]
								items[tostring(item.slot)] = {
									name = itemInfo["name"],
									amount = tonumber(item.amount),
									info = item.info ~= nil and item.info or "",
									label = itemInfo["label"],
									description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
									weight = itemInfo["weight"], 
									type = itemInfo["type"], 
									unique = itemInfo["unique"], 
									useable = itemInfo["useable"], 
									image = itemInfo["name"]..".png",
									slot = item.slot,
								}
							end
						end
					end
				end
			end)
		end
	end)
	return items
end

function SaveOwnedVehicleItems(plate, items)
	if Trunks[plate].label ~= "Trunk-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
				item.image = nil
				item.useable = nil
				item.weight = nil
				item.label = nil
				item.type = nil
				item.unique = nil
				if item.info then
					if item.info["durubality"] == nil and item.info.type == nil then
						item.info = nil
					end
				end
			end

			QBCore.Functions.ExecuteSql(false, "SELECT * FROM `trunkitemsnew` WHERE `plate` = '"..plate.."'", function(result)
				if result[1] ~= nil then
					QBCore.Functions.ExecuteSql(false, "UPDATE `trunkitemsnew` SET `items` = '"..json.encode(items).."' WHERE `plate` = '"..plate.."'", function(result) 
						Trunks[plate].isOpen = false
					end)
				else
					QBCore.Functions.ExecuteSql(false, "INSERT INTO `trunkitemsnew` (`plate`, `items`) VALUES ('"..plate.."', '"..json.encode(items).."')", function(result) 
						Trunks[plate].isOpen = false
					end)
				end
			end)
		end
	end
end

function AddToTrunk(plate, slot, otherslot, itemName, amount, info)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]
	local slot = tostring(slot)
	local otherslot = tostring(otherslot)

	if not ItemData.unique then
		if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
			Trunks[plate].items[slot].amount = Trunks[plate].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(slot),
			}
		end
	else
		if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(otherslot),
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(slot),
			}
		end
	end
end

function RemoveFromTrunk(plate, slot, itemName, amount)
	local slot = tostring(slot)
	if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
		if Trunks[plate].items[slot].amount > amount then
			Trunks[plate].items[slot].amount = Trunks[plate].items[slot].amount - amount
		else
			Trunks[plate].items[slot] = nil
			if next(Trunks[plate].items) == nil then
				Trunks[plate].items = {}
			end
		end
	else
		Trunks[plate].items[slot]= nil
		if Trunks[plate].items == nil then
			Trunks[plate].items[slot] = nil
		end
	end
end

-- Glovebox items
function GetOwnedVehicleGloveboxItems(plate)
	local items = {}
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `gloveboxitems` WHERE `plate` = '"..plate.."'", function(result)
		if result[1] ~= nil then
			for k, item in pairs(result) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				items[tostring(item.slot)] = {
					name = itemInfo["name"],
					amount = tonumber(item.amount),
					info = json.decode(item.info) ~= nil and json.decode(item.info) or "",
					label = itemInfo["label"],
					description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
					weight = itemInfo["weight"], 
					type = itemInfo["type"], 
					unique = itemInfo["unique"], 
					useable = itemInfo["useable"], 
					image = itemInfo["name"]..".png",
					slot = item.slot,
				}
			end
			QBCore.Functions.ExecuteSql(false, "DELETE FROM `gloveboxitems` WHERE `plate` = '"..plate.."'")
		else
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `gloveboxitemsnew` WHERE `plate` = '"..plate.."'", function(result)
				if result[1] ~= nil then 
					if result[1].items ~= nil then
						result[1].items = json.decode(result[1].items)
						if result[1].items ~= nil then 
							for k, item in pairs(result[1].items) do
								local itemInfo = QBCore.Shared.Items[item.name:lower()]
								items[tostring(item.slot)] = {
									name = itemInfo["name"],
									amount = tonumber(item.amount),
									info = item.info ~= nil and item.info or "",
									label = itemInfo["label"],
									description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
									weight = itemInfo["weight"], 
									type = itemInfo["type"], 
									unique = itemInfo["unique"], 
									useable = itemInfo["useable"], 
									image = itemInfo["name"]..".png",
									slot = item.slot,
								}
							end
						end
					end
				end
			end)
		end
	end)
	return items
end

function SaveOwnedGloveboxItems(plate, items)
	if Gloveboxes[plate].label ~= "Glovebox-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
				item.image = nil
				item.useable = nil
				item.weight = nil
				item.label = nil
				item.type = nil
				item.unique = nil
				if item.info then
					if item.info["durubality"] == nil and item.info.type == nil then
						item.info = nil
					end
				end
			end

			QBCore.Functions.ExecuteSql(false, "SELECT * FROM `gloveboxitemsnew` WHERE `plate` = '"..plate.."'", function(result)
				if result[1] ~= nil then
					QBCore.Functions.ExecuteSql(false, "UPDATE `gloveboxitemsnew` SET `items` = '"..json.encode(items).."' WHERE `plate` = '"..plate.."'", function(result) 
						Gloveboxes[plate].isOpen = false
					end)
				else
					QBCore.Functions.ExecuteSql(false, "INSERT INTO `gloveboxitemsnew` (`plate`, `items`) VALUES ('"..plate.."', '"..json.encode(items).."')", function(result) 
						Gloveboxes[plate].isOpen = false
					end)
				end
			end)
		end
	end
end

function AddToGlovebox(plate, slot, otherslot, itemName, amount, info)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]

	local slot = tostring(slot)
	local otherslot = tostring(otherslot)

	if not ItemData.unique then
		if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
			Gloveboxes[plate].items[slot].amount = Gloveboxes[plate].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(slot),
			}
		end
	else
		if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tonumber(otherslot),
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info ~= nil and info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
				weight = itemInfo["weight"], 
				type = itemInfo["type"], 
				unique = itemInfo["unique"], 
				useable = itemInfo["useable"], 
				image = itemInfo["name"]..".png",
				slot = tostring(slot),
			}
		end
	end
end

function RemoveFromGlovebox(plate, slot, itemName, amount)
	local slot = tostring(slot)
	if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
		if Gloveboxes[plate].items[slot].amount > amount then
			Gloveboxes[plate].items[slot].amount = Gloveboxes[plate].items[slot].amount - amount
		else
			Gloveboxes[plate].items[slot] = nil
			if next(Gloveboxes[plate].items) == nil then
				Gloveboxes[plate].items = {}
			end
		end
	else
		Gloveboxes[plate].items[slot]= nil
		if Gloveboxes[plate].items == nil then
			Gloveboxes[plate].items[slot] = nil
		end
	end
end

-- Drop items
function AddToDrop(dropId, slot, itemName, amount, info)
	local slot = tostring(slot)
	local amount = tonumber(amount)
	if Drops[dropId] then Drops[dropId].time = os.time() end
	if Drops[dropId].items[slot] ~= nil and Drops[dropId].items[slot].name == itemName then
		Drops[dropId].items[slot].amount = Drops[dropId].items[slot].amount + amount
	else
		local itemInfo = QBCore.Shared.Items[itemName:lower()]
		Drops[dropId].items[slot] = {
			name = itemInfo["name"],
			amount = amount,
			info = info ~= nil and info or "",
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["name"]..".png",
			slot = tonumber(slot),
			id = dropId,
		}
	end
end

function RemoveFromDrop(dropId, slot, itemName, amount, source)
	local slot = tostring(slot)
	if Drops[dropId] then Drops[dropId].time = os.time() end
	if Drops[dropId].items[slot] ~= nil and Drops[dropId].items[slot].name == itemName then
		if Drops[dropId].items[slot].amount > amount then
			Drops[dropId].items[slot].amount = Drops[dropId].items[slot].amount - amount
		else
			Drops[dropId].items[slot] = nil
			if next(Drops[dropId].items) == nil then
				Drops[dropId].items = {}
				--TriggerClientEvent("inventory:client:RemoveDropItem", -1, dropId)
			end
		end
	else
		Drops[dropId].items[slot] = nil
		if Drops[dropId].items == nil then
			Drops[dropId].items[slot] = nil
		end
	end
	
end

function lengthCalculator(table)
	local Count = 0
	for Index, Value in pairs(table) do
		Count = Count + 1
	end
	return Count
end

function CreateDropId()
	if Drops ~= nil then
		local id = math.random(10000, 99999)
		local dropid = id
		while Drops[dropid] ~= nil do
			id = math.random(10000, 99999)
			dropid = id
		end
		return dropid
	else
		local id = math.random(10000, 99999)
		local dropid = id
		return dropid
	end
end

function CreateNewDrop(source, fromSlot, toSlot, itemAmount)
	local Player = QBCore.Functions.GetPlayer(source)
	local itemData = Player.Functions.GetItemBySlot(fromSlot)
	if Player.Functions.RemoveItem(itemData.name, itemAmount, itemData.slot) then
		TriggerClientEvent("inventory:client:remove-item", source, itemData.name)
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local dropId = CreateDropId()
		Drops[dropId] = {}
		Drops[dropId].items = {}
		Drops[dropId].coords = GetEntityCoords(GetPlayerPed(source))
		Drops[dropId].time = os.time()
		Drops[dropId].items[tostring(toSlot)] = {
			name = itemInfo["name"],
			amount = itemAmount,
			info = itemData.info ~= nil and itemData.info or "",
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["name"]..".png",
			slot = toSlot,
			id = dropId,
		}

		TriggerClientEvent("inventory:client:DropItemAnim", source)
		TriggerClientEvent("inventory:client:AddDropItem", -1, Drops[dropId], dropId)
	else
		TriggerClientEvent("QBCore:Notify", source, "You Don't Own This Item!", "error")
		return
	end
end

QBCore.Commands.Add("randomitems", "Give Random Items (God Only)", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	local filteredItems = {}
	for k, v in pairs(QBCore.Shared.Items) do
		if QBCore.Shared.Items[k]["type"] ~= "weapon" then
			filteredItems[#filteredItems+1] = v
		end
	end
	for i = 1, 10, 1 do
		local randitem = filteredItems[math.random(1, #filteredItems)]
		local amount = math.random(1, 10)
		if randitem["unique"] then
			amount = 1
		end
		if Player.Functions.AddItem(randitem["name"], amount) then
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[randitem["name"]], 'add')
            Wait(500)
		end
	end
end, "god")

QBCore.Commands.Add("resetinv", "Reset inventory ", {{name="type", help="stash/trunk/glovebox"},{name="id/plate", help="ID or plate"}}, true, function(source, args)
	local invType = args[1]:lower()
	table.remove(args, 1)
	local invId = table.concat(args, " ")
	if invType ~= nil and invId ~= nil then 
		if invType == "trunk" then
			if Trunks[invId] ~= nil then 
				Trunks[invId].isOpen = false
			end
		elseif invType == "glovebox" then
			if Gloveboxes[invId] ~= nil then 
				Gloveboxes[invId].isOpen = false
			end
		elseif invType == "stash" then
			if Stashes[invId] ~= nil then 
				Stashes[invId].isOpen = false
			end
		else
			TriggerClientEvent('QBCore:Notify', source,  "Not a valid type..", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', source,  "Arguments not filled in correctly..", "error")
	end
end, "admin")



QBCore.Commands.Add("giveitem", "Give Player Items", {{name="id", help="Player's ID"},{name="item", help="Item Name"}, {name="amount", help="Amount"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local amount = tonumber(args[3])
	local itemData = QBCore.Shared.Items[tostring(args[2]):lower()]
	if Player ~= nil then
		if amount > 0 then
			if itemData ~= nil then
				-- check iteminfo
				local info = {}
				if itemData["type"] == "weapon" then
					amount = 1
					info.serie = tostring("JT" ..QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomInt(5))
					info.durubality = os.time()
				elseif itemData["name"] == "id_card" then
					info.owner = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
					info.citizenid = Player.PlayerData.citizenid
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
					info.gender = Player.PlayerData.charinfo.gender
					info.nationality = Player.PlayerData.charinfo.nationality
				elseif itemData["name"] == "wallet" then
					info.owner = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
					info.citizenid = Player.PlayerData.citizenid
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
					info.gender = Player.PlayerData.charinfo.gender
					info.nationality = Player.PlayerData.charinfo.nationality
				elseif itemData["name"] == "driver_license" then
					info.owner = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
					info.citizenid = Player.PlayerData.citizenid
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
				elseif itemData["name"] == "weaponlicense" then
					info.citizenid = Player.PlayerData.citizenid
					info.owner = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
				end

				if Player.Functions.AddItem(itemData["name"], amount, false, info) then
					TriggerClientEvent('QBCore:Notify', source, GetPlayerName(tonumber(args[1])).." " .. itemData["name"] .. " ("..amount.. ") Verdin", "success")
				    TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/giveitem '..args[1]..' '..args[2]..' '..args[3], source, Player.PlayerData.source)
				else
					TriggerClientEvent('QBCore:Notify', source,  "Unable to Grant Items to Player", "error")
				end
			else
				TriggerClientEvent('QBCore:Notify', source,  "Item Not Available", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', source, "Given Quantity Must Be Greater Than 0")
		end
	else
		TriggerClientEvent('QBCore:Notify', source,  "The player is offline")
	end
end, "admin")

QBCore.Functions.CreateUseableItem("snowball", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	local itemData = Player.Functions.GetItemBySlot(item.slot)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("inventory:client:UseSnowball", source, itemData.amount)
    end
end)

Citizen.CreateThread(function()
	while true do
		for x,y in pairs(Drops) do
			if (os.time() - y.time) > 600 and y.isOpen ~= 1 then
				Drops[x] = nil
				TriggerClientEvent("inventory:client:RemoveDropItem", -1, x)
			end
		end
		Citizen.Wait(300000)
	end
end)

QBCore.Functions.CreateCallback('lj-inventory:server:GetClosePlayersName', function(source, cb, closestPlayers)
    local players = {}
	for k, v in pairs(closestPlayers) do
		if v ~= source then
			local closePlayer = QBCore.Functions.GetPlayer(v)
			local name = closePlayer.PlayerData.charinfo.firstname .." ".. closePlayer.PlayerData.charinfo.lastname
			table.insert(players, {
				name = name,
				serverId = v
			})
		end
	end
	cb(players)
end)

RegisterServerEvent("inventory:server:GiveItem0", function(target, name, amount, slot, isMask)
    local src = source
	amount = tonumber(amount)
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(target))
    local dist = #(GetEntityCoords(GetPlayerPed(src))-GetEntityCoords(GetPlayerPed(target)))
  	if Player == OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, "Can't you give yourself an item?") end
  	if dist > 2 then return TriggerClientEvent('QBCore:Notify', src, "You're too far to give stuff!") end
  	local item = Player.Functions.GetItemBySlot(slot)
	if amount == 0 then amount = item.amount end

  	if item.name ~= name.name then TriggerClientEvent('QBCore:Notify', src, "Wrong item found try again!"); return end
  	if amount <= item.amount then
    	if amount == 0 then	amount = item.amount end
    	if Player.Functions.RemoveItem(item.name, amount, item.slot) then
      	if OtherPlayer.Functions.AddItem(item.name, amount, false, item.info) then
        TriggerClientEvent('inventory:client:ItemBox',target, QBCore.Shared.Items[item.name], "add")
        TriggerClientEvent('QBCore:Notify', target, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. " by "..amount..' amopunt '..item.label.." you received")
        TriggerClientEvent("inventory:client:UpdatePlayerInventory", target, true)
        TriggerClientEvent('inventory:client:ItemBox',src, QBCore.Shared.Items[item.name], "remove")
		local otherName = OtherPlayer.PlayerData.charinfo.firstname.." "..OtherPlayer.PlayerData.charinfo.lastname
		if isMask == "true" or isMask == true then
			otherName = "Anonymous"
		end
		
        TriggerClientEvent('QBCore:Notify', src, "" ..otherName .. "'e " .. amount .. " amount " .. item.label .." you gave!")
        TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
        TriggerClientEvent('qb-inventory:client:giveAnim', src)
		TriggerEvent('3dme:display', "Gets the Extended Item", QBCore.Key, "me", otherName, target)
        TriggerClientEvent('qb-inventory:client:giveAnim', OtherPlayer)
      else
        Player.Functions.AddItem(item.name, amount, item.slot, item.info)
        TriggerClientEvent('QBCore:Notify', src,  "Other players' inventory is full!", "error")
        TriggerClientEvent('QBCore:Notify', target,  "Your inventory is full!", "error")
        TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
        TriggerClientEvent("inventory:client:UpdatePlayerInventory", target, false)
      end
    else
      TriggerClientEvent('QBCore:Notify', src,  "You don't have enough items", "error")
    end
  else
    TriggerClientEvent('QBCore:Notify', src, "You do not have enough items to transfer")
  end
end)


