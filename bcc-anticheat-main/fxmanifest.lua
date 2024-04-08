fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'
author 'Bytesizd'

client_scripts {
    'client/client.lua',
    'client/injectors.lua',
    'client/mouse.lua',
    'client/net.lua',
    'client/afk.lua',
    'client/speed.lua',
    'client/online.lua',
    'client/resourcestop.lua',
    'client/commands.lua',
    'client/keys.lua',
    'client/texture.lua'
}

server_scripts {
    'server/server.lua',
    'server/discord.lua',
    'server/net.lua',
    'server/xss.lua',
    'server/db.lua',
    'server/injectors.lua',
    'server/versioner.lua',
    'server/afk.lua',
    'server/speed.lua',
    'server/online.lua',
    'server/antifx.lua'
}

shared_scripts {
    'config.lua',
    'shared/api/profanity.js',
    'shared/api/strings.lua'
}

version '1.3.1'
