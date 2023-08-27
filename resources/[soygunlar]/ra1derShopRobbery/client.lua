local kasa, kasaNo = nil, nil
local drill, temp, aktif = nil, false, true

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local marketler = {
    [1] = {
        ["basic_kasa"] = vector3(373.7188, 328.4870, 103.41),
        ["hard_kasa"] = vector3(378.2786, 333.7485, 104.17),
        ["son_advanced_time"] = 60000 * 3,
    },
    [2] = {
        ["basic_kasa"] = vector3(2555.645, 381.2675, 108.62),
        ["hard_kasa"] = vector3(2549.379, 387.8523, 109.62),
        ["son_advanced_time"] = 60000 * 3.5,
	},
    [3] = {
        ["basic_kasa"] = vector3(-3040.63, 584.3598, 7.9088),
        ["hard_kasa"] = vector3(-3048.58, 588.5079, 8.9088),
        ["son_advanced_time"] = 60000 * 3.5,
    },
    [4] = {
        ["basic_kasa"] = vector3(-1486.45, -378.24, 40.16),
        ["hard_kasa"] = vector3(-1478.71, -375.61, 39.16),
        ["son_advanced_time"] = 60000 * 3,
    },
    [5] = {
        ["basic_kasa"] = vector3(1393.07, 3606.22, 34.99),
        ["hard_kasa"] = vector3(1394.87, 3614.31, 34.99),
        ["son_advanced_time"] = 60000 * 2,
    },
    [6] = {
        ["basic_kasa"] = vector3(-2966.63, 390.88, 14.93),
        ["hard_kasa"] = vector3(-2959.63, 386.69, 14.04),
        ["son_advanced_time"] = 60000 * 3.5,
    },
    [7] = {
        ["basic_kasa"] = vector3(2676.874, 3280.519, 55.241),
        ["hard_kasa"] = vector3(2674.169, 3289.266, 56.241),
        ["son_advanced_time"] = 60000 * 4,
    },
    [8] = {
        ["basic_kasa"] = vector3(-46.8336, -1758.04, 29.420),
        ["hard_kasa"] = vector3(-43.75, -1748.16, 29.42),
        ["son_advanced_time"] = 60000 * 3,
    },
    [9] = {
        ["basic_kasa"] = vector3(1164.709, -322.792, 69.205),
        ["hard_kasa"] = vector3(1159.02, -314.07, 69.48),
        ["son_advanced_time"] = 60000 * 3,
    },
    [10] = {
        ["basic_kasa"] = vector3(-706.47, -913.51, 19.58),
        ["hard_kasa"] = vector3(-710.25, -904.18, 19.22),
        ["son_advanced_time"] = 60000 * 3,
    },
    [11] = {
        ["basic_kasa"] = vector3(-1820.68, 793.97, 138.09),
        ["hard_kasa"] = vector3(-1829.43, 798.53, 138.09),
        ["son_advanced_time"] = 60000 * 3,
    },
    [12] = {
        ["basic_kasa"] = vector3(1698.15, 4923.11, 42.07),
        ["hard_kasa"] = vector3(1708.14, 4920.73, 42.07),
        ["son_advanced_time"] = 60000 * 4.5,
    },
	[13] = {
        ["basic_kasa"] = vector3(1959.681, 3741.578, 32.343),
        ["hard_kasa"] = vector3(1961.783, 3750.232, 33.343),
        ["son_advanced_time"] = 60000 * 4,
    },
	[14] = {
        ["basic_kasa"] = vector3(1134.26, -982.52, 46.42),
        ["hard_kasa"] = vector3(1126.8, -979.78, 45.42),
        ["son_advanced_time"] = 60000 * 3,
    },
    [15] = {
        ["basic_kasa"] = vector3(24.85736, -1345.71, 29.496),
        ["hard_kasa"] = vector3(31.18802, -1339.32, 30.496),
        ["son_advanced_time"] = 60000 * 3,
    },
	[16] = {
        ["basic_kasa"] = vector3(548.8872, 2669.652, 42.156),
        ["hard_kasa"] = vector3(543.8023, 2662.390, 43.156),
        ["son_advanced_time"] = 60000 * 4,
    },
    [17] = {
        ["basic_kasa"] = vector3(-3243.79, 1000.527, 12.830),
        ["hard_kasa"] = vector3(-3249.66, 1007.362, 13.830),
        ["son_advanced_time"] = 60000 * 4,
    },
	[18] = {
        ["basic_kasa"] = vector3(1166.09, 2710.28, 38.02),
        ["hard_kasa"] = vector3(1169.69, 2717.8, 37.16),
        ["son_advanced_time"] = 60000 * 4,
    },
	[19] = {
        ["basic_kasa"] = vector3(1728.925, 6416.609, 35.037),
        ["hard_kasa"] = vector3(1737.455, 6419.463, 36.037),
        ["son_advanced_time"] = 60000 * 5,
	},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local playerPed = PlayerPedId()
		local PlayerCoords = GetEntityCoords(playerPed)
		kasa = nil
		kasaNo = nil
		for i=1, #marketler do
            local basitKasaMesafe = #(PlayerCoords - marketler[i]["basic_kasa"])
			local hardKasaMesafe = #(PlayerCoords - marketler[i]["hard_kasa"])
			if basitKasaMesafe < 1.5 then
				kasa = "basic"
				kasaNo = i
			elseif hardKasaMesafe < 1.5 then
				kasa = "hard"
				kasaNo = i
			end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if kasa and kasaNo and aktif then
			time = 1
			if kasa == "basic" then 
				QBCore.Functions.DrawText3D(marketler[kasaNo]["basic_kasa"]["x"], marketler[kasaNo]["basic_kasa"]["y"], marketler[kasaNo]["basic_kasa"]["z"]+ 0.1, "[H] Pick the Crate", 200)
				if IsControlJustPressed(0, 74) then
					-- if not exports['elixir-base']:GetSecureStatus() then
					QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
						if AktifPolis >= 3 then
							basicMarketSoy()
						else
							QBCore.Functions.Notify('Not Enough Police.', 'error')
						end
					end)
				-- end
				end
			else
				QBCore.Functions.DrawText3D(marketler[kasaNo]["hard_kasa"]["x"], marketler[kasaNo]["hard_kasa"]["y"], marketler[kasaNo]["hard_kasa"]["z"]-0.5, "[E] Pierce the Case", 250)
				if IsControlJustPressed(0, 38) then
					QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
						if AktifPolis >= 5 then
							hardMarketSoy()
						else
							QBCore.Functions.Notify('Not Enough Police', 'error')
						end
					end)
				end
			end
		end

		if drill then 
			time = 1
			local instructions = CreateInstuctionScaleform("instructional_buttons")
			DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)			
		end
		Citizen.Wait(time)
	end
