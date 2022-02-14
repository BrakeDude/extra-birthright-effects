local mod = ExtraBirthright

function mod:postGetCollectible(id, pool, decrease, seed)
    local game = Game()
    if mod.MCMOption.Settings["Esau"] > 1 then
        for i = 1, game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
            if player:GetPlayerType() == PlayerType.PLAYER_ESAU and player:HasCollectible(collectible) then
                local itemConfig = Isaac.GetItemConfig():GetCollectible(id)
                local itemPool = game:GetItemPool()
                if itemConfig.Quality ~= 2 and itemConfig.Quality ~= 3 and itemConfig.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST then
                    return itemPool:GetCollectible(pool, decrease, seed)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, mod.postGetCollectible)

function mod:EsauReward(rng,spawnpos)
    local game = Game()
    local room = game:GetRoom()
    local level = game:GetLevel()
    if mod.MCMOption.Settings["Esau"] > 1
    and not game:IsGreedMode() then
        local isContract = 1
        for i = 1, game:GetNumPlayers() do
            if Isaac.GetPlayer(i-1):HasCollectible(CollectibleType.COLLECTIBLE_CONTRACT_FROM_BELOW) then
                isContract = 2
            end
        end
        for i = 1, game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
            if player:GetPlayerType() == PlayerType.PLAYER_ESAU and player:HasCollectible(collectible) then
                
                local pickup
                local chance = rng:RandomInt(20)
                if chance <= 12 then
                    pickup = mod.MyRandomPickup(rng)
                    if pickup.variant == PickupVariant.PICKUP_BOMB and pickup.subtype == BombSubType.BOMB_GOLDEN then
                        pickup.subtype = BombSubType.BOMB_NORMAL
                    elseif pickup.variant == PickupVariant.PICKUP_KEY and pickup.subtype == KeySubType.KEY_GOLDEN then
                        pickup.subtype = KeySubType.KEY_NORMAL
                    elseif pickup.variant == PickupVariant.PICKUP_LIL_BATTERY and pickup.subtype == BatterySubType.BATTERY_GOLDEN then
                        pickup.subtype = BatterySubType.BATTERY_NORMAL
                    end
                elseif chance <= 15 then
                    local subtype = (room:GetType() == RoomType.ROOM_DEVIL or room:GetType() == RoomType.ROOM_SUPERSECRET or room:GetType() == RoomType.ROOM_CURSE) and 2 or 1
                    pickup = {variant = PickupVariant.PICKUP_GRAB_BAG, subtype = subtype}
                elseif chance <= 17 then
                    pickup = mod.getChest(rng)
                else
                    pickup = {variant = PickupVariant.PICKUP_TRINKET, subtype = game:GetItemPool():GetTrinket()}
                end
                if (room:GetType() == RoomType.ROOM_BOSSRUSH or room:GetType() == RoomType.ROOM_CHALLENGE) and room:IsAmbushDone()then
                    for j = 1,isContract do
                        Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,room:FindFreePickupSpawnPosition(spawnpos, 1),Vector.Zero,nil)
                    end
                elseif room:GetType() ~= RoomType.ROOM_BOSS then
                    for j = 1,isContract do
                        Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,room:FindFreePickupSpawnPosition(spawnpos, 1),Vector.Zero,nil)
                    end
                    return true
                elseif level:CanSpawnDevilRoom() and rng:RandomInt(2) == 0 and room:IsCurrentRoomLastBoss() then
                    level:InitializeDevilAngelRoom(false, true)
                    room:TrySpawnDevilRoomDoor(true,true)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.EsauReward)

function mod:OnlyForReward()
    local game = Game()
    local level = game:GetLevel()
    if mod.MCMOption.Settings["Esau"] > 1 then
        for i = 1, game:GetNumPlayers() do
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
            local player = Isaac.GetPlayer(i-1)
            if player:GetPlayerType() == PlayerType.PLAYER_ESAU and player:HasCollectible(collectible) then
                level:DisableDevilRoom()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnlyForReward)

function mod:NoDuality(player)
    local game = Game()
    if mod.MCMOption.Settings["Esau"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
        if player:GetPlayerType() == PlayerType.PLAYER_ESAU and player:HasCollectible(collectible) then
            for i = 1, game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i-1)
                if player:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then
                    player:RemoveCollectible(CollectibleType.COLLECTIBLE_DUALITY)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.NoDuality)