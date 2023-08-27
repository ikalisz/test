QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("gamz-skillsystem:update")
AddEventHandler("gamz-skillsystem:update", function(data, key)
     if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
          local src = source
          local xPlayer = QBCore.Functions.GetPlayer(src)
          if xPlayer then
               xPlayer.Functions.SetMetaData("skill", data)
          end
     end
end)