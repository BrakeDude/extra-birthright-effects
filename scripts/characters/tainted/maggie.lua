local mod = ExtraBirthright

function mod:TaintedRegeneration()
	if mod.MCMOption.Settings["Tainted Magdalene"] > 1 then
		for _,players in ipairs(Isaac.FindByType(1)) do
			local player = players:ToPlayer()
			if player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
					player:AddHearts(1)
					mod.sfx:Play(SoundEffect.SOUND_VAMP_GULP,1,2,false)
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.TaintedRegeneration)