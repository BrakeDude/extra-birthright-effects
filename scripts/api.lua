local mod = ExtraBirthright
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")
local BirthrightLangName = {en = "Birthright", ru = "Право первородства", es = "Primogenitura"}
local OnPickupFunctions = {}
local ChangeBirthrightFunction = {}
mod.Languages = {en = "en_us", ru = "ru", es = "spa"}
local ExtraEffects = {en ="Extra effects:", ru = "Дополнительные еффекты:", es = "Efecto extra:"}

local function IsString(eid)
	return eid and type(eid) == "string"
end

local function IsNumber(num)
	return num and type(num) == "number"
end

local function IsTable(tab)
	return tab and type(tab) == "table"
end

function mod.AddOnPickupFunction(func)
	table.insert(OnPickupFunctions,func)
end

function mod.AddBirthrightChangeCondition(func)
	table.insert(ChangeBirthrightFunction,func)
end

local function ChangeToFakeBirthright(player)
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
	if ChangeToFakeBirthright(player) then
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
		if player.QueuedItem.Item.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT and ChangeToFakeBirthright(player) then
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
	if mod.MCMOption.Name[tostring(ptype+1)] then
		return mod.MCMOption.Settings[mod.MCMOption.Name[tostring(ptype+1)]]
	end
	return 1
end

function mod.AddCustomSplashText(ptype,desc,lang)
	if not lang then
		mod.FakeBirthrightDesc[tostring(ptype)] = desc
	else
		if not mod.FakeBirthrightDesc[tostring(ptype)] then
			mod.FakeBirthrightDesc[tostring(ptype)] = {}
		end
		mod.FakeBirthrightDesc[tostring(ptype)][lang] = desc
	end
end

function mod.AddCustomEffectsOptions(name,ptype,number,label,splash1,firstEID,splash2,secondEID)
    if IsNumber(ptype) then
        --if ptype > 41 then
			local ch = tostring(ptype+1)
            for k,v in pairs(mod.Languages) do
				mod.EBEIDDesc[k][ch] = {}
			end
            if not IsString(name) then
				name = "ModdedChar"..ch
			end
			if not mod.MCMOption.Name[ch] then
				mod.MCMOption.Name[ch] = name
			end
            if not IsNumber(number) then
				number = 1
			end
            if number <= 1 then number = 1 end
			if number > 1 then number = 2 end
			mod.MCMOption.OptionsMaxNum[ch] = number == 1 and 3 or 5
            
            mod.MCMOption.Settings[name] = 1
            
			if IsString(label) then
                mod.MCMOption.Labels[ch] = label
            end
			mod.MCMOption.Size = mod.MCMOption.Size < (ptype + 1) and (ptype + 1) or mod.MCMOption.Size

			mod.FakeBirthrightDesc[ch] = {}
			
			for k,v in pairs(mod.Languages) do
				mod.FakeBirthrightDesc[ch][k] = IsTable(splash1) and ((IsString(splash1[k])) and {splash1[k]} or {"???"}) or {"???"}
				mod.FakeBirthrightDesc[ch][k][2] = IsTable(splash2) and (IsString(splash2[k]) and splash2[k] or "???") or "???"
			end
			
			if IsTable(firstEID) then
				for k,v in pairs(mod.EBEIDDesc) do
					mod.EBEIDDesc[k][ch] = {}		
					local birthrightDesc = EID.descriptions[mod.Languages[k]].birthright[ptype+1] and EID.descriptions[mod.Languages[k]].birthright[ptype+1][3] or "???"			
					if IsString(firstEID[k]) then
						mod.EBEIDDesc[k][ch] = {birthrightDesc,firstEID[k],birthrightDesc.."#{{ColorRainbow}}"..ExtraEffects[k].."{{CR}}#"..firstEID[k]}
					else
						mod.EBEIDDesc[k][ch] = {birthrightDesc, mod.FakeBirthrightDesc[ch][k][1], birthrightDesc}
					end
				end
			end
	
			if mod.MCMOption.OptionsMaxNum[ch] == 5 and IsTable(secondEID) then
				
				for k,v in pairs(mod.EBEIDDesc) do
					local birthrightDesc = EID.descriptions[mod.Languages[k]].birthright[ptype+1] and EID.descriptions[mod.Languages[k]].birthright[ptype+1][3] or "???"
					mod.EBEIDDesc[k][ch][4] = mod.EBEIDDesc[k][ch][3]
					if IsString(secondEID[k]) then
						mod.EBEIDDesc[k][ch][3] = secondEID[k]
						mod.EBEIDDesc[k][ch][5] = birthrightDesc.."#{{ColorRainbow}}"..ExtraEffects[k].."{{CR}}#"..secondEID[k]
					else
						mod.EBEIDDesc[k][ch][3] = mod.FakeBirthrightDesc[ch][k][2]
						mod.EBEIDDesc[k][ch][5] = birthrightDesc
					end
				end
			end

			mod:ReloadMCM()
       -- else
        --    Isaac.DebugString("Couldn't add effect for vanilla characters")
        --end
    else
        Isaac.DebugString("Couldn't add option for new modded character")
        print("Couldn't add option for new modded character")
    end
end