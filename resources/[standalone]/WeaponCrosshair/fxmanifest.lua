--[[ DUMPED USING FIVEX ]]--
fx_version 'adamant'



game 'gta5'



client_scripts {

	'client.lua',

	'miniresources/*',

}



server_scripts {

	'server.lua'

}



ui_page {

	'crosshair/crosshair.html'

}



files {

  "crosshair/crosshair.html",

  "crosshair/crosshair.css",

  "crosshair/crosshair.js",

}



exports {

	'getOsTime',

	'baseGetPlayers',

	'DrawText3D'

}



server_exports {

	'baseGetPlayers'

}



client_script 'gotten.lua'
--[[ DUMPED USING FIVEX ]]--