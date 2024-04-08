--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------

fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

description 'Adds usable items in RedM'
author 'DevDokus Github'
version '1.1.0'

client_scripts {
    'Core/client.lua',
    'config.lua'
}

shared_script 'config.lua'

server_scripts {
    'config.lua',
    'Core/server.lua',
}
