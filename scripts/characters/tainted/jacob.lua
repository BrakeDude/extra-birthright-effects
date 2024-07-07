local mod = ExtraBirthright
local game = Game()
local Jacob = {}
local skin = {
				[SkinColor.SKIN_PINK]="",
				[SkinColor.SKIN_WHITE]="_white",
				[SkinColor.SKIN_BLACK]="_black",
				[SkinColor.SKIN_BLUE]="_blue",
				[SkinColor.SKIN_RED]="_red",
				[SkinColor.SKIN_GREEN]="_green",
				[SkinColor.SKIN_GREY]="_grey",
			 }
--#region Tainted Jacob
function Jacob:HesMine(player,_,_,newtarget)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
		player = player:ToPlayer()
		local data = mod.GetPersistentPlayerData(player)
		if player:HasCollectible(collectible) and (player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB_B) then
			if newtarget.Type ~= EntityType.ENTITY_DARK_ESAU then
				if newtarget.Entity.Type == EntityType.ENTITY_PROJECTILE then
					data.newEsauTarget = newtarget.Entity.SpawnerEntity
				elseif newtarget.Entity:IsVulnerableEnemy() then
					data.newEsauTarget = newtarget.Entity
				end
			end
		end
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Jacob.HesMine, EntityType.ENTITY_PLAYER)

function Jacob:YouDie(npc,collider,low)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
		local player
		local isaacheart = false
		if collider.Type == EntityType.ENTITY_PLAYER and (collider:ToPlayer():GetPlayerType() == PlayerType.PLAYER_JACOB_B or collider:ToPlayer():GetPlayerType() == PlayerType.PLAYER_JACOB2_B)  then
			player = collider:ToPlayer()
			if player:HasCollectible(CollectibleType.COLLECTIBLE_ISAACS_HEART) then
				return false
			end
		elseif collider.Type == EntityType.ENTITY_FAMILIAR and collider.Variant == FamiliarVariant.ISAACS_HEART 
		then
			player = collider:ToFamiliar().Player
			isaacheart = true
			if player:GetPlayerType() ~= PlayerType.PLAYER_JACOB_B and player:GetPlayerType() ~= PlayerType.PLAYER_JACOB2_B then
				return nil
			end
		end
		if player then
			if player:HasInvincibility(0) or player:GetDamageCooldown() > 0 then
				return false
			end
			if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
				player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
			end
			if player:HasCollectible(collectible) then
				if not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then
					local deadJacob = Isaac.Spawn(1000,0,0,player.Position,Vector.Zero,nil):ToEffect()
					deadJacob:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					deadJacob.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
					deadJacob.GridCollisionClass = GridCollisionClass.COLLISION_NONE
					local deadJacobSprites = deadJacob:GetSprite()
					deadJacobSprites:Load("gfx/001.000_player.anm2",true)
					deadJacobSprites:ReplaceSpritesheet(PlayerSpriteLayer.SPRITE_EXTRA,"gfx/characters/costumes/character_019b_jacob"..skin[player:GetBodyColor()]..".png")
					deadJacobSprites:ReplaceSpritesheet(PlayerSpriteLayer.SPRITE_GHOST,"gfx/characters/costumes/ghostnoghost.png")
					deadJacobSprites:LoadGraphics()
					deadJacobSprites:Play("Death",true)
					deadJacobSprites:SetFrame(4)
				end
				player:ChangePlayerType(PlayerType.PLAYER_JACOB2_B)
			end
		end
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, Jacob.YouDie, EntityType.ENTITY_DARK_ESAU)

function Jacob:FriendlyPissedEsau(Esau)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if  Esau.SpawnerType == EntityType.ENTITY_PLAYER then
		local player = Esau.SpawnerEntity:ToPlayer()
		local data = mod.GetPersistentPlayerData(player)
		if (player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB_B) and player:HasCollectible(collectible) then
			if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
				if data.newEsauTarget then
					Esau.Target = data.newEsauTarget:Exists() and data.newEsauTarget or player
				else
					Esau.Target = player
				end
			elseif mod.MCMOption.Settings["Tainted Jacob"] == 3 or mod.MCMOption.Settings["Tainted Jacob"] == 5 then
				Esau:AddCharmed(EntityRef(player),-1)
				Esau:SetColor(Color(1,1,1,1,0,0,0),9999999,0,false,false)	
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Jacob.FriendlyPissedEsau, EntityType.ENTITY_DARK_ESAU)

local function JacobStatsCache(player,cacheFlag)
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage * 1.5
	elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then
		player.MaxFireDelay = mod:tearsUp(player.MaxFireDelay,1.5)
	elseif cacheFlag == CacheFlag.CACHE_SPEED then
		player.MoveSpeed = player.MoveSpeed + 0.3
	end
end
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_JACOB_B, 1, JacobStatsCache)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_JACOB2_B, 1, JacobStatsCache)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_JACOB_B, 2, function(player, cache)
	if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
		JacobStatsCache(player,cache)
	end
end)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_JACOB_B, 2, function(player, cache)
	if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
		JacobStatsCache(player,cache)
	end
end)

local function Dupe()
	local room = game:GetRoom()
	if room:IsFirstVisit() and (room:GetType() == RoomType.ROOM_DEVIL or room:GetType() == RoomType.ROOM_TREASURE
	or room:GetType() == RoomType.ROOM_SECRET or room:GetType() == RoomType.ROOM_SUPERSECRET) then
		local items = Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)
		for _,item in ipairs(items) do
			if not mod:GetData(item).Duped then
				mod:GetData(item).Duped = true
				local ItemPool = game:GetItemPool():GetPoolForRoom(room:GetType(),RNG():GetSeed())
				local id = game:GetItemPool():GetCollectible(ItemPool)
				local newitem = Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,id,Isaac.GetFreeNearPosition(item.Position,3),Vector(0, 0),nil):ToPickup()
				mod:GetData(newitem).Duped = true
				if item:ToPickup():IsShopItem() then
					if room:GetType() == RoomType.ROOM_DEVIL then
						newitem.Price = Isaac.GetItemConfig():GetCollectible(id).DevilPrice
					elseif room:GetType() == RoomType.ROOM_ANGEL then
						newitem:Remove()
					else
						newitem.Price = Isaac.GetItemConfig():GetCollectible(id).ShopPrice
					end
				end
			end
		end
	end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_JACOB_B, 1, Dupe)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_JACOB2_B, 1, Dupe)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_JACOB_B, 2, function()
	local doDupe = false
	for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_EDEN_B})) do
		local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_JACOB_B then
			doDupe = true
			break
		end
	end
	if doDupe then
		Dupe()
	end
end)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_JACOB2_B, 2, function()
	local doDupe = false
	for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_EDEN_B})) do
		local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_JACOB2_B then
			doDupe = true
			break
		end
	end
	if doDupe then
		Dupe()
	end
end)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if (ptype == PlayerType.PLAYER_JACOB_B or ptype == PlayerType.PLAYER_JACOB2_B) and (mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4) then
		player:AddMaxHearts(2, true)
		player:AddHearts(2)
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		player:AddCacheFlags(CacheFlag.CACHE_SPEED)
		player:EvaluateItems()
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return (player:GetPlayerType() == PlayerType.PLAYER_JACOB_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B) and mod.MCMOption.Settings["Tainted Jacob"] > 1 and mod.MCMOption.Settings["Tainted Jacob"] < 4
end)
--#endregion