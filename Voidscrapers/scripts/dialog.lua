
-- Adds a personality without the use of a csv file.
-- Table of responses to various triggers.
return {
	-- Game States
	Gamestart = {"M-mass Annihilation unit online.","Singularity s-stabilized. Please insert power core.","Forgive me if I misspeak... I'm having s-some inteference..."},
	FTL_Found = {"Something's in that pod... S-should I kill it?"},
	--FTL_Start = {},
	Gamestart_PostVictory = {"Mass Annihilation unit online."},
	Death_Revived = {"7TDfuK+@]?u9-?]... N-nevermind, I'm okay."},
	Death_Main = {"8K^K&6VC!GTHIS)SUCKS7j(2k7787o<C9:","6Z6ja@;0UrAS!OUCH4AmoCiBl7Q7+D#_)@s)4%AKYl/G9H", "Containment f-f-failing... evacuate now."},
	Death_Response = {"7rN<V@X2N;+BN #main_second ,%Cht52Ble><H#IgX"},
	Death_Response_AI = {"<+ohc@<H[1E+s-,IT'SF=2,PA8cGONE[0+T","The autopilot has failed."},
	TimeTravel_Win = {"I... did it? I did it!"},
	Gameover_Start = {"G@bT,+D,b+CG$`OBOQ!1F!,CEATBC","G@_n5Df^O+D5hBFR","Blk_D+E)F7E\8JYALDY4+Dbt;F=m","Even I c-can't destroy them all..."},
	Gameover_Response = {"G@bT,+D,b+CG$`OBOQ!1F!,CEATBC","G@_n5Df^O+D5hBFR","Blk_D+E)F7E\8JYALDY4+Dbt;F=m"},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"<+o]XCNICEX","I could do better.","It's wasted power.",},
	Upgrade_NoWeapon = {"I don't n-need them. I AM the weapon!","You understand m-m-my power."},
	Upgrade_PowerGeneric = {"<+o]^+EqaEPOWERCND*","I grow stronger."},
	
	-- Mid-Battle
	MissionStart = {"CM@U$+DY\-C`mM-Cht50Bl%S","6q($R;GUF=","L-lowering containment fields...","1_fKILLN+B1#9KILLcu_q9H[tKILL5s:/=hKILL[8PVb","BOQ'uDJ()5Df'% ...everyone hear me? I'm having s-some inteference..."},
	Mission_ResetTurn = {"C-containment holding...","Cont6Z6ja@;0UrAainmentSuT4AmoCiBl7stableQ9/hR","Keep it togethFDkf'FD,6+er..."},
	MissionEnd_Dead = {"No vek remain. I have done what I m-m-must.","A thorough killing... I guess..."},
	MissionEnd_Retreat = {"VEK78lQ>:e=DP+T",";FOP_76smE:.G Vek!","9hA8^8P`)FAILURE(7R9U><Dl6"},

	MissionFinal_Start = {"T-there's no power. 20 minutes until singularity destabilizes...","T-there's no power. S-soon... I'll..."},
	MissionFinal_StartResponse = {"BOt^cEa^))F!INCOMING,@=F<G:8FDi:FDfTC","F_Dn9BH\PYLON;H#.D:+EV=7AK_"},
	--MissionFinal_FallStart = {},
	MissionFinal_FallResponse = {"F-f-failing!","85Do^+DOWN(g&;u?!?!"},
	--MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"Even I c-can't destroy them all..."},
	--MissionFinal_BombResponse = {},
	MissionFinal_CaveStart = {"This will... stop them? D-d-defend that bomb!","Everyone! Defend the b-b-bomb!"},
	--MissionFinal_BombDestroyed = {},
	MissionFinal_BombArmed = {"1_fKILLN+B1#9KILLcu_q9H[tKILL5s:/=hKILL[8PVb","It's r-ready! Get out!"},

	PodIncoming = {"DJsVPOD>G&MD4+PODDDs;Ec5f/F(GPOD","D-does anyone else hear that falling sound...?"},
	PodResponse = {"E,T80AoDg0A0>iGOTit0A0>K&F`(^","S-someone else grab that! I don't want to break it..."},
	PodCollected_Self = {"I-I've got it! Gently now...",":esSO78GOTITd&,<(KG#:eI.THINKsI"},
	PodDestroyed_Obs = {"9j'eFUK6i","Did I d-do that...?","Uh oh... t-the pod..."},
	Secret_DeviceSeen_Mountain = {";b9JS5tiBREAK(THE)MOUNTAINiba<'a)N"},
	Secret_DeviceSeen_Ice = {";b9JS5tiBREAK[THE]1CE<'a)N"},
	Secret_DeviceUsed = {"BlkJ.Bk/UPLINK?-Df''-BPD?s/hSa"},
	Secret_Arriving = {"D-does anyone else hear that falling sound...?"},
	Emerge_Detected = {"<(KG\-3HELP,jTHERE'S&MORE73G)u:K:.X","T-there's more?!"},
	Emerge_Success = {"T-there's more?!","T-there's more..."},
	Emerge_FailedMech = {":K9bQ+@]OUCH?u9-@2)5u[","That hurt... rude!"},
	Emerge_FailedVek = {"83od3HAHAH_Ad4834","N-no need to shove..."},

	-- Mech State
	Mech_LowHealth = {"Keep it togethFDkf'FD,6+er...","8LI4HELPT6s3)V7jHELP(W%76sjHELP@+@npp","I'm okay... j-just need to rest a little."},
	Mech_Webbed = {"Hey! Rude!","G-get off me!",":I[er9go"},
	Mech_Shielded = {"T-thanks...","Containment stabilized... f-for now..."},
	Mech_Repaired = {"T-thanks..."},
	Pilot_Level_Self = {"Did I do a good job?"},
	Pilot_Level_Obs = {"2N;+BN #main_second ,%Cht5"},
	Mech_ShieldDown = {"Containment down... give me a s-second...","I'm okay! D-don't worry!","F(f9!Ch+HIT+CoD7D?"},

	-- Damage Done
	Vek_Drown = {"I guess that'll do...","I guess t-that'll do..."},
	Vek_Fall = {"I guess that'll do...","I guess t-that'll do..."},
	Vek_Smoke = {"Quickly! While it's confused!","That'll k-keep it calm..."},
	Vek_Frozen = {"That'll k-keep it calm...","...S-should I kill it?"},
	VekKilled_Self = {"CM@U$ARk","I did it!","T-take that!","T-thorough...","That's one..."},
	VekKilled_Obs = {"CM@U$ARk","N-nice.","That's one..."},
	VekKilled_Vek = {"83od3HAHAH_Ad4834","N-nice Vek?"},

	DoubleVekKill_Self = {"1_fKILLN+B1#9KILLcu_q9H[tKILL5s:/=hKILL[8PVb"},
	DoubleVekKill_Obs = {"I c-could've done that..."},
	DoubleVekKill_Vek = {"I c-could've done that...","N-nice Vek?"},

	MntDestroyed_Self = {"Oops!","Sorry... I didn't m-mean to!"},
	MntDestroyed_Obs = {"W-was that on purpose?","Blk_D+CoD.G5"},
	MntDestroyed_Vek = {"W-was that on purpose?","Blk_D+CoD.G5"},

	PowerCritical = {"T-there's barely any power. S-soon... I'll...","Come on grid... k-k-keep it together!"},
	Bldg_Destroyed_Self = {"Oh no. Oh no oh no oh;b0JO8P)KF8P)KF;u","I'm s-so sorry! I- I... 7o)Mq6pXOB+A#N"},
	Bldg_Destroyed_Obs = {"7o)Mq6pXOB+A#N","Oh no. No no no no.","b0JO8P)KFUCK8P)KF;u"},
	Bldg_Destroyed_Vek = {"Oh no. No no no no.","7o)Mq6pXOB+A#N"},
	Bldg_Resisted = {"It's okay? I-it's okay!","Phew... It's okay...","W-we did it? Its okay!"},


	-- Shared Missions
	--[[Mission_Train_TrainStopped = {},
	Mission_Train_TrainDestroyed = {},
	Mission_Block_Reminder = {},

	-- Archive
	Mission_Airstrike_Incoming = {},
	Mission_Tanks_Activated = {},
	Mission_Tanks_PartialActivated = {},
	Mission_Dam_Reminder = {},
	Mission_Dam_Destroyed = {},
	Mission_Satellite_Destroyed = {},
	Mission_Satellite_Imminent = {},
	Mission_Satellite_Launch = {},
	Mission_Mines_Vek = {},

	-- RST
	Mission_Terraform_Destroyed = {},
	Mission_Terraform_Attacks = {},
	Mission_Cataclysm_Falling = {},
	Mission_Lightning_Strike_Vek = {},
	Mission_Solar_Destroyed = {},
	Mission_Force_Reminder = {},

	-- Pinnacle
	Mission_Freeze_Mines_Vek = {},
	Mission_Factory_Destroyed = {},
	Mission_Factory_Spawning = {},
	Mission_Reactivation_Thawed = {},
	Mission_SnowStorm_FrozenVek = {},
	Mission_SnowStorm_FrozenMech = {},
	BotKilled_Self = {},
	BotKilled_Obs = {},

	-- Detritus
	Mission_Disposal_Destroyed = {},
	Mission_Disposal_Activated = {},
	Mission_Barrels_Destroyed = {},
	Mission_Power_Destroyed = {},
	Mission_Teleporter_Mech = {},
	Mission_Belt_Mech = {},]]
}