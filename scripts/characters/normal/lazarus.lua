local mod = ExtraBirthright
local rerollDs = {CollectibleType.COLLECTIBLE_D100,CollectibleType.COLLECTIBLE_D4,CollectibleType.COLLECTIBLE_D_INFINITY}

function mod:GiveHavenCall()
    for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        player = player:ToPlayer()
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
        local collectible2 = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        if (mod.MCMOption.Settings["Lazarus"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS and player:HasCollectible(collectible)) or
        (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 and player:HasCollectible(collectible2)) then
            player:SetPocketActiveItem(mod.havenscall)
        end
        local data = mod:GetData(player)
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
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.GiveHavenCall)

function mod:LazCache(player,cache)
    if (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2) then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        if player:HasCollectible(collectible) then
            player.CanFly = true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.LazCache, CacheFlag.CACHE_FLYING)

function mod:Laz2Ser(player)
    if (mod.MCMOption.Settings["Lazarus"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS) then
        local data = mod:GetData(player)
        if data.RisenUsed and not player:IsDead() then
            player:Kill()
        end
    elseif (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2) then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        local data = mod:GetData(player)
        if player:HasCollectible(collectible) and not data.RisenItems then
            player:AddNullCostume(NullItemID.ID_ANGEL)
            local itemPool = Game():GetItemPool()
            for _,dice in pairs(rerollDs) do
                player:RemoveCollectible(dice)
            end
            if not data.RisenUsed and not player:HasCollectible(mod.havenscall) then
                player:SetPocketActiveItem(mod.havenscall)
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
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.Laz2Ser)

function mod:RerollScaryDs(collectibletype,itempooltype,decrease,seed)
    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
    local collectible2 = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
    local reroll = false
    for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        player = player:ToPlayer()
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
mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, mod.RerollScaryDs)

function mod:LazFingDies(collectibleType, rng, player)
    if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
        if player:HasCollectible(collectible) then
            local data = mod:GetData(player)
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
            local data = mod:GetData(player)
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
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.LazFingDies, mod.havenscall)

function mod:LazTempItemsReset()
    for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        player = player:ToPlayer()
        local data = mod:GetData(player)
        if data.RisenItemsTemp then
            for _,v in pairs(data.RisenItemsTemp) do
                player:RemoveCollectible(v)
            end
            data.RisenItemsTemp = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.LazTempItemsReset)