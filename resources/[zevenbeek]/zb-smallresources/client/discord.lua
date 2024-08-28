Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(1025694772658192404)

		SetDiscordRichPresenceAsset('logo-mk1')

        SetDiscordRichPresenceAssetText('🔗 '.. GetConvar('Discord', 'https://discord.gg/fxuqDutUK5') )

        SetDiscordRichPresenceAssetSmallText('Zevenbeek Rebooted')

		SetDiscordRichPresenceAction(0, "Discord Server", GetConvar('Discord', 'https://discord.gg/fxuqDutUK5') )
		SetDiscordRichPresenceAction(1, "Join Server", "fivem://connect/cfx.re/join/jboypa")
		--SetDiscordRichPresenceAction(1, "Speel mee", "fivem://connect/play.fortisroleplay.nl")

		Citizen.Wait(60000)
    end
end)