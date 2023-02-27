--#region Judas
local mod = ExtraBirthright
local Judas = {}
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

function Judas:JudasBecomesStansPuppet(entity)
	local player = entity:ToPlayer()
	local data = mod.GetPersistentPlayerData(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Judas"],true)
	if player:HasCollectible(collectible) and (mod.MCMOption.Settings["Judas"] == 2 or mod.MCMOption.Settings["Judas"] == 4) and player:GetPlayerType() == PlayerType.PLAYER_JUDAS then
		local rngtrack = player:GetCollectibleRNG(collectible):RandomFloat()
		if rngtrack <= 0.2 and not data.JudasBirthBrimstone then
			player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE,true,1)
			data.JudasBirthBrimstone = true
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Judas.JudasBecomesStansPuppet, EntityType.ENTITY_PLAYER)

local addedCallbacks = {}

function Judas:JudasBirthBrimRemove()
	for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
		player = player:ToPlayer()
		local data = mod.GetPersistentPlayerData(player)
		data.JudasBirthBrimstone = false
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Judas.JudasBirthBrimRemove)

function Judas:JudasDamageAsStansPuppet(player,flag)
	local data = mod.GetPersistentPlayerData(player)
	if player:GetPlayerType() == PlayerType.PLAYER_JUDAS and flag == CacheFlag.CACHE_DAMAGE and data.JudasBirthBrimstone then
		player.Damage = player.Damage + 5
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Judas.JudasDamageAsStansPuppet)

function Judas:AntibirthUseTheBook(_,_,player)
	if ((player:GetPlayerType() == PlayerType.PLAYER_JUDAS and mod.MCMOption.Settings["Judas"] == 3)
	or (player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and mod.MCMOption.Settings["Dark Judas"] == 3)) and 
	player:HasCollectible(substituteBirthright) or 
	((player:GetPlayerType() == PlayerType.PLAYER_JUDAS and mod.MCMOption.Settings["Judas"] == 5)
	or (player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and mod.MCMOption.Settings["Dark Judas"] == 5)) and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON,false,false,false,false)
	end
end

function Judas:JudasSecondBirthrightAddCallbacks()
	local itemConf = Isaac.GetItemConfig()
	for i = 1, mod.GetMaxCollectibleID() do
		if itemConf:GetCollectible(i) then
			local item = itemConf:GetCollectible(i)
			if item.Tags & ItemConfig.TAG_BOOK == ItemConfig.TAG_BOOK and i ~= CollectibleType.COLLECTIBLE_HOW_TO_JUMP and
			i ~= CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL_PASSIVE and i ~= CollectibleType.COLLECTIBLE_NECRONOMICON then
				local add = true
				if #addedCallbacks > 0 then
					for _,v in pairs(addedCallbacks) do
						if v == i then
							add = false
							break
						end
					end
				end
				if add then
					table.insert(addedCallbacks,i)
					mod:AddCallback(ModCallbacks.MC_USE_ITEM, Judas.AntibirthUseTheBook, i)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Judas.JudasSecondBirthrightAddCallbacks)

function Judas:JudasSecondBirthrightRemoveCallbacks()
	if #addedCallbacks > 0 then
		for _,v in pairs(addedCallbacks) do
			mod:RemoveCallback(ModCallbacks.MC_USE_ITEM, mod.AntibirthUseTheBook, v)
		end
		addedCallbacks = {}
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Judas.JudasSecondBirthrightRemoveCallbacks)
--#endregion