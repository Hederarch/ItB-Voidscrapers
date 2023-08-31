
-- init.lua is the entry point of every mod

local mod = {
	id = "hedera_voidscrapers",
	name = "Voidscrapers",
	version = "1.0.0",
	requirements = {},
	modApiVersion = "2.3.0",
	icon = "img/mod_icon.png"
}

function mod:init()
	-- look in template/mech to see how to code mechs.
	require(self.scriptPath .."palettes")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."animations")
	require(self.scriptPath .."weapons")
	
	modApi:appendAsset("img/effects/explo_consume.png",self.resourcePath.."img/effects/explo_consume.png")
	modApi:appendAsset("img/effects/explo_shine_small.png",self.resourcePath.."img/effects/explo_shine_small.png")
end

--New shop
    --modApi:addWeaponDrop("VS_Prime_Driver")
    --modApi:addWeaponDrop("VS_Ranged_ShieldArti")
    --modApi:addWeaponDrop("VS_Brute_Magnum")

function mod:load(options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Voidscrapers",		-- title
			"VS_TurtleMech",			-- mech #1
			"VS_OrbitMech",			-- mech #2
			"VS_FluxMech"			-- mech #3
		},
		"Voidscrapers",
		"Specialized mechs made to escort a powerful anomaly. Armed with implosive weaponry, they can crush Vek from the inside out.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
