fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    'config.lua',
	'locale.lua',
	'languages/*.lua',
}

client_script {
    'client.lua',
    'warmenu.lua',
}

server_script {
    'server.lua',
}



dependencies {
    'vorp_core',
}
