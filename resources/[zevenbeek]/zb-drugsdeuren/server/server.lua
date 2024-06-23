QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Geef bricks als missie wordt gestart
RegisterServerEvent("zb-drugsdeuren:server:geefBricks")
AddEventHandler("zb-drugsdeuren:server:geefBricks", function(missieBrickAmount)
    local Player = QBCore.Functions.GetPlayer(source)
    local missieBrickAmount = missieBrickAmount
    Player.Functions.AddItem("weed_brick", missieBrickAmount)
end)

-- Check hoeveel bricks de player heeft als hij het aflevert
QBCore.Functions.CreateCallback("zb-drugsdeuren:server:requestBrickAantal", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("weed_brick") ~= nil then
        local aantal = Player.Functions.GetItemByName("weed_brick").amount
        cb(aantal)
    else
        -- Persoon heeft geen weed bricks in zn inventory
        cb(0)
    end
end)

-- Afleveren
RegisterServerEvent("zb-drugsdeuren:server:missieAfleveren")
AddEventHandler("zb-drugsdeuren:server:missieAfleveren", function(aantal)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.GetItemByName("weed_brick") ~= nil and Player.Functions.GetItemByName("weed_brick").amount >= aantal then
        Player.Functions.RemoveItem("weed_brick", aantal)
        local wout = GetCurrentCops()
        local prijs = 50
        if wout == 1 then
            prijs = math.random(250, 500)
        elseif wout == 2 then
            prijs = math.random(500, 600)
        elseif wout >= 3 then
            prijs = math.random(750,1000)
        end

        -- Betaal de speler
        Player.Functions.AddMoney("cash", (aantal * prijs), "drugs-aflevering")
    end
end)

-- Haal het aantal wout agenten op
function GetCurrentCops()
    local wout = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                wout = wout + 1
            end
        end
    end
    return wout
end

RegisterNetEvent('qb-anticheat:server:GetLocations')
AddEventHandler("qb-anticheat:server:GetLocations", function() 

Config.DeurLocaties['deuren'] = {}
Config.DeurLocaties["producten"] = {}
Config.DeurLocaties["missies"] = {}

--DEALERS
table.insert(Config.DeurLocaties['deuren'], {
    ["naam"] = "Ferry",
    ["coords"] = {
        ["x"] = -428.70,
        ["y"] = 294.07,
        ["z"] = 83.23,
    },
    ["tijd"] = {
        ["min"] = 1,
        ["max"] = 7,
    },
})

-- PRODUCTEN
table.insert(Config.DeurLocaties['producten'], {
                 {
                    name = "weed_white-widow_seed",
                    price = 100,
                    amount = 100,
                    info = {},
                    type = "item",
                    slot = 1,
                    minrep = 0,
                }
})

-- MISSIES
table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
                    ["coords"] = {
                        ["x"] = -38.132381439209,
                        ["y"] = -59.595706939697,
                        ["z"] = 64.057685852051,
                    }
   },
})

table.insert(Config.DeurLocaties['missies'], {
    {
             ["naam"] = "Locatie",
                ["coords"] = {
                    ["x"] = -1490.6888427734,
                    ["y"] = -658.32989501953,
                    ["z"] = 29.025077819824,
                }
   },
})
table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
                ["coords"] = {
                    ["x"] = -703.07153320312,
                    ["y"] = -1179.5406494141,
                    ["z"] = 10.609411239624,
                }
   },
})
table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
                ["coords"] = {
                    ["x"] = -1430.6611328125,
                    ["y"] = -885.15454101562,
                    ["z"] = 10.934238433838,
                },
   },
})

table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
        ["coords"] = {
            ["x"] = -1673.0821533203,
            ["y"] = 385.91482543945,
            ["z"] = 89.348289489746,
        }
   },
})
table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
        ["coords"] = {
            ["x"] = 252.26,
            ["y"] = 358.14,
            ["z"] = 105.55,
        },
   },
})
table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
        ["coords"] = {
            ["x"] = 151.44,
            ["y"] = -72.73,
            ["z"] = 67.67,
        },
   },
})
  
table.insert(Config.DeurLocaties['missies'], {
    {
        ["naam"] = "Locatie",
                ["coords"] = {
                    ["x"] = 16.61,
                    ["y"] = -1443.83,
                    ["z"] = 30.95,
                },
   },
})
table.insert(Config.DeurLocaties['missies'], {
    {
     
        ["naam"] = "Locatie",
        ["coords"] = {
            ["x"] = -141.83,
            ["y"] = -1697.44,
            ["z"] = 30.77,
        },
   },
})       
table.insert(Config.DeurLocaties['missies'], {
    {
     
        ["naam"] = "Locatie",
        ["coords"] = {
            ["x"] = 39.04,
            ["y"] = -1911.42,
            ["z"] = 21.95,
        },
   },
})  table.insert(Config.DeurLocaties['missies'], {
    {
     
      
        ["naam"] = "Locatie",
        ["coords"] = {
            ["x"] = 474.53,
            ["y"] = -1757.62,
            ["z"] = 29.09,
        }
   },
})  
        
