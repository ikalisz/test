local search1, search2, search3, search4, doorOpen = false, false, false, false, false
local duzKontakSes = false
local isLockpicking = false

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
   PlayerData = QBCore.Functions.GetPlayerData()
end)

function dispatch()
  data = {
    id = id,
    code = 1,
    description = "The Cashier's Cash Register Is Robbed",
    location = exports["jtDispatch"]:GetTheStreet(),
    coords = GetEntityCoords(PlayerPedId()),
    sprite = 207
  }
  TriggerServerEvent("jtDispatch:add-notification", data, "police")
end

function dispatchFail()
  data = {
    id = id,
    code = 1,
    description = "Failed Cashier Robbery",
    location = exports["jtDispatch"]:GetTheStreet(),
    coords = GetEntityCoords(PlayerPedId()),
    sprite = 207
  }
  TriggerServerEvent("jtDispatch:add-notification", data, "police")
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	 	Citizen.Wait(5)
	end
end



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



RegisterNetEvent('ra1derCashDeskRob:attemp')
AddEventHandler('ra1derCashDeskRob:attemp', function()
	local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
	for k,v in ipairs(cashdeskrob.Bank) do
		  local doorsCo = v.door
    	local dst = GetDistanceBetweenCoords(pedCo, doorsCo, true)
      if dst < 3.0 then
      QBCore.Functions.TriggerCallback('ra1derCashDeskRob:soyguncheck', function(checkbro)
        if not checkbro then
            QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(Cops)
              if Cops >= cashdeskrob.NeedCop then
                QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
                  if qtty > 0 then
                    QBCore.Functions.TriggerCallback('ra1derCashDeskRob:soyguncheck', function(checkbro) end, k, true, true)
                    duzKontakSes = true
                    isLockpicking = true
                    FreezeEntityPosition(PlayerPedId(), true)
                    TriggerEvent("kilitacaq")
                    TriggerEvent("x-hotwire:duzKontakSes")
                    TriggerEvent('lsrp-lockpick:StartLockpickfo', function(result)
                      if result then
                        -- duzKontakSes = false
                        -- isLockpicking = false
                        FreezeEntityPosition(PlayerPedId(), false)
                            QBCore.Functions.Progressbar('name', 'Picking UP Cash', 10000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                              disableMovement = true,
                              disableCarMovement = true,
                              disableMouse = false,
                              disableCombat = true,
                            }, {
                              animDict = "",
                              anim = "",
                              flags = 49,
                            }, {}, {}, function() -- Play When Done
                              robbing = true
                              dispatch()
                              TriggerServerEvent('ra1derCashDeskRob:deleteItem', 'lockpick3')
                              ClearPedTasks(ped)
                              OpenBankDoor()
                            duzKontakSes = false
                            isLockpicking = false
                            ClearPedTasksImmediately(ped)
                              FreezeEntityPosition(PlayerPedId(), false)
                            end, function() -- Play When Cancel
                              duzKontakSes = false
                              isLockpicking = false
                              QBCore.Functions.Notify('BaşSearchmadın!', 'error')
                              dispatchFail()
                              QBCore.Functions.TriggerCallback('ra1derCashDeskRob:soyguncheck', function(checkbro) end, k, true, false)
                              TriggerServerEvent('ra1derCashDeskRob:deleteItem', 'lockpick3')
                            end)
                          elseif result == false then
                            duzKontakSes = false
                            FreezeEntityPosition(PlayerPedId(), false)
                            isLockpicking = false
                            QBCore.Functions.Notify('you failed', 'error')
                            dispatchFail()
                            QBCore.Functions.TriggerCallback('ra1derCashDeskRob:soyguncheck', function(checkbro) end, k, true, false)
                            TriggerServerEvent('ra1derCashDeskRob:deleteItem', 'lockpick3')
                        end
                      end)
                    else
                      QBCore.Functions.Notify('There is no card you can open this place!', 'error')
                    end
                  end, "guvenlik_karti_b")
                else
                  QBCore.Functions.Notify('Not Enough Cops!', 'error')
                end
              end)
            else
              QBCore.Functions.Notify("This place is already robbed")
            end
          end, k, false)
        end
	  end
end)

function OpenBankDoor()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)

    for i = 1, #cashdeskrob.Bank, 1 do
        local doorsCo = cashdeskrob.Bank[i].door
        local dst = GetDistanceBetweenCoords(pedCo, doorsCo, true)
        local time = 3000
        if dst <= 2.0 then
            search1, search2, search3, search4 = true, true, true, true
            repeat
                local objFound = GetClosestObjectOfType(pedCo, 3.0,-131754413, 0, 0, 0)
                local objFound2 = GetClosestObjectOfType(pedCo, 3.0,-1184592117, 0, 0, 0)
                local objHead = GetEntityHeading(objFound)
                local objHead2 = GetEntityHeading(objFound2)
                objHead = objHead - 0.3
                objHead2 = objHead2 - 0.3
                time = time - 10
                Citizen.Wait(10)
                SetEntityRotation(objFound, 0.0, 0.0, objHead, 2, true)
                SetEntityRotation(objFound2, 0.0, 0.0, objHead2, 2, true)
            until time == 0
        end
    end
end

