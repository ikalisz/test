local taskInProcess = false

function openGui(time)
    TriggerEvent("elixir-base:closeInv")
    SetNuiFocus(true, false)
    SendNUIMessage({type = "open", time = time})
end
  
RegisterNUICallback('fail', function(data, cb)
    closeMenu("fail")
    ClearPedTasks(PlayerPedId())
    exports["elix1rBase"]:SendAlert("you failed", "error", 3500)
end)

RegisterNUICallback('success', function(data, cb)
    closeMenu("success")
end)

function closeMenu(type)
    SetNuiFocus(false, false)
    status = type
    taskInProcess = false
end

function taskBar(difficulty)
    if taskInProcess then return end
    taskInProcess = true
    openGui(difficulty)
    while taskInProcess do 
        local playerPed = PlayerPedId()
        if IsPedRagdoll(playerPed) or IsPedBeingStunned(playerPed) then 
            SetNuiFocus(false, false)
            SendNUIMessage({type = "close"})
            taskInProcess = false
            return false
        end
        Citizen.Wait(0) 
    end
    Citizen.Wait(200)
    if status == "success" then
        return true
    else
        return false
    end
end

RegisterCommand("testskillbar", function()
    local finished = exports["tgiann-skillbar"]:taskBar(15000, 50)
    if finished then
    else
    end
end, tr)