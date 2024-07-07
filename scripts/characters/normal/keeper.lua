--#region Keeper
local mod = ExtraBirthright
local Keeper = {}

local function OneFreebie(player)
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
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_KEEPER, 1, OneFreebie)

function Keeper:NewFloorNewDeal()
    mod.BirthrightfloorBought = false
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Keeper.NewFloorNewDeal)

local function PickupYourPrize(entity, collider)
	local trigger = false
	for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_KEEPER, PlayerType.PLAYER_EDEN_B})) do
		local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_LILITH or player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B then
			trigger = true
		end
	end
	if trigger then
		if collider.Type == EntityType.ENTITY_PLAYER and entity:ToPickup():IsShopItem() then
			mod.BirthrightfloorBought = true
		end
	end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PRE_PICKUP_COLLISION, 0, PlayerType.PLAYER_KEEPER, 1, PickupYourPrize)

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