Config, Types, Bones = {}, {}, {}
Types[1], Types[2], Types[3] = {}, {}, {}

-- This is the vehicle bones table, this is needed to verify if the vehicle bone exists when checking them, here is a list of vehicle bones you can use, all of them are included in this table: https://wiki.rage.mp/index.php?title=Vehicle_Bones
Config.VehicleBones = {'chassis', 'chassis_lowlod', 'chassis_dummy', 'seat_dside_f', 'seat_dside_r', 'seat_dside_r1', 'seat_dside_r2', 'seat_dside_r3', 'seat_dside_r4', 'seat_dside_r5', 'seat_dside_r6', 'seat_dside_r7', 'seat_pside_f', 'seat_pside_r', 'seat_pside_r1', 'seat_pside_r2', 'seat_pside_r3', 'seat_pside_r4', 'seat_pside_r5', 'seat_pside_r6', 'seat_pside_r7', 'window_lf1', 'window_lf2', 'window_lf3', 'window_rf1', 'window_rf2', 'window_rf3', 'window_lr1', 'window_lr2', 'window_lr3', 'window_rr1', 'window_rr2', 'window_rr3', 'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'handle_dside_f', 'handle_dside_r', 'handle_pside_f', 'handle_pside_r', 'wheel_lf', 'wheel_rf', 'wheel_lm1', 'wheel_rm1', 'wheel_lm2', 'wheel_rm2', 'wheel_lm3', 'wheel_rm3', 'wheel_lr', 'wheel_rr', 'suspension_lf', 'suspension_rf', 'suspension_lm', 'suspension_rm', 'suspension_lr', 'suspension_rr', 'spring_rf', 'spring_lf', 'spring_rr', 'spring_lr', 'transmission_f', 'transmission_m', 'transmission_r', 'hub_lf', 'hub_rf', 'hub_lm1', 'hub_rm1', 'hub_lm2', 'hub_rm2', 'hub_lm3', 'hub_rm3', 'hub_lr', 'hub_rr', 'windscreen', 'windscreen_r', 'window_lf', 'window_rf', 'window_lr', 'window_rr', 'window_lm', 'window_rm', 'bodyshell', 'bumper_f', 'bumper_r', 'wing_rf', 'wing_lf', 'bonnet', 'boot', 'exhaust', 'exhaust_2', 'exhaust_3', 'exhaust_4', 'exhaust_5', 'exhaust_6', 'exhaust_7', 'exhaust_8', 'exhaust_9', 'exhaust_10', 'exhaust_11', 'exhaust_12', 'exhaust_13', 'exhaust_14', 'exhaust_15', 'exhaust_16', 'engine', 'overheat', 'overheat_2', 'petrolcap', 'petrolcap', 'petroltank', 'petroltank_l', 'petroltank_r', 'steering', 'hbgrip_l', 'hbgrip_r', 'headlight_l', 'headlight_r', 'taillight_l', 'taillight_r', 'indicator_lf', 'indicator_rf', 'indicator_lr', 'indicator_rr', 'brakelight_l', 'brakelight_r', 'brakelight_m', 'reversinglight_l', 'reversinglight_r', 'extralight_1', 'extralight_2', 'extralight_3', 'extralight_4', 'numberplate', 'interiorlight', 'siren1', 'siren2', 'siren3', 'siren4', 'siren5', 'siren6', 'siren7', 'siren8', 'siren9', 'siren10', 'siren11', 'siren12', 'siren13', 'siren14', 'siren15', 'siren16', 'siren17', 'siren18', 'siren19', 'siren20', 'siren_glass1', 'siren_glass2', 'siren_glass3', 'siren_glass4', 'siren_glass5', 'siren_glass6', 'siren_glass7', 'siren_glass8', 'siren_glass9', 'siren_glass10', 'siren_glass11', 'siren_glass12', 'siren_glass13', 'siren_glass14', 'siren_glass15', 'siren_glass16', 'siren_glass17', 'siren_glass18', 'siren_glass19', 'siren_glass20', 'spoiler', 'struts', 'misc_a', 'misc_b', 'misc_c', 'misc_d', 'misc_e', 'misc_f', 'misc_g', 'misc_h', 'misc_i', 'misc_j', 'misc_k', 'misc_l', 'misc_m', 'misc_n', 'misc_o', 'misc_p', 'misc_q', 'misc_r', 'misc_s', 'misc_t', 'misc_u', 'misc_v', 'misc_w', 'misc_x', 'misc_y', 'misc_z', 'misc_1', 'misc_2', 'weapon_1a', 'weapon_1b', 'weapon_1c', 'weapon_1d', 'weapon_1a_rot', 'weapon_1b_rot', 'weapon_1c_rot', 'weapon_1d_rot', 'weapon_2a', 'weapon_2b', 'weapon_2c', 'weapon_2d', 'weapon_2a_rot', 'weapon_2b_rot', 'weapon_2c_rot', 'weapon_2d_rot', 'weapon_3a', 'weapon_3b', 'weapon_3c', 'weapon_3d', 'weapon_3a_rot', 'weapon_3b_rot', 'weapon_3c_rot', 'weapon_3d_rot', 'weapon_4a', 'weapon_4b', 'weapon_4c', 'weapon_4d', 'weapon_4a_rot', 'weapon_4b_rot', 'weapon_4c_rot', 'weapon_4d_rot', 'turret_1base', 'turret_1barrel', 'turret_2base', 'turret_2barrel', 'turret_3base', 'turret_3barrel', 'ammobelt', 'searchlight_base', 'searchlight_light', 'attach_female', 'roof', 'roof2', 'soft_1', 'soft_2', 'soft_3', 'soft_4', 'soft_5', 'soft_6', 'soft_7', 'soft_8', 'soft_9', 'soft_10', 'soft_11', 'soft_12', 'soft_13', 'forks', 'mast', 'carriage', 'fork_l', 'fork_r', 'forks_attach', 'frame_1', 'frame_2', 'frame_3', 'frame_pickup_1', 'frame_pickup_2', 'frame_pickup_3', 'frame_pickup_4', 'freight_cont', 'freight_bogey', 'freightgrain_slidedoor', 'door_hatch_r', 'door_hatch_l', 'tow_arm', 'tow_mount_a', 'tow_mount_b', 'tipper', 'combine_reel', 'combine_auger', 'slipstream_l', 'slipstream_r', 'arm_1', 'arm_2', 'arm_3', 'arm_4', 'scoop', 'boom', 'stick', 'bucket', 'shovel_2', 'shovel_3', 'Lookat_UpprPiston_head', 'Lookat_LowrPiston_boom', 'Boom_Driver', 'cutter_driver', 'vehicle_blocker', 'extra_1', 'extra_2', 'extra_3', 'extra_4', 'extra_5', 'extra_6', 'extra_7', 'extra_8', 'extra_9', 'extra_ten', 'extra_11', 'extra_12', 'break_extra_1', 'break_extra_2', 'break_extra_3', 'break_extra_4', 'break_extra_5', 'break_extra_6', 'break_extra_7', 'break_extra_8', 'break_extra_9', 'break_extra_10', 'mod_col_1', 'mod_col_2', 'mod_col_3', 'mod_col_4', 'mod_col_5', 'handlebars', 'forks_u', 'forks_l', 'wheel_f', 'swingarm', 'wheel_r', 'crank', 'pedal_r', 'pedal_l', 'static_prop', 'moving_prop', 'static_prop2', 'moving_prop2', 'rudder', 'rudder2', 'wheel_rf1_dummy', 'wheel_rf2_dummy', 'wheel_rf3_dummy', 'wheel_rb1_dummy', 'wheel_rb2_dummy', 'wheel_rb3_dummy', 'wheel_lf1_dummy', 'wheel_lf2_dummy', 'wheel_lf3_dummy', 'wheel_lb1_dummy', 'wheel_lb2_dummy', 'wheel_lb3_dummy', 'bogie_front', 'bogie_rear', 'rotor_main', 'rotor_rear', 'rotor_main_2', 'rotor_rear_2', 'elevators', 'tail', 'outriggers_l', 'outriggers_r', 'rope_attach_a', 'rope_attach_b', 'prop_1', 'prop_2', 'elevator_l', 'elevator_r', 'rudder_l', 'rudder_r', 'prop_3', 'prop_4', 'prop_5', 'prop_6', 'prop_7', 'prop_8', 'rudder_2', 'aileron_l', 'aileron_r', 'airbrake_l', 'airbrake_r', 'wing_l', 'wing_r', 'wing_lr', 'wing_rr', 'engine_l', 'engine_r', 'nozzles_f', 'nozzles_r', 'afterburner', 'wingtip_1', 'wingtip_2', 'gear_door_fl', 'gear_door_fr', 'gear_door_rl1', 'gear_door_rr1', 'gear_door_rl2', 'gear_door_rr2', 'gear_door_rml', 'gear_door_rmr', 'gear_f', 'gear_rl', 'gear_lm1', 'gear_rr', 'gear_rm1', 'gear_rm', 'prop_left', 'prop_right', 'legs', 'attach_male', 'draft_animal_attach_lr', 'draft_animal_attach_rr', 'draft_animal_attach_lm', 'draft_animal_attach_rm', 'draft_animal_attach_lf', 'draft_animal_attach_rf', 'wheelcover_l', 'wheelcover_r', 'barracks', 'pontoon_l', 'pontoon_r', 'no_ped_col_step_l', 'no_ped_col_strut_1_l', 'no_ped_col_strut_2_l', 'no_ped_col_step_r', 'no_ped_col_strut_1_r', 'no_ped_col_strut_2_r', 'light_cover', 'emissives', 'neon_l', 'neon_r', 'neon_f', 'neon_b', 'dashglow', 'doorlight_lf', 'doorlight_rf', 'doorlight_lr', 'doorlight_rr', 'unknown_id', 'dials', 'engineblock', 'bobble_head', 'bobble_base', 'bobble_hand', 'chassis_Control'}

----------------------------------------------------------------------------------------
-- Settings
----------------------------------------------------------------------------------------

-- Set to true to enable standalone functionality
Config.Standalone = false

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 4.0

-- Enable debug options and distance preview
Config.Debug = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = false

-- Key to open the target
Config.OpenKey = 'LMENU' -- Left Alt
Config.OpenControlKey = 19 -- Control for keypress detection also Left Alt, controls are found here https://docs.fivem.net/docs/game-references/controls/

-- Key to open the menu
Config.MenuControlKey = 24 -- Control for keypress detection, this is the Right Mouse Button, controls are found here https://docs.fivem.net/docs/game-references/controls/

----------------------------------------------------------------------------------------
-- Target Configs
----------------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {
    ["car-camera"] = {
        name = "PD cameras",
        coords = vector3(442.31, -999.67, 34.97), 
        length = 1.0,
        width = 3.4,
        heading = 359,
        debugPoly = false,
        minZ=34.77,
        maxZ=35.37,
        options = {
            {
                type = "client",
                event = "rp_interact:client:PoliceDashCams", 
                icon = "fas fa-circle",
                label = "Look at the vehicle cameras",
                job = "police",
            },
        },
        distance = 1.5
    },
	["policedelil"] = {
        name = "Evidence",
        coords = vector3(485.9093, -988.915, 30.689),
        length = 5.35,
        width = 1.5,
        heading = 270.0,
        debugPoly = false,
        minZ = 29.5,
        maxZ = 31.0,
        options = {
            {
              type = "client",
              event = "pddelil",
              icon = "fas fa-bong",
              label = "Look at the evidence",
              job = "police",
            },
        },
        distance = 2
    },
	["policemesai"] = {
        name = "Shift",
        coords = vector3(442.75, -982.01, 29.69),
        length = 2.0,
        width = 2.5,
        heading = 270.0,
        debugPoly = false,
        minZ = 27.5,
        maxZ = 31.0,
        options = {
            {
              type = "server",
              event = "QBCore:ToggleDuty",
              icon = "far fa-clipboard",
              label = "On/Off Duty",
              job = "police",
            },
            {
                type = "client",
                event = "lobimemur",
                icon = "fas fa-phone-volume",
                label = "Call the officer",
            },
            {
                type = "client",
                event = "exWallet:createLicense",
                icon = "fas fa-id-card",
                label = "Create Identity",
                job = "police"
            },
            
        },
        distance = 10
    },
    ["policekisisel"] = {
        name = "Police Personal",
        coords = vector3(479.9, -996.739, 30.691),
        length = 0.6,
        width = 2.2,
        heading = 270.0,
        debugPoly = false,
        minZ = 30.3,
        maxZ = 31.0,
        options = {
			{
				type = "client",
				event = "pd:kisisel",
				icon = "fas fa-box-open",
				label = "Personal Warehouse",
				job = "police",
			},
        },
        distance = 2
    },
	["policedepo"] = {
        name = "Police Depo",
        coords = vector3(473.9960, -995.064, 26.273),
        length = 4.0,
        width = 6.0,
        heading = 270.0,
        debugPoly = false,
        minZ = 25.6,
        maxZ = 28.0,
        options = {
            {
              type = "client",
              event = "polis:depo",
              icon = "fas fa-box-open",
              label = "Evidence store",
              job = "police",
            },
			{
				type = "client",
				event = "polis:trash",
				icon = "fas fa-trash-alt",
				label = "Bin",
				job = "police",
			},
			{
				type = "client",
				event = "polis:kasapara",
				icon = "fas fa-money-check-alt",
				label = "It's fun for me",
				job = "police",
			},
        },
        distance = 3
    },
	["policecephane"] = {
        name = "Police Cephanelik",
        coords = vector3(481.3409, -994.994, 31.644),
        length = 1.0,
        width = 3.2,
        heading = 0.650,
        debugPoly = false,
        minZ = 29.0,
        maxZ = 33.0,
        options = {
            {
              type = "client",
              event = "polis:cephanelik",
              icon = "fas fa-hand-holding",
              label = "Police Craftsmanship",
              job = "police",
            },
            {
                type = "client",
                event = "polis:cephanelikrutbeli",
                icon = "fas fa-hand-holding",
                label = "Certified weapons",
                job = "police",
                grade = 7
              },
        },
        distance = 2
    },
    ["policesilahtamir"] = {
        name = "Police weapon repair",
        coords = vector3(487.9, -997.115, 30.689),
        length = 1.0,
        width = 1.6,
        heading = 270.0,
        debugPoly = false,
        minZ = 30.4,
        maxZ = 31.0,
        options = {
			{
				type = "client",
				event = "polis:silahtamir",
				icon = "fas fa-clipboard",
				label = "Repair weapons",
				job = "police",
			  },
        },
        distance = 2
    },
	["policeheli"] = {
        name = "policeheli",
        coords = vector3(449.5297, -981.229, 43.691),
        length = 8.0,
        width = 8.0,
        heading = 270.0,
        debugPoly = false,
        minZ = 42.0,
        maxZ = 45.0,
        options = {
			{
              type = "client",
              event = "polis:mekanik",
              icon = "fas fa-car",
              label = "Mechanic",
              job = "police",
            },
        },
        distance = 6
    },
	["policemekanik"] = {
        name = "Police Mechanic",
        coords = vector3(450.3532, -975.624, 25.699),
        length = 8.0,
        width = 4.0,
        heading = 270.0,
        debugPoly = false,
        minZ = 24.0,
        maxZ = 26.5,
        options = {
            {
              type = "client",
              event = "polis:mekanik",
              icon = "fas fa-car",
              label = "Mechanic",
              job = "police",
            },
        },
        distance = 5
    },
    	["policemekanik2"] = {
        name = "Police Mechanic2",
        coords = vector3(463.0338, -1019.62, 28.106),
        length = 4.0,
        width = 4.0,
        heading = 90.0,
        debugPoly = false,
        minZ = 27.0,
        maxZ = 29.5,
        options = {
            {
              type = "client",
              event = "polis:mekanik",
              icon = "fas fa-car",
              label = "Mechanic",
              job = "police",
            },
        },
        distance = 5
    },
	["emsmesai"] = {
        name = "Emsshift",
        coords = vector3(312.2, -593.5, 43.28),
        length = 1.0,
        width = 2.0,
        heading = 158.0,
        debugPoly = false,
        minZ = 43.0,
        maxZ = 43.5,
        options = {
            {
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "far fa-clipboard",
				label = "ON/OFF Duty",
				job = "ambulance",
			  },
        },
        distance = 2
    },
	["emscop"] = {
        name = "emscop",
        coords = vector3(304.23, -601.4, 43.28),
        length = 1.0,
        width = 1.0,
        heading = 158.0,
        debugPoly = false,
        minZ = 42.0,
        maxZ = 43.5,
        options = {
			{
				type = "client",
				event = "ems:trash",
				icon = "fas fa-trash-alt",
				label = "Bin",
				job = "ambulance",
			},
        },
        distance = 2
    },
	["emstechizat"] = {
        name = "emstechizat",
        coords = vector3(306.5, -602.6, 43.28),
        length = 1.0,
        width = 2.0,
        heading = 160.0,
        debugPoly = false,
        minZ = 42.0,
        maxZ = 44.5,
        options = {
			{
              type = "client",
              event = "ems:techizat",
              icon = "fas fa-hand-holding",
              label = "Equipment cabinet",
              job = "ambulance",
            },
			{
				type = "client",
				event = "ems:kisisel",
				icon = "fas fa-box-open",
				label = "Personal warehouse",
				job = "ambulance",
			},
        },
        distance = 2
    },
	["emshastakayit"] = {
        name = "emshastakayit",
        coords = vector3(307.5, -595.15, 43.28),
        length = 1.0,
        width = 2.0,
        heading = 255.0,
        debugPoly = false,
        minZ = 43.0,
        maxZ = 43.5,
        options = {
			{
              type = "client",
              event = "ems:hastakayit",
              icon = "fas fa-hand-holding",
              label = "PATIENT REGISTRATION",
              job = "ambulance",
            },
        },
        distance = 2
    },
	["emsmekanik"] = {
        name = "emsmekanik",
        coords = vector3(338.83, -575.02, 28.8),
        length = 18.0,
        width = 4.0,
        heading = 340.0,
        debugPoly = false,
        minZ = 27.0,
        maxZ = 29.5,
        options = {
			{
              type = "client",
              event = "tgiann-mekanik:polisjob",
              icon = "fas fa-car",
              label = "Mechanic",
              job = "ambulance",
            },
        },
        distance = 4
    },
    ["kiyafet1"] = {
        name = "kiyafet1",
        coords = vector3(1692.7810058594, 4825.0986328125, 42.063125610352),
        length = 10.0,
        width = 10.0,
        heading = 185.0,
        debugPoly = false,
        minZ = 41.0,
        maxZ = 43.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 10
    },
    ["kiyafet2"] = {
        name = "kiyafet2",
        coords = vector3(-708.93273925781, -153.98446655273, 37.415172576904),
        length = 13.0,
        width = 15.0,
        heading = 118.0,
        debugPoly = false,
        minZ = 36.0,
        maxZ = 38.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 15
    },
    ["kiyafet3"] = {
        name = "kiyafet3",
        coords = vector3(-1192.7622070313, -771.54534912109, 17.324148178101),
        length = 18.0,
        width = 12.0,
        heading = 123.0,
        debugPoly = false,
        minZ = 16.0,
        maxZ = 18.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 15
    },
    ["kiyafet4"] = {
        name = "kiyafet4",
        coords = vector3(425.13031005859, -803.95520019531, 29.491147994995),
        length = 12.0,
        width = 12.0,
        heading = 94.0,
        debugPoly = false,
        minZ = 28.0,
        maxZ = 30.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 15
    },
    ["kiyafet5"] = {
        name = "kiyafet5",
        coords = vector3(-163.32328796387, -302.99334716797, 39.73327255249),
        length = 13.0,
        width = 15.0,
        heading = 244.0,
        debugPoly = false,
        minZ = 38.0,
        maxZ = 40.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 15
    },
    ["kiyafet6"] = {
        name = "kiyafet6",
        coords = vector3(76.318176269531, -1394.8155517578, 29.376150131226),
        length = 10.0,
        width = 13.0,
        heading = 264.0,
        debugPoly = false,
        minZ = 28.0,
        maxZ = 30.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet7"] = {
        name = "kiyafet7",
        coords = vector3(-823.71081542969, -1074.7614746094, 11.329222679138),
        length = 10.0,
        width = 13.0,
        heading = 208.0,
        debugPoly = false,
        minZ = 10.0,
        maxZ = 12.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet8"] = {
        name = "kiyafet8",
        coords = vector3(-1451.4409179688, -237.64953613281, 49.809177398682),
        length = 12.5,
        width = 15.0,
        heading = 45.0,
        debugPoly = false,
        minZ = 48.0,
        maxZ = 50.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet9"] = {
        name = "kiyafet9",
        coords = vector3(6.3427085876465, 6513.974609375, 31.878952026367),
        length = 10.0,
        width = 13.0,
        heading = 40.0,
        debugPoly = false,
        minZ = 30.0,
        maxZ = 32.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet10"] = {
        name = "kiyafet10",
        coords = vector3(617.33178710938, 2761.4636230469, 42.08814239502),
        length = 15.0,
        width = 12.0,
        heading = 180.0,
        debugPoly = false,
        minZ = 41.0,
        maxZ = 43.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet11"] = {
        name = "kiyafet11",
        coords = vector3(1194.6223144531, 2710.2136230469, 38.223701477051),
        length = 10.0,
        width = 13.0,
        heading = 180.0,
        debugPoly = false,
        minZ = 37.0,
        maxZ = 39.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet12"] = {
        name = "kiyafet12",
        coords = vector3(-3172.8269042969, 1046.9362792969, 20.863227844238),
        length = 15.0,
        width = 12.0,
        heading = 334.0,
        debugPoly = false,
        minZ = 19.0,
        maxZ = 21.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet13"] = {
        name = "kiyafet13",
        coords = vector3(-1102.9111328125, 2709.22265625, 19.108968734741),
        length = 10.0,
        width = 13.0,
        heading = 334.0,
        debugPoly = false,
        minZ = 18.0,
        maxZ = 20.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet14"] = {
        name = "kiyafet14",
        coords = vector3(-1207.4439697266, -1457.8726806641, 4.3599891662598),
        length = 10.0,
        width = 5.0,
        heading = 216.0,
        debugPoly = false,
        minZ = 3.0,
        maxZ = 5.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafet15"] = {
        name = "kiyafet15",
        coords = vector3(123.63760375977, -220.83842468262, 54.559200286865),
        length = 15.0,
        width = 13.0,
        heading = 334.0,
        debugPoly = false,
        minZ = 53.0,
        maxZ = 55.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafetunicorn"] = {
        name = "kiyafetunicorn",
        coords = vector3(106.49, -1303.45, 28.79),
        length = 10.0,
        width = 5.0,
        heading = 27.0,
        debugPoly = false,
        minZ = 27.0,
        maxZ = 30.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
            },
        },
        distance = 13
    },
    ["kiyafetpd1"] = {
        name = "kiyafetpd1",
        coords = vector3(845.89208984375, -1283.0170898438, 24.749334335327),
        length = 8.0,
        width = 3.5,
        heading = 177.0,
        debugPoly = false,
        minZ = 23.0,
        maxZ = 25.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
              job = "police"
            },
        },
        distance = 13
    },
    ["kiyafetpd2"] = {
        name = "kiyafetpd2",
        coords = vector3(460.9656, -997.693, 30.692),
        length = 6.0,
        width = 3.5,
        heading = 267.0,
        debugPoly = false,
        minZ = 29.0,
        maxZ = 31.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
              job = "police"
            },
        },
        distance = 13
    },
    ["kiyafetems1"] = {
        name = "kiyafetems1",
        coords = vector3(300.28689575195, -597.71276855469, 43.284080505371),
        length = 5.0,
        width = 3.5,
        heading = 340.0,
        debugPoly = false,
        minZ = 42.0,
        maxZ = 44.0,
        options = {
			{
              type = "client",
              event = "raidClothing:clothingShop",
              icon = "fas fa-tshirt",
              label = "Dress shop",
              job = "ambulance"
            },
        },
        distance = 13
    },
    ["berber1"] = {
        name = "berber1",
        coords = vector3(-813.21105957031, -183.45576477051, 37.568885803223),
        length = 16.0,
        width = 6.0,
        heading = 120.0,
        debugPoly = false,
        minZ = 36.0,
        maxZ = 38.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
    ["berber2"] = {
        name = "berber2",
        coords = vector3(137.26057434082, -1707.8629150391, 29.29160118103),
        length = 10.0,
        width = 10.0,
        heading = 248.0,
        debugPoly = false,
        minZ = 28.0,
        maxZ = 30.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
    ["berber3"] = {
        name = "berber3",
        coords = vector3(-1282.0003662109, -1117.2883300781, 6.9901175498962),
        length = 10.0,
        width = 5.0,
        heading = 90.0,
        debugPoly = false,
        minZ = 5.0,
        maxZ = 7.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
    ["berber4"] = {
        name = "berber4",
        coords = vector3(1930.8596191406, 3731.5241699219, 32.844417572021),
        length = 10.0,
        width = 5.0,
        heading = 207.0,
        debugPoly = false,
        minZ = 31.0,
        maxZ = 33.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
    ["berber5"] = {
        name = "berber5",
        coords = vector3(1212.9493408203, -472.83728027344, 66.207992553711),
        length = 10.0,
        width = 5.0,
        heading = 72.0,
        debugPoly = false,
        minZ = 65.0,
        maxZ = 67.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
    ["berber6"] = {
        name = "berber6",
        coords = vector3(-33.33666229248, -152.91725158691, 57.07649230957),
        length = 10.0,
        width = 5.0,
        heading = 338.0,
        debugPoly = false,
        minZ = 56.0,
        maxZ = 58.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
    ["berber7"] = {
        name = "berber7",
        coords = vector3(-277.42980957031, 6227.3403320313, 31.695539474487),
        length = 10.0,
        width = 5.0,
        heading = 44.0,
        debugPoly = false,
        minZ = 30.0,
        maxZ = 32.0,
        options = {
			{
              type = "client",
              event = "raidClothing:barberMenu",
              icon = "fas fa-hand-scissors",
              label = "Hairdresser",
            },
        },
        distance = 10
    },
}

Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetEntities = {

}

Config.TargetModels = {
    -- ["anahtar"] = {
    --     models = {
    --         "s_f_y_cop_01",
    --     },
    --     options = {
    --         {
    --             type = "client",
    --             event = "haso:anahtarmenu",
    --             icon = "fas fa-key",
    --             label = "Anahtar Çıkart",
    --         },
    --     },
    --     distance = 2.0
    -- },
    -- ["atm"] = {
    --     models = {
    --         -1126237515,
    --         506770882,
    --         -870868698,
    --         150237004,
    --         -239124254,
    --         -1364697528,
    --         GetHashKey("prop_atm_01"),
    --         GetHashKey("prop_atm_02"),
    --         GetHashKey("prop_atm_03"),
    --          GetHashKey("prop_fleeca_atm"),
    --          GetHashKey("v_corp_fleeca_display"),
    --     },
    --     options = {
    --         {
    --             type = "command",
    --             event = "atm",
    --             icon = "fas fa-dollar-sign",
    --             label = "ATM",
    --         },
    --     },
    --     distance = 1.0
    -- },
    -- ["benzinlik"] = {
    --     models=  {
    --      'prop_gas_pump_1d',
    --      'prop_gas_pump_1a', 
    --      'prop_gas_pump_1b', 
    --      'prop_gas_pump_1c', 
    --      'prop_vintage_pump', 
    --      'prop_gas_pump_old2', 
    --      'denis3d_prop_gas_pump',
    --      'prop_gas_pump_old3'
    --      },
    --      options = {
    --          {
    --              type = "client",
    --              event = "LegacyFuel:benzindoldur",
    --              icon = "fas fa-gas-pump",
    --              label = "Benzin Doldur",
    --          },
    --      },
    --      distance = 1.5
    --  },
	["sandalye"] = {
        models = {
			'prop_bench_01a',
			'prop_bench_01b',
			'prop_bench_01c',
			'prop_bench_02',
			'prop_bench_03',
			'prop_bench_04',
			'prop_bench_05',
			'prop_bench_06',
			'prop_bench_05',
			'prop_bench_08',
			'prop_bench_09',
			'prop_bench_10',
			'prop_bench_11',
			'prop_bench_07',
			'prop_fib_3b_bench',
			'prop_ld_bench01',
			'prop_wait_bench_01',
			'hei_prop_heist_off_chair',
			'hei_prop_hei_skid_chair',
			'prop_chair_01a',
			'prop_chair_01b',
			'prop_chair_02',
			'prop_chair_03',
			'prop_chair_04a',
			'prop_chair_04b',
			'prop_chair_05',
			'prop_chair_06',
			'prop_chair_05',
			'prop_chair_08',
			'prop_chair_09',
			'prop_chair_10',
			'v_club_stagechair',
			'prop_chateau_chair_01',
			'prop_clown_chair',
			'prop_cs_office_chair',
			'prop_direct_chair_01',
			'prop_direct_chair_02',
			'prop_gc_chair02',
			'prop_off_chair_01',
			'prop_off_chair_03',
			'prop_off_chair_04',
			'prop_off_chair_04b',
			'prop_off_chair_04_s',
			'prop_off_chair_05',
			'prop_old_deck_chair',
			'prop_old_wood_chair',
			'prop_rock_chair_01',
			'prop_skid_chair_01',
			'prop_skid_chair_02',
			'prop_skid_chair_03',
			'prop_sol_chair',
			'prop_wheelchair_01',
			'prop_wheelchair_01_s',
			'p_armchair_01_s',
			'p_clb_officechair_s',
			'p_dinechair_01_s',
			'p_ilev_p_easychair_s',
			'p_soloffchair_s',
			'p_yacht_chair_01_s',
			'v_club_officechair',
			'v_corp_bk_chair3',
			'v_corp_cd_chair',
			'v_corp_offchair',
			'v_ilev_chair02_ped',
			'v_ilev_hd_chair',
			'v_ilev_p_easychair',
			'v_ret_gc_chair03',
			'prop_ld_farm_chair01',
			'prop_table_04_chr',
			'prop_table_05_chr',
			'prop_table_06_chr',
			'v_ilev_leath_chr',
			'prop_table_01_chr_a',
			'prop_table_01_chr_b',
			'prop_table_02_chr',
			'prop_table_03b_chr',
			'prop_table_03_chr',
			'prop_torture_ch_01',
			'v_ilev_fh_dineeamesa',
			'v_ilev_fh_kitchenstool',
			'v_ilev_tort_stool',
			'v_ilev_fh_kitchenstool',
			'v_ilev_fh_kitchenstool',
			'v_ilev_fh_kitchenstool',
			'v_ilev_fh_kitchenstool',
			'hei_prop_yah_seat_01',
			'hei_prop_yah_seat_02',
			'hei_prop_yah_seat_03',
			'prop_waiting_seat_01',
			'prop_yacht_seat_01',
			'prop_yacht_seat_02',
			'prop_yacht_seat_03',
			'prop_hobo_seat_01',
			'prop_rub_couch01',
			'miss_rub_couch_01',
			'prop_ld_farm_couch01',
			'prop_ld_farm_couch02',
			'prop_rub_couch02',
			'prop_rub_couch03',
			'prop_rub_couch04',
			'p_lev_sofa_s',
			'p_res_sofa_l_s',
			'p_v_med_p_sofa_s',
			'p_yacht_sofa_01_s',
			'v_ilev_m_sofa',
			'v_res_tre_sofa_s',
			'v_tre_sofa_mess_a_s',
			'v_tre_sofa_mess_b_s',
			'v_tre_sofa_mess_c_s',
			'prop_roller_car_01',
			'prop_roller_car_02',
			-- Custom
			'v_ret_gc_chair02',
			'v_serv_ct_chair02',
        },
        options = {
            {
				event = "otur:event",
				icon = "fas fa-chair",
				label = "Sit",
				jobs = {"all"},
			},
        },
        distance = 1
    },
	["yatak"] = {
        models = {
            "v_med_bed2",
            "v_med_bed1",
            "prop_ld_toilet_01",
            "v_med_emptybed",
        },
        options = {
            {
                type = "client",
                event = "yattimlan:client",
                icon = "fas fa-bed",
                label = "Lie down on your face",
                args = "yuz",
            },
            {
                type = "client",
                event = "yattimlan:client",
                icon = "fas fa-bed",
                label = "Lay on your back",
                args = "sirt",
            },
            {
                type = "client",
                event = "yattimlan:client",
                icon = "fas fa-bed",
                label = "Sit on the bed",
                args = "otur",
            },
        },
        distance = 1.0
    },
-- k
     ["Çöp"] = {
        models=  {
             1437508529,
             -819563011,
             -289082718,
             1437508529,
             1614656839,
             -289082718,
             1437508529,
             1614656839,
             -130812911,
             -93819890,
             1329570871,
             1143474856,
             -228596739,
             -468629664,
             -1426008804,
             -1187286639,
             -1096777189,
             -413198204,
             437765445,
             122303831,
             1748268526,
             998415499,
             234941195,
             -2096124444,
             1792999139,
             -341442425,
             -329415894,
             -1830793175,
             -654874323,
             1010534896,
             651101403,
             909943734,
             1919238784,
             274859350,
             751349707,
             1627301588,
             1388415578,
             1813879595,
             1098827230,
             1388308576,
             600967813,
             1948359883,
             -1681329307,
             -96647174,
             811169045,
             -14708062,
             354692929,
             673826957,
             375956747,
             1233216915,
             -85604259,
             -115771139,
             -1998455445,
             577432224,
             684586828,
             218085040,
             666561306,
             -58485588,
             -206690185,
             1511880420,
             682791951,
             -1587184881
         },
         options = {
             {
                 type = "client",
                 event = "copkaristir",
                 icon = "fas fa-dumpster",
                 label = "Mix the garbage",
             },
             {
                type = "client",
                event = "copbak",
                icon = "fas fa-dumpster",
                label = "Look into the garbage",
            },
         },
         distance = 1.0
     },
    --  ["Market"] = {
    --     models=  {
    --          303280717
    --      },
    --      options = {
    --          {
    --              type = "client",
    --              event = "market:ac",
    --              label = "Market",
    --              icon = "fas fa-shopping-basket",
    --          },
    --      },
    --      distance = 1.0
    --  },
}

Config.GlobalPedOptions = {

}
local otuz= {
    "mechanic",
    "mechanic_bennys"
}

Config.GlobalVehicleOptions = {
	options = {
		{
			event = "aracislemlerigenel",
			icon = "fas fa-car",
			label = "Player Vehicle Operations"
		},
		{
			event = "ters-duz",
			icon = "fas fa-car-crash",
			label = "Turn the vehicle"
		},
		{
			event = "tgiann-menu:bgir",
			icon = "fas fa-truck-loading",
			label = "Get In The Trunk"
		},
        {
            type = 'client',
			event = "qb-truckrobbery:client:PickupCash",
			icon = "fas fa-circle",
			label = "Steal the Money",
            canInteract = function(entity)
                if exports["ra1derBankTruck"]:aracsoygun() and GetEntityModel(entity) == GetHashKey("stockade") then
                    return true
                else
                    return false
                end
            end
		},


        {
            type = 'client',
			event = "wheelchair:delete",
			icon = "fas fa-truck-loading",
			label = "Fold the Wheeled Vehicle",
            canInteract = function(entity)
                if GetEntityModel(entity) == GetHashKey("npwheelchair") then
                    return true
                end
    
                return false
            end
		},
        {
            type = 'client',
            event = 'ra1derMethCar:cook',
            icon = 'fas fa-blender',
            label = 'Cook Meth',
			canInteract = function(entity)
                if GetVehicleEngineHealth(entity) <= 0 then return false end
                	local model = GetEntityModel(entity)
					local modelName = GetDisplayNameFromVehicleModel(model)
					if modelName == 'JOURNEY' then
                    return true
                end
                return false
            end
        },
	},
}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
	options = {
		{
			type = "client",
			event = "oyuncuislemleri",
			icon = "fas fa-globe-europe",
			label = "Player Actions",
		},
        {
            type = "client",
			event = "target:nakitver",
			icon = "fas fa-circle",
			label = "Give Cash",
		},
		{
			type = "client",
			event = "polisislemleri",
			icon = "fas fa-users",
			label = "Police Operations",
			job = "police",
		},
		{
			type = "client",
			event = "emsislemleri",
			icon = "fas fa-ambulance",
			label = "EMS Transactions",
			job = "ambulance",
		},
	},
}

QBCore = exports['qb-core']:GetCoreObject()

Config.GlobalSelfMenu = {
	options = {
        -- {
        --     type = "client",
        --     event = "kimlikislemleri",
        --     icon = "fas fa-id-card",
        --     label = "Kimlik İşlemleri",
        --     canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
        --         if QBCore.Functions.GetPlayerData().metadata['isdead'] == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
        --         return false
        --     end,
        -- },
		-- {
        --     type = "client",
        --     event = "kiyafetamkcocu",
        --     icon = "fas fa-tshirt",
        --     label = "Kıyafet İşlemleri",
        --     canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
        --         if QBCore.Functions.GetPlayerData().metadata['isdead'] == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
        --         return false
        --     end,
        -- },
        {
            type = "client",
            event = "dpemotes:animation-menu",
            icon = "fas fa-play",
            label = "Animation",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if QBCore.Functions.GetPlayerData().metadata['isdead'] == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        -- {
		-- 	type = "client",
		-- 	event = "mekanislemleri",
		-- 	icon = "fas fa-map-marked-alt",
		-- 	label = "Mekan Blipleri Aç / Kapa",
        --     canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
        --         if QBCore.Functions.GetPlayerData().metadata['isdead'] == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
        --         return false
        --     end,
		-- },
        {
			type = "command",
			event = "refreshskin",
			icon = "fas fa-exchange-alt",
			label = "Refresh Character",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if IsPedInAnyVehicle(PlayerPedId(), false) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                return true
            end,
		},
        -- {
        -- type = "client",
        -- event = "mekanislemleri",
        -- icon = "fas fa-map-marked-alt",
        -- label = "Mekan Blipleri Aç / Kapa",
        --  },
        -- {
		-- 	type = "client",
		-- 	event = "meslekislemleri",
		-- 	icon = "fas fa-map-marker",
		-- 	label = "Meslek İşlemleri",
        --     canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
        --         if QBCore.Functions.GetPlayerData().job.name == "police" and QBCore.Functions.GetPlayerData().metadata['isdead'] == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
        --         return false
        --     end,
		-- },
        {
            type = "command",
            event = "taşı",
            icon = "fas fa-people-carry",
            label = "Drop the Person You're Carrying",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if exports["tgiann-kelepce"]:tasiyormuyum() and IsPedInAnyVehicle(PlayerPedId(), false) == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
            type = "client",
            event = "tgiann-garaj:open",
            icon = "fas fa-car",
            label = "Garage",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if exports["tgiann-garajv2"]:checkgarage() and IsPedInAnyVehicle(PlayerPedId(), false) == false then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
            type = "client",
            event = "tgiann-garaj:open",
            icon = "fas fa-car",
            label = "Park Vehicle",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if exports["tgiann-garajv2"]:checkgarage() and IsPedInAnyVehicle(PlayerPedId(), false) then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
			type = "command",
			event = "pdepo",
			icon = "fas fa-box",
			label = "Open Special Vehicle Inventory",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if IsPedInAnyVehicle(PlayerPedId(), false) and QBCore.Functions.GetPlayerData().job.name == "police" and GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false)) == 18 then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
		},
        {
			type = "client",
			event = "tgiann-carcontrol:open",
			icon = "fas fa-wrench",
			label = "Tool Menu",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if IsPedInAnyVehicle(PlayerPedId(), false) then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
            type = "client",
            event = "polisyarali",
            icon = "fas fa-id-card",
            label = "Submit Police Notification",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if QBCore.Functions.GetPlayerData().metadata['isdead'] then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
            type = "client",
            event = "emsbildirimgonder",
            icon = "fas fa-id-card",
            label = "Send EMS Notification",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if QBCore.Functions.GetPlayerData().metadata['isdead'] then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
            type = "client",
            event = "ems:medic",
            icon = "fas fa-comment-medical",
            label = "Consult Medic (2500$)",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if QBCore.Functions.GetPlayerData().metadata['isdead'] then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
        {
            type = "command",
            event = "ptekne",
            icon = "fas fa-ship",
            label = "Police Boat",
            job = "police",
            canInteract = function() -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                if QBCore.Functions.GetPlayerData().metadata['isdead'] == false and IsEntityInWater(PlayerPedId()) then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                return false
            end,
        },
	},
}

Config.Peds = {
    { 
        model = 'a_m_m_hillbilly_02',
        coords = vector4(683.44, -789.51, 24.5, 6.0), 
        minusOne = true, 
        gender = "male",
        freeze = true, 
        invincible = true, 
        blockevents = true,
        target = { 
            options = {
                {
					type = "client",
					event = "ps-drugprocessing:EnterLab",
					icon = "fas fa-atom",
					label = "Talk to Walter",
                }
            },
          distance = 1.7,
        },
    },
    {
        model = 'a_m_m_mlcrisis_01',
        coords = vector4(812.49, -2399.59, 23.66, 223.1), 
        minusOne = true, 
        gender = "male",
        freeze = true, 
        invincible = false, 
        blockevents = true,
        target = { 
            options = {
                {
					type = "client",
					event = "ps-drugprocessing:EnterCWarehouse",
					icon = "fas fa-key",
					label = "Talk to Draco",
                }
            },
          distance = 1.7,
        },
    },
}

----------------------------------------------------------------------------------------
-- Functions
----------------------------------------------------------------------------------------

if Config.EnableDefaultOptions then
	function Config.ToggleDoor(vehicle, door)
		if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
				SetVehicleDoorShut(vehicle, door, false)
			else
				SetVehicleDoorOpen(vehicle, door, false)
			end
		end
	end
end

----------------------------------------------------------------------------------------
-- Default options
----------------------------------------------------------------------------------------

-- These options don't represent the actual way of making TargetBones or filling out Config.TargetBones, refer to the TEMPLATES.md for a template on that, this is only the way to add it without affecting the config table

if Config.EnableDefaultOptions then
	Bones['seat_dside_f'] = {
		["Toggle Front Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Front Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 0)
			end,
			distance = 1.2
		}
	}

	Bones['seat_pside_f'] = {
		["Toggle Front Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Front Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 1)
			end,
			distance = 1.2
		}
	}

	Bones['seat_dside_r'] = {
		["Toggle Rear Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Rear Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 2)
			end,
			distance = 1.2
		}
	}

	Bones['seat_pside_r'] = {
		["Toggle Rear Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Rear Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 3)
			end,
			distance = 1.2
		}
	}

	Bones['bonnet'] = {
		["Toggle Hood"] = {
			icon = "fa-duotone fa-engine",
			label = "Toggle Hood",
			action = function(entity)
				Config.ToggleDoor(entity, 4)
			end,
			distance = 0.9
		}
	}
end