end)
RegisterNetEvent('kilitacaq')
AddEventHandler('kilitacaq', function()
	local Ped = PlayerPedId()
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while isLockpicking do
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1250)
	end
	ClearPedTasks(Ped)
end)

RegisterNetEvent('x-hotwire:duzKontakSes')
AddEventHandler('x-hotwire:duzKontakSes', function()
    while duzKontakSes do
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'duzkontak', 0.4)
      Citizen.Wait(3000)
    end
end)


RegisterNetEvent('kilitacaq')
AddEventHandler('kilitacaq', function()
	local Ped = PlayerPedId()
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while isLockpicking do
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1250)
	end
	ClearPedTasks(Ped)
end)

RegisterNetEvent('x-hotwire:duzKontakSes')
AddEventHandler('x-hotwire:duzKontakSes', function()
    while duzKontakSes do
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'duzkontak', 0.4)
      Citizen.Wait(3000)
    end
end)



function basicMarketSoy()
	aktif = false

	QBCore.Functions.Progressbar("maymuncuk_kasa_kontrol", "Checking the Safe", math.random(2000,8000), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
	disableMovement = true,
	disableCarMovement = true,
	disableMouse = false,
	disableCombat = true,
}, {
	animDict = "mini@repair",
	anim = "fixing_a_player",
	flags = 49,
}, {}, {}, function() -- Done
	QBCore.Functions.TriggerCallback('edrp-marketsoygunu:item-ve-sure-kontrol', function(durum)
		if durum then
			duzKontakSes = true
			isLockpicking = true
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerEvent("kilitacaq")
			TriggerEvent("x-hotwire:duzKontakSes")
			TriggerEvent('lsrp-lockpick:StartLockpickfo', function(result)
				if result then
					duzKontakSes = false
					isLockpicking = false
					FreezeEntityPosition(PlayerPedId(), false)
						kasiyerNotify()
						QBCore.Functions.Notify('Transaction Successful', 'success', 7500)
						QBCore.Functions.Progressbar("kasa_maymuncukla", "You Collect the Money", math.random(55000, 65000), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, {
								animDict = "mini@repair",
								anim = "fixing_a_player",
								flags = 49,
							}, {}, {}, function() -- Done
							QBCore.Functions.Notify('Picking Successful')
							duzKontakSes = false
							isLockpicking = false
							FreezeEntityPosition(PlayerPedId(), false)
							TriggerServerEvent("edrp-marketsoygun:item-sil", QBCore.Key, "basic")
							aktif = true
						end, function() -- Cancel
							TriggerServerEvent("elixir-base:event:removeItem", "lockpick2", 1)
							TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick2"], "remove")
							QBCore.Functions.Notify('Transaction Canceled', 'error', 7500)
							aktif = true
						end)
					else
						QBCore.Functions.Notify('you failed', 'error', 7500)
						duzKontakSes = false
						isLockpicking = false
						FreezeEntityPosition(PlayerPedId(), false)
						TriggerServerEvent("elixir-base:event:removeItem", "lockpick2", 1)
						TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick2"], "remove")
						aktif = true
					end
				end)
			else
				aktif = true
			end
		end, kasaNo, "basic", "lockpick2")
    end, function() -- Cancel
        aktif = true
		duzKontakSes = false
		isLockpicking = false
		FreezeEntityPosition(PlayerPedId(), false)
    end)
