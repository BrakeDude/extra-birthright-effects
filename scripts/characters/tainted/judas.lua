local mod = ExtraBirthright
local substituteDarkArts = Isaac.GetItemIdByName("Twisted Arts")
local TJudas = {}
--#region Tainted Judas
function TJudas:DarkFu(_, _, player)
	player:UseCard(Card.CARD_SOUL_JUDAS, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, TJudas.DarkFu, substituteDarkArts)

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