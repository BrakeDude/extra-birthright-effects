--#region Cain
local mod = ExtraBirthright
local Cain = {}
local bossposition = Vector.Zero or Vector(0,0)

local function NpcLoot(npc)
	local drop = npc:GetDropRNG()
	local dropTheRinG = drop:RandomFloat()
	if npc ~= EntityType.ENTITY_SHOPKEEPER then
		if dropTheRinG <= 0.22 then
			if not npc:IsBoss() then
				local pickup = mod.MyRandomPickup(dropTheRinG)
				Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,Isaac.GetFreeNearPosition(npc.Position,0),Vector.Zero,nil)
				if npc:IsChampion() then
					Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,Isaac.GetFreeNearPosition(npc.Position,0),Vector.Zero,nil)
				end
			elseif dropTheRinG <= 0.12 then
				bossposition = Isaac.GetFreeNearPosition(npc.Position,0)
				mod.wasThereBoss = true
			end
		end
	end
end

function Cain:GimmeYourSuff(npc)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Cain"],true)
	for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_CAIN)) do
		if (mod.MCMOption.Settings["Cain"] == 2 or mod.MCMOption.Settings["Cain"] == 4) and player:HasCollectible(collectible) then
			NpcLoot(npc)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, Cain.GimmeYourSuff)

mod:AddPriorityCallback(mod.Callbacks.MC_POST_NPC_DEATH, PlayerType.PLAYER_CAIN, NpcLoot)

local function BossLoot()
	local game = Game()
	local room = game:GetRoom()
	if mod.wasThereBoss then
		local ItemPool = game:GetItemPool():GetPoolForRoom(room:GetType(),RNG():GetSeed())
		Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,game:GetItemPool():GetCollectible(ItemPool),bossposition,Vector(0, 0),nil)
		mod.wasThereBoss = false
	end
end

function Cain:BossItemSuff()
	for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_CAIN)) do
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Cain"],true)
		if (mod.MCMOption.Settings["Cain"] == 2 or mod.MCMOption.Settings["Cain"] == 4) and player:HasCollectible(collectible) then
			BossLoot()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Cain.BossItemSuff)

mod:AddPriorityCallback(mod.Callbacks.MC_PRE_SPAWN_CLEAN_AWARD, PlayerType.PLAYER_CAIN, BossLoot)

function Cain:GoldenBreak(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Cain"],true)
	if (mod.MCMOption.Settings["Cain"] == 3 or mod.MCMOption.Settings["Cain"] == 5) and player:HasCollectible(collectible) then
		if  player:GetPlayerType() == PlayerType.PLAYER_CAIN and not player:HasGoldenKey() then
			player:AddGoldenKey()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Cain.GoldenBreak);

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_CAIN and mod.MCMOption.Settings["Cain"] > 1 and mod.MCMOption.Settings["Cain"] < 4
end)
--#endregion