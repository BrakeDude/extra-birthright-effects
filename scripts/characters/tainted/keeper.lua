local mod = ExtraBirthright
local Keeper = {}

function Keeper:KeeperStatsUpdate(player)
    local data = mod.GetPersistentPlayerData(player)
    local rng = player:GetDropRNG()
    if not data.BonusKeeperDamage then
        data.BonusKeeperDamage = 0
    end
    if not data.BonusKeeperFrame then
        data.BonusKeeperFrame = 120
    end
    if not data.PrevCoinCount then
        data.PrevCoinCount = 0
    end
    if data.BonusKeeperDamage > 0 then
        if data.BonusKeeperFrame == 0 then
            data.BonusKeeperDamage = data.BonusKeeperDamage - (rng:RandomInt(5) + 1) * 0.01
            if data.BonusKeeperDamage < 0 then
                data.BonusKeeperDamage = 0
            end
            rng:Next()
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            player:EvaluateItems()
            data.BonusKeeperFrame = 120
        end
        data.BonusKeeperFrame = data.BonusKeeperFrame - 1
    elseif data.BonusKeeperFrame ~= 120 then
        data.BonusKeeperFrame = 120
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Keeper.KeeperStatsUpdate)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_KEEPER_B, 1, function(player)
    local data = mod.GetPersistentPlayerData(player)
    local rng = player:GetDropRNG()
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
            rng:Next()
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            player:EvaluateItems()
        end
        data.PrevCoinCount = player:GetNumCoins()
    end
end)

local function KeeperStats(player,cache)
    local data = mod.GetPersistentPlayerData(player)
    if data.BonusKeeperDamage then
        player.Damage = player.Damage + data.BonusKeeperDamage
    end
end
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_KEEPER_B, 1, KeeperStats, CacheFlag.CACHE_DAMAGE)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B and mod.MCMOption.Settings["Tainted Keeper"] == 2
end)