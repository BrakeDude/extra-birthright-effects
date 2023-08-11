local mod = ExtraBirthright
local Azazel = {}
--#region Azazel

local function rngBrim(player)
	if mod.RNG:RandomInt(5) == 1 then
		if player:GetPlayerType() ~= PlayerType.PLAYER_AZAZEL and player:GetPlayerType() ~= PlayerType.PLAYER_AZAZEL_B and
		player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BRIMSTONE) < 1 then
			player:GetEffects():AddCollectibleEffect(CollectibleType, false, 1)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_TAMMYS_HEAD, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
			player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE, 1)
		else
			player:UseActiveItem(CollectibleType.COLLECTIBLE_TAMMYS_HEAD, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
		end
	end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_AZAZEL, 1, rngBrim)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_AZAZEL and mod.MCMOption.Settings["Azazel"] == 2
end)
--#endregion