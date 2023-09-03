
-- init.lua is the entry point of every mod

local mod = {
	id = "hedera_voidscrapers",
	name = "Voidscrapers",
	version = "1.1.0",
	requirements = {},
	modApiVersion = "2.3.0",
	icon = "img/mod_icon.png"
}

function mod:init()
	if modApiExt then
		-- modApiExt already defined. This means that the user has the complete
		-- ModUtils package installed. Use that instead of loading our own one.
		Hedera_Voidscrapers_ModApiExt = modApiExt
	else
		-- modApiExt was not found. Load our inbuilt version
		local extDir = self.scriptPath.."modApiExt/"
		Hedera_Voidscrapers_ModApiExt = require(extDir.."modApiExt")
		Hedera_Voidscrapers_ModApiExt:init(extDir)
	end
	
	-- look in template/mech to see how to code mechs.
	require(self.scriptPath .."achievements")
	require(self.scriptPath .."palettes")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."animations")
	require(self.scriptPath .."weapons")
	if modApi.achievements:isComplete(mod.id,"VS_Final") then
		local pilot = require(self.scriptPath .."pilot")
		pilot:init(mod)
		require(self.scriptPath.."replaceRepair/replaceRepair")
	end
	
	modApi:appendAsset("img/effects/explo_consume.png",self.resourcePath.."img/effects/explo_consume.png")
	modApi:appendAsset("img/effects/explo_shine_small.png",self.resourcePath.."img/effects/explo_shine_small.png")
	modApi:appendAsset("img/units/player/voidscrapers_palette_2.png",self.resourcePath.."img/units/turtle/voidscrapers_palette_2.png")
	
	if modApi.achievements:isComplete(mod.id,"VS_BossKill") then
		modApi:addWeaponDrop("SS_Clapcannon")
	end
	if modApi.achievements:isComplete(mod.id,"VS_MassMove") then
		modApi:addWeaponDrop("SS_CrushPull")
	end
	if modApi.achievements:isComplete(mod.id,"VS_TripleKill") then
		modApi:addWeaponDrop("SS_PrecisionShot")
	end
end

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
