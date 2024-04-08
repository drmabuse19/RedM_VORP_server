game 'rdr3'
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

shared_scripts {
    'config.lua',
    'shared/data/*.lua',
    'shared/helpers/*.lua',
    'shared/services/*.lua',
    'shared/main.lua'
}

server_scripts {
    'server/helpers/*.lua',
    'server/services/*.lua',
    'server/main.lua'
}

client_scripts {
    'client/services/*.lua',
    'client/main.lua'
}

files {
    'ui/*',
    'ui/vendor/*',
    'ui/vendor/vue-youtube/*',
}

ui_page 'ui/index.html'

version '1.0.7'
