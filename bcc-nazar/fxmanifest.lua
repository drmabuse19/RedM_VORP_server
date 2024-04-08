fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'Jake2k4'

server_scripts {
    'server.lua',
}

shared_scripts {
    'config.lua',
    'CardConfig.lua',
    'locale.lua',
    'languages/*.lua'
    
}


client_scripts {
    '/client/menusetup.lua',
    '/client/nazarspawn.lua',
    '/client/treasurehunt.lua',
    '/client/cards.lua'
}

version '1.4.2'

dependency {
    'vorp_core',
    'vorp_inventory',
    'vorp_menu',
    'bcc-utils',
    'vorp_inputs'
}
