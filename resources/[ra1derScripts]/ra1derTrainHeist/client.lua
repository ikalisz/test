TrainHeist = {
    ['startPeds'] = {},
    ['guardPeds'] = {},
    ['containers'] = {},
    ['collisions'] = {},
    ['locks'] = {},
    ['desks'] = {},
    ['golds'] = {}
}

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(30) -- Saniye Bekletme
	end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config['TrainHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        TrainHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(TrainHeist['startPeds'][k], true)
        SetEntityInvincible(TrainHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(TrainHeist['startPeds'][k], true)
    end
end)

RegisterNetEvent("trainheist:start", function()
    local pedCo = GetEntityCoords(ped)
    local ped = PlayerPedId()
    StartTrainHeist()
end)
--         -- local sleep = 1000
--         -- if dist <= 2.0 then 
--             -- sleep = 1
--             -- ShowHelpNotification(Strings['start_heist'])
--             -- QBCore.Functions.DrawText3D(pedCo.x, pedCo.y, pedCo.z, "[E] - Tren Soygununu Başlat")
--             -- if IsControlJustPressed(0, 38) then
--             -- end
--         end
--         Citizen.Wait(sleep)
--     end
-- end)

exports["qb-target"]:AddTargetModel("s_m_m_highsec_01", {
    options = {
        {
            event = "trainheist:start",
            icon = "bi bi-currency-dollar",
            label = "Start Train Robbery",
        },
    },
    distance = 4.0
})

-- function StartTrainHeist()
--     QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(status)
--         QBCore.Functions.TriggerCallback('trainheist:server:hasItem', function(hasItem, itemLabel)
--         if status >= 5 then
--             if hasItem then
--                     QBCore.Functions.TriggerCallback('trainheist:server:checkTime', function(time)
--                         if time then
--                             QBCore.Functions.Notify("İşi Aldın, GPS üzerinde ki işaretlenen konuma git ve oradaki MerryWeather korumalarını öldürüp altınları çal", "primary", 20000)
--                             SetNewWaypoint(Config['TrainHeist']['setupTrain']['pos'])
--                             ambushBlip = addBlip(Config['TrainHeist']['setupTrain']['pos'], 274, 6, "Merry Weather Treni")
--                             repeat
--                                 local ped = PlayerPedId()
--                                 local pedCo = GetEntityCoords(ped)
--                                 local dist = #(pedCo - Config['TrainHeist']['setupTrain']['pos'])
--                                 Wait(1)
--                             until dist <= 100.0
--                             SpawnGuards()
--                             SetupTrain()
--                             TriggerServerEvent('trainheist:server:trainLoop')
--                         end
--                     end)
--                     else
--                         QBCore.Functions.Notify("Tren Soygunu İçin", "error")
--                     end
--                 else
--                     QBCore.Functions.Notify("Yeterli polis yok!", "error")
--                 end
--         end, Config['TrainHeist']['requiredItems'][1])
--     end)
-- end

function StartTrainHeist()
    QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(status)
        if status >= 5 then
            QBCore.Functions.TriggerCallback('trainheist:server:hasItem', function(hasItem, itemLabel)
                if hasItem then
                    QBCore.Functions.TriggerCallback('trainheist:server:hasItem', function(hasItem2, itemLabel)
                        if hasItem2 then
                            QBCore.Functions.TriggerCallback('trainheist:server:checkTime', function(time)
                                if time then
                                    QBCore.Functions.Notify("You got the job, go to the marked location on the GPS and kill the MerryWeather guards there and steal the gold", "primary", 20000)
                                    SetNewWaypoint(Config['TrainHeist']['setupTrain']['pos'])
                                    TriggerServerEvent("edrp_meatfarm:item-sil", "guvenlik_karti_e", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["guvenlik_karti_e"], 'remmove')
                                    ambushBlip = addBlip(Config['TrainHeist']['setupTrain']['pos'], 274, 6, "Merry Weather Train")
                                    repeat
                                        local ped = PlayerPedId()
                                        local pedCo = GetEntityCoords(ped)
                                        local dist = #(pedCo - Config['TrainHeist']['setupTrain']['pos'])
                                        Wait(1)
                                    until dist <= 100.0
                                    SpawnGuards()
                                    SetupTrain()
                                    TriggerServerEvent('trainheist:server:trainLoop')
                                else
                                    QBCore.Functions.Notify('The train is being robbed right now.', 'error', 7500)
                                end
                            end)
                        else

                        end
                    end, "guvenlik_karti_e")
                else
                    QBCore.Functions.Notify('You dont have the necessary items for this robbery!', 'error', 7500)
                end
            end, "delicialet")
        else
            QBCore.Functions.Notify('Not Enough Police', 'error', 7500)
        end
    end)
