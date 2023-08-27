local arena = PolyZone:Create({
    vector2(-251.8106842041, -1952.9044189453),
    vector2(-255.8083190918, -1947.8168945312),
    vector2(-260.31161499023, -1943.1356201172),
    vector2(-265.63537597656, -1938.6666259766),
    vector2(-271.31335449219, -1933.8991699219),
    vector2(-276.84085083008, -1929.2531738281),
    vector2(-293.76263427734, -1915.0643310547),
    vector2(-299.45483398438, -1910.2939453125),
    vector2(-305.04110717773, -1905.5711669922),
    vector2(-310.36206054688, -1901.1298828125),
    vector2(-315.75997924805, -1897.4897460938),
    vector2(-321.47048950195, -1894.4678955078),
    vector2(-327.49899291992, -1892.0223388672),
    vector2(-333.79479980469, -1890.2099609375),
    vector2(-340.17364501953, -1889.1185302734),
    vector2(-346.69400024414, -1888.662109375),
    vector2(-353.19647216797, -1888.8944091797),
    vector2(-359.61669921875, -1889.7590332031),
    vector2(-365.99261474609, -1891.3658447266),
    vector2(-372.05746459961, -1893.5959472656),
    vector2(-377.91305541992, -1896.4425048828),
    vector2(-383.42672729492, -1899.8834228516),
    vector2(-388.31521606445, -1903.7308349609),
    vector2(-399.3244934082, -1916.8521728516),
    vector2(-402.24670410156, -1922.3076171875),
    vector2(-404.6838684082, -1928.3455810547),
    vector2(-406.47674560547, -1934.6519775391),
    vector2(-407.64010620117, -1941.0369873047),
    vector2(-408.06677246094, -1947.5346679688),
    vector2(-407.83480834961, -1954.0573730469),
    vector2(-406.92358398438, -1960.4622802734),
    vector2(-405.33819580078, -1966.8188476562),
    vector2(-403.11102294922, -1972.9047851562),
    vector2(-400.28338623047, -1978.7546386719),
    vector2(-396.81198120117, -1984.2758789062),
    vector2(-392.8112487793, -1989.4073486328),
    vector2(-388.30807495117, -1994.0571289062),
    vector2(-382.98565673828, -1998.5361328125),
    vector2(-338.28103637695, -2036.0529785156),
    vector2(-332.88272094727, -2039.6645507812),
    vector2(-327.1399230957, -2042.7239990234),
    vector2(-321.10186767578, -2045.1734619141),
    vector2(-314.85833740234, -2046.9537353516),
    vector2(-308.41937255859, -2048.0876464844),
    vector2(-301.95883178711, -2048.5539550781),
    vector2(-295.41754150391, -2048.3095703125),
    vector2(-289.10049438477, -2047.3123779297),
    vector2(-282.69631958008, -2045.8359375),
    vector2(-276.58444213867, -2043.6077880859),
    vector2(-270.68890380859, -2040.7340087891),
    vector2(-265.14874267578, -2037.2796630859),
    vector2(-260.3337097168, -2033.4943847656),
    vector2(-249.29145812988, -2020.3332519531),
    vector2(-246.37181091309, -2014.8538818359),
    vector2(-243.94528198242, -2008.8383789062),
    vector2(-242.13893127441, -2002.5653076172),
    vector2(-241.02531433105, -1996.1912841797),
    vector2(-240.5528717041, -1989.6687011719),
    vector2(-240.7921295166, -1983.1647949219),
    vector2(-241.71141052246, -1976.7215576172),
    vector2(-243.28726196289, -1970.4078369141),
    vector2(-245.5107421875, -1964.2880859375),
    vector2(-248.34475708008, -1958.4494628906)
}, {
    name="paintball",
    minZ = 15.94603729248,
    maxZ = 105.950458526611
})

local randomSpawnCoords = {
    vector3(-347.1012878418, -1977.3958740234, 37.93042755127),
    vector3(-342.59893798828, -1982.0548095703, 37.93042755127),
    vector3(-340.95120239258, -1976.3898925781, 37.93042755127),
    vector3(-346.72723388672, -1975.2595214844, 37.93042755127),
}
  