TriggerClientEvent('qb-anticheat:client:GetLocations', source, Config.DeurLocaties)



              
           
              
          
           
               
        

              
            

            

           


--     cb({["deuren"] = {
--         [1] = {
--                     ["naam"] = "Ferry",
--                     ["coords"] = {
--                         ["x"] = -428.70,
--                         ["y"] = 294.07,
--                         ["z"] = 83.23,
--                     },
--                     ["tijd"] = {
--                         ["min"] = 1,
--                         ["max"] = 7,
--                     },
--                 },
--             })
--         --x = -428.70, y = 294.07, z = 83.23, h = 262.14
--     --     [1] = {
--     --         ["naam"] = "Ferry",
--     --         ["coords"] = {
--     --             ["x"] = 1165.281494140625,
--     --             ["y"] = -1347.2432861328126,
--     --             ["z"] = 36.184059143066409,
--     --         },
--     --         ["tijd"] = {
--     --             ["min"] = 1,
--     --             ["max"] = 7,
--     --         },
--     --     },
--     --     [2] = {
--     --         ["naam"] = "Muis",
--     --         ["coords"] = {
--     --             ["x"] = -56.86803436279297,
--     --             ["y"] = -2448.41845703125,
--     --             ["z"] = 7.235764980316162,
--     --         },
--     --         ["tijd"] = {
--     --             ["min"] = 15,
--     --             ["max"] = 23,
--     --         },
--     --     },
--     --     [3] = {
--     --         ["naam"] = "Mustafa",
--     --         ["coords"] = {
--     --             ["x"] = -1120.8282470703126,
--     --             ["y"] = 2712.369873046875,
--     --             ["z"] = 18.86776351928711,
--     --         },
--     --         ["tijd"] = {
--     --             ["min"] = 1,
--     --             ["max"] = 7,
--     --         },
--     --     },
--     --     [4] = {
--     --         ["naam"] = "Schut",
--     --         ["coords"] = {
--     --             ["x"] = -86.583084106445,
--     --             ["y"] = 389.87582397461,
--     --             ["z"] = 112.43014526367,
--     --         },
--     --         ["tijd"] = {
--     --             ["min"] = 7,
--     --             ["max"] = 15,
--     --         },
--     --     },
--     -- },
--     -- Producten
--     ["producten"] = {
--         [1] = {
--             name = "weed_white-widow_seed",
--             price = 100,
--             amount = 100,
--             info = {},
--             type = "item",
--             slot = 1,
--             minrep = 0,
--         },
--         [2] = {
--             name = "weed_skunk_seed",
--             price = 100,
--             amount = 100,
--             info = {},
--             type = "item",
--             slot = 2,
--             minrep = 0,
--         },
--         [3] = {
--             name = "weed_purple-haze_seed",
--             price = 100,
--             amount = 100,
--             info = {},
--             type = "item",
--             slot = 3,
--             minrep = 0,
--         },
--         [4] = {
--             name = "weed_og-kush_seed",
--             price = 100,
--             amount = 100,
--             info = {},
--             type = "item",
--             slot = 4,
--             minrep = 0,
--         },
--         [5] = {
--             name = "weed_amnesia_seed",
--             price = 100,
--             amount = 100,
--             info = {},
--             type = "item",
--             slot = 5,
--             minrep = 0,
--         },
--     },
--     -- Missie aflever locaties
--     ["missies"] = {
--         [1] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = -38.132381439209,
--                 ["y"] = -59.595706939697,
--                 ["z"] = 64.057685852051,
--             },
--         },
--         [2] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = -1490.6888427734,
--                 ["y"] = -658.32989501953,
--                 ["z"] = 29.025077819824,
--             },
--         },
--         [3] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = -703.07153320312,
--                 ["y"] = -1179.5406494141,
--                 ["z"] = 10.609411239624,
--             },
--         },
--         [4] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = -1430.6611328125,
--                 ["y"] = -885.15454101562,
--                 ["z"] = 10.934238433838,
--             },
--         },
--         [5] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = -1673.0821533203,
--                 ["y"] = 385.91482543945,
--                 ["z"] = 89.348289489746,
--             },
--         },
--         [6] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = 252.26,
--                 ["y"] = 358.14,
--                 ["z"] = 105.55,
--             },
--         },
--         [7] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = 151.44,
--                 ["y"] = -72.73,
--                 ["z"] = 67.67,
--             },
--         },
--         [8] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = 16.61,
--                 ["y"] = -1443.83,
--                 ["z"] = 30.95,
--             },
--         },
--         [9] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = -141.83,
--                 ["y"] = -1697.44,
--                 ["z"] = 30.77,
--             },
--         },
--         [10] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = 39.04,
--                 ["y"] = -1911.42,
--                 ["z"] = 21.95,
--             },
--         },
--         [11] = {
--             ["naam"] = "Locatie",
--             ["coords"] = {
--                 ["x"] = 474.53,
--                 ["y"] = -1757.62,
--                 ["z"] = 29.09,
--             },
--         },
--     }
-- })
end)
