local mod = ExtraBirthright
--#region Samson
function mod:TSamsonCache(player,cache)
	if mod.MCMOption.Settings["Tainted Samson"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Samson"],false)
			local data = mod:GetData(player)
			if player:HasCollectible(collectible) then
				local damage = 0
				for i = 0, data.GotHit do
					damage = damage + 1.5/(i+1)
				end
				player.Damage = player.Damage + damage / 4 * (data.RoomEnemies + 1) * (player:GetTrinketMultiplier(TrinketType.TRINKET_SAMSONS_LOCK) * 0.5 + 1)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.TSamsonCache, CacheFlag.CACHE_DAMAGE)

function mod:SamsonNewLevel()
	if mod.MCMOption.Settings["Tainted Samson"] > 1 then
		for i = 1,mod.game:GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
				local data = mod:GetData(player)
				data.GotHit = 0
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.SamsonNewLevel)

function mod:TSamson(player)
	if mod.MCMOption.Settings["Tainted Samson"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
			local data = mod:GetData(player)
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Samson"],false)
			if player:HasCollectible(collectible) then
				local enemycount = 0
				for _,enemy in ipairs(Isaac.FindInRadius(player.Position,100)) do
					if enemy:IsVulnerableEnemy() and not EntityRef(enemy).IsCharmed then
						enemycount = enemycount + 1
					end
				end
				if enemycount ~= data.RoomEnemies or data.HairLock ~= player:HasTrinket(TrinketType.TRINKET_SAMSONS_LOCK,true) then
					data.RoomEnemies = enemycount
					data.HairLock = player:HasTrinket(TrinketType.TRINKET_SAMSONS_LOCK,true)
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
					player:EvaluateItems()
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE,mod.TSamson)

function mod:TSamsonDamaged(player)
	player = player:ToPlayer()
	if mod.MCMOption.Settings["Tainted Samson"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Samson"],false)
			local data = mod:GetData(player)
			if player:HasCollectible(collectible) then
				data.GotHit = data.GotHit + 1
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:EvaluateItems()
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG,mod.TSamsonDamaged, EntityType.ENTITY_PLAYER)
--#endregion