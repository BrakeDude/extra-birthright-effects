--#region Apollyon
local mod = ExtraBirthright

function mod:Stats(player,rng,list)
	for _,entity in ipairs(list) do
		if entity:Exists() and entity.SubType > 0 then
			if Isaac.GetItemConfig():GetCollectible(entity.SubType).Type ~= ItemType.ITEM_ACTIVE and not entity:ToPickup():IsShopItem() 
			and (Isaac.GetItemConfig():GetCollectible(entity.SubType).Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST) then 
				local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Apollyon"])
				local itemrng = player:GetCollectibleRNG(collectible)
				local data = mod:GetData(player)
				local quality = Isaac.GetItemConfig():GetCollectible(entity.SubType).Quality
				local maxstat = quality * 360
				local statsNames = {"Speed","FireDelay","Damage","Range","ShotSpeed","Luck"}
				local statsNum = rng:RandomInt(quality + 2) + 1
				statsNum = statsNum > quality and statsNum or quality
				for i = 1, statsNum do
					if maxstat > 0 then
						statsNames = mod.Shuffle(statsNames,rng)
						local j = itemrng:RandomInt(#statsNames) + 1
						local stat = i == statsNum and maxstat or (rng:RandomInt(math.ceil(maxstat/(statsNum - i + 1))+1))
						data.ApollyonStatUps[statsNames[j]] = data.ApollyonStatUps[statsNames[j]] + stat / 120
						maxstat = maxstat - statsNum
						table.remove(statsNames,j)
					end
				end
			end
		end
	end
end

function mod:Succ(collectible,rng,player)
	if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON then
		local itemList = Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)
		mod:Stats(player,rng,itemList)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.Succ, CollectibleType.COLLECTIBLE_VOID);

function mod:SuccStats(player,cache)
	if mod.MCMOption.Settings["Apollyon"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_APOLLYON then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Apollyon"])
		if player:HasCollectible(collectible) then
			local data = mod:GetData(player)
			player.MoveSpeed = player.MoveSpeed + data.ApollyonStatUps.Speed / 180
			player.MaxFireDelay = player.MaxFireDelay / (1 + data.ApollyonStatUps.FireDelay / 120)
			player.Damage = player.Damage + data.ApollyonStatUps.Damage / 17
			player.TearRange = player.TearRange + data.ApollyonStatUps.Range * 2.5
			player.ShotSpeed = player.ShotSpeed + data.ApollyonStatUps.ShotSpeed / 150
			player.Luck = player.Luck + data.ApollyonStatUps.Luck / 60
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.SuccStats)

function mod:PocketVoid(player)
	if mod.MCMOption.Settings["Apollyon"] > 1 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Apollyon"])
		if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_APOLLYON then
			if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= CollectibleType.COLLECTIBLE_VOID then
				if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_VOID then
					player:RemoveCollectible(CollectibleType.COLLECTIBLE_VOID,false,ActiveSlot.SLOT_POCKET)
				elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_VOID then
					player:RemoveCollectible(CollectibleType.COLLECTIBLE_VOID,false,ActiveSlot.SLOT_SECONDARY)
				end
				player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_VOID,ActiveSlot.SLOT_POCKET,true)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.PocketVoid)
--#endregion