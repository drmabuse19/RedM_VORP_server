fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

shared_scripts {
  'configs/config.lua',
  'configs/stations.lua',
  'configs/trains.lua',
  'locale.lua',
  'languages/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  '/server/server.lua',
  '/server/exports.lua'
}

client_scripts {
  '/client/functions.lua',
  '/client/client.lua',
  '/client/menuSetup.lua',
  '/client/missions.lua'
}

ui_page {
  'ui/index.html'
}

files {
  'imgs/trainImg.png',
  'ui/index.html',
  'ui/js/*.*',
  'ui/css/*.*',
  'ui/fonts/*.*',
}

version '1.1.5'
