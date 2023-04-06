local mod = ExtraBirthright
local Samson = {}

function Samson:SamsonStronk(player)
	if mod.MCMOption.Settings["Samson"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Samson"],false)
        if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
			if player:HasCollectible(collectible) then
                if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) then
                    player:UseActiveItem(CollectibleType.COLLECTIBLE_MOMS_BRACELET)
                end
            end
        end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Samson.SamsonStronk)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_SAMSON, function(player)
	if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_MOMS_BRACELET)
	end
end)

function Samson:SamsonCache(player,cache)
	if mod.MCMOption.Settings["Samson"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Samson"],false)
			if player:HasCollectible(collectible) then
				player.Damage = player.Damage + 4
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Samson.SamsonCache, CacheFlag.CACHE_DAMAGE)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_SAMSON, function(player,cache)
	player.Damage = player.Damage + 4
end, CacheFlag.CACHE_DAMAGE)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_SAMSON and mod.MCMOption.Settings["Samson"] > 1 then
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_SAMSON and mod.MCMOption.Settings["Samson"] == 2
end)