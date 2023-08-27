local npc = vector3(-55.56, 67.67, 71.95)
local carPos = vector3(-75.6, 74.98, 71.81)

QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(vector3(-61.97, 69.09, 71.86))
    SetBlipSprite(blip, 85)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 29)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Used Vehicle Sales")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        local distance = #(pedCoords - npc)
        inUI = false
        local time = 1000
        if distance < 20 then
            time = 1
            -- DrawMarker(2, npc.x, npc.y, npc.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 110, 195, 231, 100, false, true, 2, false, false, false, false)
            if distance < 2 and coreLoaded then
                inUI = true
                exports['qb-ui']:showInteraction("[E] Used Car Shop")
                if IsControlJustReleased(0, 38) then
                    openMenu()
                end
            end 
            if not inUI then
                exports['qb-ui']:hideInteraction()
            end
        end
        Citizen.Wait(time)
    end
end)






function openMenu()
    QBCore.UI.Menu.CloseAll()
    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'carMenu',{
        title    = 'Used Vehicle Sales',
        align    = 'left',
        elements = {
            {label = "Buy Used Car", value = "buy"},
            {label = "Add Your Vehicle to Sales List", value = "sell"},
            {label = "Vehicles I Put for Sale", value = "my_sell"}
        }
    }, function(data, menu)
        if data.current.value == "buy" then
            buyCar()
        elseif data.current.value == "import" then
            import()
        elseif data.current.value == "sell" then
            sellCar()
        elseif data.current.value == "my_sell" then
            mySellCar()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
end

function spawnFristCar(carModel)
    WaitForVehicleToLoad(carModel)
    QBCore.Functions.SpawnVehicle(carModel, function(vehicle)
        FreezeEntityPosition(vehicle, true)
        SetModelAsNoLongerNeeded(carModel)
        TriggerEvent("x-hotwire:give-keys", vehicle)
    end, {x=carPos.x, y=carPos.y, z=carPos.z, h=210.0}, false)
end

local spawnLocation = {
    {x=-65.53, y=81.43, z=71.55, h=62.95},
    {x=-73.97, y=84.67, z=71.47, h=62.95},
    {x=-81.72, y=83.15, z=71.48, h=147.48},
    {x=-88.42, y=72.19, z=71.58, h=147.48},
}

function isSpawnLocationFree()
    for i=1, #spawnLocation do
        if QBCore.Functions.IsSpawnPointClear(vector3(spawnLocation[i].x, spawnLocation[i].y, spawnLocation[i].z), 3.0) then
            return spawnLocation[i]
        end
    end
    return spawnLocation[1]
end

function import()
    QBCore.Functions.TriggerCallback('tgiann-ikinciel:import-car', function(importCars)
        local elements = {}

        local playerPed   = PlayerPedId()
        createdCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(createdCamera, -71.62, 75.67, 73.61)
        SetCamRot(createdCamera, -25.0, 0.0, 98.0, 2)
        RenderScriptCams(1, 0, 0, 1, 1)
        local first = false
        for _, car in pairsByKeys(importCars) do
            table.insert(elements, {label = car.label .." (Piece: "..car.count.. ") $" .. car.price, value = car})
            if not first then
                first = true
                spawnFristCar(car.model)
            end

        end

        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'car_import_menu', {
            title    = 'Buy Import Vehicle',
            align    = 'left',
            elements = elements
        }, function(data, menu)
            if data.current.value.count > 0 then
                QBCore.UI.Menu.CloseAll()
                TriggerServerEvent("tgiann-ikinciel:buy-import", data.current.value, QBCore.Key)
            else
                QBCore.Functions.Notify("Vehicle is Out of Stock!", "error")
            end
        end,function(data, menu)
            -- esc
            menu.close()
            DeleteDisplayVehicleInsideShop()
            DestroyCam(createdCamera, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
		    createdCamera = 0
        end,function(data, menu)
            --aşağı yukar
            local vehicleData = data.current.value
            if vehicleData then
                DeleteDisplayVehicleInsideShop()
                WaitForVehicleToLoad(vehicleData.model)

                QBCore.Functions.SpawnVehicle(vehicleData.model, function(vehicle)
                    FreezeEntityPosition(vehicle, true)
                    SetModelAsNoLongerNeeded(vehicleData.model)
                    TriggerEvent("x-hotwire:give-keys", vehicle)
                end, {x=carPos.x, y=carPos.y, z=carPos.z, h=210.0}, false)
            end

        end, function(data, menu)
            --enter
            DeleteDisplayVehicleInsideShop()
            DestroyCam(createdCamera, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
		    createdCamera = 0
        end)
    end)

end

function mySellCar()
    local elements = {}

    QBCore.Functions.TriggerCallback('tgiann-ikinciel:my-sell-car', function(myCars)
        if myCars then
            for _, car in pairs(myCars) do
                local carModelName = GetDisplayNameFromVehicleModel(json.decode(car.prop).model)
                local plate = car.plate
                table.insert(elements, {label = carModelName .. " " .. plate, value = plate})
            end
        else
            table.insert(elements, {label = "You Don't Have Any Vehicles for Sale!"})
        end

        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'car_sell_menu',
        {
            title    = 'Remove Your Vehicle from Sale',
            align    = 'left',
            elements = elements
        }, function(data, menu)
            QBCore.UI.Menu.CloseAll()
            TriggerServerEvent("tgiann-ikinciel:delete-list", data.current.value)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function sellCar()
    local elements = {}

    QBCore.Functions.TriggerCallback('tgiann-ikinciel:player-car', function(myCars)
        if myCars then
            for _, car in pairs(myCars) do
                local carModelName = GetDisplayNameFromVehicleModel(json.decode(car.vehicle).model)
                local plate = car.plate
                local prop = car.vehicle
                table.insert(elements, {label = carModelName .. " " .. plate, value = plate, prop = prop})
            end
        else
            table.insert(elements, {label = "You Don't Have a Vehicle to Sell"})
        end

        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'car_sell_menu',
        {
            title    = 'Used Vehicle Sales',
            align    = 'left',
            elements = elements
        }, function(data2, menu2)
            QBCore.UI.Menu.CloseAll()
            if data2.current.value then
                openPriceMenu(data2.current.value, data2.current.prop)
            end
        end, function(data2, menu2)
            menu2.close()
        end)
    end)
end

function openPriceMenu(plate, prop)
    QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_car_input_menu', {
            title = "Vehicle Sales Price"
    }, function(data3, menu3)
        local sellPrice = tonumber(data3.value)
        if type(sellPrice) == "number" then
            TriggerServerEvent("tgiann-ikinciel:sell-car", sellPrice, plate, prop)
            local gameVehicles = QBCore.Functions.GetVehicles()
            for i = 1, #gameVehicles do
                local vehicle = gameVehicles[i]

                if DoesEntityExist(vehicle) then
                    if trim(GetVehicleNumberPlateText(vehicle)) == trim(plate) then
                        QBCore.Functions.DeleteVehicle(vehicle)
                        break
                    end
                end
            end

        else
            QBCore.Functions.Notify("Incorrect Quantity!", "error")
        end
        menu3.close()
    end, function(data3, menu3)
        menu3.close()
    end)
