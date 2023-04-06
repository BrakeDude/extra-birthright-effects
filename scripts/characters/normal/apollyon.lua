--#region Apollyon
local mod = ExtraBirthright
local Apollyon = {}

local function Succlogic(player)
	local data = mod.GetPersistentPlayerData(player)
	if data.PocketItems then
		if data.PocketItems.Card or data.PocketItems.Pill then
			if data.PocketItems.Card then
				local flag = UseFlag.USE_NOANIM
				if player:HasCollectible(CollectibleType.COLLECTIBLE_TAROT_CLOTH) then
					flag = flag | UseFlag.USE_CARBATTERY
				end
				for _,sub in ipairs(data.PocketItems.Card) do
					player:UseCard(sub, flag)
				end
			end
			if data.PocketItems.Pill then
				local flag = UseFlag.USE_NOANIM
				for _,sub in ipairs(data.PocketItems.Pill) do
					player:UsePill(Game():GetItemPool():GetPillEffect(sub),sub,flag)
				end
			end
			data.PocketItems.Card = nil
			data.PocketItems.Pill = nil
		else
			local tabl = {Card = PickupVariant.PICKUP_TAROTCARD, Pill = PickupVariant.PICKUP_PILL}
			for key,variant in pairs(tabl) do
				data.PocketItems[key] = {}
				
				for _,pickup in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, variant)) do
					pickup = pickup:ToPickup()
				
					if not pickup:IsShopItem() then
						table.insert(data.PocketItems[key], pickup.SubType)
						pickup:Remove()
						Isaac.Spawn(1000, EffectVariant.POOF01,0,pickup.Position,Vector.Zero,nil)
					end
				end
				if #data.PocketItems[key] == 0 then data.PocketItems[key] = nil end	
			end
		end
	end
end

local function StatCache(player,cache)

end

function Apollyon:Cache(player,cache)
	local birth = mod.GetOptionsBirthright(mod.MCMOption.Settings["Apollyon"])
	if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON and mod.MCMOption.Settings["Apollyon"] > 1 and player:HasCollectible(birth) then
		StatCache(player,cache)
	end
end

function Apollyon:Succ(collectible,rng,player)
	local birth = mod.GetOptionsBirthright(mod.MCMOption.Settings["Apollyon"])
	if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON and mod.MCMOption.Settings["Apollyon"] > 1 and player:HasCollectible(birth) then
		Succlogic(player)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Apollyon.Succ, CollectibleType.COLLECTIBLE_VOID)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_USE_ITEM, 0, PlayerType.PLAYER_APOLLYON, function(collectible,rng,player,flags,ActiveSlot,customdata)
	Succlogic(player)
end, CollectibleType.COLLECTIBLE_VOID)



mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_APOLLYON then
		if mod.MCMOption.Settings["Apollyon"] > 1 and player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_VOID then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_VOID)
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_VOID,ActiveSlot.SLOT_POCKET,true)
		end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_APOLLYON and mod.MCMOption.Settings["Apollyon"] == 2
end)
--#endregion