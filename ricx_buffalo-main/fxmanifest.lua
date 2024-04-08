
fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}
lua54 "yes"

escrow_ignore {
	'*.lua', 
}
client_scripts {
    'config.lua',
    'client.lua'
}


server_scripts {
    'server.lua',
}