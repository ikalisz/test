fx_version 'bodacious'
game 'gta5'

client_script "client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

shared_scripts {
    'config.lua'
}

files {
    'ui/app.js',
    'ui/index.html',
	'ui/lspd.png',
	'ui/lssd.png'
}

ui_page {
    'ui/index.html'
}

exports {"isCamOpen"}