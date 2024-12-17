local mod = ExtraBirthright

local Eden = {}
local currentState = PlayerType.PLAYER_CAIN

local substituteBirthright = mod.COLLECTIBLE_BIRTHRIGHT

function mod:GetCustomBirthrightPlayers(types)
    local rPlayers = {}
    local players = mod:GetPlayersByType(types)
    for _,player in ipairs(players) do
        local ptype = player:GetPlayerType()
        if (mod.GetMCMValue(ptype) and mod.GetMCMValue(ptype) > 1) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) then
                table.insert(rPlayers, player)
            end
        end
    end
    return rPlayers
end

local function GetBirthrightCallbacks(modcallback)
    local callbacks = mod.GetCustomCallbacks(modcallback)
    local callbackTable = {}
    for _,player in ipairs(mod:GetPlayers()) do
        local data = mod.GetPersistentPlayerData(player)
        local ptype = player:GetPlayerType()
        local i = 1
        while i <= #callbacks do
            local callback = callbacks[i]
            if callback then
                local otherPlayerType = callback.PlayerType
                if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
                    local MCMValue = mod.GetMCMValue(ptype)
                    local maxMCMValue = mod.GetMaxMCMValue(ptype)
                    local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
                    if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                        table.insert(callbackTable, callback)
                        --callbacks[i] = nil
                    end
                end
            end
            i = i + 1
        end
    end
    return callbackTable
end

local function ChangeEdenState(player)
    local col = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
    if player and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and player:HasCollectible(col) and mod.MCMOption.Settings["Tainted Eden"] > 1 then
        local data = mod.GetPersistentPlayerData(player)
        local rng = player:GetDropRNG()
        data.TEdenState = mod.MCMOption.PlayerType[rng:RandomInt(#mod.MCMOption.PlayerType)]
        rng:Next()
    end
end

--#region 1
function Eden:CustomNPCUpdate(npc)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_NPC_UPDATE)
      
    for ptype, callback in ipairs(callbackTable) do
        local npcType = table.unpack(callback.Params)
        if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
            callback.Function(npc)
        end
    end
    
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Eden.CustomNPCUpdate)
--#endregion

--#region 2
function Eden:CustomPostUpdate()
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_UPDATE)
    for ptype, callback in ipairs(callbackTable) do
        callback.Function()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Eden.CustomPostUpdate)
--#endregion

--#region 3
function Eden:CustomUse(collectible,rng,player,flags,ActiveSlot,customdata)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_ITEM)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local collectibleID = table.unpack(callback.Params)
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
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PEFFECT_UPDATE)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local playerType = table.unpack(callback.Params)
                if not playerType or mod.IsNumber(playerType) and playerType == ptype then
                    callback.Function(player)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Eden.CustomPEffectUpdate)
--#endregion

--#region 5
function Eden:CustomCardUse(card,player,flags)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_CARD)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local cardID = table.unpack(callback.Params)
                if not cardID or mod.IsNumber(cardID) and cardID == card then
                    local ret = callback.Function(card,player,flags)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, Eden.CustomCardUse)
--#endregion

--#region 6
function Eden:CustomFamiliarUpdate(familiar)
    local player = familiar.Player
    if player then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_FAMILIAR_UPDATE)
        local data = mod.GetPersistentPlayerData(player)
        local ptype = player:GetPlayerType()
        
        for _, callback in ipairs(callbacks) do
            local otherPlayerType = callback.PlayerType
            if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
                local MCMValue = mod.GetMCMValue(ptype)
                local maxMCMValue = mod.GetMaxMCMValue(ptype)
                local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
                if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                    local familiarVariant = table.unpack(callback.Params)
                    if not familiarVariant or mod.IsNumber(familiarVariant) and familiarVariant == familiar.Variant then
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
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_FAMILIAR_UPDATE)
        local data = mod.GetPersistentPlayerData(player)
        local ptype = player:GetPlayerType()
        
        for _, callback in ipairs(callbacks) do
            local otherPlayerType = callback.PlayerType
            if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
                local MCMValue = mod.GetMCMValue(ptype)
                local maxMCMValue = mod.GetMaxMCMValue(ptype)
                local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
                if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                    local familiarVariant = table.unpack(callback.Params)
                    if not familiarVariant or mod.IsNumber(familiarVariant) and familiarVariant == familiar.Variant then
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
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_EVALUATE_CACHE)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local cacheT = table.unpack(callback.Params)
                if not cacheT or mod.IsNumber(cacheT) and cacheT == cache then
                    callback.Function(player, cache)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Eden.CustomCache)
