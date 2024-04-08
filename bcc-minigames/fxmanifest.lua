game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author "BCC @Bytesizd"

client_scripts {
    'client/main.lua',
    'client/api.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page {
    "ui/index.html"
}

files {
    "ui/index.html",
    "ui/js/*.*",
    "ui/css/*.*",
    "ui/fonts/*.*",
    "ui/img/*.*",
    "ui/media/*.*"
}

export "initiate"

version '1.0.6'