end




function hardMarketSoy()
	aktif = false
	QBCore.Functions.Progressbar("del_kasa_kontrol", "Checking the Safe", math.random(2000,8000), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 49,
    }, {}, {}, function() -- Done
        QBCore.Functions.TriggerCallback('edrp-marketsoygunu:item-ve-sure-kontrol', function(durum)
			if durum then
				kasaNotif()
				TriggerEvent("memory")
			else
				aktif = true
			end
		end, kasaNo, "hard", "guvenlik_karti_a", "matkap")
    end, function() -- Cancel
		aktif = true
    end)

end

-- local minigame = exports['hackingminigame']:Open()   
-- if(minigame == true) then -- success
-- else
-- aktif = true
-- QBCore.Functions.Notify('Başaramadın', 'error', 7500)

RegisterNetEvent("memory", function()
    exports["hacking"]:hacking(
	function()
        QBCore.Functions.Progressbar("kasa_del", "You prepare the materials", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "mini@repair",
			anim = "fixing_a_player",
			flags = 49,
		}, {}, {}, function() -- Done
			exports["hacking"]:hacking(
	        function()
			startAnim()
			TriggerEvent("Drilling:Start",function(success)
				if success then
					aktif = true
					stopAnim()
					QBCore.Functions.Notify('Drilling Successful')
					Wait(1000)
					TriggerEvent("paratopla")
					-- exports['jtLevelSystem']:updateXP(3)
				else
					aktif = true
					stopAnim()
					QBCore.Functions.Notify("Robbery Failed!", "error")
					TriggerServerEvent("edrp-marketsoygun:item-sil", QBCore.Key, "matkap", kasaNo)
				end
			end)
		end, function() -- Cancel
			aktif = true
			TriggerServerEvent("edrp-marketsoygun:soygun-yapildi", kasaNo, false, "son_advanced_cd")
			-- exports['jtLevelSystem']:updateXP(3)
		end)

	end,
	function()
    	QBCore.Functions.Notify("Hack Failed!", "error")
	 end)
	end,
	function()
    	QBCore.Functions.Notify("Hack Failed!", "error")
	 end)
end)


	

function attachObject()
	drill = CreateObject(`hei_prop_heist_drill`, 0, 0, 0, true, true, true)
	AttachEntityToEntity(drill, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 64017), 0.100, 0.0250, 0.018, 0.024, 35.0, 73.0, true, true, false, true, 1, true)
end

function stopAnim()
	StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteObject(drill)
	ClearPedTasks(PlayerPedId())
	temp = false
	drill = nil
end

