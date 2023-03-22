local mod = ExtraBirthright
local Maggie = {}

function Maggie:TaintedRegeneration()
	if mod.MCMOption.Settings["Tainted Magdalene"] > 1 then
		for _,player in ipairs(mod:GetPlayers()) do
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Magdalene"])
			if player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B then
				if player:HasCollectible(collectible) then
					player:AddHearts(1)
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP,1,2,false)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Maggie.TaintedRegeneration)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B and mod.MCMOption.Settings["Tainted Magdalene"] == 2
end)