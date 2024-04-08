fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
  'client/warmenu.lua',
  'client/main.lua',
  'client/boss.lua',
}

server_scripts {
  'server/main.lua',
}

shared_scripts {
  'utils/locale.lua',
  'utils/utils.lua',
  'config.lua',
  'locales/*.lua',
}

files {
  'ui/hud.html',
  'ui/css/style.css',
  'ui/fonts/rdrlino-regular-webfont.woff'
}

ui_page 'ui/hud.html'

dependencies {
  'vorp_core',
}