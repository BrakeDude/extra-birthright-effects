local mod = ExtraBirthright

local Eden = {}
local currentState = PlayerType.PLAYER_AZAZEL

local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

function Eden:CustomCache(player,cache)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_EVALUATE_CACHE_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                callback.Function(player,cache)
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Eden.CustomCache)

function Eden:CustomPreUse(collectible,rng,player,flags,ActiveSlot,customdata)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_PRE_USE_ITEM_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState and 
            (not callback.Param or callback.Param and callback.Param == collectible) then
                local ret = callback.Function(collectible,rng,player,flags,ActiveSlot,customdata)
                return ret
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, Eden.CustomPreUse)

function Eden:CustomUse(collectible,rng,player,flags,ActiveSlot,customdata)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_USE_ITEM_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState and 
            (not callback.Param or callback.Param and callback.Param == collectible) then
                local ret = callback.Function(collectible,rng,player,flags,ActiveSlot,customdata)
                return ret
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Eden.CustomUse)

function Eden:CustomPlayerUpdate(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_POST_PLAYER_UPDATE_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                callback.Function(player)
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Eden.CustomPlayerUpdate)

function Eden:CustomPlayerInit(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_POST_PLAYER_INIT_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                callback.Function(player)
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Eden.CustomPlayerInit)

function Eden:CustomPEffectUpdate(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_POST_PEFFECT_UPDATE_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                callback.Function(player)
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Eden.CustomPEffectUpdate)

function Eden:CustomPostNPCDeath(npc)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = Isaac.GetCallbacks("MC_POST_NPC_DEATH_TEDEN")
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                    callback.Function(npc)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, Eden.CustomPostNPCDeath)

function Eden:CustomPreSpawnReward(rng,spawnpos)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = Isaac.GetCallbacks("MC_PRE_SPAWN_CLEAN_AWARD_TEDEN")
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                    callback.Function(rng,spawnpos)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Eden.CustomPreSpawnReward)

function Eden:CustomPostCollectibleUpdate(pickup)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = Isaac.GetCallbacks("MC_POST_PICKUP_UPDATE_TEDEN")
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState and (callback.Param == nil or callback.Param ~= nil and callback.Param == pickup.Variant) then
                    local ret = callback.Function(pickup)
                    if ret then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, Eden.CustomPostCollectibleUpdate)

local function ChangeEdenState(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local data = mod.GetPersistentPlayerData(player)
        data.TEdenState = currentState--RNG():RandomInt(PlayerType.NUM_PLAYER_TYPES)
    end
end

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

function Eden:ChangeOnHit(entity, amount, flags, source, cd)
    local player = entity:ToPlayer()
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = Isaac.GetCallbacks("MC_ENTITY_TAKE_DMG_TEDEN")
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.Mod.Name == mod.Name and callback.Priority == data.TEdenState then
                local ret = callback.Function(player,amount,flags,source,cd)
                if ret == false then
                    return ret
                end
            end
        end
        ChangeEdenState(player)
    end
end
mod:AddPriorityCallback(mod.Callbacks.MC_ENTITY_TAKE_DMG, 1, Eden.ChangeOnHit, EntityType.ENTITY_PLAYER)

function Eden:ChangeOnNewRoom()
    for _, player in ipairs(mod:GetPlayers()) do
        ChangeEdenState(player)
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Eden.ChangeOnHit, EntityType.ENTITY_PLAYER)



mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and mod.MCMOption.Settings["Tainted Eden"] == 2
end)