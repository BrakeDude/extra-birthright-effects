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

--#endregion

--#region 40

--#endregion

--#region 41

--#endregion

--#region 42

--#endregion

--#region 43

--#endregion

--#region 44

--#endregion

--#region 45

--#endregion

--#region 46

--#endregion

--#region 47

--#endregion

--#region 48

--#endregion

--#region 49

--#endregion

--#region 50

--#endregion

--#region 51

--#endregion

--#region 52

--#endregion

--#region 53

--#endregion

--#region 54

--#endregion

--#region 55

--#endregion

--#region 56

--#endregion

--#region 57

--#endregion

--#region 58

--#endregion

--#region 59

--#endregion

--#region 60

--#endregion

--#region 61

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

--#endregion

--#region 65

--#endregion

--#region 66

--#endregion

--#region 67

--#endregion

--#region 68

--#endregion

--#region 69

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
                    callback.Function(rng,spawnpos)
                end
            end
            return nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Eden.CustomPreSpawnReward)
--#endregion

--#region 71

--#endregion

--#region 72

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