fx_version 'cerulean'
game 'gta5'

description 'QB-SmallResources'
version '1.0.0'

shared_script 'config.lua'
server_script 'server/*.lua'
client_script 'client/*.lua'

files {
    'stream/*.ytd',
    'stream/*.yft',
    'stream/*.ycd',
    'stream/*.ytyp',
    'stream/*.ydr',
  }

lua54 'yes'