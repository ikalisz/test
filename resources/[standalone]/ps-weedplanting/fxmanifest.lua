fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.6'
description 'ps-weedplanting'
author 'edited by ra1der'

shared_scripts {
    'shared/sh_shared.lua',
    'shared/locales.lua',
}

client_scripts{
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'client/cl_planting.lua',
    'client/cl_processing.lua'
} 
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_planting.lua',
    'server/sv_processing.lua'
}

dependencies {
    'PolyZone',
	'qb-target'
}
