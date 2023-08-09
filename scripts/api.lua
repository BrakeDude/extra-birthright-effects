local mod = ExtraBirthright
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")
local BirthrightLangName = {en = "Birthright", ru = "Право первородства", es = "Primogenitura"}
local OnPickupFunctions = {}
local ChangeBirthrightFunction = {}
mod.Languages = {en = "en_us", ru = "ru", es = "spa"}
local ExtraEffects = {en ="Extra effects:", ru = "Дополнительные еффекты:", es = "Efecto extra:"}

mod.Callbacks = mod.Callbacks or {}

mod.Callbacks.TEdenCallbacks = mod.Callbacks.TEdenCallbacks or {}

mod.Callbacks.Enums = {
	MC_NPC_UPDATE = 0,
	MC_POST_UPDATE = 1,
	MC_POST_RENDER = 2,
	MC_USE_ITEM = 3,
	MC_POST_PEFFECT_UPDATE = 4,
	MC_USE_CARD = 5,
	MC_FAMILIAR_UPDATE = 6,
	MC_FAMILIAR_INIT = 7,
	MC_EVALUATE_CACHE = 8,
	MC_POST_PLAYER_INIT = 9,
	MC_USE_PILL = 10,
	MC_ENTITY_TAKE_DMG = 11,
	MC_POST_CURSE_EVAL = 12,
	MC_INPUT_ACTION = 13,
	MC_LEVEL_GENERATOR = 14,
	MC_POST_GAME_STARTED = 15,
	MC_POST_GAME_END = 16,
	MC_PRE_GAME_EXIT = 17,
	MC_POST_NEW_LEVEL = 18,
	MC_POST_NEW_ROOM = 19,
	MC_GET_CARD = 20,
	MC_GET_SHADER_PARAMS = 21,
	MC_EXECUTE_CMD = 22,
	MC_PRE_USE_ITEM = 23,
	MC_PRE_ENTITY_SPAWN = 24,
	MC_POST_FAMILIAR_RENDER = 25,
	MC_PRE_FAMILIAR_COLLISION = 26,
	MC_POST_NPC_INIT = 27,
	MC_POST_NPC_RENDER = 28,
	MC_POST_NPC_DEATH = 29,
	MC_PRE_NPC_COLLISION = 30,
	MC_POST_PLAYER_UPDATE = 31,
	MC_POST_PLAYER_RENDER = 32,
	MC_PRE_PLAYER_COLLISION = 33,
	MC_POST_PICKUP_INIT = 34,
	MC_POST_PICKUP_UPDATE = 35,
	MC_POST_PICKUP_RENDER = 36,
	MC_POST_PICKUP_SELECTION = 37,
	MC_PRE_PICKUP_COLLISION = 38,
	MC_POST_TEAR_INIT = 39,
	MC_POST_TEAR_UPDATE = 40,
	MC_POST_TEAR_RENDER = 41,
	MC_PRE_TEAR_COLLISION = 42,
	MC_POST_PROJECTILE_INIT = 43,
	MC_POST_PROJECTILE_UPDATE = 44,
	MC_POST_PROJECTILE_RENDER = 45,
	MC_PRE_PROJECTILE_COLLISION = 46,
	MC_POST_LASER_INIT = 47,
	MC_POST_LASER_UPDATE = 48,
	MC_POST_LASER_RENDER = 49,
	MC_POST_KNIFE_INIT = 50,
	MC_POST_KNIFE_UPDATE = 51,
	MC_POST_KNIFE_RENDER = 52,
	MC_PRE_KNIFE_COLLISION = 53,
	MC_POST_EFFECT_INIT = 54,
	MC_POST_EFFECT_UPDATE = 55,
	MC_POST_EFFECT_RENDER = 56,
	MC_POST_BOMB_INIT = 57,
	MC_POST_BOMB_UPDATE = 58,
	MC_POST_BOMB_RENDER = 59,
	MC_PRE_BOMB_COLLISION = 60,
	MC_POST_FIRE_TEAR = 61,
	MC_PRE_GET_COLLECTIBLE = 62,
	MC_POST_GET_COLLECTIBLE = 63,
	MC_GET_PILL_COLOR = 64,
	MC_GET_PILL_EFFECT = 65,
	MC_GET_TRINKET = 66,
	MC_POST_ENTITY_REMOVE = 67,
	MC_POST_ENTITY_KILL = 68,
	MC_PRE_NPC_UPDATE = 69,
	MC_PRE_SPAWN_CLEAN_AWARD = 70,
	MC_PRE_ROOM_ENTITY_SPAWN = 71,
	MC_PRE_ENTITY_DEVOLVE = 72,
	MC_PRE_MOD_UNLOAD = 73,

	MC_PLAYER_TAKE_DMG = 74,
}

