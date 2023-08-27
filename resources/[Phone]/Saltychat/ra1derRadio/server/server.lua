QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem('walkie_lspd', function(source)
	TriggerClientEvent('ra1derRadio:use', source)
end)

QBCore.Commands.Add("t", "Bir Telsiz Frekansına Bağlan", {{name="Telsiz Frekansı", help="1 ile 100 arası"}}, true, function(source, args) 
	TriggerClientEvent('ra1derRadio:t', source, args[1])
end)

QBCore.Commands.Add("tk", "Telsiz Frekansından Ayrıl", {}, false, function(source, args) 
	TriggerClientEvent('ra1derRadio:tk', source)
end)

Citizen.CreateThread(function()
	exports["saltychat"]:SetRadioTowers({
		{2572, 5397, 56},
		{2663, 4972, 56},
		{2892, 3911, 56},
		{2720, 3304, 64},
		{2388, 2949, 64},
		{1830, 2368, 64},
		{1650, 1316, 102},
		{1363, 680, 102},
		{918, 230, 92},
		{567, 303, 58},
		{-47, -666, 74},
		{-585, -902, 53},
		{2572, 5397, 56},
		{2338, 5940, 77},
		{1916, 6244, 65},
		{1591, 6371, 42},
		{953, 6504, 42},
		{76, 6606, 42},
		{408, 6587, 42},
		{-338, -579, 48},    --prop_radiomast02
		{-293, -632, 47},    --prop_radiomast02
		{-269, -962, 143},     --prop_radiomast02
		{98, -870, 136},     --prop_radiomast02
		{-214, -744, 219},    --prop_radiomast01
		{-166, -590, 199},    --prop_radiomast01
		{124, -654, 261},     --prop_radiomast01
		{149, -769, 261},     --prop_radiomast01
		{580, 89, 117},      --prop_radiomast02
		{423, 15, 151},      --prop_radiomast02
		{424, 18, 151},         --prop_radiomast02
		{551, -28, 93},     --prop_radiomast02
		{305, -284, 68},      --prop_radiomast02
		{299, -313, 68},      --prop_radiomast02
		{1240, -1090, 44},     --prop_radiomast02
		{-418, -2804, 14},    --prop_radiomast02
		{802, -2996, 27},     --prop_radiomast02
		{253, -3145, 39},      --prop_radiomast01
		{207, -3145, 39},      --prop_radiomast01
		{207, -3307, 39},      --prop_radiomast01
		{247, -3307, 39},     --prop_radiomast01
		{484, -2178, 40},     --prop_radiomast01
		{548, -2219, 67},     --prop_radiomast02
		{-701, 58, 68},     --prop_radiomast02
		{-696, 208, 139},     --prop_radiomast02
		{-769, 255, 134},      --prop_radiomast02
		{-150, -150, 96},      --prop_radiomast01
		{-202, -327, 65},    --prop_radiomast01
		{-1913, -3031, 22},      --prop_radiomast01
		{-1918, -3028, 22},    --prop_radiomast02
		{-1039, -2385, 27},    --prop_radiomast02
		{-1042, -2390, 27},    --prop_radiomast01
		{-1583, -3216, 28},     --prop_radiomast01
		{-1590, -3212, 28},     --prop_radiomast02
		{-1308, -2626, 36},      --prop_radiomast01
		{-1311, -2624, 36},    --prop_radiomast02
		{-984, -2778, 48},    --prop_radiomast01
		{-991, -2774, 48},    --prop_radiomast02
		{-556, -119, 50},    --prop_radiomast02
		{-619, -106, 51},    --prop_radiomast02
		{-1167, -575, 40},     --prop_radiomast01
		{-1152, -443, 42},    --prop_radiomast02
		{-1156, -498, 49},    --prop_radiomast02
		{-1290, -445, 106},    --prop_radiomast02
		{-928, -383, 135},    --prop_radiomast01
		{-902, -443, 170},    --prop_radiomast01
		{-770, -786, 83},    --prop_radiomast02
		{-824, -719, 120},    --prop_radiomast02
		{-598, -917, 35},     --prop_radiomast02
		{-678, -717, 54},    --prop_radiomast02
		{-669, -804, 31},      --prop_radiomast02
		{-1463, -526, 83},    --prop_radiomast02
		{-1525, -596, 66},    --prop_radiomast02
		{-1375, -465, 83},    --prop_radiomast02
		{-1711, 478, 127},      --prop_radiomast02
		{-2311, 335, 187},     --prop_radiomast01
		{-2214, 342, 198},      --prop_radiomast01
		{-2234, 187, 193},     --prop_radiomast01
		{202, 1204, 230},          --prop_radiomast02
		{217, 1140, 230},      --prop_radiomast02
		{668, 590, 136},      --prop_radiomast02
		{722, 562, 134},      --prop_radiomast02
		{838, 510, 138},      --prop_radiomast02
		{773, 575, 138},      --prop_radiomast02
		{735, 231, 145},      --prop_radiomast02
		{450, 5566, 795},        --prop_radiomast02
		{-449, 6019, 35},     --prop_radiomast02
		{-142, 6286, 39},     --prop_radiomast02
		{-368, 6105, 38},     --prop_radiomast02
		{2792, 5996, 355},      --prop_radiomast01
		{2796, 5992, 354},       --prop_radiomast02
		{3460, 3653, 51},      --prop_radiomast02
		{3459, 3659, 51},      --prop_radiomast01
		{3615, 3642, 51},       --prop_radiomast01
		{3614, 3636, 51},      --prop_radiomast02
		{-2180, 3252, 54},      --prop_radiomast02
		{-2124, 3219, 54},      --prop_radiomast02
		{-2050, 3178, 54},      --prop_radiomast02
		{1858, 3694, 37},      --prop_radiomast02
		{1695, 3614, 37},      --prop_radiomast02
		{1692, 2532, 60},      --prop_radiomast02
		{1692, 2647, 60},      --prop_radiomast02
		{1824, 2574, 60},      --prop_radiomast02
		{1407, 2117, 104},      --prop_radiomast02
	})
end) 

RegisterServerEvent('ra1derRadio:set-channel')
AddEventHandler('ra1derRadio:set-channel', function(channel)
	if channel == nil then channel = "100" end
	exports["saltychat"]:SetPlayerRadioChannel(source, tostring(channel), false)
	TriggerClientEvent("QBCore:Notify", source, channel .. '.00 MHz Frekansına Bağlandın')
end)

RegisterServerEvent('ra1derRadio:remove-channel')
AddEventHandler('ra1derRadio:remove-channel', function(oldChannel)
	exports["saltychat"]:RemovePlayerRadioChannel(source, tostring(oldChannel))
	TriggerClientEvent("QBCore:Notify", source, oldChannel.. '.00 MHz Frekansından Ayrıldın', 'error')
end)

RegisterServerEvent('ra1derRadio:set-disses')
AddEventHandler('ra1derRadio:set-disses', function(bool)
	if bool == nil then bool = false end
	if bool then
		TriggerClientEvent("QBCore:Notify", source, 'Hoparlör Modu Aktif', 'success')
	else
		TriggerClientEvent("QBCore:Notify", source, 'Hoparlör Modu Pasif', 'error')
	end
	exports["saltychat"]:SetPlayerRadioSpeaker(source, bool)
end)

