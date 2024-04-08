fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


author 'VORP @ASHKAN'
description 'A player Housing script for vorp core framework'
repository 'https://github.com/VORPCORE/vorp_housing-lua'
lua54 'yes'


shared_scripts {
	"config.lua",
	"locale.lua",
	"languages/*.lua"
}
client_script 'client/client.lua'
server_scripts {
   'server/server.lua',
   '@oxmysql/lib/MySQL.lua'
}


version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_housing-lua'
