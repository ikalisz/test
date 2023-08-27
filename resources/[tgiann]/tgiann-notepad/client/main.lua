local isUiOpen = false 
local prop, secondaryprop = nil
local object = 0
local TestLocalTable = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

function startAnim()
    local player = PlayerPedId()
    local ad = "missheistdockssetup1clipboard@base"
    local prop_name = 'prop_notepad_01'
    local secondaryprop_name = 'prop_pencil_01'
    
    if DoesEntityExist(player) and not IsEntityDead(player) then 
        loadAnimDict(ad)
        local x,y,z = table.unpack(GetEntityCoords(player))
        prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
        secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
        AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- lkrp_notepadpad
        AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
        TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )      
    end
end

function stopAnim()
    TaskPlayAnim(player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(prop, 1, 1)
    DeleteObject(prop)
    DetachEntity(secondaryprop, 1, 1)
    DeleteObject(secondaryprop)
end

RegisterNUICallback('escape', function()
    QBCore.Functions.Notify("You Torn the Note Paper")
    TriggerEvent("lkrp_notepad:CloseNotepad")
end)

RegisterNUICallback('droppingEmpty', function()
    TriggerEvent("lkrp_notepad:CloseNotepad")
end)

RegisterNUICallback('updating', function(data)
    local text = data.text
    local id = data.id
    TriggerServerEvent("server:saveNote", id, text)
    TriggerEvent("lkrp_notepad:CloseNotepad")
end)

RegisterNUICallback('dropping', function(data, cb)
    local text = data.text
    local location = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("server:saveNewNote", text)
    TriggerEvent("lkrp_notepad:CloseNotepad")
end)

RegisterNetEvent("lkrp_notepad:CloseNotepad")
AddEventHandler("lkrp_notepad:CloseNotepad", function()
    stopAnim()
    SendNUIMessage({action = 'closeNotepad'})
    --SetPlayerControl(PlayerId(), 1, 0)
    isUiOpen = false
    SetNuiFocus(false, false); 
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('lkrp_notepad:updateNotes')
AddEventHandler('lkrp_notepad:updateNotes', function(serverNotesPassed)
    TestLocalTable = serverNotesPassed
end)

RegisterNetEvent('lkrp_notepad:openNoteMenu')
AddEventHandler('lkrp_notepad:openNoteMenu', function(result)
    startAnim()
    local elements = {}
    if result[1] then
        table.insert(elements, {label = "My Notes", value = "notlarim", data = result})
    end
    table.insert(elements, {label = "Write a New Note", value = "not_yaz"})

    --QBCore.UI.Menu.CloseAll()
    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'not_menu',
    {
        title    = 'My Notes',
        align    = 'top-left',
        elements = elements
    },function(data, menu)
        if data.current.value == "notlarim" then
            notlarim(data.current.data)
        elseif data.current.value == "not_yaz" then
            if not isUiOpen then
                menu.close()
                openGui()
            end
        end
    end,function(data, menu)
        menu.close()
        stopAnim()
    end)
end)

function openGui() 
    --SetPlayerControl(PlayerId(), 0, 0)
    SendNUIMessage({action = 'openNotepad'})
    isUiOpen = true
    SetNuiFocus(true, true)
end

function notlarim(notlar) 
    local elements = {}
    for id, text in pairs(notlar) do
        if string.len(text.yazi) <= 35 then
            table.insert(elements, {label = text.yazi , text = text.yazi, id = text.id})
        else
            table.insert(elements, {label = string.sub(text.yazi, 1, 35) .. "..." , text = text.yazi, id = text.id})
        end
    end

    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'kayitli_notlar',
    {
        title    = 'My Notes',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        notIslemMenu(data.current.text, data.current.id)
    end, function(data, menu)
        menu.close()
    end)
end

function notIslemMenu(yazi, id) 
    local elements = {}
    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'not_islem_menu',
    {
        title    = 'My Notes',
        align    = 'top-left',
        elements = {
            {label = "Read / Edit", value = "oku-duzenle"},
            {label = "Delete Note", value = "sil"},
            {label = "Paste and Give Note to Nearby", value = "kopyala"},
        }
    }, function(data, menu)
        QBCore.UI.Menu.CloseAll()
        if data.current.value == "oku-duzenle" then
            openGuiRead(yazi, id)
        elseif data.current.value == "sil" then
            TriggerServerEvent("server:deleteNote", id)
            stopAnim()
        elseif data.current.value == "kopyala" then
            local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent("server:kopyala", GetPlayerServerId(closestPlayer), yazi)
                QBCore.Functions.Notify("You gave the note to someone close to you!")
            else
                QBCore.Functions.Notify("No One Near!", "error")
            end
            stopAnim()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function openGuiRead(text, id)
    local veh = GetVehiclePedIsUsing(PlayerPedId())
    --SetPlayerControl(PlayerId(), 0, 0)
    isUiOpen = true
    SendNUIMessage({
        action = 'openNotepadRead',
        TextRead = text,
        Id = id
    })
    SetNuiFocus(true, true)
end