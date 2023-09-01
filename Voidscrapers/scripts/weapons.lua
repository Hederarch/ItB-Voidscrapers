
--[[
	some simple examples of how to start coding weapons.
	to test these weapons, you can - with this mod enabled - write in the console:
	
	weapon Weapon_Template
	weapon Weapon_Template2
	
	you can then look over the code below to see how they were made.
	you'll notice Weapon_Template looks cooler than Weapon_Template2.
	to find out more on why that is, you can look at
	Prime_Punchmech in ITB/scripts/weapons_prime.lua,
	and look at how the GetSkillEffect of this weapon is different.
]]


-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- add assets from our mod so the game can find them.
modApi:appendAsset("img/weapons/voidgrip_icon.png", path .."img/weapons/voidgrip_icon.png")
modApi:appendAsset("img/weapons/flipmortar_icon.png", path .."img/weapons/flipmortar_icon.png")
modApi:appendAsset("img/weapons/fluxgun_icon.png", path .."img/weapons/fluxgun_icon.png")

SS_Clapcannon = LineArtillery:new{
	Name = "Inversion Mortar",
	Class = "Ranged",
	Description = "Fires an implosive projectile which swaps and damages adjacent units.",
	ArtillerySize = 8,
	UpShot = "advanced/effects/shotup_swapother.png",
	Icon = "weapons/flipmortar_icon.png",
	Damage = 1,
	Shield = 0,
	Friendly = false,
	OnlyEmpty = false,
	Explosion = "",
	ExplosionCenter = "",
	ExplosionOuter = "",
	UpgradeList = { "Add Shield", "Ally Immune" },
	Upgrades = 2,
	UpgradeCost = { 2, 1 },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(3,1),
		Enemy2 = Point(1,1),
		Friendly = Point(2,0),
		Enemy3 = Point(2,2),
		Target = Point(2,1),
		Building = Point(2,1),
	},
}

local function IsTipImage()
    return Board:GetSize() == Point(6, 6)
end

function SS_Clapcannon:GetTargetArea(point)
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do
		for i = 2, self.ArtillerySize do
			local curr = Point(point + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			
			if not self.OnlyEmpty or not Board:IsBlocked(curr,PATH_GROUND) then
				ret:push_back(curr)
			end

		end
	end
	
	return ret
end

function SS_Clapcannon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,0)
	local targets = 0
	damage.iShield = self.Shield
	damage.sAnimation = "ExploRepulse1",
	ret:AddBounce(p1, 1)
	ret:AddArtillery(damage, self.UpShot)
	ret:AddBounce(p2, -8)
	for dir = DIR_START,DIR_END do
			local launch = p2 - DIR_VECTORS[dir]
			local land = p2 + DIR_VECTORS[dir]
			ret:AddBounce(launch,-4)
			if Board: IsPawnSpace(launch) and not Board:GetPawn(launch):IsGuarding()then
				if Board:IsValid(land) and ((Board: IsPawnSpace(land) and not Board:GetPawn(land):IsGuarding()) or (not Board: IsPawnSpace(land) and not Board:IsBlocked(land, PATH_FLYER)))  then
					local move = PointList()
					move:push_back(launch)
					move:push_back(land)
					ret:AddLeap(move, NO_DELAY)
					ret.effect:back().bHide = true
					targets = targets + 1
					LOG(targets)
				else
					local block = SpaceDamage(launch,0)
					block.sImageMark = "advanced/combat/icons/icon_throwblocked_glow.png"
					ret:AddDamage(block)
				end
			end
		end
	ret:AddDelay(0.8)
		-- i know checking all this again is horribly unoptimized, blame tatu
	for dir = DIR_START,DIR_END do
			local launch = p2 - DIR_VECTORS[dir]
			local land = p2 + DIR_VECTORS[dir]
			if Board:IsValid(land) and (Board: IsPawnSpace(launch) and not Board:GetPawn(launch):IsGuarding()) and ((Board: IsPawnSpace(land) and not Board:GetPawn(land):IsGuarding()) or (not Board: IsPawnSpace(land) and not Board:IsBlocked(land, PATH_FLYER)))  then
				local thump = SpaceDamage(land,self.Damage)
				if self.Friendly and Board:IsPawnTeam(launch,TEAM_PLAYER) then
					thump.iDamage = 0
				end
				ret:AddDamage(thump)
				ret:AddBounce(land,4)
				if not IsTipImage() and not IsTestMechScenario() then
					ret:AddScript(string.format("local pawn = Board:GetPawn(Point(%d,%d)) local here = pawn:GetSpace() pawn:SetSpace(Point(-1,-1)) modApi:scheduleHook(17, function() pawn:SetSpace(here) end)",land.x,land.y)) --tatu fixed this blame tatu <3
				end
				
			end
		end
	-- achievement trigger
	
	if not IsTipImage() and not IsTestMechScenario() and GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] == "Voidscrapers" and 
		not modApi.achievements:isComplete("hedera_voidscrapers", "VS_BossKill") and targets == 4 then
		ret:AddScript("local complete = modApi.achievements:isComplete(\"hedera_voidscrapers\",\"VS_MassMove\") if complete then return end modApi.achievements:trigger(\"hedera_voidscrapers\",\"VS_MassMove\")")
	end

	return ret
	
