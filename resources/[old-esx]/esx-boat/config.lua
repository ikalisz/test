Config               = {}

Config.MarkerType    = 1
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

Config.StoreMarker = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

Config.Zones = {
	BoatShops = {
		{ -- Shank St, nearby campaign boat garage
			Outside = vector3(-773.7, -1495.2, 2.6),
			Inside = vector4(-798.5, -1503.1, -0.4, 120.0)
		}
	}

}

Config.Vehicles = {
	{model = 'seashark', label = 'Jet Ski', price = 25000},
	{model = 'suntrap', label = 'Boat', price = 60000},
	{model = 'tropic', label = 'Boat', price = 90000},
	{model = 'squalo', label = 'Sightseeing Boat', price = 130000},
	{model = 'dinghy', label = 'Zodiac Red', price = 200000},
	{model = 'dinghy3', label = 'Zodiac Black', price = 200000},
	{model = 'jetmax', label = 'Speedboat', price = 270000},
	{model = 'speeder', label = 'Big Speedboat', price = 350000},
	{model = 'speeder2', label = 'Big Speedboat (Coated)', price = 350000},
	{model = 'Marquis', label = 'Sailboat', price = 500000},
	{model = 'toro', label = 'Luxury Speedboat', price = 600000},
	{model = 'Tug', label = 'Old Fishing Boat', price = 50000},
	{model = 'longfin', label = 'Longfin', price = 2000000},

}