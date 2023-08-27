

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local PlayerData = {}

local ATMObjects = {
	-870868698,
	-1126237515,
	-1364697528,
	506770882,
}

local banks = {
	{name="Banka", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Banka", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Banka", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Banka", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Banka", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Banka", id=108, x=-351.534, y=-49.529, z=49.042},
}



local prop = {
    "prop_atm_01",
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm",
}
  exports['qb-target']:AddTargetModel(prop, {
      options = {
          {
              type = "client",
              event = "bankanim",
              icon = "fas fa-dollar-sign",
              label = "ATM",
        },
    },
        distance = 1.5    
})

RegisterNetEvent("bankanim", function()
	local nearAtm, nearBank = true, true
	local ped = PlayerPedId()
	ExecuteCommand("e atm")
	QBCore.Functions.Progressbar("use_bank", "Inserting Card!", 1500, false, false, { 
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true
	}, {}, {}, {}, function() -- Done
		local PlayerData = QBCore.Functions.GetPlayerData()
        TriggerEvent("raidBanking:OpenBank")
	end, function() -- Cancel
		local nearAtm, nearBank = false, false
	end)
end)




local blip = false
local aktifblipler = {}
RegisterNetEvent("raidBanking:blipAcKapa")
AddEventHandler("raidBanking:blipAcKapa", function()
	if blip then
		pasifblip()
		blip = false
	else
		aktifblip()
		blip = true
	end
end)

function aktifblip()
	for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Bank")
		EndTextCommandSetBlipName(blip)
		table.insert(aktifblipler, blip)
	end
end

function pasifblip()
	for i = 1, #aktifblipler do
		RemoveBlip(aktifblipler[i])
	end
	aktifblipler = {}
end

-- NUI Variables
local nearAtm, nearBank = false, false
RegisterNetEvent('raidBanking:client:OpenBank')
AddEventHandler('raidBanking:client:OpenBank', function(playerData, actv)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'open',
        data = playerData
    })

    SendNUIMessage({
        action = 'updateActivity',
        results = actv
    })
end)

RegisterNetEvent("raidBanking:update", function(actv)
    SendNUIMessage({
        action = 'updateActivity',
        results = actv
    })
end)

RegisterNetEvent('raidBanking:client:UpdateBank')
AddEventHandler('raidBanking:client:UpdateBank', function(playerData)
    SendNUIMessage({
        action = 'updatePlayerData',
        data = playerData
    })
end)

RegisterNUICallback('close', function()
    QBCore.Functions.Progressbar("use_bank", "Closing...!", 1500, false, false, { 
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true
	}, {}, {}, {}, function() -- Done
		local PlayerData = QBCore.Functions.GetPlayerData()
    ExecuteCommand("e c")
    SetNuiFocus(false, false)
	end, function() -- Cancel
		local nearAtm, nearBank = false, false
	end)
end)

RegisterNUICallback('TransferMoney', function(data, cb)
    local src = source
    if data.iban ~= nil and data.amount ~= nil then
        QBCore.Functions.TriggerCallback('raidBanking:server:TransferMoney', function(retval)
            if retval or data.iban then
                Citizen.Wait(500)
                TriggerServerEvent('raidBanking:server:UpdateBank')
            else
                SendNUIMessage({
                    action = "notify",
                    message = "This IBAN is Invalid!",
                    type = "error",
                })
            end
        end, data.iban, data.amount)
    end

    cb(retval)
end)

RegisterNUICallback('TakeMoney', function(data, cb)
    local src = source
    if data.type ~= nil and data.amount ~= nil then
        QBCore.Functions.TriggerCallback('raidBanking:server:TakeMoney', function(retval)
            if retval then
                Citizen.Wait(500)
                TriggerServerEvent('raidBanking:UpdateBank')
            end
        end, data.amount, data.type)
    end
    cb(retval)
end)

RegisterNUICallback('UpdateBank', function()
    TriggerServerEvent('raidBanking:UpdateBank')
end)

RegisterNetEvent('raidBanking:OpenBank')
AddEventHandler('raidBanking:OpenBank', function()
    TriggerServerEvent('raidBanking:OpenBank')
end)

RegisterNetEvent("target:paraver:basari",function()
    QBCore.Shared.RequestAnimDict('mp_common', function()
        TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake2_a', 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    end)
end)

RegisterNetEvent("target:nakitver", function(id)
    local Player = QBCore.Functions.GetPlayerData()
    local money = Player.money.cash
    QBCore.Functions.Notify('' ..money.. "$ You Have Cash", 'primary', 7500)
    local input = exports['qb-input']:ShowInput({
        header = "Para Ver",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Enter Money Value'
            },
        },
    })
    if input then
        input.amount = input.amount and tonumber(input.amount) or 0
        if input.amount and input.amount > 0 then
            QBCore.Functions.TriggerCallback("target:paraver",function(cb)
                if cb then
                    --
                end
            end,GetPlayerServerId(NetworkGetEntityOwner(id.entity)), input.amount)
        else
            QBCore.Functions.Notify("Please enter valid value.", "error")
        end
    end
end)

RegisterNetEvent('raidBanking:Notify')
AddEventHandler('raidBanking:Notify', function(notify)
    SendNUIMessage({
        action = "notify",
        message = notify,
        type = "success",
    })
end)
