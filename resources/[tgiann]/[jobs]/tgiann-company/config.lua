itemList = {"kola", "ayran", "atom", "tavukmenu", "etmenu", "makarna", "pburger", "burgerl", "burgerm", "burgers", "burgerxl", "domates2", "friesl", "friesm", "friess", "friesxl", "hotdogl", "hotdogm", "hotdogs", "hotdogxl", "kolal", "kolam", "kolas", "marul2", "patates2","sogan2", "tacok", "tacos", "tacot", "tacoxl", "tburgerl", "tburgerm", "tburgers", "tburgerxl","sushi", "mochi","wakame","ramen","generaltso","macha","latte","pogacapatates","pogacadomates","kekuzum","kahvekek","graphius","americano","raki","karidesizgara","mezetabagi","balikizgara","ahtapotsalata"}

blips = {
    ["burger"] = {
        ["coord"] = vector3(-1196.94, -894.05, 14.0),
        ["name"] = "Burger Shot",
        ["sprite"] = 106,
    },
    -- ["kahve"] = {
    --     ["coord"] = vector3(-629.6, 234.72, 81.88),
    --     ["name"] = "Bean Machine Cafe",
    --     ["sprite"] = 106,
    -- },
    -- -- ["chicken"] = {
    -- --     ["coord"] = vector3(-376.11, 269.9, 86.42),
    -- --     ["name"] = "Anadolu Tat 1071",
    -- --     ["sprite"] = 89,
    -- -- },
    -- ["hotdog"] = {
    --     ["coord"] = vector3(45.624305725098, -1007.6956176758, 27.287910461426),
    --     ["name"] = "LS Hotdog",
    --     ["sprite"] = 80,
    -- },
    -- ["taco"] = {
    --     ["coord"] = vector3(95.98, -1294.37, 29.26),
    --     ["name"] = "Unicorn",
    --     ["sprite"] = 121,
    -- },
}

-- Kesilebilir
cuttingItems = {
    ["domates2"] = "domates",
    ["sogan2"] = "sogan",
    ["marul2"] = "marul",
    ["patates2"] = "patates",
    ["ekmek"] = "hamur",
    ["ketcap"] = "domates",
    ["kiyma"] = "dana_eti",
    ["sosis"] = "kiyma",
}

cuttingCoords = {
    ["taco"] = vector3(130.65, -1281.59, 29.27),
    ["hotdog"] = vector3(44.624305725098, -1006.6956176758, 29.287910461426),
    ["chicken"] = vector3(-385.03, 267.21, 86.71),
    ["burger"] = vector3(-1198.93, -898.24, 14.0),
    ["popsdiner"] = vector3(1587.3607177734, 6459.1459960938, 26.014015197754),
    ["balik"] = vector3(-1842.6488037109, -1184.7612304688, 14.487835083008),
    ["kahve"] = vector3(-632.28, 224.39, 81.88),
    ["japon"] = vector3(-174.55816650391, 303.9856262207, 97.459999084473),
}

-- Patates Kızartması
frieItem = {
    ["friess"] = {
        ["patates2"] = 1,
        ["tuz"] = 1
    },
    ["friesm"] = {
        ["patates2"] = 2,
        ["tuz"] = 1
    },
    ["friesl"] = {
        ["patates2"] = 3,
        ["tuz"] = 1
    },
    ["friesxl"] = {
        ["patates2"] = 4,
        ["tuz"] = 1
    },
}

friesCoords = {
    ["taco"] = vector3(417.69107055664, -1918.9669189453, 25.471240997314),
    ["hotdog"] = vector3(41.027584075928, -1008.0799560547, 29.28670501709),
    ["chicken"] = vector3(-380.88, 264.19, 86.71),
    ["burger"] = vector3(-1201.78, -899.08, 14.0),
    ["balik"] = vector3(-1844.5798339844, -1187.4875488281, 14.327179908752),
    ["japon"] = vector3(-172.72979736328, 300.82638549805, 97.459976196289),
}

