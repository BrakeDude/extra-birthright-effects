local mod = ExtraBirthright
local IsaacM = {}

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_USE_ITEM, 0, PlayerType.PLAYER_ISAAC_B, 1, function(col,rng,player,slot,vardata)
    if rng:RandomInt(10) == 1 then
        player:UseCard(Card.CARD_SOUL_ISAAC, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
    end
end, CollectibleType.COLLECTIBLE_SPINDOWN_DICE)

---@param player EntityPlayer
mod.AddOnPickupFunction(function(player)
    local ptype = player:GetPlayerType()
    if ptype == PlayerType.PLAYER_ISAAC_B then
        if mod.MCMOption.Settings["Tainted Isaac"] > 1 and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_SPINDOWN_DICE then
            player:RemoveCollectible(CollectibleType.COLLECTIBLE_SPINDOWN_DICE)
            player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_SPINDOWN_DICE,ActiveSlot.SLOT_POCKET,true)
        end
    end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_ISAAC_B and mod.MCMOption.Settings["Tainted Isaac"] == 2
end)