local mod = ExtraBirthright
local Azazel = {}
--#region Tainted Azazel
function Azazel:TAzazelFlight(player,cacheFlag)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Azazel"])
	if mod.MCMOption.Settings["Tainted Azazel"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B and player:HasCollectible(collectible) then
			if cacheFlag == CacheFlag.CACHE_FLYING then
				player.CanFly = true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Azazel.TAzazelFlight)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_AZAZEL_B, function(player,cache)
	player.CanFly = true
end, CacheFlag.CACHE_FLYING)

local function Flight(player)
	local effects = player:GetEffects()
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

function Azazel:TAzazelBrim(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Azazel"])
	if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B then
		if player:HasCollectible(collectible) and (mod.MCMOption.Settings["Tainted Azazel"] > 1) then
			Flight(player)		
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Azazel.TAzazelBrim)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_AZAZEL_B, function(player)
	Flight(player)
end)


mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B and mod.MCMOption.Settings["Tainted Azazel"] == 2
end)
--#endregion