end

RegisterCommand("trains", function()
    StartTrainHeist()
end)

-- local openUi = false
RegisterNetEvent('trainheist:client:trainLoop')
AddEventHandler('trainheist:client:trainLoop', function()
    trainLoop = true
    while trainLoop do
        Wait(10)
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local openUi = false
        
        if robber then
            local trainDist = #(pedCo - Config['TrainHeist']['setupTrain']['pos'])
            if trainDist >= 50.0 then
                TriggerServerEvent('trainheist:server:resetHeist')
                FinishHeist()
                break
            end
        end

        if IsEntityDead(ped) then
            break
        end

        for k, v in pairs(Config['TrainHeist']['setupTrain']['containers']) do
            local dist = #(pedCo - v['lock']['pos'])
            if dist <= 1.5 and not v['lock']['taken'] then
                openUi = true
                 exports['qb-ui']:showInteraction("[E] Break the Lock")
                --exports["qb-core"]:keyPressed("[E] Kilidi Kır", "left")
                if IsControlJustPressed(0, 38) then
                    -- exports['qb-ui']:hideInteraction()
                    OpenContainer(k)
                end
            end
            for x, y in pairs(v['golds']) do
                local dist = #(pedCo - y['pos'])
                if dist <= 1.3 and not y['taken'] and not grabNow then
                    openUi = true
                    exports['qb-ui']:showInteraction("[E] Collect Ingots")
                    if IsControlJustPressed(0, 38) then
                        exports['qb-ui']:hideInteraction()
                        Grab(k, x)	
                    end
                end
            end
        end
        if not openUi then
            exports['qb-ui']:hideInteraction()
        end
    end
end)



function FinishHeist()
    QBCore.Functions.Notify("Deliver the Gold Bars to the Buyer. Has location on GPS.", 'success', 7500)
    Wait(10000)
    RemoveBlip(ambushBlip)
    DeleteVehicle(mainTrain)
    DeleteVehicle(trainPart)
    DeleteObject(TrainHeist['desks'][1])
    DeleteObject(TrainHeist['desks'][2])
    DeleteObject(TrainHeist['containers'][1])
    DeleteObject(TrainHeist['containers'][2])
    DeleteObject(TrainHeist['locks'][1])
    DeleteObject(TrainHeist['locks'][2])
    -- ShowNotification(Strings['deliver_to_buyer'])
    SetNewWaypoint(Config['TrainHeist']['finishHeist']['buyerPos'])
    loadModel('baller')
    buyerBlip = addBlip(Config['TrainHeist']['finishHeist']['buyerPos'], 500, 0, "Gold Bullion Buyer")
    buyerVehicle = CreateVehicle(GetHashKey('baller'), Config['TrainHeist']['finishHeist']['buyerPos'].xy + 3.0, Config['TrainHeist']['finishHeist']['buyerPos'].z, 269.4, 0, 0)
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['TrainHeist']['finishHeist']['buyerPos'])

        if dist <= 50.0 then
            PlayCutscene('hs3f_all_drp3', Config['TrainHeist']['finishHeist']['buyerPos'])
            DeleteVehicle(buyerVehicle)
            RemoveBlip(buyerBlip)
            TriggerServerEvent('trainheist:server:sellRewardItems')
            break
        end
        Wait(1)
    end