end

SS_Clapcannon_A = SS_Clapcannon:new{
	UpgradeDescription = "Shields the central tile that the artillery hits.",
	Shield = EFFECT_CREATE,
	
}

SS_Clapcannon_B = SS_Clapcannon:new{
	UpgradeDescription = "No longer damages allies.",
	Friendly = true,
	
}

SS_Clapcannon_AB = SS_Clapcannon:new{
	Shield = EFFECT_CREATE,
	Friendly = true,
	
}
SS_CrushPull = TankDefault:new{
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Name = "Void Grip",
	Icon = "weapons/voidgrip_icon.png",
	Description = "Pulls and damages a far-away unit, or consumes an adjacent unit and creates cracks.",
	Explo = "explopush1_",
	Class = "Prime",
	PowerCost = 2,
	Damage = 1,
	Heal = false,
	ZoneTargeting = ZONE_DIR,
	UpgradeList = { "Digestion", "+1 Damage" },
	Upgrades = 2,
	UpgradeCost = { 2, 1 },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,0),
		Target = Point(2,0),
		Second_Origin = Point(2,3),
		Second_Target = Point(2,2)
	},
}

function SS_CrushPull:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	if p1:Manhattan(p2) == 1 and Board:IsPawnSpace(p1) then
		
		local consume = SpaceDamage(p2,DAMAGE_DEATH)
		consume.sAnimation = "ExploConsume"
		-- achievement trigger
		if not IsTipImage() and not IsTestMechScenario() and Board:IsPawnSpace(p2) and GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] == "Voidscrapers" and 
		not modApi.achievements:isComplete("hedera_voidscrapers", "VS_BossKill") and
		_G[Board:GetPawn(p2):GetType()].Tier == TIER_BOSS and Board:GetTurn() == 1 then
		
			ret:AddScript("local complete = modApi.achievements:isComplete(\"hedera_voidscrapers\",\"VS_BossKill\") if complete then return end modApi.achievements:trigger(\"hedera_voidscrapers\",\"VS_BossKill\")")
		end
		ret:AddMelee(p1,consume,NO_DELAY)
		for dir = DIR_START,DIR_END do
			local gust = SpaceDamage(p2 - DIR_VECTORS[dir],0)
			gust.bHide = true
			gust.sAnimation = "airpush_".. dir
			ret:AddDamage(gust)
		end
		local crack = SpaceDamage(p1,0)
		if self.Heal and Board:IsPawnSpace(p2) then
			crack.iDamage = -1
		end
		crack.iCrack = EFFECT_CREATE
		ret:AddDamage(crack)
		ret:AddBounce(p2,5)
	else
		local target = GetProjectileEnd(p1,p2)
		local direction = GetDirection(p2 - p1)
		if Board:IsPawnSpace(target) then
			if Board:GetPawn(target):IsGuarding() then
				local fake = SpaceDamage(p1 - DIR_VECTORS[direction],0)
				ret:AddMelee(p1,fake,NO_DELAY)
				local damage = SpaceDamage(target,self.Damage)
				damage.sAnimation = "airpush_".. GetDirection(p1 - p2)
				ret:AddDamage(damage)
			else
				local fake = SpaceDamage(p1 - DIR_VECTORS[direction],0)
				ret:AddMelee(p1,fake,NO_DELAY)
				ret:AddCharge(Board:GetSimplePath(target, p1 + DIR_VECTORS[direction]), FULL_DELAY)
				local damage = SpaceDamage(p1 + DIR_VECTORS[direction],self.Damage)
				damage.sAnimation = "airpush_".. GetDirection(p1 - p2)
				ret:AddDamage(damage)
				ret:AddBounce(p1 + DIR_VECTORS[direction],5)
			end
		end
	end
	return ret
