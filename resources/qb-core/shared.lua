QBShared = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

QBShared.RandomStr = function(length)
	if length > 0 then
		return QBShared.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

QBShared.RandomInt = function(length)
	if length > 0 then
		return QBShared.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

QBShared.SplitStr = function(str, delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find( str, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( str, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( str, delimiter, from  )
	end
	table.insert( result, string.sub( str, from  ) )
	return result
end

QBShared.Round = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

-- credit https://richard.warburton.it
QBShared.GroupDigits = function(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' ..","):reverse())..right
end

QBShared.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

QBShared.setJobMoney = function(job, grade, money)
	QBShared.Jobs[job].grade[grade].payment = money
end

QBShared.RequestAnimDict = function(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

	--["ironoxide"] 				 	 = {["name"] = "ironoxide", 			  		["label"] = "Ijzer Poeder", 			["weight"] = 100, 		["type"] = "item", 		["image"] = "ironoxide.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = {accept = {"aluminumoxide"}, reward = "thermite", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Poeders mixen..", ["timeOut"] = 10000}},   ["description"] = "Wat poeder om mee te mixen."},
	--["lockpick"] 					 = {["name"] = "lockpick", 			 	  	  	["label"] = "Lockpick", 				["weight"] = 300, 		["type"] = "item", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = {accept = {"screwdriverset"}, reward = "advancedlockpick", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Lockpick maken", ["timeOut"] = 7500,}},   ["description"] = "Als je af en toe de sleutels vergeet is het niet meer zo erg.. Of je gebruikt het ergens anders voor.."},
	--["smoketrailred"] 			 = {["name"] = "smoketrailred", 				["label"] = "Rookpatroon Rood", 		["weight"] = 50,	 	["type"] = "item", 			["unique"] = true, 	    ["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Laat een rood rookspoor achter tijdens het vliegen. Woot!"},

-- -- PD Silahları
-- [`weapon_m4`]       			 = {['name'] = 'weapon_m4',     				['label'] = 'PD M4',        			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',    		['image'] = 'np_m4.png',            		['unique'] = true, 		['useable'] = true, 	['description'] = 'PD M4'},
-- [`weapon_glock`]    			 = {['name'] = 'weapon_glock',  				['label'] = 'PD Glock',     			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',   		['image'] = 'np_glock.png',         		['unique'] = true, 		['useable'] = true, 	['description'] = 'PD Glock'},
-- [`weapon_ltl`]      			 = {['name'] = 'weapon_ltl',    				['label'] = 'PD Shotgun',   			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',  		['image'] = 'np_pump-shotgun.png',  ['unique'] = true, 		['useable'] = true, 	        ['description'] = 'PD Shotgun'},
-- [`weapon_taser`]    			 = {['name'] = 'weapon_taser',  				['label'] = 'PD Taser',	        		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_TASER',    		['image'] = 'np_stun-gun.png',  ['unique'] = true, 		['useable'] = true, 	                  ['description'] = 'PD Taser'},
-- [`weapon_specialcarbine_mk2`]    = {['name'] = 'weapon_specialcarbine_mk2',  	['label'] = 'PD Scar 17',	        	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',    		['image'] = 'np_scar',     	    ['unique'] = true, 		['useable'] = true, 	['description'] = 'PD Scar 17'},
-- [`weapon_railgun`] 				 = {['name'] = 'weapon_railgun', 		 	  	['label'] = 'PD EMP Launcher', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_EMP',				['image'] = 'empgun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A weapon that uses electromagnetic force to launch high velocity projectiles'},
-- [`weapon_m14`]                   = {['name'] = 'weapon_m14',  	                ['label'] = 'PD M14',	        	    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',    		['image'] = 'np_mk14.png',     	['unique'] = true, 		['useable'] = true, 	['description'] = 'PD m14'},
-- [`weapon_sniperrifle`]           = {['name'] = 'weapon_sniperrifle',  	        ['label'] = 'PD M24',	        	    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',    		['image'] = 'np_m24.png',     	['unique'] = true, 		['useable'] = true, 	['description'] = 'PD m24'},

-- -- İllegal Silahları
-- [`weapon_assaultrifle2`]	     = {['name'] = 'weapon_assaultrifle2',		    ['label'] = 'AK47',         			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',    		['image'] = 'np_assault-rifle.png',		['unique'] = true, 		['useable'] = true, 	['description'] = 'AK47'},
-- [`weapon_microsmg2`]			 = {['name'] = 'weapon_microsmg2',				['label'] = 'Mini Uzi',			        ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',      		['image'] = 'np_micro-smg2.png',   		['unique'] = true, 		['useable'] = true, 	['description'] = 'Mini Uzi'},
-- [`weapon_microsmg3`]			 = {['name'] = 'weapon_microsmg3',				['label'] = 'Mac10',        			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',      		['image'] = 'np_micro-smg.png',		    ['unique'] = true, 		['useable'] = true, 	['description'] = 'Mac10'},
-- [`componet_gavel`]     			 = {['name'] = 'componet_gavel',   				['label'] = 'Gavel',    			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,             	     	['image'] = 'np_gavel.png',		    ['unique'] = true, 		['useable'] = true, 	['description'] = 'PLAY BALL!'},
-- [`weapon_bats`]     			 = {['name'] = 'weapon_bats',   				['label'] = 'Baseball Bat',    			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,             		['image'] = 'np_baseball-bat.png',		    ['unique'] = true, 		['useable'] = true, 	['description'] = 'PLAY BALL!'},
-- [`weapon_katanas`]  			 = {['name'] = 'weapon_katanas',				['label'] = 'Zangetsu',        			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,             		['image'] = 'np_katana.png',       		['unique'] = true, 		['useable'] = true, 	['description'] = '“slaying moon”'},
-- [`weapon_katana`]   			 = {['name'] = 'weapon_katana',				    ['label'] = 'Kazeshini',     			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,             		['image'] = 'np_cursed-katana.png',		['unique'] = true, 		['useable'] = true, 	['description'] = '“wind of death”'},
-- [`weapon_nailgun`]  			 = {['name'] = 'weapon_nailgun',				['label'] = 'Nail Gun',     			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_NAIL',     		['image'] = 'np_nailgun.png',      		['unique'] = true, 		['useable'] = true, 	['description'] = 'BOB THE BUILDER'},
-- [`weapon_sledgeham`]			 = {['name'] = 'weapon_sledgeham',				['label'] = 'Sledgehammer',  			['weight'] = 2000, 		['type'] = 'weapon', 	['ammotype'] = nil,              		['image'] = 'np_hammer.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'I HIT HARD'},
-- [`weapon_shiv`]     			 = {['name'] = 'weapon_shiv',   				['label'] = 'Shiv',         			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,             		['image'] = 'np_shiv.png',         		['unique'] = true, 		['useable'] = true, 	['description'] = 'You dont want to know where i keep this.'},
-- [`weapon_dp9`]      			 = {['name'] = 'weapon_dp9',    				['label'] = 'Diamond Back', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',           ['image'] = 'np_DB9.png',         		    ['unique'] = true, 		['useable'] = true, 	['description'] = 'pop pop pop'},
-- [`weapon_staff`]    			 = {['name'] = 'weapon_staff',  				['label'] = 'Wizard Staff', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_STAFF',    		['image'] = 'np_staff01.png',      		['unique'] = true, 		['useable'] = true, 	['description'] = 'IM A WIZARD HARRY!'},
-- [`weapon_sniperrifle2`]			 = {['name'] = 'weapon_sniperrifle2',			['label'] = 'Hunting Rifle',			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',   		['image'] = 'np_huntingrifle.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'For hunting'},
-- [`weapon_dragunov`]			     = {['name'] = 'weapon_dragunov',			['label'] = 'Dragunov',			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',   		['image'] = 'np_dragunov.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'For hunting'},
-- -- Sarjorler vb.

-- ['taser_ammo']                   = {['name'] = 'taser_ammo',                    ['label'] = 'Taser Cartridges X30',     ['weight'] = 1500,      ['type'] = 'item',      ['image'] = 'taser_ammo.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,  ['combinable'] = nil,   ['description'] = 'Ammunition intended for Tasers.'}, 
-- ['pistol_ammo'] 				 = {['name'] = 'pistol_ammo', 			  	  	['label'] = 'Pistol ammo', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'np_pistol-ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Pistols'},
-- ['rifle_ammo'] 				 	 = {['name'] = 'rifle_ammo', 			  	  	['label'] = 'Rifle ammo', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'np_rifle-ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Rifles'},
-- ['smg_ammo'] 				 	 = {['name'] = 'smg_ammo', 			  	  		['label'] = 'SMG ammo', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'smg_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Sub Machine Guns'},
-- ['shotgun_ammo'] 				 = {['name'] = 'shotgun_ammo', 			  	  	['label'] = 'Shotgun ammo', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'np_shotgun-ammo.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Shotguns'},
-- ['mg_ammo'] 				 	 = {['name'] = 'mg_ammo', 			  	  		['label'] = 'MG ammo', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'mg_ammo.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Machine Guns'},
-- ['snp_ammo'] 				 	 = {['name'] = 'snp_ammo', 			  	  		['label'] = 'Sniper ammo', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Sniper Rifles'},
--    ['emp_ammo']			         = {['name'] = 'emp_ammo', 			  	        ['label'] = 'EMP Ammo', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'emp_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Ammo for EMP Launcher'},

QBShared.Items                       ={
	['wallet'] 				 	 	 = {['name'] = 'wallet',						['label'] = 'Wallet', 					['weight'] = 300, 		['type'] = 'item', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   	['combinable'] = nil,   	['description'] = ""},
	
	-- PD Silahları
	
	["weapon_m4"]                  ={["name"] = "weapon_m4"                , ["label"] = "PD M4"         , ["weight"] = 3500 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	-- [`weapon_katana`]   			 = {['name'] = 'weapon_katana',				    ['label'] = 'Kazeshini',     			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,             		['image'] = 'np_cursed-katana.png',		['unique'] = true, 		['useable'] = true, 	['description'] = '“wind of death”'},
	["weapon_glock"]                  ={["name"] = "weapon_glock"                , ["label"] = "PD Glock"         , ["weight"] = 2200 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_ltl"]                  ={["name"] = "weapon_ltl"                , ["label"] = "PD Beang Bag"         , ["weight"] = 3300 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_taser"]                  ={["name"] = "weapon_taser"                , ["label"] = "PD Taser"         , ["weight"] = 1700 , ["type"] = "weapon", ["ammotype"] = "AMMO_TASER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_specialcarbine_mk2"]                  ={["name"] = "weapon_specialcarbine_mk2"                , ["label"] = "PD FN Scar"         , ["weight"] = 3000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_railgun"]                  ={["name"] = "weapon_railgun"                , ["label"] = "PD EMP Launcher"         , ["weight"] = 5000 , ["type"] = "weapon", ["ammotype"] = "AMMO_EMP"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_m14"]                  ={["name"] = "weapon_m14"                , ["label"] = "PD M14"         , ["weight"] = 4444 , ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_sniperrifle"]                  ={["name"] = "weapon_sniperrifle"                , ["label"] = "Av Tüfeği"         , ["weight"] = 4444 , ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	--İllegal Silahları
	["weapon_assaultrifle2"]                  ={["name"] = "weapon_assaultrifle2"                , ["label"] = "AK47"         , ["weight"] = 3500 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_microsmg2"]                  ={["name"] = "weapon_microsmg2"                , ["label"] = "Mini Uzi"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_microsmg3"]                  ={["name"] = "weapon_microsmg3"                , ["label"] = "Mac10"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["componet_gavel"]                  ={["name"] = "componet_gavel"                , ["label"] = "Gavel"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bats"]                  ={["name"] = "weapon_bats"                , ["label"] = "Beyzbol Katana"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_katanas"]                  ={["name"] = "weapon_katanas"                , ["label"] = "Zangetsu"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_katana"]                  ={["name"] = "weapon_katana"                , ["label"] = "Katana"         , ["weight"] = 2400 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	-- ["weapon_katana"]                  ={["name"] = "weapon_katana"                , ["label"] = "Kazeshini"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_nailgun"]                  ={["name"] = "weapon_nailgun"                , ["label"] = "Nail Gun"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_NAIL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_sledgeham"]                  ={["name"] = "weapon_sledgeham"                , ["label"] = "Sledgehammer"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_shiv"]                  ={["name"] = "weapon_shiv"                , ["label"] = "Shiv"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "nil"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_dp9"]                  ={["name"] = "weapon_dp9"                , ["label"] = "DP-1999"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_staff"]                  ={["name"] = "weapon_staff"                , ["label"] = "Sorcerer's Staff"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_STAFF"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_sniperrifle2"]                  ={["name"] = "weapon_sniperrifle2"                , ["label"] = "Hunting Rifle"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_dragunov"]                  ={["name"] = "weapon_dragunov"                , ["label"] = "SVD Dragunov"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	--Sarjor vb.
	["pistol_ammo"]         ={["name"] = "pistol_ammo"        , ["label"] = "Pistol Ammo"       , ["weight"] = 10  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Tabanca türü silahlar için mermi."                                                },
	["rifle_ammo"]          ={["name"] = "rifle_ammo"         , ["label"] = "Rifle Ammo"         , ["weight"] = 10  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Tüfek türü silahlar için mermi."                                                  },
	["smg_ammo"]            ={["name"] = "smg_ammo"           , ["label"] = "SMG Ammo"           , ["weight"] = 10  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "SMG türü silahlar için mermi."                                                    },
	["shotgun_ammo"]        ={["name"] = "shotgun_ammo"       , ["label"] = "Sg Ammo"               , ["weight"] = 10  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Pompalı tüfekler için fişek."                                                     },
	["mg_ammo"]             ={["name"] = "mg_ammo"            , ["label"] = "MG Ammo"                 , ["weight"] = 10  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Tam otomatik silahlar için mermi kutusu."                                         },
	["snp_ammo"]            ={["name"] = "snp_ammo"           , ["label"] = "Sniper Ammo", ["weight"] = 10 , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Keskin nişancı tüfeği için mermi kutusu."},
	["taser_ammo"]            ={["name"] = "taser_ammo"           , ["label"] = "Taser Crtg x5", ["weight"] = 10 , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Keskin nişancı tüfeği için mermi kutusu."},
	["emp_ammo"]            ={["name"] = "emp_ammo"           , ["label"] = "EMP Ammo", ["weight"] = 10 , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Keskin nişancı tüfeği için mermi kutusu."},
	["nail_ammo"]            ={["name"] = "nail_ammo"           , ["label"] = "Nails", ["weight"] = 10 , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Keskin nişancı tüfeği için mermi kutusu."},



	["weapon_mk18b"]                 ={["name"] = "weapon_mk18b"               , ["label"] = "PD MK18"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_unarmed"]               ={["name"] = "weapon_unarmed"              , ["label"] = "Fist"                , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_flashlight"]            ={["name"] = "weapon_flashlight"           , ["label"] = "Flashlight"             , ["weight"] = 500  , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_knife"]                 ={["name"] = "weapon_knife"                , ["label"] = "Knife"           , ["weight"] = 500 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_nightstick"]            ={["name"] = "weapon_nightstick"           , ["label"] = "Police Baton"                   , ["weight"] = 200 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_hammer"]                ={["name"] = "weapon_hammer"               , ["label"] = "Hammer"                 , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bat"]                   ={["name"] = "weapon_bat"                  , ["label"] = "Bat"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_golfclub"]              ={["name"] = "weapon_golfclub"             , ["label"] = "Golf Stick"           , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_crowbar"]               ={["name"] = "weapon_crowbar"              , ["label"] = "Crowbar"                 , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_pistol"]                ={["name"] = "weapon_pistol"               , ["label"] = "Taurus PT 92"                , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_pistol_mk2"]            ={["name"] = "weapon_pistol_mk2"           , ["label"] = "Baretta M9"          , ["weight"] = 1500 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_combatpistol"]          ={["name"] = "weapon_combatpistol"         , ["label"] = "FN FNX-45"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_appistol"]              ={["name"] = "weapon_appistol"             , ["label"] = "Colt SCAMP"             , ["weight"] = 1500 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_pistol50"]              ={["name"] = "weapon_pistol50"             , ["label"] = "Desert Eagle"        , ["weight"] = 1200 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_microsmg"]              ={["name"] = "weapon_microsmg"             , ["label"] = "IMI UZI"             , ["weight"] = 1300 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_smg"]                   ={["name"] = "weapon_smg"                  , ["label"] = "MP5"                   , ["weight"] = 2000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_smg_mk2"]               ={["name"] = "weapon_smg_mk2"              , ["label"] = "MP5X-K"             , ["weight"] = 2500 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_assaultsmg"]            ={["name"] = "weapon_assaultsmg"           , ["label"] = "FN P90"           , ["weight"] = 1500 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_assaultrifle"]          ={["name"] = "weapon_assaultrifle"         , ["label"] = "AKS-74U"         , ["weight"] = 3000, ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_assaultrifle_mk2"]      ={["name"] = "weapon_assaultrifle_mk2"         , ["label"] = "AKS-74U MK2"         , ["weight"] = 3000, ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_carbinerifle"]          ={["name"] = "weapon_carbinerifle"         , ["label"] = "PD MPX"         , ["weight"] = 3000, ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_carbinerifle_mk2"]      ={["name"] = "weapon_carbinerifle_mk2"     , ["label"] = "PD SCAR"         , ["weight"] = 3000, ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_advancedrifle"]         ={["name"] = "weapon_advancedrifle"        , ["label"] = "OTs-14 Groza"        , ["weight"] = 1800, ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_mg"]                    ={["name"] = "weapon_mg"                   , ["label"] = "Machinegun"            , ["weight"] = 20000, ["type"] = "weapon", ["ammotype"] = "AMMO_MG"             , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_combatmg"]              ={["name"] = "weapon_combatmg"             , ["label"] = "Combat MG"             , ["weight"] = 20000, ["type"] = "weapon", ["ammotype"] = "AMMO_MG"             , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_pumpshotgun"]           ={["name"] = "weapon_pumpshotgun"          , ["label"] = "Mossberg 590"          , ["weight"] = 2200 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_sawnoffshotgun"]        ={["name"] = "weapon_sawnoffshotgun"       , ["label"] = "Mossberg 500"      , ["weight"] = 2200 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_assaultshotgun"]        ={["name"] = "weapon_assaultshotgun"       , ["label"] = "UTAS UTS-15"       , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bullpupshotgun"]        ={["name"] = "weapon_bullpupshotgun"       , ["label"] = "Kel-Tec KSG"       , ["weight"] = 2000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_stungun"]               ={["name"] = "weapon_stungun"              , ["label"] = "Stinger S-200"                 , ["weight"] = 350  , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_heavysniper"]           ={["name"] = "weapon_heavysniper"          , ["label"] = "Heavy Sniper"          , ["weight"] = 4000, ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_remotesniper"]          ={["name"] = "weapon_remotesniper"         , ["label"] = "Remote Sniper"         , ["weight"] = 4000, ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER_REMOTE"  , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_grenadelauncher"]       ={["name"] = "weapon_grenadelauncher"      , ["label"] = "Grenade Launcher"      , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE", ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_grenadelauncher_smoke"] ={["name"] = "weapon_grenadelauncher_smoke", ["label"] = "Smoke Grenade Launcher", ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE", ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_rpg"]                   ={["name"] = "weapon_rpg"                  , ["label"] = "RPG"                   , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RPG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_minigun"]               ={["name"] = "weapon_minigun"              , ["label"] = "Minigun"               , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_MINIGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_grenade"]               ={["name"] = "weapon_grenade"              , ["label"] = "Grenade"               , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_stickybomb"]            ={["name"] = "weapon_stickybomb"           , ["label"] = "Termite Bomb"                    , ["weight"] = 15000, ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_smokegrenade"]          ={["name"] = "weapon_smokegrenade"         , ["label"] = "Rookbom"               , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bzgas"]                 ={["name"] = "weapon_bzgas"                , ["label"] = "BZ Gas"                , ["weight"] = 400 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_molotov"]               ={["name"] = "weapon_molotov"              , ["label"] = "Molotov"               , ["weight"] = 400 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_fireextinguisher"]      ={["name"] = "weapon_fireextinguisher"     , ["label"] = "Fire extinguisher"      , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_petrolcan"]             ={["name"] = "weapon_petrolcan"            , ["label"] = "Gas Can"           , ["weight"] = 2500 , ["type"] = "weapon", ["ammotype"] = "AMMO_PETROLCAN"      , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "Benzin Pidonu" },
	["weapon_ball"]                  ={["name"] = "weapon_ball"                 , ["label"] = "Ball"                   , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_BALL"           , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_flare"]                 ={["name"] = "weapon_flare"                , ["label"] = "Flare"          , ["weight"] = 100 , ["type"] = "weapon", ["ammotype"] = "AMMO_FLARE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_snspistol"]             ={["name"] = "weapon_snspistol"            , ["label"] = "H&K P7M10"             , ["weight"] = 1200  , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bottle"]                ={["name"] = "weapon_bottle"               , ["label"] = "Broken Bottle"            , ["weight"] = 400  , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_gusenberg"]             ={["name"] = "weapon_gusenberg"            , ["label"] = "Thompson M1928A1"           , ["weight"] = 2000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"             , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_specialcarbine"]        ={["name"] = "weapon_specialcarbine"       , ["label"] = "H&K G36C"       , ["weight"] = 2200, ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_heavypistol"]           ={["name"] = "weapon_heavypistol"          , ["label"] = "Heavy Pistol"          , ["weight"] = 200 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bullpuprifle"]          ={["name"] = "weapon_bullpuprifle"         , ["label"] = "Norinco QBZ-95-1"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_dagger"]                ={["name"] = "weapon_dagger"               , ["label"] = "Dagger"                , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_vintagepistol"]         ={["name"] = "weapon_vintagepistol"        , ["label"] = "FN Model 1922"        , ["weight"] = 1200 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_firework"]              ={["name"] = "weapon_firework"             , ["label"] = "Firework Launcher"     , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_musket"]                ={["name"] = "weapon_musket"               , ["label"] = "Musket"                , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_heavyshotgun"]          ={["name"] = "weapon_heavyshotgun"         , ["label"] = "Heavy Shotgun"         , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_marksmanrifle"]         ={["name"] = "weapon_marksmanrifle"        , ["label"] = "Marksman Rifle"        , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SNIPER"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_hominglauncher"]        ={["name"] = "weapon_hominglauncher"       , ["label"] = "Homing Launcher"       , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_STINGER"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_proxmine"]              ={["name"] = "weapon_proxmine"             , ["label"] = "Proxmine Grenade"      , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_snowball"]              ={["name"] = "weapon_snowball"             , ["label"] = "Snowball"               , ["weight"] = 150  , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_flaregun"]              ={["name"] = "weapon_flaregun"             , ["label"] = "Flare Gun"             , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_FLARE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_garbagebag"]            ={["name"] = "weapon_garbagebag"           , ["label"] = "Vuilniszak"            , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_handcuffs"]             ={["name"] = "weapon_handcuffs"            , ["label"] = "HandCuffs"            , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_combatpdw"]             ={["name"] = "weapon_combatpdw"            , ["label"] = "SIG-Sauer MPX-SD"            , ["weight"] = 2000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_marksmanpistol"]        ={["name"] = "weapon_marksmanpistol"       , ["label"] = "Airsoft Gun"       , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_knuckle"]               ={["name"] = "weapon_knuckle"              , ["label"] = "Knuckle"            , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_hatchet"]               ={["name"] = "weapon_hatchet"              , ["label"] = "Hatchet"                 , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_machete"]               ={["name"] = "weapon_machete"              , ["label"] = "Machete"                  , ["weight"] = 800 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_machinepistol"]         ={["name"] = "weapon_machinepistol"        , ["label"] = "Intratec TEC-DC9"                 , ["weight"] = 1200 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_switchblade"]           ={["name"] = "weapon_switchblade"          , ["label"] = "Switchblade"               , ["weight"] = 280  , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_revolver"]              ={["name"] = "weapon_revolver"             , ["label"] = "Colt 1892 Revolver"              , ["weight"] = 2500 , ["type"] = "weapon", ["ammotype"] = "AMMO_PISTOL"         , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_dbshotgun"]             ={["name"] = "weapon_dbshotgun"            , ["label"] = "Zabala DBS" , ["weight"] = 1500 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_compactrifle"]          ={["name"] = "weapon_compactrifle"         , ["label"] = "AK Micro Draco"         , ["weight"] = 1500 , ["type"] = "weapon", ["ammotype"] = "AMMO_RIFLE"          , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_autoshotgun"]           ={["name"] = "weapon_autoshotgun"          , ["label"] = "Armsel Protecta"          , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_battleaxe"]             ={["name"] = "weapon_battleaxe"            , ["label"] = "Axe"         , ["weight"] = 6000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_compactlauncher"]       ={["name"] = "weapon_compactlauncher"      , ["label"] = "Compact Launcher"      , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_minismg"]               ={["name"] = "weapon_minismg"              , ["label"] = "SA Vz. 82 Skorpion"              , ["weight"] = 1300 , ["type"] = "weapon", ["ammotype"] = "AMMO_SMG"            , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_pipebomb"]              ={["name"] = "weapon_pipebomb"             , ["label"] = "Pipe Bomb"          , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_poolcue"]               ={["name"] = "weapon_poolcue"              , ["label"] = "Pool Cue"               , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_wrench"]                ={["name"] = "weapon_wrench"               , ["label"] = "Wrench"      , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_autoshotgun"]           ={["name"] = "weapon_autoshotgun"          , ["label"] = "UTAS UTS-15"       , ["weight"] = 3000 , ["type"] = "weapon", ["ammotype"] = "AMMO_SHOTGUN"        , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["weapon_bread"]                 ={["name"] = "weapon_bread"                , ["label"] = "Bread"                 , ["weight"] = 1000 , ["type"] = "weapon", ["ammotype"] = nil                   , ["unique"] = true, ["useable"] = false, ["combinable"] = nil, ["description"] = "" },
	["pkelepce"]            ={["name"] = "pkelepce"           , ["label"] = "Police Handcuffs"            , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Kaliteli çelikten yapılma, güçlü polis kelepçesi."                                },
	["pkelepceanahtar"]     ={["name"] = "pkelepceanahtar"    , ["label"] = "Police Key"             , ["weight"] = 50   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Her polis kelepçesini açabilen, polis anahtarı."                                  },
	["white_phone"]          ={["name"] = "white_phone"         , ["label"] = "Phone"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mavi kaplı telefon."                                                              },
	["maya"]                ={["name"] = "maya"               , ["label"] = "Maya"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mavi kaplı telefon."                                                              },
	["viski_cubugu"]                ={["name"] = "viski_cubugu"               , ["label"] = "Whiskey Stick"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mavi kaplı telefon."                                                              },
	["tamirkiti"]           ={["name"] = "tamirkiti"          , ["label"] = "Advanced Repair Bag"     , ["weight"] = 2000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Aracı yeni gibi yapan tamir aleti."                                               },
	["umbrella"]            ={["name"] = "umbrella"           , ["label"] = "Umbrella"                    , ["weight"] = 1500  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Girdiği her yerde açılmayabilir."                               },
	["pmisir"]              ={["name"] = "pmisir"             , ["label"] = "Popcorn"             , ["weight"] = 50    , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tuzlu, tereyağlı ve lezzetli.."                                                   },
	["pizza"]               ={["name"] = "pizza"              , ["label"] = "Pizza"                      , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Herkesi mutlu edebilir, çünkü pizza."                                             },
	["sise"]                ={["name"] = "sise"               , ["label"] = "Glass bottle"                   , ["weight"] = 350   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Camdan yapılmış bir şişe, içi boş gözüküyor"                                                                             },
	["kapi"]                ={["name"] = "kapi"               , ["label"] = "Vehicle Door"                , ["weight"] = 15000 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Arabadan özensizce sökülmüş kapı."                                                },
	["portakal"]            ={["name"] = "portakal"           , ["label"] = "Orange"                   , ["weight"] = 1000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Olgun portakal.."                                                                 },
	["drone_flyer_7"]       ={["name"] = "drone_flyer_7"      , ["label"] = "Police Drone"                , ["weight"] = 5000 , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Polisler için özel üretilmiş bir quadcopter."                                     },
	["matkap"]              ={["name"] = "matkap"             , ["label"] = "Drill"                     , ["weight"] = 3600  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Zorlu kilitleri kırabilecek bir matkap, darbeli.."                                },
	["matkapucu"]              ={["name"] = "matkapucu"             , ["label"] = "Drill Tip"                     , ["weight"] = 500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Matkabın içine koyulan bir uç."                                },
	["yarimmatkap"]              ={["name"] = "yarimmatkap"             , ["label"] = "Endless Drill"                     , ["weight"] = 2500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir matkap ama bir şey eksik?"                                },
	["delicialet"]              ={["name"] = "delicialet"             , ["label"] = "Cutter"                     , ["weight"] = 5000  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Matkap tarzında kesici alet ama matkap değil?"                                },
	["ucsuzdelicialet"]              ={["name"] = "ucsuzdelicialet"             , ["label"] = "Endless Cutter"                     , ["weight"] = 4000  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Matkap tarzında kesici ama ucu yok?"                                },
	["sablon_kart"]         ={["name"] = "sablon_kart"        , ["label"] = "Template Card"               , ["weight"] = 25   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Boş bir kart, belki bir işe yarıyordur?"                                          },
	["ligher"]              ={["name"] = "lighter"            , ["label"] = "Lighter"                     , ["weight"] = 150   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Çakar çakmaz çakan çakmak."                                                       },
	["plastik"]             ={["name"] = "plastik"            , ["label"] = "Plastic"                    , ["weight"] = 200   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir şeyler üretmeye yarayan malzeme."                                             },
	["notd"]                ={["name"] = "notd"               , ["label"] = "Notebook"                , ["weight"] = 400   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İçine bir şeyler karalayabileceğin bir defter."                                   },
	["tunner_chip"]         ={["name"] = "tunner_chip"        , ["label"] = "ECU"                        , ["weight"] = 1250  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Araça ek özellikler kazandıran, elektronik çip"                                   },
	["dna"]                 ={["name"] = "dna"                , ["label"] = "DNA"                      , ["weight"] = 150   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "İçinde delil bulunduran torba."                                                   },
	["sosisli"]             ={["name"] = "sosisli"            , ["label"] = "Hot Dog"                    , ["weight"] = 350   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Uzun, kalın, lezzetli.."                                                          },
	["grand_cru"]           ={["name"] = "grand_cru"          , ["label"] = "Grand Cru"                  , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "grand_cru"                                                                        },
	["mermikovani"]         ={["name"] = "mermikovani"        , ["label"] = "Empty Bullet Case"           , ["weight"] = 150   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mermi Kovanı"                                                                     },
	["barut"]               ={["name"] = "barut"              , ["label"] = "Gunpowder"                      , ["weight"] = 400   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ateşle yaklaşmayın, şarkısı bile var.."                                           },
	["kelepceanahtar"]      ={["name"] = "kelepceanahtar"     , ["label"] = "Clamp Wrench"           , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Kendine ait kelepçeyi açabilen bir anahtar."                                      },
	["taco"]                ={["name"] = "taco"               , ["label"] = "Taco"                       , ["weight"] = 200   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tam kapanmamış dürüm.."                                                           },
	["kelepce"]             ={["name"] = "kelepce"            , ["label"] = "Handcuff"                    , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ne yazık ki tüylü modellerinden değil.."                                          },
	["armor"]               ={["name"] = "armor"              , ["label"] = "Armor"                       , ["weight"] = 4000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Mermilerin size isabet etmesini engelleyen bir yelek"                             },
	["medikit"]             ={["name"] = "medikit"            , ["label"] = "Health Bag"             , ["weight"] = 500  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Gelişmiş son teknoloji bir tedavi çantası."                                       },
	["martini"]             ={["name"] = "martini"            , ["label"] = "Martini Blanc"              , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sizde mi partiden sıkıldınız?"                                                    },
	["lowradio"]            ={["name"] = "lowradio"           , ["label"] = "Stock Radio"                 , ["weight"] = 2500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kalitesiz bir teyp, kaseti olan var mı?"                                          },
	["highrim"]             ={["name"] = "highrim"            , ["label"] = "Quality Wheels"              , ["weight"] = 6800  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Oldukça pahalı duran bir jant"                                                    },
	["slaughtered_chicken"] ={["name"] = "slaughtered_chicken", ["label"] = "Sliced Chicken"             , ["weight"] = 2500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kesilmiş tavuk"                                                                   },
	["shark"]               ={["name"] = "shark"              , ["label"] = "Shark"               , ["weight"] = 20000 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dı-rın Dı-rın Dırındırındırın..."                                                 },
	["packaged_chicken"]    ={["name"] = "packaged_chicken"   , ["label"] = "Packaged Chicken"          , ["weight"] = 800   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Paketlenmiş Tavuk"                                                                },
	["packaged_koko"]    ={["name"] = "packaged_koko"   , ["label"] = "Packaged Cocaine"          , ["weight"] = 800   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Paketlenmiş Tavuk"                                                                },
	["khorium"]    ={["name"] = "khorium"   , ["label"] = "Chorium"          , ["weight"] = 800   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Paketlenmiş Tavuk"                                                                },
	["koko"]    ={["name"] = "koko"   , ["label"] = "Cocaine"          , ["weight"] = 800   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Paketlenmiş Tavuk"                                                                },
	["highradio"]           ={["name"] = "highradio"          , ["label"] = "Digital Radio"              , ["weight"] = 1800  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Son teknoloji kaliteli bir araç müzik sistemi."                                   },
	["clothe"]              ={["name"] = "clothe"             , ["label"] = "Clothes"                    , ["weight"] = 1000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Özensizce dikilmiş kıyafet"                                                       },
	["cigarette"]           ={["name"] = "cigarette"          , ["label"] = "Cigarette"                     , ["weight"] = 10    , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Tütünlü rulo."                                                                    },
	["bsigara"]           ={["name"] = "bsigara"          , ["label"] = "Smoked Cigarette"                     , ["weight"] = 50    , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "İçilmiş Sigara."                                                                    },
	["vape"]           ={["name"] = "vape"          , ["label"] = "Vape"                     , ["weight"] = 500    , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Nikotinli elektronik sigaramsı bir şey"                                                                    },
	["binoculars"]          ={["name"] = "binoculars"         , ["label"] = "Binoculars"                     , ["weight"] = 1000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Gözlem veya röntgencilik arasındaki ince çizgi.."                                 },
	["beer"]                ={["name"] = "beer"               , ["label"] = "Beer"                       , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Düşük alkol, yüksek eğlence, göbek.."                                             },
	["battery"]             ={["name"] = "battery"            , ["label"] = "Vehicle Battery"                 , ["weight"] = 6500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Arabalara gerekli elektrik gücünü sağlayan büyük pil."                            },
	["bandage"]             ={["name"] = "bandage"            , ["label"] = "Bandage"                     , ["weight"] = 200   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yaralarını sarabileceğin basit kumaş parçası"                                     },
	["ıfak"]                ={["name"] = "ıfak"               , ["label"] = "Ifak"                     , ["weight"] = 200   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yaralarını sarabileceğin basit kumaş parçası"                                     },
	["airbag"]              ={["name"] = "airbag"             , ["label"] = "Airbag"               , ["weight"] = 2000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaza anında can kurtaran hava yastığı."                                           },
	["fixkit"]              ={["name"] = "fixkit"             , ["label"] = "Repair kit"                 , ["weight"] = 4000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Aracı hala gidebilecek duruma getiren tamir aleti."                               },
	["pickaxe"]                ={["name"] = "pickaxe"               , ["label"] = "Pickaxe"                      , ["weight"] = 2000   , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Items needed to access mining materials"                                },
	["fabric"]              ={["name"] = "fabric"             , ["label"] = "Fabric"                      , ["weight"] = 5000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kıyafet dikimine hazır kumaş."                                                    },
	["alive_chicken"]       ={["name"] = "alive_chicken"      , ["label"] = "Chicken"                      , ["weight"] = 5000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bildiğimiz tavuk. Dümdüz, sıradan.."                                              },
	["lockpick2"]           ={["name"] = "lockpick2"          , ["label"] = "Lockpick"                  , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Bununla ne yapacaksın?"                                                           },
	["lockpick3"]           ={["name"] = "lockpick3"          , ["label"] = "Advanced Lockpick"                  , ["weight"] = 600   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Bununla ne yapacaksın?"                                                           },
	["saat"]                ={["name"] = "saat"               , ["label"] = "Watch"                       , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Basit saat"                                                                       },
	["yuzuk"]               ={["name"] = "yuzuk"              , ["label"] = "Ring"                      , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Merak etme seçilmiş kişi değilsin, sıradan bir yüzük."                            },
	["altinkolye"]          ={["name"] = "altinkolye"         , ["label"] = "Golden necklace"                , ["weight"] = 300   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Düğünlerde iş görür."                                                             },
	["rolex"]               ={["name"] = "rolex"              , ["label"] = "Rolex Watch"                 , ["weight"] = 200   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yolculuk nereye? Monaco?"                                                         },
	["lowgradefert"]        ={["name"] = "lowgradefert"       , ["label"] = "Fertilizer"                      , ["weight"] = 2000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dümdüz bok, bitkiler seviyor."                                                    },
	["washed_stone"]        ={["name"] = "washed_stone"       , ["label"] = "Cleaned Stone"            , ["weight"] = 5000   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tozu toprağı arındırılmış taş."                                                   },
	["turtlebait"]          ={["name"] = "turtlebait"         , ["label"] = "Turtle Food"            , ["weight"] = 400   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaplumbağaları cezbeden yem."                                                     },
	["turtle"]              ={["name"] = "turtle"             , ["label"] = "Sea turtle"         , ["weight"] = 7300  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Masum bir kaplumbağa, ona ne yapacaksın d-dostum?"                                },
	["stockrim"]            ={["name"] = "stockrim"           , ["label"] = "Stock Wheel"                  , ["weight"] = 4500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Standart kalitede bir jant."                                                               },
	["speaker"]             ={["name"] = "speaker"            , ["label"] = "Speaker"                   , ["weight"] = 1050  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yüksek ses veren araçlar için tasarlanmış elektronik alet"                        },
	["wool"]                ={["name"] = "wool"               , ["label"] = "Wool"                        , ["weight"] = 5000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Koyundan elde edilmiş işlenmeye hazır yün"                                                                              },
	["lowgrademaleseed"]    ={["name"] = "lowgrademaleseed"   , ["label"] = "Male Seed"                , ["weight"] = 10   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ekip büyütülebilen bir bitkinin tohumu"                                           },
	["lowgradefemaleseed"]  ={["name"] = "lowgradefemaleseed" , ["label"] = "Female Seed"                 , ["weight"] = 15   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ekip büyütülebilen bir bitkinin tohumu"                                           },
	["jewels"]              ={["name"] = "jewels"             , ["label"] = "Gem"                   , ["weight"] = 400   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Eminim sana çok yakışacaklar.."                                                   },
	['spikestrip'] 				     = {['name'] = 'spikestrip',					['label'] = 'Spikestrip', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'spikestrip.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Dikenli Tel'},
	["gps"]                 ={["name"] = "gps"                , ["label"] = "GPS"                        , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Anlık konum paylaşımı yapan askeri teçhizat"                                      },
	["walkie_lspd"]         ={["name"] = "walkie_lspd"        , ["label"] = "Radio"                     , ["weight"] = 200   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Uydu bağlantılı telekomünikasyon cihazı."                                         },
	["odun"]                ={["name"] = "odun"               , ["label"] = "Wood"                       , ["weight"] = 3000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir zamanlar yaşayan bir can.."                                                   },
	["kereste"]             ={["name"] = "kereste"            , ["label"] = "Timber"                    , ["weight"] = 1000   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İşlenmiş odun."                                                                   },
	["packaged_plank"]		={["name"] = "packaged_plank"     , ["label"] = "Plank"                      , ["weight"] = 800 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tiftiklenmiş, işlemden geçirilmiş odun."                                          },
	["uzum"]                ={["name"] = "uzum"               , ["label"] = "Grape"                       , ["weight"] = 1000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bildiğin üzüm"                                                                    },
	["uzumkasa"]                     ={["name"] = "uzumkasa"           , ["label"] = "Grape Case"                , ["weight"] = 15000  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İçi üzüm dolu kasa"                                              },
	["findik"]              ={["name"] = "findik"             , ["label"] = "Strawberry"                     , ["weight"] = 4500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bildiğin Çilek"                                                                    },
	["drone_flyer_1"]       ={["name"] = "drone_flyer_1"      , ["label"] = "Simple Drone 1"              , ["weight"] = 2000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Minik, yavaş bir quadcopter"                                                      },
	["drone_flyer_2"]       ={["name"] = "drone_flyer_2"      , ["label"] = "Simple Drone 2"              , ["weight"] = 3000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Minik, yavaşça bir quadcopter"                                                    },
	["drone_flyer_3"]       ={["name"] = "drone_flyer_3"      , ["label"] = "Simple Drone 3"              , ["weight"] = 4000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Minik, idare eder bir quadcopter"                                                 },
	["drone_flyer_4"]       ={["name"] = "drone_flyer_4"      , ["label"] = "Developed Drone 1"           , ["weight"] = 8000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Büyük, fena değil bir quadcopter"                                                 },
	["drone_flyer_5"]       ={["name"] = "drone_flyer_5"      , ["label"] = "Developed Drone 2"           , ["weight"] = 9000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Büyük, iyi bir quadcopter"                                                        },
	["drone_flyer_6"]       ={["name"] = "drone_flyer_6"      , ["label"] = "Developed Drone 3"           , ["weight"] = 10000 , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Büyük, oldukça kaliteli bir quadcopter"                                           },
	["flashlight"]          ={["name"] = "flashlight"         , ["label"] = "Advanced : Torch"            , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silahlara takılabilen küçük fener"                                                },
	["scope"]               ={["name"] = "scope"              , ["label"] = "Advanced : Holo"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hedefi daha rahat görebilmenizi sağlayan, ortasında nişangah olan silah dürbünü." },
	["scope2"]               ={["name"] = "scope2"            , ["label"] = "Advanced : K. Binoculars"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hedefi daha rahat görebilmenizi sağlayan, ortasında nişangah olan silah dürbünü." },
	["scope3"]               ={["name"] = "scope3"            , ["label"] = "Advanced : B.Binoculars"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hedefi daha rahat görebilmenizi sağlayan, ortasında nişangah olan silah dürbünü." },
	["clip"]                ={["name"] = "clip"               , ["label"] = "Advanced : Magazin"          , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silahın mermi kapasitesini arttıran şarjör."                                      },
	["grip"]                ={["name"] = "grip"               , ["label"] = "Advanced : Grip"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle"]                ={["name"] = "muzzle"               , ["label"] = "Advanced : Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle2"]                ={["name"] = "muzzle2"               , ["label"] = "Advanced : Tactical Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle3"]                ={["name"] = "muzzle3"               , ["label"] = "Advanced : Tombik Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle4"]                ={["name"] = "muzzle4"               , ["label"] = "Advanced : Sharp Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle5"]                ={["name"] = "muzzle5"               , ["label"] = "Advanced : Heavy Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle6"]                ={["name"] = "muzzle6"               , ["label"] = "Advanced : Modern Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["muzzle7"]                ={["name"] = "muzzle7"               , ["label"] = "Advanced : Multiple Muzzle"             , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Silah kontrolünü arttıran, silah eklentisi"                                       },
	["plakagovdesi"]        ={["name"] = "plakagovdesi"       , ["label"] = "Plate Body"              , ["weight"] = 1000  , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tek başına bir işe yaramayan plaka gövdesi"                                       },
	["splaka"]              ={["name"] = "splaka"             , ["label"] = "Fake Plate"                , ["weight"] = 500   , ["type"] = "item", ["unique"] = false, ["useable"] = true , ["shouldClose"] = true , ["combinable"] = nil, ["description"] = "Tek Kulanımlık Sahte Plaka"                                                       },
	["yag"]                 ={["name"] = "yag"                , ["label"] = "Quality Oil"               , ["weight"] = 150   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ömrünü dolduran silahları temizlemek için birebir."                               },
	["ab"]                  ={["name"] = "ab"                 , ["label"] = "Antibiotic"                , ["weight"] =   200 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir çok hastalığın ilacı, fazlası zarar."                                         },                                                                                                                                                                          
	["arac_tablet"]         ={["name"] = "arac_tablet"        , ["label"] = "Car Tablet"               , ["weight"] =   1500, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Arabanızın kozmetik yazılımına müdahale edebilen bir tablet."                     },       
	["asit"]                ={["name"] = "asit"               , ["label"] = "Acid"                       , ["weight"] =  100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Harley e sorun o iyi bilir.."                                                     },       
	["azot"]                ={["name"] = "azot"               , ["label"] = "Nitrogen"                       , ["weight"] =   100, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Belki de bir tüpe koyup denemelisin?"                                             },       
	["balik_ekmek"]         ={["name"] = "balik_ekmek"        , ["label"] = "Fish and bread"                , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir de o şişede balık olsam.."                                                    },       
	["balon_baligi"]        ={["name"] = "balon_baligi"       , ["label"] = "Puffer fish"               , ["weight"] =  500  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ne istedin şuncacık hayvandan?"                                                   },       
	["book"]                ={["name"] = "book"               , ["label"] = "LSPD Handbook"                      , ["weight"] =  250  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Oku baban gibi eşek olma."                                                        },       
	["bos_tup"]             ={["name"] = "bos_tup"            , ["label"] = "Empty Tube"                    , ["weight"] =   1000, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sağlam demirden boş bir tüp."                                                     },       
	["buz"]                 ={["name"] = "buz"                , ["label"] = "Ice"                        , ["weight"] =  100  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Donmuş su"                                                                        },       
	["cam"]                 ={["name"] = "cam"                , ["label"] = "Cam"                        , ["weight"] =   300 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dikkat, kırılır."                                                                 },       
	["chocho"]              ={["name"] = "chocho"             , ["label"] = "Chocolate"                   , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tatlı, keyif verici işlenmiş bitki özü."                                          },       
	["cookie"]              ={["name"] = "cookie"             , ["label"] = "Cookie"                   , ["weight"] =   80  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Atıştırmalık, lezzetli."                                                          },       
	["tree_lumber"]						= {["name"] = "tree_lumber",  	  		["label"] = "Timber",	  		["weight"] = 1000, 		["type"] = "item", 		["image"] = "lumber.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
	["tree_bark"]						= {["name"] = "tree_bark",  	  		["label"] = "Wood Pieces",	  	["weight"] = 850, 		["type"] = "item", 		["image"] = "treebark.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
	["wood_plank"]						= {["name"] = "wood_plank",  	  		["label"] = "Wooden Boards",	  	["weight"] = 1100, 		["type"] = "item", 		["image"] = "woodplank.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
	
	["crab"]                ={["name"] = "crab"               , ["label"] = "Crab"                     , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Standart yengeç"                                                                  },       
	["cutted_wood"]         ={["name"] = "cutted_wood"        , ["label"] = "Sawn Wood"              , ["weight"] =  1000 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Özenle kesilmiş, işlenmeye hazır odun."                                           },       
	["dana_eti"]            ={["name"] = "dana_eti"           , ["label"] = "Veal"                   , ["weight"] =  200  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Möö."},       
	["yakutelmas"]             ={["name"] = "yakutelmas"            , ["label"] = "Ruby Diamond"                      , ["weight"] =  250  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Parlak birşey"                                                            },              
	["dildo"]               ={["name"] = "dildo"              , ["label"] = "Dildo"                      , ["weight"] =  270  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Titreşimli.."                                                                     },       
	["domates"]             ={["name"] = "domates"            , ["label"] = "Tomatoes"                    , ["weight"] =  1000 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Biber , patlıcaan."                                                                },       
	["domates_suyu"]        ={["name"] = "domates_suyu"       , ["label"] = "Tomatoes juice"               , ["weight"] =  500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Taze sıkılmış domatesten yapılma."                                                },       
	["donut"]               ={["name"] = "donut"              , ["label"] = "Pink Donut"                , ["weight"] =  100  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Renkli donut, polislere ikram etmekten çekinmeyin."                               },       
	["donut2"]              ={["name"] = "donut2"             , ["label"] = "Chocolate Donut"           , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Polislere ikram etmekten çekinmeyin."                                             },       
	["ekmek"]               ={["name"] = "ekmek"              , ["label"] = "Bread"                      , ["weight"] =   350 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Santos fırınından taze taze."                                                     },       
	["enerji_icecegi"]      ={["name"] = "enerji_icecegi"     , ["label"] = "Energy drink"             , ["weight"] =   200 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yorgunluk mu? O ne??"                                                             },       
	["essence"]             ={["name"] = "essence"            , ["label"] = "Essence"                     , ["weight"] =  500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ateşle yaklaşmayın."                                                              },       
	["golem"]               ={["name"] = "golem"              , ["label"] = "Golem"                      , ["weight"] =   100  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dikkat göründüğünden serttir!"                                                    },       
	["grapperaisin"]        ={["name"] = "grapperaisin"       , ["label"] = "Grape"                       , ["weight"] =   3000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Santos'un olmazsa olmazı, ticaret malzemesi, geçim kaynağı. Şifa bu şifa.."                                                                     },       
	["hackv1"]              ={["name"] = "hackv1"             , ["label"] = "Tablet v1"                  , ["weight"] =  300  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Basit, kalitesiz bir tablet."                                                     },       
	["hackv2"]              ={["name"] = "hackv2"             , ["label"] = "Tablet v2"                  , ["weight"] =   300 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "İyi kalite bir tablet."                                                           },       
	["hackv3"]              ={["name"] = "hackv3"             , ["label"] = "Tablet v3"                  , ["weight"] =   300 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Çok kaliteli bir tablet."                                                         },       
	["hamburger"]           ={["name"] = "hamburger"          , ["label"] = "Hamburger"                  , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Lezzetli dolu dolu bir burger."                                                   },       
	["hamur"]               ={["name"] = "hamur"              , ["label"] = "Pastry"                      , ["weight"] =  100  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Açarsın börek, yayarsın pizza. Nerede kullanacaksın?"                             },       
	["havuc"]               ={["name"] = "havuc"              , ["label"] = "Carrot"                      , ["weight"] =   1000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Iııı naber cınım??"                                                               },      

	["jager"]               ={["name"] = "jager"              , ["label"] = "Hunter"               , ["weight"] =  500  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hazır olun uçuşa geçiyoruz."                                                      },       
	["jagerbomb"]           ={["name"] = "jagerbomb"          , ["label"] = "Hunter bomb"                  , ["weight"] =  300 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bomba geliyor, aç ağzını."                                                        },       
	["jagercerbere"]        ={["name"] = "jagercerbere"       , ["label"] = "Hunter Hell"                 , ["weight"] =  900  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "..."                                                                              },       
	["jusfruit"]            ={["name"] = "jusfruit"           , ["label"] = "Fruit juice"                 , ["weight"] =   850 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Lezzetli ve sağlıklı"                                                             },       
	["kargo_kolisi"]        ={["name"] = "kargo_kolisi"       , ["label"] = "Parcel"               , ["weight"] =  500  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Acaba içinde ne var?"                                                             },       
	["kaykay"]              ={["name"] = "kaykay"             , ["label"] = "Skateboard"                     , ["weight"] =  500  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaymaz mısın?"                                                                    },       
	["kek"]                 ={["name"] = "kek"                , ["label"] = "Cake"                        , ["weight"] =  120  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Üç yumurtayı çırptım önce, portakal dilimledim ince ince.."                       },       
	["kekmek"]              ={["name"] = "kekmek"             , ["label"] = "Meatball Bread"                , ["weight"] = 250   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir tire, inegöl değil ama idare eder."                                           },       
	["ketcap"]              ={["name"] = "ketcap"             , ["label"] = "Ketchup"                     , ["weight"] =  300 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dök dök ye."                                                                      },       
	["kingcrab"]            ={["name"] = "kingcrab"           , ["label"] = "King Crab"                , ["weight"] =  150  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Adına kanma , büyük boy yengeç."                                                   },       
	["kirmizi_kart"]        ={["name"] = "kirmizi_kart"       , ["label"] = "Red card"               , ["weight"] =  25  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kırmızı renkte bir güvenlik kartı"                                                },
	["trojan_usb"]                 ={["name"] = "trojan_usb"                , ["label"] = "Trojan USB"                        , ["weight"] =  25  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Trojan USB"                                                }, 
	["kiyma"]               ={["name"] = "kiyma"              , ["label"] = "Mince"                      , ["weight"] =  200  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sağlıklı değil gibi ama sen bilirsin."                                            },       
	["kraker"]              ={["name"] = "kraker"             , ["label"] = "Cracker"                     , ["weight"] =  200  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Fazla yeme kabız olursun."                                                        },       
	["kum"]                 ={["name"] = "kum"                , ["label"] = "Annual"                        , ["weight"] =  10   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Denizden çıkarılmış, kuru kum."                                                   },       
	["kuru_ot"]             ={["name"] = "kuru_ot"            , ["label"] = "Dry weed"                    , ["weight"] =   400 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "O öyle kuru kuru gitmez."                                                         },       
	["lighter"]             ={["name"] = "lighter"            , ["label"] = "Lighter"                     , ["weight"] =  50   , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Çakar çakmaz çakan çakmak"                                                        },       
	["limon"]               ={["name"] = "limon"              , ["label"] = "Lemon"                      , ["weight"] =   40  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sarı, ekşi."                                                                      },       
	["limonata"]            ={["name"] = "limonata"           , ["label"] = "Lemonade"                   , ["weight"] =  500  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bu kadar ekşi bir şey nasıl buna dönüşüyor?"                                      },       
	["madde_x"]             ={["name"] = "madde_x"            , ["label"] = "Article X"                    , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yeraltı dünyasının para birimi"                                                                              },       
	["martini"]             ={["name"] = "martini"            , ["label"] = "Martini blanc"              , ["weight"] =   900 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sıradan olmayanlara.."                                                            },       
	["marul"]               ={["name"] = "marul"              , ["label"] = "Lettuce"                      , ["weight"] =   1000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yeşil, sulu."                                                                     },       
	["mavi_kart"]           ={["name"] = "mavi_kart"          , ["label"] = "Blue Card"                  , ["weight"] =   25 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mavi renkte bir güvenlik kartı"                                                                              },
	["sari_kart"]           ={["name"] = "sari_kart"          , ["label"] = "Yellow card"                  , ["weight"] =   25 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sarı renkte bir güvenlik kartı"                                                                              },
	["paketlenmis_esrar"]           ={["name"] = "paketlenmis_esrar"          , ["label"] = "Packaged Marijuana"                  , ["weight"] =   25 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                                                              },       
	["mercan"]              ={["name"] = "mercan"             , ["label"] = "Coral"                     , ["weight"] =  300  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mercanlar canlı derler ama sanırım bu ölmüş."                                     },       
	["midyel"]              ={["name"] = "midyel"             , ["label"] = "Large Mussels"            , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Büyük boy canlı midye."                                                           },       
	["midyem"]              ={["name"] = "midyem"             , ["label"] = "Medium Mussel"             , ["weight"] =   30  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Orta boy canlı midye."                                                            },       
	["midyes"]              ={["name"] = "midyes"             , ["label"] = "Small Mussel"            , ["weight"] =   10  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Küçük boy canlı midye."                                                           },       
	["milkshake"]           ={["name"] = "milkshake"          , ["label"] = "Milkshake"                  , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ".. bring all boys to the yard.."                                                  },       
	["misir"]               ={["name"] = "misir"              , ["label"] = "Sweetcorn"                      , ["weight"] =   40  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tezgahta satılanı en güzeli."                                                     },       
	["mojito"]              ={["name"] = "mojito"             , ["label"] = "Mojito"                     , ["weight"] =   900 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Naneli ferahlatıcı alkol."                                                        },       
	["mor_kart"]            ={["name"] = "mor_kart"           , ["label"] = "Purple Card"                   , ["weight"] =   25 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mor renkte bir güvenlik kartı"                                                                              },       
	['emptynitrous'] 				 	 = {['name'] = 'emptynitrous', 			  	  		['label'] = 'Empty Nos Tube', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'emptynitrous.png', 				['unique'] = true, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Boş Nitro Oksit Sistem'},
	["nos"]                 ={["name"] = "nos"                , ["label"] = "Nitrous Oxide System"         , ["weight"] =   2000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Solunması vücut üzerinde olumsuz etkiler yaratabilir."                            },       
	["ot"]                  ={["name"] = "ot"                 , ["label"] = "Marijuana Leaf"                         , ["weight"] =   200, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bu böyle olmaz, kurut bunu."                                                      },       
	["o_tup"]               ={["name"] = "o_tup"              , ["label"] = "Oxygen Cylinder"               , ["weight"] =   2500 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İçinde sıkıştırılmış oksijen bulunan tüp."                                        },       
	["parasut"]             ={["name"] = "parasut"            , ["label"] = "Parachute"                    , ["weight"] =   1500, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dikkatli kullanın, garanti vermez."                                               },       
	["patates"]             ={["name"] = "patates"            , ["label"] = "Potatoes"                    , ["weight"] =   1000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sıradan patates."                                                                 },       
	["petrol"]              ={["name"] = "Petrol"             , ["label"] = "Petrol"                     , ["weight"] =   5000, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "AMERICA FUCK YEA!"                                                                },       
	["petrol_raffin"]       ={["name"] = "petrol_raffin"      , ["label"] = "Refined Petrol"              , ["weight"] =   2400, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İşlenmiş kaliteli petrol."                                                        },       
	["pismis_balik"]        ={["name"] = "pismis_balik"       , ["label"] = "Baked fish"               , ["weight"] =   400 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güzelce pişirilmiş kılçıksız balık."                                              },       
	["pk"]                  ={["name"] = "pk"                 , ["label"] = "Painkiller"                , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Reçetesiz kullanımı yasaktır."                                                    },       
	["plastik_sise"]        ={["name"] = "plastik_sise"       , ["label"] = "Plastic bottle"               , ["weight"] =   70  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Geri dönüştürülebilir atık plastik şişe."                                         },       
	["polis_karti"]         ={["name"] = "polis_karti"        , ["label"] = "Police ID"              , ["weight"] =  25  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Polis Kimliği"                                                                    },       
	
	["id_card"]         ={["name"] = "id_card"        , ["label"] = "ID CARD"              , ["weight"] =  250  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kişisel bilgilerini gösteren vatandaş kimliği"                                                                    },       
	['driver_license'] 				 = {['name'] = 'driver_license', 			  	['label'] = 'Driver License', 			['weight'] = 0, 		['type'] = 'item', 		 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Araç sürebileceğinizi gösterme izni'},
	['hunting_license'] 				 = {['name'] = 'hunting_license', 			  	['label'] = 'Hunting License', 			['weight'] = 0, 		['type'] = 'item', 		 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Legal bir şekilde avlanabilmenizi gösteren lisans'},
	['weaponlicense'] 				 = {['name'] = 'weaponlicense',				    ['label'] = 'Weapon License',			['weight'] = 0,			['type'] = 'item',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Silah kullanabileceğini gösteren izin.'},
	
	['cctv'] 		 				 = {['name'] = 'cctv', 							['label'] = 'CCTV Camera', 				['weight'] = 5000, 	    ['type'] = 'item', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Single Heading CCTV Camera (Manually Placeable)'},
	['360cctv'] 		 			 = {['name'] = '360cctv', 						['label'] = '360D CCTV Camera', 			['weight'] = 10000, 	    ['type'] = 'item', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '360 Degree Revolvable CCTV Camera (Manually Placeable)'},
	['camviewer'] 		 			 = {['name'] = 'camviewer', 					['label'] = 'CamViewer', 			    ['weight'] = 7000, 	    ['type'] = 'item', 		 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Remote Camera Viewer and Controller'},
	
	["portakal_suyu"]       ={["name"] = "portakal_suyu"      , ["label"] = "Orange juice"              , ["weight"] =  700 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Taze sıkma portakal suyu."                                                        },       
	["psus"]                ={["name"] = "psus"               , ["label"] = "Cake Decoration"                 , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ekmek bulamıyorlarsa süslü pasta yesinler."                                       },       
	["rc_car"]              ={["name"] = "rc_car"             , ["label"] = "RC Car"                   , ["weight"] =  1000 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Uzaktan kumandalı elektrikli araba."                                              },       
	["tkumanda"]              ={["name"] = "tkumanda"             , ["label"] = "TV remote"                   , ["weight"] =  1000 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Uzaktan kumandalı elektrikli araba."                                              },       
	["recycle_item"]        ={["name"] = "recycle_item"       , ["label"] = "Recycle Product"         , ["weight"] = 50    , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Geri dönüştürülebilir kaliteli plastik çöp."                                      },       
	["rhum"]                ={["name"] = "rhum"               , ["label"] = "Rum"                        , ["weight"] =   160, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Korsan içkisi"                                                                    },       
	["rhumcoca"]            ={["name"] = "rhumcoca"           , ["label"] = "Rum-Cola"                   , ["weight"] =   140, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Etkisi uzun süre kalabilir."                                                      },       
	["rhumfruit"]           ={["name"] = "rhumfruit"          , ["label"] = "Rum-Fruit"                  , ["weight"] =   145, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rom un acılığını alan meyveli kokteyl."                                           },       
	["sarma_ot"]            ={["name"] = "sarma_ot"           , ["label"] = "Joint"                   , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Size kendinizi çok sağlıklı hissettiren yasadışı bir malzeme"                                                                              },       
	["oxy"]            ={["name"] = "oxy"           , ["label"] = "Gory"                   , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Size kendinizi çok sağlıklı hissettiren yasadışı bir malzeme"                                                                              },       
	["ifak"]            ={["name"] = "ifak"           , ["label"] = "Ifak"                   , ["weight"] =   100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Size kendinizi çok sağlıklı hissettiren yasadışı bir malzeme"                                                                              },       
	["shark_doping"]        ={["name"] = "shark_doping"       , ["label"] = "Doping"                     , ["weight"] =  50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Size kendinizi çok dayanıklı hissettiren yasadışı bir malzeme"                                                                              },       
	["siyah_kart"]          ={["name"] = "siyah_kart"         , ["label"] = "Black Card"                 , ["weight"] =   25 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Siyah renkte bir güvenlik kartı"                                                                              },       
	["sogan"]               ={["name"] = "sogan"              , ["label"] = "Onion"                      , ["weight"] =   1000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Doğrarken gözlük takmayı unutma."                                                 },       
	["sosis"]               ={["name"] = "sosis"              , ["label"] = "Sausage"                      , ["weight"] =   200 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Et silindiri."                                                                    },       
	["sucuk"]               ={["name"] = "sucuk"              , ["label"] = "Sausage"                      , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sert et silindiri."                                                               },       
	["sut"]                 ={["name"] = "sut"                , ["label"] = "Milk"                        , ["weight"] =   250 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Pastörize, UHT."                                                                  },       
	["su_alti"]             ={["name"] = "su_alti"            , ["label"] = "Underwater Regulator"         , ["weight"] =  1250   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Su altında bir süre nefes almanıza yarayan alet"                                                                              },       
	["su_alti2"]            ={["name"] = "su_alti2"           , ["label"] = "Diving Equipment"         , ["weight"] =  1250   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Su altında bir süre nefes almanıza yarayan gelişmiş alet"                                                                              },       
	["tarak"]               ={["name"] = "tarak"              , ["label"] = "Comb"                      , ["weight"] =  100  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tayyar bana tarrak aldı cümlesindeki nesne."                                      },       
	["tavukatom"]           ={["name"] = "tavukatom"          , ["label"] = "Quality Atom"              , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bildiğiniz atom ama daha iyisi."                                                  },       
	["tavukburger"]         ={["name"] = "tavukburger"        , ["label"] = "Chicken Burger"               , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tavuk eti içeren lezzetli, doyurucu burger."                                      },       
	["tavuknuggets"]        ={["name"] = "tavuknuggets"       , ["label"] = "Chicken Nuggets"               , ["weight"] =   200 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kızarmış tavuk parçaları."                                                        },       
	["tavuksoganhalkasi"]   ={["name"] = "tavuksoganhalkasi"  , ["label"] = "Onion rings"              , ["weight"] =  300  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kızarmış soğan halkaları."                                                        },       
	["tavuksos"]            ={["name"] = "tavuksos"           , ["label"] = "Chicken Sauce"                 , ["weight"] =   10  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Her şeye tat katan gizli lezzet formülü."                                         },       
	["teqpaf"]              ={["name"] = "teqpaf"             , ["label"] = "Tequila-Lemon"              , ["weight"] =  80  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sanki yeterince can yakmıyormuş gibi."                                            },       
	["tequila"]             ={["name"] = "tequila"            , ["label"] = "Tequila"                    , ["weight"] =   80 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dikkat, çarpar."                                                                  },       
	["toothpaste"]          ={["name"] = "toothpaste"         , ["label"] = "Tooth paste"                 , ["weight"] =  300  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Basit bir diş macunu."                                                            },       
	["turtle_soup"]         ={["name"] = "turtle_soup"        , ["label"] = "Turtle Soup"         , ["weight"] =  250 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Masum kaplumbağalardan yapılmış bir çorba.."                                      },       
	["tuz"]                 ={["name"] = "tuz"                , ["label"] = "Salt"                        , ["weight"] = 10    , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaya tuzu."                                                                       },       
	["vodka"]               ={["name"] = "vodka"              , ["label"] = "Vodka"                      , ["weight"] =   80 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Şişede durduğu gibi durmaz."                                                      },       
	["vodkaenergy"]         ={["name"] = "vodkaenergy"        , ["label"] = "Vodka-Energy"               , ["weight"] =   90 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Önce yükseltir, sonra düşürür."                                                   },       
	["vodkafruit"]          ={["name"] = "vodkafruit"         , ["label"] = "Vodka-Fruit"                , ["weight"] =  900  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Meyveli her şey sağlıklı olmuyor."                                                },       
	["water"]               ={["name"] = "water"              , ["label"] = "Water"                         , ["weight"] =   200 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Doğal Santos kaynak suyu."                                                        },       
	["whisky"]              ={["name"] = "whisky"             , ["label"] = "Whisky"                      , ["weight"] =   80 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kalite arayanlara arayışlarına devam etme sebebi."                                },       
	["whiskycoca"]          ={["name"] = "whiskycoca"         , ["label"] = "Whisky-Cola"                 , ["weight"] =   90 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Viski ve Kolanın birleşimi."                                                     },       
	["wine"]                ={["name"] = "wine"               , ["label"] = "Wine"                      , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Üzümden yapılma alkollü içecek, kırmızı."                                         },       
	["wood"]                ={["name"] = "wood"               , ["label"] = "Wood"                       , ["weight"] =   5000, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dümdüz odun."                                                                     },       
	["yesil_kart"]          ={["name"] = "yesil_kart"         , ["label"] = "Green Card"                 , ["weight"] =  100  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yeşil renkte bir güvenlik kartı"                                                                              },       
	["yosun"]               ={["name"] = "yosun"              , ["label"] = "Moss"                      , ["weight"] =   300 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Su altından toplanmış, yeşil bitki."                                              },       
	["tzamanlayici"]        ={["name"] = "tzamanlayici"       , ["label"] = "Termite Timer"         , ["weight"] =   600 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tik tak, tik tak."                                              }, 
	["ticaretm"]            ={["name"] = "ticaretm"       	  , ["label"] = "Trade Material"          , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaliteli bir şekilde paketlenmiş, hazır ticaret malzemesi"                                              }, 
	["ticaretk"]            ={["name"] = "ticaretk"       	  , ["label"] = "Trade Material"          , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaliteli bir şekilde paketlenmiş, hazır ticaret malzemesi"                                              }, 
	["bilet"]               ={["name"] = "bilet"       		  , ["label"] = "Holiday Ticket"         	   	 , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "En kısa sürede kullan"                                              }, 
	["emp"]                 ={["name"] = "emp"       		  , ["label"] = "EMP"         				 , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Dikkatli ol."                                              }, 
	["tyengec"]       	    ={["name"] = "tyengec"       	  , ["label"] = "Cleaned Crab"         , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Temizlenmiş ve ayıklanmış yengeç."                                              }, 
	["yemekyengec"]         ={["name"] = "yemekyengec"        , ["label"] = "Crab Meal"              , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Lezzetli bir su ürünü yemeği."                                              }, 
	["adrenalin"]           ={["name"] = "adrenalin"          , ["label"] = "Adrenalin"                  , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Canına can katar"                                              }, 
	["pparca"]              ={["name"] = "pparca"             , ["label"] = "Quality Vehicle Parts"    , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Belki bir işe yarıyordur?"                                              }, 
	["tavukmenu"]           ={["name"] = "tavukmenu"          , ["label"] = "Chicken Rice"                 , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Pops Tavuk Menü."                                              }, 
	["pburger"]             ={["name"] = "pburger"            , ["label"] = "Lentil soup"                , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Pops Burger."                                              }, 
	["kahve"]               ={["name"] = "kahve"              , ["label"] = "Coffee"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Arjantin olmasa da idare eder."                                              }, 
	["etmenu"]      	    ={["name"] = "etmenu"        	  , ["label"] = "Onion Meatballs"                    , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Pops Et Menü."                                              }, 
	["kemer"]      	  	    ={["name"] = "kemer"       		  , ["label"] = "Belt"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sıkı kemer"                                              }, 
	["makarna"]        		={["name"] = "makarna"       	  , ["label"] = "Beans and rice"               , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Pops soslu makarna"                                              }, 
	["kahvea"]       	    ={["name"] = "kahvea"       	  , ["label"] = "Coffee bean"            , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaliteli kahve çekirdekleri."                                              }, 
	["abc"]        			={["name"] = "abc"       		  , ["label"] = "ABC"         				 , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Eğlencenin ABC'si"                                              }, 
	["izlipara"]        		={["name"] = "izlipara"       		  , ["label"] = "Traced Money"         		 , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bir bankadan çalınmış, işaretli para"                                              }, 
	["hackcoin"]        	={["name"] = "hackcoin"       	  , ["label"] = "V Coin"         		     , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "We do not forgive. We do not forget. Expect us"                                              }, 
	["casinochips"]        	={["name"] = "casinochips"        , ["label"] = "Diamond Casino"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Paranızı sağa sola savurmanın eğlenceli yolu"                                              }, 
	["burgerl"]        	={["name"] = "burgerl"        , ["label"] = "Steak Burger"             , ["weight"] =   250 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Steak kızarmış etin kemiksiz bir parçasıdır. En iyi sığır eti parçaları biftek de adlanır. Normalde ızgara şeklinde yapılsa da tavada kızartma da yapılır. Biftek, farklı soslarla da pişirilebilir, kıyılarak hamburger gibi köfte haline getirilebilir, barbekü, kebap, mangal türünde yapılabilir."                                              }, 
	["burgerm"]        	={["name"] = "burgerm"        , ["label"] = "Wet Hamburger"             , ["weight"] =   150 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Islak hamburgeri özel kılan birçok detaydan başlıca olanları ekmeği, özel sosu ve köftesidir. Islak hamburger ekmeği, sadece ıslak hamburger yapımında kullanılmak üzere özel olarak üretilmektedir. Özel sos ile tatlandırılan ekmek dağılmadan hamburger köftesini tutar ve lezzeti doruk noktasına ulaştırır."                                              }, 
	["burgers"]        	={["name"] = "burgers"        , ["label"] = "Onion rings"             , ["weight"] =   100 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Soğan halkası, bir fast food türüdür. ABD, Kanada, Birleşik Krallık, İrlanda, Avustralya, Yeni Zelanda, Güney Afrika, Türkiye ve bazı Asya ve Kıta Avrupası ülkelerinde yaygın olarak yapılmaktadır. Genellikle halka şeklindeki soğan dilimlerini unladıktan sonra yağda kızartarak yapılır."                                              }, 
	["burgerxl"]        	={["name"] = "burgerxl"        , ["label"] = "Burger"             , ["weight"] =   200 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hamburger veya sadece Burger, iki dilim yuvarlak sandviç ekmeği arasına yerleştirilen bir köfteyle yapılan sandviç türü. Genellikle ketçap, mayonez, turşu, soğan, domates, hardal ve bunun gibi değişik malzemelerin de ilavesi ile servis edilir."                                              }, 
	["domates2"]        	={["name"] = "domates2"        , ["label"] = "Cold Tomatoes"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İnce ince dilimlenmiş lezzetli görünen bir domates"                                              }, 
	["friesl"]        	={["name"] = "friesl"        , ["label"] = "Big Potato"             , ["weight"] =   200 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İnce dilim hazırlanmış, kızartılmış büyük boy patates"                                              }, 
	["friesm"]        	={["name"] = "friesm"        , ["label"] = "Medium Potato"             , ["weight"] =   150 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İnce dilim hazırlanmış, kızartılmış orta boy patates"                                              }, 
	["friess"]        	={["name"] = "friess"        , ["label"] = "Mini Potatoes"             , ["weight"] =   100 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İnce dilim hazırlanmış, kızartılmış mini boy patates"                                              }, 
	["friesxl"]        	={["name"] = "friesxl"        , ["label"] = "XL Potatoes"             , ["weight"] =   250 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İnce dilim hazırlanmış, kızartılmış dev boy patates"                                              }, 
	["hotdogl"]        	={["name"] = "hotdogl"        , ["label"] = "Hot dog"             , ["weight"] =   230 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sosisli sandviç, değişik tariflere göre hazırlanan sosislerin, pişirilip, sıcak şekilde sunulduğu sandviç'e verilen isimdir. Genellikle sıcak ve yumuşak olarak hazırlanmış sosisler, sosis uzunluğunda - ya da daha kısa - sandviç ekmeklerinin içine konulur."                                              }, 
	["hotdogm"]        	={["name"] = "hotdogm"        , ["label"] = "Corn Dog"             , ["weight"] =   200 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Amerikan kızartılmış sosis Amerikan eyalet fuarlarında yaygın olarak tüketilen bir yemektir."                                              }, 
	["hotdogs"]        	={["name"] = "hotdogs"        , ["label"] = "Mac Cheese"             , ["weight"] =   150 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Peynir soslu makarna, çedar peynirinden hazırlanan soslu makaroni makarnası. Menşesi muhtemelen Kuzey Avrupadır. Ilk bilinen tarif 1769 yılındandır. Amerikan Cumhurbaşkanı Thomas Jefferson Fransa seyahat ettiğinde yiyip çok beğenmiş ve Amerikan mutfağına tanıtmış."                                              }, 
	["hotdogxl"]        	={["name"] = "hotdogxl"        , ["label"] = "Mozarella Bar"             , ["weight"] =   75 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İngilizceden çevrilmiştir-Mozzarella çubukları, genellikle ordövr olarak servis edilen uzun hırpalanmış veya ekmekli mozzarella parçalarıdır. Mozzarella çubukları domates, ketçap veya marinara sosu ile erik sosu, jalapeno jeli, barbekü sosu, bal hardal sosu ve çiftlik sosu ile servis edilebilir."                                              }, 
	["marul2"]        	={["name"] = "marul2"        , ["label"] = "Cold Lettuce"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yıkanmış, taze ve dilimlenmiş marul parçaları"                                              }, 
	["patates2"]        	={["name"] = "patates2"        , ["label"] = "Sliced ​​Potato"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Taze ve parmak kalınlığında dilimlenmiş patates"                                              }, 
	["sogan2"]        	={["name"] = "sogan2"        , ["label"] = "Chopped Onion"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Görenin gözlerini yaşartan taze doğranmış soğan"                                              }, 
	["tacok"]        	={["name"] = "tacok"        , ["label"] = "Nacho"             , ["weight"] =   80 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Nachos, kuzey Meksika kökenli bir Tex-Mex mutfağı yemeği. Yemek, totopo ekmeklerinden, bilinen adıyla tortilla cipslerin peynir ya da peynir bazlı bir sosla kaplanmasıyla oluşur. Genellikle atıştırmalık olarak servis edilir. İlk olarak 1943'te Ignacio Nacho Anaya tarafından yaratılmıştır."                                              }, 
	["tacos"]        	={["name"] = "tacos"        , ["label"] = "Churro"             , ["weight"] =   210 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Churro, bir tür kızarmış hamur tatlısı. İspanya, Portekiz, Fransa, Filipinler, İbero-Amerika ve Güneybatı Amerika Birleşik Devletleri'nde popülerdir. Genellikle kahvaltıda champurrado, café con leche, sıcak çikolata veya süt reçeline batırılarak yenir."                                              }, 
	["tacot"]        	={["name"] = "tacot"        , ["label"] = "Burrito"             , ["weight"] =   350 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Burrito veya taco de harina, bir Meksika yemeği. Dürüme benzer. Tortillanın katlanış biçimi, içerisine sürülen fasulye püresi, et, tavuk, peynir gibi malzemelerle değişik çeşitler hazırlanabilir."                                              }, 
	["tacoxl"]        	={["name"] = "tacoxl"        , ["label"] = "Taco"             , ["weight"] =   175 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Taco, geleneksel Meksika yemeği. Birçok şekilde yapılabilmektedir. Yapımında tortilla, et, peynir ve çeşitli sebzeler kullanılır. Ayrıca, yanında bazı garnitürler de tüketilebilir. Genellikle elle yenilmektedir. Taco, Meksika'da Avrupalılar'ın gelişinden önce tüketilmeye başlanmıştır."                                              }, 
	["tburgerl"]        	={["name"] = "tburgerl"        , ["label"] = "Chicken Bucket"             , ["weight"] =   300 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kısaca kızarmış tavuk olarak da bilinen güneyde kızarmış tavuk, terbiyeli un veya hamurla kaplanmış ve tavada kızartılmış, derin yağda kızartılmış, basınçlı kızartılmış veya havada kızartılmış tavuk parçalarından oluşan bir yemektir. Kova halinde paketlenmiştir ve yemeye hazırdır."                                              }, 
	["tburgerm"]        	={["name"] = "tburgerm"        , ["label"] = "Caesar salad"             , ["weight"] =   200 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sezar salatası limon suyu, zeytinyağı, yumurta, Worcestershire sos, ançuez, sarımsak, Dijon hardalı, Parmesan peyniri ve karabiber ile hazırlanan yeşil marul ve krutonlu yeşillik salatasıdır. Türkiye'de ançüez yerine genellikle ızgara tavuk göğsü kullanılır."                                              }, 
	["tburgers"]        	={["name"] = "tburgers"        , ["label"] = "Zurna Chicken Wrap"             , ["weight"] =   175 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "56cm lik silindir zevk. Tavuk dönerden hazırlanmıştır."                                              }, 
	["tburgerxl"]        	={["name"] = "tburgerxl"        , ["label"] = "Chicken Burger"             , ["weight"] =   200 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tavuk Burger, iki dilim yuvarlak sandviç ekmeği arasına yerleştirilen bir kızartılmış tavuk göğsü konularak yapılan sandviç türü. Genellikle ketçap, mayonez, turşu, soğan, domates, hardal ve bunun gibi değişik malzemelerin de ilavesi ile servis edilir."                                              }, 
	["menubell"]        	={["name"] = "menubell"        , ["label"] = "AT1071 Package"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Anadolu Tat 1071 mağazasında hazırlanmış bir paket"                                              }, 
	["menuhot"]        	={["name"] = "menuhot"        , ["label"] = "Contrary Package"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Aksi Büfe mağazasında hazırlanmış bir paket"                                              }, 
	["menushot"]        	={["name"] = "menushot"        , ["label"] = "Shot Package"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Burger Shot mağazasında hazırlanmış bir paket"                                              }, 
	["menutaco"]        	={["name"] = "menutaco"        , ["label"] = "Taco Package"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Taco Libre mağazasında hazırlanmış bir paket"                                              }, 
	["menudiner"]        	={["name"] = "menudiner"        , ["label"] = "Homemade Food Package"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Niyazi Ev Yemekleri mağazasında hazırlanmış bir paket"                                              }, 
	["ayran"]        	={["name"] = "ayran"        , ["label"] = "Ayran"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Ayran, yoğurdun içine su katılarak elde edilen bir tür içecek. Türk mutfağına ait olan en yaygın içeceklerdendir. Türkiye, Ermenistan, Azerbaycan, İran, Lübnan, Bulgaristan ve diğer bazı Balkan ülkeleriyle Orta Doğu ve Orta Asya ülkelerinde yapılır. Ayran yapımında doğal nitelikli yağlı koyun yoğurdu yeğlenir."                                              }, 
	["kola"]        	={["name"] = "kola"        , ["label"] = "Cola"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Kola, karamel ile renklendirilen, şekerli veya tatlandırıcılı, kafein içeren, alkolsüz, sodalı bir içecek. Botanikte Cola acuminata olarak geçen ağacın meyveleri ve onun meşrubat olarak kullanılan haline verilen isimdir. Bu meyvenin tohumunun kırmızı bir suyu vardır."                                              }, 
	["cay"]        	={["name"] = "cay"        , ["label"] = "Tea"             , ["weight"] =   0 ,  ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Çay, çeşitli bitkilerin yapraklarının, çiçeklerinin, köklerinin, gövdelerinin, kabuklarının, tohumlarının kaynatılmasıyla veya haşlanmasıyla elde edilen bir içecek türüdür. Çay çalısının bilimsel ismi Camellia sinensistir."                                              }, 
	["atom"]                ={["name"] = "atom"               , ["label"] = "Atom"                       , ["weight"] =   400, ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enerji dolu, sağlıklı içecek."                                                    },       
	["huntingbait"]      	  	    ={["name"] = "huntingbait"       		  , ["label"] = "Bait (Hunter)"                      , ["weight"] =   150 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""                                              }, 
	["huntingknife"]      	  	    ={["name"] = "huntingknife"       		  , ["label"] = "Leather Knife"                      , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""                                              }, 
	["geyikderisi"]      	  	    ={["name"] = "geyikderisi"       		  , ["label"] = "Deerskin"                      , ["weight"] =   750 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                              }, 
	["boktancesed"]      	  	    ={["name"] = "boktancesed"       		  , ["label"] = "Shit Deer Body"                      , ["weight"] =   1600 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                              }, 
	["kotucesed"]      	  	    ={["name"] = "kotucesed"       		  , ["label"] = "Evil Deer Corpse"                      , ["weight"] =   1800 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                              }, 
	["iyicesed"]      	  	    ={["name"] = "iyicesed"       		  , ["label"] = "Good Deer Corpse"                      , ["weight"] =   2000 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                              }, 
	["kalitelicesed"]      	  	    ={["name"] = "kalitelicesed"       		  , ["label"] = "Quality Deer Body"                      , ["weight"] =   2200 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                              }, 
	-- ["geyiketi"]      	  	    ={["name"] = "geyiketi"       		  , ["label"] = "Geyik Eti"                      , ["weight"] =   2000 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""                                              }, 

	["ahtapot"]      	  	    ={["name"] = "ahtapot"       		  , ["label"] = "Octopus"                      , ["weight"] =   1100 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ahtapot yumuşak gövdeli, sekiz kollu, Octopoda takımında sınıflandırılan yumuşakçaların genel adı. Kabul görmüş 300 civarında türü bulunan ahtapotlar kalamarlar, mürekkep balıkları ve nautiloidler ile birlikte kafadan bacaklılar sınıfında gruplandırılırlar."}, 
	["ahtapotsalata"]      	  	    ={["name"] = "ahtapotsalata"       		  , ["label"] = "Octopus salad"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ahtapot salatası, Türk mutfağında bir salata. Girit mutfağı kökenlidir. Ahtapotun haşlanıp, düğmeleri ayıklanıp -genellikle tamamı soyulduktan sonra- dilimlenip zeytinyağı - limon sosu ile sunulması. Genellikle zeytin, sarımsak, karabiber, kuru soğan, yeşil biber ve al biber de bu salatada kullanılır."}, 
	["americano"]      	  	    ={["name"] = "americano"       		  , ["label"] = "Americano"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Caffè Americano ya da Americano sıcak su ekleyerek espresso kaynatmak yöntemi ile hazırlanan kahve çeşidi. Bu yöntem ile filtre kahveden farklı bir tat elde edilirken kahvenin sertliği korunur. Americano nun sertliği eklenen espresso ve suyun miktarına göre değişir."}, 
	["baliketi"]      	  	    ={["name"] = "baliketi"       		  , ["label"] = "Fish"                      , ["weight"] =   120 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Balık eti, deniz veya tatlı sularda yakalanan soğuk kanlı solungaçları ile solunum yapan hayvanların besin olarak kullanılan etleridir."}, 
	["balikizgara"]      	  	    ={["name"] = "balikizgara"       		  , ["label"] = "Grilled fish"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Izgarada pişirilmiş farklı balıklardan yapılabilen. Limon, soğan ile servis edilen lezzetli yiyecek."}, 
	["generaltso"]      	  	    ={["name"] = "generaltso"       		  , ["label"] = "General Tso Chicken"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "General Tso nun tavuğu, Tayvan merkezli Hunan mutfağı şefi Peng Chang-kuei tarafından icat edilen Kuzey Amerika Çin restoranlarında servis edilen tatlı bir derin yağda kızartılmış tavuk yemeğidir."}, 
	["graphius"]      	  	    ={["name"] = "graphius"       		  , ["label"] = "Graphius"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İçeriğinde üzüm bulunan, serinletici ve ferahlatıcı bir içecek."}, 
	["kahvekek"]      	  	    ={["name"] = "kahvekek"       		  , ["label"] = "Coffee Cake"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Un, şeker ve yumurta karışımı, genellikle içine çekirdeksiz kuru üzüm, kakao vb. de konularak yapılan, fırında pişirilen ekstra olarak kahve aromalı tatlı çörek."}, 
	["karagoz"]      	  	    ={["name"] = "karagoz"       		  , ["label"] = "Karagöz"                      , ["weight"] =   200 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ortak iki bantlı çipura, Sparidae familyasına ait bir çipura türüdür."}, 
	["karides"]      	  	    ={["name"] = "karides"       		  , ["label"] = "Prawn"                      , ["weight"] =   120 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Karides, Avrupa denizlerinde ve Kuzey Amerika kıyılarında yaşayan, kabuklular sınıfındandır. Silindirik vücutlu, uzun duyargalıdır. Boyu 5–6 cm dir. Vücudu kalsiyum karbonattan meydana gelen bir zırhla örtülüdür. Gövdesi eklemlidir. Geniş yüzgeçimsi kuyruğunu sallayarak geri geri yüzer."}, 
	["karidesizgara"]      	  	    ={["name"] = "karidesizgara"       		  , ["label"] = "Grilled Shrimp"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Muhteşem görünümlü, lezzetli. Tereyağında kızartılmış ve ardından ızgarada tam olarak pişirilmiş lezzetli karides yemeği."}, 
	["kayabalik"]      	  	    ={["name"] = "kayabalik"       		  , ["label"] = "Rock Fish"                      , ["weight"] =   150 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kaya balığı, oldukça geniş bir balık türü ailesi olan 200 den fazla cinsi ve 2.000 den fazla türü bulunan Gobiidae familyasından bir balıktır. Çoğunluğu tipik olarak 10 cm büyüklüğünde olup, göreceli olarak oldukça küçüktürler."}, 
	["kekuzum"]      	  	    ={["name"] = "kekuzum"       		  , ["label"] = "Grape cake"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Un, şeker ve yumurta karışımı, genellikle içine çekirdeksiz kakao vb. de konularak yapılan, fırında pişirilen ekstra olarak bol kuru üzümlü ve üzüm aromalı tatlı çörek."}, 
	["latte"]      	  	    ={["name"] = "latte"       		  , ["label"] = "Latte"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Latte, İtalyanca'da Süt anlamına gelmektedir. Asıl adı Caffe Latte Machiatodur. Espresso, buharla ısıtılmış kıvamlı süt dolu bir kupaya eklenir. Genellikle ince ve uzun bardakta servis edilir. İsteğe göre üzerine süt köpüğü ve tatlı krema eklenir."}, 
	["levrek"]      	  	    ={["name"] = "levrek"       		  , ["label"] = "Sea bass"                      , ["weight"] =   195 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Levrek birçok balık türü tarafından paylaşılan bir isimdir. Terim, tümü büyük takım Perciformese veya levrek benzeri balıklara ait olan hem tatlı su hem de deniz türlerini kapsar. Bas kelimesi, levrek anlamına gelen Orta İngilizce barlarından gelir"}, 
	["lufer"]      	  	    ={["name"] = "lufer"       		  , ["label"] = "Bluefish"                      , ["weight"] =   180 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Lüfer, Pomatomidae familyasından ekonomik değeri yüksek bir balık türü. Vücutları uzun, sırt yüzgeçleri iki tane, kuyrukları çatallı, ağızları iri, dişleri sivri ve güçlüdür. Yan çizgi hemen hemen düz olup, pullarla örtülüdür. Yan çizgide pul sayısı 95-100 adettir."}, 
	["macha"]      	  	    ={["name"] = "macha"       		  , ["label"] = "Mocha"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Matcha, özel olarak yetiştirilen ve işlenen öğütülmüş bir yeşil çay tozudur. Geleneksel olarak, klasik Japon çay seremonisinde kullanılır. Ayrıca, wagashi tatlısı türlerine, yeşil çaylı dondurmaya, soba adlı yemeğe gıda ilavesi olarak kullanılmaktadır. Maçça tozuna da Maçça denir."}, 
	["mezetabagi"]      	  	    ={["name"] = "mezetabagi"       		  , ["label"] = "Appetizer Plate"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Meze Doğu Akdeniz de ve özellikle Türk mutfağında yer alan bir yiyecek grubudur. Genelde soğuk servis edilir. Ana yemek öncesi aperitif olarak yenildiği gibi, çilingir sofralarının da vazgeçilmez öğesidir. Mezeler çok değişik türlerde olabilir."}, 
	["mochi"]      	  	    ={["name"] = "mochi"       		  , ["label"] = "Mochi"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Mochi, mochigome, kısa taneli yapışkan pirinç ve bazen su, şeker ve mısır nişastası gibi diğer bileşenlerden yapılan Japon pirinç kekidir. Pirinç ezilerek özel yöntemlerle hamur kıvamına ve istenen şekle getirilir. Japonya da geleneksel olarak mochitsuki adı verilen bir törenle yapılır."}, 
	["morina"]      	  	    ={["name"] = "morina"       		  , ["label"] = "Cod"                      , ["weight"] =   950 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Morina, Gadidae familyasına mensup Gadus cinsi balıkların genel adıdır. Ayrıca diğer bazı balık çeşitleri için de kullanılabilen genel bir addır. Morina balığı suyun derinliğine göre renk değiştirebilme özelliğine sahiptir. Morinanın ağırlığı yaklaşık 4,5 kg ile 11,3 kg arasındadır."}, 
	["pkonserve"]      	  	    ={["name"] = "pkonserve"       		  , ["label"] = "Rusty Tins"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Paslanmış artık kullanılamayacak halde bir konserve. Kim bilir zamanında içinde ne vardı.."}, 
	["pogacadomates"]      	  	    ={["name"] = "pogacadomates"       		  , ["label"] = "Tomato Pastry"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hamuruna yoğurt katılıp içine domates konularak hazırlanan bir tür tuzlu çörek."}, 
	["pogacapatates"]      	  	    ={["name"] = "pogacapatates"       		  , ["label"] = "Potato Pastry"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hamuruna yoğurt katılıp içine patates konularak hazırlanan bir tür tuzlu çörek."}, 
	["psise"]      	  	    ={["name"] = "psise"       		  , ["label"] = "Dirty Bottle"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Su içerisinde durmaktan yıpranmış ve kullanılmayacak hale gelmiş pis şişe.."}, 
	["ksise"]      	  	    ={["name"] = "ksise"       		  , ["label"] = "Dirty Glass Bottle"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Su içerisinde durmaktan yıpranmış ve kullanılmayacak hale gelmiş pis şişe.."}, 
	["raki"]      	  	    ={["name"] = "raki"       		  , ["label"] = "New raki"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rakı; damıtma yoluyla elde edilen suma kullanılan ve genellikle anason tohumu ile aromalandırılan, alkollü bir geleneksel Türk içkisi."},
	["rakibardak"]      	  	    ={["name"] = "rakibardak"       		  , ["label"] = "New raki"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rakı; damıtma yoluyla elde edilen suma kullanılan ve genellikle anason tohumu ile aromalandırılan, alkollü bir geleneksel Türk içkisi."},
	["beyazpeynir"]      	  	    ={["name"] = "beyazpeynir"       		  , ["label"] = "Feta cheese"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rakı; damıtma yoluyla elde edilen suma kullanılan ve genellikle anason tohumu ile aromalandırılan, alkollü bir geleneksel Türk içkisi."},
	["ezme"]      	  	    ={["name"] = "ezme"       		  , ["label"] = "Crushing"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rakı; damıtma yoluyla elde edilen suma kullanılan ve genellikle anason tohumu ile aromalandırılan, alkollü bir geleneksel Türk içkisi."},
	["tuzlufistik"]      	  	    ={["name"] = "tuzlufistik"       		  , ["label"] = "Salted Peanuts"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rakı; damıtma yoluyla elde edilen suma kullanılan ve genellikle anason tohumu ile aromalandırılan, alkollü bir geleneksel Türk içkisi."},        
	["ramen"]      	  	    ={["name"] = "ramen"       		  , ["label"] = "Ramen"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Rāmen, Çin kökenli olan ve çorba içinde sunulan eriştenin Japon mutfağındaki adıdır. Genellikle çorbası, et suyu ile yapılır ve dilimlenmiş et, kurutulmuş deniz yosunu, kamaboko, yeşil soğan ve hatta mısır gibi üst malzemeleri ile servis edilir."}, 
	["ringa"]      	  	    ={["name"] = "ringa"       		  , ["label"] = "Herring"                      , ["weight"] =   1000 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ringa, sardalyagiller familyasından kemikli balık cinsi. Ringaların Atlas okyanusunun kuzey kesiminde yaşayan Atlantik ringası, ince-uzun gövdeli, 12–40 cm boyunda, gövdesi gümüşi renkli bir balıktır. Genellikle plankton gibi küçük hayvanlarla beslenirse de, bazen büyük balıklara da saldırır."}, 
	["somon"]      	  	    ={["name"] = "somon"       		  , ["label"] = "Salmon"                      , ["weight"] =   300 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sombalığı, som balığı ya da somon olarak adlandırılan balıkların hepsi Salmoniformes sınıfının Salmonidae familyasına ait olsalar da aslında bu familyanın farklı cinslerindenlerdir: Salmo, Salmothymus, Stenodus ve Oncorhynchus."}, 
	["sushi"]      	  	    ={["name"] = "sushi"       		  , ["label"] = "Sushi"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Suşi, bir Japon mutfağı yemeğidir; pirinç sirkesi ve şeker ile tatlandırılmış haşlanmış pirinç üstüne veya içine balık, diğer deniz ürünleri veya sebze gibi malzemeler konarak servis edilir. Japonya çıkışlı bir yemek olmasına rağmen tüm Uzakdoğu ülkelerinde tüketilir."}, 
	["talabalik"]      	  	    ={["name"] = "talabalik"       		  , ["label"] = "Trout"                      , ["weight"] =   985 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Alabalık, Salmonidae familyasının en tanınmış üyesidir ve somon balığı ile yakın akrabadır. Alabalık diye adlandırdığımız balıkların bazıları Salmo cinsine ait değillerdir. Salmonidae ailesinin arta kalanını oluşturan Oncorhynchus ve Salvelinus cinslerine ait olan balıkların bazılarına da alabalık denilir."}, 
	["tranca"]      	  	    ={["name"] = "tranca"       		  , ["label"] = "Trance"                      , ["weight"] =   850 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Trança genelde sinaritlerin irisi için kullanilan bir isimdir. Lagos ve orfozla büyük benzerlik gösterirlerse de ayri familyalara mensupturlar. Aşırı yağlı ve oldukça lezzetlidir."}, 
	["tsazan"]      	  	    ={["name"] = "tsazan"       		  , ["label"] = "Carp"                      , ["weight"] =   250 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sazan, sazangiller familyasına adını veren tatlı su balığı. Göl ve yavaş akan derelerde bulunur. Uzun gövdeli, solucan, böcek larvaları ve bitkilerle beslenen bir dip balığıdır. 1,5 metre boyunda, 35 kg ağırlıkta olanları vardır. Ömrü 40-50 yıla kadar varabilir."}, 
	["uskumru"]      	  	    ={["name"] = "uskumru"       		  , ["label"] = "Mackerel"                      , ["weight"] =   150 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Uskumru bir deniz balığı. Aynı zamanda Uskumrugiller familyasına adını vermiş olan, bu familyanın örnek balığıdır. Vücut iğ şeklindedir. Sırtta aşağıya doğru inen açık veya koyu yeşilimsi-mavi, üzeri lekeli bantlar vardır. Başta beyin görünmez, karın tarafı açık gümüşi renktedir."}, 
	["wakame"]      	  	    ={["name"] = "wakame"       		  , ["label"] = "Wakame"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Wakame veya Undaria pinnatifida, bir deniz yosunu ve sebzesidir. Tadı tatlı olup genellikle çorbalar ve salatalarda kullanılır. Wakame Japonyada Nara döneminden beri yetiştirilmektedir. Wakame Küresel İstilacı Türler Veritabanına göre dünyanın en kötü 100 istilacı türlerü arasında aday gösterildi."}, 
	["yosun2"]      	  	    ={["name"] = "yosun2"       		  , ["label"] = "Dirty Moss"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Su yosunları ya da algler, sucul fotosentetik ökaryotları tanımlamak için kullanılan ve birbirleriyle akraba olmayan çeşitli grupları içine alan resmî olmayan bir terimdir."}, 
	["mastercard"]      	  	    ={["name"] = "mastercard"       		  , ["label"] = "ATM Card"                      , ["weight"] =   50 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 

	["paket_kargo_kolisi"]      	  	    ={["name"] = "paket_kargo_kolisi"       		  , ["label"] = "Packaged Takeaway Box"                      , ["weight"] =   500 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 

	["bodycam"]      	  	    ={["name"] = "bodycam"       		  , ["label"] = "Body Camera"                      , ["weight"] =   1111 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["dashcam"]      	  	    ={["name"] = "dashcam"       		  , ["label"] = "Car Camera"                      , ["weight"] =   1111 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["bilezik"]      	  	    ={["name"] = "bilezik"       		  , ["label"] = "Gold bracelet"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["bilezik2"]      	  	    ={["name"] = "bilezik2"       		  , ["label"] = "Embroidered Twist Bracelet"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["elmaskupe"]      	  	    ={["name"] = "elmaskupe"       		  , ["label"] = "Diamond Earrings"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["elmaskupe2"]      	  	    ={["name"] = "elmaskupe2"       		  , ["label"] = "Single Stone Diamond Earrings"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["incikolye"]      	  	    ={["name"] = "incikolye"       		  , ["label"] = "Pearl Necklace"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["illegalgotur"]      	  	    ={["name"] = "illegalgotur"       		  , ["label"] = "Illegal Cargo Package"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 

	["csaat"]      	  	    ={["name"] = "csaat"       		  , ["label"] = "Saat"                      , ["weight"] =   0 , ["type"] = "item", ["unique"] = true, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""}, 
	["ampul1"]={["name"] = "ampul1", ["label"] = "Bulb Green", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Şırıngaya aktarmaya hazır, yeşil renkli ilaç."},       
	["ampul2"]={["name"] = "ampul2", ["label"] = "Bulb Blue", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Şırıngaya aktarmaya hazır, mavi renkli ilaç."},    
	["ampul3"]={["name"] = "ampul3", ["label"] = "Bulb Red", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Şırıngaya aktarmaya hazır, kırmızı renkli ilaç"},    
	["hap1"]={["name"] = "hap1", ["label"] = "Pill Green", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Oral yolla alınan, yeşil renkli ilaç."},    
	["hap2"]={["name"] = "hap2", ["label"] = "Pill Blue", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Oral yolla alınan, mavi renkli ilaç."},    
	["hap3"]={["name"] = "hap3", ["label"] = "Pill Red", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Oral yolla alınan, kırmızı renkli ilaç."},    
	["merhem1"]={["name"] = "merhem1", ["label"] = "Ointment Green", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Deri üzerine sürülerek tatbik edilen, yeşil renkli ilaç."},    
	["merhem2"]={["name"] = "merhem2", ["label"] = "Ointment Blue", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Deri üzerine sürülerek tatbik edilen, mavi renkli ilaç."},    
	["merhem3"]={["name"] = "merhem3", ["label"] = "Ointment Red", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Deri üzerine sürülerek tatbik edilen, kırmızı renkli ilaç."},    
	["aspirin"]={["name"] = "aspirin", ["label"] = "Aspirin", ["weight"] =5, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "İki tane iç hiç bir şeyin kalmaz."},    
	["fitil"]={["name"] = "fitil", ["label"] = "Suppository", ["weight"] =15, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bunu böyle g*tune sokuyorsun amca!!"},    
	["flaster"]={["name"] = "flaster", ["label"] = "Plaster", ["weight"] =30, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yapışkan bandaj tam boyutlu bir bandaj gerektirecek kadar ciddi yaralanmalar için kullanılan küçük bir pansumandır. Ürün adı olmuş markalar olarak Band-Aid veya Elastoplast olarak bilinirler. Curad ve Nexcare gibi markalar da bulunuyor. Yapışkan bandaj yara ve kabuğu sürtünme, bakteri, hasar ve kirden korur."},    
	["enjektor"]={["name"] = "enjektor", ["label"] = "Injector", ["weight"] =8, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Tıpta, bir doku veya boşluğa basınçlı sıvı doldurmaya yarayan aletlere bu isim verilir. Yani enjeksiyon olayını gerçekleştiren bir alettir. Enjektörün camdan veya madenden, silindir şeklinde bir gövdesi ve bunun içinde gidip gelebilen bir pistonu vardır."},    
	["oturnike"]={["name"] = "oturnike", ["label"] = "Automatic Turnstile", ["weight"] =10, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Turnike, başka bir yöntemle önü alınamayan, ciddi yaşamı tehlikeye sokan kanamalarda uygulanmalıdır. Turnike, yalnız büyük bir damarın (arterin) kesildiği durumlarda gereklidir. Turnike, yaranın biraz yukarısına, eklem yerine gelmeyecek şekilde ve yaraya değmeyecek biçimde yerleştirilmelidir."},    
	["spanch"]={["name"] = "spanch", ["label"] = "Spanch", ["weight"] =5, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hidrofil gaz bezinin dikdörtgen ve kare şeklinde, kenarlarından serbest lifler vermeyecek 8-24 kat arası dikişsiz olarak katlanması ile oluşturulan tıbbi malzemedir."},    
	["termojel"]={["name"] = "termojel", ["label"] = "Thermogel", ["weight"] =40, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Hem sıcak hem de soğuk terapide kullanılabilen kumaş kaplı termojeldir."},    
	["vacut"]={["name"] = "vacut", ["label"] = "Vacutainer", ["weight"] =20, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Bir Vacutainer kan alma tüpü, tüpün içinde bir vakum sızdırmazlığı sağlayan renkli bir kauçuk tıpaya sahip olan ve önceden belirlenmiş bir sıvı hacminin çekilmesini kolaylaştıran steril bir cam veya plastik test tüpüdür."},
   	-- ["bodycam"]             ={["name"] = "bodycam"            , ["label"] = "Bodycam"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kayıt Cihazı"},   	["bodycam"]             ={["name"] = "bodycam"            , ["label"] = "Bodycam"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Kayıt Cihazı"},
    ["bronze_record"]          ={["name"] = "bronze_record"            , ["label"] = "Bronze Record"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bronze Plak"},
	["printerdocument"]          ={["name"] = "printerdocument"            , ["label"] = "Printer Output"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Çıktı"},
	["yemek_jetonu"]          ={["name"] = "yemek_jetonu"            , ["label"] = "Meal Coupon"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yemekçi Fred İçin Kullanılan Yemek Jetonu"}, 
	["electronickit"]          ={["name"] = "electronickit"            , ["label"] = "Electronic Kit"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Elektronik kit."}, 
	["wetsuit"]          ={["name"] = "wetsuit"            , ["label"] = "Underground Garment"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Yer altı giysisi."},
	["pantinge"]          ={["name"] = "pantinge"            , ["label"] = "Precious Picture"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Değerli Resim"}, 
	["paintingi"]          ={["name"] = "paintingi"            , ["label"] = "Precious Picture"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Değerli Resim"},   
	["paintingh"]          ={["name"] = "paintingh"            , ["label"] = "Precious Picture"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Değerli Resim"},   
	["paintingj"]          ={["name"] = "paintingj"            , ["label"] = "Precious Picture"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Değerli Resim"},   
	["paintingf"]          ={["name"] = "paintingf"            , ["label"] = "Precious Picture"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Değerli Resim"}, 
	["paintingg"]          ={["name"] = "paintingg"            , ["label"] = "Precious Picture"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Değerli Resim"},   
	["gasmask"]          ={["name"] = "gasmask"            , ["label"] = "Gasmask"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Gaz Maskesi"},
	['weedplant_seedm'] 			 = {['name'] = 'weedplant_seedm', 			    ['label'] = 'Male Cannabis Seed', 			['weight'] = 1111, 		['type'] = 'item', 		['image'] = 'weedplant_seed.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Male Weed Seed'},
['weedplant_seedf'] 			 = {['name'] = 'weedplant_seedf', 			    ['label'] = 'Female Marijuana Seed', 		['weight'] = 1111, 		['type'] = 'item', 		['image'] = 'weedplant_seed.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Female Weed Seed'},
['weedplant_branch'] 			 = {['name'] = 'weedplant_branch', 			    ['label'] = 'Cannabis Branch', 				['weight'] = 10000, 	['type'] = 'item', 		['image'] = 'weedplant_branch.png', 	['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Weed plant'},
['weedplant_weed'] 				 = {['name'] = 'weedplant_weed', 			    ['label'] = 'Dry weed', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'weedplant_weed.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Weed ready for packaging'},
['weedplant_packedweed'] 		 = {['name'] = 'weedplant_packedweed', 			['label'] = 'Packed Herb', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weedplant_weed.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Weed ready for sale'},
['weedplant_package'] 			 = {['name'] = 'weedplant_package', 			['label'] = 'Suspicious Package', 		['weight'] = 10000, 	['type'] = 'item', 		['image'] = 'weedplant_package.png', 	['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Suspicious Package'},

	["wet_weed"] 		 	 	 	 = {["name"] = "wet_weed",           			["label"] = "Moist Weed",	 			["weight"] = 3000, 		["type"] = "item", 		["image"] = "wet_weed.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Wet weed that needs to be treated!"},
    ["coke"] 		 	 	 	     = {["name"] = "coke",           				["label"] = "Cocaine", 					["weight"] = 1000,		["type"] = "item", 		["image"] = "coke.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Processed cocaine"},
    ["coca_leaf"] 		 	 	 	 = {["name"] = "coca_leaf",           			["label"] = "Cocaine leaf",	 		["weight"] = 1500,		["type"] = "item", 		["image"] = "coca_leaf.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Cocaine leaves that must be processed !"},
    ["cannabis"] 			 		 = {["name"] = "cannabis", 						["label"] = "Cannabis", 				["weight"] = 2500, 		["type"] = "item", 		["image"] = "cannabis.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Uncured cannabis"},
    ["marijuana"] 			 		 = {["name"] = "marijuana", 					["label"] = "Marijuana", 				["weight"] = 500,		["type"] = "item", 		["image"] = "marijuana.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Some fine smelling buds."},
    ["chemicals"] 		 	 	 	 = {["name"] = "chemicals",           			["label"] = "Chemicals",	 			["weight"] = 1500, 		["type"] = "item", 		["image"] = "chemicals.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care..."},
    ["poppyresin"] 		 	 	 	 = {["name"] = "poppyresin",           			["label"] = "Poppy resin",	 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "poppyresin.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "It sticks to your fingers when you handle it."},
    ["heroin"] 		 	 	 	     = {["name"] = "heroin",           				["label"] = "Heroin",	 				["weight"] = 500, 		["type"] = "item", 		["image"] = "heroin.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Really addictive depressant..."},
    ["lsa"] 		 	 	 	     = {["name"] = "lsa",           				["label"] = "LSA",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "lsa.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Almost ready to party..."},
    ["lsd"] 		 	 	 	     = {["name"] = "lsd",           				["label"] = "LSD",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "lsd.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Lets get this party started!"},
    ["meth"] 		 	 	 	     = {["name"] = "meth",           				["label"] = "Pure Meth",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "meth.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "İşlem görmemiş saf meth."},
	["islenmismeth"] 		 	 	 	     = {["name"] = "islenmismeth",           				["label"] = "Finished Meth",	 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "meth.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "İşlem Görmüş Meth"},
	["poset"] 		 	 	 	     = {["name"] = "poset",           				["label"] = "Carrier bag",	 					["weight"] = 100, 		["type"] = "item", 		["image"] = "poset.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Boş Poşet"},
    ["hydrochloric_acid"] 			 = {["name"] = "hydrochloric_acid", 			["label"] = "Hydrochloric Acid",		["weight"] = 1500, 		["type"] = "item", 		["image"] = "hydrochloric_acid.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["sodium_hydroxide"] 			 = {["name"] = "sodium_hydroxide", 				["label"] = "Sodium Hydroxide", 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "sodium_hydroxide.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["sulfuric_acid"] 		 	 	 = {["name"] = "sulfuric_acid",           		["label"] = "Sulfuric Acid",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "sulfuric_acid.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["thionyl_chloride"] 		 	 = {["name"] = "thionyl_chloride",           	["label"] = "Thionyl Chloride",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "thionyl_chloride.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["liquidmix"] 		 	 	     = {["name"] = "liquidmix",           		    ["label"] = "Liquid Chem Mix",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "liquidmix.png", 		    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["bakingsoda"] 		 	 	     = {["name"] = "bakingsoda",           		    ["label"] = "Baking Soda",	 		    ["weight"] = 1500, 		["type"] = "item", 		["image"] = "bakingsoda.png", 		    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Household Baking Soda!"},
    ["chemicalvapor"] 		 	     = {["name"] = "chemicalvapor",           	    ["label"] = "Chemical Vapors",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "chemicalvapor.png", 	    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "High Pressure Chemical Vapors, Explosive!"},
    ["trimming_scissors"] 		 	 = {["name"] = "trimming_scissors",           	["label"] = "Trimming Scissors",	 	["weight"] = 1500, 		["type"] = "item", 		["image"] = "trimming_scissors.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Very Sharp Trimming Scissors"},
    ['methtray'] 					 = {['name'] = 'methtray', 						['label'] = 'Meth Tray', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'methtray.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'make some meth'},
    ['methkey'] 					 = {['name'] = 'methkey', 						['label'] = 'Meth Lab Key', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'methkey.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with "Walter" Engraved on the Back...'},
    ['cocainekey'] 					 = {['name'] = 'cocainekey', 					['label'] = 'Key B', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'methkey.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with a "Razorblade" Engraved on the Back...'},
    ['weedkey'] 					 = {['name'] = 'weedkey', 						['label'] = 'Key C', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'methkey.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with a "Seed" Engraved on the Back...'},
    ['finescale'] 					 = {['name'] = 'finescale', 					['label'] = 'Fine Scale', 			    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'finescale.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Scale Used for Fine Powders and Materials.'},
    ['coke_small_brick'] 		 	 = {['name'] = 'coke_small_brick', 				['label'] = 'Cocaine Package', 			['weight'] = 350, 		['type'] = 'item', 		['image'] = 'coke_small_brick.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Small package of cocaine, mostly used for deals and takes a lot of space'},
	
	["rentalpapers"]          ={["name"] = "rentalpapers"            , ["label"] = "Rental Certificate"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Araç kiraladığında geri iade edebilmen için verilen belge/ruhsat"},
	
	-- Maske
	-- ["mask"]          ={["name"] = "mask"            , ["label"] = "Maske"               , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask1"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask2"]          ={["name"] = "mask"            , ["label"] = "Maske"              , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask3"]          ={["name"] = "mask"            , ["label"] = "Maske"               , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask4"]          ={["name"] = "mask"            , ["label"] = "Maske"               , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask5"]          ={["name"] = "mask"            , ["label"] = "Maske"               , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask6"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask7"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask8"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask9"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask10"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask11"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask12"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask13"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask14"]          ={["name"] = "mask"            , ["label"] = "Maske"               , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask15"]          ={["name"] = "mask"            , ["label"] = "Maske" "               , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask16"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask17"]          ={["name"] = "mask"            , ["label"] = "Maske"               , ["weight"] =   500 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask18"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask19"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},
	-- ["mask20"]          ={["name"] = "mask"            , ["label"] = "Maske"                , ["weight"] =   500  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Maske"},














	["toka"]          ={["name"] = "toka"            , ["label"] = "Hair clip"               , ["weight"] =   150  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Saçını kolayca bağlayabileceğin bir saç tokası"},
	-- ["bsigara"]          ={["name"] = "bsigara"            , ["label"] = "Sigara Artığı"               , ["weight"] =   30  , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Saçını kolayca bağlayabileceğin bir saç tokası"},
	["key1"]          ={["name"] = "key1"            , ["label"] = "Casino Key"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Casino Anahtarı"},
	["key2"]          ={["name"] = "key2"            , ["label"] = "Casino Key 2"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Casino Anahtarı 2"},              
	["drill"]          ={["name"] = "drill"            , ["label"] = "Big Drill"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Büyük bir matkap tipi."},   
	["grapple"]          ={["name"] = "grapple"            , ["label"] = "Grapple Gun"               , ["weight"] =   50  , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Grapple Gun işte."},       
	['atm'] 					 	 = {['name'] = 'atm', 			 	  	  		['label'] = 'ATM', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'atm.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Visa can be used via ATM'},
	['rope'] 					 	 = {['name'] = 'rope', 			 	  	  		['label'] = 'Rope', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'rope.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Visa can be used via ATM'},
	['mastercard'] 					 = {['name'] = 'mastercard', 					['label'] = 'Master Card', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'mastercard.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'MasterCard can be used via ATM'},
	["fenilendiamin"]={["name"] = "fenilendiamin", ["label"] = "Phenylene Diamine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tereftaloilklorur"]={["name"] = "tereftaloilklorur", ["label"] = "Terephthaloyl Chloride", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["ipek"]={["name"] = "ipek", ["label"] = "Silk", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["pamuk"]={["name"] = "pamuk", ["label"] = "Cotton", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["celikplaka"]={["name"] = "celikplaka", ["label"] = "Steel Plate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["celik"]={["name"] = "celik", ["label"] = "Steel", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["saglamlastirilmiscelik"]={["name"] = "saglamlastirilmiscelik", ["label"] = "Reinforced Steel", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["paslanmazcelik"]={["name"] = "paslanmazcelik", ["label"] = "Stainless steel", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["metalboru"]={["name"] = "metalboru", ["label"] = "Metal Pipe", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["yay"]={["name"] = "yay", ["label"] = "Arrow", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["saglamlastirilmiscelikyay"]={["name"] = "saglamlastirilmiscelikyay", ["label"] = "Reinforced Steel Arrow", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"}, 
	["tetiklemetelefonu"]={["name"] = "tetiklemetelefonu", ["label"] = "Trigger Phone", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},   
	["titanyummatkap"]={["name"] = "titanyummatkap", ["label"] = "Titanium Drill", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},  
	["titanyum"]={["name"] = "titanyum", ["label"] = "Titanium", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["titanyummadeni"]={["name"] = "titanyummadeni", ["label"] = "Titanium Mine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["titanyumyay"]={["name"] = "titanyumyay", ["label"] = "Titanium Arrow", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["titanyumboru"]={["name"] = "titanyumboru", ["label"] = "Titanium Pipe", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["alasimliboru"]={["name"] = "alasimliboru", ["label"] = "Alloy Pipe", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["saglamlastirilmiskalincelikboru"]={["name"] = "saglamlastirilmiskalincelikboru", ["label"] = "Reinforced Thick Steel Pipe", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["celikyay"]={["name"] = "celikyay", ["label"] = "Steel Spring", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["cip"]={["name"] = "cip", ["label"] = "Chip", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["elektronikkart"]={["name"] = "elektronikkart", ["label"] = "Electronic Card", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["hedeflemebilgisayari"]={["name"] = "hedeflemebilgisayari", ["label"] = "Targeting Computer", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["rdx"]={["name"] = "rdx", ["label"] = "RDX", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tnt"]={["name"] = "tnt", ["label"] = "TNT", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kablo"]={["name"] = "kablo", ["label"] = "Cable", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["toryum"]={["name"] = "toryum", ["label"] = "Thorium", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["toryummadeni"]={["name"] = "toryummadeni", ["label"] = "Thorium Mine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["optikdurbun"]={["name"] = "optikdurbun", ["label"] = "Optical Binoculars", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["heavypistolkalip"]={["name"] = "heavypistolkalip", ["label"] = "Heavy Pistol Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["dokumkalip"]={["name"] = "dokumkalip", ["label"] = "Casting Frame", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["racingdongle"]={["name"] = "racingdongle", ["label"] = "Racing Dongle", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["skarpionkalip"]={["name"] = "skarpionkalip", ["label"] = "Skorpion Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["pistol50kalip"]={["name"] = "pistol50kalip", ["label"] = "Pistol 50. Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["appistolkalip"]={["name"] = "appistolkalip", ["label"] = "Ap Pistol Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tec9kalip"]={["name"] = "tec9kalip", ["label"] = "Tec-9 Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["microsmgkalip"]={["name"] = "microsmgkalip", ["label"] = "Micro SMG Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["compactriflekalip"]={["name"] = "compactriflekalip", ["label"] = "Compact Rifle Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["assaultriflekalip"]={["name"] = "assaultriflekalip", ["label"] = "Assault Rifle Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["rpgkalip"]={["name"] = "rpgkalip", ["label"] = "RPG Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["hominglauncherkalip"]={["name"] = "hominglauncherkalip", ["label"] = "Homing Launcher Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["marksmanriflekalip"]={["name"] = "marksmanriflekalip", ["label"] = "Marksman Rifle Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sniperriflekalip"]={["name"] = "sniperriflekalip", ["label"] = "Sniper Rifle Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["doublebarrelkalip"]={["name"] = "doublebarrelkalip", ["label"] = "Double Barrel Body Mold", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sodyumkarbonat"]={["name"] = "sodyumkarbonat", ["label"] = "Sodium Carbonate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kokayapragi"]={["name"] = "kokayapragi", ["label"] = "Coca Leaf", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kerosen"]={["name"] = "kerosen", ["label"] = "Kerosene", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["denatoniumbenzoate"]={["name"] = "denatoniumbenzoate", ["label"] = "Denatonium Benzoate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sulfurikasit"]={["name"] = "sulfurikasit", ["label"] = "Sulfuric acid", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["aseton"]={["name"] = "aseton", ["label"] = "Aseton", ["weight"] =500, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzoccine"]={["name"] = "benzoccine", ["label"] = "Benzoccine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tarcin"]={["name"] = "tarcin", ["label"] = "Cinnamon", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["amonyak"]={["name"] = "amonyak", ["label"] = "Ammonia", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["misketlimon"]={["name"] = "misketlimon", ["label"] = "Lime", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["klor"]={["name"] = "klor", ["label"] = "Chlorine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sodyumbikarbonat"]={["name"] = "sodyumbikarbonat", ["label"] = "Sodium bicarbonate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["imbik"]={["name"] = "imbik", ["label"] = "Retort", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tupfirin"]={["name"] = "tupfirin", ["label"] = "Tube Furnace", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["beher"]={["name"] = "beher", ["label"] = "Each", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["erlen"]={["name"] = "erlen", ["label"] = "Erlen", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["propan"]={["name"] = "propan", ["label"] = "Propane", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["etileter"]={["name"] = "etileter", ["label"] = "Ethyl Ether", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["iyot"]={["name"] = "iyot", ["label"] = "Iodine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["toryumnitrat"]={["name"] = "toryumnitrat", ["label"] = "Thorium Nitrate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["hidrojengazi"]={["name"] = "hidrojengazi", ["label"] = "Hydrogen Gas", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["metilamin"]={["name"] = "metilamin", ["label"] = "Methylamine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["fenilaseton"]={["name"] = "fenilaseton", ["label"] = "Phenylacetone", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["toluene"]={["name"] = "toluene", ["label"] = "Toluene", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kahvefiltresi"]={["name"] = "kahvefiltresi", ["label"] = "Coffee Filter", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["piridin"]={["name"] = "piridin", ["label"] = "Pyridine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["guzelavratotu"]={["name"] = "guzelavratotu", ["label"] = "Belladonna", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["komur"]={["name"] = "komur", ["label"] = "Coal", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["komurmadeni"]={["name"] = "komurmadeni", ["label"] = "Coal mine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["ayirmatupu"]={["name"] = "ayirmatupu", ["label"] = "Separation Tube", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["fenilasetikasit"]={["name"] = "fenilasetikasit", ["label"] = "Phenylacetic Acid", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["asetikanhidrit"]={["name"] = "asetikanhidrit", ["label"] = "Acetic Anhydride", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzilsiyanur"]={["name"] = "benzilsiyanur", ["label"] = "Benzyl Cyanide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzilklorur"]={["name"] = "benzilklorur", ["label"] = "Benzyl Chloride", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["fenilamin"]={["name"] = "fenilamin", ["label"] = "Phenylamine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["et"]={["name"] = "et", ["label"] = "Meat", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["oksijen"]={["name"] = "oksijen", ["label"] = "Oxygen Cylinder", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["deniztuzu"]={["name"] = "deniztuzu", ["label"] = "Sea salt", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzen"]={["name"] = "benzen", ["label"] = "Benzene", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["metilalkol"]={["name"] = "metilalkol", ["label"] = "Methyl alcohol", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["aetilalkol"]={["name"] = "aetilalkol", ["label"] = "Ethyl alcohol", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["komurkatrani"]={["name"] = "komurkatrani", ["label"] = "Coal Tar", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzilalkol"]={["name"] = "benzilalkol", ["label"] = "Benzyl Alcohol", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["karbonmonoksit"]={["name"] = "karbonmonoksit", ["label"] = "carbon monoxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["karbon"]={["name"] = "karbon", ["label"] = "Karbon", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["karbondioksit"]={["name"] = "karbondioksit", ["label"] = "Carbon dioxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["potasyumkarbonat"]={["name"] = "potasyumkarbonat", ["label"] = "Potassium Carbonate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["potasyumasetat"]={["name"] = "potasyumasetat", ["label"] = "Potassium Acetate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["potasyumnitrat"]={["name"] = "potasyumnitrat", ["label"] = "Potassium Nitrate", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["potasyumhidroksit"]={["name"] = "potasyumhidroksit", ["label"] = "Potassium Hydroxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["potasyummadeni"]={["name"] = "potasyummadeni", ["label"] = "Potassium Mine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["potasyum"]={["name"] = "potasyum", ["label"] = "Potassium", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["dikisseti"]={["name"] = "dikisseti", ["label"] = "Sewing kit", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["monazitmadeni"]={["name"] = "monazitmadeni", ["label"] = "Monazite Mine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["nitrikasit"]={["name"] = "nitrikasit", ["label"] = "Nitric acid", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzoilklorur"]={["name"] = "benzoilklorur", ["label"] = "Benzoyl Chloride", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sodyumklorur"]={["name"] = "sodyumklorur", ["label"] = "Sodium chloride", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["asetikasit"]={["name"] = "asetikasit", ["label"] = "Sodium chloride", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kukurtdioksit"]={["name"] = "kukurtdioksit", ["label"] = "Sulfur dioxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kukurttrioksit"]={["name"] = "kukurttrioksit", ["label"] = "Sulfur dioxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kukurt"]={["name"] = "kukurt", ["label"] = "Sulfur", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["vanadyumpentoksit"]={["name"] = "vanadyumpentoksit", ["label"] = "Vanadium Pentoxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["vanadyum"]={["name"] = "vanadyum", ["label"] = "Vanadium", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["fueloil"]={["name"] = "fueloil", ["label"] = "Fuel Oil", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kirectasi"]={["name"] = "kirectasi", ["label"] = "Limestone", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kirec"]={["name"] = "kirec", ["label"] = "Lime", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["denatonyum"]={["name"] = "denatonyum", ["label"] = "Denatonium", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["benzoikasit"]={["name"] = "benzoikasit", ["label"] = "Benzoic Acid", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sodyumhidroksit"]={["name"] = "sodyumhidroksit", ["label"] = "Sodium hydroxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["lidokain"]={["name"] = "lidokain", ["label"] = "Lidocaine", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kalsiyumhidroksit"]={["name"] = "kalsiyumhidroksit", ["label"] = "Calcium Hydroxide", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["heavypistolgovde"]={["name"] = "heavypistolgovde", ["label"] = "Heavy Pistol Body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["pistol50govde"]={["name"] = "pistol50govde", ["label"] = "Desert Eagle body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["appistolgovde"]={["name"] = "appistolgovde", ["label"] = "AP Pistol body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tec9govde"]={["name"] = "tec9govde", ["label"] = "Tec-9 body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["microsmggovdesi"]={["name"] = "microsmggovdesi", ["label"] = "Micro SMG body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["compactriflegovde"]={["name"] = "compactriflegovde", ["label"] = "Compact Rifle body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["assaultriflegovde"]={["name"] = "assaultriflegovde", ["label"] = "Assault Rifle body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["rpggovde"]={["name"] = "rpggovde", ["label"] = "RPG body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["hominglaunchergovde"]={["name"] = "hominglaunchergovde", ["label"] = "Homing Launcher body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["marksmanriflegovde"]={["name"] = "marksmanriflegovde", ["label"] = "Marksman Rifle body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sniperriflegovde"]={["name"] = "sniperriflegovde", ["label"] = "Sniper Rifle body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["doublebarrelgovde"]={["name"] = "doublebarrelgovde", ["label"] = "Double Barrel body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["savedoffgovde"]={["name"] = "savedoffgovde", ["label"] = "Saved Off body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["pumpshotgungovdesi"]={["name"] = "pumpshotgungovdesi", ["label"] = "Pump Shotgun body", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sarapnel"]={["name"] = "sarapnel", ["label"] = "Shrapnel", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["lensoptik"]={["name"] = "lensoptik", ["label"] = "Lens Optics", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["seker"]={["name"] = "seker", ["label"] = "Sugar", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["kagit"]={["name"] = "kagit", ["label"] = "Paper", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["tarti"]={["name"] = "tarti", ["label"] = "Weight", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["ogutucu"]={["name"] = "ogutucu", ["label"] = "Grinder", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},

	["sandalye1"]={["name"] = "sandalye1", ["label"] = "Green Chair", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	["sandalye2"]={["name"] = "sandalye2", ["label"] = "White Chair", ["weight"] =0, ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "SADSAD"},
	-- Regular Fish
	-- Regular Fish
['stingray'] 			     	 = {['name'] = 'stingray', 				    ['label'] = 'Stingray fish',            		['weight'] = 600,      ['type'] = 'item',      ['image'] = 'stingray.png',         	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Stingray'},
['flounder'] 			     	 = {['name'] = 'flounder', 				    ['label'] = 'Flounder',            		['weight'] = 700,      ['type'] = 'item',      ['image'] = 'flounder.png',         	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Flounder'},
['codfish'] 			     	 = {['name'] = 'codfish', 				    ['label'] = 'Cod Fish',            			['weight'] = 900,      ['type'] = 'item',      ['image'] = 'codfish.png',         		['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Cod'},
['mackerel'] 			     	 = {['name'] = 'mackerel', 				    ['label'] = 'Mackerel Fish',            		['weight'] = 500,      ['type'] = 'item',      ['image'] = 'mackerel.png',         	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Mackerel'},
['bass'] 			 		 	 = {['name'] = 'bass', 						['label'] = 'Seabass',                     ['weight'] = 680,      ['type'] = 'item',      ['image'] = 'bass.png',                 ['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'A normal fish Tatses pretty good!'},

-- Trash Items
['fishingtin'] 			 	 	 = {['name'] = 'fishingtin', 				['label'] = 'Rusty Tins', 				['weight'] = 450, 		['type'] = 'item', 		['image'] = 'fishingtin.png', 			['unique'] = false,    ['useable'] = false, 	['shouldClose'] = false,	 ['combinable'] = nil,   ['description'] = 'Fishing Tin'},	
['fishingboot'] 			 	 = {['name'] = 'fishingboot', 				['label'] = 'Mossy Shoes', 			['weight'] = 700, 		['type'] = 'item', 		['image'] = 'fishingboot.png', 			['unique'] = false,    ['useable'] = false, 	['shouldClose'] = false,	 ['combinable'] = nil,   ['description'] = 'Fishing Boot'},	

-- Exotic Fish
['killerwhale'] 			 	 = {['name'] = 'killerwhale', 				['label'] = 'Killer whale', 					['weight'] = 8000, 	['type'] = 'item', 		['image'] = 'killerwhale.png', 			['unique'] = false, 	   ['useable'] = false, 	['shouldClose'] = false,	 ['combinable'] = nil,   ['description'] = 'Killer Whale'},	
['dolphin'] 			     	 = {['name'] = 'dolphin', 					['label'] = 'Dolphin',          		['weight'] = 6500,      ['type'] = 'item',      ['image'] = 'dolphin.png',       		['unique'] = true,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Dolphin'},
['sharktiger'] 			     	 = {['name'] = 'sharktiger', 				['label'] = 'Tiger Shark',          			['weight'] = 6000,      ['type'] = 'item',      ['image'] = 'sharktiger.png',       	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Tigershark'},
['sharkhammer'] 			     = {['name'] = 'sharkhammer', 				['label'] = 'Hammer Shark',         			['weight'] = 4500,      ['type'] = 'item',      ['image'] = 'sharkhammer.png',       	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Hammerhead Shark'},

-- Gear
['fishbait'] 			     	 = {['name'] = 'fishbait', 					['label'] = 'Fish Food', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishbait.png', 			['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Fishing bait'},
['fishingrod'] 			 		 = {['name'] = 'fishingrod', 				['label'] = 'Fishing Rod', 				['weight'] = 750, 		['type'] = 'item', 		['image'] = 'fishingrod.png', 			['unique'] = true,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A fishing rod for adventures with friends!!'},	
['anchor'] 			 	 		 = {['name'] = 'anchor', 					['label'] = 'Boat Anchor', 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'anchor.png', 				['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Boat Anchor'},	
['fishicebox'] 			 	 	 = {['name'] = 'fishicebox', 				['label'] = 'Ice Crate', 		['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishicebox.png', 			['unique'] = true,     ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ice Box to store all of your fish'},	

-- Rewards
['fishingloot'] 			 	 = {['name'] = 'fishingloot', 				['label'] = 'Metal box', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'fishingloot.png', 			['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Seems to be a corroded from the salt water, Should be easy to open'},	
['fishinglootbig'] 			 	 = {['name'] = 'fishinglootbig', 			['label'] = 'Treasure chest', 			['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'fishinglootbig.png', 		['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'The lock seems to be intact, Might need a key'},	
['fishingkey'] 			 	 	 = {['name'] = 'fishingkey', 			    ['label'] = 'Worn Key', 			['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishingkey.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A weathered key that looks usefull'},	
['fishtacklebox'] 			 	 = {['name'] = 'fishtacklebox', 			['label'] = 'Tool Bag', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fishtacklebox.png', 		['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Seems to be left over tackle box from another fisherman'},	
['pearlscard'] 			 	 	 = {['name'] = 'pearlscard', 				['label'] = 'Pearl', 			['weight'] = 100, 		['type'] = 'item', 		['image'] = 'pearlscard.png', 			['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A special member of Pearl\'s Seafood Restaurant'},

	['laptop'] = {['name'] = 'laptop', ['label'] = 'Laptop', ['weight'] = 2000, ['type'] = 'item', ['image'] = 'laptop.png', ['unique'] = true, ['useable'] = true,  ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Günlük bilgisayar ama?'}, 
	['disabler'] = {['name'] = 'disabler', ['label'] = 'Disabler', ['weight'] = 500, ['type'] = 'item', ['image'] = 'tablet.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'for the boosting contracts'},
	["bowlingball"] = {
		["name"] = "bowlingball", 			 	
		["label"] = "Bowling Ball", 	    
		["weight"] = 150, 		
		["type"] = "item", 		
		["expire"] = 999,			
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "What more could a bowling ball be?"
	},
	["beehive"] = {
		["name"] = "beehive", 			 	
		["label"] = "beehive", 	    
		["weight"] = 150, 		
		["type"] = "item", 		
		["expire"] = 999,			
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "What more could a bowling ball be?"
	},
	["queenbee"] = {
		["name"] = "queenbee", 			 	
		["label"] = "queenbee", 	    
		["weight"] = 150, 		
		["type"] = "item", 		
		["expire"] = 999,			
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "What more could a bowling ball be?"
	},
	["honey"] = {
		["name"] = "honey", 			 	
		["label"] = "honey", 	    
		["weight"] = 150, 		
		["type"] = "item", 		
		["expire"] = 999,			
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "What more could a bowling ball be?"
	},
	["honeycomb"] = {
		["name"] = "honeycomb", 			 	
		["label"] = "honeycomb", 	    
		["weight"] = 150, 		
		["type"] = "item", 		
		["expire"] = 999,			
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "What more could a bowling ball be?"
	},
	["bowlingreceipt"] = {
		["name"] = "bowlingreceipt", 			 	
		["label"] = "Bowling Receipt", 	    
		["weight"] = 150, 		
		["type"] = "item", 		
		["expire"] = 999,		    	
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "Ticket for bowling"
	},

	["boombox"] = {
		["name"] = "boombox", 			 	
		["label"] = "Boombox", 	    
		["weight"] = 1500, 		
		["type"] = "item", 		
		["expire"] = 999,		    	
		["unique"] = false,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "instrument that can play songs?"
	},

	["wheelchair"] = {
		["name"] = "wheelchair", 			 	
		["label"] = "Foldable Wheelchair", 	    
		["weight"] = 4000, 		
		["type"] = "item", 		
		["expire"] = 999,		    	
		["unique"] = true,   	
		["useable"] = true, 	
		["shouldClose"] = true,    
		["combinable"] = nil,   
		["description"] = "Foldable Wheelchair"
	},

	["case"] = {
		["name"] = "case", 
		["label"] = "Antique Case", 
		["weight"] =  2500, 
		["type"] = "item", 
		["unique"] = true, 
		["useable"] = true, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Case"
	}, 

	["stone"] = {
		["name"] = "stone", 
		["label"] = "Stone Piece", 
		["weight"] = 1000, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Raw crushed stone pieces"
	},
	["finishedstone"] = {
		["name"] = "finishedstone", 
		["label"] = "Machined Stone Pieces", 
		["weight"] = 2000, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Particles of smelted and processed stone in the mining center"
	},

	["crudemetal"] = {
		["name"] = "crudemetal", 
		["label"] = "Crude Metal", 
		["weight"] =   500, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Raw metal separated from stone chips"
	},  

	["finishedmetal"] = {
		["name"] = "finishedmetal", 
		["label"] = "Machined Metal", 
		["weight"] =  1000, 
		["type"] = "item", 	
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Melted Metal"
	},  

	["crudecopper"] ={
		["name"] = "crudecopper", 
		["label"] = "Raw Copper", 
		["weight"] =   1000, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Raw copper, sorted from stone fragments"
	},  
	
	["finishedcopper"] = {
		["name"] = "finishedcopper", 
		["label"] = "Machined Copper", 
		["weight"] =  1000, 
		["type"] = "item", 	
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Melted Copper"
	},  
	
	["crudeiron"] = {
		["name"] = "crudeiron", 
		["label"] = "Raw Iron", 
		["weight"] =   1000, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Raw iron sorted from stone chips"
	},    

	["finishediron"] = {
		["name"] = "finishediron", 
		["label"] = "Processed Iron", 
		["weight"] =  1000, 
		["type"] = "item", 	
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Molten Iron"
	},  
	
	["crudegold"] = {
		["name"] = "crudegold", 
		["label"] = "Raw Gold", 
		["weight"] =   1000, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "The raw iron, sorted from the pieces of stone"
	},  


	["goldbar"] = {
		["name"] = "goldbar", 
		["label"] = "Gold Bar", 
		["weight"] =   1500, 
		["type"] = "item", 
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "A gold bar with a serial number added after the traded pure gold and a sort of traded gold bar"
	},  

	["finishedgold"] = {
		["name"] = "finishedgold", 
		["label"] = "Wrought Gold", 
		["weight"] =  1000, 
		["type"] = "item", 	
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Melted Gold"
	},  

	["crudediamond"] = {
		["name"] = "crudediamond", 
		["label"] = "Raw Diamond Particles", 
		["weight"] =  1000, 
		["type"] = "item", 	
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Pieces of rough diamonds cut out of stone chips"
	},  

	["finisheddiamond"] = {
		["name"] = "finisheddiamond", 
		["label"] = "Machined Diamond", 
		["weight"] =  1000, 
		["type"] = "item", 	
		["unique"] = false, 
		["useable"] = false, 
		["shouldClose"] = false, 
		["combinable"] = nil, 
		["description"] = "Melted Diamond"
	},  
-- EV Soygun

	
		["stolensafe"] = {
			["name"] = "stolensafe", 
			["label"] = "Stolen Safe", 
			["weight"] =  1000, 
			["type"] = "item", 	
			["unique"] = false, 
			["useable"] = true, 
			["shouldClose"] = false, 
			["combinable"] = nil, 
			["description"] = "Melted Diamond"
		}, 

["stolentv"] = {
	["name"] = "stolentv", 
	["label"] = "Stolen TV", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = false, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
},  

["stolenscope"] = {
	["name"] = "stolenscope", 
	["label"] = "Stolen Telescope", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = false, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
},  

["stolenart"] = {
	["name"] = "stolenart", 
	["label"] = "Stolen Painting", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = false, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
}, 
["kiralikaracsozlesmesi"] = {
	["name"] = "kiralikaracsozlesmesi", 
	["label"] = "Rental Car Agreement", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = true, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
}, 

["beehive"] = {
	["name"] = "beehive", 
	["label"] = "Beehive", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = true, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
}, 
["queenbee"] = {
	["name"] = "queenbee", 
	["label"] = "Queen bee", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = true, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
}, 
["honey"] = {
	["name"] = "honey", 
	["label"] = "Honey", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = true, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
}, 
["honeycomb"] = {
	["name"] = "honeycomb", 
	["label"] = "Honey Comb", 
	["weight"] =  1000, 
	["type"] = "item", 	
	["unique"] = true, 
	["useable"] = true, 
	["shouldClose"] = false, 
	["combinable"] = nil, 
	["description"] = "Melted Diamond"
}, 


--

	["mediumbackpack"]= {["name"] = "mediumbackpack", ["label"] = "Backpack", 		["weight"] = 5000, 		["type"] = "item", 		["image"] = "backpack.png", ["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "Medium Backpack"},
	["bag"]= {["name"] = "bag", ["label"] = "Backpack", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "backpack.png", ["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "Sırt Çantası"},
	["megaphone"]                    = {["name"] = "megaphone",                     ["label"] = "Megaphone",                ["weight"] = 1000,      ["type"] = "item",      ["image"] = "megaphone.png",            ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A nice megaphone"},
	["camera"]                    ={["name"] = "camera"                 , ["label"] = "Camera"                      , ["weight"] =   950 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Fotoğraf Makinası."},
    ["resim"]                    ={["name"] = "resim"                 , ["label"] = "Photograph"                      , ["weight"] =   950 , ["type"] = "item", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Çekilmiş bir adet fotoğraf."},
	["police_stormram"]                    ={["name"] = "police_stormram"                 , ["label"] = "Storm Arm"                      , ["weight"] =   30000 , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Koçun Başı."},
	["guvenlik_karti_a"]         ={["name"] = "guvenlik_karti_a"        , ["label"] = "Security Card A"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_b"]         ={["name"] = "guvenlik_karti_b"        , ["label"] = "Security Card B"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_c"]         ={["name"] = "guvenlik_karti_c"        , ["label"] = "Security Card C"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_d"]         ={["name"] = "guvenlik_karti_d"        , ["label"] = "Security Card D"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_e"]         ={["name"] = "guvenlik_karti_e"        , ["label"] = "Security Card E"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_f"]         ={["name"] = "guvenlik_karti_f"        , ["label"] = "Security Card F"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_g"]         ={["name"] = "guvenlik_karti_g"        , ["label"] = "Security Card G"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},
	["guvenlik_karti_h"]         ={["name"] = "guvenlik_karti_h"        , ["label"] = "Security Card H"               , ["weight"] = 100   , ["type"] = "item", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Güvenlik sistemlerini kontrol edebilen bir kart"},


	["wet_weed"] 		 	 	 	 = {["name"] = "wet_weed",           			["label"] = "Weed Grass",	 			["weight"] = 3000, 		["type"] = "item", 		["image"] = "wet_weed.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Wet weed that needs to be treated!"},
    ["coke"] 		 	 	 	     = {["name"] = "coke",           				["label"] = "Cocaine", 					["weight"] = 1000,		["type"] = "item", 		["image"] = "coke.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Processed cocaine"},
    ["coca_leaf"] 		 	 	 	 = {["name"] = "coca_leaf",           			["label"] = "Cocaine Leaves",	 		["weight"] = 1500,		["type"] = "item", 		["image"] = "coca_leaf.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Cocaine leaves that must be processed !"},
    ["cannabis"] 			 		 = {["name"] = "cannabis", 						["label"] = "Cannabis", 				["weight"] = 2500, 		["type"] = "item", 		["image"] = "cannabis.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Uncured cannabis"},
    ["marijuana"] 			 		 = {["name"] = "marijuana", 					["label"] = "Marijuana", 				["weight"] = 500,		["type"] = "item", 		["image"] = "marijuana.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Some fine smelling buds."},
    ["chemicals"] 		 	 	 	 = {["name"] = "chemicals",           			["label"] = "Chemical Drums",	 			["weight"] = 1500, 		["type"] = "item", 		["image"] = "chemicals.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care..."},
    ["poppyresin"] 		 	 	 	 = {["name"] = "poppyresin",           			["label"] = "Poppy Resin",	 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "poppyresin.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "It sticks to your fingers when you handle it."},
    ["heroin"] 		 	 	 	     = {["name"] = "heroin",           				["label"] = "Heroin",	 				["weight"] = 500, 		["type"] = "item", 		["image"] = "heroin.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Really addictive depressant..."},
    ["lsa"] 		 	 	 	     = {["name"] = "lsa",           				["label"] = "LSA",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "lsa.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Almost ready to party..."},
    ["lsd"] 		 	 	 	     = {["name"] = "lsd",           				["label"] = "LSD",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "lsd.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Lets get this party started!"},
    ["meth"] 		 	 	 	     = {["name"] = "meth",           				["label"] = "Pure Meth",	 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "meth.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Really addictive stimulant..."},
    ["hydrochloric_acid"] 			 = {["name"] = "hydrochloric_acid", 			["label"] = "Hydrochloric acid",		["weight"] = 1500, 		["type"] = "item", 		["image"] = "hydrochloric_acid.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["sodium_hydroxide"] 			 = {["name"] = "sodium_hydroxide", 				["label"] = "Sodium Hydroxide", 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "sodium_hydroxide.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["sulfuric_acid"] 		 	 	 = {["name"] = "sulfuric_acid",           		["label"] = "Sulfuric acid",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "sulfuric_acid.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["thionyl_chloride"] 		 	 = {["name"] = "thionyl_chloride",           	["label"] = "Thionyl Chloride",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "thionyl_chloride.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["liquidmix"] 		 	 	     = {["name"] = "liquidmix",           		    ["label"] = "Liquid Chemical Mixture",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "liquidmix.png", 		    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["bakingsoda"] 		 	 	     = {["name"] = "bakingsoda",           		    ["label"] = "Baking soda (500gr)",	 		    ["weight"] = 500, 		["type"] = "item", 		["image"] = "bakingsoda.png", 		    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Household Baking Soda!"},
    ["chemicalvapor"] 		 	     = {["name"] = "chemicalvapor",           	    ["label"] = "Chemical Composition",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "chemicalvapor.png", 	    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "High Pressure Chemical Vapors, Explosive!"},
    ["trimming_scissors"] 		 	 = {["name"] = "trimming_scissors",           	["label"] = "Trimming Scissors",	 	["weight"] = 1500, 		["type"] = "item", 		["image"] = "trimming_scissors.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Very Sharp Trimming Scissors"},
    ['methtray'] 					 = {['name'] = 'methtray', 						['label'] = 'Tray', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'meth_tray.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'make some meth'},
    ['methkey'] 					 = {['name'] = 'methkey', 						['label'] = 'Key A', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'pkelepceanahtar.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with "Walter" Engraved on the Back...'},
    ['cocainekey'] 					 = {['name'] = 'cocainekey', 					['label'] = 'Key B', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'pkelepceanahtar.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with a "Razorblade" Engraved on the Back...'},
    ['weedkey'] 					 = {['name'] = 'weedkey', 						['label'] = 'Key C', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'pkelepceanahtar.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with a "Seed" Engraved on the Back...'},
    ['finescale'] 					 = {['name'] = 'finescale', 					['label'] = 'Scale', 			    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'finescale.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Scale Used for Fine Powders and Materials.'},
    -- ['coke_small_brick'] 		 	 = {['name'] = 'coke_small_brick', 				['label'] = 'Kokain Paketi', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'coke_small_brick.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Small package of cocaine, mostly used for deals and takes a lot of space'},
	['coke_brick'] 		 	 = {['name'] = 'coke_brick', 				['label'] = 'Wrap Cocaine (500g)', 			['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'coke_brick.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Small package of cocaine, mostly used for deals and takes a lot of space'},


	["thermitec"] = {["name"] = "thermitec", ["label"] = "Thermite", ["weight"] = 1000, ["type"] = "item", ["image"] = "thermitec.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Go Burning"},
	["thermite"] = {["name"] = "thermite", ["label"] = "Thermite Bomb", ["weight"] = 1000, ["type"] = "item", ["image"] = "thermite.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Go Burning"},
}

-- // HASH WEAPON ITEMS, NEED SOMETIMES TO GET INFO FOR CLIENT
QBShared.WeaponsHashtoName = {
	[`weapon_m4`]                   = "weapon_m4",
	[`weapon_glock`]                   = "weapon_glock",
	[`weapon_ltl`]                   = "weapon_ltl",
	[`weapon_taser`]                   = "weapon_taser",
	[`weapon_specialcarbine_mk2`]                   = "weapon_specialcarbine_mk2",
	[`weapon_m14`]                   = "weapon_m14",
	[`weapon_assaultrifle2`]                   = "weapon_assaultrifle2",
	[`weapon_microsmg2`]                   = "weapon_microsmg2",
	[`weapon_microsmg3`]                   = "weapon_microsmg3",
	[`componet_gavel`]                   = "componet_gavel",
	[`weapon_bats`]                   = "weapon_bats",
	[`weapon_katanas`]                   = "weapon_katanas",
	[`weapon_katana`]                   = "weapon_katana",
	[`weapon_nailgun`]                   = "weapon_nailgun",
	[`weapon_sledgeham`]                   = "weapon_sledgeham",
	[`weapon_shiv`]                   = "weapon_shiv",
	[`weapon_dp9`]                   = "weapon_dp9",
	[`weapon_staff`]                   = "weapon_staff",
	[`weapon_sniperrifle2`]                   = "weapon_sniperrifle2",
	[`weapon_dragunov`]                   = "weapon_dragunov",
	[`weapon_mk18b`]                 = "weapon_mk18b",
	[`weapon_unarmed`]               = "weapon_unarmed",
	[`weapon_knife`]                 = "weapon_knife",
	[`weapon_nightstick`]            = "weapon_nightstick",
	[`weapon_hammer`]                = "weapon_hammer",
	[`weapon_bat`]                   = "weapon_bat",
	[`weapon_golfclub`]              = "weapon_golfclub", 
	[`weapon_crowbar`]               = "weapon_crowbar",	
	[`weapon_pistol`]                = "weapon_pistol",
	[`weapon_pistol_mk2`]            = "weapon_pistol_mk2",
	[`weapon_smg_mk2`]            	 = "weapon_smg_mk2",
	[`weapon_combatpistol`]          = "weapon_combatpistol",
	[`weapon_appistol`]              = "weapon_appistol", 
	[`weapon_pistol50`]              = "weapon_pistol50", 
	[`weapon_smg`]                   = "weapon_smg",
	[`weapon_microsmg`]              = "weapon_microsmg",
	[`weapon_assaultsmg`]            = "weapon_assaultsmg", 
	[`weapon_carbinerifle`]          = "weapon_carbinerifle", 
	[`weapon_carbinerifle_mk2`]      = "weapon_carbinerifle_mk2", 
	[`weapon_assaultrifle`]          = "weapon_assaultrifle",
	[`weapon_assaultrifle_mk2`]      = "weapon_assaultrifle_mk2",
	[`weapon_advancedrifle`]         = "weapon_advancedrifle", 	
	[`weapon_mg`]                    = "weapon_mg", 
	[`weapon_combatmg`]              = "weapon_combatmg",
	[`weapon_pumpshotgun`]           = "weapon_pumpshotgun",	
	[`weapon_sawnoffshotgun`]        = "weapon_sawnoffshotgun",
	[`weapon_assaultshotgun`]        = "weapon_assaultshotgun",
	[`weapon_bullpupshotgun`]        = "weapon_bullpupshotgun",
	[`weapon_stungun`]               = "weapon_stungun",
	[`weapon_sniperrifle`]           = "weapon_sniperrifle",
	[`weapon_heavysniper`]           = "weapon_heavysniper",
	[`weapon_grenadelauncher`]       = "weapon_grenadelauncher",
	[`weapon_remotesniper`]          = "weapon_remotesniper",
	[`weapon_grenadelauncher_smoke`] = "weapon_grenadelauncher_smoke",
	[`weapon_rpg`]                   = "weapon_rpg",
	[`weapon_minigun`]               = "weapon_minigun",
	[`weapon_grenade`]               = "weapon_grenade",
	[`weapon_stickybomb`]            = "weapon_stickybomb",
	[`weapon_smokegrenade`]          = "weapon_smokegrenade",
	[`weapon_bzgas`]                 = "weapon_bzgas",
	[`weapon_molotov`]               = "weapon_molotov",
	[`weapon_petrolcan`]             = "weapon_petrolcan",
	[`weapon_fireextinguisher`]      = "weapon_fireextinguisher",
	[`weapon_briefcase`]             = "weapon_briefcase",
	[`weapon_briefcase_02`]          = "weapon_briefcase_02",
	[`weapon_ball`]                  = "weapon_ball",
	[`weapon_flare`]                 = "weapon_flare",
	[`weapon_snspistol`]             = "weapon_snspistol",
	[`weapon_bottle`]                = "weapon_bottle",
	[`weapon_gusenberg`]             = "weapon_gusenberg",
	[`weapon_specialcarbine`]        = "weapon_specialcarbine",
	[`weapon_heavypistol`]           = "weapon_heavypistol",
	[`weapon_bullpuprifle`]          = "weapon_bullpuprifle",
	[`weapon_dagger`]                = "weapon_dagger",
	[`weapon_vintagepistol`]         = "weapon_vintagepistol",
	[`weapon_firework`]              = "weapon_firework",
	[`weapon_heavyshotgun`]          = "weapon_heavyshotgun",
	[`weapon_musket`]                = "weapon_musket",
	[`weapon_marksmanrifle`]         = "weapon_marksmanrifle",
	[`weapon_proxmine`]              = "weapon_proxmine",
	[`weapon_hominglauncher`]        = "weapon_hominglauncher",
	[`weapon_snowball`]              = "weapon_snowball",
	[`weapon_flaregun`]              = "weapon_flaregun",
	[`weapon_garbagebag`]            = "weapon_garbagebag",
	[`weapon_handcuffs`]             = "weapon_handcuffs",
	[`weapon_combatpdw`]             = "weapon_combatpdw",
	[`weapon_marksmanpistol`]        = "weapon_marksmanpistol",
	[`weapon_knuckle`]               = "weapon_knuckle",
	[`weapon_hatchet`]               = "weapon_hatchet",
	[`weapon_railgun`]               = "weapon_railgun",
	[`weapon_machete`]               = "weapon_machete",
	[`weapon_machinepistol`]         = "weapon_machinepistol",
	[`weapon_switchblade`]           = "weapon_switchblade",
	[`weapon_revolver`]              = "weapon_revolver",	
	[`weapon_dbshotgun`]             = "weapon_dbshotgun",
	[`weapon_compactrifle`]          = "weapon_compactrifle",
	[`weapon_autoshotgun`]           = "weapon_autoshotgun",
	[`weapon_battleaxe`]             = "weapon_battleaxe",
	[`weapon_compactlauncher`]       = "weapon_compactlauncher",
	[`weapon_pipebomb`]              = "weapon_pipebomb",	
	[`weapon_minismg`]               = "weapon_minismg",
	[`weapon_wrench`]                = "weapon_wrench",
	[`weapon_poolcue`]               = "weapon_poolcue",
	[`weapon_bread`]                 = "weapon_bread",
}

QBShared.Vehicles = {
	["Bisiklet"] = {
		[`bmx`] = {
			["name"] = "BMX",
			["model"] = "bmx",
			["count"] = 200,
			["price"] = 300,
		},
		[`bimx`] = {
			["name"] = "BIMX",
			["model"] = "bimx",
			["count"] = 200,
			["price"] = 850,
		},
		[`cruiser`] = {
			["name"] = "Cruiser",
			["model"] = "cruiser",
			["count"] = 200,
			["price"] = 250,
		},
		[`fixter`] = {
			["name"] = "Fixter",
			["model"] = "fixter",
			["count"] = 200,
			["price"] = 300,
		},
		[`scorcher`] = {
			["name"] = "Scorcher",
			["model"] = "scorcher",
			["count"] = 200,
			["price"] = 500,
		},
		[`tribike`] = {
			["name"] = "Tribike",
			["model"] = "tribike",
			["count"] = 200,
			["price"] = 700,
		},
		[`tribike2`] = {
			["name"] = "Tribike-2",
			["model"] = "tribike2",
			["count"] = 200,
			["price"] = 700,
		},
		[`tribike3`] = {
			["name"] = "Tribike-3",
			["model"] = "tribike3",
			["count"] = 200,
			["price"] = 700,
		},
	},
	["Compacts"] = {
		[`asbo`] = {
			["name"] = "Asbo",
			["model"] = "asbo",
			["count"] = 10,
			["price"] = 27500,
		},
		[`blista`] = {
			["name"] = "Blista",
			["model"] = "blista",
			["count"] = 10,
			["price"] = 28350,
		},
		[`issi7`] = {
			["name"] = "Issi",
			["model"] = "issi7",
			["count"] = 10,
			["price"] = 60000,
		},
		[`panto`] = {
			["name"] = "Panto",
			["model"] = "panto",
			["count"] = 10,
			["price"] = 25000,
		},
		[`prairie`] = {
			["name"] = "Prairie",
			["model"] = "prairie",
			["count"] = 10,
			["price"] = 35000,
		},
		[`rhapsody`] = {
			["name"] = "Rhapsody",
			["model"] = "rhapsody",
			["count"] = 10,
			["price"] = 22000,
		},
		[`brioso2`] = {
			["name"] = "Brioso",
			["model"] = "brioso2",
			["count"] = 10,
			["price"] = 27500,
		},
	},
	["Coupes"] = {
		[`cogcabrio`] = {
			["name"] = "Cog Cabrio",
			["model"] = "cogcabrio",
			["count"] = 10,
			["price"] = 30000,
		},
		[`exemplar`] = {
			["name"] = "Exemplar",
			["model"] = "exemplar",
			["count"] = 10,
			["price"] = 35000,
		},
		[`f620`] = {
			["name"] = "F620",
			["model"] = "f620",
			["count"] = 10,
			["price"] = 42500,
		},
		[`felon`] = {
			["name"] = "Felon",
			["model"] = "felon",
			["count"] = 10,
			["price"] = 35000,
		},
		[`felon2`] = {
			["name"] = "Felon2",
			["model"] = "felon2",
			["count"] = 10,
			["price"] = 37500,
		},
		[`jackal`] = {
			["name"] = "Jackal",
			["model"] = "jackal",
			["count"] = 10,
			["price"] = 30000,
		},
		[`oracle`] = {
			["name"] = "Oracle",
			["model"] = "oracle",
			["count"] = 10,
			["price"] = 22500,
		},
		[`oracle2`] = {
			["name"] = "Oracle-2",
			["model"] = "oracle2",
			["count"] = 10,
			["price"] = 35000,
		},
		[`sentinel`] = {
			["name"] = "Sentinel",
			["model"] = "sentinel",
			["count"] = 10,
			["price"] = 32500,
		},
		[`sentinel2`] = {
			["name"] = "Sentinel-2",
			["model"] = "sentinel2",
			["count"] = 10,
			["price"] = 32500,
		},
		[`windsor2`] = {
			["name"] = "Windsor-2",
			["model"] = "windsor2",
			["count"] = 10,
			["price"] = 60000,
		},
		[`zion`] = {
			["name"] = "Zion",
			["model"] = "zion",
			["count"] = 10,
			["price"] = 75000,
		},
		[`zion2`] = {
			["name"] = "zion-2",
			["model"] = "zion2",
			["count"] = 10,
			["price"] = 87500,
		},
	},
	["Motorcycles"] = {
		[`blazer`] = {
			["name"] = "Blazer",
			["model"] = "blazer",
			["count"] = 10,
			["price"] = 30000,
		}, 
		[`akuma`] = {
			["name"] = "Akuma",
			["model"] = "akuma",
			["count"] = 10,
			["price"] = 30000,
		},
		[`bagger`] = {
			["name"] = "Bagger",
			["model"] = "bagger",
			["count"] = 10,
			["price"] = 43752,
		},
		[`bati`] = {
			["name"] = "Bati",
			["model"] = "bati",
			["count"] = 10,
			["price"] = 62000,
		},
		[`bf400`] = {
			["name"] = "BF400",
			["model"] = "bf400",
			["count"] = 10,
			["price"] = 34270,
		},
		[`carbonrs`] = {
			["name"] = "CarbonRS",
			["model"] = "carbonrs",
			["count"] = 10,
			["price"] = 57600,
		},
		[`daemon2`] = {
			["name"] = "Daemon",
			["model"] = "daemon2",
			["count"] = 10,
			["price"] = 19500,
		},
		[`diablous`] = {
			["name"] = "Diablous",
			["model"] = "diablous",
			["count"] = 10,
			["price"] = 35700,
		},
		[`double`] = {
			["name"] = "Double",
			["model"] = "double",
			["count"] = 10,
			["price"] = 43600,
		},
		[`esskey`] = {
			["name"] = "Esskey",
			["model"] = "esskey",
			["count"] = 10,
			["price"] = 37700,
		},
		[`faggio`] = {
			["name"] = "Faggio",
			["model"] = "faggio",
			["count"] = 10,
			["price"] = 3610,
		},
		[`faggio2`] = {
			["name"] = "Faggio",
			["model"] = "faggio2",
			["count"] = 10,
			["price"] = 4720,
		},
		[`faggio3`] = {
			["name"] = "Faggio",
			["model"] = "faggio3",
			["count"] = 10,
			["price"] = 5170,
		},
		[`fcr2`] = {
			["name"] = "FCR",
			["model"] = "fcr2",
			["count"] = 10,
			["price"] = 42200,
		},
		[`hakuchou`] = {
			["name"] = "Hakuchou",
			["model"] = "hakuchou",
			["count"] = 10,
			["price"] = 57500,
		},
		[`hakuchou2`] = {
			["name"] = "HakuchouDrag",
			["model"] = "hakuchou2",
			["count"] = 10,
			["price"] = 71260,
		},
		[`hexer`] = {
			["name"] = "Hexer",
			["model"] = "hexer",
			["count"] = 10,
			["price"] = 33300,
		},
		[`lectro`] = {
			["name"] = "Lectro",
			["model"] = "lectro",
			["count"] = 10,
			["price"] = 35500,
		},
		[`nightblade`] = {
			["name"] = "NightBlade",
			["model"] = "nightblade",
			["count"] = 10,
			["price"] = 38200,
		},
		[`pcj`] = {
			["name"] = "PCJ",
			["model"] = "pcj",
			["count"] = 10,
			["price"] = 20060,
		},
		[`ruffian`] = {
			["name"] = "Ruffian",
			["model"] = "ruffian",
			["count"] = 10,
			["price"] = 45000,
		},
		[`sanchez2`] = {
			["name"] = "Sanchez",
			["model"] = "sanchez2",
			["count"] = 10,
			["price"] = 15000,
		},
		[`vader`] = {
			["name"] = "Vader",
			["model"] = "vader",
			["count"] = 10,
			["price"] = 34000,
		},
		[`zombieb`] = {
			["name"] = "ZombieB",
			["model"] = "zombieb",
			["count"] = 10,
			["price"] = 28880,
		},
		[`zombiea`] = {
			["name"] = "ZombieA",
			["model"] = "zombiea",
			["count"] = 10,
			["price"] = 30050,
		},
		[`stryder`] = {
			["name"] = "Stryder",
			["model"] = "stryder",
			["count"] = 10,
			["price"] = 40000,
		},
		[`vindicator`] = {
			["name"] = "Vindicator",
			["model"] = "vindicator",
			["count"] = 10,
			["price"] = 45000,
		},
		[`fcr2`] = {
			["name"] = "FCR",
			["model"] = "fcr2",
			["count"] = 10,
			["price"] = 15000,
		},
	},
	["Muscle"] = {
		[`buccaneer`] = {
			["name"] = "Buccaneer",
			["model"] = "buccaneer",
			["count"] = 10,
			["price"] = 26000,
		},
		[`buccaneer2`] = {
			["name"] = "Buccaneer-2",
			["model"] = "buccaneer2",
			["count"] = 10,
			["price"] = 24000,
		},
		[`blade`] = {
			["name"] = "Blade",
			["model"] = "blade",
			["count"] = 10,
			["price"] = 22500,
		},
		[`chino`] = {
			["name"] = "Chino",
			["model"] = "chino",
			["count"] = 10,
			["price"] = 25000,
		},
		[`chino2`] = {
			["name"] = "Chino-2",
			["model"] = "chino2",
			["count"] = 10,
			["price"] = 27000,
		},
		[`deviant`] = {
			["name"] = "Deviant",
			["model"] = "deviant",
			["count"] = 10,
			["price"] = 63300,
		},
		[`coquette3`] = {
			["name"] = "Coquette-3",
			["model"] = "coquette3",
			["count"] = 10,
			["price"] = 72000,
		},
		[`hustler`] = {
			["name"] = "Hustler",
			["model"] = "hustler",
			["count"] = 10,
			["price"] = 52000,
		},
		[`dominator`] = {
			["name"] = "Dominator",
			["model"] = "dominator",
			["count"] = 10,
			["price"] = 43500,
		},
		[`dominator3`] = {
			["name"] = "Dominator-3",
			["model"] = "dominator3",
			["count"] = 10,
			["price"] = 50070,
		},
		[`dukes`] = {
			["name"] = "Dukes",
			["model"] = "dukes",
			["count"] = 10,
			["price"] = 21823,
		},
		[`faction`] = {
			["name"] = "Faction",
			["model"] = "faction",
			["count"] = 10,
			["price"] = 20500,
		},
		[`gauntlet`] = {
			["name"] = "Gauntlet",
			["model"] = "gauntlet",
			["count"] = 10,
			["price"] = 32500,
		},
		[`impaler`] = {
			["name"] = "Impaler",
			["model"] = "impaler",
			["count"] = 10,
			["price"] = 37500,
		},
		[`nightshade`] = {
			["name"] = "Nightshade-2",
			["model"] = "nightshade",
			["count"] = 10,
			["price"] = 37500,
		},
		[`picador`] = {
			["name"] = "Picador",
			["model"] = "picador",
			["count"] = 10,
			["price"] = 7500,
		},
		[`ruiner`] = {
			["name"] = "Ruiner",
			["model"] = "ruiner",
			["count"] = 10,
			["price"] = 12500,
		},
		[`sabregt2`] = {
			["name"] = "Sabre GT Custom",
			["model"] = "sabregt2",
			["count"] = 10,
			["price"] = 35200,
		},
		[`tampa`] = {
			["name"] = "Tampa",
			["model"] = "tampa",
			["count"] = 10,
			["price"] = 37500,
		},
		[`tulip`] = {
			["name"] = "Tulip",
			["model"] = "tulip",
			["count"] = 10,
			["price"] = 20000,
		},
		[`vamos`] = {
			["name"] = "Vamos",
			["model"] = "vamos",
			["count"] = 10,
			["price"] = 42500,
		},
		[`vigero`] = {
			["name"] = "Vigero",
			["model"] = "vigero",
			["count"] = 10,
			["price"] = 10000,
		},
		[`virgo`] = {
			["name"] = "Virgo",
			["model"] = "virgo",
			["count"] = 10,
			["price"] = 14000,
		},
		[`virgo2`] = {
			["name"] = "Virgo-2",
			["model"] = "virgo2",
			["count"] = 10,
			["price"] = 21267,
		},
		[`yosemite`] = {
			["name"] = "Yosemite",
			["model"] = "yosemite",
			["count"] = 10,
			["price"] = 37532,
		},
	},
	["Off Road"] = {
		[`bfinjection`] = {
			["name"] = "BF Injection",
			["model"] = "bfinjection",
			["count"] = 10,
			["price"] = 7220,
		},
		[`bodhi2`] = {
			["name"] = "Bodhi",
			["model"] = "bodhi2",
			["count"] = 10,
			["price"] = 10000,
		}, 
		[`brawler`] = {
			["name"] = "Brawler",
			["model"] = "brawler",
			["count"] = 10,
			["price"] = 53550,
		}, 
		[`caracara2`] = {
			["name"] = "Cara Cara",
			["model"] = "caracara2",
			["count"] = 10,
			["price"] = 60000,
		}, 
		[`hellion`] = {
			["name"] = "Hellion",
			["model"] = "hellion",
			["count"] = 10,
			["price"] = 47500,
		}, 
		[`kamacho`] = {
			["name"] = "Kamacho",
			["model"] = "kamacho",
			["count"] = 10,
			["price"] = 95020,
		}, 
		[`riata`] = {
			["name"] = "Riata",
			["model"] = "riata",
			["count"] = 10,
			["price"] = 60000,
		}, 
		[`sandking`] = {
			["name"] = "Sandking XL",
			["model"] = "sandking",
			["count"] = 10,
			["price"] = 76600,
		},  
		[`yosemite3`] = {
			["name"] = "Yosemite Custom",
			["model"] = "yosemite3",
			["count"] = 10,
			["price"] = 90000,
		}, 
		[`outlaw`] = {
			["name"] = "Outlaw",
			["model"] = "outlaw",
			["count"] = 10,
			["price"] = 50000,
		}, 
	},
	["Sedans"] = {
		[`asea`] = {
			["name"] = "Asea",
			["model"] = "asea",
			["count"] = 10,
			["price"] = 12000,
		},
		[`asterope`] = {
			["name"] = "Asterope",
			["model"] = "asterope",
			["count"] = 10,
			["price"] = 18329,
		},
		[`cog55`] = {
			["name"] = "Cog55",
			["model"] = "cog55",
			["count"] = 10,
			["price"] = 27500,
		},
		[`fugitive`] = {
			["name"] = "Fugitive",
			["model"] = "fugitive",
			["count"] = 10,
			["price"] = 25000,
		},
		[`glendale`] = {
			["name"] = "Glendale",
			["model"] = "glendale",
			["count"] = 10,
			["price"] = 12500,
		},
		[`intruder`] = {
			["name"] = "Intruder",
			["model"] = "intruder",
			["count"] = 10,
			["price"] = 30000,
		},
		[`premier`] = {
			["name"] = "Premier",
			["model"] = "premier",
			["count"] = 10,
			["price"] = 16652,
		},
		[`primo`] = {
			["name"] = "Primo",
			["model"] = "primo",
			["count"] = 10,
			["price"] = 20000,
		},
		[`primo2`] = {
			["name"] = "Primo-2",
			["model"] = "primo2",
			["count"] = 10,
			["price"] = 25000,
		},
		[`stanier`] = {
			["name"] = "Stanier",
			["model"] = "stanier",
			["count"] = 10,
			["price"] = 17622,
		},
		[`stratum`] = {
			["name"] = "Stratum",
			["model"] = "stratum",
			["count"] = 10,
			["price"] = 37500,
		},
		[`superd`] = {
			["name"] = "Superd",
			["model"] = "superd",
			["count"] = 10,
			["price"] = 55000,
		},
		[`surge`] = {
			["name"] = "Surge",
			["model"] = "surge",
			["count"] = 10,
			["price"] = 15500,
		},
		[`tailgater`] = {
			["name"] = "Tailgater",
			["model"] = "tailgater",
			["count"] = 10,
			["price"] = 48622,
		},
		[`washington`] = {
			["name"] = "Washington",
			["model"] = "washington",
			["count"] = 10,
			["price"] = 26322,
		},
    },
	["Sports"] = {
		[`alpha`] = {
			["name"] = "Alpha",
			["model"] = "alpha",
			["count"] = 10,
			["price"] = 32500,
		},
		[`banshee`] = {
			["name"] = "Banshee",
			["model"] = "banshee",
			["count"] = 10,
			["price"] = 70000,
		},
		[`bestiagts`] = {
			["name"] = "BestiaGTS",
			["model"] = "bestiagts",
			["count"] = 10,
			["price"] = 87770,
		},
		[`buffalo`] = {
			["name"] = "Buffalo",
			["model"] = "buffalo",
			["count"] = 10,
			["price"] = 42500,
		},
		[`carbonizzare`] = {
			["name"] = "Carbonizzare",
			["model"] = "carbonizzare",
			["count"] = 10,
			["price"] = 100000,
		},
		[`comet2`] = {
			["name"] = "Comet-2",
			["model"] = "comet2",
			["count"] = 10,
			["price"] = 162000,
		},
		[`comet3`] = {
			["name"] = "Comet-3",
			["model"] = "comet3",
			["count"] = 10,
			["price"] = 242300,
		},
		[`comet5`] = {
			["name"] = "Comet-5",
			["model"] = "comet5",
			["count"] = 10,
			["price"] = 380000,
		},
		[`coquette`] = {
			["name"] = "Coquette",
			["model"] = "coquette",
			["count"] = 10,
			["price"] = 55500,
		},
		[`drafter`] = {
			["name"] = "Drafter",
			["model"] = "drafter",
			["count"] = 10,
			["price"] = 540000,
		},
		[`elegy`] = {
			["name"] = "Elegy",
			["model"] = "elegy",
			["count"] = 10,
			["price"] = 520000,
		},
		[`elegy2`] = {
			["name"] = "Elegy-2",
			["model"] = "elegy2",
			["count"] = 10,
			["price"] = 35000,
		},
		[`feltzer2`] = {
			["name"] = "Feltzer-2",
			["model"] = "feltzer2",
			["count"] = 10,
			["price"] = 175000,
		},
		[`furoregt`] = {
			["name"] = "FuroreGT",
			["model"] = "furoregt",
			["count"] = 10,
			["price"] = 172000,
		},
		[`futo`] = {
			["name"] = "Futo",
			["model"] = "futo",
			["count"] = 10,
			["price"] = 31000,
		},	
		[`fusilade`] = {
			["name"] = "Fusilade",
			["model"] = "fusilade",
			["count"] = 10,
			["price"] = 38500,
		},
		[`komoda`] = {
			["name"] = "Komoda",
			["model"] = "komoda",
			["count"] = 10,
			["price"] = 382000,
		},
		[`imorgon`] = {
			["name"] = "Imorgon",
			["model"] = "imorgon",
			["count"] = 10,
			["price"] = 268200,
		},
		[`jugular`] = {
			["name"] = "Jugular",
			["model"] = "jugular",
			["count"] = 10,
			["price"] = 458320,
		},
		[`jester`] = {
			["name"] = "Jester",
			["model"] = "jester",
			["count"] = 10,
			["price"] = 257300,
		},
		[`lynx`] = {
			["name"] = "Lynx",
			["model"] = "lynx",
			["count"] = 10,
			["price"] = 210500,
		},
		[`massacro`] = {
			["name"] = "Massacro",
			["model"] = "massacro",
			["count"] = 10,
			["price"] = 204521,
		},
		[`neo`] = {
			["name"] = "Neo",
			["model"] = "neo",
			["count"] = 10,
			["price"] = 312000,
		},
		[`neon`] = {
			["name"] = "Neon",
			["model"] = "neon",
			["count"] = 10,
			["price"] = 356500,
		},
		[`ninef2`] = {
			["name"] = "9F-2",
			["model"] = "ninef2",
			["count"] = 10,
			["price"] = 126600,
		},
		[`paragon`] = {
			["name"] = "Paragon",
			["model"] = "paragon",
			["count"] = 10,
			["price"] = 316000,
		},
		[`pariah`] = {
			["name"] = "Pariah",
			["model"] = "pariah",
			["count"] = 10,
			["price"] = 180000,
		},
		[`penumbra`] = {
			["name"] = "Penumbra",
			["model"] = "penumbra",
			["count"] = 10,
			["price"] = 155500,
		},
		[`raiden`] = {
			["name"] = "Raiden",
			["model"] = "raiden",
			["count"] = 10,
			["price"] = 315721,
		},
		[`rapidgt2`] = {
			["name"] = "RapidGT2",
			["model"] = "rapidgt2",
			["count"] = 10,
			["price"] = 135000,
		},
		[`revolter`] = {
			["name"] = "Revolter",
			["model"] = "revolter",
			["count"] = 10,
			["price"] = 590000,
		},
		[`schafter3`] = {
			["name"] = "Schafter3",
			["model"] = "schafter3",
			["count"] = 10,
			["price"] = 178500,
		},
		[`schlagen`] = {
			["name"] = "Schlagen",
			["model"] = "schlagen",
			["count"] = 10,
			["price"] = 453000,
		},
		[`seven70`] = {
			["name"] = "Seven70",
			["model"] = "seven70",
			["count"] = 10,
			["price"] = 120000,
		},
		[`specter`] = {
			["name"] = "Specter",
			["model"] = "specter",
			["count"] = 10,
			["price"] = 110000,
		},
		[`sugoi`] = {
			["name"] = "Sugoi",
			["model"] = "sugoi",
			["count"] = 10,
			["price"] = 245500,
		},
		[`sultan`] = {
			["name"] = "Sultan",
			["model"] = "sultan",
			["count"] = 10,
			["price"] = 50000,
		},
		[`sultanrs`] = {
			["name"] = "SultanRS",
			["model"] = "sultanrs",
			["count"] = 10,
			["price"] = 260660,
		},
		[`surano`] = {
			["name"] = "Surano",
			["model"] = "surano",
			["count"] = 10,
			["price"] = 140000,
		},
		[`vstr`] = {
			["name"] = "VSTR",
			["model"] = "vstr",
			["count"] = 10,
			["price"] = 232000,
		},
		[`remus`] = {
			["name"] = "Remus",
			["model"] = "remus",
			["count"] = 10,
			["price"] = 102000,
		},
		[`comet6`] = {
			["name"] = "Comet6",
			["model"] = "comet6",
			["count"] = 10,
			["price"] = 520000,
		},
		[`growler`] = {
			["name"] = "Growler",
			["model"] = "growler",
			["count"] = 10,
			["price"] = 570000,
		},
		[`rt3000`] = {
			["name"] = "RT3000",
			["model"] = "rt3000",
			["count"] = 10,
			["price"] = 555000,
		},
		[`buffalo2`] = {
			["name"] = "Buffalo Custom",
			["model"] = "buffalo2",
			["count"] = 10,
			["price"] = 180000,
		},
		[`sultan2`] = {
			["name"] = "Karin Sultan Classic",
			["model"] = "sultan2",
			["count"] = 10,
			["price"] = 260000,
		},
	},
	["Super"] = { 
		[`coquette4`] = {
			["name"] = "coquette4",
			["model"] = "coquette4",
			["count"] = 1,
			["price"] = 650000,
		},
		[`zorrusso`] = {
			["name"] = "zorrusso",
			["model"] = "zorrusso",
			["count"] = 1,
			["price"] = 550000,
		},
		[`visione`] = {
			["name"] = "visione",
			["model"] = "visione",
			["count"] = 1,
			["price"] = 500000,
		},
		[`italirsx`] = {
			["name"] = "italirsx",
			["model"] = "italirsx",
			["count"] = 1,
			["price"] = 695000,
		},
		[`italigtb2`] = {
			["name"] = "italigtb2",
			["model"] = "italigtb2",
			["count"] = 1,
			["price"] = 500000,
		},
		[`pfister811`] = {
			["name"] = "pfister811",
			["model"] = "pfister811",
			["count"] = 1,
			["price"] = 620000,
		},
		[`krieger`] = { 
			["name"] = "krieger",
			["model"] = "krieger",
			["count"] = 1,
			["price"] = 699500,
		},
		[`tempesta`] = {
			["name"] = "tempesta",
			["model"] = "tempesta",
			["count"] = 1,
			["price"] = 625000,
		},
		[`furia`] = {
			["name"] = "furia",
			["model"] = "furia",
			["count"] = 1,
			["price"] = 575000,
		},
		[`adder`] = {
			["name"] = "adder",
			["model"] = "adder",
			["count"] = 1,
			["price"] = 575000,
		},
		[`entityxf`] = {
			["name"] = "entityxf",
			["model"] = "entityxf",
			["count"] = 1,
			["price"] = 515000,
		},
		[`fmj`] = {
			["name"] = "fmj",
			["model"] = "fmj",
			["count"] = 1,
			["price"] = 550000,
		},
		[`nero`] = {
			["name"] = "nero",
			["model"] = "nero",
			["count"] = 1,
			["price"] = 585000,
		},
		[`nero2`] = {
			["name"] = "nero2",
			["model"] = "nero2",
			["count"] = 1,
			["price"] = 615000,
		},
		[`sheava`] = {
			["name"] = "sheava",
			["model"] = "sheava",
			["count"] = 1,
			["price"] = 425000,
		},
		[`xa21`] = {
			["name"] = "xa21",
			["model"] = "xa21",
			["count"] = 1,
			["price"] = 535000,
		},
		[`thrax`] = {
			["name"] = "thrax",
			["model"] = "thrax",
			["count"] = 1,
			["price"] = 725000,
		},
		-- [`comet6`] = {
		-- 	["name"] = "comet6",
		-- 	["model"] = "comet6",
		-- 	["count"] = 1,
		-- 	["price"] = 395000,
		-- },
		[`ignus`] = {
			["name"] = "Ignus",
			["model"] = "ignus",
			["count"] = 1,
			["price"] = 750000,
		},
		[`zeno`] = {
			["name"] = "Zeno",
			["model"] = "zeno",
			["count"] = 1,
			["price"] = 645000,
		},
		-- [`comet7`] = {
		-- 	["name"] = "Comet 7",
		-- 	["model"] = "comet7",
		-- 	["count"] = 1,
		-- 	["price"] = 415000,
		-- },
		[`corsita`] = {
			["name"] = "Corsita",
			["model"] = "Corsita",
			["count"] = 1,
			["price"] = 618000,
		},
		[`torero2`] = {
			["name"] = "Torero GT",
			["model"] = "torero2",
			["count"] = 1,
			["price"] = 547000,
		},
	},
	["Sports Classics"] = {
		[`casco`] = {
			["name"] = "Casco",
			["model"] = "casco",
			["count"] = 10,
			["price"] = 237500,
		},
		[`coquette2`] = {
			["name"] = "Coquette",
			["model"] = "coquette2",
			["count"] = 10,
			["price"] = 232500,
		},
		[`gt500`] = {
			["name"] = "GT500",
			["model"] = "gt500",
			["count"] = 10,
			["price"] = 258000,
		},
		[`infernus2`] = {
			["name"] = "Infernus",
			["model"] = "infernus2",
			["count"] = 10,
			["price"] = 325600,
		},
		[`pigalle`] = {
			["name"] = "Pigalle",
			["model"] = "pigalle",
			["count"] = 10,
			["price"] = 12000,
		},
		[`rapidgt3`] = {
			["name"] = "RapidGT",
			["model"] = "rapidgt3",
			["count"] = 10,
			["price"] = 123500,
		},
		[`turismo2`] = {
			["name"] = "Turismo-2",
			["model"] = "turismo2",
			["count"] = 10,
			["price"] = 375000,
		},
		[`viseris`] = {
			["name"] = "Viseris",
			["model"] = "viseris",
			["count"] = 10,
			["price"] = 165000,
		},
		[`z190`] = {
			["name"] = "Z190",
			["model"] = "z190",
			["count"] = 10,
			["price"] = 202538,
		},
		[`cheburek`] = {
			["name"] = "Cheburek",
			["model"] = "cheburek",
			["count"] = 10,
			["price"] = 12106,
		},
		[`feltzer3`] = {
			["name"] = "Feltzer",
			["model"] = "feltzer3",
			["count"] = 10,
			["price"] = 160000,
		},
	},
	["Suvs"] = {
		[`baller`] = {
			["name"] = "Baller",
			["model"] = "baller",
			["count"] = 10,
			["price"] = 140500,
		}, 
		[`baller3`] = {
			["name"] = "Baller 3",
			["model"] = "baller3",
			["count"] = 10,
			["price"] = 169999,
		}, 
		[`baller4`] = {
			["name"] = "Baller 4",
			["model"] = "baller3",
			["count"] = 10,
			["price"] = 167500,
		}, 
		[`cavalcade`] = {
			["name"] = "Cavalcade",
			["model"] = "cavalcade",
			["count"] = 10,
			["price"] = 132250,
		}, 
		[`granger`] = {
			["name"] = "Granger",
			["model"] = "granger",
			["count"] = 10,
			["price"] = 64450,
		}, 
		[`huntley`] = {
			["name"] = "Huntley",
			["model"] = "huntley",
			["count"] = 10,
			["price"] = 186600,
		}, 
		[`landstalker2`] = {
			["name"] = "LandStalker S",
			["model"] = "landstalker2",
			["count"] = 10,
			["price"] = 260666,
		},  
		[`rocoto`] = {
			["name"] = "Rocoto",
			["model"] = "rocoto",
			["count"] = 10,
			["price"] = 148888,
		}, 
		[`toros`] = {
			["name"] = "Toros",
			["model"] = "toros",
			["count"] = 10,
			["price"] = 325800,
		}, 
		[`xls`] = {
			["name"] = "XLS",
			["model"] = "xls",
			["count"] = 10,
			["price"] = 164440,
		}, 
	},
	["Vans"] = {
		[`minivan2`] = {
			["name"] = "Minivan",
			["model"] = "minivan2",
			["count"] = 10,
			["price"] = 17500,
		},
		[`bison`] = {
			["name"] = "Bison",
			["model"] = "bison",
			["count"] = 10,
			["price"] = 10000,
		},
		[`journey`] = {
			["name"] = "Journey",
			["model"] = "journey",
			["count"] = 10,
			["price"] = 20000,
		},
		[`rumpo3`] = {
			["name"] = "Rumpo 3",
			["model"] = "rumpo3",
			["count"] = 10,
			["price"] = 20000,
		},
		[`youga2`] = {
			["name"] = "Youga 2",
			["model"] = "youga2",
			["count"] = 10,
			["price"] = 20000,
		},
		[`youga3`] = {
			["name"] = "Youga 3",
			["model"] = "youga3",
			["count"] = 10,
			["price"] = 20000,
		},
	}
}

for k, v in pairs(QBShared.Vehicles) do 
	for key, value in pairs(v) do
		value.hash = GetHashKey(value.model)
	end	
end

QBShared.Aircraft = {
	["Helikopter"] = {
		[`buzzard2`] = {
			["name"] = "Buzzard",
			["model"] = "buzzard2",
			["count"] = 1,
			["price"] = 7000000,
		},
		[`volatus`] = {
			["name"] = "Volatus",
			["model"] = "volatus",
			["count"] = 1,
			["price"] = 9000000,
		},
		[`havok`] = {
			["name"] = "Havok",
			["model"] = "havok",
			["count"] = 1,
			["price"] = 5000000,
		},
		[`swift`] = {
			["name"] = "Swift",
			["model"] = "swift",
			["count"] = 1,
			["price"] = 8500000,
		},
		[`frogger`] = {
			["name"] = "Frogger",
			["model"] = "frogger",
			["count"] = 1,
			["price"] = 6000000,
		},
		[`supervolito`] = {
			["name"] = "Super Volito",
			["model"] = "supervolito",
			["count"] = 1,
			["price"] = 7500000,
		},
	},
	["Uçak"] = {
		[`cuban800`] = {
			["name"] = "Cuban 800",
			["model"] = "cuban800",
			["count"] = 1,
			["price"] = 5000000,
		},
		[`dodo`] = {
			["name"] = "Dodo",
			["model"] = "dodo",
			["count"] = 1,
			["price"] = 7500000,
		},
		[`mammatus`] = {
			["name"] = "Mammatus",
			["model"] = "mammatus",
			["count"] = 1,
			["price"] = 6000000,
		},		
		[`duster`] = {
			["name"] = "Duster",
			["model"] = "duster",
			["count"] = 1,
			["price"] = 4500000,
		},
	}
}



--[[ [`asa`] = {

	["name"] = "",

	["model"] = "asa",

	["count"] = 2,

	["price"] = ,

},  ]]

QBShared.Money = {
	["police"] = 0,
	["ambulance"] = 0,
	["mechanic"] = 0,
	["sheriff"] = 0,
	["mechanic_gabz"] = 0,
	["mechanic_bennys"] = 0,
	["mechanic_hayes"] = 0,
	["mechanic_hayes2"] = 0,
	["mcehanic_tunner"] = 0,
	["mechanic_vinewood"] = 0,
	["cardealer"] = 0,
	["mafia"] = 0,
	["news"] = 0,
	["nightclub"] = 0,
	["unicorn"] = 0,
	["bahama"] = 0,
	["teq"] = 0,
	["chicken"] = 0,
	["hotdog"] = 0,
	["burger"] = 0,
	["realestate"] = 0,
	["taco"] = 0,
	["diner"] = 0,
	["popsdiner"] = 0,
	["casinomarket"] = 0,
	["casino"] = 0,
	["balik"] = 0,
	["kahve"] = 0,
	["japon"] = 0,
	["avukat"] = 0,
}

function setJobGradePayment(job, level, money)
	if QBShared.Jobs[job] then
		if QBShared.Jobs[job].grade[level] then
			QBShared.Jobs[job].grade[level].payment = money
		end
	end
end

function setJobMoney(job, money)
	QBShared.Money[job] = money
end

QBShared.Jobs = {
	["unemployed"] = {
		label = "Unemployed",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Unemployed",
				payment = 150,
			},
		}
	},
	["kimyager"] = {
		label = "Chemist",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Chemist",
				payment = 150,
			},
		}
	},
	["news"] = {
		label = "Weazel News",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Intern",
				payment = 150,
			},
			[2] = {
				label = "Worker",
				payment = 200,
			},
			[3] = {
				label = "Boss",
				payment = 250,
				boss = true
			},
		}
	},
	["mafia"] = {
		label = "Private Mafia",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["police"] = {
		label = "Police",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Cadet",
				payment = 150,
			},
			[2] = {
				label = "Officer I",
				payment = 200,
			},
			[3] = {
				label = "Officer II",
				payment = 250,
			},
			[4] = {
				label = "Officer III",
				payment = 300,
			},
			[5] = {
				label = "Senior Officer",
				payment = 350,
			},
			[6] = {
				label = "Corporal",
				payment = 400,
			},
			[7] = {
				label = "Sergeant",
				payment = 650,
			},
			[8] = {
				label = "Lieutenant",
				payment = 850,
				boss = true,
			},
			[9] = {
				label = "Chief",
				payment = 1000,
				boss = true,
			}
		}
	},
	
	["mechanic"] = {
		label = "Mechanic",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Mechanic Worker 1",
				payment = 20,
			},
			[2] = {
				label = "Mechanic Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["mechanic_gabz"] = {
		label = "Ottos Autos",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["mechanic_bennys"] = {
		label = "Bennys Original Motorworks",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 50,
			},
			[2] = {
				label = "Boss",
				payment = 75,
				boss = true
			},
		}
	},
	["mechanic_hayes"] = {
		label = "Hayes Auto Bodyshop",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["mechanic_hayes2"] = {
		label = "Hayes Motorwork Shop",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["mechanic_tunner"] = {
		label = "6STR WorkShop",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["mechanic_ottos"] = {
		label = "Ottos Autos",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["cardealer"] = {
		label = "Gallery",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Gallery Worker 1",
				payment = 20,
			},
			[2] = {
				label = "Gallery Boss",
				payment = 20,
				boss = true
			},
		}
	},
	
	["ambulance"] = {
		label = "Doctor",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Intern Doctor",
				payment = 150,
			},
			[2] = {
				label = "General Practitioner",
				payment = 175,
			},
			[3] = {
				label = "Doctor",
				payment = 200,
			},
			[4] = {
				label = "Expert Doctor",
				payment = 225,
			},
			[5] = {
				label = "Assistant Professor Doctor",
				payment = 250,
			},
			[6] = {
				label = "Assistant Physician",
				payment = 275,
				boss = true
			},
			[7] = {
				label = "Chief Physician",
				payment = 300,
				boss = true
			},
		}
	},
	["hacker"] = {
		label = "Hacker",
		paySafe = false,
		defaultDuty = true,
		grade = {
			[1] = {
				label = "Hacker",
				payment = 20,
			}
		}
	},
	["nightclub"] = {
		label = "Night club",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["unicorn"] = {
		label = "Unicorn",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["bahama"] = {
		label = "Bahama",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["teq"] = {
		label = "Tequi-la-la",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			},
		}
	},
	["taco"] = {
		label = "Taco",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["chicken"] = {
		label = "Chicken Bell",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["burger"] = {
		label = "Burger Shot",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["realestate"] = {
		label = "Estate agent",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["hotdog"] = {
		label = "Chihuahua Hotdogs",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["popsdiner"] = {
		label = "Pops Diner",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["beanmachine"] = {
		label = "Bean Machine",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
	["casino"] = {
		label = "Casino",
		defaultDuty = true,
		paySafe = false,
		grade = {
			[1] = {
				label = "Worker",
				payment = 20,
			},
			[2] = {
				label = "Boss",
				payment = 20,
				boss = true
			}
		}
	},
}

QBShared.StarterItems = {
    ["white_phone"] = {amount = 1, item = "white_phone"},
	["friesxl"] = {amount = 1, item = "friesxl"},
	["atom"] = {amount = 1, item = "atom"},
}