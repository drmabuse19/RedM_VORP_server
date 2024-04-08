fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'
author 'BCC @ Bytesizd'

server_scripts {
	'server/main.lua',
    'server/api.lua'
}

client_scripts {
	'client/main.lua',
}

shared_scripts {
	'config.lua'
}

dependency 'vorp_core'

version '2.1.1'