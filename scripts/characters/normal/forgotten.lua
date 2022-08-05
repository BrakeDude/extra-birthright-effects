local mod = ExtraBirthright

function mod:ForgottenHit(entity)
	local player = entity:ToPlayer()
	local data = mod:GetData(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
	if player:HasCollectible(collectible) and mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
        data.ForgottenHearts = player:GetBoneHearts()
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.ForgottenHit, EntityType.ENTITY_PLAYER)

function mod:ForgottenBones(player)
	if mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
		local data = mod:GetData(player)
	    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
        if data.ForgottenHearts and player:HasCollectible(collectible) then
            if player:GetBoneHearts() < data.ForgottenHearts then
                for i = 1, math.min(6,player:GetCollectibleRNG(collectible):RandomInt(10)) do
                    local bone = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_ORBITAL, 0 , player.Position, Vector.Zero, player):ToFamiliar()
                    mod:GetData(bone).BoneAfter = bone.EntityCollisionClass
                    bone.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                    
                end
            end
            data.ForgottenHearts = nil
        end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.ForgottenBones)

function mod:UpdateBones(familiar)
    if familiar.FrameCount > 15 then
        local data = mod:GetData(familiar)
        if data.BoneAfter ~= nil then
            familiar.EntityCollisionClass = data.BoneAfter 
            data.BoneAfter = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.UpdateBones, FamiliarVariant.BONE_ORBITAL)