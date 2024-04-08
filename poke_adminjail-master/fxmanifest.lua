fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_script{ 
    'config.lua',
	'server/main.lua'
}

client_script {
    'config.lua',
	'client/main.lua'
}

shared_scripts {
	'locale.lua',
	'locales/es.lua'
}