fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
name "hails_guarma"
author "Hailey-Ross"
description "Resource for Traveling to Guarma from Saint Denis"
url "https://github.com/Hailey-Ross/hails_guarma"

server_scripts {
    'server.lua',
    'config.lua'
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
    'config.lua'
}

version '0.1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/Hailey-Ross/hails_guarma'
