local mod = ExtraBirthright
local Eve = {}

local function BirdsOnDamage(player,amount,damageflag,source,cd)
    if damageflag & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE and damageflag & DamageFlag.DAMAGE_INVINCIBLE ~= DamageFlag.DAMAGE_INVINCIBLE then
        local data = mod.GetPersistentPlayerData(player)
        if not data.EveBirds then
            data.EveBirds = 0
        end
        local rng = player:GetDropRNG()
        local chance = rng:RandomInt(100)
        if chance < 25 then
            data.EveBirds = data.EveBirds + 1
            player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
            player:EvaluateItems()
        end
        rng:Next()
    end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_EVE, 1, BirdsOnDamage)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_EVE, 1, function(player,cache)
    local data = mod.GetPersistentPlayerData(player)
    if not data.EveBirds then
        data.EveBirds = 0
    end
    if data.EveBirds > 0 then
        player:CheckFamiliar(FamiliarVariant.DEAD_BIRD, data.EveBirds, player:GetDropRNG())
    end
end, CacheFlag.CACHE_FAMILIARS)

function Eve:BirdsReset()
    for _,player in ipairs(mod:GetPlayers()) do
        local data = mod.GetPersistentPlayerData(player)
        data.EveBirds = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Eve.BirdsReset)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_EVE and mod.MCMOption.Settings["Eve"] == 2
end)