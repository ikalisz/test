QBCore = nil
local loadedBlips = {}
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local craft = {
	["nitrocu"] = {
        coord = vector3(-239.1, -1397.81, 31.28),
		heading = 281.2,
		ModelHash = 0xC4B715D2,
		label = 'Nitroman Jack',
		BlipPos = {type = 478, color = 39, size = 0.6},
		hasBlip = false,
        items = {
            {
                name = "nos",
                amount = 1,
                costs = {
                    ["bos_tup"] = 10,
                },
                type = "item",
            },
        }
    },
    ["caki"] = {
        coord = vector3(1636.299072265625, 2565.261474609375, 45.56487274169922),
		heading = 183.4289703369141,
		ModelHash = 0xB1BB9B59,
		label = 'Troubled Kursad',
		BlipPos = {type = 478, color = 39, size = 0.6},
		hasBlip = false,
        items = {
            {
                name = "weapon_shiv",
                amount = 1,
                costs = {
                    ["crudemetal"] = 30,
                },
                type = "item",
            },
        }
    },
	["carl"] = {
        coord = vector3(-277.82, 2205.5, 130.4),
		heading = 60.4289703369141,
		ModelHash = 0x52060D92,
		label = 'Bomber Carl',
		BlipPos = {type = 478, color = 39, size = 0.6},
		hasBlip = false,
        items = {
            {
                name = "thermite",
                amount = 2,
                costs = {
                    ["guvenlik_karti_d"] = 1,
                },
                type = "item",
            },
        }
    },
}

Citizen.CreateThread(function()
	for name, craft in pairs(craft) do
		exports["elixir-base"]:pedcreate("craftnpc-"..craft.label, craft.ModelHash, craft.coord.x, craft.coord.y, craft.coord.z - 1, craft.heading)
		exports["elixir-base"]:addNotif("E", craft.label, 1.2, 1.2, vector3(craft.coord.x, craft.coord.y, craft.coord.z))
	end

    while true do
        local time = 500
        if coreLoaded then
            for name, craft in pairs(craft) do
                local distance = #(craft.coord - GetEntityCoords(PlayerPedId()))
                if distance < 1.2 then
                    time = 1
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("ra1derCrafting:open", craft.label, craft.items)
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)



RegisterNetEvent('ra1derCrafting:open')
AddEventHandler('ra1derCrafting:open', function(isim, table)
	local crafting = {label = isim}
	crafting.items = GetThresholdItems(table)
	TriggerServerEvent("inventory:server:OpenInventory", "crafting", math.random(1, 99), crafting)
end)



function GetThresholdItems(table)
	local items = {}
	local number = 1
	local CraftingItems = ItemsToItemInfo(table)
	local oldConfig = CraftingItems
	for k, item in pairs(oldConfig) do
		items[number] = oldConfig[k]
		number = number + 1
	end
	return items
end

function ItemsToItemInfo(table)
	local items = {}
	local slot = 0
	for k, item in pairs(table) do
		slot = slot + 1
		table[k].slot = slot
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		local itemCostLabel = ""
		local first = true
		for itemName, itemAmount in pairs(item.costs) do
            if QBCore.Shared.Items[itemName] ~= nil then 
			    if first then
                    first = false 
                    itemCostLabel = "Gerekenler: " ..itemAmount.. "x " ..QBCore.Shared.Items[itemName]["label"] ..""
                else
                    itemCostLabel =  itemCostLabel ..", "..QBCore.Shared.Items[itemName]["label"] .. ": "..itemAmount.."x"
                end
            else
                QBCore.Functions.Notify(itemName.. " Named Item Not Found, Contact Authorities", 'error', 7500)
                return {}
            end
		end

		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = {costs = itemCostLabel},
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["name"]..".png",
			slot = item.slot,
			costs = item.costs,
			job = item.job,
			allcost = item.costs,
		}
		end
	return items
end

