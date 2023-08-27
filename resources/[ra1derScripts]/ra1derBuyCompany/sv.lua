local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("ra1der_company:tamamla",function(source,cb,tablo)
    local oyuncu = QBCore.Functions.GetPlayer(source)
    if oyuncu then
        local function islem_tamam(oyuncu)  
            local ucret = tablo.deger == "hafta" and tablo.veri.ucret or tablo.deger == "aylik" and tablo.veri.ucret * 4
            if oyuncu.Functions.RemoveMoney("bank", ucret) then
                exports[Config.SqlType]:execute("INSERT INTO ra1der_company (job,cid,deger,time) VALUES(@j,@c,@d,@t)",{
                    ['@j'] = tablo.veri.job,
                    ['@c'] = oyuncu.PlayerData.citizenid,
                    ['@d'] = tablo.deger,
                    ['@t'] = tostring(os.time())
                })
                oyuncu.Functions.SetJob(tablo.veri.job, Config.StartJobGrade) 
                TriggerEvent('DiscordBot:ToDiscord', 'isletmesatinal', "Player Named ``"..tablo.veri.job.."`` Business Name ``"..tablo.veri.ucret.."$`` with the price ``"..tablo.deger.."`` Rented" , oyuncu.PlayerData.source)
                cb(true)
            else
                cb(false,{
                    message=Config.Text["nomoney"],
                    type="error"
                })
            end
        end
        exports[Config.SqlType]:execute("SELECT * FROM ra1der_company",{},function(result)
            if result and result[1] then
                for k,v in pairs(result) do
                    if v.job == tablo.veri.job then
                        cb(false,{
                            message=Config.Text["renterror"],
                            type="error"
                        })
                        return
                    end
                end
                islem_tamam(oyuncu)
            else
                islem_tamam(oyuncu)
            end
        end)
    end
end)

CreateThread(function()
    while true do Wait(5 * 60 * 1000) --Her 10 dakikada bir
        exports[Config.SqlType]:execute("SELECT * FROM ra1der_company",{},function(result)
            if result then
                for k,v in ipairs(result) do -- Haftalık süre biçimi, aylik süre biçimi
                    local sure = v.deger == "hafta" and (7 * 24 * 60 * 60) or v.deger == "aylik" and (4 * 7 * 24 * 60 * 60)
                    if os.time() - tonumber(v.time) >= sure then
                        local job,grade = Config.FinishJob, Config.FinishJobGrade --
                        exports[Config.SqlType]:execute("DELETE FROM ra1der_company WHERE job=@j AND cid=@c",{
                            ['@j'] = v.job,
                            ['@c'] = v.cid
                        })
                        local oyuncular = QBCore.Functions.GetPlayers()
                        for l,u in pairs(oyuncular) do
                            local oyuncu = QBCore.Functions.GetPlayer(tonumber(u))
                            if oyuncu then
                                if oyuncu.PlayerData.job and oyuncu.PlayerData.job.name == v.job then
                                    oyuncu.Functions.SetJob(job,grade)
                                end
                            end
                        end
                        Wait(2000)
                        exports[Config.SqlType]:execute("SELECT * FROM players",{},function(players)
                            if players then
                                for j,s in ipairs(players) do
                                    s.job = json.decode(s.job)
                                    if s.job and s.job.name == v.job then
                                        exports[Config.SqlType]:execute("UPDATE players SET job=@j WHERE citizenid=@c",{
                                            ['@c'] = s.citizenid,
                                            ['@j'] = json.encode({
                                                gradelabel = QBCore.Shared.Jobs[job].grade[grade].label, -- New QBCore kullanıyorsanız burayı editlemeniz gerekiyor.
                                                grade = grade,
                                                boss = false,
                                                onduty = true,
                                                name = job,
                                                paySafe = false,
                                                label = QBCore.Shared.Jobs[job].label,
                                                payment = QBCore.Shared.Jobs[job].grade[grade].payment
                                            })
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end)
    end 
end)