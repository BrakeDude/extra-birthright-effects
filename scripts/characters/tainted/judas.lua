local mod = ExtraBirthright
local substituteDarkArts = Isaac.GetItemIdByName("Twisted Arts")
local TJudas = {}
--#region Tainted Judas
function TJudas:DarkFu(_, _, player)
    if mod.MCMOption.Settings["Tainted Judas"] > 1 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Judas"])
		if player:HasCollectible(collectible) and (player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B) then
			player:UseCard(Card.CARD_SOUL_JUDAS,UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, TJudas.DarkFu, substituteDarkArts)

function TJudas:DarkFuItem(player)
    if player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B then
		if mod.MCMOption.Settings["Tainted Judas"] > 1 then
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Judas"])
			if player:HasCollectible(collectible) and
			player:GetActiveItem(ActiveSlot.SLOT_POCKET) == CollectibleType.COLLECTIBLE_DARK_ARTS then
				player:SetPocketActiveItem(substituteDarkArts)
			elseif not player:HasCollectible(collectible) and
			player:GetActiveItem(ActiveSlot.SLOT_POCKET) == substituteDarkArts then
				player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS)
			end
		elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) == substituteDarkArts then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_DARK_ARTS)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, TJudas.DarkFuItem)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_JUDAS_B and mod.MCMOption.Settings["Tainted Judas"] > 1 then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_DARK_ARTS,false,ActiveSlot.SLOT_POCKET)
		player:SetPocketActiveItem(substituteDarkArts)
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B and mod.MCMOption.Settings["Tainted Judas"] == 2
end)
--#endregion