end

SS_CrushPull_A = SS_CrushPull:new{
	UpgradeDescription = "Heals the user when consuming an adjacent unit.",
	Heal = true,
}
SS_CrushPull_B = SS_CrushPull:new{
	UpgradeDescription = "Deals 1 additional damage when pulling.",
	Damage = 2,
}
SS_CrushPull_AB = SS_CrushPull:new{
	Heal = true,
	Damage = 2,
}

SS_PrecisionShot = Skill:new	{
	Name = "Flux Caster",
	Description = "Fires a projectile which phases through obstacles, then explodes.",
	Class = "Brute",
	Damage = 1,
	EdgeDamage = 0,
	BuildingDamage = true,
	Icon = "weapons/fluxgun_icon.png",
	Sound = "/general/combat/explode_small",
	ProjectileArt = "effects/shot_phaseshot",
	UpShot = "effects/shotup_grid.png",
	PowerCost = 0, --AE Change
	UpgradeList = { "+1 Damage", "Building Immune" },
	Upgrades = 2,
	UpgradeCost = { 2, 1 },
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(2,0),
		Target = Point(2,1),
		Mountain = Point(2,3),
	},
	ZoneTargeting = ZONE_DIR,
}

function SS_PrecisionShot:GetTargetArea(p1)
	local ret = PointList()

	for dir = DIR_START, DIR_END do
		for i = 1, 8 do
			local curr = Point(p1 + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			
			ret:push_back(curr)
		end
	end

	return ret
end

function SS_PrecisionShot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local reverse = GetDirection(p1 - p2)
	
	local damage = SpaceDamage(p2,self.Damage)
	damage.bHide = false
	damage.sAnimation = "explo_fire1"
	if not self.BuildingDamage and Board:IsBuilding(p2) then
		damage.iDamage = DAMAGE_ZERO
		damage.sAnimation = "ExploRepulse2"
	end
	for i = 0, p1:Manhattan(p2) do
		local spark = SpaceDamage(p1 + DIR_VECTORS[direction] * i,0)
		spark.sAnimation = "ExploShineSmall"
		ret:AddDamage(spark)
		ret:AddDelay(0.15)
	end
	ret:AddDamage(damage)
	ret:AddBounce(p2,4)
	
	local forward = SpaceDamage(p2 + DIR_VECTORS[direction],self.EdgeDamage,direction)
	forward.sAnimation = "airpush_"..direction
	if self.EdgeDamage > 0 then
		forward.sAnimation = "explopush1_"..direction
	end
	if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[direction]) then
		forward.iDamage = DAMAGE_ZERO
		forward.sAnimation = "airpush_"..direction
	end
	ret:AddDamage(forward)
	local backward = SpaceDamage(p2 + DIR_VECTORS[reverse],self.EdgeDamage,reverse)
	backward.sAnimation = "airpush_"..reverse
	if self.EdgeDamage > 0 then
		backward.sAnimation = "explopush1_"..reverse
	end
	if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[reverse]) then
		backward.iDamage = DAMAGE_ZERO
		backward.sAnimation = "airpush_"..reverse
	end
	ret:AddDamage(backward)
	return ret
end

SS_PrecisionShot_A = SS_PrecisionShot:new{
	UpgradeDescription = "Deals 1 additional damage.",
	Damage = 2,
	EdgeDamage = 1,
}

SS_PrecisionShot_B = SS_PrecisionShot:new{
	UpgradeDescription = "No longer damages Buildings.",
	BuildingDamage = false,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,2),
		Building = Point(2,1),
		Enemy3 = Point(2,0),
		Target = Point(2,1),
		Mountain = Point(2,3),
	},
}

SS_PrecisionShot_AB = SS_PrecisionShot:new{
	BuildingDamage = false,
	Damage = 2,
	EdgeDamage = 1,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,2),
		Building = Point(2,1),
		Enemy3 = Point(2,0),
		Target = Point(2,1),
		Mountain = Point(2,3),
	},
}

function FireChevio(id)
	local complete = modApi.achievements:isComplete(modId,id)
	if complete then return end
	modApi.achievements:trigger(modId,id)
end