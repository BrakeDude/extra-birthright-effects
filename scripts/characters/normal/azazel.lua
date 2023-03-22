local mod = ExtraBirthright
local Azazel = {}
--#region Azazel

local function rngBrim(player)
	if player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BIRTHRIGHT):RandomInt(5) == 1 then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_TAMMYS_HEAD, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
	end
end

function Azazel:Azazel8Brim(player)
	player = player:ToPlayer()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Azazel"])
	if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL and player:HasCollectible(collectible) and mod.MCMOption.Settings["Azazel"] > 1 then
		rngBrim(player)
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Azazel.Azazel8Brim, EntityType.ENTITY_PLAYER)

mod:AddPriorityCallback(mod.Callbacks.MC_ENTITY_TAKE_DMG, PlayerType.PLAYER_AZAZEL, function(player, amount, flags, source, cd)
	rngBrim(player)
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_AZAZEL and mod.MCMOption.Settings["Azazel"] == 2
end)
--#endregion