-- İçecekler
drinkItem = {
    ["atom"] = {
        ["portakal_suyu"] = 1,
        ["domates_suyu"] = 1,
        ["havuc"] = 1
    },
    ["portakal_suyu"] = {
        ["portakal"] = 2
    },
    ["domates_suyu"] = {
        ["domates"] = 2,
    },
    ["ayran"] = {
        ["sut"] = 2,
        ["tuz"] = 1,
        ["water"] = 1,
    },
    ["kola"] = {
        ["atom"] = 1,
        ["water"] = 2,
    },
    ["cay"] = {
        ["water"] = 1,
    }
}

drinkCoords = {
    ["taco"] = vector3(133.44, -1286.61, 29.27),
    ["hotdog"] = vector3(45.46524810791, -1009.8017578125, 29.487492752075),
    ["chicken"] = vector3(-384.07, 261.62, 86.71),
    ["burger"] = vector3(-1199.0432128906, -895.92626953125, 14.295237350464),
    ["popsdiner"] = vector3(1592.408203125, 6457.0830078125, 26.014015197754),
    ["balik"] = vector3(-1837.8427734375, -1183.4519042969, 14.325386047363),
    ["kahve"] = vector3(-635.54, 236.7, 82.48),
    ["japon"] = vector3(-171.80149841309, 307.91458129883, 97.990966796875),
}

