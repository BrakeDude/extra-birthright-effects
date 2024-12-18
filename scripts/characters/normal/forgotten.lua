local mod = ExtraBirthright
local Forgotten = {}

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_THEFORGOTTEN, 1, function(player)
    local data = mod.GetPersistentPlayerData(player)
    data.ForgottenHearts = player:GetBoneHearts()
end)

local function Bones(player)
    local data = mod.GetPersistentPlayerData(player)
    if data.ForgottenHearts then
        if player:GetBoneHearts() < data.ForgottenHearts then
            local rng = player:GetDropRNG()
            for i = 1, math.min(6,rng:RandomInt(10)) do
                local bone = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_ORBITAL, 0 , player.Position, Vector.Zero, player):ToFamiliar()
                mod:GetData(bone).BoneAfter = bone.EntityCollisionClass
                bone.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            end
            rng:Next()
        end
        data.ForgottenHearts = nil
    end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_THEFORGOTTEN, 1, Bones)

function Forgotten:UpdateBones(familiar)
    if familiar.FrameCount > 15 then
        local data = mod:GetData(familiar)
        if data.BoneAfter ~= nil then
            familiar.EntityCollisionClass = data.BoneAfter 
            data.BoneAfter = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Forgotten.UpdateBones, FamiliarVariant.BONE_ORBITAL)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN and mod.MCMOption.Settings["The Forgotten"] == 2
end)