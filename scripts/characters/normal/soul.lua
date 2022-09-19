local mod = ExtraBirthright

function mod:ForgottenSoulHit(entity,damage)
	local player = entity:ToPlayer()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
	if player:HasCollectible(collectible) and mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THESOUL then
        print(math.floor(damage / 2) + player:GetSoulHearts() % 2)
        for i = 1,math.floor(damage / 2) + player:GetSoulHearts() % 2,1 do
            print(1)
            for j = 1, math.min(1,player:GetCollectibleRNG(collectible):RandomInt(3)) do
                local wisp = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, 0 , player.Position, Vector.Zero, player):ToFamiliar()
            end
        end
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.ForgottenSoulHit, EntityType.ENTITY_PLAYER)