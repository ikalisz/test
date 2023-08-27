Config = {}

Config.VehicleMenu = true -- enable this if you wan't a vehicle menu.
Config.RangeCheck = 25.0 -- this is the change you will be able to control the vehicle.


Config.BlipGarage = {
	Sprite = 357,
	Color = 77,
	Display = 2,
	Scale = 0.45
}

Config.BlipGaragePrivate = {
	Sprite = 290,
	Color = 53,
	Display = 2,
	Scale = 0.4
}

Config.BlipPound = {
	Sprite = 67,
	Color = 64,
	Display = 2,
	Scale = 0.6
}

Config.BlipJobPound = {
	Sprite = 67,
	Color = 49,
	Display = 2,
	Scale = 0.6
}

Config.PointMarker = {
	r = 255, g = 0, b = 0,     -- Green Color
	x = 1.0, y = 1.0, z = 1.0  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 4.0, y = 4.0, z = 4.0  -- Big Size Circle
}

Config.PoundMarker = {
	r = 0, g = 0, b = 100,     -- Blue Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}


Config.Garages = {
    {
        ["blip"] = vector3(-187.56056213379, -1920.9401855469, 27.3003963),
		["sPosition"] = {
            vector3(-193.0611114502, -1928.4951171875, 27.195943832397),
            vector3(-198.88859558105, -1931.5440673828, 27.195987701416),
            vector3(-183.9397277832, -1936.3176269531, 27.196376800537),
        },
        ["sHeading"] = {
            208.0105,
            208.9722,
            114.7981,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-1160.2678222656, -2118.9196777344, 13.26203918457),
        ["tip"] = "menu",
    },
    {
        ["blip"] = vector3(992.19549560547, -127.01154327393, 74.060836791992),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(1203.6268310547, -1266.2015380859, 35.225021362305),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-1188.9903564453, -1488.4056396484, 4.3792991638184),
		["sPosition"] = {
            vector3(-1188.4344482422, -1488.2512207031, 3.773823261261),
            vector3(-1198.0324707031, -1494.5379638672, 3.7637453079224),
            vector3(-1184.8907470703, -1493.2913818359, 3.7743744850159),
        },
        ["sHeading"] = {
            125.2665,
            306.6346,
            126.4453,
        },
        ["tip"] = "menu"
    },

    {
        ["blip"] = vector3(-492.99987792969, -331.28695678711, 34.365623474121),
		["sPosition"] = {
            vector3(-492.99987792969, -331.28695678711, 34.365623474121),
            vector3(-490.43609619141, -341.5231628418, 34.36404800415),
        },
        ["sHeading"] = {
            125.2665,
            306.6346,
            126.4453,
        },
        ["tip"] = "menu"
    },

    {
        ["blip"] = vector3(1725.5695800781, 3719.3254394531, 34.120059967041),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(139.87911987305, 6598.8393554688, 31.844926834106),
		["sPosition"] = {
            vector3(145.83798217773, 6603.701171875, 31.246276855469),
            vector3(150.34844970703, 6599.36328125, 31.24095916748),
            vector3(145.92045593262, 6612.1181640625, 31.219791412354),
        },
        ["sHeading"] = {
            178.8403,
            178.0247,
            357.0231,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(1867.8118896484, 2603.0512695312, 45.67200088501),
		["sPosition"] = {
            vector3(1870.6348876953, 2595.3979492188, 45.065986633301),
            vector3(1869.7657470703, 2591.8325195313, 45.066101074219),
            vector3(1876.8016357422, 2595.6401367188, 45.067085266113),
        },
        ["sHeading"] = {
            89.79,
            89.79,
            268.75,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(1110.1143798828, 255.25486755371, 80.855560302734),
		["sPosition"] = {
            vector3(1108.4801025391, 255.90570068359, 80.248558044434),
            vector3(1113.9616699219, 252.64849853516, 80.250930786133),
            vector3(1110.2379150391, 258.65692138672, 80.250450134277),
        },
        ["sHeading"] = {
            56.16,
            239.86,
            57.34,
        },
        ["tip"] = "menu"
    },

    {
        ["blip"] = vector3(-1165.6241455078, -888.93371582031, 14.114175796509),
		["sPosition"] = {
            vector3(-1165.1351318359, -887.65832519531, 13.712992668152),
            vector3(-1163.2895507813, -890.56585693359, 13.716335296631),
        },
        ["sHeading"] = {
            123.96,
            124.80,
            128.31,
        },
        ["tip"] = "menu"
    },

    {
        ["blip"] = vector3(-15.39942741394, -1088.1169433594, 26.670660018921),
		["sPosition"] = {
          	vector3(-8.3647184371948, -1081.7175292969, 26.067440032959),
            vector3(-11.553004264832, -1080.7481689453, 26.068340301514),
            vector3(-17.140148162842, -1079.5018310547, 26.066570281982),
        },
        ["sHeading"] = {
            123.96,
            124.80,
            128.31,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(278.55981445312, -333.03549194336, 44.919986724854),
        ["sPosition"] = {
            vector3(266.37246704102, -332.20748901367, 44.919845581055),
            vector3(279.94320678711, -329.97512817383, 44.919868469238),
            vector3(270.28762817383, -319.00390625, 44.919845581055),
        },
        ["sHeading"] = {
            251.31530761719,
            73.430740356445,
            245.16644287109,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(472.67477416992, -1096.6665039062, 29.201877593994),
		["sPosition"] = {
            vector3(471.83679199219, -1095.6395263672, 28.596483230591),
            vector3(471.88336181641, -1088.8572998047, 28.597497940063),
            vector3(459.08700561523, -1091.2993164063, 28.596431732178),
        },
        ["sHeading"] = {
            88.10,
            90.48,
            269.93,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-694.44525146484, -748.97009277344, 29.350624084473),
		["sPosition"] = {
            vector3(-687.18377685547, -751.38903808594, 28.931135177612),
            vector3(-700.38311767578, -751.27307128906, 28.947069168091),
            vector3(-683.22979736328, -764.10418701172, 29.229839324951),
        },
        ["sHeading"] = {
            178.85,
            178.99,
            0.22,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-576.98199462891, 323.44104003906, 84.677368164062),
		["sPosition"] = {
            vector3(-576.31591796875, 324.31985473633, 84.057235717773),
            vector3(-577.21282958984, 314.00454711914, 84.06404876709),
            vector3(-562.26239013672, 318.71173095703, 83.797294616699),
        },
        ["sHeading"] = {
            176.04,
            353.90,
            84.98,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(376.0910949707, 279.88421630859, 103.13893890381),
		["sPosition"] = {
            vector3(378.53720092773, 281.30340576172, 102.50340270996),
            vector3(371.1379699707, 284.65496826172, 102.64981842041),
            vector3(382.72885131836, 292.00888061523, 102.51000213623),
        },
        ["sHeading"] = {
            340.91,
            339.07,
            166.09,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(810.88684082031, -2408.1333007812, 23.670387268066),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-1650.4202880859, -901.32391357422, 8.6484937667847),
		["sPosition"] = {
            vector3(-1650.4884033203, -904.72174072266, 7.9984865188599),
            vector3(-1640.0513916016, -906.35693359375, 8.0967063903809),
            vector3(-1644.0336914063, -910.88146972656, 7.9920749664307),
        },
        ["sHeading"] = {
            139.46,
            319.32,
            140.83,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-3146.63671875, 1094.67578125, 20.697641372681),
		["sPosition"] = {
            vector3(-3136.9775390625, 1094.3792724609, 20.017923355103),
            vector3(-3138.4177246094, 1086.6394042969, 20.058647155762),
            vector3(-3152.4946289063, 1092.5189208984, 20.099880218506),
        },
        ["sHeading"] = {
            82.54,
            79.44,
            280.71,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-355.50500488281, -93.077239990234, 45.661632537842),
		["sPosition"] = {
            vector3(-358.96826171875, -102.44885253906, 45.057144165039),
            vector3(-362.6357421875, -101.4429397583, 45.059650421143),
            vector3(-369.19232177734, -98.939193725586, 45.057628631592),
        },
        ["sHeading"] = {
            342.10,
            341.83,
            340.36,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-2207.4699707031, 4252.494140625, 47.447635650635),
		["sPosition"] = {
            vector3(-2205.7939453125, 4248.1088867188, 46.993152618408),
            vector3(-2210.7692871094, 4244.3408203125, 46.985778808594),
            vector3(-2214.6098632813, 4239.2270507813, 46.875190734863),
        },
        ["sHeading"] = {
            39.05,
            39.67,
            36.92,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-1146.6231689453, 2668.9641113281, 18.302381515503),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(589.60516357422, 2731.5895996094, 42.057125091553),
		["sPosition"] = {
            vector3(589.56457519531, 2736.3317871094, 41.439151763916),
            vector3(583.37005615234, 2736.0610351563, 41.40726852417),
            vector3(581.28137207031, 2721.1020507813, 41.455070495605),
        },
        ["sHeading"] = {
            184.12,
            181.96,
            4.40,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(1689.5728759766, 4776.31640625, 41.92147064209),
		["sPosition"] = {
            vector3(1691.3846435547, 4778.0068359375, 41.315711975098),
            vector3(1690.9808349609, 4770.1235351563, 41.316822052002),
            vector3(1691.7322998047, 4762.1708984375, 41.314868927002),
        },
        ["sHeading"] = {
            91.91,
            90.17,
            89.76,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(2571.8979492188, 321.80996704102, 108.45532226562),
		["sPosition"] = {
            vector3(2574.7463378906, 311.84078979492, 107.8533782959),
            vector3(2575.3000488281, 327.83016967773, 107.84741210938),
            vector3(2567.2739257813, 328.21185302734, 107.84686279297),
        },
        ["sHeading"] = {
            359.70,
            359.89,
            0.02,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(29.258485794067, -1731.5091552734, 29.301292419434),
		["sPosition"] = {
            vector3(36.822185516357, -1733.9356689453, 28.698902130127),
            vector3(36.108783721924, -1725.6051025391, 28.697244644165),
            vector3(41.181037902832, -1729.568359375, 28.697891235352),
        },
        ["sHeading"] = {
            230.39,
            44.53,
            230.03,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(295.83474731445, -607.89019775391, 43.332038879395),
		["sPosition"] = {
            vector3(296.66143798828, -607.8583984375, 42.653671264648),
            vector3(297.92660522461, -605.25427246094, 42.638690948486),
            vector3(299.19622802734, -602.53759765625, 42.611034393311),
        },
        ["sHeading"] = {
            69.85,
            69.02,
            68.05,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(975.08795166016, -1019.3695068359, 41.045555114746),
		["sPosition"] = {
          	vector3(966.48559570313, -1019.770690918, 40.244083404541),
            vector3(967.20251464844, -1025.5805664063, 40.241268157959),
            vector3(966.34045410156, -1031.0838623047, 40.233577728271),
        },
        ["sHeading"] = {
            271.15,
            268.36,
            273.05,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-445.21682739258, 6048.5654296875, 31.340208053589),
		["sPosition"] = {
          	vector3(-453.2216796875, 6050.380859375, 30.733896255493),
            vector3(-445.29058837891, 6055.0932617188, 30.734832763672),
            vector3(-435.18023681641, 6031.9057617188, 30.735534667969),
        },
        ["sHeading"] = {
            223.46,
            208.62,
            29.76,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(4976.486328125, -5705.8837890625, 19.867332458496),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(5156.3657226562, -4615.7919921875, 2.7846808433533),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(5013.6728515625, -5182.90625, 2.5148439407349),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(4500.6845703125, -4544.7963867188, 4.0230841636658),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(336.85919189453, -621.48919677734, 29.293952941895),
		["sPosition"] = {
          	vector3(336.48236083984, -618.01147460938, 28.688415527344),
            vector3(343.29913330078, -620.16198730469, 28.687368392944),
            vector3(342.3444519043, -632.57067871094, 28.688764572144),
        },
        ["sHeading"] = {
            157.94,
            159.49,
            339.93,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(550.26031494141, -1791.1641845703, 29.197011947632),
		["sPosition"] = {
          	vector3(549.28497314453, -1796.8688964844, 28.592359542847),
            vector3(555.49859619141, -1797.3731689453, 28.590858459473),
            vector3(555.47875976563, -1786.4348144531, 28.591905593872),
        },
        ["sHeading"] = {
            351.87,
            351.06,
            157.87,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-171.49165344238, -2155.1677246094, 16.705106735229),
		["sPosition"] = {
          	vector3(-169.29278564453, -2161.8793945313, 16.100423812866),
            vector3(-176.41331481934, -2164.818359375, 16.098934173584),
            vector3(-181.14556884766, -2149.6994628906, 16.099542617798),
        },
        ["sHeading"] = {
            19.61,
            18.26,
            197.45,
        },
        ["tip"] = "menu"
    },

    {
        ["blip"] = vector3(555.0445556640625, -133.52676391601565, 59.705106735229),
		["sPosition"] = {
          	vector3(549.17095947266, -136.34748840332, 58.723655700684),
            vector3(544.57653808594, -136.91639709473, 58.660430908203),
            vector3(536.60028076172, -136.16217041016, 59.016983032227),
        },
        ["sHeading"] = {
            178.81,
            180.53,
            180.86,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-202.1133270263672, 308.1741027832031, 96.94618225097656),
		["sPosition"] = {
          	vector3(-205.77119445801, 315.04418945313, 96.33992767334),
            vector3(-216.21984863281, 314.89321899414, 96.341102600098),
            vector3(-205.78898620605, 301.55322265625, 96.342819213867),
        },
        ["sHeading"] = {
            179.33,
            179.79,
            3.48,
        },
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(164.32347106933597, -3053.019287109375, 5.91685533523559),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-371.7130126953125, -107.71146392822266, 38.68206405639648),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(-1410.1180419922, 688.23034667969, 186.99926757813),
        ["tip"] = "menu"
    },
    {
        ["blip"] = vector3(431.64825439453, -988.86657714844, 25.69997215271),
        ["job"] = "police",
        ["tip"] = "cekilmis"
    },
    {
        ["blip"] = vector3(-478.90054321289, -361.55905151367, 24.229434967041),
        ["job"] = "ambulance",
        ["tip"] = "cekilmis"
    },
    {
        ["blip"] = vector3(-475.71606445313, -390.91256713867, 24.229349136353),
        ["job"] = "ambulance",
        ["tip"] = "cekilmis"
    },
    {
        ["blip"] = vector3(-139.58996582031, -1172.6452636719, 23.769588470459),
        ["tip"] = "cekilmis"
    },
    {
        ["blip"] = vector3(-741.20788574219, -1344.23828125, 1.5952144861221),
        ["tip"] = "cekilmis-bot",
        ["sPosition"] = vector3(-727.64, -1344.14, 0.0),
        ["sHeading"] = 140.0
    },
    {
        ["blip"] = vector3(1331.451171875, 4226.6733398438, 33.916137695312),
        ["tip"] = "cekilmis-bot",
        ["sPosition"] = vector3(1358.95, 4223.75, 30.0),
        ["sHeading"] = 170.0
    },
    {
        ["blip"] = vector3(5153.2358398438, -4666.6884765625, 1.4359271526337),
        ["tip"] = "cekilmis-bot",
        ["sPosition"] = vector3(5144.82, -4657.46, 0.50),
        ["sHeading"] = 340.5
    },
    {
        ["blip"] = vector3(4936.90234375, -5148.7739257812, 2.4648473262787),
        ["tip"] = "cekilmis-bot",
        ["sPosition"] = vector3(4937.5, -5140.71, 0.50),
        ["sHeading"] = 244.42
    },
    -- Çekilmiş Uçak
    {
        ["blip"] = vector3(-1261.8374023438, -3372.9274902344, 13.938730239868),
        ["tip"] = "cekilmis-ucak"
    },
    {
        ["blip"] = vector3(1770.5375976562, 3239.7939453125, 42.131603240967),
        ["tip"] = "cekilmis-ucak"
    },
    {
        ["blip"] = vector3(481.65008544922, -982.35424804688, 41.006786346436),
        ["tip"] = "cekilmis-ucak",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(4445.423828125, -4489.9526367188, 4.1946783065796),
        ["tip"] = "cekilmis-ucak"
    },
    {
        ["blip"] = vector3(332.7190, -547.3900, 28.7444),
        ["tip"] = "cekilmis-ucak",
        ["job"] = "ambulance"
    },
    

    -- Tekne Garajları
    {
        ["blip"] = vector3(-735.39428710938, -1337.3172607422, 1.5952160358429),
        ["tip"] = "bot",
        ["sPosition"] = vector3(-718.86, -1344.05, 0.0),
        ["sHeading"] = 140.0
    },
    {
        ["blip"] = vector3(550.73046875, -3147.0190429688, 6.0692248344421),
        ["tip"] = "bot",
        ["sPosition"] = vector3(525.66, -3190.12, 0.0),
        ["sHeading"] = 170.0
    },
    {
        ["blip"] = vector3(-3418.8273925781, 967.95782470703, 11.935395240784),
        ["tip"] = "bot",
        ["sPosition"] = vector3(-3443.94, 957.71, 0.0),
        ["sHeading"] = 10.0
    },
    {
        ["blip"] = vector3(-275.53512573242, 6638.1293945312, 7.4661197662354),
        ["tip"] = "bot",
        ["sPosition"] = vector3(-306.35, 6622.04, 0.0),
        ["sHeading"] = 25.0
    },
    {
        ["blip"] = vector3(1335.7205810547, 4225.53515625, 33.915382385254),
        ["tip"] = "bot",
        ["sPosition"] = vector3(1293.01, 4198.08, 29.0),
        ["sHeading"] = 170.0
    },
    {
        ["blip"] = vector3(3865.8369140625, 4462.9389648438, 2.7338531017303),
        ["tip"] = "bot",
        ["sPosition"] = vector3(3896.53, 4470.24, 0.43),
        ["sHeading"] = 199.5
    },
    {
        ["blip"] = vector3(5094.3388671875, -4655.8334960938, 0.75716763734818),
        ["tip"] = "bot",
        ["sPosition"] = vector3(5114.15, -4652.37, 0.49),
        ["sHeading"] = 260.0
    },
    {
        ["blip"] = vector3(4930.423828125, -5174.2563476562, 2.4799265861511),
        ["tip"] = "bot",
        ["sPosition"] = vector3(4926.2, -5163.88, 0.26),
        ["sHeading"] = 250.5
    },
    {
        ["blip"] = vector3(4764.373046875, -4780.6928710938, 3.8013296127319),
        ["tip"] = "bot",
        ["sPosition"] = vector3(4756.85, -4792.13, 0.5),
        ["sHeading"] = 50.0
    },
    -- Uçak Garajları
    {
        ["blip"] = vector3(-1645.3657226562, -3126.8151855469, 13.98985004425),
        ["tip"] = "ucak"
    },
    {
        ["blip"] = vector3(1732.0317382812, 3299.0505371094, 41.22346496582),
        ["tip"] = "ucak"
    },
    {
        ["blip"] = vector3(4890.8735351562, -5736.833984375, 26.350637435913),
        ["tip"] = "ucak"
    },
    {
        ["blip"] = vector3(4458.9516601562, -4508.5249023438, 4.1810331344604),
        ["tip"] = "ucak"
    },
    {
        ["blip"] = vector3(4882.638671875, -5283.3471679688, 8.4362916946411),
        ["tip"] = "ucak"
    },

    -- PD Garajlar
    { -- Polis Alt kat
        ["blip"] = vector3(452.35800170898, -990.40979003906, 25.69997215271),
        ["tip"] = "meslek-polis-arac",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(1867.3264160156, 3698.5588378906, 33.537078857422),
        ["tip"] = "meslek-polis-arac",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(-467.63912963867, 6029.3862304688, 31.340179443359),
        ["tip"] = "meslek-polis-arac",
        ["job"] = "police"
    },
    { -- PD Arka Garaj
        ["blip"] = vector3(476.39581298828, -1022.8016357422, 28.066631317139),
        ["tip"] = "meslek-polis-arac",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(828.33557128906, -1263.8101806641, 26.275793075562),
        ["tip"] = "meslek-polis-arac",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(334.78607177734, -578.31896972656, 28.796854019165),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },
    -- Sivil PD Garajları
    {
        ["blip"] = vector3(441.22747802734, -1024.2971191406, 28.702247619629),
        ["tip"] = "meslek-policesivil-arac",
        ["job"] = "police"
    },
    -- EMS Garajları
    {
        ["blip"] = vector3(289.91369628906, -588.79272460938, 43.17712020874),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },

    {
        ["blip"] = vector3(-455.28005981445, -343.37548828125, 34.359741210938),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },
    





    {
        ["blip"] = vector3(-267.14459228516, 6334.9541015625, 32.4245262146),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },
    {
        ["blip"] = vector3(1825.7413330078, 3692.4487304688, 34.207405090332),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },
    {
        ["blip"] = vector3(334.78607177734, -578.31896972656, 28.796854019165),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },
    { --sahil
        ["blip"] = vector3(-829.01318359375, -1217.4436035156, 6.9341173171997),
        ["tip"] = "meslek-ems-arac",
        ["job"] = "ambulance"
    },

    --EMS Heli
    {
        ["blip"] = vector3(354.88461303711, -579.71478271484, 74.161720275879),
        ["tip"] = "meslek-ems-heli",
        ["job"] = "ambulance"
    },
    {
        ["blip"] = vector3(-451.51275634766, -307.78482055664, 78.168113708496),
        ["tip"] = "meslek-ems-heli",
        ["job"] = "ambulance"
    },
    {
        ["blip"] = vector3(-252.9344329834, 6319.2827148438, 39.659641265869),
        ["tip"] = "meslek-ems-heli",
        ["job"] = "ambulance"
    },
    {
        ["blip"] = vector3(1771.0954589844, 3651.5827636719, 34.421672821045),
        ["tip"] = "meslek-ems-heli",
        ["job"] = "ambulance"
    },
    {
        ["blip"] = vector3(1771.0954589844, 3651.5827636719, 34.421672821045),
        ["tip"] = "meslek-ems-heli",
        ["job"] = "ambulance"
    },

    -- Polis Heli
    {
        ["blip"] = vector3(450.02969360352, -981.80834960938, 43.691619873047),
        ["tip"] = "meslek-police-heli",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(-475.51397705078, 5988.4970703125, 31.336685180664),
        ["tip"] = "meslek-police-heli",
        ["job"] = "police"
    },
    {
        ["blip"] = vector3(1771.6671142578, 3651.4362792969, 34.415691375732),
        ["tip"] = "meslek-police-heli",
        ["job"] = "police"
    },
    -- Motor Garaj
    {
        ["blip"] = vector3(1770.2053222656, 3652.7995605469, 34.41898727417),
        ["tip"] = "meslek-motor-arac",
        ["job"] = "motor"
    },
    -- Özel Güvenlik Garaj
    {
        ["blip"] = vector3(506.07855224609, -3133.7661132812, 6.0697693824768),
        ["tip"] = "meslek-mafia-arac",
        ["job"] = "mafia"
    },
    -- İlk Girij Garajı
    {
        ["blip"] = vector3(415.74850463867, -650.23895263672, 28.500078201294),
        ["tip"] = "meslek-unemployed-arac",
        ["job"] = "unemployed"
    },
    -- Polis Tekne
    {
        ["blip"] = vector3(-885.18078613281, -1394.5736083984, 3.2579383850098),
        ["tip"] = "meslek-police-bot",
        ["job"] = "police",
        ["sPosition"] = vector3(-844.78, -1417.81, -0.41),
        ["sHeading"] = 180.0
    },
    {
        ["blip"] = vector3(-1627.9114990234, -1165.7196044922, 3.2277910709381),
        ["tip"] = "meslek-police-bot",
        ["job"] = "police",
        ["sPosition"] = vector3(-1633.72, -1177.5, 0.41),
        ["sHeading"] = 137.0
    },
    {
        ["blip"] = vector3(715.44836425781, 4093.0217285156, 33.978687286377),
        ["tip"] = "meslek-police-bot",
        ["job"] = "police",
        ["sPosition"] = vector3(714.57, 4077.6, 30.90),
        ["sHeading"] = 174.0
    },

    -- EMS Tekne
    {
        ["blip"] = vector3(-885.18078613281, -1394.5736083984, 3.2579383850098),
        ["tip"] = "meslek-ems-bot",
        ["job"] = "ambulance",
        ["sPosition"] = vector3(-844.78, -1417.81, -0.41),
        ["sHeading"] = 180.0
    },
    {
        ["blip"] = vector3(-1627.9114990234, -1165.7196044922, 3.2277910709381),
        ["tip"] = "meslek-ems-bot",
        ["job"] = "ambulance",
        ["sPosition"] = vector3(-1633.72, -1177.5, 0.41),
        ["sHeading"] = 137.0
    },
    {
        ["blip"] = vector3(715.44836425781, 4093.0217285156, 33.978687286377),
        ["tip"] = "meslek-ems-bot",
        ["job"] = "ambulance",
        ["sPosition"] = vector3(714.57, 4077.6, 30.90),
        ["sHeading"] = 174.0
    },

        -- Gece Kulübü Garaj
    {
        ["blip"] = vector3(323.93579101562, 341.75567626953, 105.19658660889),
        ["tip"] = "meslek-night-arac",
        ["job"] = "nightclub"
    },
    --wn
    {
        ["blip"] = vector3(-553.15002441406, -930.3017578125, 23.862089157104),
        ["tip"] = "meslek-wn-arac",
        ["job"] = "news"
    },
    {
        ["blip"] = vector3(-583.72424316406, -930.72985839844, 36.832889556885),
        ["tip"] = "meslek-wn-heli",
        ["job"] = "news"
    },
    {
        ["blip"] = vector3(-512.711181640625, -262.2513732910156, 35.42401885986328),
        ["tip"] = "meslek-avuKat",
        ["job"] = "avukat"
    },
    {
        ["blip"] = vector3(-604.83251953125, -987.68719482422, 21.741500854492),
        ["tip"] = "menu",
    },
}

Config.policeVehicle = {
    { model = 'npolmm', label = 'Police Offroad Motorcycles', price = 100, type ="car", job ="police"},
    { model = 'npolvic', label = 'Police Crown Victoria', price = 250, type ="car", job ="police"},
    { model = 'npolchar', label = 'Police Dodge Charger', price = 250, type ="car", job ="police"},
    { model = 'polraptor', label = 'Police Raptor', price = 1000, type ="car", job ="police"},
    { model = 'npolexp', label = 'Police Ford Explorer', price = 250, type ="car", job ="police"},
    { model = 'npoltaurus', label = 'Police Ford Taurus', price = 250, type ="car", job ="police"},
    { model = 'npolstang', label = 'Ford Mustang', price = 5000, type ="car", job ="police"},
    { model = 'npolchal', label = 'Dodge Challenger Demon', price = 5000, type ="car", job ="police"},
    { model = 'npolvette', label = 'Corvette C7 - HSU', price = 5000, type ="car", job ="police"},
    { model = 'clrgc8', label = 'Corvette C8 - HSU', price = 10000, type ="car", job ="police"},
    { model = 'clrgr1200', label = 'BMW R1200 - HSU', price = 2500, type ="car", job ="police"},
    { model = 'bcat', label = 'Police BearCat', price = 5000, type ="car", job ="police"},
    { model = 'policet', label = 'Van Transport Vehicle', price = 250, type ="car", job ="police" },
    { model = 'pbus', label = 'Bus Transport', price = 250, type ="car", job ="police" },
    { model = 'dilettante', label = 'Learner Vehicle', price = 50, type ="car", job ="police"},
}

Config.policeBoat = {
    { model = 'predator', label = 'Police Boat', price = 240, type ="boat", job ="police"},
    { model = 'pspjski', label = 'Police Jet Ski', price = 240, type ="boat", job ="police"},
}

Config.emsVehicle = {
	{ model = 'emsnspeedo', label = 'EMS Speedo', price = 50, type ="car", job ="ambulance"},
    { model = 'clrgemsexp', label = 'EMS Explorer', price = 340, type ="car", job ="ambulance"},
    { model = 'emsc', label = 'EMS Charger', price = 250, type ="car", job ="ambulance"},
    { model = 'emsf', label = 'EMS Ford F150', price = 500, type ="car", job ="ambulance"},
    { model = 'ramero', label = 'Funeral Vehicle', price = 50, type ="car", job ="ambulance"},
}

Config.emsBoat = {
    { model = 'seashark2', label = 'EMS Jet Ski', price = 240, type ="boat", job ="ambulance"},
    { model = 'dinghy', label = 'EMS Boat', price = 500, type ="boat", job ="ambulance"},
}

Config.emsHeli = {
	{ model = 'emsaw139', label = 'EMS Helicopter', price = 2500, type ="helicopter", job ="ambulance", livery = 1},
}

Config.policeHeli = {
    { model = 'polas350', label = 'Police Helicopter', price = 3500, type ="helicopter", job ="police", livery = 1},
    { model = 'seasparrow2', label = 'Sea Sparrow', price = 1000, type ="helicopter", job ="police", livery = 1},
}

Config.motorVehicle = {
    { model = 'daemon', label = 'Contander', price = 15000, type ="car", job ="motor"},
    { model = 'hexer', label = 'Hexer', price = 14000, type ="car", job ="motor" },
    { model = 'zombieb', label = 'Zombie Chopper', price = 16000, type ="car", job ="motor" },
    { model = 'zombiea', label = 'Zombie Bobber', price = 18000, type ="car", job ="motor"},
    { model = 'gburrito', label = 'Gang Burrito', price = 8000, type ="car", job ="motor"},
    { model = 'slamvan2', label = 'Lost Slamvan', price = 15000, type ="car", job ="motor"},
}

Config.mafiaVehicle = {
    { model = 'schafter5', label = 'Schafter V12 (Armored)', price = 2000, type ="car", job ="mafia" },
	{ model = 'baller6', label = 'Baller LE LWB (Armored)', price = 4000, type ="car", job ="mafia" },
	{ model = 'xls2', label = 'XLS (Armored)', price = 6000, type ="car", job ="mafia" },	
	{ model = 'cog552', label = 'Cognoscenti 55 (Armored)', price = 8000, type ="car", job ="mafia" },
}

Config.jobVehicle = {
    { model = 'cruiser', label = 'Cruiser', price = 250, type ="car", job ="unemployed" },
}

Config.nightVehicle = {
    { model = 'pbus2', label = 'Party Bus', price = 250, type ="car", job ="nightclub" },
    { model = 'stretch', label = 'Stretch', price = 250, type ="car", job ="nightclub" },
}

Config.sivilpd = {
    { model = 'ucballer', label = 'Civil Baller', price = 10000, type ="car", job ="police", tint = 2 },
    { model = 'ucwashington', label = 'Civil Washington', price = 10000, type ="car", job ="police", tint = 2  },
}

Config.wnVehicle = {
    { model = 'newsvan', label = 'Van', price = 1000, type ="car", job ="news" },
}

Config.wnHeli = {
    { model = 'newsheli2', label = 'News Helicopter', price = 5000, type ="helicopter", job ="news" },
}

Config.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Config.AlignMenu = "right" -- this is where the menu is located [left, right, center, top-right, top-left etc.]
