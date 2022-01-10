ExtraBirthright = RegisterMod( "Extra Birthright Effeccts", 1 );
local mod = ExtraBirthright
mod.Version = "2.35"
local json = require("json")
mod.game = Game()
mod.room = mod.game:GetRoom()
mod.sfx = SFXManager()
mod.rng = RNG()
mod.substituteBirthright = Isaac.GetItemIdByName("Fake Birthright")
mod.substituteDarkArts = Isaac.GetItemIdByName("Twisted Arts")
mod.wasThereBoss = false
mod.bossposition = Vector.Zero
mod.taintedLazBirthright = {false,false,false,false,false,false,false,false}
mod.fliped = {0,0,0,0,0,0,0,0}
mod.BirthrightfloorBought = false
mod.doubleHearts = Isaac.GetEntityVariantByName("Heart (double soul)")

mod.JacobDeathAnim = Isaac.GetEntityTypeByName("Tainted Jacob Death Animation")

mod.Books = {
	CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK,
	CollectibleType.COLLECTIBLE_BIBLE,
	CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL,
	CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS,
	CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS,
	CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS,
	CollectibleType.COLLECTIBLE_BOOK_OF_SIN,
	CollectibleType.COLLECTIBLE_SATANIC_BIBLE,
	CollectibleType.COLLECTIBLE_TELEPATHY_BOOK,
	CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD,
	CollectibleType.COLLECTIBLE_MONSTER_MANUAL,
	CollectibleType.COLLECTIBLE_LEMEGETON
}

mod.shootDirecton = {
	[Direction.NO_DIRECTION] = Vector(0,0),
	[Direction.LEFT] = Vector(-1, 0),
	[Direction.UP] = Vector(0, -1),
	[Direction.RIGHT] = Vector(1, 0),
	[Direction.DOWN] = Vector(0, 1)
}

include("scripts/ModConfig.lua")
include("scripts/helpFuncs.lua")
include("scripts/eid.lua")
include("scripts/cmd.lua")

include("scripts/characters/normal/isaac.lua")
include("scripts/characters/normal/maggie.lua")
include("scripts/characters/normal/cain.lua")
include("scripts/characters/normal/judas.lua")
include("scripts/characters/normal/judasblack.lua")
include("scripts/characters/normal/azazel.lua")
include("scripts/characters/normal/bb.lua")
include("scripts/characters/normal/samson.lua")
include("scripts/characters/normal/lilith.lua")
include("scripts/characters/normal/keeper.lua")
include("scripts/characters/normal/apollyon.lua")
include("scripts/characters/normal/bethany.lua")
include("scripts/characters/tainted/maggie.lua")
include("scripts/characters/tainted/judas.lua")
include("scripts/characters/tainted/bb.lua")
include("scripts/characters/tainted/eve.lua")
include("scripts/characters/tainted/azazel.lua")
include("scripts/characters/tainted/samson.lua")
include("scripts/characters/tainted/lazarus.lua")
include("scripts/characters/tainted/lilith.lua")
include("scripts/characters/tainted/apollyon.lua")
include("scripts/characters/tainted/bethany.lua")
include("scripts/characters/tainted/jacob.lua")
--#region Saving
function mod:SaveSomeData(isSaving)
	local saveBirthright = {}
	if isSaving then
		for i = 1, mod.game:GetNumPlayers() do
			local saveData = {}
			local player = Isaac.GetPlayer(i-1)
			saveData.taintedLazBirthright = mod.taintedLazBirthright[i]
			saveData.flipTimeCharge = mod.fliped[i]
			saveData.PlayerData = json.encode(mod:GetData(player))
			saveBirthright["player_"..tostring(i)]=saveData
		end
		saveBirthright.CurrentBlessing = mod.level:GetCurses()
		saveBirthright.BirthrightfloorBought = mod.BirthrightfloorBought
	end
	saveBirthright.ModConfigMenu = json.encode(mod.MCMOption.Settings)
	saveBirthright.ModConfigMenuHearts = json.encode(mod.EBHeartsDrops.Settings)
	saveBirthright.ModConfigMenuPills = json.encode(mod.EBPillsDrops.Settings)
	saveBirthright.ModConfigCardsAndRunes = json.encode(mod.EBCardsAndRunesDrops.Settings)
	saveBirthright.ModConfigMenuBombs = json.encode(mod.EBBombsDrops.Settings)
	saveBirthright.ModConfigMenuKeys = json.encode(mod.EBKeysDrops.Settings)
	saveBirthright.ModConfigMenuCoins = json.encode(mod.EBCoinsDrops.Settings)
	saveBirthright.ModConfigMenuBatteries = json.encode(mod.EBBatteriesDrops.Settings)
	saveBirthright.Version = mod.Version
	mod:SaveData(json.encode(saveBirthright))
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.SaveSomeData)
--#endregion
--#region Loading

