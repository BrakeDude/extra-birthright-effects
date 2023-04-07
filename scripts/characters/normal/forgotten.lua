local mod = ExtraBirthright
local Forgotten = {}

function Forgotten:ForgottenHit(entity)
	local player = entity:ToPlayer()
	local data = mod.GetPersistentPlayerData(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
	if player:HasCollectible(collectible) and mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
        data.ForgottenHearts = player:GetBoneHearts()
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Forgotten.ForgottenHit, EntityType.ENTITY_PLAYER)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_THEFORGOTTEN, function(player)
    local data = mod.GetPersistentPlayerData(player)
    data.ForgottenHearts = player:GetBoneHearts()
end)

local function Bones(player)
    local data = mod.GetPersistentPlayerData(player)
    if data.ForgottenHearts then
        if player:GetBoneHearts() < data.ForgottenHearts then
            for i = 1, math.min(6,mod.RNG:RandomInt(10)) do
                local bone = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_ORBITAL, 0 , player.Position, Vector.Zero, player):ToFamiliar()
                mod:GetData(bone).BoneAfter = bone.EntityCollisionClass
                bone.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                
            end
        end
        data.ForgottenHearts = nil
    end
end

function Forgotten:ForgottenBones(player)
	if mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
	    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
        if player:HasCollectible(collectible) then
            Bones(player)
        end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Forgotten.ForgottenBones)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_THEFORGOTTEN, Bones)

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