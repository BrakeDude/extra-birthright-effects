local mod = ExtraBirthright

local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

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
        if not mod.EBEIDDesc[ptype+1] then
            mod.EBEIDDesc[ptype+1] = {}
        end
        mod.MCMOption.Name[ptype+1] = name
        local maxoption = (((first and second) and 5) or (first or second) and 3) or 1
        mod.MCMOption.Name[ptype+1] = name
        mod.MCMOption.OptionsMaxNum[ptype+1] = maxoption
        mod.MCMOption.Settings[name] = 1
        if label and type(label) =="string" then
            mod.MCMOption.Labels[ptype+1] = label
        end
    end
end