function mod:InitData(player)
	local pType = player:GetPlayerType()
	if pType <= 40 then
	local data = mod:GetData(player)
		if pType == PlayerType.PLAYER_APOLLYON then
			if not data.ApollyonStatUps then
				data.ApollyonStatUps = {
					Speed = 0,
					FireDelay = 0,
					Damage = 0,
					Range = 0,
					ShotSpeed = 0,
					Luck = 0
				}
			end
		end
		if pType == PlayerType.PLAYER_SAMSON_B then
			if not data.RoomEnemies then
				data.RoomEnemies = 0
			end
			if not data.GotHit then
				data.GotHit = 0
			end
			if data.HairLock == nil then
				data.HairLock = false
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.InitData)

function mod:LoadItBack(isContinued)
	mod.taintedLazBirthright = {false,false,false,false,false,false,false,false}
	if mod:HasData() then
		local loadBirthright = json.decode(mod:LoadData())
		if isContinued then
			for i = 1, mod.game:GetNumPlayers()  do
				local player = Isaac.GetPlayer(i-1)
				mod.taintedLazBirthright[i] = loadBirthright["player_"..tostring(i)].taintedLazBirthright
				mod.fliped[i] = loadBirthright["player_"..tostring(i)].flipTimeCharge
				player:GetData().ExtraBirthright = json.decode(loadBirthright["player_"..tostring(i)].PlayerData)
			end
			mod.BirthrightfloorBought = loadBirthright.BirthrightfloorBought
			local blessings = loadBirthright.CurrentBlessing
			for i = 1, #mod.LevelBlessing.Blessings do
				if mod.LevelBlessing.CheckFlag(blessings, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i]))) then
					Game():GetLevel():AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])),false)
				end
			end
		end
		
		mod.MCMOption.Settings = json.decode(loadBirthright.ModConfigMenu)
		for i = 1, #mod.MCMOption.Name do
			if mod.MCMOption.Settings[mod.MCMOption.Name[i]] == nil then
				mod.MCMOption.Settings[mod.MCMOption.Name[i]] = 1
			end
		end
		mod.EBHeartsDrops.Settings = json.decode(loadBirthright.ModConfigMenuHearts)
		mod.EBPillsDrops.Settings = json.decode(loadBirthright.ModConfigMenuPills)
		mod.EBBombsDrops.Settings = json.decode(loadBirthright.ModConfigMenuBombs)
		mod.EBCoinsDrops.Settings = json.decode(loadBirthright.ModConfigMenuCoins)
		mod.EBKeysDrops.Settings = json.decode(loadBirthright.ModConfigMenuKeys)
		mod.EBBatteriesDrops.Settings = json.decode(loadBirthright.ModConfigMenuBatteries)
		mod.EBCardsAndRunesDrops.Settings = json.decode(loadBirthright.ModConfigCardsAndRunes)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.LoadItBack)