--#region Modified FiendFolio code, which used StageAPI as reference. Thanks DeadInfinity, Taiga and FiendFolio Team

local highestID = 0
for _,v in pairs(mod.Callbacks.Enums) do
	highestID = math.max(v, highestID)
	mod.Callbacks.TEdenCallbacks[v] = mod.Callbacks.TEdenCallbacks[v] or {}
end

function mod.AddCustomCallback(modID, id, priority, character, customeffects, fn, ...)
	if id < 1 or id > highestID then
		print("ExtraBirthright API Error: AddCustomCallback called with invalid callback ID. ModID:"..tostring(modID))
		return
	end
	customeffects = customeffects and math.max(1,math.min(customeffects, 2)) or 1
	local callbacks = mod.Callbacks.TEdenCallbacks[id]
	local index = 1

    for i = #callbacks, 1, -1 do
		local callback = callbacks[i]
        if priority >= callback.Priority then
            index = i + 1
            break
        end
    end

    table.insert(callbacks, index, {
        Priority = priority,
        Function = fn,
        PlayerType = character,
		Effect = customeffects,
        ModID = modID,
        Params = {...},
        CallbackID = id,
    })
end

function mod.UnregisterCustomCallbacks(modID)
    for id, callbacks in pairs(mod.Callbacks.TEdenCallbacks) do
        for i = #callbacks, 1, -1 do
			local callback = callbacks[i]
            if callback.ModID == modID then
                table.remove(callbacks, i)
            end
        end
    end
end

function mod.GetCustomCallbacks(id)
	return mod.Callbacks.TEdenCallbacks[id]
end
--#endregion

function mod.IsString(str)
	return str and type(str) == "string"
end

function mod.IsNumber(num)
	return num and type(num) == "number"
end

function mod.IsTable(tab)
	return tab and type(tab) == "table"
end

function mod.AddOnPickupFunction(func)
	table.insert(OnPickupFunctions,func)
end

function mod.AddBirthrightChangeCondition(func)
	table.insert(ChangeBirthrightFunction,func)
end

function mod.ChangeToFakeBirthright(player)
	local change = false
	for _,func in ipairs(ChangeBirthrightFunction) do
		change = change or func(player)
	end
	return change
end

local function CheckBirthrightAll(_,player)
	local game = Game()
	local ptype = player:GetPlayerType()
	local data = mod.GetPersistentPlayerData(player)
	if mod.ChangeToFakeBirthright(player) then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
			player:AddCollectible(substituteBirthright,0,false)
		end	
	else
		if player:HasCollectible(substituteBirthright) then
			player:RemoveCollectible(substituteBirthright)
			player:AddCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT,0,false)
		end
	end
	if player.QueuedItem.Item then
		if player.QueuedItem.Item.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT and mod.ChangeToFakeBirthright(player) then
			local charName = tostring(ptype + 1)
			if mod.FakeBirthrightDesc[charName] then
				local lang = Options.Language
				local desc = mod.FakeBirthrightDesc[charName][lang]
				local brname = BirthrightLangName[lang]
				if not desc then
					desc = mod.FakeBirthrightDesc[charName].en
					brname = BirthrightLangName.en
				end
				local desci = desc[mod.MCMOption.Settings[mod.MCMOption.Name[charName]]-1]
				Game():GetHUD():ShowItemText(brname, desci, false)
			end
			local queue = player.QueuedItem
			queue.Item = nil
			player.QueuedItem = queue
			player:QueueItem(Isaac.GetItemConfig():GetCollectible(substituteBirthright))
		end
	end
	if ptype == PlayerType.PLAYER_THESOUL_B then return end
	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or player:HasCollectible(substituteBirthright)) and not data.gotBirthright then
		for _,func in pairs(OnPickupFunctions) do
			func(player)
		end
	end
	data.gotBirthright = player:HasCollectible(substituteBirthright) or player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN or player:GetPlayerType() == PlayerType.PLAYER_THESOUL then
		if not data.ForgottenType then
			data.ForgottenType = player:GetPlayerType()
		end
		if data.ForgottenType ~= player:GetPlayerType() then
			data.ForgottenType = player:GetPlayerType()
			mod:BirthrightDesc()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, CheckBirthrightAll)


