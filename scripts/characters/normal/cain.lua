--#region Cain
local mod = ExtraBirthright
local Cain = {}
local bossposition = Vector.Zero or Vector(0,0)
local wasThereBoss = false

local function NpcLoot(npc)
	local drop = npc:GetDropRNG()
	local dropTheRinG = drop:RandomFloat()
	if npc ~= EntityType.ENTITY_SHOPKEEPER then
		if dropTheRinG <= 0.50 then
			if not npc:IsBoss() then
				local pickup = mod.MyRandomPickup(drop)
				Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,Isaac.GetFreeNearPosition(npc.Position,0),Vector.Zero,nil)
				if npc:IsChampion() then
					Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,Isaac.GetFreeNearPosition(npc.Position,0),Vector.Zero,nil)
				end
			elseif dropTheRinG <= 0.30 then
				bossposition = Isaac.GetFreeNearPosition(npc.Position,0)
				wasThereBoss = true
			end
		end
	end
end
mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NPC_DEATH, 0, PlayerType.PLAYER_CAIN, 1, NpcLoot)

local function BossLoot()
	local game = Game()
	local room = game:GetRoom()
	if wasThereBoss then
		local ItemPool = game:GetItemPool():GetPoolForRoom(room:GetType(),RNG():GetSeed())
		Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,game:GetItemPool():GetCollectible(ItemPool),bossposition,Vector(0, 0),nil)
		wasThereBoss = false
	end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PRE_SPAWN_CLEAN_AWARD, 0, PlayerType.PLAYER_CAIN, 1, BossLoot)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_CAIN, 2, function(player)
	if not player:HasGoldenKey() then
		player:AddGoldenKey()
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_CAIN and mod.MCMOption.Settings["Cain"] > 1 and mod.MCMOption.Settings["Cain"] < 4
end)
--#endregion