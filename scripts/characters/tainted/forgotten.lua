local mod = ExtraBirthright
local Forgotten = {}

local function TForgorBones(player,cache)
    local soul = player:GetOtherTwin() or player
    local data = mod:GetData(player)
    if soul and data.TriggerForgorBones then
        local bones = 0
        for _,bone in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.BONE_ORBITAL,-1)) do
            if bone.SpawnerEntity and GetPtrHash(bone.SpawnerEntity) == GetPtrHash(soul) then
                bones = bones + 1
            end
        end
        soul:CheckFamiliar(FamiliarVariant.BONE_ORBITAL, math.min(5,5-math.max(0,bones)), RNG(), nil, 0)
        data.TriggerForgorBones = nil
    end
end
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_THEFORGOTTEN_B, 1, TForgorBones, CacheFlag.CACHE_FAMILIARS)
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_EVALUATE_CACHE, 0, PlayerType.PLAYER_THESOUL_B, 1, TForgorBones, CacheFlag.CACHE_FAMILIARS)

local function TForgorOnRoom()
    for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_THEFORGOTTEN_B, PlayerType.PLAYER_EDEN_B})) do
        local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_THEFORGOTTEN_B or player:GetPlayersByType() ~= PlayerType.PLAYER_EDEN_B then
            local soul = player:GetOtherTwin() or player
            local data = mod:GetData(player)
            if soul and not data.TriggerForgorBones and not Game():GetRoom():IsClear() then
                data.TriggerForgorBones = true
                player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
                player:EvaluateItems()
            end
        end
    end
end
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_THESOUL_B, 1, TForgorOnRoom)

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