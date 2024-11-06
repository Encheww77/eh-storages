fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Encheww77'
description 'Storages for QB-Core'
version '1.0'

server_scripts {
	'server/server.lua',
	'@oxmysql/lib/MySQL.lua'
} 

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/client.lua'
}

shared_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@ox_lib/init.lua',
	'@qb-core/shared/locale.lua',
	'locale/en.lua',
	'config.lua'
}

escrow_ignore {
    'config.lua',
    'locale/*.lua',
}