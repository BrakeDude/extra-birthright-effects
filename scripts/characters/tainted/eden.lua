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

--#region 1
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
--#endregion

--#region 2
function Eden:CustomPostUpdate()
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_UPDATE)
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
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Eden.CustomPostUpdate)
--#endregion

--#region 3
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
--#endregion

--#region 4
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
--#endregion

--#region 5
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
--#endregion

--#region 6
function Eden:CustomFamiliarUpdate(familiar)
    local player = familiar.Player
    if player then
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_FAMILIAR_UPDATE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local famType = table.unpack(callback.Param)
                    if not famType or mod.IsNumber(famType) and famType == familiar.Type then
                        callback.Function(familiar)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Eden.CustomFamiliarUpdate)
--#endregion

--#region 7
function Eden:CustomFamiliarInit(familiar)
    local player = familiar.Player
    if player then
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_FAMILIAR_INIT)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local famType = table.unpack(callback.Param)
                    if not famType or mod.IsNumber(famType) and famType == familiar.Type then
                        callback.Function(familiar)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Eden.CustomFamiliarInit)
--#endregion

--#region 8
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
--#endregion

--#region 9
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
--#endregion

--#region 10
function Eden:CustomPillUse(pill,player,flags)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_PILL)
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
--#endregion

--#region 11
function Eden:CustomEntityTakeDmg(entity, amount, flags, source, cd)
    if entity then
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        local hasBR = false
        for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
            hasBR = player:HasCollectible(col) or hasBR
        end
        if source.Entity and source.Entity:ToPlayer() then
            local player = source.Entity:ToPlayer()
            hasBR = player:HasCollectible(col) or hasBR
        end
        if hasBR and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_ENTITY_TAKE_DMG)
            for ptype, callback in ipairs(callbacks) do
                local etype = table.unpack(callback.Param)
                if not etype or mod.IsNumber(etype) and etype == entity.Type then
                    local ret = callback.Function(entity,amount,flags,source,cd)
                    if ret == false then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Eden.CustomEntityTakeDmg)
--#endregion

--#region 12
function Eden:CustomPostCurseEval(curse)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_CURSE_EVAL)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local newcurse = callback.Function(curse)
                    if not newcurse or mod.IsNumber(newcurse) then
                        curse = newcurse
                    end
                end
            end
        end
    end
    return curse
end
mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, Eden.CustomPostCurseEval)
--#endregion

--#region 13

--#endregion

--#region 14

--#endregion

--#region 15

--#endregion

--#region 16

--#endregion

--#region 17

--#endregion

--#region 18
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
--#endregion

--#region 19
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
--#endregion

--#region 20
function Eden:CustomGetCard(rng, card, playing, runes, onlyrunes)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_GET_CARD)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local newcard = callback.Function(rng,card,playing,runes,onlyrunes)
                    if not newcard or mod.IsNumber(newcard) then
                        card = newcard
                    end
                end
            end
        end
    end
    return card
end
mod:AddCallback(ModCallbacks.MC_GET_CARD, Eden.CustomGetCard)
--#endregion

--#region 21
function Eden:CustomGetShaderParam(shader)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_GET_SHADER_PARAMS)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local ret = callback.Function(shader)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, Eden.CustomGetShaderParam)
--#endregion

--#region 22

--#endregion

--#region 23
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
--#endregion

--#region 24
function Eden:CustomPreEntitySpawn(type, variant, subtype, position, velocity, spawner, seed)
    local retent = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_ENTITY_SPAWN)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local newret = callback.Function(type, variant, subtype, position, velocity, spawner, seed)
                    if not newret or mod.IsTable(newret) then
                        retent = newret
                    end
                end
            end
        end
    end
    return retent
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, Eden.CustomPreEntitySpawn)
--#endregion

--#region 25
function Eden:CustomFamiliarRender(familiar, renderOffset)
    local player = familiar.Player
    if player then
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_FAMILIAR_RENDER)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local famType = table.unpack(callback.Param)
                    if not famType or mod.IsNumber(famType) and famType == familiar.Type then
                        callback.Function(familiar, renderOffset)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, Eden.CustomFamiliarRender)