end

RegisterNetEvent('trainheist:client:resetHeist')
AddEventHandler('trainheist:client:resetHeist', function()
    DeleteObject(clientContainer)
    DeleteObject(clientLock)
    DeleteObject(clientContainer2)
    DeleteObject(clientLock2)
    clientContainer, clientContainer2, clientLock, clientLock2 = nil, nil, nil, nil
    ClearArea(2885.97, 4560.83, 48.0551, 50.0)
    trainLoop = false
    for k, v in pairs(Config['TrainHeist']['setupTrain']['containers']) do
        v['lock']['taken'] = false
        for x, y in pairs(v['golds']) do
            y['taken'] = false
        end
    end
end)

function SpawnGuards()

    local ped = PlayerPedId()



    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))

    AddRelationshipGroup('GuardPeds')



    for k, v in pairs(Config['TrainHeist']['guardPeds']) do

        loadModel(v['model'])

        TrainHeist['guardPeds'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)

        NetworkRegisterEntityAsNetworked(TrainHeist['guardPeds'][k])

        networkID = NetworkGetNetworkIdFromEntity(TrainHeist['guardPeds'][k])

        SetNetworkIdCanMigrate(networkID, true)

        SetNetworkIdExistsOnAllMachines(networkID, true)

        SetPedRandomComponentVariation(TrainHeist['guardPeds'][k], 0)

        SetPedRandomProps(TrainHeist['guardPeds'][k])

        SetEntityAsMissionEntity(TrainHeist['guardPeds'][k])

        SetEntityVisible(TrainHeist['guardPeds'][k], true)

        SetPedRelationshipGroupHash(TrainHeist['guardPeds'][k], GetHashKey("GuardPeds"))

        SetPedAccuracy(TrainHeist['guardPeds'][k], 35)

        SetPedArmour(TrainHeist['guardPeds'][k], 50)

        SetPedCanSwitchWeapon(TrainHeist['guardPeds'][k], true)

        SetPedDropsWeaponsWhenDead(TrainHeist['guardPeds'][k], false)

		SetPedFleeAttributes(TrainHeist['guardPeds'][k], 0, false)

        GiveWeaponToPed(TrainHeist['guardPeds'][k], GetHashKey('WEAPON_CARBINERIFLE'), 255, false, false)

        local random = math.random(1, 2)

        if random == 2 then

            TaskGuardCurrentPosition(TrainHeist['guardPeds'][k], 10.0, 10.0, 1)

        end

    end



    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))

	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))

	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))

end

function SetupTrain()
    loadModel('freight')
    loadModel('freightcar')
    -- loadModel('tr_prop_tr_container_01a')
    loadModel('prop_ld_container')
    -- loadModel('tr_prop_tr_lock_01a')
    loadModel('xm_prop_lab_desk_02')
    loadModel('h4_prop_h4_gold_stack_01a')
    mainTrain = CreateVehicle(GetHashKey('freight'), Config['TrainHeist']['setupTrain']['pos'], Config['TrainHeist']['setupTrain']['heading'], 1, 0)
    trainPart = CreateVehicle(GetHashKey('freightcar'), Config['TrainHeist']['setupTrain']['part'], Config['TrainHeist']['setupTrain']['heading'], 1, 0)
    FreezeEntityPosition(mainTrain, true)
    FreezeEntityPosition(trainPart, true)
    for k, v in pairs(Config['TrainHeist']['setupTrain']['containers']) do
        TrainHeist['containers'][k] = CreateObject(GetHashKey('tr_prop_tr_container_01a'), v['pos'], 1, 1, 0)
        SetEntityHeading(TrainHeist['containers'][k], v['heading'])
        FreezeEntityPosition(TrainHeist['containers'][k], true)
        Wait(math.random(100, 500))
        TrainHeist['collisions'][k] = CreateObject(GetHashKey('prop_ld_container'), v['pos'], 1, 1, 0)
        SetEntityHeading(TrainHeist['collisions'][k], v['heading'])
        SetEntityVisible(TrainHeist['collisions'][k], false)
        FreezeEntityPosition(TrainHeist['collisions'][k], true)
        Wait(math.random(100, 500))
        TrainHeist['locks'][k] = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), v['lock']['pos'], 1, 1, 0)
        SetEntityHeading(TrainHeist['locks'][k], v['heading'])
        TrainHeist['desks'][k] = CreateObject(GetHashKey('xm_prop_lab_desk_02'), v['table'], 1, 1, 0)
        SetEntityHeading(TrainHeist['desks'][k], v['heading'])
        Wait(math.random(100, 500))
        for x, y in pairs(v['golds']) do
            TrainHeist['golds'][k..x] = CreateObject(GetHashKey('h4_prop_h4_gold_stack_01a'), y['pos'], 1, 1, 0)
            SetEntityHeading(TrainHeist['golds'][k..x], v['heading'])
        end
        Wait(math.random(1000, 5000))
    end
