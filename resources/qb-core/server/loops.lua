RegisterServerEvent("qb-core:save-all-data")
AddEventHandler('qb-core:save-all-data', function()
    saveCars()
    saveJobMoney()
    TriggerEvent("vehiclemod:server:saveAllData")
end)

-- Meslek kasaları data kontrol ve kayıt
Citizen.CreateThread(function() 
    exports.oxmysql:execute('SELECT * FROM jobs_accounts', {
    }, function(result)
        for i=1, #result do 
            local job = result[i].job
            local gradeMoney = json.decode(result[i].grademoney)
            if QBCore.Shared.Money[job] then
                setJobMoney(job, result[i].money)
                for x=1, #gradeMoney do 
                    setJobGradePayment(job, x, gradeMoney[x])
                end
            end
        end
    end)

    while true do
        Citizen.Wait(60000 * 5)
        saveJobMoney()
    end
end)

function saveJobMoney()
    for job, money in pairs(QBCore.Shared.Money) do 
        if QBCore.Shared.Jobs[job] then
            local gradeAndMoney = {}
            for level, grade in pairs(QBCore.Shared.Jobs[job].grade) do 
                gradeAndMoney[level] = tonumber(grade.payment)
            end

            exports.oxmysql:execute("UPDATE jobs_accounts SET money = @money, grademoney = @grademoney WHERE job = @job", {
                ['@job'] = job,
                ['@money'] = money,
                ['@grademoney'] = json.encode(gradeAndMoney)
            }, function(result)
                if result.affectedRows == 0 then
                    exports.oxmysql:execute('INSERT INTO jobs_accounts (money, job, grademoney) VALUES (@money, @job, @grademoney)', {
                        ['@job'] = job,
                        ['@money'] = money,
                        ['@grademoney'] = json.encode(gradeAndMoney)
                    })
                end
            end)
        end
    end
 --   print("\x1b[32m["..GetCurrentResourceName()..":LOG]\x1b[0m TUM MESLEK KASALARI KAYIT EDILDI")
end

-- Galeri araç sayısı data kontrol ve kayıt
Citizen.CreateThread(function() 
    exports.oxmysql:execute('SELECT * FROM tgiann_vehicleshop', {
    }, function(result)
        if result[1] then
            for category, data in pairs(json.decode(result[1].data)) do 
                if QBCore.Shared.Vehicles[category] then
                    for car, cCount in pairs(data) do
                        if QBCore.Shared.Vehicles[category][tonumber(car)] then
                            QBCore.Shared.Vehicles[category][tonumber(car)]["count"] = cCount
                        end
                    end
                end
            end
        else
            saveCars()
        end
    end)
 
    while true do
        Citizen.Wait(60000 * 30)
        saveCars()
    end
end)

function saveCars()
    local newData = {}
    for category, data in pairs(QBCore.Shared.Vehicles) do
        newData[category] = {}
        for car, cData in pairs(data) do
            newData[category][car] = cData.count
        end
    end

    exports.oxmysql:execute("UPDATE tgiann_vehicleshop SET data = @data", {
        ['@data'] = json.encode(newData),
    }, function(result)
        if result.affectedRows == 0 then
            exports.oxmysql:execute('INSERT INTO tgiann_vehicleshop (data) VALUES (@data)', {
                ['@data'] = json.encode(newData),
            })
        end
    end)

  --  print("\x1b[32m["..GetCurrentResourceName()..":LOG]\x1b[0m TUM GALERI ARAC SAYISI KAYIT EDILDI")
end

RegisterServerEvent("qb-core:set-car-count")
AddEventHandler('qb-core:set-car-count', function(category, sCarHash, count)
    QBCore.Shared.Vehicles[category][sCarHash].count = count
end)