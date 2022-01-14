local mod = ExtraBirthright
--#region Azazel

function mod:Azazel8Brim(player)
	player = player:ToPlayer()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Azazel"])
	if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL and player:HasCollectible(collectible) then
		local rng = player:GetCollectibleRNG(collectible)
		if rng:RandomInt(5) == 1 then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_TAMMYS_HEAD, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.Azazel8Brim, EntityType.ENTITY_PLAYER)
--#endregion