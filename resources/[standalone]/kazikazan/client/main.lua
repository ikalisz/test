local QBCore = exports['qb-core']:GetCoreObject()

local kazanc = nil
RegisterNetEvent('esx_kazikazan:onStart', function()
  SetNuiFocus(true, true)
  SendNUIMessage({
      action = "openui"
  })
end)

RegisterNUICallback('reward', function(data, cb)
kazanc = data.price
    if kazanc then
      TriggerServerEvent('esx_kazikazan:withdraw', data.price)
      QBCore.Functions.Notify('Congratulations Scratcher $' ..data.price.. 'You Won Dollars','success')
    else
      QBCore.Functions.Notify('You wont gain anything from scratching.','error')
    end
    SetNuiFocus(false, false)
    SendNUIMessage({
      action = "closeui"
    })
end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
      action = "closeui"
    })
end)