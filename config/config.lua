--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 500



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
    --- FOOD ---
	bread = 250,
	chocolate = 500,
	cocacola = 500,
	croquettes = 250,
	cupcake = 250,
	hamburger = 250,
	protein_shake = 500,
	sandwich = 250,
	sportlunch = 250,
	
	--- FOOD ---
	
	--- DRINKS ---
	water = 500,
	coffe = 500,
	milk = 500,
	beer = 500,
	tequila = 500,
	vodka = 500,
	whisky = 500,
	wine = 500,
	icetea = 500,
	powerade = 500,
	--- DRINKS ---
	
	--- MEDS ---
	bandage = 100,
	medikit = 500,
	--- MEDS ---
	
	--- JOBS ---
	alive_chicken = 1000,
	clothe = 1000,
	copper = 1000,
	diamond = 1000,
	cutted_wood = 1000,
	essence = 1000,
	fabric = 1000,
	gold = 1000,
	iron = 1000,
	packaged_chicken = 1000,
	packaged_plank = 1000,
	petrol = 1000,
	petrol_raffin = 1000,
	slaughtered_chicken = 1000,
	stone = 1000,
	washed_stone = 1000,
	wood = 1000,
	wool = 1000,
	--- JOBS ---
	
	--- MISC ---
	bulletproof = 2500,
	lighter = 100,
	cigarett = 100,
	gazbottle = 1000,
	scratchoff = 1,
	scratchoff_used = 1,
	gym_membership = 1,
	oxygen_mask = 1000,
	--- MISC ---
	
	--- TOOLS ---
	blowpipe = 1000,
	carokit = 1000,
	carotool = 1000,
	drill = 1000,
	fixkit = 1000,
	fixtool = 1000,
	lockpick = 1000,
	repairkit = 1000,
	--- TOOLS ---
	
	--- ILEGALS ---
	coke = 1000,
	coke_pooch = 1000,
	meth = 1000,
	meth_pooch = 1000,
	opium = 1000,
	opium_pooch = 1000,
	weed = 1000,
	weed_pooch = 1000,
	--- ILEGALS ---
	
	---WEAPONS----
	clip = 1000,
	WEAPON_GRENADE = 1000,
	WEAPON_BZGAS = 1000,
	WEAPON_SMOKEGRENADE = 1000,
	WEAPON_RAILGUN = 1000,
	WEAPON_STICKYBOMB = 1000,
	WEAPON_KNIFE = 1000,
	WEAPON_NIGHTSTICK = 1000,
	WEAPON_HAMMER = 1000,
	WEAPON_BAT = 1000,
	WEAPON_GOLFCLUB = 1000,
	WEAPON_CROWBAR = 1000,
	WEAPON_PETROLCAN = 1000,
	WEAPON_FIREEXTINGUISHER = 1000,
	WEAPON_BALL = 1000,
	WEAPON_DAGGER = 1000,
	WEAPON_SWEAPON_SNOWBALLTUNGUN = 1000,
	WEAPON_GARBAGEBAG = 1000,
	WEAPON_HANDCUFFS = 1000,
	WEAPON_KNUCKLE = 1000,
	WEAPON_HATCHET = 1000,
	WEAPON_MACHETE = 1000,
	WEAPON_SWITCHBLADE = 1000,
	WEAPON_BATTLEAXE = 1000,
	WEAPON_POOLCUE = 1000,
	WEAPON_FLASHLIGHT = 1000,
	WEAPON_FLAREGUN = 1000,
	WEAPON_PISTOL = 1000,
	WEAPON_COMBATPISTOL = 1000, -- poid poir une munnition
	WEAPON_APPISTOL = 1000,
	WEAPON_PISTOL50 = 1000,
	WEAPON_COMBATPDW = 1000,
	WEAPON_MARKSMANPISTOL = 1000,
	WEAPON_SNSPISTOL = 1000,
	WEAPON_HEAVYPISTOL = 1000,
	WEAPON_REVOLVER = 1000,
	WEAPON_VINTAGEPISTOL = 1000,
	WEAPON_STUNGUN = 1000,
	WEAPON_FIREWORK = 1000,
	WEAPON_MINISMG = 1000,
	WEAPON_SMG = 1000,
	WEAPON_MICROSMG = 1000,
	WEAPON_ASSAULTSMG = 1000,
	WEAPON_PUMPSHOTGUN = 1000,
	WEAPON_AUTOSHOTGUN = 1000,
	WEAPON_DBSHOTGUN = 1000,
	WEAPON_ASSAULTSHOTGUN = 1000,
	WEAPON_SAWNOFFSHOTGUN = 1000,
	WEAPON_HEAVYSHOTGUN = 1000,
	WEAPON_MUSKET = 1000,
	WEAPON_COMPACTRIFLE = 1000,
	WEAPON_MARKSMANRIFLE = 1000,
	WEAPON_SPECIALCARBINE = 1000,
	WEAPON_ADVANCEDRIFLE = 1000,
	WEAPON_CARBINERIFLE = 1000,
	WEAPON_ASSAULTRIFLE = 1000,
	WEAPON_BALL = 1000,
	WEAPON_MG = 1000,
	WEAPON_COMBATMG = 1000,
	WEAPON_BULLPUPRIFLE = 1000,
	WEAPON_BULLPUPSHOTGUN = 1000,
	WEAPON_HEAVYSNIPER = 1000,
	WEAPON_SNIPERRIFLE = 1000,
	WEAPON_FLARE = 1000,
	---WEAPONS----
	
	--- MONEY ---
	black_money = 1, -- poids pour un argent
	--- MONEY ---
}

Config.VehicleLimit = {
    [0] = 200000, --Compact
    [1] = 400000, --Sedan
    [2] = 700000, --SUV
    [3] = 250000, --Coupes
    [4] = 300000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 50000, --Sports
    [7] = 20000, --Super
    [8] = 10000, --Motorcycles
    [9] = 1800000, --Off-road
    [10] = 3000000, --Industrial
    [11] = 700000, --Utility
    [12] = 1000000, --Vans
    [13] = 0, --Cycles
    [14] = 50000, --Boats
    [15] = 200000, --Helicopters
    [16] = 300000, --Planes
    [17] = 400000, --Service
    [18] = 400000, --Emergency
    [19] = 0, --Military
    [20] = 3000000, --Commercial
    [21] = 0, --Trains
}