--#endregion

--#region 26
function Eden:CustomPreFamiliarCollision(familiar, collider, low)
    local player = familiar.Player
    if player then
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_FAMILIAR_COLLISION)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local fvariant = table.unpack(callback.Params)
                    if not fvariant or mod.IsNumber(fvariant) and familiar.Variant == fvariant then
                        local ret = callback.Function(familiar, collider, low)
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
mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, Eden.CustomPreFamiliarCollision)
--#endregion

--#region 27
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
--#endregion

--#region 28
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
mod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, Eden.CustomPostNPCRender)
--#endregion

--#region 29
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
--#endregion

--#region 30
function Eden:CustomPreNPCCollision(npc, collider, low)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_NPC_COLLISION)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local npcType = table.unpack(callback.Param)
                    if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
                        local ret = callback.Function(npc, collider, low)
                        if ret ~= nil then
                            return ret
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, Eden.CustomPreNPCCollision)
--#endregion

--#region 31
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
--#endregion

--#region 32
function Eden:CustomPlayerRender(player, renderOffset)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PLAYER_RENDER)
        local data = mod.GetPersistentPlayerData(player)
        for ptype, callback in ipairs(callbacks) do
            if data.TEdenState and callback.PlayerType == data.TEdenState then
                local pvariant = table.unpack(callback.Param)
                if not pvariant or mod.IsNumber(pvariant) and pvariant == player.Variant then
                    callback.Function(player,renderOffset)
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, Eden.CustomPlayerRender)
--#endregion

--#region 33
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
--#endregion

--#region 34
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
--#endregion

--#region 35
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
--#endregion

--#region 36
function Eden:CustomPostPickupRender(pickup, renderOffset)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_RENDER)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local variant = table.unpack(callback.Param)
                    if not variant or mod.IsNumber(variant) and variant == pickup.Variant then
                        callback.Function(pickup, renderOffset)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, Eden.CustomPostPickupRender)
--#endregion

--#region 37
function Eden:CustomPostPickupSelection(pickup, variant, subtype)
    local ret = nil
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_SELECTION)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local newret = callback.Function(pickup, variant, subtype)
                    if not newret or mod.IsTable(newret) then
                        ret = newret
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, Eden.CustomPostPickupSelection)
--#endregion

--#region 38
function Eden:CustomPrePickupCollision(pickup, collider, low)
    if collider and collider:ToPlayer() and collider:ToPlayer():GetPlayerType() == PlayerType.PLAYER_EDEN_B then
        local player = collider:ToPlayer()
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_PICKUP_COLLISION)
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
--#endregion

--#region 39
function Eden:CustomPostTearInit(tear)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_TEAR_INIT)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == tear.Variant then
                            callback.Function(tear)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, Eden.CustomPostTearInit)
--#endregion

--#region 40
function Eden:CustomPostTearUpdate(tear)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_TEAR_UPDATE)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == tear.Variant then
                            callback.Function(tear)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, Eden.CustomPostTearUpdate)
--#endregion

--#region 41
function Eden:CustomPostTearRender(tear, renderOffset)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_TEAR_RENDER)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == tear.Variant then
                            callback.Function(tear,renderOffset)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_RENDER, Eden.CustomPostTearUpdate)
--#endregion

--#region 42
function Eden:CustomPreTearCollision(tear, collider, low)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_TEAR_COLLISION)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == tear.Variant then
                            local ret = callback.Function(tear, collider, low)
                            if ret ~= nil then
                                return ret
                            end
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, Eden.CustomPreTearCollision)
--#endregion

--#region 43
function Eden:CustomPostProjectileInit(proj)
    local player = mod:GetPlayerFromTear(proj)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_INIT)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == proj.Variant then
                            callback.Function(proj)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, Eden.CustomPostProjectileInit)
--#endregion

--#region 44
function Eden:CustomPostProjectileUpdate(proj)
    local player = mod:GetPlayerFromTear(proj)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_UPDATE)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == proj.Variant then
                            callback.Function(proj)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, Eden.CustomPostProjectileUpdate)
