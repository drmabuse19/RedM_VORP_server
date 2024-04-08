fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'Erwin'
game "rdr3"


  files {
   'stream/*.ytyp'

  } 
  
escrow_ignore {
    'stream/*.ydr'   -- Ignore all .ydr
  }
  
  data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'


dependency '/assetpacks'