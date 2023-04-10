local mod = ExtraBirthright
local Bethany = {}
--#region Tainted Bethany

local function WispLogic(wisp, player)
	local fire_direction = player:GetFireDirection()
	if fire_direction ~= Direction.NO_DIRECTION then
		local tear_vector = mod.shootDirecton[fire_direction]:Normalized()
		if wisp.FireCooldown <= 0 then
			local entity = wisp:FireProjectile(tear_vector)
			local tear = entity:ToTear()
			tear:AddTearFlags(player.TearFlags)
			tear.Scale = 0.6
			local color = Color(0.4,0.15,0.38,1)
			color:SetOffset(0.28,0,0.455)
			tear.Color=color
			tear:AddTearFlags(TearFlags.TEAR_HOMING)
			tear:AddTearFlags(TearFlags.TEAR_SPECTRAL)
			tear.CollisionDamage = player.Damage / 2.5
			wisp.FireCooldown = math.ceil(player.MaxFireDelay)
		end
	end
	wisp.FireCooldown = wisp.FireCooldown - 1
	if wisp:GetData().HP == nil then
		wisp.MaxHitPoints = wisp.MaxHitPoints * 2
		wisp.HitPoints = wisp.HitPoints * 2
		wisp:GetData().HP = wisp.HitPoints
	else
		wisp:GetData().HP = wisp.HitPoints
	end
end

function Bethany:BetterWisps(wisp)
	if mod.MCMOption.Settings["Tainted Bethany"] > 1 then
		if wisp.SpawnerEntity ~= nil then
			local player = wisp.SpawnerEntity
			if player.Type == EntityType.ENTITY_PLAYER then
				player = player:ToPlayer()
				local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Bethany"])
				if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player:HasCollectible(collectible) then
					WispLogic(wisp,player)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Bethany.BetterWisps, FamiliarVariant.ITEM_WISP)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_FAMILIAR_UPDATE, 0, PlayerType.PLAYER_BETHANY_B, function(wisp)
	if wisp.SpawnerEntity ~= nil then
		local player = wisp.SpawnerEntity
		if player.Type == EntityType.ENTITY_PLAYER then
			WispLogic(wisp,player)
		end
	end
end, FamiliarVariant.ITEM_WISP)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and mod.MCMOption.Settings["Tainted Bethany"] == 2
end)
--#endregion