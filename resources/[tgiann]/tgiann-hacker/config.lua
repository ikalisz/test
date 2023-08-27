Config                            = {}
Config.Locale                     = 'tr'

Config.PolisiAra           = true -- Hack sonrası polis alarmını aktif etmek için true ayarlayın
Config.PolisiAramaYuzdesi    = 1 -- 1=100%, 2=50%, 3=33%, 4=25%, 5=20%.
Config.PolisSayisi = 2
Config.HackSure = 0

-- Distance (in meters) displayed at MaxRings
mtracker_MaxDistance = 3000
-- MaxRings to scale the display
mtracker_MaxRings = 6
-- Key to Close the App, currently: ESC
mtracker_StoppingKey = 322
-- ScalingTypes
-- "SQRT": Scale distance with Square Root
-- "LOG": Scale distance logarithmically
-- "LIN": Scale distance linearily
mtracker_ScalingType = "SQRT"

Config.V1OrtaGerekenSayi = 100 -- V1 Orta Seviye Hack İçin Gereken Sayı
Config.V1ZorGerekenSayi = 200 -- V1 Zor Seviye Hack İçin Gereken Sayı

Config.pcHack = 220 -- V1 Zor Seviye Hack İçin Gereken Sayı

Config.zones = {	
    ["hdisari"] = {
        type = 21,  
        coords = vector3(2154.5373535156, 2921.189453125, -81.075477600098),
        color = vector3(255, 0, 0),
        to = vector3(-2222.6262207031, 304.15417480469, 174.60171508789),
        text = "Get out "
    },

    ["hiceri"] = {
        type = 21,  
        coords = vector3(-2222.6262207031, 304.15417480469, 174.60171508789),
        color = vector3(255, 0, 0),
        to = vector3(2154.5373535156, 2921.189453125, -81.075477600098),
        text = "Come in "
    },
}