--#endregion

--#region 9
function Eden:CustomPlayerInit(player)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PLAYER_INIT)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local playerVariant = table.unpack(callback.Params)
                if not playerVariant or mod.IsNumber(playerVariant) and playerVariant == player.Variant then
                    callback.Function(player)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Eden.CustomPlayerInit)
--#endregion

--#region 10
function Eden:CustomPillUse(pill,player,flags)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_USE_PILL)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local pillID = table.unpack(callback.Params)
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
        local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_ENTITY_TAKE_DMG)
        
        for ptype, callback in ipairs(callbackTable) do
            local etype = table.unpack(callback.Params)
            if not etype or mod.IsNumber(etype) and etype == entity.Type then
                local ret = callback.Function(entity,amount,flags,source,cd)
                if ret == false then
                    return ret
                end
            end
        end
        
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Eden.CustomEntityTakeDmg)
--#endregion

--#region 12
function Eden:CustomPostCurseEval(curse)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_CURSE_EVAL)
    
    for ptype, callback in ipairs(callbackTable) do
        local newCurse = callback.Function(curse)
        if not newCurse or mod.IsNumber(newCurse) then
            curse = newCurse
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
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_NEW_LEVEL)
       
    for ptype, callback in ipairs(callbackTable) do
        callback.Function()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Eden.CustomNewLevel)
--#endregion

--#region 19
function Eden:CustomNewRoom()
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_NEW_ROOM)
        
    for ptype, callback in ipairs(callbackTable) do
        callback.Function()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Eden.CustomNewRoom)
--#endregion

--#region 20
function Eden:CustomGetCard(rng, card, playing, runes, onlyrunes)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_GET_CARD)
    
    for _, callback in ipairs(callbackTable) do
        local ret = callback.Function(rng, card, playing, runes, onlyrunes)
        if not ret and mod.IsNumber(ret) then
            card = ret
        end
    end

    return card
end
mod:AddCallback(ModCallbacks.MC_GET_CARD, Eden.CustomGetCard)
--#endregion

--#region 21
function Eden:CustomGetShaderParam(shader)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_GET_SHADER_PARAMS)
   
    for _, callback in ipairs(callbackTable) do
        local ret = callback.Function(shader)
        if ret ~= nil then
            return ret
        end
    end
end
--mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, Eden.CustomGetShaderParam)
--#endregion

--#region 22

--#endregion

--#region 23
function Eden:CustomPreUse(collectible,rng,player,flags,ActiveSlot,customdata)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_USE_ITEM)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                for _,collectibleID in pairs(callback.Params) do
                    if not collectibleID or mod.IsNumber(collectibleID) and collectibleID == collectible then
                        local ret = callback.Function(collectible,rng,player,flags,ActiveSlot,customdata)
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
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, Eden.CustomPreUse)
--#endregion

--#region 24
function Eden:CustomPreEntitySpawn(type, variant, subtype, position, velocity, spawner, seed)
    local retent = nil
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_ENTITY_SPAWN)
    
    for ptype, callback in ipairs(callbackTable) do
        local newent = callback.Function(type, variant, subtype, position, velocity, spawner, seed)
        if not newent or mod.IsTable(newent) then
            retent = newent
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
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_FAMILIAR_RENDER)
        local data = mod.GetPersistentPlayerData(player)
        local ptype = player:GetPlayerType()
        
        for _, callback in ipairs(callbacks) do
            local otherPlayerType = callback.PlayerType
            if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
                local MCMValue = mod.GetMCMValue(ptype)
                local maxMCMValue = mod.GetMaxMCMValue(ptype)
                local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
                if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                    local familiarVariant = table.unpack(callback.Params)
                    if not familiarVariant or mod.IsNumber(familiarVariant) and familiarVariant == familiar.Variant then
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
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_FAMILIAR_COLLISION)
        local data = mod.GetPersistentPlayerData(player)
        local ptype = player:GetPlayerType()
        
        for _, callback in ipairs(callbacks) do
            local otherPlayerType = callback.PlayerType
            if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
                local MCMValue = mod.GetMCMValue(ptype)
                local maxMCMValue = mod.GetMaxMCMValue(ptype)
                local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
                if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                    local familiarVariant = table.unpack(callback.Params)
                    if not familiarVariant or mod.IsNumber(familiarVariant) and familiarVariant == familiar.Variant then
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
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_NPC_INIT)
    
    for ptype, callback in ipairs(callbackTable) do
        local npcType = table.unpack(callback.Params)
        if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
            callback.Function(npc)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, Eden.CustomPostNPCInit)