-- Yiyecekler
foodItems = {
    ["taco"] = {
        ["vodka"] = { --Churro
            ["aetilalkol"] = 1,
            ["water"] = 1,
        },
        ["vodkaenergy"] = { --Nacho
            ["vodka"] = 1,
            ["enerji_icecegi"] = 1,
        },
        ["whisky"] = { --Burrito
            ["aetilalkol"] = 1,
            ["viski_cubugu"] = 1,
        },
        ["beer"] = { --Burrito
            ["aetilalkol"] = 1,
            ["maya"] = 1,
       },
        ["whiskycoca"] = { --Taco
            ["whisky"] = 1,
            ["kola"] = 1,
        }
    },
    ["hotdog"] = {
        ["hotdogs"] = { --Mac Cheese
            ["hamur"] = 4,
            ["sut"] = 2,
            ["tuz"] = 1,
            ["limon"] = 1,
        },
        ["hotdogm"] = { --Corn Dog
            ["hamur"] = 2,
            ["sosis"] = 2,
            ["tuz"] = 1,
            ["ketcap"] = 1,
            ["limon"] = 1,
        },
        ["hotdogl"] = { --Sosisli Sandviç
            ["ekmek"] = 1,
            ["sosis"] = 2,
            ["marul2"] = 2,
            ["ketcap"] = 1,
        },
        ["hotdogxl"] = { --Mozarella Çubuğu
            ["hamur"] = 1,
            ["sut"] = 4,
            ["misir"] = 2,
            ["ketcap"] = 2,
            ["tuz"] = 1,
        }
    },
    ["chicken"] = {
        ["tburgers"] = { --Zurna Tavuk Dürüm
            ["packaged_chicken"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["tuz"] = 1,
        },
        ["tburgerm"] = { --Sezar Salata
            ["packaged_chicken"] = 1,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["domates2"] = 2,
            ["tuz"] = 1,
        },
        ["tburgerl"] = { --Tavuk Kova
            ["packaged_chicken"] = 5,
            ["limon"] = 1,
            ["tuz"] = 1,
        },
        ["tburgerxl"] = { --Tavuk Burger
            ["packaged_chicken"] = 1,
            ["ekmek"] = 1,
            ["marul2"] = 2,
            ["tuz"] = 1,
            ["domates2"] = 2
        }
    },
    ["burger"] = {
        ["burgers"] = { --Soğan Halkası
            ["tuz"] = 1,
            ["sogan2"] = 4,
            ["ketcap"] = 2,
            ["hamur"] = 1,
        },
        ["burgerm"] = { -- Islak Hamburger
            ["domates2"] = 1,
            ["sogan2"] = 1,
            ["ketcap"] = 2,
            ["kiyma"] = 2,
            ["ekmek"] = 1,
        },
        ["burgerl"] = { --Biftek
            ["domates2"] = 2,
            ["sogan2"] = 2,
            ["tuz"] = 2,
            ["dana_eti"] = 5,
            ["ekmek"] = 1,
        },
        ["burgerxl"] = { --Burger
            ["domates2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["kiyma"] = 2,
            ["ekmek"] = 1,
        }
    },
    ["popsdiner"] = {
        ["tavukmenu"] = {--Tavuklu Pilav
            ["domates2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["packaged_chicken"] = 2,
            ["tuz"] = 1,
        },
        ["etmenu"] = { --Soğanlı Köfte
            ["domates2"] = 1,
            ["sogan2"] = 3,
            ["marul2"] = 1,
            ["kiyma"] = 3,
            ["tuz"] = 1,
        },
        ["makarna"] = {--Kuru Fasulye Pilav
            ["domates2"] = 1,
            ["sogan2"] = 2,
            ["marul2"] = 1,
            ["kiyma"] = 2,
            ["hamur"] = 2,
        },
        ["pburger"] = { --Mercimek Çorbası
            ["domates2"] = 1,
            ["sogan2"] = 1,
            ["marul2"] = 1,
            ["limon"] = 2,
            ["ekmek"] = 2,
        },
    },
    ["balik"] = {
        ["ahtapotsalata"] = {
            ["ahtapot"] = 1,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["limon"] = 2,
            ["tuz"] = 1,
        },
        ["balikizgara"] = {
            ["baliketi"] = 5,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["domates2"] = 2,
            ["tuz"] = 1,
        },
        ["mezetabagi"] = {
            ["domates2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["kiyma"] = 1,
            ["packaged_chicken"] = 1,
        },
        ["karidesizgara"] = {
            ["karides"] = 2,
            ["sogan2"] = 1,
            ["marul2"] = 1,
            ["limon"] = 2,
            ["tuz"] = 1,
            ["domates2"] = 1,
        },
        ["raki"] = {
            ["water"] = 5,
            ["buz"] = 1,
        },
    },
    ["kahve"] = {
        ["americano"] = {
            ["kahvea"] = 5,
            ["water"] = 2,
        },
        ["graphius"] = {
            ["water"] = 3,
            ["buz"] = 1,
            ["limon"] = 1,
            ["grapperaisin"] = 2,
        },
        ["kahvekek"] = {
            ["kahvea"] = 2,
            ["hamur"] = 2,
            ["tuz"] = 2,
        },
        ["kekuzum"] = {
            ["grapperaisin"] = 2,
            ["hamur"] = 2,
            ["tuz"] = 2,
        },
        ["pogacadomates"] = {
            ["domates2"] = 2,
            ["hamur"] = 4,
            ["tuz"] = 1,
        },
        ["pogacapatates"] = {
            ["patates2"] = 2,
            ["hamur"] = 4,
            ["tuz"] = 1,
        },
        ["latte"] = {
            ["kahvea"] = 4,
            ["sut"] = 2,
            ["water"] = 2,
        },
        ["macha"] = {
            ["kahvea"] = 4,
            ["sut"] = 2,
            ["water"] = 2,
        },
    },
    ["japon"] = {
        ["generaltso"] = {
            ["domates2"] = 2,
            ["packaged_chicken"] = 4,
            ["tuz"] = 1,
            ["misir"] = 1,
        },
        ["ramen"] = {
            ["patates2"] = 2,
            ["water"] = 2,
            ["tuz"] = 1,
            ["misir"] = 2,
            ["dana_eti"] = 2,
        },
        ["wakame"] = {
            ["domates2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["yosun"] = 2,
            ["water"] = 1,
        },
        ["mochi"] = {
            ["misir"] = 4,
            ["sut"] = 2,
            ["water"] = 1,
            ["hamur"] = 1,
        },
        ["sushi"] = {
            ["baliketi"] = 6,
            ["yosun"] = 6,
            ["marul2"] = 1,
        },
    },
}

foodCoords = {
    ["taco"] = vector3(129.44, -1279.77, 29.27), 
    ["hotdog"] = vector3(42.253612518311, -1008.5904541016, 29.286949157715),
    ["chicken"] = vector3(-385.25, 264.76, 86.71),
    ["burger"] = vector3(-1198.34, -897.71, 14.0),
    ["popsdiner"] = vector3(1589.0091552734, 6458.5395507812, 26.014015197754),
    ["balik"] = vector3(-1843.7353515625, -1185.8426513672, 14.32753944397),
    ["kahve"] = vector3(-629.43, 222.88, 81.8),
    ["japon"] = vector3(-178.87199401855, 300.80615234375, 97.460014343262)
}

-- Depo
storageCoord = {
    ["taco"] = vector3(93.55, -1290.45, 28.96),
    ["hotdog"] = vector3(43.676856994629, -1008.8042602539, 29.287187576294),
    ["chicken"] = vector3(-381.84, 262.41, 86.71),
    ["burger"] = vector3(-1197.68, -894.39, 14.0),
    ["popsdiner"] = vector3(1585.931640625, 6459.7778320312, 26.014015197754),
    ["balik"] = vector3(-1837.6662597656, -1187.8695068359, 14.322218894958),
    ["kahve"] = vector3(-631.92, 228.3, 81.8),
    ["japon"] = vector3(-177.48651123047, 308.47329711914, 97.99097442627),
    ["picler"] = vector3(418.61, -1503.09, 30.16),
}

-- Tezgah
tableCoord = {
    ["taco"] = vector3(128.73, -1284.48, 29.281240997314),
    ["hotdog"] = vector3(43.849662780762, -1004.7572631836, 29.287828445435),
    ["chicken"] = vector3(-382.4, 265.9, 86.31),
    ["burger"] = vector3(-1195.0285644531, -892.33166503906, 13.995308876038),
    ["popsdiner"] = vector3(1590.6541748047, 6455.2075195312, 26.014015197754),
    ["balik"] = vector3(-1831.6990966797, -1184.4224853516, 14.530296516418),
    ["kahve"] = vector3(-634.41, 234.89, 81.88),
    ["japon"] = vector3(-170.96376037598, 295.07266235352, 93.682060241699),
    ["picler"] = vector3(414.07, -1496.79, 30.16),
}

--Patron
bossCoord = {
    ["taco"] = vector3(96.63, -1294.23, 29.06),
    ["hotdog"] = vector3(41.347591400146, -1004.6605834961, 29.287342071533),
    ["chicken"] = vector3(-365.13, 277.31, 86.71),
    ["burger"] = vector3(-1178.33, -895.659, 13.856),
    ["popsdiner"] = vector3(1595.248046875, 6455.6264648438, 26.014039993286),
    ["balik"] = vector3(-1841.0218505859, -1190.3157958984, 14.322540283203),
    ["kahve"] = vector3(-633.99, 228.67, 81.88),
    ["japon"] = vector3(-174.30589294434, 300.91842651367, 100.92323303223),
    ["picler"] = vector3(411.37, -1500.95, 33.81),
}

masalar = {
    vector3(33.665084838867, -1780.6219482422, 29.616176605225),
    vector3(29.48051071167, -1777.419921875, 29.616176605225),
    vector3(34.644554138184, -1774.8414306641, 29.616176605225),
    vector3(38.75313949585, -1777.9504394531, 29.616176605225),
    vector3(40.183586120605, -1773.3415527344, 29.616176605225),
    vector3(36.106800079346, -1770.1354980469, 29.616176605225),
    vector3(41.125106811523, -1766.2125244141, 29.616176605225),
    vector3(45.258739471436, -1769.3726806641, 29.616176605225),
    vector3(66.300773620605, -1745.4208984375, 29.616189956665),
    vector3(62.12414932251, -1742.2664794922, 29.616189956665),
    vector3(68.51481628418, -1740.2514648438, 29.616189956665),
    vector3(64.33521270752, -1737.0854492188, 29.616189956665),
    vector3(69.57234954834, -1732.9938964844, 29.616189956665),
    vector3(73.781883239746, -1736.1984863281, 29.616189956665),
    vector3(75.770469665527, -1731.6628417969, 29.616189956665),
    vector3(71.767654418945, -1728.4621582031, 29.616189956665),
	--Burger Shot
    vector3(-1190.88, -891.87, 13.83),
    vector3(-1191.74, -886.67, 13.83),
    vector3(-1193.47, -888.3, 13.83),
    vector3(-1194.42, -883.41, 13.83),
    vector3(-1191.82, -881.76, 13.83),
    vector3(-1188.94, -880.54, 13.83),
    vector3(-1186.97, -882.48, 13.83),
    vector3(-1183.05, -888.05, 13.83),
    vector3(-1182.27, -890.76, 13.83),
    vector3(-1184.31, -892.96, 13.83),
    vector3(-1186.75, -894.62, 13.83),
    vector3(-1188.65, -891.26, 13.83),
    vector3(113.4, -1302.98, 28.89),
	--Unicorn
	vector3(117.46, -1282.93, 27.96),
	vector3(115.889, -1286.92, 27.96),
    vector3(112.79, -1283.21, 27.96),
    vector3(120.9, -1285.21, 27.56),
    vector3(116.56, -1291.43, 27.56),
    vector3(119.97, -1296.76, 28.56),
    vector3(123.25, -1294.76, 28.56),
    vector3(123.25, -1294.76, 28.56),
	--Hotdog
	vector3(46.58, -1002.86, 29.1),
	vector3(50.23, -1004.13, 29.1),
	vector3(48.63, -1006.85, 29.1),
	vector3(47.9, -1009.96, 29.1),
	--Lucky Plucker
	vector3(135.8, -1469.37, 29.36),
	vector3(133.43, -1467.14, 29.36),
	vector3(139.16, -1462.95, 29.36),
    --Balik
    vector3(-1840.2846679688, -1204.9530029297, 14.552080154419),
    vector3(-1836.1997070312, -1203.87890625, 14.552080154419),
    vector3(-1833.61328125, -1208.1551513672, 14.552080154419),
    vector3(-1829.6447753906, -1207.4066162109, 14.552080154419),
    vector3(-1828.4405517578, -1203.2294921875, 14.552080154419),
    vector3(-1832.5231933594, -1201.1127929688, 14.552080154419),
    vector3(-1836.5817871094, -1198.6638183594, 14.552080154419),
    vector3(-1832.6630859375, -1193.4226074219, 14.552080154419),
    vector3(-1828.9479980469, -1195.4968261719, 14.552080154419),
    vector3(-1825.8192138672, -1197.3035888672, 14.552080154419),
    vector3(-1824.0936279297, -1194.3939208984, 14.552080154419),
    vector3(-1827.5718994141, -1192.2653808594, 14.552080154419),
    vector3(-1830.7586669922, -1190.365234375, 14.552080154419),
    vector3(-1828.8022460938, -1183.9342041016, 14.552080154419),
    vector3(-1824.5405273438, -1186.265625, 14.552080154419),
    vector3(-1820.353515625, -1188.8376464844, 14.552080154419),
    vector3(-1822.1733398438, -1201.5892333984, 14.469674110413),
    vector3(-1816.8778076172, -1187.0732421875, 13.984181404114),
    vector3(-1814.4306640625, -1184.8947753906, 13.984181404114),
    vector3(-1821.2265625, -1184.2731933594, 13.984181404114),
    vector3(-1822.3626708984, -1179.9044189453, 13.984181404114),
    vector3(-1826.1713867188, -1180.0164794922, 13.984181404114),
    --Japon
    vector3(-164.84973144531, 286.92901611328, 93.762176513672),
    vector3(-161.55630493164, 287.03305053711, 93.762176513672),
    vector3(-158.29585266113, 287.06555175781, 93.762176513672),
    vector3(-154.72160339355, 289.67755126953, 93.762176513672),
    vector3(-150.25831604004, 288.89520263672, 93.762176513672),
    vector3(-150.25033569336, 292.18774414062, 93.762176513672),
    vector3(-150.28656005859, 295.36972045898, 93.762176513672),
    vector3(-150.37875366211, 298.55282592773, 93.762176513672),
    vector3(-159.22843933105, 296.38037109375, 93.762100219727),
    vector3(-159.9708404541, 293.38592529297, 93.762100219727),
    vector3(-163.21682739258, 293.35998535156, 93.762100219727),
    vector3(-163.10118103027, 290.14547729492, 93.762100219727),
    vector3(-160.02345275879, 290.25802612305, 93.762100219727),
    vector3(-171.46026611328, 297.26974487305, 98.892311096191),
    vector3(-171.46688842773, 291.82559204102, 98.892379760742),
    vector3(-163.92218017578, 292.36376953125, 98.892379760742),
    vector3(-156.30335998535, 292.08441162109, 98.892379760742),
    -- Bean Machine
    vector3(-624.67, 235.93, 81.43),
    vector3(-629.91, 236.57, 81.38),
    vector3(-627.1, 231.51, 81.39),
    vector3(-619.44, 231.27, 81.38),
    vector3(-632.45, 224.38, 85.87),
}