--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------

fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

description 'Customizable Metabolism for RedM'
author 'DevDokus Github'
version '1.2.0'

client_scripts {
    'Core/Client/meta.lua',
    'Core/Client/hud.lua',
    'config.lua'
}

shared_script 'config.lua'

server_scripts {
    'config.lua',
    'Core/Server/meta.lua',
    'Core/Server/hud.lua',
}

ui_page('Html/index.html')

files({
	"Html/script.js",
	"Html/jquery.min.js",
	"Html/jquery-ui.min.js",
	"Html/styles.css",
	"Html/img/*.svg",
	"Html/img/*.png",
	"Html/index.html",
})
