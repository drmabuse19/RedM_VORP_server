fx_version 'cerulean'
lua54 'yes'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'MasNana'
description 'Hunting Wagon Script'
repository 'https://github.com/masnana/mas_huntingwagon'
version '1.0.0'

dependencies {
    'ox_lib',
    'uiprompt'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_script 'server.lua'
client_scripts {
    '@uiprompt/uiprompt.lua',
    'client.lua'
}
