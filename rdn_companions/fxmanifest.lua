
fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {"rdr3"}


ConvarFramework = "vorp" --IMPORTANT: Put either "redem" or "vorp" depending on your framework


client_scripts {
    'client/warmenu.lua',
    'client/client.lua',
    'config.lua'
}


shared_scripts {
    'config.lua',
	'locale.lua',
	'locales/es.lua',
	'locales/en.lua',
}


if ConvarFramework == "redem" then
	server_scripts {
		'@mysql-async/lib/MySQL.lua',
	}
end

server_scripts {

    'config.lua',
    'server/server.lua',
}