AddEventHandler('tgiann:playerdead', function(dead)
    if dead then
        local playerPed = PlayerPedId()
        if inArena() then
            TriggerServerEvent("tgiann-fightclub:efect")
            DoScreenFadeOut(2000)
            QBCore.Functions.Notify("You'll Get Well Soon!", "primary")
            local randomCoords = randomSpawnCoords[math.random(1, #randomSpawnCoords)]
            Citizen.Wait(10000)
            SetEntityCoords(playerPed, randomCoords.x, randomCoords.y, randomCoords.z)
            TriggerEvent("esx_ambulancejob:revive", false)
            DoScreenFadeIn(2000)
        end
    end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/arena', 'Write to Anyone in the Arena Area.', {})
end)

RegisterCommand("arena", function(source, args)
    if inArena() then
        if args[1] == nil then 
            QBCore.Functions.Notify("You Didn't Enter a Message!", "error")
            return 
        end
        local message = table.concat(args, " ")
        TriggerServerEvent('tgiann-fightclub:server:pb-message', "ARENA | " .. PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname, message)
    else
        QBCore.Functions.Notify("You Cannot Use This Command Outside the Arena!", "error")
    end
end)

RegisterNetEvent('tgiann-fightclub:pb-message')
AddEventHandler('tgiann-fightclub:pb-message', function(wr, msg)
    if inArena() then
        TriggerEvent('chatMessage', wr, "primary", msg)
    end
end)

function inArena()
    if arena:isPointInside(GetEntityCoords(PlayerPedId())) then
        return true
    else
        return false
    end
end

exports('inArenaExports', function()
    return inArena()
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-323.1286315918, -1974.6383056641, 45.793636322021)
	SetBlipSprite(blip, 543)
	SetBlipScale(blip, 0.5)
	SetBlipColour(blip, 69)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("Airsoft Arena")
	EndTextCommandSetBlipName(blip)
end)

--[[ RegisterCommand("sa", function()
    TriggerServerEvent("tgiann-fightclub:efect")
end) ]]

RegisterNetEvent('tgiann-fightclub:client:efect')
AddEventHandler('tgiann-fightclub:client:efect', function(job)
    if inArena() then
        alevEfek()
    end
end)

local efectCoords = {
    {coord = vector3(-308.47253417969, -2003.3762207031, 38.238254547119), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-297.26623535156, -2003.2685546875, 38.439914703369), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-295.39956665039, -1996.3635253906, 38.439914703369), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-247.84379577637, -1990.5754394531, 38.439914703369), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-251.05532836914, -1997.5659179688, 39.059928894043), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-264.85876464844, -2013.8637695312, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-279.76223754883, -2031.6153564453, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-320.28500366211, -1997.9272460938, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-353.23471069336, -1996.3533935547, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-370.64398193359, -1987.1384277344, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-315.23455810547, -1980.5233154297, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-328.87933349609, -1966.7687988281, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-345.78247070312, -1949.9801025391, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-374.14892578125, -1955.6993408203, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-385.7048034668, -1927.3331298828, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-372.45608520508, -1908.3231201172, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-363.8620300293, -1904.6896972656, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-329.82824707031, -1919.1169433594, 38.579917907715), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-322.10003662109, -1918.2944335938, 38.699920654297), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-308.00814819336, -1929.3098144531, 38.699920654297), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-304.71691894531, -1926.5643310547, 38.719921112061), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-303.95413208008, -1938.9183349609, 35.219841003418), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-283.94290161133, -1948.2866210938, 35.219841003418), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-267.18304443359, -1947.8145751953, 33.97981262207), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-265.85641479492, -1960.0447998047, 32.77978515625), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-267.0827331543, -1947.8446044922, 33.359798431396), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-284.1982421875, -1928.4575195312, 33.359798431396), dict = "core", particleName = "ent_sht_petrol_fire", size = 1.0},
    {coord = vector3(-296.14297485352, -1921.3557128906, 33.359798431396), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-302.99475097656, -1917.5593261719, 33.499801635742), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-337.87554931641, -1910.671875, 38.819923400879), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-345.35043334961, -1911.7518310547, 38.259910583496), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-352.45196533203, -1910.140625, 38.259910583496), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-323.76525878906, -1922.0185546875, 38.259910583496), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-302.35464477539, -1933.3568115234, 33.419799804688), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-341.06503295898, -1954.2767333984, 38.759922027588), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-358.02978515625, -1937.5673828125, 38.639919281006), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-382.49353027344, -1922.4476318359, 38.319911956787), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-395.67318725586, -1941.5001220703, 38.319911956787), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-285.19384765625, -2036.1947021484, 33.399799346924), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-268.47525024414, -2018.484375, 38.199909210205), dict = "core", particleName = "ent_sht_petrol_fire"}, 
    {coord = vector3(-253.74011230469, -2000.7130126953, 38.199909210205), dict = "core", particleName = "ent_sht_petrol_fire"},
    {coord = vector3(-363.29962158203, -1932.2578125, 33.919830322266), dict = "core", particleName = "ent_sht_petrol_fire"},
}

function alevEfek()
    for i=1 ,#efectCoords do
        local dict = efectCoords[i].dict
        local particleName = efectCoords[i].particleName
        local size = 3.0
        if efectCoords[i].size then size = efectCoords[i].size end
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Citizen.Wait(0)
        end
        UseParticleFxAssetNextCall(dict)
        local particleHandle = StartParticleFxNonLoopedAtCoord(particleName, efectCoords[i].coord, 0.0, 0.0, 0.0, size, false, false, false)
        SetParticleFxLoopedColour(particleHandle, 0, 255, 0 ,0)
    end
end