QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterNetEvent('driving:vehicleAction')
AddEventHandler('driving:vehicleAction', function(playerId, action)
    TriggerClientEvent("drivingInstructor:vehicleAction", playerId, action)
end)

RegisterNetEvent('driving:toggleInstructorMode')
AddEventHandler('driving:toggleInstructorMode', function(isInstructorMode)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("drivingInstructor:instructorToggle", source, not isInstructorMode, xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname)
end)

RegisterNetEvent('driving:submitTest')
AddEventHandler('driving:submitTest', function(curTest)
    local xPlayer = QBCore.Functions.GetPlayer(curTest.cid)
    if xPlayer then
        TriggerClientEvent("drivingInstructor:viewResults", curTest.cid, curTest)
        if curTest.passed then
            xPlayer.Functions.SetMetaData("ehliyetceza", 0)
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You passed the test", "success")
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Failed the Test", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "The Identity Number (ID) You Write Doesn't Belong To Anyone", "error")
    end
end)

QBCore.Commands.Add("dtest", "Start Driving Test", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.job.name == "police" then
        TriggerClientEvent("drivingInstructor:testToggle", source)
    end
end)

QBCore.Commands.Add("dtestb", "Finish the Driving Test", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.job.name == "police" then
        TriggerClientEvent("drivingInstructor:submitTest", source)
    end
end)