--#endregion

--#region 45
function Eden:CustomPostProjectileRender(proj, renderOffset)
    local player = mod:GetPlayerFromTear(proj)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_RENDER)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == proj.Variant then
                            callback.Function(proj,renderOffset)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_RENDER, Eden.CustomPostProjectileRender)
--#endregion

--#region 46
function Eden:CustomPreProjectileCollision(proj, collider, low)
    local player = mod:GetPlayerFromTear(proj)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_PROJECTILE_COLLISION)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == proj.Variant then
                            local ret = callback.Function(proj, collider, low)
                            if ret ~= nil then
                                return ret
                            end
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, Eden.CustomPreProjectileCollision)
--#endregion

--#region 47
function Eden:CustomPostLaserInit(laser)
    local player = mod:GetPlayerFromTear(laser)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_LASER_INIT)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == laser.Variant then
                            callback.Function(laser)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_INIT, Eden.CustomPostLaserInit)
--#endregion

--#region 48
function Eden:CustomPostLaserUpdate(laser)
    local player = mod:GetPlayerFromTear(laser)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_LASER_UPDATE)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == laser.Variant then
                            callback.Function(laser)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, Eden.CustomPostLaserUpdate)
--#endregion

--#region 49
function Eden:CustomPostLaserRender(laser, renderOffset)
    local player = mod:GetPlayerFromTear(laser)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_LASER_RENDER)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == laser.Variant then
                            callback.Function(laser, renderOffset)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_RENDER, Eden.CustomPostLaserRender)
--#endregion

--#region 50
function Eden:CustomPostKnifeInit(knife)
    local player = mod:GetPlayerFromTear(knife)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_KNIFE_INIT)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == knife.SubType then
                            callback.Function(knife)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, Eden.CustomPostKnifeInit)
--#endregion

--#region 51
function Eden:CustomPostKnifeUpdate(knife)
    local player = mod:GetPlayerFromTear(knife)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_KNIFE_UPDATE)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == knife.SubType then
                            callback.Function(knife)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, Eden.CustomPostKnifeUpdate)
--#endregion

--#region 52
function Eden:CustomPostKnifeRender(knife, renderOffset)
    local player = mod:GetPlayerFromTear(knife)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_KNIFE_RENDER)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == knife.SubType then
                            callback.Function(knife, renderOffset)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_RENDER, Eden.CustomPostKnifeRender)
--#endregion

--#region 53
function Eden:CustomPreKnifeCollision(knife, collider, low)
    local player = mod:GetPlayerFromTear(knife)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_KNIFE_COLLISION)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == knife.SubType then
                            local ret = callback.Function(knife, collider, low)
                            if ret ~= nil then
                                return ret
                            end
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, Eden.CustomPreKnifeCollision)
--#endregion

--#region 54
function Eden:CustomPostEffectInit(effect)
    local player = mod:GetPlayerFromTear(effect)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_EFFECT_INIT)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == effect.Variant then
                            callback.Function(effect)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, Eden.CustomPostKnifeInit)
--#endregion

--#region 55
function Eden:CustomPostEffectUpdate(effect)
    local player = mod:GetPlayerFromTear(effect)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_EFFECT_UPDATE)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == effect.Variant then
                            callback.Function(effect)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, Eden.CustomPostEffectUpdate)
--#endregion

--#region 56
function Eden:CustomPostEffectRender(effect, renderOffset)
    local player = mod:GetPlayerFromTear(effect)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_EFFECT_RENDER)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == effect.Variant then
                            callback.Function(effect, renderOffset)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, Eden.CustomPostEffectRender)
--#endregion

--#region 57
function Eden:CustomPostBombInit(bomb)
    local player = mod:GetPlayerFromTear(bomb)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_BOMB_INIT)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == bomb.Variant then
                            callback.Function(bomb)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, Eden.CustomPostBombInit)
--#endregion

--#region 58
function Eden:CustomPostBombUpdate(bomb)
    local player = mod:GetPlayerFromTear(bomb)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_BOMB_UPDATE)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == bomb.Variant then
                            callback.Function(bomb)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, Eden.CustomPostBombUpdate)