function mod.GetOptionsBirthright(option,extra)
	extra = extra or false
	return (option == 2 or option == 3 and extra) and substituteBirthright or CollectibleType.COLLECTIBLE_BIRTHRIGHT
end

function mod.OptionBirthrightCondition(value, maxValue, effect)
	if not mod.IsNumber(value) or not mod.IsNumber(maxValue) or not mod.IsNumber(effect) then return nil end
	if maxValue > 3 then
		return effect == 1 and (value == 2 or value == 4) or effect == 2 and (value == 3 or value == 5)
	else
		return value > 1
	end
end

function mod.GetMCMPlayerTypeIndex(ptype)
	if ptype == PlayerType.PLAYER_THESOUL then
		ptype = PlayerType.PLAYER_THEFORGOTTEN
	end
	if ptype == PlayerType.PLAYER_THESOUL_B then
		ptype = PlayerType.PLAYER_THEFORGOTTEN_B
	end
	if ptype == PlayerType.PLAYER_LAZARUS2_B then
		ptype = PlayerType.PLAYER_LAZARUS_B
	end
	for i = 1, #mod.MCMOption.PlayerType do
		if mod.MCMOption.PlayerType[i] == ptype then
			return i
		end
	end
	return nil
end
function mod.GetMCMValue(ptype)
	if ptype == PlayerType.PLAYER_THESOUL then
		ptype = PlayerType.PLAYER_THEFORGOTTEN
	end
	if ptype == PlayerType.PLAYER_THESOUL_B then
		ptype = PlayerType.PLAYER_THEFORGOTTEN_B
	end
	if ptype == PlayerType.PLAYER_LAZARUS2_B then
		ptype = PlayerType.PLAYER_LAZARUS_B
	end
	local name = mod.GetMCMName(ptype)
	if name then
		return mod.MCMOption.Settings[name]
	end
	return nil
end

function mod.GetMCMName(ptype)
	if ptype == PlayerType.PLAYER_THESOUL then
		ptype = PlayerType.PLAYER_THEFORGOTTEN
	end
	if ptype == PlayerType.PLAYER_THESOUL_B then
		ptype = PlayerType.PLAYER_THEFORGOTTEN_B
	end
	if ptype == PlayerType.PLAYER_LAZARUS2_B then
		ptype = PlayerType.PLAYER_LAZARUS_B
	end
	local index = mod.GetMCMPlayerTypeIndex(ptype)
	if mod.IsNumber(index) then
		return mod.MCMOption.Name[index]
	end
	return nil
end

function mod.GetMaxMCMValue(ptype)
	if ptype == PlayerType.PLAYER_THESOUL then
		ptype = PlayerType.PLAYER_THEFORGOTTEN
	end
	if ptype == PlayerType.PLAYER_THESOUL_B then
		ptype = PlayerType.PLAYER_THEFORGOTTEN_B
	end
	if ptype == PlayerType.PLAYER_LAZARUS2_B then
		ptype = PlayerType.PLAYER_LAZARUS_B
	end
	local index = mod.GetMCMPlayerTypeIndex(ptype)
	if mod.IsNumber(index) then
		return mod.MCMOption.OptionsMaxNum[index]
	end
	return nil
end

