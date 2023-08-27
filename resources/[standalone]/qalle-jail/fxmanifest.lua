fx_version 'bodacious'
game 'gta5'
lua54 'yes'

server_scripts {
	"config.lua",
	"server/server.lua"
}

client_scripts {
	'@PolyZone/client.lua',
	"config.lua",
	"client/utils.lua",
	"client/client.lua",
	"client/events.lua",
}