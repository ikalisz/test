fx_version 'bodacious'
game 'gta5'

ui_page 'html/index.html'

files {
    'html/index.html',
	'html/js/*.js',
	'html/img/*.png',
	'html/css/*.css',
	'html/css/*.gif',
}

server_scripts {
	'config.lua',
	'server/main.lua',
	'server/sv_devret.lua',
}

client_scripts {
	'config.lua',
	'client/utils.lua',
	'client/main.lua',
	'client/cl_devret.lua'
}

export 'GeneratePlate'
