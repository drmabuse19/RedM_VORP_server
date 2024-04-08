game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'VORP @Emolitt'
description 'Mailbox for VORP Core Framework'

client_scripts {
  'client/*.lua'
}

server_scripts {
  'server/*.lua'
}

shared_scripts {
  'locale.lua',
  'config.lua',
  'languages/*.lua',

}

ui_page "html/index.html"

files {
  "html/index.html",
  "html/styles.css",
  "html/reset.css",
  "html/jquery.min.js",
  "html/listener.js"
}


--dont touch
version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_mailbox'
