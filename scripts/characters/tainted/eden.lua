local mod = ExtraBirthright

local Eden = {}
local currentState = PlayerType.PLAYER_AZAZEL

local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

local function ChangeEdenState(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local data = mod.GetPersistentPlayerData(player)
        data.TEdenState = mod.RNG:RandomInt(PlayerType.NUM_PLAYER_TYPES)
    end
end

function Eden:CustomPreGetCollectible(itempool,decrease,seed)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_GET_COLLECTIBLE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local retr = callback.Function(itempool,decrease,seed)
                    if retr then
                        ret = retr
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, Eden.CustomPreGetCollectible)

function Eden:CustomPostGetCollectible(SelectedCollectible,itempool,decrease,seed)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_GET_COLLECTIBLE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local retr = callback.Function(SelectedCollectible,itempool,decrease,seed)
                    if retr ~= nil then
                        ret = retr
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, Eden.CustomPostGetCollectible)

function Eden:CustomCache(player,cache)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_EVALUATE_CACHE)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local cacheT = table.unpack(callback.Params)
                if cache == cacheT then
                    callback.Function(player,cache)
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Eden.CustomCache)

function Eden:CustomPrePlayerCollision(player, collider, low)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_PLAYER_COLLISION)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local pvariant = table.unpack(callback.Params)
                if not pvariant or mod.IsNumber(pvariant) and player.Variant == pvariant then
                    local ret = callback.Function(player, collider, low)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Eden.CustomPrePlayerCollision)

function Eden:CustomPrePickupCollision(pickup, collider, low)
    if collider and collider:ToPlayer() and collider:ToPlayer():GetPlayerType() == PlayerType.PLAYER_EDEN_B then
        local player = collider:ToPlayer()
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_PLAYER_COLLISION)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then 
                    local variant = table.unpack(callback.Params)
                    if not variant or mod.IsNumber(variant) and variant == pickup.Variant then
                        local ret = callback.Function(pickup, collider, low)
                        if ret ~= nil then
                            return ret
                        end
                    end
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Eden.CustomPrePickupCollision)

function Eden:CustomPreUse(collectible,rng,player,flags,ActiveSlot,customdata)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_USE_ITEM)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then 
                local collectibleID = table.unpack(callback.Param)
                if not collectibleID or mod.IsNumber(collectibleID) and collectibleID == collectible then
                    local ret = callback.Function(collectible,rng,player,flags,ActiveSlot,customdata)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, Eden.CustomPreUse)

function Eden:CustomUse(collectible,rng,player,flags,ActiveSlot,customdata)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_ITEM)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local collectibleID = table.unpack(callback.Param)
                if not collectibleID or mod.IsNumber(collectibleID) and collectibleID == collectible then
                    local ret = callback.Function(collectible,rng,player,flags,ActiveSlot,customdata)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Eden.CustomUse)

function Eden:CustomCardUse(card,player,flags)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_CARD)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then 
                local cardID = table.unpack(callback.Param)
                if not cardID or mod.IsNumber(cardID) and cardID == card then
                    callback.Function(card,player,flags)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, Eden.CustomCardUse)

function Eden:CustomPillUse(pill,player,flags)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_CARD)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then 
                local pillID = table.unpack(callback.Param)
                if not pillID or mod.IsNumber(pillID) and pillID == pill then
                    callback.Function(pill,player,flags)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_PILL, Eden.CustomPillUse)

function Eden:CustomPlayerUpdate(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local pvariant = table.unpack(callback.Param)
                if not pvariant or mod.IsNumber(pvariant) and pvariant == player.Variant then
                    callback.Function(player)
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Eden.CustomPlayerUpdate)

function Eden:CustomPlayerInit(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks =  mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PLAYER_INIT)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local pvariant = table.unpack(callback.Param)
                if not pvariant or mod.IsNumber(pvariant) and pvariant == player.Variant then
                    callback.Function(player)
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Eden.CustomPlayerInit)

function Eden:CustomPEffectUpdate(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PEFFECT_UPDATE)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                callback.Function(player)
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Eden.CustomPEffectUpdate)

function Eden:CustomPostNPCInit(npc)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_NPC_INIT)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local npcType = table.unpack(callback.Param)
                    if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
                        callback.Function(npc)
                    end
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, Eden.CustomPostNPCInit)

