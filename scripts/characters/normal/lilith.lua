--#region Lilith
local mod = ExtraBirthright
local Lilith = {}
local game = Game()

function Lilith:SpawnMinisaacs()
	
	local room = game:GetRoom()
	local MiniIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in pairs(MiniIsaacs) do
		if mod:GetData(minisaac).BoxOfFriendRemove then
			minisaac:Remove()
		end
	end
	if mod.MCMOption.Settings["Lilith"] > 1 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lilith"])
		for i = 1, game:GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			local pos = Isaac.GetFreeNearPosition(player.Position,0)
			if player:GetPlayerType() == PlayerType.PLAYER_LILITH then
				if player:HasCollectible(collectible) and room:IsFirstVisit() and not room:IsClear() then
					local count = 2
					if room:GetRoomShape() >= RoomShape.ROOMSHAPE_2x2 then
						count = 4
					end
					for i=1, count do
						local minisaac = Isaac.Spawn(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC,2,pos,Vector.Zero,player):ToFamiliar()--player:AddMinisaac(pos, false):ToFamiliar()
						mod:GetData(minisaac).FromBirthright = true
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Lilith.SpawnMinisaacs)

function Lilith:DespawnMinisaacsOnNewLevel()
	local MiniIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in pairs(MiniIsaacs) do
		if mod:GetData(minisaac).FromBirthright then
			minisaac:Remove()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Lilith.DespawnMinisaacsOnNewLevel)

function Lilith:MiniBoxFriends(_,_,player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lilith"])
	if mod.MCMOption.Settings["Lilith"] > 1 then
		if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_LILITH then
			local MinIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
			for _,minisaac in ipairs(MinIsaacs) do
				if GetPtrHash(minisaac:ToFamiliar().Player) == GetPtrHash(player) then
					local isaac = Isaac.Spawn(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC,2,minisaac.Position,Vector.Zero,minisaac:ToFamiliar().Player):ToFamiliar()--minisaac:ToFamiliar().Player:AddMinisaac(minisaac.Position, false)
					mod:GetData(isaac).BoxOfFriendRemove = true
				end
			end
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lilith.MiniBoxFriends, CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)
--#endregion