end

function OpenContainer(index)
    -- QBCore.Functions.TriggerCallback('kuyumcu:item-kontrol', function(hasItem)
    --     if hasItem then
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local pedRotation = GetEntityRotation(ped)
            local animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'
            loadAnimDict(animDict)
            loadPtfxAsset('scr_tn_tr')
            TriggerServerEvent('trainheist:server:lockSync', index)
            
            for i = 1, #TrainAnimation['objects'] do
                loadModel(TrainAnimation['objects'][i])
                TrainAnimation['sceneObjects'][i] = CreateObject(GetHashKey(TrainAnimation['objects'][i]), pedCo, 1, 1, 0)
            end

            sceneObject = GetClosestObjectOfType(pedCo, 2.5, GetHashKey('tr_prop_tr_container_01a'), 0, 0, 0)
            lockObject = GetClosestObjectOfType(pedCo, 2.5, GetHashKey('tr_prop_tr_lock_01a'), 0, 0, 0)
            NetworkRegisterEntityAsNetworked(sceneObject)
            NetworkRegisterEntityAsNetworked(lockObject)

            scene = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1065353216)

            NetworkAddPedToSynchronisedScene(ped, scene, animDict, TrainAnimation['animations'][1][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(sceneObject, scene, animDict, TrainAnimation['animations'][1][2], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(lockObject, scene, animDict, TrainAnimation['animations'][1][3], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(TrainAnimation['sceneObjects'][1], scene, animDict, TrainAnimation['animations'][1][4], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(TrainAnimation['sceneObjects'][2], scene, animDict, TrainAnimation['animations'][1][5], 1.0, -1.0, 1148846080)

            SetEntityCoords(ped, GetEntityCoords(sceneObject))
            NetworkStartSynchronisedScene(scene)
            Wait(4000)
            UseParticleFxAssetNextCall('scr_tn_tr')
            sparks = StartParticleFxLoopedOnEntity("scr_tn_tr_angle_grinder_sparks", TrainAnimation['sceneObjects'][1], 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 1065353216, 1065353216, 1065353216, 1)
            Wait(1000)
            StopParticleFxLooped(sparks, 1)
            Wait(GetAnimDuration(animDict, 'action') * 1000 - 5000)
            TriggerServerEvent('trainheist:server:containerSync', GetEntityCoords(sceneObject), GetEntityRotation(sceneObject))
            TriggerServerEvent('trainheist:server:objectSync', NetworkGetNetworkIdFromEntity(sceneObject))
            TriggerServerEvent('trainheist:server:objectSync', NetworkGetNetworkIdFromEntity(lockObject))
            DeleteObject(TrainAnimation['sceneObjects'][1])
            DeleteObject(TrainAnimation['sceneObjects'][2])
            ClearPedTasks(ped)
    --     else
    --         QBCore.Functions.Notify('Gerekli eşyalara sahip değilsin', 'error')
    --     end
    -- end)
end

RegisterNetEvent('trainheist:client:lockSync')
AddEventHandler('trainheist:client:lockSync', function(index)
    Config['TrainHeist']['setupTrain']['containers'][index]['lock']['taken'] = not Config['TrainHeist']['setupTrain']['containers'][index]['lock']['taken']
end)

RegisterNetEvent('trainheist:client:grabSync')
AddEventHandler('trainheist:client:grabSync', function(index, index2)
    Config['TrainHeist']['setupTrain']['containers'][index]['golds'][index2]['taken'] = not Config['TrainHeist']['setupTrain']['containers'][index]['golds'][index2]['taken']
end)

RegisterNetEvent('trainheist:client:objectSync')
AddEventHandler('trainheist:client:objectSync', function(e)
    local entity = NetworkGetEntityFromNetworkId(e)
    DeleteEntity(entity)
    DeleteObject(entity)
end)

RegisterNetEvent('trainheist:client:containerSync')
AddEventHandler('trainheist:client:containerSync', function(coords, rotation)
    animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'
    loadAnimDict(animDict)

    if clientContainer and clientLock then
        clientContainer2 = CreateObject(GetHashKey('tr_prop_tr_container_01a'), coords, 0, 0, 0)
        clientLock2 = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), coords, 0, 0, 0)
        
        clientScene = CreateSynchronizedScene(coords, rotation, 2, true, false, 1065353216, 0, 1065353216)
        PlaySynchronizedEntityAnim(clientContainer2, clientScene, TrainAnimation['animations'][1][2], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientContainer2)
        PlaySynchronizedEntityAnim(clientLock2, clientScene, TrainAnimation['animations'][1][3], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientLock2)

        SetSynchronizedScenePhase(clientScene, 0.99)
        SetEntityCollision(clientContainer2, false, true)
        FreezeEntityPosition(clientContainer2, true)
    else
        clientContainer = CreateObject(GetHashKey('tr_prop_tr_container_01a'), coords, 0, 0, 0)
        clientLock = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), coords, 0, 0, 0)
        
        clientScene = CreateSynchronizedScene(coords, rotation, 2, true, false, 1065353216, 0, 1065353216)
        PlaySynchronizedEntityAnim(clientContainer, clientScene, TrainAnimation['animations'][1][2], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientContainer)
        PlaySynchronizedEntityAnim(clientLock, clientScene, TrainAnimation['animations'][1][3], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientLock)

        SetSynchronizedScenePhase(clientScene, 0.99)
        SetEntityCollision(clientContainer, false, true)
        FreezeEntityPosition(clientContainer, true)
    end
end)

