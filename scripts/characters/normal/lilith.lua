--#region Lilith
local mod = ExtraBirthright
function mod:SpawnMinisaacs()
	local MiniIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in pairs(MiniIsaacs) do
		if mod:GetData(minisaac).BoxOfFriendRemove then
			minisaac:Remove()
		end
	end
	if mod.MCMOption.Settings["Lilith"] > 1 then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lilith"])
		for i = 1, mod.game:GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			local pos = Isaac.GetFreeNearPosition(player.Position,0)
			if player:GetPlayerType() == PlayerType.PLAYER_LILITH then
				if player:HasCollectible(collectible) and mod.room:IsFirstVisit() and not mod.room:IsClear() then
					local count = 2
					if mod.room:GetRoomShape() >= RoomShape.ROOMSHAPE_2x2 then
						count = 4
					end
					for i=1, count do
						local minisaac = Isaac.Spawn(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC,2,pos,mod.ZERO_VECTOR,player):ToFamiliar()--player:AddMinisaac(pos, false):ToFamiliar()
						mod:GetData(minisaac).FromBirthright = true
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.SpawnMinisaacs)

function mod:DespawnMinisaacsOnNewLevel()
	local MiniIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
	for _,minisaac in pairs(MiniIsaacs) do
		if mod:GetData(minisaac).FromBirthright then
			minisaac:Remove()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.DespawnMinisaacsOnNewLevel)

function mod:MiniBoxFriends(_,_,player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Lilith"])
	if mod.MCMOption.Settings["Lilith"] > 1 then
		if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_LILITH then
			local MinIsaacs = Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC)
			for _,minisaac in ipairs(MinIsaacs) do
				if minisaac:ToFamiliar().Player.ControllerIndex == player.ControllerIndex then
					local isaac = Isaac.Spawn(EntityType.ENTITY_FAMILIAR,FamiliarVariant.MINISAAC,2,minisaac.Position,mod.ZERO_VECTOR,minisaac:ToFamiliar().Player):ToFamiliar()--minisaac:ToFamiliar().Player:AddMinisaac(minisaac.Position, false)
					mod:GetData(isaac:ToFamiliar()).BoxOfFriendRemove = true
				end
			end
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.MiniBoxFriends, CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)
--#endregion