function startAnim()
	if not temp then
		RequestAnimDict("anim@heists@fleeca_bank@drilling")
		while not HasAnimDictLoaded("anim@heists@fleeca_bank@drilling") do
			Citizen.Wait(0)
		end
		attachObject()
		TaskPlayAnim(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 8.0, 8.0, -1, 1, 0, false, false, false)
		temp = true
	end
end

RegisterNetEvent("paratopla", function()
	QBCore.Functions.Progressbar('name_here', 'Looting', math.random(45000, 65000), false, true, { -- Name | Label | Time | useWhileDead | canCancel
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 49,
	}, {}, {}, function() -- Play When Done
		ClearPedTasksImmediately(PlayerPedId())
		TriggerServerEvent("edrp-marketsoygun:item-sil", QBCore.Key, "hard")
	end, function() -- Play When Cancel
		--Stuff goes here
	end)
end)

function CreateInstuctionScaleform(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(10)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(5)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, 172, true))
	InstructionButtonMessage("Matkabı İttir")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(4)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, 173, true))
	InstructionButtonMessage("Matkabı Çek")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(3)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, 175, true))
	InstructionButtonMessage("Matkabı Hızlandır")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, 174, true))
	InstructionButtonMessage("Matkabı Yavaşlat")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, 177, true))
	InstructionButtonMessage("İptal")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

function InstructionButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end





function kasiyerNotify()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = kasaNo.. "No. Market is Robbed",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 433
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end


function kasaNotif()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = "Market Box Being Robbed",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 277
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
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

local Market = {
	{name="24/7 Super Market", id=52,  x = 373.3491, y = 327.7801, z = 103.56}, --1
	{name="24/7 Super Market", id=52,  x = 2555.666, y = 381.1979, z = 108.62}, --2
	{name="24/7 Super Market", id=52,  x = -3040.62, y = 584.3700, z = 7.9031}, --3
	{name="24/7 Super Market", id=52,  x = -1486.20, y = -377.983, z = 40.163}, --4
	{name="24/7 Super Market", id=52,  x = 1391.751, y = 3606.147, z = 34.980},--5
	{name="24/7 Super Market", id=52,  x = -2966.36, y = 390.8671, z = 15.043},--6
	{name="24/7 Super Market", id=52,  x = 2676.792, y = 3280.491, z = 55.241},--7
	{name="24/7 Super Market", id=52,  x = -46.8319, y = -1758.02, z = 29.415},--8
	{name="24/7 Super Market", id=52,  x = 1164.813, y = -322.710, z = 69.205},--9
	{name="24/7 Super Market", id=52,  x = -706.052, y = -913.618, z = 19.215},--10
	{name="24/7 Super Market", id=52,  x = -1820.12, y = 794.4564, z = 138.08},--11
	{name="24/7 Super Market", id=52,  x = 1698.150, y = 4923.109, z = 43.063},--12
	{name="24/7 Super Market", id=52,  x = 1959.681, y = 3741.575, z = 32.338},--13
	{name="24/7 Super Market", id=52,  x = 1134.226, y = -982.534, z = 46.409},--14
	{name="24/7 Super Market", id=52,  x = 24.85870, y = -1345.72, z = 29.491},--15
	{name="24/7 Super Market", id=52,  x = 548.8872, y = 2669.651, z = 42.150},--16
	{name="24/7 Super Market", id=52,  x = -3243.79, y = 1000.517, z = 12.824},--17
	{name="24/7 Super Market", id=52,  x = 1166.090, y = 2710.308, z = 39.325},--18
	{name="24/7 Super Market", id=52,  x = 373.3491, y = 327.7801, z = 103.56},--19
	{name="24/7 Super Market", id=52, x = 1728.685, y = 6416.122, z = 35.037},

}

local blip = false
local aktifblipler = {}
RegisterNetEvent("market:blipAcKapa")
AddEventHandler("market:blipAcKapa", function()
	if blip then
		pasifblip()
		blip = false
		exports["elix1rBase"]:SendAlert('Market Blips Closed', 'error', 2500)
	else
		aktifblip()
		blip = true
		exports["elix1rBase"]:SendAlert('Market Blips Opened', 'success', 2500)
	end
end)

function aktifblip()
	for k,v in ipairs(Market)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("24/7 Super Market")
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


