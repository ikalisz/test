QBCore = nil 
isLoggedIn = false
Citizen.CreateThread(function()
   while QBCore == nil do
   	TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
   	Citizen.Wait(30) -- Saniye Bekletme
   end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnJobUptade')
AddEventHandler('QBCore:Client:OnJobUptade',  function(Amount)
    CurrentCops = Amount
end)

RegisterNetEvent('start-robbing')
AddEventHandler("start-robbing", function()
    AtmStartRob()
end)

function AtmStartRob()
	local pos = GetEntityCoords(PlayerPedId())
	-- if LocalPlayer.state.isLoggedIn then -- eğer ki new qbcore kullanıyorsanız bu satırı ve 55-56-57. satırları aktif edin.
		QBCore.Functions.TriggerCallback("ra1derAtmRobbery:Cooldown", function(cooldown)
			if not cooldown then
                QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
                    if AktifPolis > 1 then
                    QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
                        if qtty > 0 then
							local minigame = exports['hackingminigame']:Open()   
                            if(minigame == true) then -- success
                                ClearPedTasksImmediately(PlayerPedId())
                                HackSuccess() 
							else
								Citizen.Wait(1000)
							    ClearPedTasksImmediately(PlayerPedId())
								HackFailed()
							end
						else
							QBCore.Functions.Notify("You don't have what it takes to rob this ATM!", "error")
						end
					end, "trojan_usb")
                else
                    QBCore.Functions.Notify("Not Enough Police!", "error")
                end
            end)
			else
				QBCore.Functions.Notify("You just robbed an ATM, wait a bit, my dear")
			end
		end)
	-- else
	-- 	Citizen.Wait(3000)
	-- end
end


function RobMoney()
    Anim = true
    PoliceCall()
    QBCore.Functions.Progressbar("power_hack", "Collecting Coins", (50000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@ornate_bank@grab_cash_heels",
        anim = "grab",
        flags = 16,
    }, {
        model = "prop_cs_heist_bag_02",
        bone = 57005,
       coords = { x = -0.005, y = 0.00, z = -0.16 },
       rotation = { x = 250.0, y = -30.0, z = 0.0 },


    }, {}, function() -- Done
        Anim = false
        StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
		SetPedComponentVariation((PlayerPedId()), 5, 47, 0, 0)
        TriggerServerEvent("ra1derAtmRobbery:success")	
    end, function() -- Cancel
        Anim = false
        StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
		
    end)
    
    Citizen.CreateThread(function()
        while Anim do
            TriggerServerEvent('qb-hud:Server:gain:stress', math.random(2, 3))
            Citizen.Wait(12000)
        end
    end)
end

function HackFailed()
    QBCore.Functions.Notify("You Failed to Hack", "error")
    PoliceCall2()
end

function HackSuccess()
	QBCore.Functions.Notify("You Managed To Open The ATM Safe!")
    ClearPedTasksImmediately(PlayerPedId())
	RobMoney()
    TriggerServerEvent('ra1derAtmRobbery:Server:BeginCooldown')
end

function PoliceCall()
    local chance = 75
    if GetClockHours() >= 0 and GetClockHours() <= 6 then
        chance = 50
    end
    if math.random(1, 100) <= chance then
        -- Dispatch kullanıcıya göre değişiklik gösterebilir;
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        local id = math.random(1, 9999)
        
        data = {
            id = id,
            code = 10-31,
            description = "Possible ATM Robbery",
            location = GetTheStreet(),
            coords = playerPos,
            sprite = 439
        }   
        TriggerServerEvent("jtDispatch:add-notification", data, "police")
    end
end



      
function GetTheStreet()
	local ZoneNames = exports["jtDispatch"]:bolgeler()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    playerStreetsLocation = ZoneNames[tostring(zone)]

    if not zone then
        zone = "UNKNOWN"
        ZoneNames['UNKNOWN'] = zone
    elseif not ZoneNames[tostring(zone)] then
        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
        ZoneNames[tostring(zone)] = "Unknown Region"
    end

    if (intersectStreetName ~= nil and intersectStreetName ~= "") or (currentStreetName ~= nil and currentStreetName ~= "") then
        playerStreetsLocation = currentStreetName
    else
        playerStreetsLocation = ZoneNames[tostring(zone)]
    end

	return playerStreetsLocation
end

function GetStreetAndZone()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end

    function PoliceCall()  
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        local id = math.random(25, 99)
        
        data = {
            id = id,
            code = 10-40,
            description = "ATM Robbery",
            location = GetTheStreet(),
            coords = playerPos,
            sprite = 433
        }   
        TriggerServerEvent("jtDispatch:add-notification", data, "police")
    end


    function PoliceCall2()  
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        local id = math.random(25, 99)
        
        data = {
            id = id,
            code = 10-40,
            description = "Failed ATM Robbery",
            location = GetTheStreet(),
            coords = playerPos,
            sprite = 433
        }   
        TriggerServerEvent("jtDispatch:add-notification", data, "police")
    end

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
                    event = "start-robbing",
                    icon = "fas fa-dollar-sign",
                    label = "Rob ATM",
              },
          },
              distance = 1.5    
      })

