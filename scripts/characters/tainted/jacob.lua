local mod = ExtraBirthright
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
function mod:HesMine(player,_,_,newtarget)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
		local player = player:ToPlayer()
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
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.HesMine, EntityType.ENTITY_PLAYER)

function mod:YouDie(npc,collider,low)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
		local player
		local isaacheart = false
		if collider.Type == EntityType.ENTITY_PLAYER and collider:ToPlayer():GetPlayerType() == PlayerType.PLAYER_JACOB_B  then
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
			if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) and not isaacheart then
				player:TakeDamage(2, 0, EntityRef(player), 0)
				return false
			end
			if player:HasCollectible(collectible) and not isaacheart then
				if not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then
					local deadJacob = Isaac.Spawn(1000,0,0,player.Position,Vector.Zero,nil):ToEffect()
					deadJacob:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					deadJacob.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
					deadJacob.GridCollisionClass = GridCollisionClass.COLLISION_NONE
					local deadJacobSprites = deadJacob:GetSprite()
					deadJacobSprites:Load("gfx/001.000_player.anm2",true)
					print(player:GetBodyColor())
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
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.YouDie, EntityType.ENTITY_DARK_ESAU)

function mod:FriendlyPissedEsau(Esau)
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
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.FriendlyPissedEsau, EntityType.ENTITY_DARK_ESAU)

function mod:JacobStatsCache(player,cacheFlag)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
		if (player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB_B)
		and player:HasCollectible(collectible) then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage * 1.5
			elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then
				player.MaxFireDelay = player.MaxFireDelay / (1 + 3.05 / 8)
			elseif cacheFlag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed + 0.3
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.JacobStatsCache)

function mod:SecondItem()
	local game = Game()
	local room = game:GetRoom()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Jacob"],true)
	if mod.MCMOption.Settings["Tainted Jacob"] == 2 or mod.MCMOption.Settings["Tainted Jacob"] == 4 then
		for i = 1, game:GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			if (player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB_B)
			and player:HasCollectible(collectible) and room:IsFirstVisit() and
			(room:GetType() == RoomType.ROOM_DEVIL or room:GetType() == RoomType.ROOM_TREASURE
			or room:GetType() == RoomType.ROOM_SECRET or room:GetType() == RoomType.ROOM_SUPERSECRET)
			then
				local items = Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)
				for _,item in ipairs(items) do
					local ItemPool = game:GetItemPool():GetPoolForRoom(room:GetType(),RNG():GetSeed())
					local id = game:GetItemPool():GetCollectible(ItemPool)
					local newitem = Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,id,Isaac.GetFreeNearPosition(item.Position,3),Vector(0, 0),nil):ToPickup()
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
				return
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.SecondItem)
--#endregion