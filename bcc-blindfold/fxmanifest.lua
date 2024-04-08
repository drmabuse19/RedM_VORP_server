fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'

author 'Bytesizd'
description 'A blindfold script for RedM and VorpCore Framework'

server_script {
    'server/server.lua'
}

client_script {
    'client/client.lua',
    'client/utils.lua'
}

shared_script {
    'config.lua'
}

ui_page 'ui/index.html'

files {
    'ui/**/*'
}

version '1.0.1'
