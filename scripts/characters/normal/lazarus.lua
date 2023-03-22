local mod = ExtraBirthright
local rerollDs = {CollectibleType.COLLECTIBLE_D100,CollectibleType.COLLECTIBLE_D4,CollectibleType.COLLECTIBLE_D_INFINITY}
local havenscall = Isaac.GetItemIdByName("Haven's Call")
local Laz = {}

function Laz:GiveHavenCall()
    for _,player in ipairs(mod:GetPlayers()) do
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
        local collectible2 = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        if (mod.MCMOption.Settings["Lazarus"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS and player:HasCollectible(collectible)) or
        (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 and player:HasCollectible(collectible2)) then
            player:SetPocketActiveItem(havenscall)
        end
        local data = mod.GetPersistentPlayerData(player)
        if data.RisenItems then
            for _,v in pairs(data.RisenItems) do
                player:RemoveCollectible(v)
            end
            data.RisenItems = nil
        end
        if data.RisenUsed then
            data.RisenUsed = nil
        end
        if not player:HasPlayerForm(PlayerForm.PLAYERFORM_ANGEL) then
            player:TryRemoveNullCostume(NullItemID.ID_ANGEL)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Laz.GiveHavenCall)

function Laz:LazCache(player,cache)
    if (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2) then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        if player:HasCollectible(collectible) then
            player.CanFly = true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Laz.LazCache, CacheFlag.CACHE_FLYING)

function Laz:Laz2Ser(player)
    if (mod.MCMOption.Settings["Lazarus"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS) then
        local data = mod.GetPersistentPlayerData(player)
        if data.RisenUsed and not player:IsDead() then
            player:Die()
        end
    elseif (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2) then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        local data = mod.GetPersistentPlayerData(player)
        if player:HasCollectible(collectible) and not data.RisenItems then
            player:AddNullCostume(NullItemID.ID_ANGEL)
            local itemPool = Game():GetItemPool()
            for _,dice in pairs(rerollDs) do
                player:RemoveCollectible(dice)
            end
            if not data.RisenUsed and not player:HasCollectible(havenscall) then
                player:SetPocketActiveItem(havenscall)
            end
            data.RisenItems = {}
            while #data.RisenItems < 3 do
                local itemSer = itemPool:GetCollectible(ItemPoolType.POOL_ANGEL)
                local itemConfig = Isaac.GetItemConfig():GetCollectible(itemSer)
                if not mod:Contains(data.RisenItems,itemSer) and itemConfig.Tags & ItemConfig.TAG_ANGEL == ItemConfig.TAG_ANGEL
                and itemConfig.Type ~= ItemType.ITEM_ACTIVE then
                    player:AddCollectible(itemSer,0,false)
                    table.insert(data.RisenItems,itemSer)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Laz.Laz2Ser)

function Laz:RerollScaryDs(collectibletype,itempooltype,decrease,seed)
    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
    local collectible2 = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
    local reroll = false
    for _,player in ipairs(mod:GetPlayers()) do
        if (mod.MCMOption.Settings["Lazarus"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS and player:HasCollectible(collectible)) or
        (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 and player:HasCollectible(collectible2)) then
            reroll = true
            break
        end
    end
    if not reroll then return nil end
    while mod:Contains(rerollDs,collectibletype) do
        collectibletype = Game():GetItemPool():GetCollectible(itempooltype,false,seed)
    end
    return collectibletype
end
mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, Laz.RerollScaryDs)

function Laz:LazFingDies(collectibleType, rng, player)
    if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
        if player:HasCollectible(collectible) then
            local data = mod.GetPersistentPlayerData(player)
            data.RisenUsed = true
            for _,enemy in ipairs(Isaac.GetRoomEntities()) do
                if enemy:IsEnemy() and enemy:IsActiveEnemy() and enemy:IsVulnerableEnemy() then
                    local crack = Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.CRACK_THE_SKY,0,enemy.Position,Vector.Zero,player):ToEffect()
                    crack:GetSprite().PlaybackSpeed = 1.5
                    if enemy.MaxHitPoints > 10 then
                        enemy:TakeDamage(player:GetEffectiveMaxHearts() * enemy.MaxHitPoints + 10 * player.Damage,0,EntityRef(player),10)
                    end
                end
            end
        end
        return {Remove = true, ShowAnim = false}
    elseif player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        if player:HasCollectible(collectible) then
            local data = mod.GetPersistentPlayerData(player)
            if not data.RisenItemsTemp then
                data.RisenItemsTemp = {}
                while #data.RisenItemsTemp < 3 do
                    local itemSer = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL)
                    local itemConfig = Isaac.GetItemConfig():GetCollectible(itemSer)
                    if not mod:Contains(data.RisenItems,itemSer) and not mod:Contains(data.RisenItemsTemp,itemSer) and itemConfig.Tags & ItemConfig.TAG_ANGEL == ItemConfig.TAG_ANGEL
                    and itemConfig.Type ~= ItemType.ITEM_ACTIVE then
                        player:AddCollectible(itemSer,0,false)
                        table.insert(data.RisenItemsTemp,itemSer)
                    end
                end
            end
        end
        return {Remove = true, ShowAnim = true}
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Laz.LazFingDies, havenscall)

function Laz:LazTempItemsReset()
    for _,player in ipairs(mod:GetPlayers()) do
        local data = mod.GetPersistentPlayerData(player)
        if data.RisenItemsTemp then
            for _,v in pairs(data.RisenItemsTemp) do
                player:RemoveCollectible(v)
            end
            data.RisenItemsTemp = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Laz.LazTempItemsReset)

mod.AddOnPickupFunction(function(player)
    local ptype = player:GetPlayerType()
    if (ptype == PlayerType.PLAYER_LAZARUS and mod.MCMOption.Settings["Lazarus"] > 1) or (ptype == PlayerType.PLAYER_LAZARUS2 and mod.MCMOption.Settings["Lazarus Risen"] > 1) then
        player:SetPocketActiveItem(havenscall)
    end
    if ptype == PlayerType.PLAYER_LAZARUS2 and mod.MCMOption.Settings["Lazarus Risen"] > 1 then
        player:AddCacheFlags(CacheFlag.CACHE_FLYING)
        player:EvaluateItems()
    end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_LAZARUS and mod.MCMOption.Settings["Lazarus"] == 2 or
    player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 and mod.MCMOption.Settings["Lazarus Risen"] == 2
end)