QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("kfzeu:itemal")
AddEventHandler('kfzeu:itemal', function(data, qty)
    local src = tonumber(source)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local calculatePrice = data.value.price * qty
    if xPlayer.Functions.RemoveMoney("cash", calculatePrice) then
        if string.match(data.value.itemname, "weapon") then
            for i=1, qty do
                if xPlayer.Functions.AddItem(data.value.itemname, 1) then
                    TriggerClientEvent("QBCore:Notify", src, data.value.price .."$ 1 piece in return ".. data.label .."")
                else
                    xPlayer.Functions.AddMoney("cash", data.value.price, "money back")
                    TriggerClientEvent("QBCore:Notify", src, "You Are Too Heavy!", "error")
                end
            end
        else
            if xPlayer.Functions.AddItem(data.value.itemname, qty) then
                TriggerClientEvent("QBCore:Notify", src, calculatePrice .."$ in return "..qty.." Piece ".. data.label .."")
            else
                xPlayer.Functions.AddMoney("cash", calculatePrice, "money back")
                TriggerClientEvent("QBCore:Notify", src, "You Are Too Heavy", "error")
            end
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have enough money", "error")
    end
end)

RegisterServerEvent("kfzeu:syncXenon")
AddEventHandler("kfzeu:syncXenon", function(vehID, renk, sender)
    TriggerClientEvent("kfzeu:sync:xenon", -1, vehID, renk, sender)
end)

RegisterServerEvent("edrp_meatfarm:item-sil")
AddEventHandler('edrp_meatfarm:item-sil', function(item, miktar)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem(item, miktar)
end)

QBCore.Functions.CreateCallback("ra1der_farm:kontrol",function(source,cb,data,count)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if data.value.isRandom then
        for i=1, #data.value.giveItemList do
            local item = data.value.giveItemList[i]

            if not xPlayer.Functions.AddItem(item, data.value.give[item]*count) then
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, data.value.give[item]*count .. " Tane " ..QBCore.Shared.Items[item].label.. " You Didn't Get Your Item Because You Are Too Heavy.", "error", 15000)
            end
        end
        cb(true)
    else
        local needWeight, nedWeight = 0, (QBCore.Shared.Items[data.value.itemname].weight * (data.value.give*count))
        for item, value in pairs(data.value.neededitems) do
            for item2,dosya in pairs(QBCore.Shared.Items) do
                if item == item2 then
                    needWeight = needWeight + (dosya.weight * (value.miktar * count))
                    break
                end
            end
        end
        local totalWeight = QBCore.Player.GetTotalWeight(xPlayer.PlayerData.items)
        if (totalWeight - needWeight) +  nedWeight <= QBCore.Config.Player.MaxWeight then
            cb(true)
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You're So Heavy.", "error")
            cb(false)
        end
    end
end)
RegisterServerEvent("edrp_meatfarm:craftla")
AddEventHandler('edrp_meatfarm:craftla', function(data, count)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if data.value.isRandom then
        for i=1, #data.value.giveItemList do
            local item = data.value.giveItemList[i]

            if not xPlayer.Functions.AddItem(item, data.value.give[item]*count) then
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, data.value.give[item]*count .. " Unit " ..QBCore.Shared.Items[item].label.. " You Didn't Get Your Item Because You Are Too Heavy.", "error", 15000)
            end
        end
    else
        local needWeight, nedWeight = 0, (QBCore.Shared.Items[data.value.itemname].weight * (data.value.give*count))
        for item, value in pairs(data.value.neededitems) do
            for item2,dosya in pairs(QBCore.Shared.Items) do
                if item == item2 then
                    needWeight = needWeight + (dosya.weight * (value.miktar * count))
                    break
                end
            end
        end
        local totalWeight = QBCore.Player.GetTotalWeight(xPlayer.PlayerData.items)
        if (totalWeight - needWeight) +  nedWeight <= QBCore.Config.Player.MaxWeight then
            for item,value in pairs(data.value.neededitems) do
                xPlayer.Functions.RemoveItem(item, value.miktar * count)
            end
            xPlayer.Functions.AddItem(data.value.itemname, data.value.give*count)
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Take it, it's for you")
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You're So Heavy.", "error")
        end
    end
end)



