local version = {Major = "2", Minor = "45", Patch = ""}

local function load(data)
	ExtraBirthright = RegisterMod( "Extra Birthright Effects", 1 );
	local mod = ExtraBirthright
	local ExtraBirthrightLocal = {}
	if data then
		mod.Version = data.Version or version
		mod.fliped = data.fliped or {}
		mod.BirthrightfloorBought = data.BirthrightfloorBought or false
		mod.IsRunLoaded = data.IsRunLoaded or false
		mod.PlayerData = data.PlayerData or {}
		mod.FamiliarData = data.FamiliarData or {}
		mod.VisitedRooms = data.VisitedRooms or {}
		mod.MCMOption = data.MCMOption
		mod.MCMTCainBirthright = data.MCMTCainBirthright
	else
		mod.Version = version
		mod.fliped = {}
		mod.BirthrightfloorBought = false
		mod.IsRunLoaded = false
		mod.PlayerData = {}
		mod.FamiliarData = {}
		mod.VisitedRooms = {}
	end
	local json = require("json")
	mod.RNG = RNG()
	mod.COLLECTIBLE_BIRTHRIGHT = Isaac.GetItemIdByName("Birthright (Alt)")
	mod.IsModLoaded = false

	mod.shootDirecton = {
		[Direction.NO_DIRECTION] = Vector(0,0),
		[Direction.LEFT] = Vector(-1, 0),
		[Direction.UP] = Vector(0, -1),
		[Direction.RIGHT] = Vector(1, 0),
		[Direction.DOWN] = Vector(0, 1)
	}

	include("scripts/helpFuncs.lua")
	include("scripts/api.lua")
	include("scripts/eid.lua")
	include("scripts/encyclopedia.lua")
	include("scripts/ModConfig.lua")
	include("scripts/imgui.lua")
	include("scripts/cmd.lua")
	if not REPENTOGON then
		mod.CustomCallbacks = data.CustomCallbacks or include("scripts/ReviveAPI.lua")
	end

	include("scripts/characters/normal/isaac.lua")
	include("scripts/characters/normal/maggie.lua")
	include("scripts/characters/normal/cain.lua")
	include("scripts/characters/normal/judas.lua")
	include("scripts/characters/normal/judasblack.lua")
	include("scripts/characters/normal/bb.lua")
	include("scripts/characters/normal/eve.lua")
	include("scripts/characters/normal/samson.lua")
	include("scripts/characters/normal/azazel.lua")
	include("scripts/characters/normal/eden.lua")
	include("scripts/characters/normal/lost.lua")
	include("scripts/characters/normal/lazarus.lua")
	include("scripts/characters/normal/lilith.lua")
	include("scripts/characters/normal/keeper.lua")
	include("scripts/characters/normal/apollyon.lua")
	include("scripts/characters/normal/forgotten.lua")
	include("scripts/characters/normal/soul.lua")
	include("scripts/characters/normal/bethany.lua")
	include("scripts/characters/normal/esau.lua")
	include("scripts/characters/tainted/isaac.lua")
	include("scripts/characters/tainted/maggie.lua")
	include("scripts/characters/tainted/cain.lua")
	include("scripts/characters/tainted/judas.lua")
	include("scripts/characters/tainted/bb.lua")
	include("scripts/characters/tainted/eve.lua")
	include("scripts/characters/tainted/samson.lua")
	include("scripts/characters/tainted/azazel.lua")
	include("scripts/characters/tainted/eden.lua")
	include("scripts/characters/tainted/lost.lua")
	include("scripts/characters/tainted/lazarus.lua")
	include("scripts/characters/tainted/lilith.lua")
	include("scripts/characters/tainted/keeper.lua")
	include("scripts/characters/tainted/apollyon.lua")
	include("scripts/characters/tainted/forgotten.lua")
	include("scripts/characters/tainted/bethany.lua")
	include("scripts/characters/tainted/jacob.lua")

	--#region Saving
	function ExtraBirthrightLocal:SaveSomeData(isSaving, isUnloading)
		local saveBirthright = {}
		if isSaving then
			saveBirthright.PlayerData = mod.PlayerData
			saveBirthright.FamiliarData = mod.FamiliarData
			saveBirthright.BirthrightfloorBought = mod.BirthrightfloorBought
			saveBirthright.VisitedRooms = mod.VisitedRooms
		end

		saveBirthright.ModConfigMenu = mod.MCMOption
		saveBirthright.BirthrightStealChance = mod.MCMTCainBirthright["BirthrightYoink"]
		saveBirthright.Version = mod.Version
		mod:SaveData(json.encode(saveBirthright))
		mod.IsRunLoaded = isUnloading == true
	end
	mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, ExtraBirthrightLocal.SaveSomeData)
	mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
		ExtraBirthrightLocal:SaveSomeData(true, true)
	end)
	--#endregion

	--#region Loading
	function ExtraBirthrightLocal:LoadItBack(isContinued)
		mod.BirthrightfloorBought = false
		mod.VisitedRooms = {}
		mod.PlayerData = {}
		mod.FamiliarData = {}
		if mod:HasData() then
			local loadBirthright = json.decode(mod:LoadData())
			if isContinued then
				mod.PlayerData = loadBirthright.PlayerData
				mod.FamiliarData = loadBirthright.FamiliarData
				mod.BirthrightfloorBought = loadBirthright.BirthrightfloorBought or false
				mod.VisitedRooms = loadBirthright.VisitedRooms or {}
			end
			if loadBirthright.ModConfigMenu then
				local settings = loadBirthright.ModConfigMenu
				if settings.Name then
					for k,v in ipairs(settings.Name) do
						mod.MCMOption.Name[k] = v
					end
				end
				if settings.OptionsMaxNum then
					for k,v in pairs(settings.OptionsMaxNum) do
						mod.MCMOption.OptionsMaxNum[k] = v
					end
				end
				if settings.Settings then
					for k,v in pairs(settings.Settings) do
						mod.MCMOption.Settings[k] = v
					end
				end
				if settings.Labels then
					for k,v in pairs(settings.Labels) do
						mod.MCMOption.Labels[k] = v
					end
				end
			end
			if loadBirthright.BirthrightStealChance then
				mod.MCMTCainBirthright["BirthrightYoink"] = loadBirthright.BirthrightStealChance
			end
			mod:ReloadMCM()
			if REPENTOGON then
				mod:ReloadImGui()
			end
		end
		mod:BirthrightDesc()
		for _,player in ipairs(mod:GetPlayers()) do
			player:AddCacheFlags(CacheFlag.CACHE_ALL)
			player:EvaluateItems()
		end
		mod.IsRunLoaded = true
	end
	mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, ExtraBirthrightLocal.LoadItBack)
	--#endregion
	--#region Init
	function ExtraBirthrightLocal:Init(player)
		local data = mod.GetPersistentPlayerData(player)
		data.gotBirthright = true
		mod:BirthrightDesc()
	end
	mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, ExtraBirthrightLocal.Init)

	function ExtraBirthrightLocal:EvalData(player)
		local data = mod.GetPersistentPlayerData(player)
		data.BirthrightBloodBabyCooldown = data.BirthrightBloodBabyCooldown or 2
		data.TaintedCainPickedItem = data.TaintedCainPickedItem or false
		data.PocketItems = data.PocketItems or {}
		data.RageMeter = data.RageMeter or 0
	end
	mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, ExtraBirthrightLocal.EvalData)
	--#endregion

	function ExtraBirthrightLocal:UpdateTheRoom()
		local room = Game():GetRoom()
		mod.clearedroom = room:IsClear() and room:IsFirstVisit()
	end
	mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, ExtraBirthrightLocal.UpdateTheRoom)

	function ExtraBirthrightLocal:RemovePersistenData(entity)
		mod.RemovePersistentPlayerData(entity)
	end
	mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, ExtraBirthrightLocal.RemovePersistenData, EntityType.ENTITY_PLAYER)

	Isaac.DebugString("Extra Birthright Effects loaded. Version ".. mod.Version.Major.."."..mod.Version.Minor..mod.Version.Patch)
	print("Extra Birthright Effects loaded. Version ".. mod.Version.Major.."."..mod.Version.Minor..mod.Version.Patch)
	print("Use 'extrabirthright help' command to see other console commands")
	mod.IsModLoaded = true
