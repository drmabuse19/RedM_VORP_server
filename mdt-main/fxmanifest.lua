game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/main.css",
    "ui/styles/police.css",
    "ui/badges/police.png",
    "ui/mugshot.png"
}

server_scripts {
    'sv_mdt.lua',
    'version.lua',
}

shared_scripts {
    'config.lua',
}

client_scripts {
    'config.lua',
    'cl_mdt.lua',
}

version '1.4.2'
