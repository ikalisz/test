fx_version 'cerulean'
game 'gta5'

description 'QB-Multicharacter'
version '1.0.0'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/script.js',
    'html/logo.png',
    'html/images/*.png',
    'addons/peds.meta'
}

data_file 'PED_METADATA_FILE' 'addons/peds.meta'

dependencies {
    'qb-core',
    'qb-spawn'
}
