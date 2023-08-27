QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
end)

--[[-----------------------------------
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Ac Loaf Scripts 2020 All Rights Reserved
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--]]-----------------------------------

--[[------------------------
!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SHARING THIS FILE IS ILLEGAL
!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--]]------------------------

local data = {}

GenerateId = function(length, usecapital, usenumbers)
    local result = ''

    for i = 1, length do
        local randomised = string.char(math.random(97, 122))
        if usecapital then
            if math.random(1, 2) == 1 then
                randomised = randomised:upper()
            end
        end
        if usenumbers then
            if math.random(1, 2) == 1 then
                randomised = tostring(math.random(0, 9))
            end
        end
        result = result .. randomised
    end

    return result
end

VolumeCheck = function(id)
    if data[id]['DUI'] then
        if data[id]['ActualVolume'] ~= data[id]['Volume'] then
            local duiLong = data[id]['DUI']['Long']

            SendDuiMouseMove(duiLong, 75, 700)
            Wait(250)
            SendDuiMouseMove(duiLong, 95 + math.ceil(data[id]['Volume'] * 5), 702)
            Wait(5)
            SendDuiMouseDown(duiLong, 'left')
            Wait(7)
            SendDuiMouseUp(duiLong, 'left')

            SendDuiMouseMove(duiLong, 75, 500)

            data[id]['ActualVolume'] = data[id]['Volume']
        end
    end
end

CreateVideo = function(id, url, object, coords, scale, offset, time, volume)
    if data[id] then
        if data[id]['DUI'] then
            DestroyDui(data[id]['DUI']['Long'])
        end
        data[id] = nil
        Wait(500)
    end

    local distance = 10.0

    for k, v in pairs(Config['Objects']) do
        if v['Object'] == object then
            Distance = v['Distance']
            break
        end
    end

    data[id] = {
        ['URL'] = url,
        ['Time'] = time,
        ['Started'] = math.ceil(GetGameTimer() / 1000) + 1,
        ['Object'] = object,
        ['Coords'] = coords,
        ['Offset'] = offset,
        ['Scale'] = scale,
        ['Volume'] = volume,
        ['ActualVolume'] = 0,
        ['Distance'] = Distance
    }
end

RegisterNetEvent('loaf_tv:update')
AddEventHandler('loaf_tv:update', function(players)
    for k, v in pairs(players) do
        if v ~= nil then
            CreateVideo(k, v['URL'], v['Object'], v['Coords'], v['Scale'], v['Offset'], v['Time'], v['Volume'])

            if v['Duration'] then
                data[k]['Duration'] = v['Duration']
            end
        end
    end
end)

CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(50) end

    local SFHandle = RequestScaleformMovie('generic_texture_renderer')
    while not HasScaleformMovieLoaded(SFHandle) do Wait(1000) end

    TriggerServerEvent('loaf_tv:fetch')

    CreateThread(function()
        while true do
            Wait(500)

            for k, v in pairs(data) do
                Wait(100)
                local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), v['Distance'], GetHashKey(v['Object']))

                if v ~= nil then
                    local obj = GetClosestObjectOfType(v['Coords'], v['Distance'], GetHashKey(v['Object']))
                    if DoesEntityExist(obj) then
                        Wait(2500)
                        while #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] and data[k] ~= nil and DoesEntityExist(obj) do
                            VolumeCheck(k)
                            Wait(500)
                        end
                    end
                end
            end
        end
    end)

    CreateThread(function()
        while true do
            Wait(500)

            for k, v in pairs(Config['Objects']) do
                Wait(100)
                local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(v['Object']))
                if DoesEntityExist(obj) then
                    local playing = false
                    local CheckPlaying = GetGameTimer()
                    while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(obj)) <= 2.0 do
                        if CheckPlaying <= GetGameTimer() then
                            CheckPlaying = GetGameTimer() + 750
                            playing = false
                            for k, v in pairs(data) do
                                if v['Coords'] == GetEntityCoords(obj) then
                                    playing = true
                                end
                            end
                        end

                        if playing then
                            -- AddTextEntry(GetCurrentResourceName(), Strings['VolumeHelp'])

                            if IsControlJustReleased(0, 51) then
                                for k, v in pairs(data) do
                                    if v['Coords'] == GetEntityCoords(obj) then
                                        CreateThread(function()
                                            if v['DUI'] then
                                                SetDuiUrl(v['DUI']['Long'], Config['URL']:format(v['URL'], (math.floor(GetGameTimer() / 1000) + v['Time']) - v['Started']))
                                            end
                                        end)
                                    end
                                end
                            end
                        else
                            AddTextEntry(GetCurrentResourceName(), Strings['VideoHelp'])
                        end

                        DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
                        Wait(0)
                    end
                end
            end
        end
    end)

    while true do
        Wait(500)

        for k, v in pairs(data) do
            Wait(0)
            if v ~= nil then
                local obj = GetClosestObjectOfType(v['Coords'], v['Distance'], GetHashKey(v['Object']))
                if DoesEntityExist(obj) then
                    if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] then
                        if SFHandle ~= nil then
                            local duiLong = CreateDui(Config['URL']:format(v['URL'], (math.floor(GetGameTimer() / 1000) + v['Time']) - v['Started']), 1280, 720)
                            local dui = GetDuiHandle(duiLong)

                            local txd, txn = GenerateId(25, true, false), GenerateId(25, true, false)
                            CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd(txd), txn, dui)

                            v['DUI'] = {
                                ['Long'] = duiLong,
                                ['Obj'] = dui,
                            }

                            v['Texture'] = {
                                ['txd'] = txd,
                                ['txn'] = txn,
                            }

                            PushScaleformMovieFunction(SFHandle, 'SET_TEXTURE')
                            PushScaleformMovieMethodParameterString(v['Texture']['txd'])
                            PushScaleformMovieMethodParameterString(v['Texture']['txn'])

                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(1920)
                            PushScaleformMovieFunctionParameterInt(1080)

                            PopScaleformMovieFunctionVoid()

                            while #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] and DoesEntityExist(obj) and data[k] ~= nil do
                                Wait(0)

                                if v['Duration'] then
                                    if (math.ceil(GetGameTimer() / 1000) - v['Started']) > v['Duration'] then
                                        DestroyDui(v['DUI']['Long'])
                                        data[k] = nil
                                        break
                                    end
                                end
                                DrawScaleformMovie_3dNonAdditive(SFHandle, GetOffsetFromEntityInWorldCoords(obj, v['Offset']), 0.0, GetEntityHeading(obj) * -1, 0.0, 2, 2, 2, v['Scale'] * 1, v['Scale'] * (9 / 16), 1, 2)
                            end

                            if data[k] then
                                -- destroy browser (we are no longer close to the tv)
                                DestroyDui(v['DUI']['Long'])

                                v['DUI'] = {}
                                v['Texture'] = {}
                            end
                        end
                    end
                end
            end
        end

    end
