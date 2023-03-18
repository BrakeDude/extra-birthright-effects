local mod = ExtraBirthright
local IsaacM = {}
--#region Isaac
function IsaacM:D6Buff(_,rng,player)
	local game = Game()
	local room = game:GetRoom()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Isaac"])
	if mod.MCMOption.Settings["Isaac"] > 1 and player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_ISAAC then
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
	return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, IsaacM.D6Buff, CollectibleType.COLLECTIBLE_D6);
--#endregion