end

local createdCamera = 0
function buyCar()
    local elements = {}
    local playerPed   = PlayerPedId()

	createdCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(createdCamera, -71.62, 75.67, 73.61)
	SetCamRot(createdCamera, -25.0, 0.0, 98.0, 2)
    RenderScriptCams(1, 0, 0, 1, 1)

    QBCore.Functions.TriggerCallback('tgiann-ikinciel:car-list', function(listedCars)
        if listedCars then
            for _, car in pairs(listedCars) do
                local carModel = json.decode(car.prop).model
                local carModelName = GetDisplayNameFromVehicleModel(carModel)
                local plate = car.plate
                local prop = json.decode(car.prop)
                local price = car.price
                local ownerId = car.citizenid
                if _ == 1 then
                    WaitForVehicleToLoad(carModel)
                    QBCore.Functions.SpawnVehicle(carModel, function(vehicle)
                        FreezeEntityPosition(vehicle, true)
                        QBCore.Functions.SetVehicleProperties(vehicle, prop)
                        SetModelAsNoLongerNeeded(carModel)
                        TriggerEvent("x-hotwire:give-keys", vehicle)
                    end, {x=carPos.x, y=carPos.y, z=carPos.z, h=210.0}, false)
                end
                table.insert(elements, {label = carModelName .. " " .. plate .. " $" .. QBCore.Shared.GroupDigits(price), value = plate, prop = prop, price = price, owner = ownerId, model = carModel})
            end
        else
            table.insert(elements, {label = "No Vehicle For Sale"})
        end

        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'car_sell_menu',
        {
            title    = 'Buy Used Car',
            align    = 'left',
            elements = elements
        }, function(data4, menu4)
            QBCore.UI.Menu.CloseAll()
            if data4.current.value then
                TriggerServerEvent("tgiann-ikinciel:buy-car", data4.current.value, data4.current.price, data4.current.owner)
            end

        end,function(data4, menu4)
            -- esc
            menu4.close()
            DeleteDisplayVehicleInsideShop()
            DestroyCam(createdCamera, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
		    createdCamera = 0
        end,function(data4, menu4)
            --aşağı yukar
            local vehicleData = data4.current
            if vehicleData.value then
                DeleteDisplayVehicleInsideShop()
                WaitForVehicleToLoad(vehicleData.model)

                QBCore.Functions.SpawnVehicle(vehicleData.model, function(vehicle)
                    FreezeEntityPosition(vehicle, true)
                    QBCore.Functions.SetVehicleProperties(vehicle, vehicleData.prop)
                    SetModelAsNoLongerNeeded(vehicleData.model)
                    TriggerEvent("x-hotwire:give-keys", vehicle)
                end, {x=carPos.x, y=carPos.y, z=carPos.z, h=210.0}, false)
            end

        end, function(data4, menu4)
            --enter
            DeleteDisplayVehicleInsideShop()
            DestroyCam(createdCamera, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
		    createdCamera = 0
        end)
    end)
end

function WaitForVehicleToLoad(modelHash)
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        BeginTextCommandBusyspinnerOn('STRING')
        AddTextComponentSubstringPlayerName("Vehicle Loading...")
        EndTextCommandBusyspinnerOn(4)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end

        BusyspinnerOff()
    end
end

function DeleteDisplayVehicleInsideShop()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle(carPos)

    if distance < 4 then
         if DoesEntityExist(vehicle) then
            QBCore.Functions.DeleteVehicle(vehicle)
        end
    end  
end

function trim(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end

RegisterNetEvent("tgiann-ikinciel:client:buy-import")
AddEventHandler("tgiann-ikinciel:client:buy-import", function(model, count)
    local spawnCoords = isSpawnLocationFree()
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        local carData = QBCore.Functions.GetVehicleProperties(vehicle)
        carData.plate = exports['esx_vehicleshop']:GeneratePlate()
        QBCore.Functions.SetVehicleProperties(vehicle, carData)
        SetModelAsNoLongerNeeded(model)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        TriggerEvent("x-hotwire:give-keys", vehicle)
        TriggerServerEvent("tgiann-ikinciel:buy-import-car", carData, count, QBCore.Key)
    end, {x=spawnCoords.x, y=spawnCoords.y, z=spawnCoords.z, h=spawnCoords.h}, true)
end)