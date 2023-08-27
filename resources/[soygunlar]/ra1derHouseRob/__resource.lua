resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
this_is_a_map 'yes'

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/shellprops.ytyp'

files {	
	'stream/shellprops.ytyp',
	'LockPart1.png',
	'LockPart2.png',
}

dependencies {
	'qb-core'
}