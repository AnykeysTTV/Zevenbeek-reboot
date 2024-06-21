resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description 'Fortis Smallresources'

server_scripts {
	"server/main.lua",
	"server/trunk.lua",
	"server/consumables.lua",
	"server/hostage.lua",
	"server/wapencheck.lua",
	"server/rockstarEditor.lua",
	"server/api.lua",
	"server/repaira.lua",
	"server/bandensteek.lua",
	"config.lua",
}

client_scripts {
	"@zb-main/shared.lua",
	"client/main.lua", -- Altijd laten staan, nooit aanzitten, geen volgorde veradneren, ik maak je dood.
	"config.lua",
	"client/binoculars.lua",
	"client/ignore.lua",
	"client/density.lua",
	"client/hostage.lua",
	"client/weapdraw.lua",
	"client/hudcomponents.lua",
	"client/seatbelt.lua",
	"client/cruise.lua",
	"client/recoil.lua",
	"client/crouchprone.lua",
	"client/tackle.lua",
	"client/consumables.lua",
	"client/discord.lua",
	"client/point.lua",
	'client/engine.lua',
	"client/calmai.lua",
	"client/teleports.lua",
	"client/nos.lua",
	"client/hostage.lua",
	"client/scaleform.lua",
	"client/watermark.lua",
	"client/handsup.lua",
	"client/vehiclepush.lua",
	"client/anker.lua",
	"client/wapencheck.lua",
	"client/rockstarEditor.lua",
	"client/rolstoel.lua",
	"client/geenHPbar.lua",
	"client/schild.lua",
	"client/repaira.lua",
	"client/me.lua",
	"client/bandensteek.lua",
}

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'

files {
	'events.meta',
	'popgroups.ymt',
	'relationships.dat',
}

server_export {
    'getAutoDrift'
}

client_script '@zb-guard/03923.lua'