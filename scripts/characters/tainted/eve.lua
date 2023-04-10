local mod = ExtraBirthright
local Eve = {}
--#region Tainted Eve
function Eve:EveExtraBloodBaby(entitytype,variant,subtype,position,velocity,spawner)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eve"])
	if mod.MCMOption.Settings["Tainted Eve"] > 1 then
		if entitytype == EntityType.ENTITY_FAMILIAR and variant == FamiliarVariant.BLOOD_BABY then
			if spawner ~= nil then
				if spawner.Type == EntityType.ENTITY_PLAYER then
					local player = spawner:ToPlayer()
					if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_EVE_B then
						local searchedPlayer = Isaac.GetPlayer(mod.EsauCheck(player))
						if mod.RNG:RandomFloat() < 0.3 and mod:GetData(searchedPlayer).BirthrightBloodBabyCooldown <= 0 then
							mod:GetData(searchedPlayer).BirthrightBloodBabyCooldown = 3
							Isaac.Spawn(entitytype,variant,subtype,player.Position,velocity,searchedPlayer)
						end
						mod:GetData(searchedPlayer).BirthrightBloodBabyCooldown = mod:GetData(searchedPlayer).BirthrightBloodBabyCooldown - 1
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, Eve.EveExtraBloodBaby)

local function BuffClot(baby)
	if baby:GetData().HP == nil then
		baby.MaxHitPoints = baby.MaxHitPoints * 2
		baby.HitPoints = baby.HitPoints * 2
		baby:GetData().HP = baby.HitPoints
	else
		baby:GetData().HP = baby.HitPoints
	end
end

function Eve:BetterBloodBabies(baby)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eve"])
	if mod.MCMOption.Settings["Tainted Eve"] > 1 then
		if baby.SpawnerEntity ~= nil then
			local player = baby.SpawnerEntity
			if player.Type == EntityType.ENTITY_PLAYER then
				player = player:ToPlayer()
				if player:GetPlayerType() == PlayerType.PLAYER_EVE_B and player:HasCollectible(collectible) then
					BuffClot(baby)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Eve.BetterBloodBabies, FamiliarVariant.BLOOD_BABY)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_FAMILIAR_UPDATE, 0, PlayerType.PLAYER_EVE_B, function(baby)
	if baby.SpawnerEntity ~= nil then
		local player = baby.SpawnerEntity
		if player.Type == EntityType.ENTITY_PLAYER then
			BuffClot(baby)
		end
	end
end, FamiliarVariant.BLOOD_BABY)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_EVE_B and mod.MCMOption.Settings["Tainted Eve"] == 2
end)
--#endregion