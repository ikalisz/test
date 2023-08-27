fx_version 'cerulean'
game 'gta5'

lua54 'yes'
author "ELIXIR#5596"

description 'ELIXIRFW!'

server_scripts {
	"config.lua",
	"shared.lua",
	"server/main.lua",
	"server/functions.lua",
	"server/player.lua",
	"server/loops.lua",
	"server/events.lua",
	"server/commands.lua",
	"server/debug.lua",
	'@oxmysql/lib/MySQL.lua',
	'@mysql-async/lib/MySQL.lua',
}

client_scripts {
	"config.lua",
	"shared.lua",
	"client/main.lua",
	"client/entityiter.lua",
	"client/functions.lua",
	"client/loops.lua",
	"client/events.lua",
	"client/debug.lua",
	"client/wrapper.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/mustache.min.js',
	'html/js/wrapper.js',
	'html/js/app.js',
}

shared_scripts {
	'shared/locale.lua',
	'shared/locations.lua',
	'locale/en.lua' -- replace with desired language
}

escrow_ignore {
    'html/*',
    'locale/*',
    'shared/*',
    'config.lua',
    'shared.lua',
}