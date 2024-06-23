Config = {}

-- geluid
Config.radius = 35
Config.DefaultVolume = 0.3

-- Prijzen
Config.SleutelPrijs = 35000
Config.HardeSchijfPrijs_2 = 35000
Config.HardeSchijfPrijs_3 = 45000
Config.HardeSchijfPrijs_4 = 60000
 
-- Rewards 
Config.ComputerReward = math.random(2500, 5000)

 
-- Overig 
Config.Minimumwout = 5
Config.AlarmTijd = 600000 -- 10 minuten
Config.LockedIn = 120000
Config.Timeout =  120 * (60 * 1000)

Config.Noodstroom = false 

-- Locaties 
Config.VerkoopNPC = {x = 1272.32, y = -1712.19, z = 53.80, h = 289.84}
Config.VoltageKast = {
    [1] = { 
        ["coords"] = { 
        ["x"] = -1051.38,
        ["y"] = -238.29, 
        ["z"] = 39.73, 
    }, 
    ["isOpened"] = false, 
    ["isBusy"] = false, 
    }, 
}

Config.ComputerLocaties = {
    [1] = {
        ["coords"] = {
            ["x"] = -1063.64, 
            ["y"] = -246.76,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    },  
    [2] = {
        ["coords"] = {
            ["x"] = -1062.48, 
            ["y"] = -249.00,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [3] = {
        ["coords"] = {
            ["x"] = -1059.77, 
            ["y"] = -248.26,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [4] = {
        ["coords"] = {
            ["x"] = -1060.37, 
            ["y"] = -245.05,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [5] = {
        ["coords"] = {
            ["x"] = -1057.70, 
            ["y"] = -244.24,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [6] = {
        ["coords"] = {
            ["x"] = -1058.23, 
            ["y"] = -243.09,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [7] = {
        ["coords"] = {
            ["x"] = -1055.56, 
            ["y"] = -242.88,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [8] = {
        ["coords"] = {
            ["x"] = -1053.22, 
            ["y"] = -245.04,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [9] = {
        ["coords"] = {
            ["x"] = -1055.94, 
            ["y"] = -245.67,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [10] = {
        ["coords"] = {
            ["x"] = -1052.85, 
            ["y"] = -243.99,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [11] = {
        ["coords"] = {
            ["x"] = -1053.96, 
            ["y"] = -241.81,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [12] = {
        ["coords"] = {
            ["x"] = -1050.59, 
            ["y"] = -240.40,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [13] = {
        ["coords"] = {
            ["x"] = -1051.15, 
            ["y"] = -241.21,
            ["z"] = 44.02,  
        }, 
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [14] = {
        ["coords"] = {
            ["x"] = -1050.09, 
            ["y"] = -243.26,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
}

Config.NetwerkComputers = {
    [1] = {
        ["coords"] = {
            ["x"] = -1057.15, 
            ["y"] = -232.57,
            ["z"] = 44.02, 
        },
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
    [2] = {
        ["coords"] = {
            ["x"] = -1053.20, 
            ["y"] = -230.30,
            ["z"] = 44.02, 
        }, 
        ["isHacked"] = false,
        ["isBusy"] = false, 
    }, 
}