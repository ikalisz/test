local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local DealerPed = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

local gececikacaklar = {
    ["31"] = {
        spawned = false,
        pedmodel = 0x6C19E962,
        konum = { 
            x = 3310.76,  
            y =  5176.3,
            z = 19.61,
            h = 233.99952697754
        },
    },
}


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
                    exports["elixir-base"]:peddelete("otuzbir-" .. k, v.pedmodel, v.konum.x, v.konum.y,
                    v.konum.z - 1, v.konum.h, v.dict, v.anim)
                end
            end
        end

        Wait(sleep)
    end
end)


CreateThread(function()
        exports['qb-target']:AddBoxZone("karadayi", vector3(3310.76, 5176.32, 19.61), 0.6, 0.8, {
            heading=233.2,
            debugPoly = false,
            minZ=18.0,
            maxZ=20.66
        }, {
            options = {
                {
                    type = "client",
                    action = function()
                        openMenu()
                    end,
                    icon = "fas fa-comment",
                    label = "Talk to the mysterious man",
                },
            },
            job = {"all"},
            distance = 2.2
        })
end)

function openMenu()
    local hours = GetClockHours()
        local menu = {
            {
                header = Lang:t('menu.header'),
                icon = 'fa-solid fa-shop',
                isMenuHeader = true,
            },
            {
                header = Lang:t('menu.orderHeader'),
                txt = Lang:t('menu.orderTxt'),
                icon = 'fas fa-box-open',
                params = {
                    event = 'ra1derBlackShipment:openShop'
                }
            },
            {
                header = Lang:t('menu.finalHeader'),
                txt = Lang:t('menu.finalTxt'),
                icon = 'fas fa-list',
                params = {
                    event = 'ra1derBlackShipment:getShipment'
                }
            }
        }
        exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('ra1derBlackShipment:openShop')
AddEventHandler('ra1derBlackShipment:openShop', function()
    local menu = {
        {
            header = Lang:t('shop.header'),
            txt = Lang:t('shop.txt'),
            icon = 'fas fa-tools',
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Items) do
        menu[ #menu + 1 ] = {
            header = v.label,
            txt = '<span style="color:#50bb46; font-weight: bold;">'..v.price..'$</span> '..Lang:t('shop.price'),
            icon = v.icon,
            params = {
                event = 'ra1derBlackShipment:checkItem',
                args = {
                    rare = v.rare or Config.Chance, 
                    time = v.time or Config.DeliveryTime, 
                    item = v.hash,
                    label = v.label,
                    price = v.price,
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

AddEventHandler('ra1derBlackShipment:checkItem', function(args)
    local input = exports['qb-input']:ShowInput({
        header = "How Many Pieces Do You Want To Buy?",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Approve'
            },
        },
    })
    local count = input.amount or 1 
    local price = args.price * count 
    TriggerServerEvent('ra1derBlackShipment:MakeShipment', args.item, args.label, count, price, args.rare, args.time * count)
end)

RegisterNetEvent("progressbar", function()
    QBCore.Functions.Progressbar('name', 'Giving Money...', 3000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
}, {
    animDict = 'mp_common',
    anim = 'givetake1_b',
    flags = 16,
}, {}, {}, function() -- Play When Done
    end)
end)

RegisterNetEvent('ra1derBlackShipment:getShipment')
AddEventHandler('ra1derBlackShipment:getShipment', function()
    QBCore.Functions.TriggerCallback('ra1derBlackShipment:getTime', function(time)
        QBCore.Functions.TriggerCallback('ra1derBlackShipment:getAllShipments', function(items)
            local menu = {
                {
                    header = Lang:t('shipment.header'),
                    txt = Lang:t('shipment.txt'),
                    icon = 'fas fa-box-open',
                    isMenuHeader = true
                }
            }
            for i = 1, #items, 1 do
                times = time - items[i].time
                local dtime = items[i].sure or Config.DeliveryTime
                if times <= dtime then
                    menu[ #menu + 1 ] = {
                        header = items[i].label,
                        icon = 'fas fa-tools',
                        txt = (dtime - times)..' '..Lang:t('shipment.timeTxt'),
                        disabled = true
                    }
                end

                if times >= dtime then
                    menu[ #menu + 1 ] = {
                        header = items[i].label..' | '..items[i].price..'$',
                        txt = Lang:t('shipment.takeTxt'),
                        icon = 'fas fa-hourglass-start',
                        params = {
                            event = 'ra1derBlackShipment:checkStatus',
                            args = {
                                id = items[i].id
                            }
                        }
                    }
                end
            end
            exports['qb-menu']:openMenu(menu)
        end)
    end)
end)

AddEventHandler('ra1derBlackShipment:checkStatus', function(id)
    QBCore.Functions.TriggerCallback('ra1derBlackShipment:GetAllItems', nil, id.id)
end)