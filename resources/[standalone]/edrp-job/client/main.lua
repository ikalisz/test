
local blip, bussy = false, false
local aktifblipler = true

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local jobs = {
    -- --  ["balon-biligi"] = {
    -- --     ["blip"] = {
    -- --         ["sprite"] = 465,
    -- --         ["scale"] = 0.7,
    -- --         ["colour"] = 36,
    -- --         ["text"] = "Balon Balığı Toplama",
    -- --     },
    -- --     ["item"] = { -- oran düşükten yükseğe yazılmalı, Oranı olmayan eşyların oranı 100 yazılmalı, Birden fazla 100 oranlı item yazılamaz her item'ın kendine ait bir oranı olmalı
    -- --         {
    -- --             ["item"] = "gold",
    -- --             ["oran"] = 10,
    -- --             ["maxRandomItemCount"] = 3
    -- --         },
    -- --         {
    -- --             ["item"] = "hamburger",
    -- --             ["oran"] = 20,
    -- --             ["maxRandomItemCount"] = 2
    -- --         },
    -- --         {
    -- --             ["item"] = "rolex",
    -- --             ["oran"] = 100,
    -- --             ["maxRandomItemCount"] = 1
    -- --         },
    -- --     },
    -- --     ["selectedCoords"] = 1,
    -- --     ["e"] = "Balon Balığı",
    -- --     ["markerSetting"] = {
    -- --         ["r"] = 32,
    -- --         ["g"] = 245,
    -- --         ["b"] = 254,
    -- --         ["size"] = 0.5,
    -- --         ["3dTextZ"] = 0.5
    -- --     },
    -- --     ["anim"] = {
    -- --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    -- --         ["anim"] = "idle_b",
    -- --         ["flag"] = 33,
    -- --         ["time"] = 5000
    -- --     },
    -- --     ["coords"] = {
    -- --         vector3(380.46,-1033.27,29.3),
    -- --         vector3(373.2,-1033.64,29.3),
    -- --         vector3(365.46,-1032.55,29.3),
    -- --     }
    -- -- },
 

    -- -- Balon Balığı Toplama
    -- --["balon-biligi"] = {
    -- --     ["blip"] = {
    -- --         ["sprite"] = 465,
    -- --         ["scale"] = 0.7,
    -- --         ["colour"] = 36,
    -- --         ["text"] = "Dalış Noktası",
    -- --     },
    -- --     ["item"] = { -- oran düşükten yükseğe yazılmalı, Oranı olmayan eşyların oranı 100 yazılmalı, Birden fazla 100 oranlı item yazılamaz her item'ın kendine ait bir oranı olmalı
    -- --         {
    -- --             ["item"] = "balon_baligi",
    -- --             ["maxRandomItemCount"] = 2
    -- --         },
    -- --     },
    -- --     ["selectedCoords"] = 1,
    -- --     ["e"] = "Balon Balığı",
    -- --     ["markerSetting"] = {
    -- --         ["r"] = 32,
    -- --         ["g"] = 245,
    -- --         ["b"] = 254,
    -- --         ["size"] = 2.0,
    -- --         ["3dTextZ"] = 1.2
    -- --     },
    -- --     ["anim"] = {
    -- --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    -- --         ["anim"] = "idle_b",
    -- --         ["flag"] = 33,
    -- --         ["time"] = 5000
    -- --     },
    -- --     ["coords"] = {
    -- --         vector3(-1751.2479248047, -1495.8702392578, -21.358478546143),
    -- --         vector3(-1748.3231201172, -1502.2203369141, -21.358478546143),
    -- --         vector3(-1756.1665039062, -1504.7178955078, -20.539482116699),
    -- --         vector3(-1753.2749023438, -1513.8489990234, -20.539482116699),
    -- --         vector3(-1745.3856201172, -1515.8615722656, -20.539482116699),
    -- --         vector3(-1745.0816650391, -1497.3458251953, -22.051475524902),
    -- --         vector3(-1766.4575195312, -1524.1264648438, -19.846485137939),
    -- --         vector3(-1773.3709716797, -1519.8618164062, -19.846485137939),
    -- --         vector3(-1781.4787597656, -1527.0169677734, -20.287483215332),
    -- --         vector3(-1774.6469726562, -1540.5501708984, -21.043479919434),
    -- --         vector3(-1752.4302978516, -1544.0096435547, -23.752468109131),
    -- --         vector3(-1746.2838134766, -1551.9854736328, -25.390460968018),
    -- --         vector3(-1736.1359863281, -1558.0939941406, -26.272457122803),
    -- --         vector3(-1728.3421630859, -1549.3310546875, -24.508464813232),
    -- --         vector3(-1736.263671875, -1537.1231689453, -23.059471130371),
    -- --         vector3(-1741.1451416016, -1528.1156005859, -22.30347442627),
    -- --     }
    -- -- },

    -- -- Domates Toplama
    -- -- ["domates"] = {
    -- --     ["blip"] = {
    -- --         ["sprite"] = 285,
    -- --         ["scale"] = 0.5,
    -- --         ["colour"] = 2,
    -- --         ["text"] = "Tarla",
    -- --     },
    -- --     ["item"] = { 
    -- --         {
    -- --             ["item"] = "domates",
    -- --             ["maxRandomItemCount"] = 2
    -- --         },
    -- --     },
    -- --     ["selectedCoords"] = 1,
    -- --     ["e"] = "Domates",
    -- --     ["markerSetting"] = {
    -- --         ["r"] = 197,
    -- --         ["g"] = 0,
    -- --         ["b"] = 0,
    -- --         ["size"] = 0.5,
    -- --         ["3dTextZ"] = 0.5
    -- --     },
    -- --     ["anim"] = {
    -- --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    -- --         ["anim"] = "idle_b",
    -- --         ["flag"] = 33,
    -- --         ["time"] = 5000
    -- --     },
    -- --     ["coords"] = {
    -- --         vector3(377.77432250976, 6605.712890625, 28.490282058716),
    -- --         vector3(375.40063476562, 6610.7983398438, 28.505601882935),
    -- --         vector3(377.34619140625, 6625.705078125, 28.629642486572),
    -- --         vector3(377.80267333984, 6632.8115234375, 28.657730102539),
    -- --         vector3(377.69277954102, 6618.7348632812, 28.585145950317),
    -- --         vector3(375.41018676758, 6635.8666992188, 28.649269104004),
    -- --         vector3(382.41009521484, 6642.6865234375, 28.732841491699),
    -- --         vector3(382.49896240234, 6626.6098632812, 28.629238128662),
    -- --         vector3(380.40087890625, 6634.0483398438, 28.627029418945),
    -- --         vector3(377.59478759766, 6641.1694335938, 28.711256027222),
    -- --         vector3(382.58178710938, 6600.9497070312, 28.462621688843),
    -- --         vector3(384.85733032226, 6596.2333984375, 28.411636352539),
    -- --     }
    -- -- },

    -- -- -- Havuc Toplama
    -- -- ["havuc"] = {
    -- --     ["blip"] = {
    -- --         ["sprite"] = 285,
    -- --         ["scale"] = 0.5,
    -- --         ["colour"] = 2,
    -- --         ["text"] = "Tarla",
    -- --     },
    -- --     ["item"] = { 
    -- --         {
    -- --             ["item"] = "havuc",
    -- --             ["maxRandomItemCount"] = 2
    -- --         },
    -- --     },
    -- --     ["selectedCoords"] = 1,
    -- --     ["e"] = "Havuc",
    -- --     ["markerSetting"] = {
    -- --         ["r"] = 254,
    -- --         ["g"] = 133,
    -- --         ["b"] = 0,
    -- --         ["size"] = 0.5,
    -- --         ["3dTextZ"] = 0.5
    -- --     },
    -- --     ["anim"] = {
    -- --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    -- --         ["anim"] = "idle_b",
    -- --         ["flag"] = 33,
    -- --         ["time"] = 5000
    -- --     },
    -- --     ["coords"] = {
    -- --         vector3(571.22393798828, 6484.5825195312, 30.724605560303),
    -- --         vector3(568.24609375, 6480.3017578125, 30.730684280396),
    -- --         vector3(559.86254882812, 6507.46875, 29.782108306885),
    -- --         vector3(568.17687988281, 6508.1303710938, 29.931251525879),
    -- --         vector3(582.84436035156, 6504.7651367188, 29.862661361694),
    -- --         vector3(570.39099121094, 6473.259765625, 30.705951690674),
    -- --         vector3(576.54235839844, 6469.5649414062, 30.624891281128),
    -- --         vector3(581.22674560547, 6472.1923828125, 30.592346191406),
    -- --         vector3(585.05389404297, 6479.607421875, 30.542339324951),
    -- --         vector3(568.82904052734, 6495.7080078125, 30.202474594116),
    -- --         vector3(581.28070068359, 6487.7885742188, 30.414621353149),
    -- --         vector3(574.74615478516, 6493.4833984375, 30.300584793091),
    -- --         vector3(555.89630126953, 6502.0849609375, 29.871101379395),
    -- --         vector3(561.98059082031, 6494.673828125, 30.088703155518),
    -- --         vector3(589.20623779297, 6501.1044921875, 30.030624389648),
    -- --         vector3(576.93463134766, 6504.783203125, 29.791435241699),
    -- --     }
    -- -- },

    -- -- Eski Atık Bölgesi
    -- ["hurda"] = {
    --     ["blip"] = {
    --         ["sprite"] = 465,
    --         ["scale"] = 0.7,
    --         ["colour"] = 36,
    --         ["text"] = "Dalış Noktası",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "plastik",
    --             ["oran"] = 5,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "kum",
    --             ["oran"] = 10,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "midyel",
    --             ["oran"] = 40,
    --             ["maxRandomItemCount"] = 5
    --         },
    --         {
    --             ["item"] = "midyes",
    --             ["oran"] = 70,
    --             ["maxRandomItemCount"] = 5
    --         },
    --         {
    --             ["item"] = "midyem",
    --             ["oran"] = 100,
    --             ["maxRandomItemCount"] = 5
    --         },
            
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Bir Şeyler",
    --     ["markerSetting"] = {
    --         ["r"] = 97,
    --         ["g"] = 210,
    --         ["b"] = 70,
    --         ["size"] = 2.0,
    --         ["3dTextZ"] = 1.3
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    --         ["anim"] = "idle_b",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(-2820.8017578125, -517.98901367188, -61.973056793213),
    --         vector3(-2835.7685546875, -521.84857177734, -59.302742004395),
    --         vector3(-2847.46875, -514.11871337891, -62.289794921875),
    --         vector3(-2846.3813476562, -558.72503662109, -69.455551147461),
    --         vector3(-2832.3493652344, -567.93353271484, -64.966659545898),
    --         vector3(-2813.6809082031, -543.47216796875, -66.099494934082),
    --         vector3(-2818.1462402344, -558.08917236328, -65.744216918945),
    --     }
    -- },

    --  --Derin Dalış Noktası
    -- ["hurda-2"] = {
    --     ["blip"] = {
    --         ["sprite"] = 465,
    --         ["scale"] = 0.7,
    --         ["colour"] = 36,
    --         ["text"] = "Dalış Noktası",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "enerji_icecegi",
    --             ["oran"] = 20,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "saat",
    --             ["oran"] = 25,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "yuzuk",
    --             ["oran"] = 35,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_tech",
    --             ["oran"] = 50,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "plastik",
    --             ["oran"] = 100,
    --             ["maxRandomItemCount"] = 4
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Bir Şeyler",
    --     ["markerSetting"] = {
    --         ["r"] = 97,
    --         ["g"] = 210,
    --         ["b"] = 70,
    --         ["size"] = 2.0,
    --         ["3dTextZ"] = 1.3
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    --         ["anim"] = "idle_b",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(765.15148925781, 7382.806640625, -110.8715133667),
    --         vector3(769.11596679688, 7391.5849609375, -111.84532165527),
    --         vector3(763.49639892578, 7400.4516601562, -113.47422027588),
    --         vector3(749.50872802734, 7393.3823242188, -114.60406494141),
    --         vector3(754.42572021484, 7388.8984375, -110.49981689453),
    --         vector3(729.35955810547, 7386.1123046875, -117.10625457764),
    --         vector3(725.86962890625, 7410.6137695312, -120.21370697021),
    --         vector3(772.49737548828, 7427.69140625, -121.907081604),
    --         vector3(814.697265625, 7410.1762695312, -125.29574584961),
    --     }
    -- },

    --  -- Batık Gemi Alanı
    -- ["hurda-3"] = {
    --     ["blip"] = {
    --         ["sprite"] = 465,
    --         ["scale"] = 0.7,
    --         ["colour"] = 36,
    --         ["text"] = "Dalış Noktası",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "kum",
    --             ["oran"] = 15,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_altin",
    --             ["oran"] = 17,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_bakir",
    --             ["oran"] = 22,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_demir",
    --             ["oran"] = 28,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "kingcrab",
    --             ["oran"] = 64,
    --             ["maxRandomItemCount"] = 5
    --         },
    --         {
    --             ["item"] = "crab",
    --             ["oran"] = 100,
    --             ["maxRandomItemCount"] = 5
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Bir Şeyler",
    --     ["markerSetting"] = {
    --         ["r"] = 97,
    --         ["g"] = 210,
    --         ["b"] = 70,
    --         ["size"] = 2.0,
    --         ["3dTextZ"] = 1.3
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    --         ["anim"] = "idle_b",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(-3171.1796875, 3023.3525390625, -32.017227172852),
    --         vector3(-3177.3388671875, 3030.5209960938, -31.289190292358),
    --         vector3(-3179.2280273438, 3042.8796386719, -33.192039489746),
    --         vector3(-3175.1984863281, 3034.9167480469, -29.361166000366),
    --         vector3(-3164.51953125, 3034.9028320312, -31.289810180664),
    --         vector3(-3174.357421875, 3051.1418457031, -36.45426940918),
    --         vector3(-3190.9802246094, 3051.7141113281, -34.930725097656),
    --     }
    -- },

    --  -- Amatör Dalış Bölgesi
    --  ["hurda-4"] = {
    --     ["blip"] = {
    --         ["sprite"] = 465,
    --         ["scale"] = 0.7,
    --         ["colour"] = 36,
    --         ["text"] = "Dalış Noktası",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "yosun",
    --             ["oran"] = 50,
    --             ["maxRandomItemCount"] = 2
    --         },
    --         {
    --             ["item"] = "mercan",
    --             ["oran"] = 100,
    --             ["maxRandomItemCount"] = 2
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Bir Şeyler",
    --     ["markerSetting"] = {
    --         ["r"] = 97,
    --         ["g"] = 210,
    --         ["b"] = 70,
    --         ["size"] = 2.0,
    --         ["3dTextZ"] = 1.3
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    --         ["anim"] = "idle_b",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(-1963.9875488281, -1023.0600585938, -11.582007408142),
    --         vector3(-1984.5749511719, -1016.826965332, -13.59799861908),
    --         vector3(-1998.3018798828, -1028.0753173828, -12.086005210876),
    --         vector3(-1982.658203125, -1040.4150390625, -13.59799861908),
    --         vector3(-1967.4547119141, -1038.0174560547, -13.59799861908),
    --         vector3(-1954.0827636719, -1039.3594970703, -13.59799861908),
    --         vector3(-1953.5463867188, -1028.15234375, -12.21200466156),
    --         vector3(-1946.3662109375, -997.92419433594, -12.90500164032),
    --         vector3(-1954.1499023438, -1009.7644042969, -13.849997520447),
    --     }
    -- },

    -- -- Amatör Dalış Bölgesi
    -- ["hurda-5"] = {
    --     ["blip"] = {
    --         ["sprite"] = 465,
    --         ["scale"] = 0.7,
    --         ["colour"] = 36,
    --         ["text"] = "Dalış Noktası",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "yuzuk",
    --             ["oran"] = 5,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "kum",
    --             ["oran"] = 20,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_demir",
    --             ["oran"] = 25,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_bakir",
    --             ["oran"] = 30,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "hurda_altin",
    --             ["oran"] = 32,
    --             ["maxRandomItemCount"] = 1
    --         },
    --         {
    --             ["item"] = "plastik",
    --             ["oran"] = 50,
    --             ["maxRandomItemCount"] = 3
    --         },
    --         {
    --             ["item"] = "recycle_item",
    --             ["oran"] = 100,
    --             ["maxRandomItemCount"] = 4
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Bir Şeyler",
    --     ["markerSetting"] = {
    --         ["r"] = 97,
    --         ["g"] = 210,
    --         ["b"] = 70,
    --         ["size"] = 2.0,
    --         ["3dTextZ"] = 1.3
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    --         ["anim"] = "idle_b",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(-1042.6986083984, 6743.7856445312, -85.540199279785),
    --         vector3(-1035.0137939453, 6753.5551757812, -90.169555664062),
    --         vector3(-1022.9710693359, 6740.79296875, -95.100257873535),
    --         vector3(-1033.3409423828, 6731.8686523438, -94.982139587402),
    --         vector3(-1049.7445068359, 6731.7719726562, -89.023696899414),
    --         vector3(-1058.0582275391, 6741.53515625, -87.931579589844),
    --         vector3(-1059.8498535156, 6752.056640625, -87.346961975098),
    --     }
    -- },

    -- -- -- portakal Toplama
    -- -- ["portakal"] = {
    -- --     ["blip"] = {
    -- --         ["sprite"] = 285,
    -- --         ["scale"] = 0.5,
    -- --         ["colour"] = 2,
    -- --         ["text"] = "Tarla",
    -- --     },
    -- --     ["item"] = { 
    -- --         {
    -- --             ["item"] = "portakal",
    -- --             ["maxRandomItemCount"] = 4
    -- --         },
    -- --     },
    -- --     ["selectedCoords"] = 1,
    -- --     ["e"] = "Portakal",
    -- --     ["markerSetting"] = {
    -- --         ["r"] = 255,
    -- --         ["g"] = 145,
    -- --         ["b"] = 0,
    -- --         ["size"] = 0.5,
    -- --         ["3dTextZ"] = 0.5
    -- --     },
    -- --     ["anim"] = {
    -- --         ["disc"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
    -- --         ["anim"] = "high_center_up",
    -- --         ["flag"] = 49,
    -- --         ["time"] = 5000
    -- --     },
    -- --     ["coords"] = {
    -- --         vector3(377.09, 6505.79, 28.01),
    -- --         vector3(369.31, 6505.87, 28.48),
    -- --         vector3(362.56, 6505.76, 28.54),
    -- --         vector3(354.68, 6505.02, 28.51),
    -- --         vector3(346.88, 6505.32, 28.85),
    -- --         vector3(338.92, 6505.63, 28.64),
    -- --         vector3(329.79, 6505.73, 28.63),
    -- --         vector3(320.83, 6505.45, 29.28),
    -- --         vector3(320.86, 6517.31, 29.15),
    -- --         vector3(329.29, 6517.64, 28.98),
    -- --         vector3(337.84, 6517.22, 28.93),
    -- --         vector3(347.07, 6517.61, 28.82),
    -- --         vector3(354.51, 6517.28, 28.26),
    -- --         vector3(361.89, 6517.8, 28.26),
    -- --         vector3(369.29, 6517.65, 28.37),
    -- --         vector3(377.53, 6517.55, 28.38),
    -- --         vector3(368.56, 6531.72, 28.4),
    -- --         vector3(360.62, 6531.13, 28.34),
    -- --         vector3(352.79, 6530.6, 28.43),
    -- --         vector3(345.11, 6531.1, 28.76),
    -- --         vector3(337.66, 6531.29, 28.54),
    -- --         vector3(328.82, 6531.15, 28.67),
    -- --         vector3(320.93, 6531.01, 29.18),
    -- --     }
    -- -- },

    -- -- -- marul Toplama
    -- -- ["marul"] = {
    -- --     ["blip"] = {
    -- --         ["sprite"] = 285,
    -- --         ["scale"] = 0.5,
    -- --         ["colour"] = 2,
    -- --         ["text"] = "Tarla",
    -- --     },
    -- --     ["item"] = { 
    -- --         {
    -- --             ["item"] = "marul",
    -- --             ["maxRandomItemCount"] = 4
    -- --         },
    -- --     },
    -- --     ["selectedCoords"] = 1,
    -- --     ["e"] = "Marul",
    -- --     ["markerSetting"] = {
    -- --         ["r"] = 75,
    -- --         ["g"] = 255,
    -- --         ["b"] = 0,
    -- --         ["size"] = 0.5,
    -- --         ["3dTextZ"] = 0.5
    -- --     },
    -- --     ["anim"] = {
    -- --         ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
    -- --         ["anim"] = "idle_b",
    -- --         ["flag"] = 33,
    -- --         ["time"] = 5000
    -- --     },
    -- --     ["coords"] = {
    -- --         vector3(248.48648071289, 6460.8520507812, 31.363557815552),
    -- --         vector3(236.91036987305, 6460.115234375, 31.417533874512),
    -- --         vector3(243.25779724121, 6474.4633789062, 31.086750030518),
    -- --         vector3(235.7700958252, 6456.103515625, 31.460248947144),
    -- --         vector3(244.65194702148, 6454.5913085938, 31.413478851318),
    -- --         vector3(252.14921569824, 6457.2299804688, 31.454273223877),
    -- --         vector3(230.00276184082, 6473.3012695312, 31.243993759155),
    -- --         vector3(263.46322631836, 6468.193359375, 31.039392471313),
    -- --         vector3(228.38673400879, 6467.3041992188, 31.410573959351),
    -- --         vector3(252.94854736328, 6473.3447265625, 31.034734725952),
    -- --         vector3(262.53305053711, 6462.1059570312, 31.302869796753),
    -- --     }
    -- -- },
    -- --  

    --  -- odun Toplama
    --  ["odun"] = {
    --     ["blip"] = {
    --         ["sprite"] = 527,
    --         ["scale"] = 0.5,
    --         ["colour"] = 31,
    --         ["text"] = "Odunculuk",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "wood",
    --             ["maxRandomItemCount"] = 1
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Odun",
    --     ["markerSetting"] = {
    --         ["r"] = 171,
    --         ["g"] = 111,
    --         ["b"] = 47,
    --         ["size"] = 0.5,
    --         ["3dTextZ"] = 0.5
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@prop_human_bum_shopping_cart@male@idle_a",
    --         ["anim"] = "idle_c",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(-531.62347412109, 5372.5864257812, 70.411209106445),
    --         vector3(-538.10894775391, 5379.0439453125, 70.41374206543),
    --         vector3(-554.11047363281, 5371.0532226562, 70.328674316406),
    --         vector3(-545.09887695312, 5382.8041992188, 70.49520111084),
    --         vector3(-549.96472167969, 5375.0815429688, 70.489128112793),
    --         vector3(-539.19561767578, 5371.8491210938, 70.546768188476),
    --         vector3(-544.35968017578, 5388.5639648438, 70.212425231934),
    --     }
    -- },

    -- --[[ yün Toplama
    -- ["yun"] = {
    --     ["blip"] = {
    --         ["sprite"] = 366,
    --         ["scale"] = 0.5,
    --         ["colour"] = 9,
    --         ["text"] = "Yüncülük",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "wool",
    --             ["maxRandomItemCount"] = 4
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Yün",
    --     ["markerSetting"] = {
    --         ["r"] = 230,
    --         ["g"] = 244,
    --         ["b"] = 255,
    --         ["size"] = 0.5,
    --         ["3dTextZ"] = 0.5
    --     },
    --     ["anim"] = {
    --         ["disc"] = "pickup_object",
    --         ["anim"] = "pickup_low",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(1451.4008789062, 1073.0611572266, 114.33399200439),
    --         vector3(1446.8370361328, 1061.2445068359, 114.34142303467),
    --         vector3(1456.2448730469, 1063.4506835938, 114.3342590332),
    --         vector3(1443.1641845703, 1065.5472412109, 114.3475112915),
    --         vector3(1449.5960693359, 1071.0654296875, 114.33390808105),
    --         vector3(1444.9841308594, 1070.9444580078, 114.33367919922),
    --         vector3(1458.0955810547, 1068.2231445312, 114.33397674561),
    --         vector3(1451.1630859375, 1064.0130615234, 114.33496856689),
    --         vector3(1455.8273925781, 1071.9606933594, 114.33397674561),
    --     }
    -- },
    -- ]]
    
    --  -- Tavuk Toplama
    -- ["tavuk"] = {
    --     ["blip"] = {
    --         ["sprite"] = 233,
    --         ["scale"] = 0.5,
    --         ["colour"] = 33,
    --         ["text"] = "Tavukculuk",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "alive_chicken",
    --             ["maxRandomItemCount"] = 4
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Tavuk",
    --     ["markerSetting"] = {
    --         ["r"] = 72,
    --         ["g"] = 161,
    --         ["b"] = 121,
    --         ["size"] = 0.5,
    --         ["3dTextZ"] = 0.5
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@prop_human_bum_shopping_cart@male@idle_a",
    --         ["anim"] = "idle_c",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(-68.59, 6248.15, 31.08),
    --         vector3(-62.27, 6241.81, 31.09),
    --         vector3(-65.92, 6236.34, 31.09),
    --         vector3(-65.14, 6245.57, 31.09),
    --     }
    -- },

    -- tas Toplama
    -- ["tas"] = {
    --     ["blip"] = {
    --         ["sprite"] = 501,
    --         ["scale"] = 0.5,
    --         ["colour"] = 77,
    --         ["text"] = "Madencilik",
    --     },
    --     ["item"] = { 
    --         {
    --             ["item"] = "stone",
    --             ["maxRandomItemCount"] = 4
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Taş",
    --     ["markerSetting"] = {
    --         ["r"] = 71,
    --         ["g"] = 255,
    --         ["b"] = 92,
    --         ["size"] = 0.5,
    --         ["3dTextZ"] = 0.5
    --     },
    --     ["anim"] = {
    --         ["disc"] = "pickup_object",
    --         ["anim"] = "pickup_low",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(2952.9057617188, 2790.7829589844, 41.231597900391),
    --         vector3(2949.0739746094, 2795.2482910156, 40.765819549561),
    --         vector3(2942.0317382812, 2790.4904785156, 40.258220672607),
    --         vector3(2944.9416503906, 2795.6862792969, 40.632858276367),
    --         vector3(2942.9753417969, 2785.1088867188, 39.812232971191),
    --         vector3(2947.8815917969, 2780.6254882812, 39.550605773926),
    --         vector3(2967.2436523438, 2801.6166992188, 41.37398147583),
    --         vector3(2969.4382324219, 2787.650390625, 39.617698669434),
    --         vector3(2959.02734375, 2805.2934570312, 42.102054595947),
    --         vector3(2973.5087890625, 2795.5385742188, 40.948085784912),
    --         vector3(2955.7580566406, 2777.9504394531, 40.246585845947),
    --         vector3(2963.2580566406, 2781.8947753906, 39.64005279541),
    --     }
    -- },

  --[[ petrol Toplama
    ["petrol"] = {
        ["blip"] = {
            ["sprite"] = 436,
            ["scale"] = 0.5,
            ["colour"] = 60,
            ["text"] = "Rafinecilik",
        },
        ["item"] = { 
            {
                ["item"] = "petrol",
                ["maxRandomItemCount"] = 4
            },
        },
        ["selectedCoords"] = 1,
        ["e"] = "Petrol",
        ["markerSetting"] = {
            ["r"] = 14,
            ["g"] = 58,
            ["b"] = 252,
            ["size"] = 0.5,
            ["3dTextZ"] = 0.5
        },
        ["anim"] = {
            ["disc"] = "pickup_object",
            ["anim"] = "pickup_low",
            ["flag"] = 33,
            ["time"] = 5000
        },
        ["coords"] = {
            vector3(607.58569335938, 2878.4663085938, 39.392707824707),
            vector3(600.15283203125, 2874.6618652344, 39.473320007324),
            vector3(589.14343261719, 2877.7060546875, 39.852672576904),
            vector3(583.021484375, 2882.38671875, 39.924015045166),
            vector3(583.78851318359, 2890.6901855469, 39.472736358643),
            vector3(607.57934570312, 2886.3627929688, 39.41393661499),
            vector3(607.45867919922, 2895.3723144531, 39.537563323975),
            vector3(592.22894287109, 2896.7590332031, 39.557292938232),
            vector3(600.66033935547, 2898.1281738281, 39.944450378418),
            vector3(611.00329589844, 2890.5463867188, 39.507690429688),
        }
    },
    ]]
 
    -- petrol Toplama
    -- ["ot"] = {
    --     ["blip"] = false,
    --     ["item"] = { 
    --         {
    --             ["item"] = "ot",
    --             ["maxRandomItemCount"] = 2
    --         },
    --     },
    --     ["selectedCoords"] = 1,
    --     ["e"] = "Ot",
    --     ["markerSetting"] = {
    --         ["r"] = 73,
    --         ["g"] = 142,
    --         ["b"] = 46,
    --         ["size"] = 0.5,
    --         ["3dTextZ"] = 0.5
    --     },
    --     ["anim"] = {
    --         ["disc"] = "amb@prop_human_bum_shopping_cart@male@idle_a",
    --         ["anim"] = "idle_c",
    --         ["flag"] = 33,
    --         ["time"] = 5000
    --     },
    --     ["coords"] = {
    --         vector3(2216.1025390625, 5576.3129882812, 53.57727432251),
    --         vector3(2218.3481445312, 5576.0390625, 53.59623336792),
    --         vector3(2233.1247558594, 5577.5405273438, 53.908874511719),
    --         vector3(2223.0317382812, 5575.7534179688, 53.628555297852),
    --         vector3(2220.4833984375, 5575.85546875, 53.613346099854),
    --         vector3(2225.2478027344, 5575.5927734375, 53.638782501221),
    --         vector3(2218.1901855469, 5578.6884765625, 53.731117248535),
    --         vector3(2230.0012207031, 5575.099609375, 53.759731292725),
    --         vector3(2232.5524902344, 5575.1259765625, 53.838584899902),
    --         vector3(2227.6948242188, 5575.4252929688, 53.657875061035),
    --         vector3(2230.3459472656, 5577.7900390625, 53.794971466064),
    --         vector3(2220.8010253906, 5578.5004882812, 53.720066070557),
    --         vector3(2225.5141601562, 5578.11328125, 53.700752258301),
    --     }
    -- }, 


    -- Üzüm Toplama(Tek Seferlik)
    ["uzum"] = {
        -- ["blip"] = {
        --     ["sprite"] = 57,
        --     ["scale"] = 0.5,
        --     ["colour"] = 7,
        --     ["text"] = "Üzüm Tarlası",
        -- },
        ["item"] = { 
            {
                ["item"] = "uzum",
                ["maxRandomItemCount"] = math.random(1, 3)
            },
        },
        ["selectedCoords"] = 1,
        ["e"] = "Üzüm",
        ["markerSetting"] = {
            ["r"] = 204,
            ["g"] = 0,
            ["b"] = 102,
            ["size"] = 0.4,
            ["3dTextZ"] = 0.5
        },
        ["anim"] = {
            ["disc"] = "amb@prop_human_bum_shopping_cart@male@idle_a",
            ["anim"] = "idle_c",
            ["flag"] = 33,
            ["time"] = 5000
        },
        ["coords"] = {
            vector3(-1904.02, 2141.51, 119.59),
            vector3(-1890.02, 2137.08, 124.81),
            vector3(-1849.14, 2133.76, 125.81),
            vector3(-1850.44, 2141.26, 123.11),
            vector3(-1877.56, 2140.78, 125.0),
            vector3(-1901.38, 2145.94, 118.65),
        }
    },


    --[[ ["solucan"] = {
        ["blip"] = {
            ["sprite"] = 293,
            ["scale"] = 0.7,
            ["colour"] = 17,
            ["text"] = "Solucan Toplama",
        },
        ["item"] = { 
            {
                ["item"] = "fishbait",
                ["maxRandomItemCount"] = 4
            },
           
        },
        ["selectedCoords"] = 1,
        ["e"] = "Solucan",
        ["markerSetting"] = {
            ["r"] = 252,
            ["g"] = 109,
            ["b"] = 79,
            ["size"] = 0.5,
            ["3dTextZ"] = 0.5
        },
        ["anim"] = {
            ["disc"] = "amb@world_human_gardener_plant@male@idle_a",
            ["anim"] = "idle_b",
            ["flag"] = 33,
            ["time"] = 5000
        },
        ["coords"] = {
            vector3(-2324.6435546875, 2545.0485839844, 2.2228182554245),
            vector3(-2326.0395507812, 2534.3537597656, 2.3639525175095),
            vector3(-2334.7517089844, 2529.8208007812, 1.9738489985466),
            vector3(-2327.6809082031, 2524.3869628906, 2.3187190294266),
            vector3(-2320.6159667969, 2530.45703125, 2.4486222267151),
            vector3(-2316.8928222656, 2535.6049804688, 2.4266016483307),
            vector3(-2315.3020019531, 2543.0031738281, 2.4399626255035),
            vector3(-2315.3500976562, 2546.59375, 2.5441876649857),
        }
    },
    ]]

}



Citizen.CreateThread(function()
    while true do 
        local time = 1000
        if not bussy then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            for x,name in pairs(jobs) do
                local jobCoords = name["coords"][name["selectedCoords"]]
                local distance = #(jobCoords - playerCoords)
                if distance < 100 then
                    time = 1
                    DrawMarker(2, jobCoords.x, jobCoords.y, jobCoords.z - name["markerSetting"]["3dTextZ"], 0.0, 0.0, 0.0, 0, 0.0, 0.0, name["markerSetting"]["size"], name["markerSetting"]["size"], name["markerSetting"]["size"], name["markerSetting"]["r"], name["markerSetting"]["g"], name["markerSetting"]["b"], 180, false, true, 2, false, false, false, false)
                    if distance < 1 then
                        -- QBCore.Functions.DrawText3D(jobCoords.x, jobCoords.y, jobCoords.z, "[E] "..name["e"] .. " Topla")
                        inUI = true
                        exports['qb-ui']:showInteraction("[E] Gather", nil, "topla")
                        if IsControlJustReleased(0, 38) then 
                            exports['qb-ui']:hideInteraction("topla")
                            bussy = true
                            QBCore.Functions.Progressbar(x, name["e"] .. " Topluyorsun", name["anim"]["time"], false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = name["anim"]["disc"],
                                anim = name["anim"]["anim"],
                                flags = name["anim"]["flag"],
                            }, { }, {}, function() -- Done
                                name["selectedCoords"] = math.random(1, #name["coords"])
                                TriggerServerEvent("edrp-job:give-item", name["item"], #name["item"])
                                bussy = false
                            end, function() -- Cancel
                                bussy = false
                            end)
                        end
                    elseif distance > 1 then
                        inUI = false
                        exports['qb-ui']:hideInteraction("topla")
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent("kfzeu-meat-farm:blipAcKapa")
AddEventHandler("kfzeu-meat-farm:blipAcKapa", function()
	if blip then
		pasifblip()
		blip = false
	else
		aktifblip()
		blip = true
	end
end)

function aktifblip()
    for x,name in pairs(jobs) do
        if name["blip"] then
            local blip = AddBlipForCoord(name["coords"][1])
            SetBlipSprite(blip, name["blip"]["sprite"])
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, name["blip"]["scale"])
            SetBlipColour(blip, name["blip"]["colour"])
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name["blip"]["text"])
            EndTextCommandSetBlipName(blip)
            table.insert(aktifblipler, blip)
        end
    end
end

function pasifblip()
	for i = 1, #aktifblipler do
		RemoveBlip(aktifblipler[i])
	end
	aktifblipler = {}
end