--#endregion
--#region Init, CMD commands
function mod:Init(player)
	local data = mod:GetData(player)
	data.gotBirthright = true
	if player:GetPlayerType() == PlayerType.PLAYER_EVE_B then
		data.BirthrightBloodBabyCooldown = data.BirthrightBloodBabyCooldown or 2
	end
	mod.taintedLazBirthright[mod.EsauCheck(player)] = false
	mod.BirthrightfloorBought = false
	mod.wasThereBoss = false
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.Init);


--#endregion
--#region Birthright check for first pickup effect

function mod:CheckBirthrightAll(player)
	mod.game = Game()
	mod.level = mod.game:GetLevel()
	mod.room = mod.game:GetRoom()
	local data = mod:GetData(player)
	if player:GetPlayerType() <= 40 then
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end
	if player:GetPlayerType() == PlayerType.PLAYER_ISAAC and mod.MCMOption.Settings["Isaac"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA and mod.MCMOption.Settings["Magdalene"] > 1 and mod.MCMOption.Settings["Magdalene"] < 4 or
	player:GetPlayerType() == PlayerType.PLAYER_CAIN and mod.MCMOption.Settings["Cain"] > 1 and mod.MCMOption.Settings["Cain"] < 4 or
	player:GetPlayerType() == PlayerType.PLAYER_JUDAS and mod.MCMOption.Settings["Judas"] > 1 and mod.MCMOption.Settings["Judas"] < 4 or
	player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and mod.MCMOption.Settings["Dark Judas"] > 1 and mod.MCMOption.Settings["Dark Judas"] < 4 or	
	player:GetPlayerType() == PlayerType.PLAYER_XXX and mod.MCMOption.Settings["Blue Baby"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_EVE and mod.MCMOption.Settings["Eve"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_SAMSON and mod.MCMOption.Settings["Samson"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_AZAZEL and mod.MCMOption.Settings["Azazel"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_LAZARUS and mod.MCMOption.Settings["Lazarus"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 and mod.MCMOption.Settings["Lazarus Risen"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_EDEN and mod.MCMOption.Settings["Eden"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_THELOST and mod.MCMOption.Settings["The Lost"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_LILITH and mod.MCMOption.Settings["Lilith"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_KEEPER and mod.MCMOption.Settings["Keeper"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_APOLLYON and mod.MCMOption.Settings["Apollyon"] == 2 or
	(player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN or player:GetPlayerType() == PlayerType.PLAYER_THESOUL) and mod.MCMOption.Settings["The Forgotten"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_BETHANY and mod.MCMOption.Settings["Bethany"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_JACOB and mod.MCMOption.Settings["Jacob"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_ESAU and mod.MCMOption.Settings["Esau"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_ISAAC_B and mod.MCMOption.Settings["Tainted Isaac"] == 2 or
	--player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B and mod.MCMOption.Settings["Tainted Magdalene"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_CAIN_B and mod.MCMOption.Settings["Tainted Cain"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B and mod.MCMOption.Settings["Tainted Judas"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_XXX_B and mod.MCMOption.Settings["Tainted Blue Baby"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_EVE_B and mod.MCMOption.Settings["Tainted Eve"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B and mod.MCMOption.Settings["Tainted Samson"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B and mod.MCMOption.Settings["Tainted Azazel"] == 2 or
	(player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B) and mod.MCMOption.Settings["Tainted Lazarus"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and mod.MCMOption.Settings["Tainted Eden"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_THELOST_B and mod.MCMOption.Settings["Tainted Lost"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_LILITH_B and mod.MCMOption.Settings["Tainted Lilith"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B and mod.MCMOption.Settings["Tainted Keeper"] == 2 or
	player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B and mod.MCMOption.Settings["Tainted Apollyon"] > 1 and mod.MCMOption.Settings["Tainted Apollyon"] < 4 or
	(player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B or player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B) and mod.MCMOption.Settings["Tainted Forgotten"] == 2 or
	--player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and mod.MCMOption.Settings["Tainted Bethany"] == 2 or
	(player:GetPlayerType() == PlayerType.PLAYER_JACOB_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B) and mod.MCMOption.Settings["Tainted Jacob"] > 1 and mod.MCMOption.Settings["Tainted Jacob"] < 4
	then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			player:AddCollectible(mod.substituteBirthright,0,false)
		end	
	else
		if player:HasCollectible(mod.substituteBirthright) then
			player:RemoveCollectible(mod.substituteBirthright)
			player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT,0,false)
		end
	end

	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or player:HasCollectible(mod.substituteBirthright)) and not data.gotBirthright then
		if player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA and (mod.MCMOption.Settings["Magdalene"] == 3 or mod.MCMOption.Settings["Magdalene"] == 5) then
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
			data.MaggieHearts = player:GetHearts()
		end
		if player:GetPlayerType() == PlayerType.PLAYER_XXX and (mod.MCMOption.Settings["Blue Baby"] > 1) then
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
			data.BBHearts = player:GetSoulHearts()
		end
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON and mod.MCMOption.Settings["Samson"] > 1 then
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
		if player:GetPlayerType() == PlayerType.PLAYER_KEEPER and mod.MCMOption.Settings["Keeper"] > 1 then
			local trinket1 = player:GetTrinket(0)
			local trinket2 = player:GetTrinket(1)
			if trinket1 ~= 0 then player:TryRemoveTrinket(trinket1) end
			if trinket2 ~= 0 then player:TryRemoveTrinket(trinket2) end
			player:AddTrinket(TrinketType.TRINKET_SILVER_DOLLAR)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,false,false,true,false)
			player:AddTrinket(TrinketType.TRINKET_RIB_OF_GREED)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,false,false,true,false)
			if trinket1 ~= 0 then player:AddTrinket(trinket1) end
			if trinket2 ~= 0 then player:AddTrinket(trinket2) end
		end
		if player:GetPlayerType() == PlayerType.PLAYER_JUDAS and (mod.MCMOption.Settings["Judas"] == 2 or mod.MCMOption.Settings["Judas"] == 4) then
			for x = 1,3 do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN,2, Isaac.GetFreeNearPosition(player.Position,0),Vector.Zero,nil)
			end
		end
		if player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
			data.Bethany = PlayerType.PLAYER_BETHANY
		end
		if player:GetPlayerType() == PlayerType.PLAYER_JACOB and mod.MCMOption.Settings["Jacob"] > 1 then
			player:GetOtherTwin():AddCollectible(CollectibleType.COLLECTIBLE_RED_STEW)
		end
		if player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B and mod.MCMOption.Settings["Tainted Judas"] > 1 then
			player:RemoveCollectible(705,false,ActiveSlot.SLOT_POCKET)
			player:SetPocketActiveItem(mod.substituteDarkArts)
		end
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B and mod.MCMOption.Settings["Tainted Samson"] > 1 then
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
		if (player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B) and mod.MCMOption.Settings["Tainted Lazarus"] > 1 then
			mod.taintedLazBirthright[mod.EsauCheck(player)] = true
		end
		if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B and (mod.MCMOption.Settings["Tainted Apollyon"] == 2 or mod.MCMOption.Settings["Tainted Apollyon"] == 4) then
			for x = 1,20 do
				local rnglocust = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BIRTHRIGHT):RandomInt(5)+1
				Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rnglocust, player.Position, Vector.Zero, player)
			end
		end
		if (player:GetPlayerType() == PlayerType.PLAYER_JACOB_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B) and (mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4) then
			player:AddMaxHearts(2, true)
			player:AddHearts(2)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		end
	end
	data.gotBirthright = player:HasCollectible(mod.substituteBirthright) or player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.CheckBirthrightAll);

function mod:UpdateTheRoom()
	mod.wasThereBoss = false
	mod.clearedroom = mod.room:IsClear() and mod.room:IsFirstVisit()
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.UpdateTheRoom);
--#endregion



Isaac.DebugString("Extra Birthright Effects loaded. Version ".. mod.Version)
print("Extra Birthright Effects loaded. Version ".. mod.Version)
print("Use 'extrabirthright help' command to see other console commands")