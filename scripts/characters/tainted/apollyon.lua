local mod = ExtraBirthright
local Appolyon = {}
--#region Tainted Apollyon

function Appolyon:LocustHolyAura(locust)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Apollyon"],true)
	if mod.MCMOption.Settings["Tainted Apollyon"] == 3 or mod.MCMOption.Settings["Tainted Apollyon"] == 5 then
		if locust.SpawnerEntity ~= nil then
			local player = locust.SpawnerEntity
			if player.Type == EntityType.ENTITY_PLAYER then
				player = player:ToPlayer()
				if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B and player:HasCollectible(collectible) then
					local Aura=locust:GetData().Godhead
					if not Aura or Aura:IsDead() then
						locust:GetData().Godhead=Isaac.Spawn(1000,123,2,locust.Position,Vector.Zero,locust):ToEffect()
						Aura=locust:GetData().Godhead
						Aura:FollowParent(locust)
						Aura:GetSprite():ReplaceSpritesheet(0,'gfx/effects/effect_hallowedground.png')
						Aura:GetSprite():LoadGraphics()
						Aura.SpriteScale=Vector(0.3,0.3)
						local AuraColor=Color(1,1,1,0.5)
						AuraColor:SetColorize(1,1,0.5,1)
						Aura:GetSprite().Offset=Vector(2,-7)
						Aura.Color=AuraColor
						Aura.DepthOffset=-999
					end
					local entitiesList=Isaac.FindInRadius(locust.Position,25,1<<3)
					if locust.EntityCollisionClass==4 then
						for _,entity in ipairs(entitiesList) do
							if entity:IsActiveEnemy() and not entity:HasEntityFlags(1<<29) then
								entity:TakeDamage(1.75,0,EntityRef(locust),0)
							end
						end
					end
				elseif locust:GetData().Godhead then
					(locust:GetData().Godhead):GetSprite().Color = Color(1,1,1,0)
				end
			end
		end
	else
		if locust:GetData().Godhead then
			(locust:GetData().Godhead):GetSprite().Color = Color(1,1,1,0)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Appolyon.LocustHolyAura,FamiliarVariant.ABYSS_LOCUST)

function Appolyon:NewLocusts()
	local game = Game()
	local room = game:GetRoom()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Apollyon"],true)
	if mod.MCMOption.Settings["Tainted Apollyon"] == 2 or mod.MCMOption.Settings["Tainted Apollyon"] == 4 then
		for i = 1, game:GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B and player:HasCollectible(collectible) and room:IsFirstVisit() and not room:IsClear() then
				local spawncount = player:GetCollectibleRNG(collectible):RandomInt(5)+1
				spawncount = spawncount < 2 and 2 or spawncount
				for x = 1,spawncount do
					local rnglocust = player:GetCollectibleRNG(collectible):RandomInt(5)+1
					Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rnglocust, player.Position, Vector.Zero, player)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Appolyon.NewLocusts);
--#endregion