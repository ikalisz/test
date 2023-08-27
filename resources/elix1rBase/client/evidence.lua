local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterCommand('seks', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end, true)

RegisterNetEvent('wildEvidence:adliDepo')
AddEventHandler('wildEvidence:adliDepo', function()
    if PlayerData.job.name == 'police' then
        local input = exports['qb-input']:ShowInput({
            header = 'Forensic Evidence Depot',
            submitText = 'Login',
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    text = 'Event Log Number',
                    name = 'id',
                }
            }
        })
        local delil = input.id
        QBCore.Functions.Progressbar('name', 'Forensic Evidence Depot Opens', 3500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'missheistdockssetup1clipboard@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- Play When Done
        TriggerEvent("inventory:client:SetCurrentStash", "AdliDelilDepo_"..delil)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "AdliDelilDepo_"..delil)
    end)
    end
end)



RegisterNetEvent('wildEvidence:NormalDepo')
AddEventHandler('wildEvidence:NormalDepo', function()
    if PlayerData.job.name == 'police' then
        local input = exports['qb-input']:ShowInput({
            header = 'Normal Evidence Depot',
            submitText = 'Login',
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    text = 'Event Log Number',
                    name = 'id',
                }
            }
        })
        local normaldelil = input.id
        QBCore.Functions.Progressbar('name', 'Evidence Depot Opens', 3500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'missheistdockssetup1clipboard@base',
            anim = 'base',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            --Stuff goes here
            TriggerEvent("inventory:client:SetCurrentStash", "NormalDelilDepo_"..normaldelil)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "NormalDelilDepo_"..normaldelil) 
        end)
    end
end)


RegisterNetEvent("wildEvidence:OpenMenu", function()
    exports['qb-menu']:openMenu({
		{
            header = "Evidence Store Transactions",
            icon = "fas fa-exclamation-circle",
            isMenuHeader = true
        },
        {
            header = "Open Forensic Evidence Depot",
            icon = "fas fa-archive",
            -- txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Kimliğini İncele",
			isServer = false,
            params = {
                event = "wildEvidence:adliDepo",
            }
        },
        {
            header = "Open Normal Evidence Store",
            icon = "fas fa-archive",
            -- txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Kimliği Yakınındakine Ver",
			isServer = false,
            params = {
                event = "wildEvidence:NormalDepo",
            }
        },
        {
            header = "Close Menu",
            icon = "fas fa-times",
            -- txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Silah Ruhsatını Yakınıdaki Kişiye Ver",
			isServer = false,
            params = {
				event = "qb-menu:closeMenu",
            }
        },
    })
end)