game 'rdr3'
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'BCC @Jake2k4'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

shared_scripts {
    'shared/translation.lua',
    'config.lua'
}

client_scripts {
    'client/MainPedSpawns.lua',
    'client/OilMissions.lua',
    'client/SupplyMissions.lua',
    'client/MainWagonSpawn.lua',
    'client/MenuSetups.lua',
    'client/CriminalMissionsSetup.lua',
    'client/functions.lua'
}

files {
    'ui/index.html',
    'ui/app.js',
    'ui/style.css',
    'ui/assets/menu_background.png',
    'ui/assets/RDRLino-Regular.ttf',
    'ui/vendor/vue.js'
}

ui_page 'ui/index.html'

version '1.2.3'

dependencies {
    'vorp_core',
    'vorp_inventory',
    'vorp_utils',
    'bcc-utils',
    'bcc-minigames',
    'vorp_progressbar'
}
