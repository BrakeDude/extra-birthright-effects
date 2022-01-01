--#region Judas
local mod = ExtraBirthright
function mod:JudasBecomesStansPuppet(entity)
	local player = entity:ToPlayer()
	local data = mod:GetData(player)
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

function mod:JudasBirthBrimRemove()
	for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
		mod:GetData(player).JudasBirthBrimstone = false
	end
end

function mod:JudasDamageAsStansPuppet(player,flag)
	if player:GetPlayerType() == PlayerType.PLAYER_JUDAS and flag == CacheFlag.CACHE_DAMAGE and mod:GetData(player).JudasBirthBrimstone then
		player.Damage = player.Damage + 5
	end
end


function mod:AntibirthUseTheBook(_,_,player)
	if ((player:GetPlayerType() == PlayerType.PLAYER_JUDAS and mod.MCMOption.Settings["Judas"] == 3)
	or (player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and mod.MCMOption.Settings["Dark Judas"] == 3)) and 
	player:HasCollectible(mod.substituteBirthright) or 
	((player:GetPlayerType() == PlayerType.PLAYER_JUDAS and mod.MCMOption.Settings["Judas"] == 5)
	or (player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS and mod.MCMOption.Settings["Dark Judas"] == 5)) and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON,false,false,false,false)
	end
end

function mod.AddBookToBirthrightEffect(collectible)
	local book = (Isaac.GetItemConfig()):GetCollectible(collectible)
	if book.Tags & ItemConfig.TAG_BOOK == ItemConfig.TAG_BOOK then
		mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.AntibirthUseTheBook, collectible)
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.JudasBecomesStansPuppet, EntityType.ENTITY_PLAYER)
for _, book in ipairs(mod.Books) do
	mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.AntibirthUseTheBook, book)
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.JudasDamageAsStansPuppet)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.JudasBirthBrimRemove)
--#endregion