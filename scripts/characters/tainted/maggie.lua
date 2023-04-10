local mod = ExtraBirthright
local Maggie = {}

local function Regen(player)
	player:AddHearts(1)
	SFXManager():Play(SoundEffect.SOUND_VAMP_GULP,1,2,false)
end

function Maggie:TaintedRegeneration()
	if mod.MCMOption.Settings["Tainted Magdalene"] > 1 then
		for _,player in ipairs(mod:GetPlayers()) do
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Magdalene"])
			if player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B then
				if player:HasCollectible(collectible) then
					Regen(player)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Maggie.TaintedRegeneration)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD, 0, PlayerType.PLAYER_MAGDALENA_B, function()
	for _,player in ipairs(mod:GetPlayerType(PlayerType.PLAYER_EDEN_B)) do
		if not mod:GetData(player).Regened then
			mod:GetData(player).Regened = true
			Regen(player)
		end
	end
end)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_MAGDALENA_B, function()
	for _,player in ipairs(mod:GetPlayerType(PlayerType.PLAYER_EDEN_B)) do
		if mod:GetData(player).Regened then
			mod:GetData(player).Regened = nil
		end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B and mod.MCMOption.Settings["Tainted Magdalene"] == 2
end)