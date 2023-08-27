fx_version 'bodacious'
game 'gta5'

description 'MBG ESX Hacker Job'

version '1.0.0'

ui_page 'tracker.html'

client_scripts {
	'client/main.lua',
	'config.lua'
}

server_scripts {
	'server/main.lua',
	'config.lua'
}


exports {
  'isrunning'
}

files {
  'img/phone.png',
  'img/tracker_background.png',
  'img/tracker_bar.png',
  'img/tracker_player.png',
  'img/tracker_target.png',
  'beep.ogg',
  'tracker.html'
}

