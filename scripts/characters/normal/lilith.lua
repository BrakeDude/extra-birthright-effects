--#region Lilith
local mod = ExtraBirthright
local Lilith = {}
local game = Game()

local function NewRoomBabies(player,subtype)
	local room = game:GetRoom()
	if room:IsFirstVisit() and not room:IsClear() then
		local pos = Isaac.GetFreeNearPosition(player.Position,0)
		local count = 2
		if room:GetRoomShape() >= RoomShape.ROOMSHAPE_2x2 then
			count = 4
		end
		for i=1, count do
			local minisaac = Isaac.Spawn(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC,subtype,pos,Vector.Zero,player):ToFamiliar()--player:AddMinisaac(pos, false):ToFamiliar()
			local data = mod.GetPersistentPlayerData(minisaac)
			data.FromBirthright = true
		end
	end
end

function Lilith:SpawnMinisaacs()
	local MiniIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in pairs(MiniIsaacs) do
		local data = mod.GetPersistentPlayerData(minisaac)
		if data.BoxOfFriendRemove then
			minisaac:Remove()
			data = nil
		end
	end
	if mod.MCMOption.Settings["Lilith"] > 1 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lilith"])
		for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_LILITH)) do
			if player:HasCollectible(collectible) then
				NewRoomBabies(player,2)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Lilith.SpawnMinisaacs)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_NEW_ROOM, 0, PlayerType.PLAYER_LILITH, function()
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
	for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN_B)) do
		local data = mod.GetPersistentPlayerData(player)
		if player:HasCollectible(collectible) and data.TEdenState == PlayerType.PLAYER_LILITH then
			NewRoomBabies(player,player:GetBodyColor()+1)
		end
	end
end)

function Lilith:DespawnMinisaacsOnNewLevel()
	local MiniIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in pairs(MiniIsaacs) do
		local data = mod.GetPersistentPlayerData(minisaac)
		if data.FromBirthright then
			minisaac:Remove()
			data = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Lilith.DespawnMinisaacsOnNewLevel)

local function SpawnBabies(player,type)
	local MinIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in ipairs(MinIsaacs) do
		if GetPtrHash(minisaac:ToFamiliar().Player) == GetPtrHash(player) then
			local isaac = Isaac.Spawn(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC,minisaac.SubType,minisaac.Position,Vector.Zero,minisaac:ToFamiliar().Player):ToFamiliar()--minisaac:ToFamiliar().Player:AddMinisaac(minisaac.Position, false)
			local data = mod.GetPersistentPlayerData(minisaac)
			data.BoxOfFriendRemove = true
		end
	end
end

function Lilith:MiniBoxFriends(_,_,player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lilith"])
	if mod.MCMOption.Settings["Lilith"] > 1 then
		if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_LILITH then
			SpawnBabies(player,2)
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lilith.MiniBoxFriends, CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_USE_ITEM, 0, PlayerType.PLAYER_LILITH, function(_,_,player)
	SpawnBabies(player)
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_LILITH and mod.MCMOption.Settings["Lilith"] == 2
end)
--#endregion