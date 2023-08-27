fx_version 'bodacious'
game 'gta5'

shared_script {
	'cfg.lua'
}

client_script {
	'client.lua'
}

server_script {
	'@oxmysql/lib/MySQL.lua', -- REMOVE THE -- IN FRONT OF '@oxmysql/lib/MySQL.lua' THIS IF YOU RUN OXMYSQL
	'server.lua'
}