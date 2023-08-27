fx_version 'bodacious'
game 'gta5'

lua54 'yes'
author "ELIXIR#5596"

ui_page 'ui/index.html'

files {
	'ui/main.css',
	'ui/main.js',
	'ui/index.html',
	-- 'data/weapons.meta',	
	-- 'data/weaponheavypistol.meta',
	-- 'data/weapons_pistol_mk2.meta',	
	-- 'data/weapons_smg_mk2.meta',
	-- 'data/weapons_carbinerifle_mk2.meta',
	-- 'data/weapons_assaultrifle_mk2.meta',
	'data/weaponsnowball.meta',
	'data/events.meta',
	'data/relationships.dat'
}

-- data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons.meta'
-- data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponheavypistol.meta'
-- data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_pistol_mk2.meta'
-- data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_smg_mk2.meta'
-- data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_carbinerifle_mk2.meta'
-- data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_assaultrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponsnowball.meta'

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'data/events.meta'

-- Client Scripts
client_scripts {
	'@PolyZone/client.lua',
	"client/client.lua",
	"client/vergi.lua",
	"client/aracisim.lua",
	"client/arackoltuk.lua",
	"client/weapdraw.lua",
	"client/ped.lua",
	-- "client/vehiclesync.lua",
	"client/fingerpoint.lua",
	"client/weapons.lua",
	"client/disableScenario.lua",
	"client/notif.lua",
	"client/secure.lua",
	"client/aracspawn.lua",
	"config.lua",
	"export.lua"
}

server_scripts {
	"config.lua",
	"export.lua",
	"server/secure.lua",
	"server/server.lua",
}

exports {'GetSecureStatus'}

escrow_ignore {
    'ui/*',
    'data/*',
    'config.lua',
}