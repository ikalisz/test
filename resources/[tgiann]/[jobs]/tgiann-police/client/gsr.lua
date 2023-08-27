local ignoreShooting = false

Citizen.CreateThread(function()
    while true do
        local time = 250
        local ped = PlayerPedId()
        if IsPedArmed(ped, 7) then 
            if IsPedShooting(ped) then
                local currentWeapon = GetSelectedPedWeapon(ped)
                for _,k in pairs(Config.weaponChecklist) do
                    if currentWeapon == k then
                        ignoreShooting = true
                        break
                    end
                end
                
                if not ignoreShooting then
                    TriggerServerEvent('GSR:SetGSR')
                    ignoreShooting = false
                    Citizen.Wait(Config.gsrUpdate)
                end
                ignoreShooting = false
            end
        end
        Citizen.Wait(time)
    end
end)