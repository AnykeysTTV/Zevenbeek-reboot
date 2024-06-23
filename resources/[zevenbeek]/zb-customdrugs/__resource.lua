resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    "client/client.lua",
    "config.lua",
}

server_scripts {
    "server/server.lua",
    "config.lua",
}

ui_page {
    "html/index.html"
}

files {
    "html/*.html",
    "html/scripts/*.js",
    "html/styles/*.css",
    "html/images/*.png",
    "html/images/apps/*.png",
    "html/sounds/*.mp3",
    -- Labs
	'shellpropsv7.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'shellpropsv7.ytyp'
