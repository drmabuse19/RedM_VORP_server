fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'
author 'BCC @Apollyon'

shared_scripts {
    'config/*.lua',
    'locale.lua',
    'languages/*.lua'
}

client_scripts {
    'client/main.lua',
    'client/dataview.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/versioncheck.lua',
    'server/main.lua'
}

ui_page {
    'ui/index.html'
}

files {
    "ui/index.html",
    "ui/js/*.*",
    "ui/css/*.*",
    "ui/fonts/*.*",
    "ui/img/*.*"
}

version '1.4.1'

