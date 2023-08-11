local mod = ExtraBirthright
local Samson = {}

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_SAMSON, 1, function(player)
	if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_MOMS_BRACELET)
	end
end)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_SAMSON, 1, function(player,cache)
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