--#endregion

--#region 28
function Eden:CustomPostNPCRender(npc, offset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_NPC_RENDER)
    
    for ptype, callback in ipairs(callbackTable) do
        local npcType = table.unpack(callback.Params)
        if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
            callback.Function(npc, offset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, Eden.CustomPostNPCRender)
--#endregion

--#region 29
function Eden:CustomPostNPCDeath(npc)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_NPC_DEATH)
        
    for ptype, callback in ipairs(callbackTable) do
        local npcType = table.unpack(callback.Params)
        if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
            callback.Function(npc)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, Eden.CustomPostNPCDeath)
--#endregion

--#region 30
function Eden:CustomPreNPCCollision(npc, collider, low)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_NPC_COLLISION)
        
    for ptype, callback in ipairs(callbackTable) do
        local npcType = table.unpack(callback.Params)
        if not npcType or mod.IsNumber(npcType) and npcType == npc.Type then
            local ret = callback.Function(npc, collider, low)
            if ret ~= nil then
                return ret
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, Eden.CustomPreNPCCollision)
--#endregion

--#region 31

function Eden:CustomPlayerUpdate(player)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local playerVariant = table.unpack(callback.Params)
                if not playerVariant or mod.IsNumber(playerVariant) and playerVariant == player.Variant then
                    callback.Function(player)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Eden.CustomPlayerUpdate)
--#endregion

--#region 32
function Eden:CustomPlayerRender(player, renderOffset)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_POST_PLAYER_RENDER)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local playerVariant = table.unpack(callback.Params)
                if not playerVariant or mod.IsNumber(playerVariant) and playerVariant == player.Variant then
                    callback.Function(player, renderOffset)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, Eden.CustomPlayerRender)
--#endregion

--#region 33
function Eden:CustomPrePlayerCollision(player, collider, low)
    local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PRE_PLAYER_COLLISION)
    local data = mod.GetPersistentPlayerData(player)
    local ptype = player:GetPlayerType()
    
    for _, callback in ipairs(callbacks) do
        local otherPlayerType = callback.PlayerType
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
            local MCMValue = mod.GetMCMValue(ptype)
            local maxMCMValue = mod.GetMaxMCMValue(ptype)
            local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
            if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                local playerVariant = table.unpack(callback.Params)
                if not playerVariant or mod.IsNumber(playerVariant) and playerVariant == player.Variant then
                    local ret = callback.Function(player, collider, low)
                    if ret ~= nil then
                        return ret
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Eden.CustomPrePlayerCollision)
--#endregion

--#region 34
function Eden:CustomPostPickupInit(pickup)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_INIT)
    
    for ptype, callback in ipairs(callbackTable) do
        local pickupVariant = table.unpack(callback.Params)
        if not pickupVariant or mod.IsNumber(pickupVariant) and pickupVariant == pickup.Variant then
            callback.Function(pickup)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, Eden.CustomPostPickupInit)
--#endregion

--#region 35
function Eden:CustomPostPickupUpdate(pickup)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_UPDATE)
   
    for ptype, callback in ipairs(callbackTable) do
        local pickupVariant = table.unpack(callback.Params)
        if not pickupVariant or mod.IsNumber(pickupVariant) and pickupVariant == pickup.Variant then
            callback.Function(pickup)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, Eden.CustomPostPickupUpdate)
--#endregion