end

local function ExportPersitentData(exportMod)
	local mod = {}
	mod.fliped = exportMod.fliped
	mod.BirthrightfloorBought = exportMod.BirthrightfloorBought
	mod.IsRunLoaded = exportMod.IsRunLoaded

	mod.MCMOption = exportMod.MCMOption
	mod.MCMTCainBirthright = exportMod.MCMTCainBirthright
	mod.PlayerData = exportMod.PlayerData
	mod.FamiliarData = exportMod.FamiliarData

	mod.VisitedRooms = exportMod.VisitedRooms
	return mod
end

if ExtraBirthright then
	local function NewVersionCheck(oldVersion)
		if oldVersion == nil or oldVersion.Major == nil or oldVersion.Minor == nil then
			return true
		end
		local reset = false or tonumber(oldVersion.Major) < tonumber(version.Major)
		reset = reset or tonumber(oldVersion.Minor) < tonumber(version.Minor)
		reset = oldVersion.Patch ~= "" and version.Patch ~= "" and oldVersion.Patch < version.Patch or oldVersion.Patch == "" and version.Patch ~= ""
		return reset
	end
	if ExtraBirthright.IsModLoaded and NewVersionCheck(ExtraBirthright.Version) or not ExtraBirthright.IsModLoaded or ExtraBirthright.ResetMod then
		local exportData = ExportPersitentData(ExtraBirthright)
		ExtraBirthright = nil
		load(exportData)
		ExtraBirthright:ReloadMCM()
		if REPENTOGON then
			ExtraBirthright:ReloadImGui()
		end
	end
else
	load()
end