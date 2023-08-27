QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
end)

peds = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)



local gecePeds = {
        ["aracparcaalisi"] = {
            spawned = false,
            isim = "Shard Jack",
            pedmodel = 0xC4B715D2,
            konum = {
                x = -545.521,
                y = -1797.35,
                z = 22.348,
                h = 136.99952697754
            },
            dict = "amb@lo_res_idles@",
            anim = "world_human_lean_female_holding_elbow_lo_res_base",
                icerik = {
                {
                    item = "battery",
                    fiyat =  math.random(190,245),
                    label = "Vehicle Battery"
                }, {
                    item = "airbag",
                    fiyat = math.random(200,255),
                    label = "Airbag"
                }, {
                    item = "lowradio",
                    fiyat = math.random(80,145),
                    label = "Stock Radio"
                }, {
                    item = "pparca",
                    fiyat = math.random(125,160),
                    label = "Quality Vehicle Parts"
                }, {
                    item = "stockrim",
                    fiyat = math.random(125,160),
                    label = "Stock Car Wheel"
                }, {
                    item = "highradio",
                    fiyat = math.random(215,280),
                    label = "Digital Radio"
                }, {
                item = "highrim",
                fiyat = math.random(260,320),
                label = "Quality Vehicle Wheel"
                }, {
                item = "kapi",
                fiyat = math.random(50,95),
                label = "Vehicle Door"
            },
            {
                item = "speaker",
                fiyat = math.random(120,160),
                label = "Speaker"
            },
            }
        },
        ["kokainalici"] = {
            spawned = false,
            isim = "Highway Sam",
            pedmodel = 0x0B8D69E3,
            konum = {
                x = 1545.16, 
                y = 2226.22,
                z = 77.648,
                h = 179.99952697754
            },
            dict = "amb@lo_res_idles@",
            anim = "world_human_lean_female_holding_elbow_lo_res_base",
                icerik = {
                {
                    item = "coke_brick",
                    fiyat =  math.random(1600,3500),
                    label = "Wrap Cocaine (500gr)"
                }, 
            }
        },
        ["otalici"] = {
            spawned = false,
            isim = "Marijuana Snow",
            pedmodel = 0x6C19E962,
            konum = {
                x = 1412.975, 
                y = 3663.893,
                z = 34.448,
                h = 295.99952697754
            },
            dict = "amb@lo_res_idles@",
            anim = "world_human_lean_female_holding_elbow_lo_res_base",
                icerik = {
                {
                    item = "weedplant_packedweed",
                    fiyat =  math.random(1250,3000),
                    label = "Packed Herb",
                },
            }
        },
    -- else
    --     exports["elixir-base"]:peddelete("sellnpc-" .. k)
    --     QBCore.Functions.Notify('Bana cidden polis mi getirdiniz gerizekalılar??', 'error', 7500)
    -- end
}


local gececikacaklar = {
    ["31"] = {
        spawned = false,
        isim = "Marijuana Snow",
        pedmodel = 0x89768941,
        konum = {
            x = 3313.02,  
            y = 5175.09,
            z = 19.448,
            h = 326.99952697754
        },
        dict = "amb@lo_res_idles@",
        anim = "world_human_lean_female_holding_elbow_lo_res_base",
    },
-- else
--     exports["elixir-base"]:peddelete("sellnpc-" .. k)
--     QBCore.Functions.Notify('Bana cidden polis mi getirdiniz gerizekalılar??', 'error', 7500)
-- end
}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if GetClockHours() > 21 or GetClockHours() < 8 then
            for k, value in pairs(gecePeds) do
                if not value.spawned then
                    value.spawned = true

                    exports["elixir-base"]:pedcreate("sellnpc-" .. k, value.pedmodel, value.konum.x, value.konum.y,
                        value.konum.z - 1, value.konum.h, value.dict, value.anim)

                    exports["qb-target"]:AddBoxZone("sellnpc-" .. k,
                        vector3(value.konum.x, value.konum.y, value.konum.z), 0.6, 0.6, {
                            name = "sellnpc-" .. k,
                            debugPoly = false,
                            useZ = true,
                            minZ = value.konum.z - 1,
                            maxZ = value.konum.z + 1
                        }, {
                            options = {{
                                event = "sellnpc:main",
                                icon = "fas fa-circle",
                                label = value.isim,
                                args = value.icerik
                            }},
                            job = {"all"},
                            distance = 2.0,
                            spritecoord = vector3(value.konum.x, value.konum.y, value.konum.z)
                        }
                    )
                end
            end
        else
            for k, v in pairs(gecePeds) do
                if v.spawned then
                    v.spawned = false
                    exports["elixir-base"]:peddelete("sellnpc-" .. k)
                end
            end
        end

        Wait(sleep)
    end