function Grab(index, index2)
    QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
		if qtty > 0 then
            grabNow = true
            robber = true
            TriggerServerEvent('trainheist:server:grabSync', index, index2)
            TriggerServerEvent("trainheist:server:rewardItems")
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            animDict = 'anim@scripted@heist@ig1_table_grab@gold@male@'
            loadAnimDict(animDict)
            
            loadModel('hei_p_m_bag_var22_arm_s')
            bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pedCo, 1, 1, 0)
            sceneObject = GetClosestObjectOfType(pedCo, 2.0, GetHashKey('h4_prop_h4_gold_stack_01a'), false, false, false)
            NetworkRegisterEntityAsNetworked(sceneObject)
        
            for i = 1, #GrabGold['animations'] do
                GrabGold['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, GrabGold['scenes'][i], animDict, GrabGold['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, GrabGold['scenes'][i], animDict, GrabGold['animations'][i][2], 1.0, -1.0, 1148846080)
                if i == 2 then
                    NetworkAddEntityToSynchronisedScene(sceneObject, GrabGold['scenes'][i], animDict, 'grab_gold', 1.0, -1.0, 1148846080)
                end
            end
        
            NetworkStartSynchronisedScene(GrabGold['scenes'][1])
            Wait(GetAnimDuration(animDict, 'enter') * 1000)
            NetworkStartSynchronisedScene(GrabGold['scenes'][2])
            Wait(GetAnimDuration(animDict, 'grab') * 1000 - 2250)
            TriggerServerEvent('trainheist:server:objectSync', NetworkGetNetworkIdFromEntity(sceneObject))
            NetworkStartSynchronisedScene(GrabGold['scenes'][4])
            Wait(GetAnimDuration(animDict, 'exit_bag') * 1000)
            
            ClearPedTasks(ped)
            DeleteObject(bag)
            grabNow = false
        else
            QBCore.Functions.Notify('What are you planning to cut the doors with? :D?', 'error')
        end
    end, "delicialet")
