fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'VORP @outsider31000'
description 'A store script for vorp core framework'
repository 'https://github.com/VORPCORE/vorp_stores-lua'
lua54 'yes'


shared_scripts {
    'config.lua',
    'shared/buyitemsCFG.lua',
    'shared/sellitemsCFG.lua',
    'shared/language.lua',
    'images/*.png'
}
client_script 'client/client.lua'

server_script 'server/server.lua'


version '2.1'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_stores-lua'
