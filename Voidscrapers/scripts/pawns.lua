
local mod = modApi:getCurrentMod()
local autoOffset = 0
local id = modApi:getPaletteImageOffset(mod.id)
if id ~= nil then
	autoOffset = id
end
-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- locate our mech assets.
local mechPath = path .."img/units/flux/"

-- make a list of our files.
local files = {
	"mech.png",
	"mech_a.png",
	"mech_w.png",
	"mech_w_broken.png",
	"mech_broken.png",
	"mech_ns.png",
	"mech_h.png"
}

-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/flux_".. file, mechPath .. file)
end

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.flux_mech =			a.MechUnit:new{Image = "units/player/flux_mech.png", PosX = -20, PosY = -10} 
a.flux_mecha =			a.MechUnit:new{Image = "units/player/flux_mech_a.png", PosX = -21, PosY = 0, NumFrames = 4 }
a.flux_mechw =			a.MechUnit:new{Image = "units/player/flux_mech_w.png", PosX = -20, PosY = 6 } 
a.flux_mech_broken =	a.MechUnit:new{Image = "units/player/flux_mech_broken.png", PosX = -20, PosY = 0 }
a.flux_mechw_broken =	a.MechUnit:new{Image = "units/player/flux_mech_w_broken.png", PosX = -21, PosY = 6 }
a.flux_mech_ns =		a.MechIcon:new{Image = "units/player/flux_mech_ns.png"}

mechPath = path .."img/units/orbit/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/orbit_".. file, mechPath .. file)
end

a.orbit_mech =			a.MechUnit:new{Image = "units/player/orbit_mech.png", PosX = -20, PosY = -6} 
a.orbit_mecha =			a.MechUnit:new{Image = "units/player/orbit_mech_a.png", PosX = -21, PosY = -13, NumFrames = 4 }
a.orbit_mechw =			a.MechUnit:new{Image = "units/player/orbit_mech_w.png", PosX = -19, PosY = -7 } 
a.orbit_mech_broken =	a.MechUnit:new{Image = "units/player/orbit_mech_broken.png", PosX = -22, PosY = -13  }
a.orbit_mechw_broken =	a.MechUnit:new{Image = "units/player/orbit_mech_w_broken.png", PosX = -19, PosY = -7 }
a.orbit_mech_ns =		a.MechIcon:new{Image = "units/player/orbit_mech_ns.png"}

mechPath = path .."img/units/turtle/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/turtle_".. file, mechPath .. file)
end

a.turtle_mech =			a.MechUnit:new{Image = "units/player/turtle_mech.png", PosX = -23, PosY = -2} 
a.turtle_mecha =			a.MechUnit:new{Image = "units/player/turtle_mech_a.png", PosX = -22, PosY = -21, NumFrames = 10, Time = 0.125 }
a.turtle_mechw =			a.MechUnit:new{Image = "units/player/turtle_mech_w.png", PosX = -24, PosY = -14, NumFrames = 10, Time = 0.125 } 
a.turtle_mech_broken =	a.MechUnit:new{Image = "units/player/turtle_mech_broken.png", PosX = -23, PosY = -21 }
a.turtle_mechw_broken =	a.MechUnit:new{Image = "units/player/turtle_mech_w_broken.png", PosX = -24, PosY = -12 }
a.turtle_mech_ns =		a.MechIcon:new{Image = "units/player/turtle_mech_ns.png"}


VS_FluxMech = Pawn:new{
	Name = "Flux Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "flux_mech", 
	
	
	-- ImageOffset specifies which color scheme we will be using.
	-- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = autoOffset,

	SkillList = { "SS_PrecisionShot"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

VS_OrbitMech = Pawn:new{
	Name = "Orbit Mech",
	Class = "Ranged",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Image = "orbit_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"SS_Clapcannon"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

VS_TurtleMech = Pawn:new{
	Name = "Palanquin Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 2,
	Massive = true,
	Image = "turtle_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"SS_CrushPull"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}