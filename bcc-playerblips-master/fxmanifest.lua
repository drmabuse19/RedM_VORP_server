fx_version "adamant"
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'SavSin'
description 'Player Blips'

server_scripts {
    'Config.lua',
    'server/main.lua'
}

client_scripts {
    'Config.lua',
    'client/main.lua'
}

dependencies {
    'vorp_core'
}
