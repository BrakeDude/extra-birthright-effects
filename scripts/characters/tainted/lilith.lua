local mod = ExtraBirthright
local Lilith = {}

--#region Tainted Lilith
local function shoot_creep(creep_variant, position, direction_vector, puddle_num, puddle_dmg, puddle_scale, puddle_delay, puddle_timeout, spawner)
	if (puddle_num <= 0) or not  Game():GetRoom():IsPositionInRoom(position, 0.0) then
		return nil
	end

	local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, creep_variant, 0, position, Vector.Zero, spawner):ToEffect()
	creep.Scale = puddle_scale
	creep.CollisionDamage = puddle_dmg
	creep:SetTimeout(puddle_timeout)
	--creep:Update()

	local data = creep:GetData()
	data.IsCreep = true
	data.PuddleDirection = direction_vector
	data.PuddleNum = math.max(0, puddle_num - 1)
	data.PuddleDamage = puddle_dmg
	data.PuddleScale = puddle_scale+0.1
	data.PuddleDelay = puddle_delay
	data.PuddleTimeout = puddle_timeout
	data.Spawner = spawner

	return creep
end

function Lilith:CreepFromBellyUpdate(creep)
	local data = creep:GetData()
	if data.IsCreep and data.PuddleDelay ~= nil and creep.FrameCount == data.PuddleDelay then -- spawn next creep puddle
		--local next_position = creep.Position + data.PuddleDirection:Resized(data.PuddleStep)
		shoot_creep(creep.Variant, data.Spawner.Position, data.PuddleDirection,
					data.PuddleNum, data.PuddleDamage,
					data.PuddleScale, data.PuddleDelay, data.PuddleTimeout,
					data.Spawner)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, Lilith.CreepFromBellyUpdate, EffectVariant.PLAYER_CREEP_RED)

function Lilith:CreepFromBelly(entity)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Lilith"])
	if mod.MCMOption.Settings["Tainted Lilith"] > 1 then
		if entity.FrameCount > 2 and entity.FrameCount < 15 then
			entity:GetData().ShootCreep = entity:GetData().ShootCreep or true
			if entity.Player ~= nil then
				local player = entity.Player
					if entity:GetData().ShootCreep and player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_LILITH_B then
						entity:GetData().ShootCreep = false
						shoot_creep(EffectVariant.PLAYER_CREEP_RED, entity.Position, mod.shootDirecton[player:GetFireDirection()],4,player.Damage*1.5,1.3,1,10,entity)
					end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Lilith.CreepFromBelly, FamiliarVariant.UMBILICAL_BABY)

function Lilith:CreepHemorrhage(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Lilith"])
	if mod.MCMOption.Settings["Tainted Lilith"] > 1 then
		if player.FrameCount%5 == 1 and player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_LILITH_B then
			local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position, Vector.Zero, player):ToEffect()
			creep.Scale = 1.2
			creep.CollisionDamage = player.Damage * 2.5
			creep:SetTimeout(10)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Lilith.CreepHemorrhage)
--#endregion
