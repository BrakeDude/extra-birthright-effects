local mod = ExtraBirthright

function mod:MoreBirds(player,_,damageflag)
    if damageflag & DamageFlag.DAMAGE_IV_BAG ~= DamageFlag.DAMAGE_IV_BAG and damageflag & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE and
    damageflag & DamageFlag.DAMAGE_RED_HEARTS ~= DamageFlag.DAMAGE_RED_HEARTS and damageflag & DamageFlag.DAMAGE_INVINCIBLE ~= DamageFlag.DAMAGE_INVINCIBLE and
    damageflag & DamageFlag.DAMAGE_SPIKES ~= DamageFlag.DAMAGE_SPIKES and damageflag & DamageFlag.DAMAGE_POOP ~= DamageFlag.DAMAGE_POOP and
    damageflag & DamageFlag.DAMAGE_TIMER ~= DamageFlag.DAMAGE_TIMER and damageflag & DamageFlag.DAMAGE_CURSED_DOOR ~= DamageFlag.DAMAGE_CURSED_DOOR then
        if mod.MCMOption.Settings["Eve"] > 1 then
            player = player:ToPlayer()
            local data = mod:GetData(player)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eve"])
            if player:HasCollectible(collectible) then
                local rng = player:GetCollectibleRNG(collectible)
                local birds = 0
                for _,bird in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DEAD_BIRD)) do
                    bird = bird:ToFamiliar()
                    if GetPtrHash(bird.Player) == GetPtrHash(player) then
                        birds = birds + 1
                    end
                end
                if birds > data.EveBirds and rng:RandomInt(4) == 1 then
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
    local data = mod:GetData(player)
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
        local data = mod:GetData(player)
        data.EveBirds = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.BirdsReset)