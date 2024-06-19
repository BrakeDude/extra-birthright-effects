local mod = ExtraBirthright
local Esau = {}
local game = Game()
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

local function GetNewCollectible(id, pool, decrease, seed)
    local itemConfig = Isaac.GetItemConfig():GetCollectible(id)
    local itemPool = game:GetItemPool()
    if itemConfig.Quality ~= 2 and itemConfig.Quality ~= 3 and itemConfig.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST then
        return itemPool:GetCollectible(pool, decrease, seed)
    end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_GET_COLLECTIBLE, 0, PlayerType.PLAYER_ESAU, 1, GetNewCollectible)

local function NewReward(rng,spawnpos)
    if game:IsGreedMode() then return end
    local room = game:GetRoom()
    local level = game:GetLevel()
    local isContract = 1
    for i = 1, game:GetNumPlayers() do
        if Isaac.GetPlayer(i-1):HasCollectible(CollectibleType.COLLECTIBLE_CONTRACT_FROM_BELOW) then
            isContract = 2
        end
    end
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
    elseif level:CanSpawnDevilRoom() and rng:RandomInt(2) == 0 and room:IsCurrentRoomLastBoss() then
        if not REPENTOGON then
            level:InitializeDevilAngelRoom(false, true)
            room:TrySpawnDevilRoomDoor(true,true)
        end
        for j = 1,isContract do
            Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,room:FindFreePickupSpawnPosition(spawnpos, 1),Vector.Zero,nil)
        end
    else
        for j = 1,isContract do
            Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,room:FindFreePickupSpawnPosition(spawnpos, 1),Vector.Zero,nil)
        end
    end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD, 0, PlayerType.PLAYER_ESAU, 1, NewReward)

if not REPENTOGON then
    function Esau:OnlyForReward()
        local level = game:GetLevel()
        if mod.MCMOption.Settings["Esau"] > 1 then
            for _,player in ipairs(mod:GetPlayersByType({PlayerType.PLAYER_ESAU})) do
                local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
                if player:GetPlayerType() == PlayerType.PLAYER_ESAU and player:HasCollectible(collectible) then
                    level:DisableDevilRoom()
                end
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Esau.OnlyForReward)
else
    function Esau:OnNewLevel()
        if mod.MCMOption.Settings["Esau"] > 1 then
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
            if PlayerManager.AnyPlayerTypeHasCollectible(PlayerType.PLAYER_ESAU, collectible) then
                game:GetLevel():InitializeDevilAngelRoom(false, true)
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Esau.OnNewLevel)

    function Esau:Chance(float)
        if mod.MCMOption.Settings["Esau"] > 1 then
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
            if PlayerManager.AnyPlayerTypeHasCollectible(PlayerType.PLAYER_ESAU, collectible) then
                return 0.5
            end
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_DEVIL_CALCULATE, Esau.Chance)
end

function Esau:NoDuality(player)
    if mod.MCMOption.Settings["Esau"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Esau"])
        if player:GetPlayerType() == PlayerType.PLAYER_ESAU and player:HasCollectible(collectible) then
            for i = 1, game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i-1)
                if player:HasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then
                    player:RemoveCollectible(CollectibleType.COLLECTIBLE_DUALITY)
                end
            end
            local itempool = game:GetItemPool()
            local pooltype = itempool:GetLastPool()
            for _,item in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_DUALITY)) do
                local newitem = itempool:GetCollectible(pooltype)
                item:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, newitem, true, true)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Esau.NoDuality)

mod.AddOnPickupFunction(function(player)
    local ptype = player:GetPlayerType()
    if ptype == PlayerType.PLAYER_JACOB and mod.MCMOption.Settings["Jacob"] > 1 then
        local esau = player:GetOtherTwin()
        local randItems = {}
        local rng = mod.RNG
        for item = 1, mod.GetMaxCollectibleID() do
            if Isaac.GetItemConfig():GetCollectible(item) then
                local itemConf = Isaac.GetItemConfig():GetCollectible(item)
                if esau:HasCollectible(item) and itemConf.Type ~= ItemType.ITEM_ACTIVE
                and (itemConf.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST)
                and item ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT
                and item ~= substituteBirthright
                then
                    for i = 1, esau:GetCollectibleNum(item) do
                        table.insert(randItems,item)
                    end
                end
            end
        end
        randItems = mod.Shuffle(randItems,rng)
        local length = #randItems
        if length > 1 then
            repeat
                local i = rng:RandomInt(#randItems)+1
                player:AddCollectible(randItems[i],0,false)
                esau:RemoveCollectible(randItems[i])
                table.remove(randItems,i)
            until #randItems < length / 2
        elseif length == 1 then
            player:AddCollectible(randItems[1],0,false)
            esau:RemoveCollectible(randItems[1])
        end
        esau:AnimateCollectible(CollectibleType.COLLECTIBLE_RED_STEW)
        esau:QueueItem(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_RED_STEW))
    end
    if ptype == PlayerType.PLAYER_ESAU and mod.MCMOption.Settings["Esau"] > 1 then
        game:GetLevel():DisableDevilRoom()
        local itempool = game:GetItemPool()
        itempool:RemoveCollectible(CollectibleType.COLLECTIBLE_DUALITY)
        if REPENTOGON then
            game:GetLevel():InitializeDevilAngelRoom(false, true)
        end
    end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_JACOB and mod.MCMOption.Settings["Jacob"] == 2 or
    player:GetPlayerType() == PlayerType.PLAYER_ESAU and mod.MCMOption.Settings["Esau"] == 2
end)