local mod = ExtraBirthright
local game = Game()
--#region Cain Pickup Generator
function mod.MyRandomPickup(rng)
	local pickup = {variant=nil,subtype=0}
	local chance = rng:RandomFloat()
	local itemPool = game:GetItemPool()
	if chance <= 0.14 then
		pickup.variant = PickupVariant.PICKUP_TAROTCARD
		pickup.subtype = itemPool:GetCard(rng:Next()+1,true,false)
	end
	if chance <= 0.29 and (not pickup.variant) then
		pickup.variant = PickupVariant.PICKUP_LIL_BATTERY
	end
	if chance <= 0.42 and (not pickup.variant) then
		pickup.variant = PickupVariant.PICKUP_COIN
	end
	if chance <= 0.56 and (not pickup.variant) then
		pickup.variant = PickupVariant.PICKUP_KEY
	end
	if chance <= 0.71 and (not pickup.variant) then
		pickup.variant = PickupVariant.PICKUP_BOMB
	end
	if chance <= 0.85 and (not pickup.variant) then
		pickup.variant = PickupVariant.PICKUP_PILL
		pickup.subtype = itemPool:GetPill(rng:Next()+1)
	end
	if (not pickup.variant) then
		pickup.variant = PickupVariant.PICKUP_HEART
	end
	return pickup
end
--#endregion

function mod.getChest(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.subtype = 1
	if rng:RandomFloat() <= 0.2 then
		pickup.variant = PickupVariant.PICKUP_BOMBCHEST
	elseif rng:RandomFloat() <= 0.40 then
		pickup.variant = PickupVariant.PICKUP_LOCKEDCHEST
	elseif rng:RandomFloat() <= 0.60 then
		pickup.variant = PickupVariant.PICKUP_CHEST
	else
		pickup.variant = PickupVariant.PICKUP_SPIKEDCHEST
	end
	return pickup
end


function mod.EsauCheck(player)
	if not player or (player and not player.GetData) then
		return nil
	end
	local currentPlayer = 1
	for i=1, Game():GetNumPlayers() do
		local otherPlayer = Isaac.GetPlayer(i-1)
		local searchPlayer = i
		--added GetPlayerType() to get Jacob and Easu seperatly
		if otherPlayer.ControllerIndex == player.ControllerIndex and otherPlayer:GetPlayerType() == player:GetPlayerType() then
			currentPlayer = searchPlayer
		end
	end
	return currentPlayer
end

function mod.GetMaxCollectibleID()
    return Isaac.GetItemConfig():GetCollectibles().Size -1
end

function mod.GetMaxTrinketID()
    return Isaac.GetItemConfig():GetTrinkets().Size -1
end

function mod.Shuffle(list,rng)
	local size, shuffled  = #list, list
    for i = size, 2, -1 do
		local j = rng:RandomInt(i) + 1
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end
    return shuffled
end

-----------------------------------
--Helper Functions (thanks piber)--
-----------------------------------

function mod:GetPlayers(functionCheck, ...)

	local args = {...}
	local players = {}
	
	local game = Game()
	
	for i=1, game:GetNumPlayers() do
	
		local player = Isaac.GetPlayer(i-1)
		
		local argsPassed = true
		
		if type(functionCheck) == "function" then
		
			for j=1, #args do
			
				if args[j] == "player" then
					args[j] = player
				elseif args[j] == "currentPlayer" then
					args[j] = i
				end
				
			end
			
			if not functionCheck(table.unpack(args)) then
			
				argsPassed = false
				
			end
			
		end
		
		if argsPassed then
			players[#players+1] = player
		end
		
	end
	
	return players
	
end

function mod:GetPlayersByType(playerTypes)
	playerTypes = playerTypes or nil
	local players = mod:GetPlayers()
	if playerTypes == nil then
		return players
	end
	local table = {}
	for _,playerType in ipairs(playerTypes) do
		for _, player in ipairs(players) do
			if player:GetPlayerType() == playerType then
				table[#table+1] = player
			end
		end
	end
	return table
end

function mod:GetPlayerFromTear(tear)
	for i=1, 2 do
		local check = nil
		if i == 1 then
			check = tear.Parent
		--elseif i == 2 then
		--	check = mod:GetSpawner(tear)
		elseif i == 2 then
			check = tear.SpawnerEntity
		end
		if check then
			if check.Type == EntityType.ENTITY_PLAYER then
				return mod:GetPtrHashEntity(check):ToPlayer()
			elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS then
				local data = mod:GetData(tear)
				data.IsIncubusTear = true
				return check:ToFamiliar().Player:ToPlayer()
			end
		end
	end
	return nil
end

function mod:GetPtrHashEntity(entity)
	if entity then
		if entity.Entity then
			entity = entity.Entity
		end
		for _, matchEntity in pairs(Isaac.FindByType(entity.Type, entity.Variant, entity.SubType, false, false)) do
			if GetPtrHash(entity) == GetPtrHash(matchEntity) then
				return matchEntity
			end
		end
	end
	return nil
end

function mod:GetData(entity)
	if entity then
		local data = entity:GetData()
		if not data.ExtraBirthright then
			data.ExtraBirthright = {}
		end
		return data.ExtraBirthright
	end
	return nil
end

function mod.GetPersistentPlayerData(entity) --From Retribution, by Xalum (modified by BrakeDude)
	if entity:ToPlayer() then
		local player = entity:ToPlayer()
		local seedReference = CollectibleType.COLLECTIBLE_SAD_ONION
		local playerType = player:GetPlayerType()

		if playerType == PlayerType.PLAYER_LAZARUS2_B then
			seedReference = CollectibleType.COLLECTIBLE_INNER_EYE
		elseif playerType ~= PlayerType.PLAYER_ESAU then
			player = player:GetMainTwin()
		end

		local tableIndex = tostring(player:GetCollectibleRNG(seedReference):GetSeed())
		mod.PlayerData[tableIndex] = mod.PlayerData[tableIndex] or {}
		return mod.PlayerData[tableIndex]
	elseif entity:ToFamiliar() then
		local familiar = entity:ToFamiliar()
		
		local tableIndex = tostring(familiar.InitSeed)
		mod.FamiliarData[tableIndex] = mod.FamiliarData[tableIndex] or {}
		return mod.FamiliarData[tableIndex]
	else
		return {}
	end
end

function mod.RemovePersistentPlayerData(entity)
	if entity:ToPlayer() then
		local player = entity:ToPlayer()
		local seedReference = CollectibleType.COLLECTIBLE_SAD_ONION
		local playerType = player:GetPlayerType()

		if playerType == PlayerType.PLAYER_LAZARUS2_B then
			seedReference = CollectibleType.COLLECTIBLE_INNER_EYE
		elseif playerType ~= PlayerType.PLAYER_ESAU then
			player = player:GetMainTwin()
		end

		local tableIndex = tostring(player:GetCollectibleRNG(seedReference):GetSeed())
		mod.PlayerData[tableIndex] = nil
	elseif entity:ToFamiliar() and mod.FamiliarData then
		local familiar = entity:ToFamiliar()
		
		local tableIndex = tostring(familiar.InitSeed)
		mod.FamiliarData[tableIndex] = nil
	end
end

function mod:Contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

function mod:tearsUp(firedelay, val)
    local currentTears = 30 / (firedelay + 1)
    local newTears = currentTears + val
    return math.max((30 / newTears) - 1, -0.75)
end

function mod:rangeUp(range, val)
    local currentRange = range / 40.0
    local newRange = currentRange + val
    return math.max(1.0,newRange) * 40.0
end