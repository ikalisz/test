fx_version 'cerulean'
game 'gta5'

ui_page 'ui/main.html'

files {
    'ui/main.html',
    'ui/js/*.js',
    'ui/css/*.css',
}

client_scripts {
    "client/main.lua"
}

server_scripts {
    "server.lua",
}
