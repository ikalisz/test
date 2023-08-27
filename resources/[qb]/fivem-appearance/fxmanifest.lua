fx_version "cerulean"
game { "gta5" }

author 'snakewiz'
description 'A flexible player customization script for FiveM.'
repository 'https://github.com/pedr0fontoura/fivem-appearance'
version '1.2.2'

client_scripts {
  'game/dist/index.js',
  'blips.lua',
  'client.lua',
}

server_scripts {
  'server.lua',
	'@oxmysql/lib/MySQL.lua',
  '@mysql-async/lib/MySQL.lua',
}

shared_scripts {
  'config.lua'
}

files {
  'web/dist/index.html',
  'web/dist/assets/*.js',
  'locales/*.json',
  'peds.json',
  'tattoos.json',
  'blacklist.json',
}

ui_page 'web/dist/index.html'