--#region 36
function Eden:CustomPostPickupRender(pickup, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_RENDER)
        
    for ptype, callback in ipairs(callbackTable) do
        local pickupVariant = table.unpack(callback.Params)
        if not pickupVariant or mod.IsNumber(pickupVariant) and pickupVariant == pickup.Variant then
            callback.Function(pickup, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, Eden.CustomPostPickupRender)
--#endregion

--#region 37
function Eden:CustomPostPickupSelection(pickup, variant, subtype)
    local ret = nil
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PICKUP_SELECTION)
    
    for ptype, callback in ipairs(callbackTable) do
        local newret = callback.Function(pickup, variant, subtype)
        if not newret or mod.IsTable(newret) then
            ret = newret
        end        
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, Eden.CustomPostPickupSelection)
--#endregion

--#region 38
function Eden:CustomPrePickupCollision(pickup, collider, low)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_PICKUP_COLLISION)
      
    for _, callback in ipairs(callbackTable) do
        local pickupVariant = table.unpack(callback.Params)
        if not pickupVariant or mod.IsNumber(pickupVariant) and pickupVariant == pickup.Variant then
            local ret = callback.Function(pickup, collider, low)
            if ret ~= nil then
                return ret
            end
        end
    end
    
    return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Eden.CustomPrePickupCollision)
--#endregion

--#region 39
function Eden:CustomPostTearInit(tear)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_TEAR_INIT)
        
    for _, callback in ipairs(callbackTable) do
        local tearVariant = table.unpack(callback.Params)
        if not tearVariant or mod.IsNumber(tearVariant) and tearVariant == tear.Variant then
            callback.Function(tear)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, Eden.CustomPostTearInit)
--#endregion

--#region 40
function Eden:CustomPostTearUpdate(tear)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_TEAR_UPDATE)
        
    for _, callback in ipairs(callbackTable) do
        local tearVariant = table.unpack(callback.Params)
        if not tearVariant or mod.IsNumber(tearVariant) and tearVariant == tear.Variant then
            callback.Function(tear)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, Eden.CustomPostTearUpdate)
--#endregion

--#region 41
function Eden:CustomPostTearRender(tear, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_TEAR_RENDER)
       
    for _, callback in ipairs(callbackTable) do
        local tearVariant = table.unpack(callback.Params)
        if not tearVariant or mod.IsNumber(tearVariant) and tearVariant == tear.Variant then
            callback.Function(tear, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_RENDER, Eden.CustomPostTearUpdate)
--#endregion

--#region 42
function Eden:CustomPreTearCollision(tear, collider, low)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_TEAR_COLLISION)
    
    for _, callback in ipairs(callbackTable) do
        local tearVariant = table.unpack(callback.Params)
        if not tearVariant or mod.IsNumber(tearVariant) and tearVariant == tear.Variant then
            callback.Function(tear, collider, low)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, Eden.CustomPreTearCollision)
--#endregion

--#region 43
function Eden:CustomPostProjectileInit(proj)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_INIT)

    for ptype, callback in ipairs(callbackTable) do
        local projectileVariant = table.unpack(callback.Params)
        if not projectileVariant or mod.IsNumber(projectileVariant) and projectileVariant == proj.Variant then
            callback.Function(proj)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, Eden.CustomPostProjectileInit)
--#endregion

--#region 44
function Eden:CustomPostProjectileUpdate(proj)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_UPDATE)

    for ptype, callback in ipairs(callbackTable) do
        local projectileVariant = table.unpack(callback.Params)
        if not projectileVariant or mod.IsNumber(projectileVariant) and projectileVariant == proj.Variant then
            callback.Function(proj)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, Eden.CustomPostProjectileUpdate)
--#endregion

--#region 45
function Eden:CustomPostProjectileRender(proj, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_INIT)

    for ptype, callback in ipairs(callbackTable) do
        local projectileVariant = table.unpack(callback.Params)
        if not projectileVariant or mod.IsNumber(projectileVariant) and projectileVariant == proj.Variant then
            callback.Function(proj, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_RENDER, Eden.CustomPostProjectileRender)
--#endregion

