QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


local peds = {
    ["avsatici"] = {
        isim = "Hunter Osman",
        pedmodel =  0xA2E86156,
        konum = {x = 1321.483, y = 4314.520, z = 38.333, h = 81.78825378418},
        dict = "amb@lo_res_idles@",
        anim = "world_human_lean_female_holding_elbow_lo_res_base",
        icerik  = {
            {item = "geyikderisi", fiyat = 50, label = "Deerskin"},
            {item = "boktancesed", fiyat = 200, label = "Shit Corpse"},
            {item = "kotucesed", fiyat = 350, label = "Evil Corpse"},
            {item = "normalcesed", fiyat = 500, label = "Normal Corpse"},
            {item = "iyicesed", fiyat = 750, label = "Good Corpse"},
            {item = "kalitelicesed", fiyat = 2000, label = "Quality Corpse"},
        }
    },
    ["balikalicisi"] = {
        isim = "Blade Chieftain",
        pedmodel =  0x0DE9A30A,
        konum = {x = -1816.52, y = -1193.32, z = 14.3045, h = 328.23},
        dict = "amb@lo_res_idles@",
        anim = "world_human_lean_female_holding_elbow_lo_res_base",
        icerik  = {
            {item = "mackerel", fiyat = math.random(35, 55), label = "Mackerel Fish"},
            {item = "codfish", fiyat = math.random(35, 60), label = "Cod Fish"},
            {item = "bass", fiyat = math.random(25, 45), label = "Seabass"},
            {item = "flounder", fiyat = math.random(65, 75), label = "Flounder"},
            {item = "stingray", fiyat = math.random(40, 70), label = "Stingray fish"},
        }
    },
    ["geridonusum"] = {
        isim = "Recycler Angel",
        pedmodel =  0x69F46BF3,
        konum = {x = 960.5411, y = -1586.06, z = 30.387, h = 277.99952697754},
        dict = "amb@lo_res_idles@",
        anim = "world_human_lean_female_holding_elbow_lo_res_base",
        icerik  = {
            {item = "sise", fiyat = math.random(3, 5), label = "Glass bottle"},
            {item = "bos_tup", fiyat = math.random(15, 40), label = "Empty Steel Tube"},
            {item = "psise", fiyat = math.random(2, 5), label = "Dirty Bottle"},
            {item = "ksise", fiyat = math.random(2, 5), label = "Broken Bottle"},
            {item = "recycle_item", fiyat = math.random(3, 11), label = "Recycle Product"},
            {item = "pkonserve", fiyat = math.random(2, 7), label = "Rusty Tins"},
            {item = "fabric", fiyat = math.random(3, 6), label = "Material"},
            {item = "notd", fiyat = math.random(3, 8), label = "Notebook"},
            {item = "bsigara", fiyat = math.random(1, 2), label = "Smoked Cigarette"},
        }
    },
    ["madensatis"] = {
        isim = "Since the Buyer is Sam",
        pedmodel =  0xFBB374CA,
        konum = {x = 269.9052, y = -3075.83, z = 5.7745, h = 229.99952697754},
        dict = "amb@lo_res_idles@",
        anim = "world_human_lean_female_holding_elbow_lo_res_base",
        icerik  = {
            {item = "finishedstone", fiyat = math.random(180, 220), label = "Machined Stone Pieces"},
            {item = "finishedmetal", fiyat = math.random(225, 270), label = "Machined Metal"},
            {item = "finishedcopper", fiyat = math.random(325, 365), label = "Machined Copper"},
            {item = "finishediron", fiyat = math.random(425, 475), label = "Processed Iron"},
            {item = "finishedgold", fiyat = math.random(600, 700), label = "Processed Gold Ingot"},
            {item = "finisheddiamond", fiyat =  math.random(959, 1050), label = "Machined Diamond Particles"},
        }
    },
    ["odunsatis"] = {
        isim = "Lumberjack Jack",
        pedmodel =  0x9A1E5E52,
        konum = {x = 854.51, y = -2112.81, z = 31.58, h = 178.99952697754},
        dict = "amb@lo_res_idles@",
        anim = "world_human_lean_female_holding_elbow_lo_res_base",
        icerik  = {
            {item = "odun", fiyat = math.random(15, 25), label = "Wood Planks"},
            {item = "cutted_wood", fiyat = math.random(45, 65), label = "Processed Wood"},
        }
    },
}




RegisterServerEvent("ra1derSellNpc:onLoad", function()
    TriggerClientEvent("ra1derSellNpc:setpeds", source, peds)
end)

RegisterServerEvent("ra1derSellNpc:server:Trade")
AddEventHandler("ra1derSellNpc:server:Trade", function(item, miktar, fiyat, key)
    local src = tonumber(source)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        if item == "televizyon" then
            local itemData = xPlayer.Functions.GetItemByName(item)
            if itemData.amount > 0 then
                if xPlayer.Functions.RemoveItem(itemData.name, 1, itemData.slot) then
                    if itemData.info.level == 1 then
                        xPlayer.Functions.AddMoney("cash", math.random(2000, 2500), "1 level TV sold (sellnpc)")
                    elseif itemData.info.level == 2 then
                        xPlayer.Functions.AddMoney("cash", math.random(2500, 4500), "Sold 2 level television (sellnpc)")
                    else
                        xPlayer.Functions.AddMoney("cash", math.random(4500, 6000), "Sold 3 level televisions (sellnpc)")
                    end
                else
                    TriggerClientEvent("QBCore:Notify", src, 'There are no '..miktar..' ' .. QBCore.Shared.Items[item].label ..'on or in a slot!', 'error')		
                end
            else
                TriggerClientEvent("QBCore:Notify", src, 'No TV on it or in a slot!', 'error')		
            end
            return
        end
        toplamfiyat = miktar * fiyat
        if xPlayer.Functions.RemoveItem(item, miktar) then
            xPlayer.Functions.AddMoney("cash", toplamfiyat, miktar.. "x ".. item .. " sold (sellnpc)")
            TriggerEvent('DiscordBot:ToDiscord', 'seller', " | " ..QBCore.Shared.Items[item].label.. " Eşyasını "  ..miktar.. " Adet " ..toplamfiyat.. "$'a Sattı", src)
                --  TriggerEvent('DiscordBot:ToDiscord', 'seller', "31", src)
        else
            TriggerClientEvent("QBCore:Notify", src, 'There are no '..miktar..' ' .. QBCore.Shared.Items[item].label ..'on or in a slot!', 'error')			
        end
    end
end)

QBCore.Functions.CreateCallback("ra1derSellNpc:ItemCheck", function(source, cb, args, amount)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(source)
    local itemname = args
    if Player then 
        if Player.Functions.GetItemByName(itemname) and Player.Functions.GetItemByName(itemname).amount >= amount then
            cb(true) 
        else
            cb(false)
        end
    end
end)
