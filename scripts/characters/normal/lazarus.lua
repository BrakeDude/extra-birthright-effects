local mod = ExtraBirthright

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
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.GiveHavenCall)

function mod:Laz2Ser(player)
    if (mod.MCMOption.Settings["Lazarus Risen"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2) then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        local data = mod:GetData(player)
        if player:HasCollectible(collectible) and not data.RisenItems then
            local itemPool = Game():GetItemPool()
            for _,dice in pairs({CollectibleType.COLLECTIBLE_D100,CollectibleType.COLLECTIBLE_D4,CollectibleType.COLLECTIBLE_D_INFINITY}) do
                itemPool:RemoveCollectible(dice)
                player:RemoveCollectible(dice)
            end
            data.RisenItems = {}
            while #data.RisenItems < 3 do
                local itemSer = itemPool:GetCollectible(ItemPoolType.POOL_ANGEL)
                if not mod:Contains(data.RisenItems,itemSer) and Isaac.GetItemConfig():GetCollectible(itemSer).Tags & ItemConfig.TAG_ANGEL == ItemConfig.TAG_ANGEL then
                    player:AddCollectible(itemSer)
                    table.insert(data.RisenItems,itemSer)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.Laz2Ser)

function mod:LazFingDies(collectibleType, rng, player)
    if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus"])
        if player:HasCollectible(collectible) then
            player:Kill()
            for _,enemy in ipairs(Isaac.GetRoomEntities()) do
                if enemy:IsEnemy() and enemy:IsActiveEnemy() and enemy:IsVulnerableEnemy() then
                    local crack = Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.CRACK_THE_SKY,0,enemy.Position,Vector.Zero,player):ToEffect()
                    crack.CollisionDamage = enemy.MaxHitPoints * player:GetEffectiveMaxHearts() + player.Damage * 10
                end
            end
        end
    elseif player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lazarus Risen"])
        if player:HasCollectible(collectible) then
            local data = mod:GetData(player)
            if not data.RisenItemsTemp then
                data.RisenItemsTemp = {}
                while #data.RisenItemsTemp < 3 do
                    local itemSer = itemPool:GetCollectible(ItemPoolType.POOL_ANGEL)
                    if not mod:Contains(data.RisenItemsTemp,itemSer) then
                        player:AddCollectible(itemSer)
                        table.insert(data.RisenItemsTemp,itemSer)
                    end
                end
            end
        end
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