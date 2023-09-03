local this={}

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- read out other files and add what they return to variables.
local mod = modApi:getCurrentMod()
local scriptPath = modApi:getCurrentMod().scriptPath
local replaceRepair = require(scriptPath.."replaceRepair/replaceRepair")
local tooltips = require(path .."scripts/libs/tooltip")
local personalities = require(path .."scripts/libs/personality")
local dialog = require(path .."scripts/dialog")

local VS_pilot = {
	Id = "VS_Maw",					-- id must be unique. Used to link to art assets.
	Personality = "VS_Maw",        -- must match the id for a personality you have added to the game.
	Name = "M.A.W.",
	Rarity = 2,
	PowerCost = 1,
	Voice = "/voice/ai",				-- audio. look in pilots.lua for more alternatives.
	Skill = "VoidKill",				-- pilot's ability - Must add a tooltip for new skills.
}

CreatePilot(VS_pilot)

-- add assets - notice how the name is identical to pilot.Id
	modApi:appendAsset("img/portraits/pilots/VS_Maw.png", path .."img/portraits/VS_Maw.png")
	modApi:appendAsset("img/portraits/pilots/VS_Maw_2.png", path .."img/portraits/VS_Maw_2.png")
	modApi:appendAsset("img/portraits/pilots/VS_Maw_blink.png", path .."img/portraits/VS_Maw_blink.png")

function this:init(mod)

	replaceRepair:addSkill{
		Name = "Voidscrape",
		Description = "Instead of repairing, kills an adjacent unit.",
		weapon = "VoidKill",
		pilotSkill = "VoidKill",
		Icon = "img/weapons/maw_repair.png",
		IsActive = function(pawn)
			return pawn:IsAbility(VS_pilot.Skill)
		end
	}

	---- Skill ----
	VoidKill = Skill:new{
		Name = "Voidscrape",
		Description = "Instead of repairing, kills an adjacent unit.",
		Icon = "img/weapons/maw_repair.png",
		PathSize = 1, --This does the TargetArea on its own, no need for our own
		TipImage = {
			Unit = Point(2,2),
			Enemy = Point(2,1),
			Target = Point(2,1),
			CustomEnemy = "FireflyBoss",
		}
	}
	
	function VoidKill:GetSkillEffect(p1, p2)
		local ret = SkillEffect()
		local damage = SpaceDamage(p2, DAMAGE_DEATH)
		local crakc
		damage.sAnimation = "ExploConsume"
		ret:AddMelee(p1,damage,NO_DELAY)
		for dir = DIR_START,DIR_END do
			local gust = SpaceDamage(p2 - DIR_VECTORS[dir],0)
			gust.bHide = true
			gust.sAnimation = "airpush_".. dir
			ret:AddDamage(gust)
		end
		local crack = SpaceDamage(p1,0)
		ret:AddDamage(crack)
		ret:AddBounce(p2,5)
		return ret
	end
end

local personality = personalities:new{ Label = "VS_Maw" }

-- add dialog to personality.
personality:AddDialog(dialog)

-- add personality to game - notice how the id is the same as pilot.Personality
Personality["VS_Maw"] = personality



return this
