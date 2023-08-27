local PlayerData = {}
QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('blackmarket:ac')
AddEventHandler('blackmarket:ac', function()
	-- if exports['jtLevelSystem']:getXP() >= 45 then
		OpenShipments()
	-- else
		-- QBCore.Functions.Notify("Tecrüben Yetersiz!", "error")
	-- end
end)

Citizen.CreateThread(function()
	exports["elixir-base"]:pedcreate("karadayi", 0x6BD9B68C, Config.Pos.x, Config.Pos.y, Config.Pos.z, Config.Pos.h)
	while true do
		local time = 1000
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Pos.x, Config.Pos.y, Config.Pos.z, true) <= 2 and coreLoaded then
			time = 1
			-- QBCore.Functions.DrawText3D(Config.Pos.x, Config.Pos.y, Config.Pos.z+ 2.0, "~w~[~g~E~w~] Kara Dayı", 0.40)
			-- if IsControlJustReleased(0, 38) then
			-- 	if exports['jtLevelSystem']:getXP() >= 50 then
			-- 		OpenShipments()
			-- 	else
			-- 		QBCore.Functions.Notify("Tecrüben Yetersiz!", "error")
			-- 	end
			-- end
		end
		Citizen.Wait(time)
	end       
end)

function OpenShipments()
	QBCore.UI.Menu.Open( 'default', GetCurrentResourceName(), 'shipments',{
		title    = 'Illegal Goods Smuggling',
		align    = 'left',
		elements = { 
			{label = 'Ordering illegal goods', value = 'sipVer'},
			{label = 'Ordered illegal items', value = 'shipments'}	
		}
	},function(data, menu)
		if data.current.value == 'sipVer' then
			OpenMuhimmat()
		elseif data.current.value == 'shipments' then
			GetAllShipments()
		end
	end,function(data, menu)
		menu.close()
	end)
end

function GetAllShipments()
	local elements = {}
	QBCore.Functions.TriggerCallback('blackmarket:getTime', function(time)
		QBCore.Functions.TriggerCallback('blackmarket:getAllShipments', function(items)
			local once = true
			local once2 = true
			local falan = false
			local filan = false

			for i=1, #items, 1 do
				if time - items[i].time <= Config.DeliveryTime and once then
					--table.insert(elements, {label = '--SİPARİŞLER BEKLENİYOR--'})
					filan = true
					once = false
				end

				if time - items[i].time <= Config.DeliveryTime then
					times = time - items[i].time
					table.insert(elements, {label = items[i].label .. ' Remaining time: ' .. math.floor((Config.DeliveryTime - times) / 60) .. ' minute' })
				end
				
				if time - items[i].time >= Config.DeliveryTime then
					table.insert(elements, {label = items[i].label,	value = items[i].item, price = items[i].price})
				end

				if time - items[i].time >= Config.DeliveryTime and once2 then
					--table.insert(elements, {label = 'Tüm Siparişleri Al', value = 'pickup'})
					once2 = false
					falan = true
				end
			end
			
			if falan == true and filan == false then
				table.insert(elements, {label = 'Get All Orders', value = 'pickup'})
				falan = false
			end
				
			QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'allshipments',  {
				title    = 'Ordered Materials',
				align    = 'left',
				elements = elements
			},function(data, menu)
				if data.current.value == 'pickup' then
					menu.close()
					QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
						if AktifPolis >= 0 then
							QBCore.Functions.TriggerCallback('blackmarkets:GetAllItems', function(status)
								if status then
									--TriggerEvent("Tgiann:PolisBildirimAdimBirSiyahMarket")
									TriggerEvent("elixir-base:soygun-engel")
								end
							end)
						else
							QBCore.Functions.Notify("Not Enough Police", "error")
						end
					end)   
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function OpenMuhimmat()
	local elements = {}
	  for i=1, #Config.ItemsMuhimmat, 1 do
		local itemName = QBCore.Shared.Items[Config.ItemsMuhimmat[i].item].label
		local fiyat = exports["elixir-base"]:BlackMarket(Config.ItemsMuhimmat[i].item)	
		table.insert(elements, {labels = itemName, label = itemName .. ' $' .. fiyat .. ' ',	value = Config.ItemsMuhimmat[i].item, price = fiyat})
	end

	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'shipitem',{
		title    = 'Illegal Ammunition Trade',
		align    = 'left',
		elements = elements
	}, function(data, menu)
	if data.current.value ~= nil then
		QBCore.UI.Menu.CloseAll()

		QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'eşya_al',{
			title = "Amount of Items to be Purchased"
		}, function(data2, menu2)
			local yazilanesya = tonumber(data2.value)
			if yazilanesya > 0 then
				TriggerEvent("disc-inventoryhud:closedSecondInventory")
				TriggerServerEvent('blackmarket:MakeShipment', data.current.value, data.current.price*yazilanesya, yazilanesya, data.current.labels)
			end
			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)
	end

	end, function(data2, menu2)
		menu2.close()
	end)
