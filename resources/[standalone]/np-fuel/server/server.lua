-- Variables

local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end

-- Server Events

RegisterNetEvent("np-fuel:server:OpenMenu", function (amount, inGasStation, hasWeapon)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	local tax = GlobalTax(amount)
	local total = math.ceil(amount + tax)
	TriggerClientEvent('qb-menu:client:openMenu', src, {
		{
			header = "Gas Station",
			icon = "fas fa-gas-pump",
			txt = "If you walk away without releasing the pump, you will be fined.!",
			isMenuHeader = true
		},
		{
				id = 1,
				header = "Payment Process",
				icon = "fas fa-hand-holding",
				-- txt = 'Vergiler dahil toplam maliyet: $'..amount + tax ..' olacaktır.' ,
				txt = 'Total cost including taxes: <span style="color:#64e887;">$' ..amount + tax ..' </span> ',
				params = {
					event = "np-fuel:client:RefuelVehicle",
					args = total,
				}
			},
		})
	end)



QBCore.Functions.CreateCallback('np-fuel:server:fuelCan', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local itemData = Player.Functions.GetItemByName("weapon_petrolcan")
    cb(itemData)
end)

RegisterNetEvent("np-fuel:server:PayForFuel", function (amount)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	player.Functions.RemoveMoney('cash', amount)
end)


RegisterNetEvent("np-fuel:server:Ceza", function (amount)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	-- player.Functions.RemoveMoney('bank', 100)
end)
