local mod = ExtraBirthright
local BB = {}
local doubleHearts = Isaac.GetEntityVariantByName("Heart (double soul)")
local game = Game()
--#region Blue Baby

function BB:BBHearts(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Blue Baby"])
	local data = mod.GetPersistentPlayerData(player)
	if player:HasCollectible(collectible) and (mod.MCMOption.Settings["Blue Baby"] > 1) and player:GetPlayerType() == PlayerType.PLAYER_XXX then
		if not data.BBHearts then
			data.BBHearts = player:GetSoulHearts()
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		end
		if data.BBHearts ~= player:GetSoulHearts() then
			data.BBHearts = player:GetSoulHearts()
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:EvaluateItems()
		end
	elseif data.BBHearts then
		data.BBHearts = nil
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		player:AddCacheFlags(CacheFlag.CACHE_SPEED)
		player:AddCacheFlags(CacheFlag.CACHE_RANGE)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, BB.BBHearts)

function BB:BBStatsCache(player,cacheFlag)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Blue Baby"])
	if mod.MCMOption.Settings["Blue Baby"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_XXX and player:HasCollectible(collectible) then
			if cacheFlag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + (player:GetSoulHearts() * 0.075)
			end
			if cacheFlag == CacheFlag.CACHE_FIREDELAY then
				player.MaxFireDelay = mod:tearsUp(player.MaxFireDelay,player:GetSoulHearts()/4)
			end
			if cacheFlag == CacheFlag.CACHE_RANGE then
				player.TearRange = mod:rangeUp(player.TearRange,player:GetSoulHearts() * 0.5)
			end
			if cacheFlag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed + (player:GetSoulHearts() * 0.02)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, BB.BBStatsCache)

local function NotSoulHeart(heart)
	if heart.Variant == PickupVariant.PICKUP_HEART then
		if MoreSoulAndBlackHearts then
			return heart.Variant == PickupVariant.PICKUP_HEART and heart.SubType ~= HeartSubType.HEART_HALF_SOUL and heart.SubType ~= HeartSubType.HEART_SOUL and heart.SubType ~= HeartSubType.HEART_BLACK and heart.SubType ~= 320 and heart.SubType ~= 620
		else
			return heart.Variant == PickupVariant.PICKUP_HEART and heart.SubType ~= HeartSubType.HEAR_HALF_SOUL and heart.SubType ~= HeartSubType.HEART_SOUL and heart.SubType ~= HeartSubType.HEART_BLACK
		end
	end
	if (doubleHearts ~= -1) then
		return heart.Variant == doubleHearts and heart.SubType ~= 1 and heart.SubType ~= 2
	end
	return false
end

local function ChangeRedHeart(heart)
	local rng = heart:GetDropRNG()
	if NotSoulHeart(heart)  then
		if rng:RandomInt(100) < 30 then
			if rng:RandomInt(100) < 20 and (doubleHearts ~= -1 or MoreSoulAndBlackHearts) then
				if MoreSoulAndBlackHearts then
					heart:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, rng:RandomInt(100) < 20 and 620 or 320, true)
				else
					heart:Morph(EntityType.ENTITY_PICKUP,doubleHearts,rng:RandomInt(100) < 20 and 2 or 1,true)
				end
			else
				heart:Morph(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_HEART,rng:RandomInt(100) < 20 and HeartSubType.HEART_BLACK or HeartSubType.HEART_SOUL,true)
			end
		else
			local random = rng:RandomInt(6) + 1
			local pickup = {variant = nil, subtype = 0}
			local itemPool = game:GetItemPool()
			if random == 1 then
				pickup.variant = PickupVariant.PICKUP_COIN
			elseif random == 2 then
				pickup.variant = PickupVariant.PICKUP_BOMB
			elseif random == 3 then
				pickup.variant = PickupVariant.PICKUP_TAROTCARD
				pickup.subtype = itemPool:GetCard(rng:Next()+1, true, false)
			elseif random == 4 then
				pickup.variant = PickupVariant.PICKUP_KEY
			elseif random == 5 then
				pickup.variant = PickupVariant.PICKUP_TAROTCARD
				pickup.subtype = itemPool:GetPill(rng:Next()+1)
			elseif random == 6 then
				pickup.variant = PickupVariant.PICKUP_LIL_BATTERY
			end
			heart:Morph(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,true)
		end
	end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PICKUP_UPDATE, 0, PlayerType.PLAYER_XXX, 1, ChangeRedHeart)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_XXX and (mod.MCMOption.Settings["Blue Baby"] > 1) then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_POOP)
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_POOP)
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_XXX and mod.MCMOption.Settings["Blue Baby"] == 2
end)
--#endregion