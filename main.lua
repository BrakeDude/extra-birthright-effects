ExtraBirthright = RegisterMod( "Extra Birthright Effects", 1 );
local mod = ExtraBirthright
local ExtraBirthrightLocal = {}
mod.Version = "2.44"
local json = require("json")
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")
mod.fliped = {}
mod.BirthrightfloorBought = false
mod.RNG = RNG()

mod.Callbacks = {
	MC_POST_PLAYER_INIT = "MC_POST_PLAYER_INIT_TEDEN",
	MC_POST_PLAYER_UPDATE = "MC_POST_PLAYER_UPDATE_TEDEN",
	MC_POST_PEFFECT_UPDATE = "MC_POST_PEFFECT_UPDATE_TEDEN",
	MC_EVALUATE_CACHE = "MC_EVALUATE_CACHE_TEDEN",
	MC_PRE_USE_ITEM = "MC_PRE_USE_ITEM_TEDEN",
	MC_USE_ITEM = "MC_USE_ITEM_TEDEN",
	MC_USE_CARD = "MC_USE_CARD_TEDEN",
	MC_USE_PILL = "MC_USE_PILL_TEDEN",
	MC_ENTITY_TAKE_DMG = "MC_ENTITY_TAKE_DMG_TEDEN",
	MC_POST_NEW_LEVEL = "MC_POST_NEW_LEVEL_TEDEN",
	MC_POST_NEW_ROOM = "MC_POST_NEW_ROOM_TEDEN",
	MC_PRE_PLAYER_COLLISION = "MC_PRE_PLAYER_COLLISION_TEDEN",
	MC_PRE_PICKUP_COLLISION = "MC_PRE_PICKUP_COLLISION_TEDEN",
	MC_POST_NPC_DEATH = "MC_POST_NPC_DEATH_TEDEN",
	MC_PRE_SPAWN_CLEAN_AWARD = "MC_PRE_SPAWN_CLEAN_AWARD_TEDEN",
	MC_POST_GET_COLLECTIBLE = "MC_POST_GET_COLLECTIBLE_TEDEN",
	MC_POST_PICKUP_UPDATE = "MC_POST_PICKUP_UPDATE_TEDEN",
}

mod.PlayerData = {}
mod.FamiliarData = {}

mod.VisitedRooms = {}

mod.shootDirecton = {
	[Direction.NO_DIRECTION] = Vector(0,0),
	[Direction.LEFT] = Vector(-1, 0),
	[Direction.UP] = Vector(0, -1),
	[Direction.RIGHT] = Vector(1, 0),
	[Direction.DOWN] = Vector(0, 1)
}

include("scripts/api.lua")
include("scripts/eid.lua")
include("scripts/encyclopedia.lua")
include("scripts/ModConfig.lua")
include("scripts/helpFuncs.lua")
include("scripts/cmd.lua")

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
include("scripts/characters/tainted/lazarus.lua")
include("scripts/characters/tainted/lilith.lua")
include("scripts/characters/tainted/keeper.lua")
include("scripts/characters/tainted/apollyon.lua")
include("scripts/characters/tainted/forgotten.lua")
include("scripts/characters/tainted/bethany.lua")
include("scripts/characters/tainted/jacob.lua")