--#region 46
function Eden:CustomPreProjectileCollision(proj, collider, low)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_PROJECTILE_INIT)
       
    for ptype, callback in ipairs(callbackTable) do
        local projectileVariant = table.unpack(callback.Params)
        if not projectileVariant or mod.IsNumber(projectileVariant) and projectileVariant == proj.Variant then
            local ret = callback.Function(proj,collider,low)
            if ret ~= nil then
                return ret
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, Eden.CustomPreProjectileCollision)
--#endregion

--#region 47
function Eden:CustomPostLaserInit(laser)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_LASER_INIT)

    for ptype, callback in ipairs(callbackTable) do
        local laserVariant = table.unpack(callback.Params)
        if not laserVariant or mod.IsNumber(laserVariant) and laserVariant == laser.Variant then
            callback.Function(laser)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_INIT, Eden.CustomPostLaserInit)
--#endregion

--#region 48
function Eden:CustomPostLaserUpdate(laser)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_LASER_UPDATE)

    for ptype, callback in ipairs(callbackTable) do
        local laserVariant = table.unpack(callback.Params)
        if not laserVariant or mod.IsNumber(laserVariant) and laserVariant == laser.Variant then
            callback.Function(laser)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, Eden.CustomPostLaserUpdate)
--#endregion

--#region 49
function Eden:CustomPostLaserRender(laser, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_LASER_RENDER)

    for ptype, callback in ipairs(callbackTable) do
        local laserVariant = table.unpack(callback.Params)
        if not laserVariant or mod.IsNumber(laserVariant) and laserVariant == laser.Variant then
            callback.Function(laser, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_RENDER, Eden.CustomPostLaserRender)
--#endregion

--#region 50
function Eden:CustomPostKnifeInit(knife)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_KNIFE_INIT)

    for ptype, callback in ipairs(callbackTable) do
        local knifeVariant = table.unpack(callback.Params)
        if not knifeVariant or mod.IsNumber(knifeVariant) and knifeVariant == knife.Variant then
            callback.Function(knife)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, Eden.CustomPostKnifeInit)
--#endregion

--#region 51
function Eden:CustomPostKnifeUpdate(knife)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_KNIFE_UPDATE)

    for ptype, callback in ipairs(callbackTable) do
        local knifeVariant = table.unpack(callback.Params)
        if not knifeVariant or mod.IsNumber(knifeVariant) and knifeVariant == knife.Variant then
            callback.Function(knife)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, Eden.CustomPostKnifeUpdate)
--#endregion

--#region 52
function Eden:CustomPostKnifeRender(knife, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_KNIFE_RENDER)

    for ptype, callback in ipairs(callbackTable) do
        local knifeVariant = table.unpack(callback.Params)
        if not knifeVariant or mod.IsNumber(knifeVariant) and knifeVariant == knife.Variant then
            callback.Function(knife, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_RENDER, Eden.CustomPostKnifeRender)
--#endregion

--#region 53
function Eden:CustomPreKnifeCollision(knife, collider, low)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_KNIFE_COLLISION)
       
    for ptype, callback in ipairs(callbackTable) do
        local knifeVariant = table.unpack(callback.Params)
        if not knifeVariant or mod.IsNumber(knifeVariant) and knifeVariant == knife.Variant then
            local ret = callback.Function(knife,collider,low)
            if ret ~= nil then
                return ret
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, Eden.CustomPreKnifeCollision)
--#endregion

--#region 54
function Eden:CustomPostEffectInit(effect)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_EFFECT_INIT)

    for ptype, callback in ipairs(callbackTable) do
        local effectVariant = table.unpack(callback.Params)
        if not effectVariant or mod.IsNumber(effectVariant) and effectVariant == effect.Variant then
            callback.Function(effect)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, Eden.CustomPostKnifeInit)
--#endregion

--#region 55
function Eden:CustomPostEffectUpdate(effect)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_EFFECT_UPDATE)

    for ptype, callback in ipairs(callbackTable) do
        local effectVariant = table.unpack(callback.Params)
        if not effectVariant or mod.IsNumber(effectVariant) and effectVariant == effect.Variant then
            callback.Function(effect)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, Eden.CustomPostEffectUpdate)
--#endregion

