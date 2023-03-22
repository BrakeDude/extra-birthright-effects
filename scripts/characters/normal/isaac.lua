local mod = ExtraBirthright
local IsaacM = {}
--#region Isaac
local game = Game()
local function D6(collectible,rng,player,flags,ActiveSlot,data)
	local room = game:GetRoom()
	for i = 1, game:GetNumPlayers() do
		if Isaac.GetPlayer(i-1):HasCollectible(CollectibleType.COLLECTIBLE_CHAOS) then
			return nil
		end
	end
	local itemPool = game:GetItemPool()
	local PoolTable = {}
	local roomPool = itemPool:GetPoolForRoom(room:GetType(),rng:GetSeed())
	if game:IsGreedMode() then
		table.insert(PoolTable,ItemPoolType.POOL_GREED_TREASURE)
		table.insert(PoolTable,ItemPoolType.POOL_GREED_DEVIL)
		table.insert(PoolTable,ItemPoolType.POOL_GREED_ANGEL)
	else
		table.insert(PoolTable,ItemPoolType.POOL_TREASURE)
		table.insert(PoolTable,ItemPoolType.POOL_DEVIL)
		table.insert(PoolTable,ItemPoolType.POOL_ANGEL)
	end
	if not mod:Contains(PoolTable,roomPool) then
		table.insert(PoolTable,roomPool)
	end

	for _,item in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
		if item.SubType ~= CollectibleType.COLLECTIBLE_NULL then
			local old = item.SubType
			local ranPool = rng:RandomInt(#PoolTable) + 1
			local newitem = itemPool:GetCollectible(PoolTable[ranPool],true,rng:GetSeed(),old)
			item:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, newitem, true)	
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, item.Position, item.Velocity, player)
		end
	end
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_D6, "UseItem")
	return true
end

function IsaacM:D6Buff(collectible,rng,player,flags,ActiveSlot,data)
	local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Isaac"])
	if mod.MCMOption.Settings["Isaac"] > 1 and player:HasCollectible(col) and player:GetPlayerType() == PlayerType.PLAYER_ISAAC then
		return D6(collectible,rng,player,flags,ActiveSlot,data)
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, IsaacM.D6Buff, CollectibleType.COLLECTIBLE_D6);

mod:AddPriorityCallback(mod.Callbacks.MC_PRE_USE_ITEM, PlayerType.PLAYER_ISAAC, D6, CollectibleType.COLLECTIBLE_D6)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_ISAAC then
		if mod.MCMOption.Settings["Isaac"] > 1 and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_D6 then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_D6)
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_D6,ActiveSlot.SLOT_POCKET,true)
		end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_ISAAC and mod.MCMOption.Settings["Isaac"] == 2
end)
--#endregion