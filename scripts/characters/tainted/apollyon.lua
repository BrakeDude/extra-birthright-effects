local mod = ExtraBirthright
local Appolyon = {}
local game = Game()
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

local function RoomSpawn(player)
	local room = game:GetRoom()
	if room:IsFirstVisit() and not room:IsClear() then
		local rng = RNG()
		rng:SetSeed(room:GetSpawnSeed(), 35)
		local spawncount = rng:RandomInt(5)+1
		spawncount = spawncount < 2 and 2 or spawncount
		rng:Next()
		for x = 1,spawncount do
			local rnglocust = rng:RandomInt(5)+1
			rng:Next()
			Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rnglocust, player.Position, Vector.Zero, player)
		end
	end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_APOLLYON_B, 1, function()
	for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_EDEN_B, PlayerType.PLAYER_APOLLYON_B})) do
		local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_APOLLYON_B or player:GetPlayerType() ~= PlayerType.PLAYER_EDEN_B then
			RoomSpawn(player)
		end
	end
end)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_APOLLYON_B, 2, function()
	for _,player in ipairs(mod:GetCustomBirthrightPlayers({PlayerType.PLAYER_EDEN_B})) do
		local data = mod.GetPersistentPlayerData(player)
		if player:GetPlayerType() == PlayerType.PLAYER_EDEN_B and data.TEdenState and data.TEdenState == PlayerType.PLAYER_APOLLYON_B then
			RoomSpawn(player)
		end
	end
end)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_APOLLYON_B and (mod.MCMOption.Settings["Tainted Apollyon"] == 2 or mod.MCMOption.Settings["Tainted Apollyon"] == 4) then
		local rng = RNG()
		local room = game:GetRoom()
		rng:SetSeed(room:GetSpawnSeed() + room:GetAwardSeed(), 35)
		for x = 1,20 do
			local rnglocust = rng:RandomInt(5)+1
			Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rnglocust, player.Position, Vector.Zero, player)
			rng:Next()
		end
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B and mod.MCMOption.Settings["Tainted Apollyon"] > 1 and mod.MCMOption.Settings["Tainted Apollyon"] < 4
end)
--#endregion