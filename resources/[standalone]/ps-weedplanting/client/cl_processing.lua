--- Events

RegisterNetEvent('ps-weedplanting:client:UseBranch', function()
            QBCore.Functions.Progressbar('weedbranch', "Esrar Dalları Ayıklanıyor", 4000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 16,
            }, {}, {}, function() -- Done
                TriggerServerEvent('ps-weedplanting:server:ProcessBranch')
                ClearPedTasksImmediately(PlayerPedId())
            end, function() -- Cancel
                QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
            end)
end)

RegisterNetEvent('ps-weedplanting:client:UseDryWeed', function()
    QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
        if qtty > 0 then
            QBCore.Functions.Progressbar('dryweed', "Esrarlar Poşetleniyor", 5000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 16,
            }, {}, {}, function() -- Done
                TriggerServerEvent('ps-weedplanting:server:PackageWeed')
                TriggerServerEvent('QBCore:Server:RemoveItem', "poset", 1)
                ClearPedTasksImmediately(PlayerPedId())
            end, function() -- Cancel
                QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
            end)
        else
            QBCore.Functions.Notify("Poşetin Yok", 'error', 2500)
        end
    end, "poset")
end)
