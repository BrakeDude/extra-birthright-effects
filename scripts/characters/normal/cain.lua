--#region Cain
local mod = ExtraBirthright
function mod:GimmeYourSuff(NPC)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Cain"],true)
	for i = 1,mod.game:GetNumPlayers() do
		local player = Isaac.GetPlayer(i-1)
		if (mod.MCMOption.Settings["Cain"] == 2 or mod.MCMOption.Settings["Cain"] == 4) and player:HasCollectible(collectible) then
			local drop = NPC:GetDropRNG()
			local dropTheRinG = drop:RandomFloat()
			if player:GetPlayerType() == PlayerType.PLAYER_CAIN then
				if NPC ~= EntityType.ENTITY_SHOPKEEPER then
					if dropTheRinG <= 0.22 then
						if not NPC:IsBoss() then
							local pickup = mod.MyRandomPickup(player:GetCollectibleRNG(collectible))
							Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,Isaac.GetFreeNearPosition(NPC.Position,0),Vector.Zero,nil)
							if NPC:IsChampion() then
								Isaac.Spawn(EntityType.ENTITY_PICKUP,pickup.variant,pickup.subtype,Isaac.GetFreeNearPosition(NPC.Position,0),Vector.Zero,nil)
							end
						elseif dropTheRinG <= 0.12 then
							mod.bossposition = Isaac.GetFreeNearPosition(NPC.Position,0)
							mod.wasThereBoss = true
						end
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.GimmeYourSuff);

function mod:BossItemSuff()
	for _,players in ipairs(Isaac.FindByType(1)) do
		local player = players:ToPlayer()
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Cain"],true)
		if (mod.MCMOption.Settings["Cain"] == 2 or mod.MCMOption.Settings["Cain"] == 4) and player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_CAIN then
			if mod.wasThereBoss then
				local ItemPool = mod.game:GetItemPool():GetPoolForRoom(mod.room:GetType(),mod.rng:GetSeed())
				Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,mod.game:GetItemPool():GetCollectible(ItemPool),mod.bossposition,Vector(0, 0),nil)
				mod.wasThereBoss = false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.BossItemSuff)

function mod:GoldenBreak(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Cain"],true)
	if (mod.MCMOption.Settings["Cain"] == 3 or mod.MCMOption.Settings["Cain"] == 5) and player:HasCollectible(collectible) then
		if  player:GetPlayerType() == PlayerType.PLAYER_CAIN and not player:HasGoldenKey() then
			player:AddGoldenKey()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.GoldenBreak);
--#endregion