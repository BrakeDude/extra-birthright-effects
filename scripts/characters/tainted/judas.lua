local mod = ExtraBirthright
--#region Tainted Judas
function mod:DarkFu(_, _, player)
    if mod.MCMOption.Settings["Tainted Judas"] > 1 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Judas"])
		if player:HasCollectible(collectible) and (player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B) then
			player:UseCard(Card.CARD_SOUL_JUDAS,UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.DarkFu, mod.substituteDarkArts)

function mod:DarkFuItem(player)
    if player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B then
		if mod.MCMOption.Settings["Tainted Judas"] > 1 then
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Judas"])
			if player:HasCollectible(collectible) and
			player:GetActiveItem(ActiveSlot.SLOT_POCKET) == CollectibleType.COLLECTIBLE_DARK_ARTS then
				player:SetPocketActiveItem(mod.substituteDarkArts)
			elseif not player:HasCollectible(collectible) and
			player:GetActiveItem(ActiveSlot.SLOT_POCKET) == mod.substituteDarkArts then
				player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS)
			end
		elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) == mod.substituteDarkArts then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.DarkFuItem)
--#endregion