end

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 1.2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
	end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, 50)
end

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

RegisterNetEvent('trainheist:client:showNotification')
AddEventHandler('trainheist:client:showNotification', function(str)
    ShowNotification(str)
end)

--Thanks to d0p3t
function PlayCutscene(cut, coords)
    while not HasThisCutsceneLoaded(cut) do 
        RequestCutscene(cut, 8)
        Wait(0) 
    end
    CreateCutscene(false, coords)
    Finish(coords)
    RemoveCutscene()
    DoScreenFadeIn(500)
end

function CreateCutscene(change, coords)
    local ped = PlayerPedId()
        
    local clone = ClonePedEx(ped, 0.0, false, true, 1)
    local clone2 = ClonePedEx(ped, 0.0, false, true, 1)
    local clone3 = ClonePedEx(ped, 0.0, false, true, 1)
    local clone4 = ClonePedEx(ped, 0.0, false, true, 1)
    local clone5 = ClonePedEx(ped, 0.0, false, true, 1)

    SetBlockingOfNonTemporaryEvents(clone, true)
    SetEntityVisible(clone, false, false)
    SetEntityInvincible(clone, true)
    SetEntityCollision(clone, false, false)
    FreezeEntityPosition(clone, true)
    SetPedHelmet(clone, false)
    RemovePedHelmet(clone, true)
    
    if change then
        SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
        RegisterEntityForCutscene(ped, 'MP_2', 0, GetEntityModel(ped), 64)
        
        SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
        RegisterEntityForCutscene(clone2, 'MP_1', 0, GetEntityModel(clone2), 64)
    else
        SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
        RegisterEntityForCutscene(ped, 'MP_1', 0, GetEntityModel(ped), 64)

        SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
        RegisterEntityForCutscene(clone2, 'MP_2', 0, GetEntityModel(clone2), 64)
    end

    SetCutsceneEntityStreamingFlags('MP_3', 0, 1)
    RegisterEntityForCutscene(clone3, 'MP_3', 0, GetEntityModel(clone3), 64)
    
    SetCutsceneEntityStreamingFlags('MP_4', 0, 1)
    RegisterEntityForCutscene(clone4, 'MP_4', 0, GetEntityModel(clone4), 64)
    
    SetCutsceneEntityStreamingFlags('MP_5', 0, 1)
    RegisterEntityForCutscene(clone5, 'MP_5', 0, GetEntityModel(clone5), 64)
    
    Wait(10)
    if coords then
        StartCutsceneAtCoords(coords, 0)
    else
        StartCutscene(0)
    end
    Wait(10)
    ClonePedToTarget(clone, ped)
    Wait(10)
    DeleteEntity(clone)
    DeleteEntity(clone2)
    DeleteEntity(clone3)
    DeleteEntity(clone4)
    DeleteEntity(clone5)
    Wait(50)
    DoScreenFadeIn(250)
end

function Finish(coords)
    if coords then
        local tripped = false
        repeat
            Wait(0)
            if (timer and (GetCutsceneTime() > timer))then
                DoScreenFadeOut(250)
                tripped = true
            end
            if (GetCutsceneTotalDuration() - GetCutsceneTime() <= 250) then
            DoScreenFadeOut(250)
            tripped = true
            end
        until not IsCutscenePlaying()
        if (not tripped) then
            DoScreenFadeOut(100)
            Wait(150)
        end
        return
    else
        Wait(18500)
        StopCutsceneImmediately()
    end
end

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        DeleteVehicle(mainTrain)
        DeleteVehicle(trainPart)
        ClearArea(2885.97, 4560.83, 48.0551, 50.0)
    end
end)