--#region Saving
function ExtraBirthrightLocal:SaveSomeData(isSaving)
	local saveBirthright = {}
	local game = Game()
	if isSaving then
		saveBirthright.PlayerData = json.encode(mod.PlayerData)
		saveBirthright.FamiliarData = json.encode(mod.FamiliarData)
		saveBirthright.BirthrightfloorBought = json.encode(mod.BirthrightfloorBought)
		saveBirthright.VisitedRooms = json.encode(mod.VisitedRooms)
	end


	saveBirthright.ModConfigMenu = json.encode(mod.MCMOption.Settings)
	saveBirthright.ModConfigMenuHearts = json.encode(mod.EBHeartsDrops.Settings)
	saveBirthright.ModConfigMenuPills = json.encode(mod.EBPillsDrops.Settings)
	saveBirthright.ModConfigCardsAndRunes = json.encode(mod.EBCardsAndRunesDrops.Settings)
	saveBirthright.ModConfigMenuBombs = json.encode(mod.EBBombsDrops.Settings)
	saveBirthright.ModConfigMenuKeys = json.encode(mod.EBKeysDrops.Settings)
	saveBirthright.ModConfigMenuCoins = json.encode(mod.EBCoinsDrops.Settings)
	saveBirthright.ModConfigMenuBatteries = json.encode(mod.EBBatteriesDrops.Settings)
	saveBirthright.ModConfigMenuChests = json.encode(mod.EBChestsDrops.Settings)
	saveBirthright.BirthrightStealChance = mod.MCMTCainBirthright["BirthrightYoink"]
	saveBirthright.Version = mod.Version
	mod:SaveData(json.encode(saveBirthright))
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, ExtraBirthrightLocal.SaveSomeData)
--#endregion

--#region Loading
function ExtraBirthrightLocal:LoadItBack(isContinued)
	local game = Game()
	mod.BirthrightfloorBought = false
	mod.VisitedRooms = {}
	mod.PlayerData = {}
	mod.FamiliarData = {}
	if mod:HasData() then
		local loadBirthright = json.decode(mod:LoadData())
		if isContinued then
			if tonumber(loadBirthright.Version) < tonumber(mod.Version) then
				for i = 1, game:GetNumPlayers()  do
					local player = Isaac.GetPlayer(i-1)
					player:GetData().ExtraBirthright = json.decode(loadBirthright["player_"..tostring(i)].PlayerData)
				end
			else
				mod.PlayerData = json.decode(loadBirthright.PlayerData)
				mod.FamiliarData = json.decode(loadBirthright.FamiliarData)
			end
			mod.BirthrightfloorBought = json.decode(loadBirthright.BirthrightfloorBought) or false
			mod.VisitedRooms = json.decode(loadBirthright.VisitedRooms) or {}
		end
		if loadBirthright.ModConfigMenu then
			mod.MCMOption.Settings = json.decode(loadBirthright.ModConfigMenu)
			for i = 1, #mod.MCMOption.Name do
				if mod.MCMOption.Settings[mod.MCMOption.Name[i]] == nil then
					mod.MCMOption.Settings[mod.MCMOption.Name[i]] = 1
				end
			end
		end
		if loadBirthright.ModConfigMenuHearts then
			mod.EBHeartsDrops.Settings = json.decode(loadBirthright.ModConfigMenuHearts)
		end
		if loadBirthright.ModConfigMenuPills then
			mod.EBPillsDrops.Settings = json.decode(loadBirthright.ModConfigMenuPills)
		end
		if loadBirthright.ModConfigMenuBombs then
			mod.EBBombsDrops.Settings = json.decode(loadBirthright.ModConfigMenuBombs)
		end
		if loadBirthright.ModConfigMenuCoins then
			mod.EBCoinsDrops.Settings = json.decode(loadBirthright.ModConfigMenuCoins)
		end
		if loadBirthright.ModConfigMenuKeys then
			mod.EBKeysDrops.Settings = json.decode(loadBirthright.ModConfigMenuKeys)
		end
		if loadBirthright.ModConfigMenuBatteries then
			mod.EBBatteriesDrops.Settings = json.decode(loadBirthright.ModConfigMenuBatteries)
		end
		if loadBirthright.ModConfigCardsAndRunes then
			mod.EBCardsAndRunesDrops.Settings = json.decode(loadBirthright.ModConfigCardsAndRunes)
		end
		if loadBirthright.BirthrightStealChance then
			mod.MCMTCainBirthright["BirthrightYoink"] = loadBirthright.BirthrightStealChance
		end
	end
	mod:BirthrightDesc()
	for _,player in ipairs(mod:GetPlayers()) do
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end
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


Isaac.DebugString("Extra Birthright Effects loaded. Version ".. mod.Version)
print("Extra Birthright Effects loaded. Version ".. mod.Version)
print("Use 'extrabirthright help' command to see other console commands")