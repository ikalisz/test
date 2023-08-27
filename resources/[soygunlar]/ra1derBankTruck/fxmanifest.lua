fx_version 'cerulean'

game 'gta5'
lua54 'yes'

author 'ra1der#0710'

description 'banktruck'

version '1.2'

client_scripts {
    'client/cl_*.lua',
}

shared_script {
    'shared/sh_*.lua',
}

server_scripts {
    'server/sv_*.lua',
}

exports{
    "bankTruck",
    "aracsoygun"
}