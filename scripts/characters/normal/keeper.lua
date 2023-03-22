--#region Keeper
local mod = ExtraBirthright
local Keeper = {}

function Keeper:OneFreebie(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Keeper"])
	if mod.MCMOption.Settings["Keeper"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_KEEPER and player:HasCollectible(collectible) then
			local entities = Isaac.FindByType(EntityType.ENTITY_PICKUP)
			for _,entity in ipairs(entities) do
				local pickup = entity:ToPickup()
				if mod.MCMOption.Settings["Keeper"] > 1 then
					if  pickup:IsShopItem() and not mod.BirthrightfloorBought then
						pickup.Price = PickupPrice.PRICE_FREE
					end
					pickup.AutoUpdatePrice = mod.BirthrightfloorBought
				else
					pickup.AutoUpdatePrice = true
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Keeper.OneFreebie)

function Keeper:NewFloorNewDeal()
    mod.BirthrightfloorBought = false
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Keeper.NewFloorNewDeal)

function Keeper:PickupYourPrize(entity, collider)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Keeper"])
	if mod.MCMOption.Settings["Keeper"] > 1 then
		local trigger = false
		for i = 1, Game():GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			if player:GetPlayerType() == PlayerType.PLAYER_KEEPER and player:HasCollectible(collectible) then
				trigger = true
			end
		end
		if trigger then
			if collider.Type == EntityType.ENTITY_PLAYER and entity:ToPickup():IsShopItem() then
				mod.BirthrightfloorBought = true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Keeper.PickupYourPrize)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_KEEPER and mod.MCMOption.Settings["Keeper"] > 1 then
		local trinket1 = player:GetTrinket(0)
		local trinket2 = player:GetTrinket(1)
		if trinket1 ~= 0 then player:TryRemoveTrinket(trinket1) end
		if trinket2 ~= 0 then player:TryRemoveTrinket(trinket2) end
		player:AddTrinket(TrinketType.TRINKET_SILVER_DOLLAR)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,false,false,true,false)
		player:AddTrinket(TrinketType.TRINKET_RIB_OF_GREED)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,false,false,true,false)
		if trinket1 ~= 0 then player:AddTrinket(trinket1) end
		if trinket2 ~= 0 then player:AddTrinket(trinket2) end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_KEEPER and mod.MCMOption.Settings["Keeper"] == 2
end)
--#endregion