end)


Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if GetClockHours() > 21 or GetClockHours() < 8 then
            for k, value in pairs(gececikacaklar) do
                if not value.spawned then
                    value.spawned = true

                    exports["elixir-base"]:pedcreate("otuzbir-" .. k, value.pedmodel, value.konum.x, value.konum.y,
                    value.konum.z - 1, value.konum.h, value.dict, value.anim)

                end
            end
        else
            for k, v in pairs(gececikacaklar) do
                if v.spawned then
                    v.spawned = false
                    exports["elixir-base"]:peddelete("otuzbir -" .. k)
                end
            end
        end

        Wait(sleep)
    end
end)


local thermite = 1
local inmenu = false
RegisterNetEvent("ra1derSellNpc:setpeds", function(ped)
    peds = ped
    for key, value in pairs(peds) do
        if value.dict then
            exports["elixir-base"]:pedcreate("sellnpcs-"..key, value.pedmodel, value.konum.x, value.konum.y, value.konum.z - 1, value.konum.h, value.dict, value.anim)
        else
            exports["elixir-base"]:pedcreate("sellnpcs-"..key, value.pedmodel, value.konum.x, value.konum.y, value.konum.z - 1, value.konum.h)
        end
    end
    for k, v in pairs(peds) do
        exports["qb-target"]:AddBoxZone("sellnpc-"..k, vector3(v.konum.x, v.konum.y, v.konum.z), 0.6, 0.6, {
            name="sellnpc-"..k,
            debugPoly=false,
            useZ=true,
            minZ=v.konum.z - 1,
            maxZ=v.konum.z + 1,
            }, {
                options = {
                    {
                        event = "sellnpc:main",
                        icon = "fas fa-circle",
                        label = v.isim,
                        args = v.icerik,
                    },
                },
                job = {"all"},
                distance = 2.0,
                spritecoord = vector3(v.konum.x, v.konum.y, v.konum.z),
            }
        )
    end
end)


Citizen.CreateThread(function()
    TriggerServerEvent("ra1derSellNpc:onLoad")
end)

RegisterNetEvent("sellnpc:main", function(data)
    icerik = data.args
    contextdata = {
        {header = data.label, isMenuHeader = true, icon = "fas fa-person"}
    }
    for k, v in pairs(icerik) do
        
        table.insert(contextdata, {header = v.label, txt = v.fiyat .. "$ (Adet)", icon = "fas fa-dollar-sign", params = {
            event = "ra1derSellNpc:client:openDialog",
            args =  {
                item = v.item,
                fiyat = v.fiyat,
            },
        }})

    end

    exports["qb-menu"]:openMenu(contextdata)
end)
local animasyon = false
RegisterNetEvent('animasyon')
AddEventHandler('animasyon', function()
	local Ped = PlayerPedId()
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while animasyon do
        TaskPlayAnim(Ped, "mp_common", "givetake1_b", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(2500)
		ClearPedTasks(Ped)
        TaskPlayAnim(Ped, "mp_common", "givetake1_b", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(2500)
		ClearPedTasks(Ped)
	end
	ClearPedTasks(Ped)
end)


RegisterNetEvent("ra1derSellNpc:client:openDialog", function(data)
    fiyat = data.fiyat
    item = data.item

    if item == "televizyon" then
        TriggerServerEvent("ra1derSellNpc:server:Trade", item, 1, fiyat, QBCore.Key)
        return 
    end
    
    local keyboard = exports['qb-input']:ShowInput({
        header = "How Many Do You Want To Sell?",
        submitText = "Sat",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                text = "Enter Number",
                name = 'input',
            }
        }
    })
        if keyboard then
            keyboard = keyboard.input
            keyboard = tonumber(keyboard)
            if keyboard <= 0  then
                QBCore.Functions.Notify("Incorrect value.", "error")
            else
                QBCore.Functions.TriggerCallback("ra1derSellNpc:ItemCheck", function(check)
                    if check then 
                        animasyon = true
                        TriggerEvent("animasyon")
                        QBCore.Functions.Progressbar('name', 'The Sale Is Occurring', 3500 * keyboard, false, false, { -- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = '',
                            anim = '',
                            flags = 16,
                        }, {}, {}, function() -- Play When Done
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[item], 'remove')
                            TriggerServerEvent("ra1derSellNpc:server:Trade", item, keyboard, fiyat, QBCore.Key)
                            animasyon = false
                            ClearPedTasks(PlayerPedId())
                        end)
                    else
                        QBCore.Functions.Notify('Theres not enough of an item to sell!', 'error', 7500)
                    end
                end, item, keyboard) 
            end
        else
            QBCore.Functions.Notify('You Didnt Enter a Value.', 'error', 7500)
        end
    
end)
