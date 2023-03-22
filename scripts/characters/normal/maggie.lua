--#region Magdalene and Cain
local mod = ExtraBirthright
local Maggie = {}

function Maggie:CharmingScript(player)
	local data = mod.GetPersistentPlayerData(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Magdalene"],true)
	if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA then
		if mod.MCMOption.Settings["Magdalene"] == 2 or mod.MCMOption.Settings["Magdalene"] == 4 then
			if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA then
				local rng = player:GetCollectibleRNG(collectible)
				local enemies = Isaac.FindInRadius(player.Position,50,EntityPartition.ENEMY)
				for _,enemy in ipairs(enemies) do
					if enemy:IsVulnerableEnemy() and not EntityRef(enemy).IsCharmed and rng:RandomInt(1000) < 50 then
						local duration = rng:RandomInt(180,210) + 1
						if enemy:IsBoss() then
							duration = rng:RandomInt(90,120) + 1
						end
						enemy:AddCharmed(EntityRef(enemy),duration)
					end
				end
			end
		end
		if (mod.MCMOption.Settings["Magdalene"] == 3 or mod.MCMOption.Settings["Magdalene"] == 5) then
			if not data.MaggieHearts then
				data.MaggieHearts = player:GetHearts()
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:EvaluateItems()
			end
			if data.MaggieHearts ~= player:GetHearts() then
				data.MaggieHearts = player:GetHearts()
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:EvaluateItems()
			end
		elseif data.MaggieHearts then
			data.MaggieHearts = nil
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Maggie.CharmingScript)

function Maggie:YumHeartBuff(_,_,player)
	if mod.MCMOption.Settings["Magdalene"] == 2 or mod.MCMOption.Settings["Magdalene"] == 4 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Magdalene"],true)
		if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA then
			player:AddHearts(2)
			for _,otherplayer in pairs(mod:GetPlayers()) do
				if GetPtrHash(player) ~= GetPtrHash(otherplayer) then
					player:AddHearts(1)
				end
			end
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Maggie.YumHeartBuff, CollectibleType.COLLECTIBLE_YUM_HEART)

function Maggie:MaggieStatsCache(player,cacheFlag)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Magdalene"],true)
	if mod.MCMOption.Settings["Magdalene"] == 3 or mod.MCMOption.Settings["Magdalene"] == 5 then
		if player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA and player:HasCollectible(collectible) then
			if cacheFlag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed + (player:GetHearts() * 0.06)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Maggie.MaggieStatsCache)

function Maggie:MaggieSoulHeartNextLevel()
	if mod.MCMOption.Settings["Magdalene"] == 3 or mod.MCMOption.Settings["Magdalene"] == 5 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Magdalene"],true)
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			if player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA and player:HasCollectible(collectible) then
				player:AddSoulHearts(2)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Maggie.MaggieSoulHeartNextLevel)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_MAGDALENA then
		local data = mod.GetPersistentPlayerData(player)
		if player:HasCollectible(Isaac.GetItemIdByName("Birthright (Alt)")) then
			player:AddMaxHearts(2)
		end
		if (mod.MCMOption.Settings["Magdalene"] == 2 or mod.MCMOption.Settings["Magdalene"] == 4) and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_YUM_HEART then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_YUM_HEART)
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_YUM_HEART)
		end
		if (mod.MCMOption.Settings["Magdalene"] == 3 or mod.MCMOption.Settings["Magdalene"] == 5) then
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
			data.MaggieHearts = player:GetHearts()
		end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA and mod.MCMOption.Settings["Magdalene"] > 1 and mod.MCMOption.Settings["Magdalene"] < 4
end)
--#endregion