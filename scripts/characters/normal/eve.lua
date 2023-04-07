local mod = ExtraBirthright
local Eve = {}

local function BirdsOnDamage(player,amount,damageflag,source,cd)
    if damageflag & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE and damageflag & DamageFlag.DAMAGE_INVINCIBLE ~= DamageFlag.DAMAGE_INVINCIBLE then
        local data = mod.GetPersistentPlayerData(player)
        local rng = mod.RNG
        local chance = rng:RandomInt(100)
        if chance < 25 then
            data.EveBirds = data.EveBirds + 1
            player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
            player:EvaluateItems()
        end
    end
end

function Eve:MoreBirds(player,amount,damageflag,source,cd)
    player = player:ToPlayer()
    if mod.MCMOption.Settings["Eve"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EVE then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eve"])
        if player:HasCollectible(collectible) then
            BirdsOnDamage(player,amount,damageflag,source,cd)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Eve.MoreBirds, EntityType.ENTITY_PLAYER)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_EVE, BirdsOnDamage)

function Eve:BirdsCache(player,cache)
    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eve"])
    local data = mod.GetPersistentPlayerData(player)
    if not data.EveBirds then
        data.EveBirds = 0
    end
    if mod.MCMOption.Settings["Eve"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EVE and player:HasCollectible(collectible) then
        if data.EveBirds > 0 then
            player:CheckFamiliar(FamiliarVariant.DEAD_BIRD,data.EveBirds, mod.RNG)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Eve.BirdsCache, CacheFlag.CACHE_FAMILIARS)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_NON_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_EVE, function(player,cache)
    local data = mod.GetPersistentPlayerData(player)
    if data.EveBirds > 0 then
        player:CheckFamiliar(FamiliarVariant.DEAD_BIRD,data.EveBirds, mod.RNG)
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