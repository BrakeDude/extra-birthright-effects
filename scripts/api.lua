local mod = ExtraBirthright
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")
local BirthrightLangName = {en = "Birthright", ru = "Право первородства", es = "Primogenitura"}
local OnPickupFunctions = {}
local ChangeBirthrightFunction = {}
mod.Languages = {en = "en_us", ru = "ru", es = "spa"}
local ExtraEffects = {en ="Extra effects:#", ru = "Дополнительные еффекты:{{CR}} #", es = ""}

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
			local charName = ptype + 1
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
	if mod.MCMOption.Name[ptype+1] then
		return mod.MCMOption.Settings[mod.MCMOption.Name[ptype+1]]
	end
	return 1
end

function mod.AddCustomEffects(name,ptype,first,second,label)
    if name and type(name) == "string" and ptype and type(ptype) == "number" then
        if ptype > 41 then
            if not mod.EBEIDDesc[ptype+1] then
                mod.EBEIDDesc[ptype+1] = {}
            end
            mod.MCMOption.Name[ptype+1] = name
            mod.MCMOption.Name[ptype+1] = name
            
            if not first or type(first) ~= "string" and second and type(second) == "string" then
                first = second
                second = nil
            end
            if first and type(first) == "string" then
                mod.MCMOption.OptionsMaxNum[ptype+1] = 3
                for k,v in pairs(mod.EBEIDDesc) do
                    v[ptype+1] = {EID.descriptions[Languages[k]].birthright[ptype+1][3],first,EID.descriptions[Languages[k]].birthright[ptype+1][3].."#{{ColorRainbow}}Extra effects:"..first}, -- Maggie
                end
                if second and type(second) == "string" then
                    mod.MCMOption.OptionsMaxNum[ptype+1] = 5
                    for k,v in pairs(mod.EBEIDDesc) do
                        v[ptype+1][4] = v[ptype+1][3]
                        v[ptype+1] = {EID.descriptions[Languages[k]].birthright[ptype+1][3],first,EID.descriptions[Languages[k]].birthright[ptype+1][3].."#{{ColorRainbow}}Extra effects:"..first}, -- Maggie
                    end
                end
                mod.MCMOption.Settings[name] = 1
            end
            
            mod.MCMOption.OptionsMaxNum[ptype+1] = maxoption
            mod.MCMOption.Settings[name] = 1
            if label and type(label) =="string" then
                mod.MCMOption.Labels[ptype+1] = label
            end

        else
            Isaac.DebugString("Couldn't add effect for vanilla characters")
        end
    else
        Isaac.DebugString("Couldn't add option for new modded character")
        print("Couldn't add option for new modded character")
    end
end