--#region 56
function Eden:CustomPostEffectRender(effect, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_EFFECT_RENDER)

    for ptype, callback in ipairs(callbackTable) do
        local effectVariant = table.unpack(callback.Params)
        if not effectVariant or mod.IsNumber(effectVariant) and effectVariant == effect.Variant then
            callback.Function(effect, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, Eden.CustomPostEffectRender)
--#endregion

--#region 57
function Eden:CustomPostBombInit(bomb)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_BOMB_INIT)

    for ptype, callback in ipairs(callbackTable) do
        local bombVariant = table.unpack(callback.Params)
        if not bombVariant or mod.IsNumber(bombVariant) and bombVariant == bomb.Variant then
            callback.Function(bomb)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, Eden.CustomPostBombInit)
--#endregion

--#region 58
function Eden:CustomPostBombUpdate(bomb)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_BOMB_UPDATE)

    for ptype, callback in ipairs(callbackTable) do
        local bombVariant = table.unpack(callback.Params)
        if not bombVariant or mod.IsNumber(bombVariant) and bombVariant == bomb.Variant then
            callback.Function(bomb)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, Eden.CustomPostBombUpdate)
--#endregion

--#region 59
function Eden:CustomPostBombRender(bomb, renderOffset)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_BOMB_RENDER)

    for ptype, callback in ipairs(callbackTable) do
        local bombVariant = table.unpack(callback.Params)
        if not bombVariant or mod.IsNumber(bombVariant) and bombVariant == bomb.Variant then
            callback.Function(bomb, renderOffset)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_RENDER, Eden.CustomPostBombRender)
--#endregion

--#region 60
function Eden:CustomPreBombCollision(bomb, collider, low)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_BOMB_COLLISION)

    for ptype, callback in ipairs(callbackTable) do
        local bombVariant = table.unpack(callback.Params)
        if not bombVariant or mod.IsNumber(bombVariant) and bombVariant == bomb.Variant then
            local ret = callback.Function(bomb, collider, low)
            if ret ~= nil then
                return ret
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, Eden.CustomPreBombCollision)
--#endregion

--#region 61
function Eden:CustomPostFireTear(tear)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_FIRE_TEAR)

    for ptype, callback in ipairs(callbackTable) do
        local tearVariant = table.unpack(callback.Params)
        if not tearVariant or mod.IsNumber(tearVariant) and tearVariant == tear.Variant then
            callback.Function(tear)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Eden.CustomPostFireTear)
--#endregion

--#region 62
function Eden:CustomPreGetCollectible(itempool,decrease,seed)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_GET_COLLECTIBLE)
    local ret = nil
    for ptype, callback in ipairs(callbackTable) do
        local newret = callback.Function(itempool,decrease,seed)
        if not newret or mod.IsNumber(newret) then
            ret = newret
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, Eden.CustomPreGetCollectible)
--#endregion

--#region 63
function Eden:CustomPostGetCollectible(SelectedCollectible,itempool,decrease,seed)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_GET_COLLECTIBLE)
    local ret = nil
    for ptype, callback in ipairs(callbackTable) do
        local newret = callback.Function(SelectedCollectible,itempool,decrease,seed)
        if not newret or mod.IsNumber(newret) then
            ret = newret
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, Eden.CustomPostGetCollectible)
--#endregion

--#region 64
function Eden:CustomGetPillColor(seed)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_GET_PILL_COLOR)
    local ret = nil
    for ptype, callback in ipairs(callbackTable) do
        local newret = callback.Function(seed)
        if not newret or mod.IsNumber(newret) then
            ret = newret
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_GET_PILL_COLOR, Eden.CustomGetPillColor)
--#endregion

--#region 65
function Eden:CustomGetPillEffect(effect, pillcolor)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_GET_PILL_EFFECT)
    local ret = nil
    for ptype, callback in ipairs(callbackTable) do
        local newret = callback.Function(effect, pillcolor)
        if not newret or mod.IsNumber(newret) then
            ret = newret
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, Eden.CustomGetPillEffect)
--#endregion