end)

-- RegisterCommand('tv', function(source, args)
--     if args[1] then
--         for k, v in pairs(Config['Objects']) do
--             local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v['Object']))
--             if DoesEntityExist(obj) then
--                 TriggerServerEvent('loaf_tv:add', args[1], v['Object'], GetEntityCoords(obj), v['Scale'], v['Offset'])
--                 break
--             end
--         end
--     end
-- end)

RegisterNetEvent("tv", function()
    local keyboard = exports['qb-input']:ShowInput({
        header = "Open Song with Youtube URL",
        inputs = {
			{
                type = 'text',
				isRequired = true,
				text = "Enter Video ID.",
				name = 'input',
			}
		}
	})
    local link = keyboard.input
    if link ~= nil or link == false or link <= 0  then
        if link then
            for k, v in pairs(Config['Objects']) do
                local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v['Object']))
                if DoesEntityExist(obj) then
                    TriggerServerEvent('loaf_tv:add', link, v['Object'], GetEntityCoords(obj), v['Scale'], v['Offset'])
                    break
                end
            end
        end
    else
        QBCore.Functions.Notify('Invalid Value', 'error', 7500)
    end
end)

local tv = {
    `prop_tv_flat_01`,
    `prop_tv_flat_michael`,
    `prop_trev_tv_01`,
    `prop_tv_flat_03b`
    -- -196922616
}

exports['qb-target']:AddTargetModel(tv, {
    options = {
        {
            type = "client",
            event = "tv",
            icon = "fas fa-tv",
            label = "TV",
        },
        {
            type = "client",
            event = "volume",
            icon = "fas fa-volume-up",
            label = "Change Volume",
        },
        {
            type = "client",
            event = "destroy",
            icon = "fas fa-times",
            label = "Close Video",
        },
    },
    distance = 2.5
})

RegisterNetEvent("volume", function()
    -- if args[1] then
        -- local volume = tonumber(args[1])
        -- if volume then
            -- if volume >= 0 then
            local keyboard = exports['qb-input']:ShowInput({
                                header = "Adjust Volume",
                                inputs = {
                                    {
                                        type = 'text',
                                        isRequired = true,
                                        text = "Enter Values ​​1-10.",
                                        name = 'input',
                                    }
                                }
                            })
                if keyboard and keyboard.input then
                    local volume = tonumber(keyboard.input)
                    if volume <= 0 or volume > 10 then
                        QBCore.Functions.Notify("Incorrect value.", "error")
                    else
                        for k, v in pairs(data) do
                            if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= 5.0 then
                                -- if volume == 1 then volume = 1.5 end
                                -- if volume > 10 then volume = 10 end
                                TriggerServerEvent('loaf_tv:setvolume', k, volume)
                                break
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify('You Didnt Enter a Value.', 'error', 7500)
                end
                -- else
                --     QBCore.Functions.Notify('1 ile 10 arasında bir değer girmelisin', 'error', 7500)
                -- end
            -- end

            -- end
        -- end
    -- end
end)

-- RegisterCommand('volume', function()
--     local keyboard = exports['qb-input']:ShowInput({
--                 header = "Ses Seviyesini Ayarla",
--                 inputs = {
--                     {
--                         type = 'text',
--                         isRequired = true,
--                         text = "1-10 Arasında Değer Gir.",
--                         name = 'input',
--                     }
--                 }
--             })
--     local volume = keyboard.input
--     -- if volume ~= nil or link == false or link <= 0  then
--     if volume then
--         for k, v in pairs(data) do
--             if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= 5.0 then
--                 if volume == 1 then volume = 1.5 end
--                 if volume > 10 then volume = 10 end
--                 TriggerServerEvent('loaf_tv:setvolume', k, volume)
--                 break
--             end
--         end
--     else
--     --     QBCore.Functions.Notify('Geçersiz Değer', 'error', 7500)
--     end
-- end)

RegisterNetEvent("destroy", function()
    for k, v in pairs(data) do
        if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= 5.0 then
            TriggerServerEvent('loaf_tv:destroy', k)
            break
        end
    end
end)

RegisterNetEvent('loaf_tv:delete')
AddEventHandler('loaf_tv:delete', function(id)
    if data[id] then
        if data[id]['DUI'] then
            DestroyDui(data[id]['DUI']['Long'])
        end
        data[id] = nil
    end
end)

RegisterNetEvent('loaf_tv:updatevolume')
AddEventHandler('loaf_tv:updatevolume', function(id, volume)
    if data[id] then
        data[id]['Volume'] = volume
    end
end)
         