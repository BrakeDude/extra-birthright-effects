local mod = ExtraBirthright
local doubleHearts = Isaac.GetEntityVariantByName("Heart (double soul)")
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

function mod.TheCard(subtype)
	if (subtype >= 27 and subtype <= 30) or
	(subtype >= 32 and subtype <= 47) or
	(subtype >= 51 and subtype <= 54) or
	(subtype >= 56 and subtype <= 97) then
		return true
	else
		return false
	end
end

function mod.getCards(rng)
	local pickup = {variant=nil,subtype=nil}
		pickup.variant = PickupVariant.PICKUP_TAROTCARD
		local subtype = rng:RandomInt(97) + 1
		while mod.TheCard(subtype) do
			if mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.ID[subtype]] then
				break
			else
				subtype = rng:RandomInt(97) + 1
			end
		end
		pickup.subtype = subtype
	return pickup
end

function mod.getPills(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.variant = PickupVariant.PICKUP_PILL
	if rng:RandomFloat() <= 0.03 and mod.EBPillsDrops["Golden pills"] then
		pickup.subtype = PillColor.PILL_GOLD
	else
		pickup.subtype = rng:RandomInt(13) + 1
	end
	if rng:RandomFloat() <= 0.05 and mod.EBPillsDrops["Horse pills"] then
		pickup.subtype = PillColor.PILL_GIANT_FLAG + pickup.subtype
	end
	return pickup
end

function mod.getBombs(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.variant = PickupVariant.PICKUP_BOMB
	if rng:RandomFloat() <= 0.03 and mod.EBBombsDrops.Settings["Golden Bomb"] then
		pickup.subtype = BombSubType.BOMB_GOLDEN
	elseif rng:RandomFloat() <= 0.1 then
		pickup.subtype = BombSubType.BOMB_DOUBLEPACK
	else
		pickup.subtype = BombSubType.BOMB_NORMAL
	end
	return pickup
end

function mod.getKeys(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.variant = PickupVariant.PICKUP_KEY
	if rng:RandomFloat(rng) <= 0.03 then
		pickup.subtype = KeySubType.KEY_GOLDEN
	elseif rng:RandomFloat(rng) <= 0.05 and mod.EBKeysDrops.Settings["Charged Key"] then
		pickup.subtype = KeySubType.KEY_CHARGED
	elseif rng:RandomFloat(rng) <= 0.15 then
		pickup.subtype = KeySubType.KEY_DOUBLEPACK
	else
		pickup.subtype = KeySubType.KEY_NORMAL
	end
	return pickup
end

function mod.getCoins(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.variant = PickupVariant.PICKUP_COIN
	if rng:RandomFloat() <= 0.03 and mod.EBCoinsDrops.Settings["Golden Penny"] then
		pickup.subtype = CoinSubType.COIN_GOLDEN
	elseif rng:RandomFloat() <= 0.05 then
		pickup.subtype = CoinSubType.COIN_DIME
	elseif rng:RandomFloat() <= 0.1 and mod.EBCoinsDrops.Settings["Lucky Penny"] then
		pickup.subtype = CoinSubType.COIN_LUCKYPENNY
	elseif rng:RandomFloat() <= 0.15 then
		pickup.subtype = CoinSubType.COIN_NICKEL
	elseif rng:RandomFloat() <= 0.12 then
		pickup.subtype = CoinSubType.COIN_DOUBLEPACK
	elseif rng:RandomFloat() <= 0.15 and mod.EBCoinsDrops.Settings["Sticky Nickel"] then
		pickup.subtype = CoinSubType.COIN_STICKYNICKEL
	else
		pickup.subtype = CoinSubType.COIN_PENNY
	end
	return pickup
end

function mod.getBatteries(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.variant = PickupVariant.PICKUP_LIL_BATTERY
	if rng:RandomFloat() <= 0.03 and mod.EBBatteriesDrops.Settings["Golden Battery"] then
		pickup.subtype = BatterySubType.BATTERY_GOLDEN
	elseif rng:RandomFloat() <= 0.05 then
		pickup.subtype = BatterySubType.BATTERY_MEGA
	elseif rng:RandomFloat() <= 0.25 then
		pickup.subtype = BatterySubType.BATTERY_NORMAL
	else
		pickup.subtype = BatterySubType.BATTERY_MICRO
	end
	return pickup
end

function mod.getHearts(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.variant = PickupVariant.PICKUP_HEART
	if rng:RandomFloat() <= 0.03 then
		pickup.subtype = HeartSubType.HEART_ETERNAL
	elseif rng:RandomFloat() <= 0.05 then
		pickup.subtype = HeartSubType.HEART_BLENDED
	elseif rng:RandomFloat() <= 0.09 and mod.EBHeartsDrops["Golden Heart"] then
		pickup.subtype = HeartSubType.HEART_GOLDEN
	elseif rng:RandomFloat() <= 0.1 and mod.EBHeartsDrops["Rotten Heart"] then
		pickup.subtype = HeartSubType.HEART_ROTTEN
	elseif rng:RandomFloat() <= 0.07 and mod.EBHeartsDrops["Bone Heart"] then
		pickup.subtype = HeartSubType.HEART_BONE
	elseif rng:RandomFloat() <= 0.1 and doubleHearts ~= -1 then
		pickup.subtype = rng:RandomInt(6)+1
		pickup.variant = doubleHearts
	elseif rng:RandomFloat() <= 0.15 then
		pickup.subtype = HeartSubType.HEART_BLACK
	elseif rng:RandomFloat() <= 0.15 then
		pickup.subtype = HeartSubType.HEART_DOUBLEPACK
	elseif rng:RandomFloat() <= 0.20 then
		pickup.subtype = HeartSubType.HEART_SOUL
	elseif rng:RandomFloat() <= 0.25 and mod.EBHeartsDrops["Half Soul Heart"] then
		pickup.subtype = HeartSubType.HEART_HALF_SOUL
	elseif rng:RandomFloat() <= 0.25 and mod.EBHeartsDrops["Scared Heart"] then
		pickup.subtype = HeartSubType.HEART_SCARED
	elseif rng:RandomFloat() <= 0.40 then
		pickup.subtype = HeartSubType.HEART_FULL
	else
		pickup.subtype = HeartSubType.HEART_HALF
	end
	return pickup
end


--#region Cain Pickup Generator
function mod.MyRandomPickup(rng)
	local pickup = {variant=nil,subtype=nil}
	local chance = rng:RandomFloat()
	if chance <= 0.14 then
		pickup = mod.getCards(rng)
	end
	if chance <= 0.29 and (not pickup.variant or not pickup.subtype) then
		pickup = mod.getBatteries(rng)
	end
	if chance <= 0.42 and (not pickup.variant or not pickup.subtype) then
		pickup = mod.getCoins(rng)
	end
	if chance <= 0.56 and (not pickup.variant or not pickup.subtype) then
		pickup = mod.getKeys(rng)
	end
	if chance <= 0.71 and (not pickup.variant or not pickup.subtype) then
		pickup = mod.getBombs(rng)
	end
	if chance <= 0.85 and (not pickup.variant or not pickup.subtype) then
		pickup = mod.getPills(rng)
	end
	if (not pickup.variant and not pickup.subtype) then
		pickup = mod.getHearts(rng)
	end
	return pickup
end
--#endregion

function mod.getChest(rng)
	local pickup = {variant=nil,subtype=nil}
	pickup.subtype = 1
	if rng:RandomFloat() <= 0.05 and mod.EBChestsDrops["Mega Chest"] then
		pickup.variant = PickupVariant.PICKUP_MEGACHEST
	elseif rng:RandomFloat() <= 0.2 then
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

function mod.GetOptionsBirthright(option,extra)
	extra = extra or false
	return (option == 2 or option == 3 and extra) and substituteBirthright or CollectibleType.COLLECTIBLE_BIRTHRIGHT
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

function mod:GetPlayerFromTear(tear)
	for i=1, 3 do
		local check = nil
		if i == 1 then
			check = tear.Parent
		elseif i == 2 then
			check = mod:GetSpawner(tear)
		elseif i == 3 then
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

function mod:GetSpawner(entity)
	if entity and entity.GetData then
		local spawnData = mod:GetSpawnData(entity)
		if spawnData and spawnData.SpawnerEntity then
			local spawner = mod:GetPtrHashEntity(spawnData.SpawnerEntity)
			return spawner
		end
	end
	return nil
end

function mod:GetSpawnData(entity)
	if entity and entity.GetData then
		local data = mod:GetData(entity)
		return data.SpawnData
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
	if entity and entity.GetData then
		local data = entity:GetData()
		if not data.ExtraBirthright then
			data.ExtraBirthright = {}
		end
		return data.ExtraBirthright
	end
	return nil
end

function mod.GetPersistentPlayerData(entity) --From Retribution, by Xalum (modified by me)
	if entity:ToPlayer() and mod.PlayerData then
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
	elseif entity:ToFamiliar() and mod.FamiliarData then
		local familiar = entity:ToFamiliar()
		
		local tableIndex = tostring(familiar.InitSeed)
		mod.FamiliarData[tableIndex] = mod.FamiliarData[tableIndex] or {}
		return mod.FamiliarData[tableIndex]
	else
		return {}
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