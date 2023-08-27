Config = {}

Config.Chance = 50 --Eğer ki Config.Items içerisinde rare girmemişseniz default olarak 50 ve altı değer için eşyayı verir
Config.PaymentType = 'cash' -- Ödeme Seçeneği
Config.DeliveryTime = 60 -- Saniye cinsinden eşyaların teslim edilme süresi

Config.Seller = { -- You can duplicates NPCs from here
    {
        targetLabel = Lang:t('cfg.targetLabel'),
        targetIcon = 'fas fa-people-carry'
    }
}

Config.Items = {
    {
        rare = 60, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'lowgradefemaleseed',
        label = 'Female Marijuana Seed',
        price = 300,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 60, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'lowgrademaleseed',
        label = 'Male Cannabis Seed',
        price = 200,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 80, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'lockpick3',
        label = 'Arrived Monkey',
        price = 250,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 99, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'weapon_shiv',
        label = 'Glass Knife',
        price = 500,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 80, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'hydrochloric_acid',
        label = 'Hydraulic Acid',
        price = 100,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 80, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'sodium_hydroxide',
        label = 'Soydum Hydroxide',
        price = 100,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 80, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'sulfuric_acid',
        label = 'Sulfuric acid',
        price = 100,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 50, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'methkey',
        label = 'Lab Key',
        price = 1000,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 100, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'finescale',
        label = 'Fine Scale',
        price = 100,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 99, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'aseton',
        label = 'Nail polish remover',
        price = 20,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 99, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'bakingsoda',
        label = 'Blackening Powder',
        price = 15,
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 99, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 60,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'thionyl_chloride',
        label = 'Thionyl Chloride',
        price = 150, 
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
    {
        rare = 70, -- Girilen değer 100 üzerinden kontrol edilir ve girilen sayının eksiği yanmayacak şekilde kabul edilir
        time = 360,  -- Girilen sayı eşyanın teslimat süresidir, adet artar ise : örnek 2x 360 olarak süre katlanır
        hash = 'weapon_machinepistol',
        label = 'Intratec TEC-DG9 (Light Scan)',
        price = 8000, 
        icon = 'fas fa-circle', -- You can edit the option icon in the menu here.
    },
}

