fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'Silonugget'

lua54 'yes'



client_scripts {
    'client.lua',
    
}


shared_scripts {
    'config.lua',
}

files{
    'stream/*.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/model_t_ytyp'


