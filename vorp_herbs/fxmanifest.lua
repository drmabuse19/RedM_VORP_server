fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'VORP @Snapopotamus'
description 'A Pick up Herbs script for vorp core framework'
repository 'https://github.com/VORPCORE/vorp_herbs'

shared_script 'config.lua'
client_script 'client/client.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}

version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_herbs'
