local Vehicles = {}
local Araclarim = {}
local ToplamPara = 5

function vergiKontrol()
    QBCore.Functions.TriggerCallback('elixir-base:araclarim', function(data)
		Araclarim = data
        for category, cars in pairs(QBCore.Shared.Vehicles) do
			for x, car in pairs(cars) do
                table.insert(Vehicles, {hash = x, price = car.price})
                for xx, yy in pairs(Araclarim) do
                    if GetHashKey(car.model) == json.decode(yy.vehicle).model then
                        ToplamPara = ToplamPara + (car.price/100) * 0.02
                    end
                end
            end
        end
        TriggerEvent("elixir-base:araclarim", Araclarim, Vehicles)
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if playerLoaded then
            Citizen.Wait(5000000)
            QBCore.Functions.TriggerCallback('esx_billing:getBills', function(bills)
                local faiz = 0
                for i=1, #bills, 1 do
                    if bills[i].label ~= "Araç Vergisi" then
                        faiz = faiz + (bills[i].amount/100) * 1
                    end
                end
    
                if ToplamPara == 0 and faiz > 0 then
                    QBCore.Functions.Notify("Accommodation and Unpaid Invoices Taxed. $" .. ToplamPara + faiz)
                elseif ToplamPara > 0 and faiz == 0 then
                    QBCore.Functions.Notify("Vehicle Tax Arrived $" .. ToplamPara)
                elseif ToplamPara > 0 and faiz > 0 then
                    QBCore.Functions.Notify("Vehicle and Unpaid Invoices Taxed $" .. ToplamPara + faiz)
                end
                TriggerServerEvent('esx_billing:aracvergi', GetPlayerServerId(PlayerId()), 'devlet', "Vergi", ToplamPara + faiz)
            end)
        end
	end
end)

RegisterNetEvent('elixir-base:vergi-ekle')
AddEventHandler('elixir-base:vergi-ekle', function(ekstra)
    ToplamPara = ToplamPara + ekstra
    TriggerServerEvent("tgiann-police:put-money", ToplamPara + ekstra)
end)