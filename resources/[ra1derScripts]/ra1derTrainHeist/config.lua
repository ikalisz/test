Config = {}

Config.KartName = "guvenlik_karti_e"

Config['TrainHeist'] = {
    ['requiredPoliceCount'] = 1, -- required police count for start heist
    ['nextRob'] = 3600, -- seconds for next heist
    ['requiredItems'] = { -- add to database or shared
        'delicialet',
        "guvenlik_karti_e"
    },
    ['reward'] = {
        itemName = 'goldbar', -- gold item name
        grabamount = 25, -- gold grab amount
        sellPrice = 200 -- buyer sell price
    },
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-687.82, -2417.1, 13.9445),
        peds = {
            {pos = vector3(-934.721, -2925.82, 13.950), heading = 288.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-933.804, -2927.78, 13.951), heading = 327.42, ped = 'a_m_y_hasjew_01'},
            {pos = vector3(-934.999, -2923.53, 13.948), heading = 236.42, ped = 'a_m_y_smartcaspat_01'}
        }
    },
    ['guardPeds'] = { -- guard ped list (you can add new)
    { coords = vector3(2850.67, 4535.49, 45.3924), heading = 270.87, model = 's_m_y_blackops_01'},
    { coords = vector3(2833.246, 4539.546, 46.579), heading = 22.87, model = 's_m_y_blackops_01'},
    { coords = vector3(2856.28, 4544.12, 45.3354), heading = 177.93, model = 's_m_y_blackops_01'},
    { coords = vector3(2869.90, 4530.26, 47.7877), heading = 354.93, model = 's_m_y_blackops_01'},
    { coords = vector3(2856.90, 4526.85, 48.6552), heading = 268.3, model = 's_m_y_blackops_01'},
    { coords = vector3(2924.16, 4555.50, 49.0100), heading = 265.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2926.36, 4584.29, 48.77), heading = 141.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2901.05, 4597.49, 47.59), heading = 172.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2872.38, 4568.56, 47.36), heading = 265.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2841.62, 4555.37, 47.06), heading = 190.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2861.58, 4537.78, 45.50), heading = 64.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2883.46, 4558.21, 49.02), heading = 53.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2940.87, 4623.36, 48.72), heading = 152.05, model = 's_m_y_blackops_01'},

    { coords = vector3(2921.87, 4544.25, 49.79), heading = 226.45, model = 's_m_y_blackops_01'},
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
    ['cutting'] = 'Press ~INPUT_CONTEXT~ to cutting',
    ['grab'] = 'Press ~INPUT_CONTEXT~ to grab',
    ['start_heist'] = 'Press ~INPUT_CONTEXT~ to Start Train Heist',
    ['goto_ambush'] = 'Go to ambush point in GPS. Kill the guards, search Merryweather containers and steal golds.',
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['ambush_blip'] = 'Amubsh Point',
    ['need_this'] = 'You need this: ',
    ['deliver_to_buyer'] = 'Deliver the loot to the buyer. Check gps.',
    ['buyer_blip'] = 'Buyer',
    ['need_police'] = 'Not enough police in the city.',
    ['total_money'] = 'You got this: ',
    ['police_alert'] = 'Train robbery alert! Check your gps.',
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