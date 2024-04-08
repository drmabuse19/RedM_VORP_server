
fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}
lua54 "yes"

escrow_ignore {
	'*.lua',
}

shared_scripts {
    'config.lua',
}

client_scripts {
    'client.lua',
}
