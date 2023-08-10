--#region Dark Judas
local mod = ExtraBirthright
local DJudas = {}

local function DarkJudasGetsBonked(player)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON,false,false,false,false)
end
--mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, DJudas.DarkJudasGetsBonked, EntityType.ENTITY_PLAYER)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_BLACKJUDAS, 1, DarkJudasGetsBonked)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and mod.MCMOption.Settings["Dark Judas"] > 1 and mod.MCMOption.Settings["Dark Judas"] < 4
end)
--#endregion