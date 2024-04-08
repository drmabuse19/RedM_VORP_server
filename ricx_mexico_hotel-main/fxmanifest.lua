fx_version "cerulean"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
lua54 "yes"
this_is_a_map "yes"

escrow_ignore {
	'*.lua', 
}

files {
	"stream/*.ymap",
}
  
shared_scripts {
	"config.lua"
}

client_scripts {
	"client.lua",
}

server_scripts {
	"server.lua",
}
