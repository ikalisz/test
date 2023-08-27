fx_version 'cerulean'
game 'gta5'

description 'qb-core inventory edit by ra1der'

server_scripts {
	"config.lua",
	'@oxmysql/lib/MySQL.lua',
	"server/main.lua",
}

client_scripts {
	"config.lua",
	"client/main.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/font/*.ttf',
	'html/css/*.css',
	'html/js/*.js',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/attachment_images/*.png',
	'html/ammo_images/*.png',
}