end

RegisterNetEvent('Tgiann:PolisBildirimAdimBirSiyahMarket')
AddEventHandler('Tgiann:PolisBildirimAdimBirSiyahMarket', function()
	Citizen.Wait(30000)
	TriggerEvent("Tgiann-PolisBildirim:BildirimGonder", "Buying Illegal Items", false)
	TriggerServerEvent("EmergencyBlips:black-market-open")
	Citizen.Wait(60000 * math.random(4,5))
	TriggerServerEvent("EmergencyBlips:black-market-close")
end)

Renkler = {
	['0'] = "Black",
	['1'] = "Black",
	['2'] = "Black",
	['3'] = "Dark Silver",
	['4'] = "Metallic Silver",
	['5'] = "Metallic Blue Silver",
	['6'] = "Metallic Steel Gray",
	['7'] = "Metallic Silver",
	['8'] = "Metallic Silver",
	['9'] = "Metallic Night Silver",
	['10'] = "Metal",
	['11'] = "Metallic Grey",
	['12'] = "Mattete black",
	['13'] = "Matte Gray",
	['14'] = "Matte Light grey",
	['15'] = "Black",
	['16'] = "Black ",
	['17'] = "Dark Silver",
	['18'] = "Silver",
	['19'] = "Gun Metal",
	['20'] = "Silver",
	['21'] = "Black",
	['22'] = "Graphite",
	['23'] = "Silver grey",
	['24'] = "Silver",
	['25'] = "Silver Blue",
	['26'] = "Silver",
	['27'] = "Metallic Red",
	['28'] = "Metallic Turin Red",
	['29'] = "Metallic Formula Red",
	['30'] = "Metallic Blaze Red",
	['31'] = "Metallic Graceful Red",
	['32'] = "Metallic Garnet Red",
	['33'] = "Metallic Desert Red",
	['34'] = "Metallic Cabernet Red",
	['35'] = "Metallic Candy Red",
	['36'] = "Metallic Sunrise Orange",
	['37'] = "Metallic Classic Gold",
	['38'] = "Metallic Orange",
	['39'] = "Matte Red",
	['40'] = "Matte Dark Red",
	['41'] = "Matte Orange",
	['42'] = "Matte Yellow",
	['43'] = "Red",
	['44'] = "Bright Red",
	['45'] = "Garnet Red",
	['46'] = "Red",
	['47'] = "Golden Red",
	['48'] = "Dark Red",
	['49'] = "Metallic Dark Green",
	['50'] = "Metallic Racing Green",
	['51'] = "Metallic Sea Green",
	['52'] = "Metallic Olive Green",
	['53'] = "Metallic Green",
	['54'] = "Metallic Gasoline Blue Green",
	['55'] = "Matte Lime Green",
	['56'] = "Dark Green",
	['57'] = "Green",
	['58'] = "Dark Green",
	['59'] = "Green",
	['60'] = "Teal",
	['61'] = "Metallic Midnight Blue",
	['62'] = "Metallic Dark Blue",
	['63'] = "Metallic Saxony Blue",
	['64'] = "Metallic Blue",
	['65'] = "Metallic Mariner Blue",
	['66'] = "Metallic Harbor Blue",
	['67'] = "Metallic Diamond Blue",
	['68'] = "Metallic Surf Blue",
	['69'] = "Metallic Nautical Blue",
	['70'] = "Metallic Brilliant Blue",
	['71'] = "Metallic Violet Blue",
	['72'] = "Metallic Spinnaker Blue",
	['73'] = "Metallic Ultra Blue",
	['74'] = "Metallic Light Blue",
	['75'] = "Dark Blue",
	['76'] = "Night Blue",
	['77'] = "Blue",
	['78'] = "Sea Foam Blue",
	['79'] = "Uil Light Blue",
	['80'] = "Maui Blue",
	['81'] = "Light Blue",
	['82'] = "Matte Dark Blue",
	['83'] = "Matte Blue",
	['84'] = "Matte Midnight Blue",
	['85'] = "Dark Blue",
	['86'] = "Blue",
	['87'] = "Light Blue",
	['88'] = "Metallic Yellow",
	['89'] = "Metallic Yellow",
	['90'] = "Metallic Bronze",
	['91'] = "Metallic Yellow",
	['92'] = "Metallic Lime",
	['93'] = "Metallic Champagne",
	['94'] = "Metallic Pueblo Beige",
	['95'] = "Metallic Dark Ivory",
	['96'] = "Metallic Brown",
	['97'] = "Metallic Golden Brown",
	['98'] = "Metallic Light Brown",
	['99'] = "Metallic Straw Beige",
	['100'] = "Metallic Moss Brown",
	['101'] = "Metallic Biston Brown",
	['102'] = "Metallic Beechwood",
	['103'] = "Metallic Dark Beechwood",
	['104'] = "Metallic Orange",
	['105'] = "Metallic Sand",
	['106'] = "Metallic Sand",
	['107'] = "Metallic Cream",
	['108'] = "Brown",
	['109'] = "Brown",
	['110'] = "Light Brown",
	['111'] = "Metallic White",
	['112'] = "Metallic Ice White",
	['113'] = "Honey Beige",
	['114'] = "Brown",
	['115'] = "Dark Brown",
	['116'] = "Straw Beige",
	['117'] = "Steel",
	['118'] = "Black Steel",
	['119'] = "Aluminum",
	['120'] = "Chrome",
	['121'] = "Off White",
	['122'] = "Off White",
	['123'] = "Orange",
	['124'] = "Light Orange",
	['125'] = "Metallic Securicor Green",
	['126'] = "Taxi Yellow",
	['127'] = "Police Blue",
	['128'] = "Matte Green",
	['129'] = "Matte Brown",
	['130'] = "Orange",
	['131'] = "Matte White",
	['132'] = "White",
	['133'] = "Olive Soldier Green",
	['134'] = "Pure White",
	['135'] = "Hot Pink",
	['136'] = "Salmon Pink",
	['137'] = "Metallic Vermillion Pink",
	['138'] = "Orange",
	['139'] = "Green",
	['140'] = "Blue",
	['141'] = "Mettalic Black Blue",
	['142'] = "Metallic Black Purple",
	['143'] = "Metallic Black Red",
	['144'] = "Hunter Green",
	['145'] = "Metallic Purple",
	['146'] = "Metaillic Dark Blue",
	['147'] = "MODSHOP Black",
	['148'] = "Matte Purple",
	['149'] = "Matte Dark Purple",
	['150'] = "Metallic Lava Red",
	['151'] = "Matte Forest Green",
	['152'] = "Matte Olive Drab",
	['153'] = "Matte Desert Brown",
	['154'] = "Matte Desert Tan",
	['155'] = "Matte Foilage Green",
	['156'] = "DEFAULT ALLOY COLOR",
	['157'] = "Epsilon Blue",
}

exports['qb-target']:AddTargetModel(0x6BD9B68C, {
	options = {
		{
			type = "client",
			event = "blackmarket:ac",
			icon = "fas fa-shopping-basket",
			label = "Talk to Uncle Black",
		},
	},
	distance = 2,
})

