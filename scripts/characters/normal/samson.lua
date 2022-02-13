local mod = ExtraBirthright
function mod:SamsonStronk(player)
	if mod.MCMOption.Settings["Samson"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Samson"],false)
        if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
			if player:HasCollectible(collectible) then
                if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) then
                    player:UseActiveItem(CollectibleType.COLLECTIBLE_MOMS_BRACELET)
                end
            end
        end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.SamsonStronk)

function mod:SamsonCache(player,cache)
	if mod.MCMOption.Settings["Samson"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Samson"],false)
			if player:HasCollectible(collectible) then
				player.Damage = player.Damage + 4
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.SamsonCache, CacheFlag.CACHE_DAMAGE)