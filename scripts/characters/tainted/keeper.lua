local mod = ExtraBirthright
local Keeper = {}

function Keeper:KeeperStatsUpdate(player)
    if mod.MCMOption.Settings["Tainted Keeper"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Keeper"])
        if player:HasCollectible(collectible) then
            local data = mod.GetPersistentPlayerData(player)
            local rng = player:GetCollectibleRNG(collectible)
            if not data.BonusKeeperDamage then
                data.BonusKeeperDamage = 0
            end
            if not data.BonusKeeperFrame then
                data.BonusKeeperFrame = 120
            end
            if not data.PrevCoinCount then
                data.PrevCoinCount = 0
            end
            if data.PrevCoinCount ~= player:GetNumCoins() then
                local diff = player:GetNumCoins() - data.PrevCoinCount
                if diff > 0 then
                    data.BonusKeeperDamage = data.BonusKeeperDamage + diff * (0.05 + (rng:RandomInt(3) + 1) * 0.01)
                    player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                    player:EvaluateItems()
                end
                data.PrevCoinCount = player:GetNumCoins()
            end
            if data.BonusKeeperDamage > 0 then
                if data.BonusKeeperFrame == 0 then
                    data.BonusKeeperDamage = data.BonusKeeperDamage - (rng:RandomInt(5) + 1) * 0.01
                    if data.BonusKeeperDamage < 0 then
                        data.BonusKeeperDamage = 0
                    end
                    player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                    player:EvaluateItems()
                    data.BonusKeeperFrame = 120
                end
                data.BonusKeeperFrame = data.BonusKeeperFrame - 1
            elseif data.BonusKeeperFrame ~= 120 then
                data.BonusKeeperFrame = 120
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Keeper.KeeperStatsUpdate)

function Keeper:KeeperStats(player,cache)
    if mod.MCMOption.Settings["Tainted Keeper"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Keeper"])
        local data = mod.GetPersistentPlayerData(player)
        if player:HasCollectible(collectible) then
            player.Damage = player.Damage + data.BonusKeeperDamage
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Keeper.KeeperStats, CacheFlag.CACHE_DAMAGE)