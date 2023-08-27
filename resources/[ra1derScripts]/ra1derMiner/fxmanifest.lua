fx_version 'cerulean'
game 'gta5'

description 'mirlex jobs'
version '1.0.0'

client_scripts {"@PolyZone/client.lua", "@PolyZone/BoxZone.lua", "@PolyZone/CircleZone.lua", "client/*.lua", "config.lua"}

server_scripts {
    'server/*.lua'
}

shared_scripts { 
	'config.lua',
}