function mod.AddCustomEffectsMCM(playerType,name,extra,label,splash1,firstEID,splash2,secondEID)
    if not playerType or playerType and (not mod.IsNumber(playerType) or mod.IsNumber(playerType) and playerType < 41) then return end
	extra = type(extra) == "boolean" and extra or false
	label = mod.IsString(label) and label or ""
	--if ptype > 41 then
	local size = #mod.MCMOption.Name + 1
	local ch = tostring(size)
	mod.MCMOption.PlayerType[size] = playerType
	for k,v in pairs(mod.Languages) do
		mod.EBEIDDesc[k][size] = {}
	end
	if not mod.IsString(name) then
		name = "ModdedChar"..ch
	end
	if not mod.MCMOption.Name[size] then
		mod.MCMOption.Name[size] = name
	end

	mod.MCMOption.OptionsMaxNum[size] = extra and 5 or 3
	
	mod.MCMOption.Settings[name] = 1
	mod.MCMOption.Labels[size] = label
	mod.FakeBirthrightDesc[size] = {}

	for k,v in pairs(mod.Languages) do
		mod.FakeBirthrightDesc[size][k] = mod.IsTable(splash1) and ((mod.IsString(splash1[k])) and {splash1[k]} or {"???"}) or {"???"}
		mod.FakeBirthrightDesc[size][k][2] = mod.IsTable(splash2) and (mod.IsString(splash2[k]) and splash2[k] or "???") or "???"
	end
	
	if mod.IsTable(firstEID) then
		for k,v in pairs(mod.EBEIDDesc) do
			mod.EBEIDDesc[k][size] = {}		
			local birthrightDesc = EID.descriptions[mod.Languages[k]].birthright[size] and EID.descriptions[mod.Languages[k]].birthright[size][3] or "???"			
			if mod.IsString(firstEID[k]) then
				mod.EBEIDDesc[k][size] = {birthrightDesc,firstEID[k],birthrightDesc.."#{{ColorRainbow}}"..ExtraEffects[k].."{{CR}}#"..firstEID[k]}
			else
				mod.EBEIDDesc[k][size] = {birthrightDesc, mod.FakeBirthrightDesc[size][k][1], birthrightDesc}
			end
		end
	end

	if mod.MCMOption.OptionsMaxNum[size] == 5 and mod.IsTable(secondEID) then
		
		for k,v in pairs(mod.EBEIDDesc) do
			local birthrightDesc = EID.descriptions[mod.Languages[k]].birthright[size] and EID.descriptions[mod.Languages[k]].birthright[size][3] or "???"
			mod.EBEIDDesc[k][size][4] = mod.EBEIDDesc[k][size][3]
			if mod.IsString(secondEID[k]) then
				mod.EBEIDDesc[k][size][3] = secondEID[k]
				mod.EBEIDDesc[k][size][5] = birthrightDesc.."#{{ColorRainbow}}"..ExtraEffects[k].."{{CR}}#"..secondEID[k]
			else
				mod.EBEIDDesc[k][size][3] = mod.FakeBirthrightDesc[size][k][2]
				mod.EBEIDDesc[k][size][5] = birthrightDesc
			end
		end
	end

	mod:ReloadMCM()
	-- else
	--    Isaac.DebugString("Couldn't add effect for vanilla characters")
	--end
end

function mod.RemoveCustomEffectsOptions(playerType)
	local ch = 41
	for i = #mod.MCMOption.PlayerType, 42, -1 do
		if mod.MCMOption.PlayerType[i] == playerType then
			ch = i
			break
		end
	end
	if ch > 41 then
		for k,v in pairs(mod.Languages) do
			table.remove(mod.EBEIDDesc[k],ch)
		end
		table.remove(mod.MCMOption.Name, ch)
		table.remove(mod.MCMOption.OptionsMaxNum, ch)
		table.remove(mod.MCMOption.Labels, ch)
		table.remove(mod.MCMOption.PlayerType, ch)
		table.remove(mod.FakeBirthrightDesc, ch)
	end
	mod:ReloadMCM()
end

if mod.Callbacks and mod.Callbacks.TEdenCallbacks and mod.UnregisterCustomCallbacks then
    mod.UnregisterCustomCallbacks("ExtraBirthright")
end