--#endregion

--#region 59
function Eden:CustomPostBombRender(bomb, renderOffset)
    local player = mod:GetPlayerFromTear(bomb)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_BOMB_RENDER)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == bomb.Variant then
                            callback.Function(bomb,renderOffset)
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_RENDER, Eden.CustomPostBombRender)
--#endregion

--#region 60
function Eden:CustomPreBombCollision(bomb, collider, low)
    local player = mod:GetPlayerFromTear(bomb)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_BOMB_COLLISION)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        local variant = table.unpack(callback.Params)
                        if not variant or mod.IsNumber(variant) and variant == bomb.Variant then
                            local ret = callback.Function(bomb, collider, low)
                            if ret ~= nil then
                                return ret
                            end
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, Eden.CustomPreBombCollision)
--#endregion

--#region 61
function Eden:CustomPostFireTear(tear)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
            local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
            if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
                local data = mod.GetPersistentPlayerData(player)
                local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_FIRE_TEAR)
                for ptype, callback in ipairs(callbacks) do
                    if data.TEdenState and callback.PlayerType == data.TEdenState then 
                        callback.Function(tear)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Eden.CustomPostFireTear)
--#endregion

--#region 62
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
--#endregion

--#region 63
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
--#endregion

--#region 64
function Eden:CustomGetPillColor(seed)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_GET_PILL_COLOR)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local retr = callback.Function(seed)
                    if retr ~= nil then
                        ret = retr
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_GET_PILL_COLOR, Eden.CustomGetPillColor)
--#endregion

--#region 65
function Eden:CustomGetPillEffect(effect, pillcolor)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_GET_PILL_EFFECT)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local retr = callback.Function(effect, pillcolor)
                    if retr ~= nil then
                        ret = retr
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, Eden.CustomGetPillEffect)
--#endregion

--#region 66
function Eden:CustomGetTrinket(trinket, rng)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_GET_TRINKET)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local retr = callback.Function(trinket, rng)
                    if retr ~= nil then
                        ret = retr
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_GET_TRINKET, Eden.CustomGetTrinket)
--#endregion

--#region 67
function Eden:CustomPostEntityRemove(entity)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_ENTITY_REMOVE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local entype = table.unpack(callback.Params)
                    if not entype or mod.IsNumber(entype) and entype == entity.Type then
                        callback.Function(entity)
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, Eden.CustomPostEntityRemove)
--#endregion

--#region 68
function Eden:CustomPostEntityKill(entity)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    local ret = nil
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_ENTITY_KILL)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local entype = table.unpack(callback.Params)
                    if not entype or mod.IsNumber(entype) and entype == entity.Type then
                        callback.Function(entity)
                    end
                end
            end
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, Eden.CustomPostEntityKill)
--#endregion

--#region 69
function Eden:CustomPreNPCUpdate(npc)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_NPC_UPDATE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local npcType = table.unpack(callback.Param)
                    if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
                        local ret = callback.Function(npc)
                        if ret ~= nil then
                            return ret
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, Eden.CustomPreNPCUpdate)
--#endregion

--#region 70
function Eden:CustomPreSpawnReward(rng,spawnpos)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local ret = callback.Function(rng,spawnpos)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Eden.CustomPreSpawnReward)
--#endregion

--#region 71
function Eden:CustomPreRoomEntitySpawn(entity,variant,subtype,gridIDX, seed)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local ret = callback.Function(entity,variant,subtype,gridIDX, seed)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, Eden.CustomPreRoomEntitySpawn)
--#endregion

--#region 72
function Eden:CustomPreEntityDevolve(entity)
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
        local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        if player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
            local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_ENTITY_DEVOLVE)
            local data = mod.GetPersistentPlayerData(player)
            for ptype, callback in ipairs(callbacks) do
                if data.TEdenState and callback.PlayerType == data.TEdenState then
                    local ret = callback.Function(entity)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_DEVOLVE, Eden.CustomPreEntityDevolve)
--#endregion

--#region 73

--#endregion

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