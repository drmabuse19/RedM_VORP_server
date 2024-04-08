game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'not.js',
    'client.lua'
}

shared_scripts {
    'config.lua'
}

files {'not.js'}

server_scripts {
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
}