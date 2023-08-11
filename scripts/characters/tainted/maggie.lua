local mod = ExtraBirthright
local Maggie = {}

local function Regen(player)
	player:AddHearts(1)
	SFXManager():Play(SoundEffect.SOUND_VAMP_GULP,1,2,false)
end


mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD, 0, PlayerType.PLAYER_MAGDALENA_B, 1, function()
	for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_EDEN_B, PlayerType.PLAYER_MAGDALENA_B})) do
		local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_MAGDALENA_B or player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B then
			if not mod:GetData(player).Regened then
				mod:GetData(player).Regened = true
				Regen(player)
			end
		end
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	for _,player in ipairs(mod:GetPlayers()) do
		if mod:GetData(player).Regened then
			mod:GetData(player).Regened = nil
		end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA_B and mod.MCMOption.Settings["Tainted Magdalene"] == 2
end)