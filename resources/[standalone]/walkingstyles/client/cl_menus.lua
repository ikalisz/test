local QBCore = exports['qb-core']:GetCoreObject()

-- Walk Styles Menu --
RegisterNetEvent('xt-walkstyles:client:Menu', function()
    local walkStyles = {}
        walkStyles[#walkStyles+1] = {
            header = 'Walkstyles',
            icon = "fas fa-info",
            params = {
                isServer = true,
                event = 'xt-walkstyles:server:GetWalkStyle',
            }
        }

        for r = 1, #Config.Styles, 1 do
            walkStyles[#walkStyles+1] = {
                header = Config.Styles[r].name,
                icon = "fas fa-circle",
                params = {
                    event = 'xt-walkstyles:client:SetWalkStyle',
                    args = Config.Styles[r].value
                }
            }
        end

        walkStyles[#walkStyles+1] = {
            header = 'Close Menu',
            icon = "fas fa-times",
            params = {
                event = 'qb-menu:client:closeMenu',
            }
        }

        exports['qb-menu']:openMenu(walkStyles)
end)