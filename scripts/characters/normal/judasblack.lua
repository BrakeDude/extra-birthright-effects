--#region Dark Judas
local mod = ExtraBirthright
function mod:DarkJudasGetsBonked(entity)
	local player = entity:ToPlayer()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Dark Judas"],true)
	if (mod.MCMOption.Settings["Dark Judas"] == 2  or mod.MCMOption.Settings["Dark Judas"] == 4) and player:HasCollectible(collectible) then
		if player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON,false,false,false,false)
		end
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.DarkJudasGetsBonked, EntityType.ENTITY_PLAYER)
--#endregion