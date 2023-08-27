
local QBCore = exports['qb-core']:GetCoreObject()

BackItems = {
    ["weapon_specialcarbine_mk2"] = {
        model="w_ar_scar",
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = 0.15,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_mk18b"] = {
        model="w_ar_mk18b",
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_heavysniper"] = {
        model="w_sr_heavysniper",
        back_bone = 24818,
        x = -0.2,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_sniperrifle"] = {
        model="w_sr_m24",
        back_bone = 24818,
        x = -0.2,
        y = -0.17,
        z = -0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_katana"] = {
        model="w_me_katana",
        back_bone = 24818,
        x = 0.35,
        y = -0.25,
        z = 0.3,
        x_rotation = 225.0,
        y_rotation = 8.0,
        z_rotation = 90.0,
    },
    ["weapon_bats"] = {
        model="w_me_baseball_bat_metal",
        back_bone = 24818,
        x = 0.35,
        y = -0.25,
        z = 0.3,
        x_rotation = 225.0,
        y_rotation = 8.0,
        z_rotation = 90.0,
    },
    ["weapon_bat"] = {
        model="w_me_keyboard",
        back_bone = 24818,
        x = -0.2,
        y = -0.17,
        z = -0.3,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_katanas"] = {
        model="w_me_katana_lr",
        back_bone = 24818,
        x = 0.01,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 120.0,
        z_rotation = 0.0,
    },
    ["weapon_combatpdw"] = {
        model="w_sb_mpx",
        back_bone = 24818,
        x = -0.10,
        y = -0.20,
        z = -0.20,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_compactrifle"] = {
        model="w_ar_draco",
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = 0.05,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_m4"] = {
        model="w_ar_M4", 
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = -0.05,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_m14"] = {
        model="w_sr_m14", 
        back_bone = 24818,
        x = -0.05,
        y = -0.17,
        z = 0.05,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_dragunov"] = {
        model="w_sr_dragunov", 
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = -0.0001,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_assaultrifle"] = {
        model="w_ar_assaultrifle", 
        back_bone = 24818,
        x = 0.0,
        y = -0.14,
        z = 0.05,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_assaultrifle2"] = {
        model="w_ar_assaultrifle2", 
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_gepard"] = {
        model="w_ar_gepard", 
        back_bone = 24818,
        x = 0.1,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_microsmg2"] = {
        model="w_sb_uzi", 
        back_bone = 24818,
        x = 0.1,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_smg"] = {
        model="w_sb_mp5", 
        back_bone = 24818,
        x = 0.1,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_smg_mk2"] = {
        model="W_SB_SMGMk2", 
        back_bone = 24818,
        x = 0.1,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_microsmg3"] = {
        model="w_sb_microsmg3", 
        back_bone = 24818,
        x = 0.1,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["weapon_advancedrifle"] = {
        model="w_ar_groza", 
        back_bone = 24818,
        x = 0.1,
        y = -0.17,
        z = 0.1,
        x_rotation = 180.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },
    ["coke_brick"] = {
        model="bkr_prop_coke_cutblock_01", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 90.0,
    },
    ["weed_bud"] = {
        model="bkr_prop_weed_drying_01a", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["weapon_machete"] = {
        model="w_me_machette_lr", 
        back_bone = 24817,
        x = 0.01,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 120.0,
        z_rotation = 0.0,
    },
}


local CurrentBackItems = {}
local TempBackItems = {}
local checking = true
local currentWeapon = nil
local slots = 30
local s = {}


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
    BackLoop()
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
    resetItems()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(5000)
    TriggerEvent("backitems:loop")
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    resetItems()
end)

RegisterNetEvent("backitems:displayItems", function(toggle)
    if toggle then 
        for k,v in pairs(TempBackItems) do 
            createBackItem(k)
        end
        BackLoop()
    else 
        TempBackItems = CurrentBackItems
        checking = false
        for k,v in pairs(CurrentBackItems) do
            removeBackItem(k)
        end
        CurrentBackItems = {}
    end
end)

function resetItems()
    removeAllBackItems()
    CurrentBackItems = {}
    TempBackItems = {}
    currentWeapon = nil
    s = {}
    checking = false
end

function BackLoop()
    print("[Backpacks]: Started")
    checking = true
    CreateThread(function()
        while checking do
            local player = QBCore.Functions.GetPlayerData()
            while player == nil do 
                player = QBCore.Functions.GetPlayerData()
                Wait(500)
            end
            for i = 1, slots do
                s[i] = player.items[i]
            end
            check()
            Wait(1000)
        end
    end)
end

function check()
    for i = 1, slots do
        if s[i] ~= nil then
            local name = s[i].name
            if BackItems[name] then
                if name ~= currentWeapon then
                    createBackItem(name)
                end
            end
        end
    end

    for k,v in pairs(CurrentBackItems) do 
        local hasItem = false
        for j = 1, slots do
            if s[j] ~= nil then
                local name = s[j].name
                if name == k then 
                    hasItem = true
                end
            end
        end
        if not hasItem then 
            removeBackItem(k)
        end
    end
end


function createBackItem(item)
    if not CurrentBackItems[item] then
        if BackItems[item] then 
            local i = BackItems[item]
            local model = i["model"]
            local ped = PlayerPedId()
            local bone = GetPedBoneIndex(ped, i["back_bone"])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(10)
            end
            SetModelAsNoLongerNeeded(model)
            CurrentBackItems[item] = CreateObject(GetHashKey(model), 1.0, 1.0, 1.0, true, true, false)   
            AttachEntityToEntity(CurrentBackItems[item], ped, bone, i["x"], i["y"], i["z"], i["x_rotation"], i["y_rotation"], i["z_rotation"], false, false, false, false, 2, true)
        end
    end
end

function removeBackItem(item)
    if CurrentBackItems[item] then
        DeleteEntity(CurrentBackItems[item])
        CurrentBackItems[item] = nil
    end
end

function removeAllBackItems()
    for k,v in pairs(CurrentBackItems) do 
        removeBackItem(k)
    end
end

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weap, shootbool)
    if weap == nil then
        createBackItem(currentWeapon)
        currentWeapon = nil
    else
        if currentWeapon ~= nil then  
            createBackItem(currentWeapon)
            currentWeapon = nil
        end
        currentWeapon = tostring(weap.name)
        removeBackItem(currentWeapon)
    end
end)

RegisterNetEvent("backitems:loop")
AddEventHandler("backitems:loop", function()
    BackLoop()
end)