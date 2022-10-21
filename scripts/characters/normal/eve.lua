local mod = ExtraBirthright

function mod:MoreBirds(player,_,damageflag)
    if damageflag & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE and damageflag & DamageFlag.DAMAGE_INVINCIBLE ~= DamageFlag.DAMAGE_INVINCIBLE then
        if mod.MCMOption.Settings["Eve"] > 1 then
            player = player:ToPlayer()
            local data = mod:GetData(player)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eve"])
            if player:HasCollectible(collectible) then
                local rng = player:GetCollectibleRNG(collectible)
                local chance = rng:RandomInt(100)
                if chance < 25 then
                    data.EveBirds = data.EveBirds + 1
                    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
                    player:EvaluateItems()
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.MoreBirds, EntityType.ENTITY_PLAYER)

function mod:BirdsCache(player,cache)
    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eve"])
    local data = mod.GetPersistentPlayerData(player)
    if not data.EveBirds then
        data.EveBirds = 0
    end
    if mod.MCMOption.Settings["Eve"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EVE and player:HasCollectible(collectible) then
        if data.EveBirds > 0 then
            player:CheckFamiliar(FamiliarVariant.DEAD_BIRD,data.EveBirds, player:GetCollectibleRNG(collectible))
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.BirdsCache, CacheFlag.CACHE_FAMILIARS)

function mod:BirdsReset()
    for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        player = player:ToPlayer()
        local data = mod.GetPersistentPlayerData(player)
        data.EveBirds = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.BirdsReset)