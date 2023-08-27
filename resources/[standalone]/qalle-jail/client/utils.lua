local inscene = false
local signmodel = GetHashKey("prop_police_id_board")
local textmodel = GetHashKey("prop_police_id_text")

local jail = {
	vector3(1773.4829101563, 2482.5556640625, 50.422821044922),	
	vector3(1770.2899169922, 2481.2468261719, 50.421974182129),
	vector3(1767.5102539063, 2479.2653808594, 50.420909881592), 
	vector3(1764.1162109375, 2477.7282714844, 50.419971466064),
	vector3(1754.9764404297, 2494.1193847656, 50.424587249756),
	vector3(1757.8392333984, 2495.7785644531, 50.425521850586),
	vector3(1761.1318359375, 2497.9313964844, 50.426692962646),
}

RegisterCommand("jailmenu", function(source, args)
	if PlayerData.job and PlayerData.job.name == "police" then
		OpenJailMenu()
	else
		QBCore.Functions.Notify("you are not police!")
	end
end)


CreateThread(function()
    scaleform = LoadScaleform("mugshot_board_01")
    text = CreateNamedRenderTargetForModel("ID_TEXT", textmodel)
  
    while text do
        Wait(1)
        SetTextRenderId(text) -- set render target
        Set_2dLayer(4)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
        DrawScaleformMovie(scaleform, 0.40, 0.35, 0.80, 0.75, 255, 255, 255, 255, 0)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Wait(1)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(1)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function Cutscene()
	DoScreenFadeOut(100)

	Wait(250)

	ClearPedProp(playerPed, 0)

	LoadModel(-1320879687)

	-- local PolicePosition = Config.Cutscene["PolicePosition"]
	-- local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPed, PlayerPosition["h"])
	FreezeEntityPosition(PlayerPed, true)


    SignProp1 = CreateObject(signmodel, 1, 1, 1, false, true, false)
    SignProp2 = CreateObject(textmodel, 1, 1, 1, false, true, false)

	LoadAnim("mp_character_creation@customise@male_a")
	TaskPlayAnim(PlayerPed, "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)
    AttachEntityToEntity(SignProp1, PlayerPed, GetPedBoneIndex(PlayerPed, 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);
    AttachEntityToEntity(SignProp2, PlayerPed, GetPedBoneIndex(PlayerPed, 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);

    local ScaleformMovie = RequestScaleformMovie("MUGSHOT_BOARD_01")

    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end

	inscene = true

	Cam()

	Wait(1000)

	DoScreenFadeIn(100)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "deklansor", 0.3)

	Wait(2500)

	DoScreenFadeOut(250)

	Wait(1000)
	SetEntityHeading(PlayerPed, PlayerPosition["h"] + 90)

	DoScreenFadeIn(100)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "deklansor", 0.3)

	Wait(2500)

	DoScreenFadeOut(250)

	Wait(1000)
	SetEntityHeading(PlayerPed, PlayerPosition["h"] - 90)

	DoScreenFadeIn(100)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "deklansor", 0.3)

	Wait(2500)

	DoScreenFadeOut(250)




	-- son bölüm
	-- local JailPosition = Config.JailPositions["Cell"]

	random  = math.random(1, #jail)
	SetEntityCoords(PlayerPed, jail[random].x, jail[random].y, jail[random].z)
	-- DeleteEntity(Police)
	
	SetModelAsNoLongerNeeded(-1320879687)
	inscene = false


	Wait(1000)
	DeleteObject(SignProp1)
    DeleteObject(SignProp2)
	ClearPedTasks(PlayerPed)



	TriggerServerEvent("InteractSound_SV:PlayOnSource", "cell", 0.3)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPed, false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])

	Wait(2500)
	DoScreenFadeIn(100)

	InJail()
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])

	RenderScriptCams(true, false, 0, true, true)
	SetCamRot(CamOptions["cameraId"], 0, 0, -10)
	-- SetCamParams(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"], -7.50235, 0.059666, -111.7328, 0, 9100, 0, 0, 2);
end

function TeleportPlayer(pos)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport_jail',{
			title    = "Select position",
			align    = 'center',
			elements = elements
		},function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]

			if action == "Prison Entrance" or action == "Security Area" then
				if PlayerData.job.name ~= "police" then
					QBCore.Functions.Notify("You don't have the key to get in here!")
					return
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Wait(250)

			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]

		DoScreenFadeOut(100)

		Wait(250)

		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

		Wait(250)

		DoScreenFadeIn(100)
	end
end

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(1677.57, 2568.73, 45.59)

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.7)
    SetBlipColour (blip, 6)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Los Santos Jail')
    EndTextCommandSetBlipName(blip)
end)


function CreateNamedRenderTargetForModel(name, model)
    local text = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, 0)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        text = GetNamedRendertargetRenderId(name)
    end

    return text
end


function LoadScaleform (scaleform)
    local text = RequestScaleformMovie(scaleform)

    if text ~= 0 then
        while not HasScaleformMovieLoaded(text) do
            Wait(0)
        end
    end

    return text
end

Citizen.CreateThread(function() 
	
    while true do
		if inscene then
			sleep = 0
			PslayerData = QBCore.Functions.GetPlayerData()
			PushScaleformMovieFunction(RequestScaleformMovie("MUGSHOT_BOARD_01"), "SET_BOARD")
			PushScaleformMovieFunctionParameterString("Los Santos Police Department")
			PushScaleformMovieFunctionParameterString(PslayerData.charinfo.firstname .. " " .. PslayerData.charinfo.lastname)
			PushScaleformMovieFunctionParameterString(PslayerData.citizenid)
			PushScaleformMovieFunctionParameterString(PslayerData.charinfo.birthdate .. " - " .. PslayerData.charinfo.nationality)
			PushScaleformMovieFunctionParameterString(0)
			PushScaleformMovieFunctionParameterString(5)
			PushScaleformMovieFunctionParameterString(0)
			PushScaleformMovieFunctionParameterString(jailTime.. " minutes")

			PopScaleformMovieFunctionVoid()
		else
			sleep = 3500
		end
		Wait(sleep)
    end
end)