function Eden:CustomNPCUpdate(npc)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_NPC_UPDATE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local npcType = table.unpack(callback.Param)
                    if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
                        callback.Function(npc)
                    end
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Eden.CustomNPCUpdate)

function Eden:CustomPostNPCRender(npc, offset)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_NPC_RENDER)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local npcType = table.unpack(callback.Param)
                    if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
                        callback.Function(npc, offset)
                    end
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, Eden.CustomPostNPCRender)

function Eden:CustomPostNPCDeath(npc)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_NPC_DEATH)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local npcType = table.unpack(callback.Param)
                    if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
                        callback.Function(npc)
                    end
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, Eden.CustomPostNPCDeath)

function Eden:CustomPreSpawnReward(rng,spawnpos)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    callback.Function(rng,spawnpos)
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Eden.CustomPreSpawnReward)

function Eden:CustomNewLevel()
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_NEW_LEVEL)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    callback.Function()
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Eden.CustomNewLevel)

function Eden:CustomNewRoom()
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_NEW_ROOM)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    callback.Function()
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Eden.CustomNewRoom)

function Eden:CustomPostPickupInit(pickup)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_INIT)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local variant = table.unpack(callback.Param)
                    if not variant or mod.IsNumber(variant) and variant == pickup.Variant then
                        callback.Function(pickup)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, Eden.CustomPostPickupInit)

function Eden:CustomPostPickupUpdate(pickup)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_UPDATE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local variant = table.unpack(callback.Param)
                    if not variant or mod.IsNumber(variant) and variant == pickup.Variant then
                        callback.Function(pickup)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, Eden.CustomPostPickupUpdate)

function Eden:ChangeOnHit(entity, amount, flags, source, cd)
    local player = entity:ToPlayer()
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local ret = callback.Function(player,amount,flags,source,cd)
                if ret == false then
                    return ret
                end
            end
        end
        ChangeEdenState(player)
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -1, Eden.ChangeOnHit, EntityType.ENTITY_PLAYER)

function Eden:CustomEntityTakeDmg(entity, amount, flags, source, cd)
    if entity and not entity:ToPlayer() then
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        local hasBR = false
        for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
            hasBR = player:HasCollectible(col) or hasBR
        end
        if hasBR and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_NON_PLAYER_TAKE_DMG)
            for ptype, callback in ipairs(callbacks) do
                if callback.Mod.Name == mod.Name and (not callback.Param or callback.Param and callback.Param == entity.Type) then
                    local ret = callback.Function(entity,amount,flags,source,cd)
                    if ret == false then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -1, Eden.CustomEntityTakeDmg)

function Eden:DataUpdate(player)
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
        local data = mod.GetPersistentPlayerData(player)
        if not data.TEdenState then
            data.TEdenState = currentState--RNG():RandomInt(PlayerType.NUM_PLAYER_TYPES)
        end
        if player:HasCollectible(mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])) then
            data.EdenPickedUpBirthright = true
        end
        if mod.MCMOption.Settings["Tainted Eden"] == 2 and data.EdenPickedUpBirthright and Game():GetFrameCount() > 1 then
            if not player:HasCollectible(substituteBirthright) then
                local rng = mod.RNG
                local randItems = {}
                for item = 1, mod.GetMaxCollectibleID() do
                    if Isaac.GetItemConfig():GetCollectible(item) then
                        local itemConf = Isaac.GetItemConfig():GetCollectible(item)
                        if player:HasCollectible(item) and itemConf.Type ~= ItemType.ITEM_ACTIVE
                        and (itemConf.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST)
                        then
                            for i = 1, player:GetCollectibleNum(item) do
                                table.insert(randItems,item)
                            end
                        end
                    end
                end
                randItems = mod.Shuffle(randItems,rng)
                player:AddCollectible(substituteBirthright,0,false)
                player:RemoveCollectible(randItems[rng:RandomInt(#randItems)+1])
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Eden.DataUpdate)

function Eden:ChangeOnNewRoom()
    for _, player in ipairs(mod:GetPlayers()) do
        ChangeEdenState(player)
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Eden.ChangeOnHit, EntityType.ENTITY_PLAYER)



mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and mod.MCMOption.Settings["Tainted Eden"] == 2
end)