local uzumRestart = false -- Her restartta üzüm satma aktif olsun
local uzumSatanlar = {}
RegisterServerEvent('meat-farm:startSelling')
AddEventHandler('meat-farm:startSelling', function(item, qty, money, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer.Functions.GetItemByName(item).amount >= qty then
            if item == "uzumkasa" then
                if uzumRestart then
                    local time = (os.time() - xPlayer.PlayerData.metadata["uzum"])
                    if time < 86400 and xPlayer.PlayerData.metadata["uzum"] ~= 0 then
                        TriggerClientEvent("QBCore:Notify", src, 'You Can Only Sell 1 Case Of Grapes A Day! The Next Grape Crate '.. QBCore.Shared.Round(((86400-time)/60)/60,2) .. ' You Can Sell After Hours', 'error')	
                        return
                    else          
                        if uzumSatanlar[xPlayer.PlayerData.citizenid] == nil  then
                            uzumSatanlar[xPlayer.PlayerData.citizenid] = qty
                            TriggerClientEvent("QBCore:Notify", src, 'The right to sell the remaining grape crates per day : ' .. 1 - uzumSatanlar[xPlayer.PlayerData.citizenid] )	
                            TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty..' He sold a Grape Crate and' .. money*qty ..'$ won.', src)
                        else
                            if uzumSatanlar[xPlayer.PlayerData.citizenid] >= 1 then
                                TriggerClientEvent("QBCore:Notify", src, 'You can sell 1 crate per day!', 'error')	
                                xPlayer.Functions.SetMetaData("uzum", os.time())
                                return
                            else
                                uzumSatanlar[xPlayer.PlayerData.citizenid] = qty + uzumSatanlar[xPlayer.PlayerData.citizenid]
                                TriggerClientEvent("QBCore:Notify", src, 'Your right to sell a crate of grapes left for the day : ' .. 1 - uzumSatanlar[xPlayer.PlayerData.citizenid] )
                                TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty..' He sold a Grape Crate and' .. money*qty ..'$ won.', src)	
                            end
                        end
                    end
                else
                    local time = (os.time() - xPlayer.PlayerData.metadata["uzum"])
                    if time < 86400 and xPlayer.PlayerData.metadata["uzum"] ~= 0 then
                        TriggerClientEvent("QBCore:Notify", src, 'You Can Only Sell Grape Crates Once A Day! Next Grape '.. QBCore.Shared.Round(((86400-time)/60)/60,2) .. ' You Can Sell After Hours', 'error')	
                        return
                    else
                        if qty <= 5 then
                            if qty ~= 5 then
                                if uzumSatanlar[xPlayer.PlayerData.citizenid] == nil  then
                                    if xPlayer.Functions.RemoveItem(item, qty) then
                                        xPlayer.Functions.AddMoney("cash", money*qty, QBCore.Shared.Items[item].label .. " ".. qty .."x sold it. kfzeu")
                                        -- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", qty)
                                        TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty.."x "..QBCore.Shared.Items[item].label..' sold and '..money*qty..'$ won.', src)	
                                        uzumSatanlar[xPlayer.PlayerData.citizenid] = qty
                                    else   
                                        TriggerClientEvent("QBCore:Notify", src, 'On or in a Slot '..qty..' Tane ' .. QBCore.Shared.Items[item].label ..' None!', 'error')		
                                    end
                                else
                                    if uzumSatanlar[xPlayer.PlayerData.citizenid] + qty > 5 then
                                        TriggerClientEvent("QBCore:Notify", src, 'You Can Sell Up To 5 Crates of Grape: Remaining Rights ('.. 5 - uzumSatanlar[xPlayer.PlayerData.citizenid] .. ")", 'error')	
                                    elseif uzumSatanlar[xPlayer.PlayerData.citizenid] + qty == 5 then
                                        if xPlayer.Functions.RemoveItem(item, qty) then
                                            xPlayer.Functions.AddMoney("cash", money*qty, QBCore.Shared.Items[item].label .. " ".. qty .."x sold it. kfzeu")
                                            -- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", qty)
                                            TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty.."x "..QBCore.Shared.Items[item].label..' sold and '..money*qty..'$ won.', src)	
                                            xPlayer.Functions.SetMetaData("uzum", os.time())
                                            uzumSatanlar[xPlayer.PlayerData.citizenid] = 5
                                        else   
                                            TriggerClientEvent("QBCore:Notify", src, 'On or in a Slot '..qty..' Tane ' .. QBCore.Shared.Items[item].label ..' None!', 'error')		
                                        end
                                    else
                                        if xPlayer.Functions.RemoveItem(item, qty) then
                                            xPlayer.Functions.AddMoney("cash", money*qty, QBCore.Shared.Items[item].label .. " ".. qty .."x sold it. kfzeu")
                                            -- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", qty)
                                            TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty.."x "..QBCore.Shared.Items[item].label..' sold and '..money*qty..'$ won.', src)	
                                            uzumSatanlar[xPlayer.PlayerData.citizenid] = uzumSatanlar[xPlayer.PlayerData.citizenid] + qty
                                        else   
                                            TriggerClientEvent("QBCore:Notify", src, 'On or in a Slot '..qty..' Tane ' .. QBCore.Shared.Items[item].label ..' None!', 'error')		
                                        end
                                    end
 
                                end
                            else
                                if xPlayer.Functions.RemoveItem(item, qty) then
                                    xPlayer.Functions.AddMoney("cash", money*qty, QBCore.Shared.Items[item].label .. " ".. qty .."x sold it. kfzeu")
                                    -- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", qty)
                                    TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty.."x "..QBCore.Shared.Items[item].label..'sold and '..money*qty..'$ won.', src)	
                                    xPlayer.Functions.SetMetaData("uzum", os.time())
                                    uzumSatanlar[xPlayer.PlayerData.citizenid] = 5
                                else   
                                    TriggerClientEvent("QBCore:Notify", src, 'On or in a Slot '..qty..' Unit ' .. QBCore.Shared.Items[item].label ..' None!', 'error')		
                                end
                            end
                        else
                            TriggerClientEvent("QBCore:Notify", src, 'You Can Sell Up To 5 Crates of Grape', 'error')	
                            return
                        end
                    end
                end
            else
                if xPlayer.Functions.RemoveItem(item, qty) then
                    xPlayer.Functions.AddMoney("cash", money*qty, QBCore.Shared.Items[item].label .. " ".. qty .."x sold. kfzeu")
                    -- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", qty)
                    TriggerEvent('DiscordBot:ToDiscord', 'legalmeslek', qty.."x "..QBCore.Shared.Items[item].label..' sold and '..money*qty..'$ won.', src)	
                else   
                    TriggerClientEvent("QBCore:Notify", src, 'On or in a Slot '..qty..' Tane ' .. QBCore.Shared.Items[item].label ..' None!', 'error')		
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", src, 'On or in a Slot '..qty..' Tane ' .. QBCore.Shared.Items[item].label ..' None!', 'error')		
        end 
    end
end)