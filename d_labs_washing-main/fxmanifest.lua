fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
lua54 'yes'

author 'D-Labs'
version '1.0'
description 'Washing at prop'

escrow_ignore {
	'config.lua',
    'server/open_server.lua'
}

client_script {
    'not.js',
    'client/client.lua'
}

files {'not.js'}

shared_script 'config.lua'