Citizen.CreateThread( function() -- Döngü bitirme
  local time = 3000
  while true do Wait(time)
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)

    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    for i = 1, #cashdeskrob.Bank, 1 do
      local desk1 = cashdeskrob.Bank[i].desk1
      local desk2 = cashdeskrob.Bank[i].desk2
      local desk3 = cashdeskrob.Bank[i].desk3
      local desk4 = cashdeskrob.Bank[i].desk4
      local dst1 = GetDistanceBetweenCoords(pedCo, desk1.x, desk1.y, desk1.z, true)
      local dst2 = GetDistanceBetweenCoords(pedCo, desk2.x, desk2.y, desk2.z, true)
      local dst3 = GetDistanceBetweenCoords(pedCo, desk3.x, desk3.y, desk3.z, true)
      local dst4 = GetDistanceBetweenCoords(pedCo, desk4.x, desk4.y, desk4.z, true)
      if dst1 <= 0.75 and search1 then
      time = 0
        QBCore.Functions.DrawText3D(desk1.x, desk1.y, desk1.z, '[H] Search')
        if IsControlJustPressed(1, 74) then
          time = 1000
          search1 = false
          QBCore.Functions.Progressbar("vezne_Search3", "you are looking for..", 20000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {
              animDict = "mini@repair",
            anim = "fixing_a_player",
            flags = 49,
            }, {}, {}, function() -- Done
              TriggerServerEvent('ra1derCashDeskRob:giveMoney', QBCore.Key)
              TriggerServerEvent("ra1derCashDeskRob:kart", QBCore.Key)
              ClearPedTasks(ped)
            end, function() -- Cancel
              search1 = true
            end)         
        end
      end
      if dst2 <= 1 and search2 then
        time = 0
        QBCore.Functions.DrawText3D(desk2.x, desk2.y, desk2.z, '[H] Search')
        if IsControlJustPressed(1, 74) then
          time = 1000
          search2 = false
          QBCore.Functions.Progressbar("vezne_Search3", "you are looking for..", 20000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {
              animDict = "mini@repair",
            anim = "fixing_a_player",
            flags = 49,
            }, {}, {}, function() -- Done
              TriggerServerEvent('ra1derCashDeskRob:giveMoney', QBCore.Key)
              ClearPedTasks(ped)
            end, function() -- Cancel
              search2 = true
            end)         
        end
      end
      if dst3 <= 1 and search3 then
        time = 0
        QBCore.Functions.DrawText3D(desk3.x, desk3.y, desk3.z, '[H] Search')
        if IsControlJustPressed(1, 74) then
          time = 1000
          search3 = false
          QBCore.Functions.Progressbar("vezne_Search", "you are looking for..", 20000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {
              animDict = "mini@repair",
            anim = "fixing_a_player",
            flags = 49,
            }, {}, {}, function() -- Done
                TriggerServerEvent('ra1derCashDeskRob:giveMoney', QBCore.Key)
                ClearPedTasks(ped)
              end, function() -- Cancel
                search3 = true
            end)         
          end
        end
      if dst4 <= 1 and search4 then
        time = 0
        QBCore.Functions.DrawText3D(desk4.x, desk4.y, desk4.z, '[H] Search')
        if IsControlJustPressed(1, 74) then
          time = 1000
          search4 = false
            QBCore.Functions.Progressbar("vezne_Search2", "you are looking for..", 20000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
              }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 49,
              }, {}, {}, function() -- Done
              TriggerServerEvent('ra1derCashDeskRob:giveMoney', QBCore.Key, "31")
              ClearPedTasks(ped)
              Citizen.Wait(cashdeskrob.CloseDoorWhenFinish)

                local objFound = GetClosestObjectOfType(pedCo, 30.0,-131754413, 0, 0, 0)
                local objCo = GetEntityCoords(objFound)
                local doorDst = GetDistanceBetweenCoords(pedCo, 1178.87, 2709.365, 38.36251, true)
                local doorDst2 = GetDistanceBetweenCoords(pedCo, -1214.905, -334.7281, 38.05551, true)
                local doorDst3 = GetDistanceBetweenCoords(pedCo, -2960.176, 479.0105, 15.97156, true)

                if doorDst < 30.0 then
                   SetEntityRotation(objFound, 0.0, 0.0, 450.0, 2, true)
                elseif doorDst2 < 30.0 then
                    SetEntityRotation(objFound, 0.0, 0.0, 300.0, 2, true)
                elseif doorDst3 < 30.0 then
                    SetEntityRotation(objFound, 0.0, 0.0, 355.0, 2, true)
                else
                    SetEntityRotation(objFound, 0.0, 0.0, 250.0, 2, true)
                  end
                end, function() -- Cancel
              search4 = true
              time = 3000
            end)         
          end
        end
      end
    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    local objFound = GetClosestObjectOfType(pedCo, 30.0,-131754413, 0, 0, 0)
    local objCo = GetEntityCoords(objFound)
    local doorDst = GetDistanceBetweenCoords(pedCo, 1178.87, 2709.365, 38.36251, true)
    local doorDst2 = GetDistanceBetweenCoords(pedCo, -1214.905, -334.7281, 38.05551, true)
    local doorDst3 = GetDistanceBetweenCoords(pedCo, -2960.176, 479.0105, 15.97156, true)

    if doorDst < 30.0 then
       SetEntityRotation(objFound, 0.0, 0.0, 450.0, 2, true)
    elseif doorDst2 < 30.0 then
        SetEntityRotation(objFound, 0.0, 0.0, 300.0, 2, true)
    elseif doorDst3 < 30.0 then
        SetEntityRotation(objFound, 0.0, 0.0, 355.0, 2, true)
    else
        SetEntityRotation(objFound, 0.0, 0.0, 250.0, 2, true)
      end
	end
end)
