fx_version 'bodacious'
game 'gta5'


lua54 'yes'
author "ELIXIR#5596"

-- Client Scripts
client_scripts {
	'@PolyZone/client.lua',
	"client/*.lua",
}

server_scripts {
	"config.lua",
	"export.lua",
	"server/*.lua",
}

exports {
    'SendAlert',
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}

escrow_ignore {
    'config.lua',
}