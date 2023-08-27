local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ra1derMethCar:start')
AddEventHandler('ra1derMethCar:start', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Aseton = Player.Functions.GetItemByName("aseton") --Aseton
    local MethTepsi = Player.Functions.GetItemByName("methtray") -- Meth Tepsisi
	local BosPaket = Player.Functions.GetItemByName("poset") -- Boş Paket
	local ItemSafMeth = Player.Functions.GetItemByName("meth") -- Saf Meth
	if Aseton ~= nil and MethTepsi ~= nil and BosPaket ~= nil and ItemSafMeth ~= nil then
		if Aseton.amount >= 5 and MethTepsi.amount >= 1 and BosPaket.amount >= 1 and ItemSafMeth.amount >= 10 then	
			TriggerClientEvent("ra1derMethCar:startprod", _source)
			Player.Functions.RemoveItem("aseton", 5, false)
			Player.Functions.RemoveItem("meth", 10, false)
			Player.Functions.RemoveItem("poset", 5, false)
		else
			TriggerClientEvent('ra1derMethCar:stop', _source)
			TriggerClientEvent('QBCore:Notify', source, "You don't have enough of your necessary items to cook meth", 'error')
		end
	else
		TriggerClientEvent('ra1derMethCar:stop', _source)
		TriggerClientEvent('QBCore:Notify', source, "You don't have the necessary items", 'error')
	end
end)

RegisterServerEvent('ra1derMethCar:make')
AddEventHandler('ra1derMethCar:make', function(posx,posy,posz)
	local src   = source
    local Player = QBCore.Functions.GetPlayer(src)
	local xPlayers   = QBCore.Functions.GetPlayers(Player)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('ra1derMethCar:smoke',xPlayers[i],posx,posy,posz, 'a') 
	end
end)

RegisterServerEvent('ra1derMethCar:finish')
AddEventHandler('ra1derMethCar:finish', function(qualtiy)
	local src   = source
    local Player = QBCore.Functions.GetPlayer(src)
	local rnd = math.random(-7, 1)
	local qualitynew = qualtiy - 3
	local top = (math.floor(qualitynew / 2) + rnd)
	local function iptal()
		local agirlik = {
			aseton = 5,
			meth = 10,
			poset = 5
		}
		local topA = 0
		for k,v in pairs(agirlik) do
			topA = topA + (QBCore.Shared.Items[k].weight * v)
		end
		if topA + QBCore.Player.GetTotalWeight(Player.PlayerData.items) <= QBCore.Config.Player.MaxWeight then
			for k,v in pairs(agirlik) do
				Player.Functions.AddItem(k,v)
				TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[k], "add")
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "You Are Too Heavy, So the transaction could not be completed. \nYour items could not be returned due to your weight.", "error")
		end
	end
	if top > 0 then
		local topW = (QBCore.Shared.Items["islenmismeth"].weight * top)
		if topW + QBCore.Player.GetTotalWeight(Player.PlayerData.items) <= QBCore.Config.Player.MaxWeight then
			Player.Functions.AddItem('islenmismeth', top)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['islenmismeth'], "add")
		else
			iptal()
		end
	else
		iptal()
	end
end)

RegisterServerEvent('ra1derMethCar:blow')
AddEventHandler('ra1derMethCar:blow', function(posx, posy, posz)
	local src   = source
    local Player = QBCore.Functions.GetPlayer(src)
    local xPlayers   = QBCore.Functions.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('ra1derMethCar:blowup', xPlayers[i],posx, posy, posz)
	end
end)
