fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author 'Jannings'

server_scripts {
	'server.lua',
	'@oxmysql/lib/MySQL.lua'

}

shared_scripts {
	'config.lua'
}

client_scripts {
	'client.lua'
}


export 'CheckPosseArea'

version '1.1.2'