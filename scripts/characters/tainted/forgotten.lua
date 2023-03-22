local mod = ExtraBirthright
local Forgotten = {}

function Forgotten:TForgorBones(player,cache)  
    if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B and mod.MCMOption.Settings["Tainted Forgotten"] > 1 then
        local soul = player:GetOtherTwin()
        local data = mod:GetData(player)
        if soul and data.TriggerForgorBones then
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Forgotten"])
            if player:HasCollectible(collectible) then
                local bones = 0
                for _,bone in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.BONE_ORBITAL,-1)) do
                    if bone.SpawnerEntity and GetPtrHash(bone.SpawnerEntity) == GetPtrHash(soul) then
                        bones = bones + 1
                    end
                end
                soul:CheckFamiliar(FamiliarVariant.BONE_ORBITAL, math.min(5,5-math.max(0,bones)), RNG(), nil, 0)
            end
            data.TriggerForgorBones = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Forgotten.TForgorBones, CacheFlag.CACHE_FAMILIARS)

function Forgotten:TForgorOnRoom()  
    if mod.MCMOption.Settings["Tainted Forgotten"] > 1 then
        for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_THEFORGOTTEN_B)) do
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Forgotten"])
            if player:HasCollectible(collectible) then
                local soul = player:GetOtherTwin()
                local data = mod:GetData(player)
                if soul and not data.TriggerForgorBones and not Game():GetRoom():IsClear() then
                    data.TriggerForgorBones = true
                    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
                    player:EvaluateItems()
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Forgotten.TForgorOnRoom)

mod.AddOnPickupFunction(function(player)
    local ptype = player:GetPlayerType()
    if ptype == PlayerType.PLAYER_THEFORGOTTEN_B and mod.MCMOption.Settings["Tainted Forgotten"] > 1 then
        mod:GetData(player).TriggerForgorBones = true
        player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
        player:EvaluateItems()
    end
end)

mod.AddBirthrightChangeCondition(function(player)
	return (player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B or player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B) and mod.MCMOption.Settings["Tainted Forgotten"] == 2
end)