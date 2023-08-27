QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)



RegisterCommand("skin", function(source, args, rawCommand)
    local src = source
	if QBCore.Functions.GetPermission(src) == "god" or QBCore.Functions.GetPermission(src) == "adminplus" or QBCore.Functions.GetPermission(src) == "admin" or QBCore.Functions.GetPermission(src) == "mod" then
		if (args[1] ~= nil) then
			local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
			if Player ~= nil then
				TriggerClientEvent('raidClothing:adminEvent', Player.PlayerData.source)
			else
				TriggerClientEvent('QBCore:Notify', src, "Sistem", "Oyuncu aktif değil!")
			end
		else
			TriggerClientEvent('raidClothing:adminEvent', src)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 'Sistem', 'Yeterli yetkiye sahip değilsin!')
	end
end, false)

RegisterCommand("kafa", function(source, args, rawCommand)
	TriggerClientEvent("qb-clothing:setKafa", source, args)
end, false)

-- Callbacks
QBCore.Functions.CreateCallback('raidClothing:getPlayerSkin', function(source, cb)
    local src = source
	local pedAppearance = nil 
    local Player = QBCore.Functions.GetPlayer(src)
    local players_appearance = exports.oxmysql:executeSync('SELECT appearance FROM players_appearance WHERE citizenid = ?', {Player.PlayerData.citizenid})
    if players_appearance[1] then
	    pedAppearance = json.decode(players_appearance[1].appearance)
    end
    cb(pedAppearance, Player.PlayerData.charinfo.gender)
end)

-- Events
RegisterServerEvent("raidClothing:saveSkin") 
AddEventHandler('raidClothing:saveSkin', function(pedModel, pedAppearance)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if pedModel ~= nil and pedAppearance ~= nil then 
        exports.oxmysql:execute('DELETE FROM players_appearance WHERE citizenid = ?', {Player.PlayerData.citizenid}, function()
            exports.oxmysql:execute('INSERT INTO players_appearance (citizenid, model, appearance) VALUES (?, ?, ?)', {Player.PlayerData.citizenid, json.encode(pedModel), json.encode(pedAppearance)})
        end)
    end
end)


otuzbir = {
	["wallet"] = {amount = 1, item = "wallet"},
	["id_card"] = {amount = 1, item = "id_card"},
}
-- Functions
local function baslangicesya(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for _, v in pairs(otuzbir) do
        local info = {}
        if v.item == "wallet" then
			info.owner = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
			info.citizenid = Player.PlayerData.citizenid
			info.firstname = Player.PlayerData.charinfo.firstname
			info.lastname = Player.PlayerData.charinfo.lastname
			info.birthdate = Player.PlayerData.charinfo.birthdate
			info.gender = Player.PlayerData.charinfo.gender
			info.nationality = Player.PlayerData.charinfo.nationality
		elseif v.item == "id_card" then 
			info.owner = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
			info.citizenid = Player.PlayerData.citizenid
			info.firstname = Player.PlayerData.charinfo.firstname
			info.lastname = Player.PlayerData.charinfo.lastname
			info.birthdate = Player.PlayerData.charinfo.birthdate
			info.gender = Player.PlayerData.charinfo.gender
			info.nationality = Player.PlayerData.charinfo.nationality
         end
		Player.Functions.AddItem(v.item, 1, false, info) 
		Player.Functions.AddItem("white_phone", 1, false) 
		Player.Functions.AddItem("atom", 1, false) 
		Player.Functions.AddItem("burgerxl", 1, false) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['id_card'], "add", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wallet'], "add", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['white_phone'], "add", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['atom'], "add", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['burgerxl'], "add", 1)
		SetPlayerRoutingBucket(src, 0)
    end
end



RegisterNetEvent("kimlikver")
AddEventHandler("kimlikver", function()
	local src = source
	baslangicesya(src)
end)


QBCore.Commands.Add("ped", "Give the player pedmenu", {{name="id", help="Player's id"}, {name="hash", help="Ped Hashi"}}, false, function(source, args)
	TriggerClientEvent("qb-clothing:client:ped", args[1], args[2])
end, "god")


RegisterServerEvent("raidClothing:setRoutingBucket") 
AddEventHandler('raidClothing:setRoutingBucket', function(key)
    local src = source
	if QBCore.Functions.kickHacKer(src, key) then
		SetPlayerRoutingBucket(src, src)
    end
end)

-- Player Outfits 
RegisterNetEvent('raidClothing:saveOutfit', function(name, pedModel, pedComponents, pedProps)
	local Player = QBCore.Functions.GetPlayer(source)
    local cash = Player.PlayerData.money["cash"]
	local price = 50
	if cash >= price then
        Player.Functions.RemoveMoney('bank', 50)
		TriggerClientEvent('QBCore:Notify', source, "The outfit was purchased for $ 50")
		exports.oxmysql:execute('INSERT INTO `players_outfits` (citizenid, name, ped, components, props) VALUES (?, ?, ?, ?, ?)', {Player.PlayerData.citizenid, name, json.encode(pedModel), json.encode(pedComponents), json.encode(pedProps)})
    else
		TriggerClientEvent('QBCore:Notify', source,  "Yeterli Paran Yok!")
    end
end)



RegisterNetEvent('raidClothing:getOutfit', function(name)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local outfit = exports.oxmysql:executeSync('SELECT outfit FROM players_outfits WHERE citizenid = ? AND name = ?', {Player.PlayerData.citizenid, name})
	local newOutfit = outfit
	if newOutfit then
		newOutfit = json.decode(newOutfit)
		TriggerClientEvent('raidClothing:setOutfit', src, newOutfit)
	end
end)

RegisterNetEvent('raidClothing:getOutfits', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local myOutfits = {}
	local result = exports.oxmysql:executeSync('SELECT id, name, ped, components, props FROM players_outfits WHERE citizenid = ?', {Player.PlayerData.citizenid})
	for i=1, #result, 1 do
		table.insert(myOutfits, {id = result[i].id, name = result[i].name, ped = json.decode(result[i].ped), components = json.decode(result[i].components), props = json.decode(result[i].props)})
	end
	TriggerClientEvent('raidClothing:sendOutfits', src, myOutfits)
end)


-- PD Presets
RegisterNetEvent('raidClothing:deleteOutfit', function(id)
	local Player = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute('DELETE FROM players_outfits WHERE id = ?', {id})
end)

