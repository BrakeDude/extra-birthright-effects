local mod = ExtraBirthright
--#region Tainted Azazel

function mod:TAzazelFlight(player,cacheFlag)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Azazel"])
	if mod.MCMOption.Settings["Tainted Azazel"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B and player:HasCollectible(collectible) then
			if cacheFlag == CacheFlag.CACHE_FLYING then
				player.CanFly = true
			end
		end
	end
end

function mod:TAzazelBrim(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Azazel"])
	if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B then
		local effects = player:GetEffects()
		if player:HasCollectible(collectible) and (mod.MCMOption.Settings["Tainted Azazel"] > 1) then
			if not effects:GetCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE) then
				effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE)
			end
			if not effects:GetCollectibleEffect(CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT) then
				effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT)
			end
			if not player.CanFly then
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.TAzazelFlight)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.TAzazelBrim)
--#endregion