--#region 66
function Eden:CustomGetTrinket(trinket, rng)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_GET_TRINKET)
    local ret = nil
    for ptype, callback in ipairs(callbackTable) do
        local newret = callback.Function(trinket, rng)
        if not newret or mod.IsNumber(newret) then
            ret = newret
        end
    end
    return ret
end
mod:AddCallback(ModCallbacks.MC_GET_TRINKET, Eden.CustomGetTrinket)
--#endregion

--#region 67
function Eden:CustomPostEntityRemove(entity)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_ENTITY_REMOVE)
    for ptype, callback in ipairs(callbackTable) do
        local entityType = table.unpack(callback.Params)
        if not entityType or mod.IsNumber(entityType) and entityType == entity.Type then
            callback.Function(entity)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, Eden.CustomPostEntityRemove)
--#endregion

--#region 68
function Eden:CustomPostEntityKill(entity)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_POST_ENTITY_KILL)
    for ptype, callback in ipairs(callbackTable) do
        local entityType = table.unpack(callback.Params)
        if not entityType or mod.IsNumber(entityType) and entityType == entity.Type then
            callback.Function(entity)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, Eden.CustomPostEntityKill)
--#endregion

--#region 69
function Eden:CustomPreNPCUpdate(npc)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_NPC_UPDATE)
    for ptype, callback in ipairs(callbackTable) do
        local entityType = table.unpack(callback.Params)
        if not entityType or mod.IsNumber(entityType) and entityType == npc.Type then
            local ret = callback.Function(npc)
            if ret ~= nil then
                return ret
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, Eden.CustomPreNPCUpdate)
--#endregion

--#region 70
function Eden:CustomPreSpawnReward(rng,spawnpos)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD)
    for ptype, callback in ipairs(callbackTable) do
        local ret = callback.Function(rng,spawnpos)
        if ret ~= nil then
            return ret
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Eden.CustomPreSpawnReward)
--#endregion

--#region 71
function Eden:CustomPreRoomEntitySpawn(entity,variant,subtype,gridIDX, seed)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_ROOM_ENTITY_SPAWN)
    for ptype, callback in ipairs(callbackTable) do
        local ret = callback.Function(entity,variant,subtype,gridIDX, seed)
        if ret ~= nil then
            return ret
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, Eden.CustomPreRoomEntitySpawn)
--#endregion

--#region 72
function Eden:CustomPreEntityDevolve(entity)
    local callbackTable = GetBirthrightCallbacks(mod.Callbacks.Enums.MC_PRE_ENTITY_DEVOLVE)
    for ptype, callback in ipairs(callbackTable) do
        local ret = callback.Function(entity)
        if ret ~= nil then
            return ret
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_DEVOLVE, Eden.CustomPreEntityDevolve)
--#endregion

--#region 73

--#endregion

function Eden:ChangeOnHit(entity, amount, flags, source, cd)
    local player = entity and entity:ToPlayer() or nil
    if player then
        local callbacks = mod.GetCustomCallbacks(mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG)
        local data = mod.GetPersistentPlayerData(player)
        local ptype = player:GetPlayerType()
        for _,callback in ipairs(callbacks) do
            local otherPlayerType = callback.PlayerType
            if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and otherPlayerType == data.TEdenState or mod.GetMCMValue(otherPlayerType) and mod.GetMCMValue(otherPlayerType) > 1 and player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B and player:GetPlayerType() == otherPlayerType) then
                local MCMValue = mod.GetMCMValue(ptype)
                local maxMCMValue = mod.GetMaxMCMValue(ptype)
                local col = mod.GetOptionsBirthright(MCMValue, maxMCMValue > 3)
                if player:HasCollectible(col) and mod.OptionBirthrightCondition(MCMValue, maxMCMValue, callback.Effect) then
                    local ret = callback.Function(player, amount, flags, source, cd)
                    if ret == false then
                        return false
                    end
                end
            end
        end
        if (mod.MCMOption.Settings["Tainted Eden"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_EDEN_B) then
            ChangeEdenState(player)
        end
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
                local rng = player:GetCollectibleRNG(substituteBirthright)
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
	return player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and mod.MCMOption.Settings["Tainted Eden"] > 1 and mod.MCMOption.Settings["Tainted Eden"] < 4
end)