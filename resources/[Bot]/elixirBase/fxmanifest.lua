fx_version 'bodacious'
game 'gta5'

server_script {		-- Server Scripts		
	"config.lua",
	"server/main.lua",
	"shared/whitelist.lua",
	'@oxmysql/lib/MySQL.lua'
}

client_script {						-- Client Scripts
	"config.lua",
	"client/weapons.lua",
	"client/main.lua",
	"shared/whitelist.lua",
}