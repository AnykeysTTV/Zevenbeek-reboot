Config = {}

Config['TrainHeist'] = {
    ['requiredPoliceCount'] = 5, -- required police count for start heist
    ['nextRob'] = 10800, -- seconds for next heist
    ['requiredItems'] = { -- add to database or shared
        'cutter',
        'bag'
    },
    ['reward'] = {
        itemName = 'stolengoldbar', -- gold item name
        grabCount = 25, -- gold grab count
        sellPrice = 2000 -- buyer sell price
    },
    ['startHeist'] ={ -- heist start coords
        pos = vector3( 468.30, -2193.83, 5.92),
        peds = {
            {pos = vector3(468.30, -2193.83, 5.92), heading = 69.14, ped = 's_m_m_highsec_01'},
            {pos = vector3(468.1,  -2193.07, 5.92), heading = 153.28, ped = 's_m_m_highsec_02'},
            {pos = vector3(467.72, -2194.21, 5.92), heading = 338.79, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['guardPeds'] = { -- guard ped list (you can add new)
            { coords = vector3(2850.67, 4535.49, 45.3924), heading = 270.87, model = 's_m_y_blackops_03'},
            { coords = vector3(2856.28, 4544.12, 45.3354), heading = 177.93, model = 's_m_y_blackops_03'},
            { coords = vector3(2869.90, 4530.26, 47.7877), heading = 354.93, model = 's_m_y_blackops_03'},
            { coords = vector3(2859.08, 4519.85, 47.9145), heading = 177.88, model = 's_m_y_blackops_03'},
            { coords = vector3(2886.69, 4556.21, 48.4262), heading = 265.05, model = 's_m_y_blackops_03'},
    }, 
    ['finishHeist'] = { -- finish heist coords
        buyerPos = vector3(-1690.6, -916.19, 6.78323)
    },
    ['setupTrain'] = { -- train and containers coords
        pos = vector3(2872.028, 4544.253, 47.758),
        part = vector3(2883.305, 4557.646, 47.758),
        heading = 140.0,
        ['containers'] = {
            {
                pos = vector3(2885.97, 4560.83, 48.0551), 
                heading = 320.0, 
                lock = {pos = vector3(2884.76, 4559.38, 49.22561), taken = false},
                table = vector3(2886.55, 4561.53, 48.23),
                golds = {
                    {pos = vector3(2886.05, 4561.93, 49.14), taken = false},
                    {pos = vector3(2887.05, 4561.13, 49.14), taken = false},
                } 
            },
            {
                pos = vector3(2880.97, 4554.83, 48.0551), 
                heading = 140.0, 
                lock = {pos = vector3(2882.15, 4556.26, 49.22561), taken = false},
                table = vector3(2880.45, 4554.23, 48.23),
                golds = {
                    {pos = vector3(2881.05, 4553.93, 49.14), taken = false},
                    {pos = vector3(2880.25, 4554.63, 49.14), taken = false},
                } 
            }
        }
    }
} 

Strings = {
    ['start_heist'] = 'Press ~INPUT_CONTEXT~ to Start Train Heist',
    ['cutting'] = 'Druk op E om te starten met slijpen',
    ['grab'] = 'Druk op E om te beginnen met pakken',
    ['start_heist'] = 'Press ~INPUT_CONTEXT~ to Start Train Heist',
    ['goto_ambush'] = 'Ga naar de overval plek op je GPS, vermoord de bewakers maar let op ze zijn bewapend!. Slijp de containers open met een slijptol en neem een tas mee!',
    ['wait_nextrob'] = 'Je moet zo lang wachten om de overval te starten',
    ['minute'] = 'minuten.',
    ['ambush_blip'] = 'Overval punt',
    ['need_this'] = 'Je hebt het volgende nodig: ',
    ['deliver_to_buyer'] = 'Breng de spullen naar de koper, check je gps',
    ['buyer_blip'] = 'Koper',
    ['need_police'] = 'Niet genoeg wout aanwezig.',
    ['total_money'] = 'Je hebt dit: ',
    -- ['police_alert'] = 'Train robbery alert! Check your gps.',
}

--Dont change. Main and required things.
TrainAnimation = {
    ['objects'] = {
        'tr_prop_tr_grinder_01a',
        'ch_p_m_bag_var02_arm_s'
    },
    ['animations'] = {
        {'action', 'action_container', 'action_lock', 'action_angle_grinder', 'action_bag'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

GrabGold = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'enter', 'enter_bag'},
        {'grab', 'grab_bag', 'grab_gold'},
        {'grab_idle', 'grab_idle_bag'},
        {'exit', 'exit_bag'},
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}