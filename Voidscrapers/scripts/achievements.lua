local mod = modApi:getCurrentMod()
local modId = "hedera_voidscrapers"

-- big thanks to the Vextras team (especially NAH) for helping me set this up
-- and letting me blatantly steal all this code lmao

local achievements = {
	VS_BossKill = modApi.achievements:add{
		id = "VS_BossKill",
		name = "Like a Boss",
		tooltip = "Kill a Leader Vek on the first turn with the Void Grip",
		image = mod.resourcePath.."img/achievements/voidscrapers_chievo1.png",
		objective = 1,
		squad = "Voidscrapers",
	},

	VS_MassMove = modApi.achievements:add{
		id = "VS_MassMove",
		name = "All Together Now",
		tooltip = "Move 4 Vek at once with the Inversion Mortar",
		image = mod.resourcePath.."img/achievements/voidscrapers_chievo2.png",
		objective = 1,
		squad = "Voidscrapers",
	},
	
	VS_TripleKill = modApi.achievements:add{
		id = "VS_TripleKill",
		name = "Playing With Power",
		tooltip = "Kill 3 Vek at once with the Flux Caster",
		image = mod.resourcePath.."img/achievements/voidscrapers_chievo3.png",
		objective = 1,
		squad = "Voidscrapers",
	},
}

local fluxAttack = false
local fluxCount = 0

function FireChevio(id)
	local complete = modApi.achievements:isComplete(modId,id)
	if complete then return end
	modApi.achievements:trigger(modId,id)
end

local function isGame()
	return true
		and Game ~= nil
		and GAME ~= nil
end

local function isMission()
	local mission = GetCurrentMission()

	return true
		and isGame()
		and mission ~= nil
		and mission ~= Mission_Test
end

local function isMissionBoard()
	return true
		and isMission()
		and Board ~= nil
		and Board:IsTipImage() == false
end

local HOOK_SkillStart = function(mission, pawn, weaponId, p1, p2)
	if weaponId:find("SS_PrecisionShot") then
		fluxAttack = true
	end
end

local function HOOK_PawnKilled(mission, pawn)
	if isMissionBoard() then
		if not achievements.VS_TripleKill:isComplete() then
			if fluxAttack then
				 fluxCount = fluxCount + 1
				 if fluxCount >= 3 then
					FireChevio("VS_TripleKill")
				 end
			end
		end
	end
end

local HOOK_SkillEnd = function(mission, pawn, weaponId, p1, p2)
		modApi:scheduleHook(500, function()
			if weaponId:find("SS_PrecisionShot") then
				fluxAttack = false
				fluxCount = 0
			end
		end)
end

-- AddHooks
local function EVENT_onModsLoaded()
	
	modapiext:addPawnKilledHook(HOOK_PawnKilled)
	modapiext:addSkillEndHook(HOOK_SkillEnd)
	modapiext:addSkillStartHook(HOOK_SkillStart)
	
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

-- Sub / Unsub to Events
local function SquadEntered(modId)
    if modId == squad then
        -- Progress
        modapiext.events.onPawnKilled:subscribe(HOOK_PawnKilled)
        modapiext.events.onSkillStart:subscribe(HOOK_SkillStart)
        modapiext.events.onSkillEnd:subscribe(HOOK_SkillEnd)
    end
end

local function SquadExited(modId)
    if modId == squad then
        -- Progress
        modapiext.events.onPawnKilled:unsubscribe(HOOK_PawnKilled)
        modapiext.events.onSkillStart:unsubscribe(HOOK_SkillStart)
        modapiext.events.onSkillEnd:unsubscribe(HOOK_SkillEnd)
    end
end

modApi.events.onSquadEnteredGame:subscribe(SquadEntered)
modApi.events.onSquadExitedGame:subscribe(SquadExited)