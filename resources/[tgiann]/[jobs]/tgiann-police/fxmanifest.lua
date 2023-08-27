fx_version 'bodacious'
game 'gta5'

server_scripts {
	'config.lua',
	'server/main.lua',
	'server/spike.lua',
	'server/gsr.lua',
	'server/heli.lua',
	'server/obje.lua',
	'server/chatalert.lua',
}

-- client_scripts {
-- 	'config.lua',
-- 	'client/main.lua',
-- 	'client/spike.lua',
-- 	'client/tezer.lua',
-- 	'client/gsr.lua',
-- 	'client/heli.lua',
-- 	'client/obje.lua',
-- 	'client/chatalert.lua',
-- 	"@PolyZone/client.lua",
-- 	"@PolyZone/BoxZone.lua", 
-- 	"@PolyZone/CircleZone.lua",
-- }



client_scripts {"@PolyZone/client.lua", "@PolyZone/BoxZone.lua", "@PolyZone/CircleZone.lua", "client/*.lua", "config.lua"}

files {'ui/custom_ui.html', 'ui/ui.css', 'ui/noise.png'}

ui_page 'ui/custom_ui.html'