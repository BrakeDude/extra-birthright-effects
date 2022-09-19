local mod = ExtraBirthright
function mod:GetCMDOption(arg,tainted)
	local start = 1
	if tainted then
		start = 21
	end
	if string.find(arg,"Risen") then
		return 11
	end
	for i = start, #mod.MCMOption.Name do
		if string.find(arg,mod.MCMOption.Name[i])then
			return i
		end
	end
	return nil
end

function mod:changeCMD(args,s1,s2)
	local commandstr = ""
	local tainted = string.find(args,"Tainted")
	local char = 0
	if tainted == s2 + 2 then
		char = mod:GetCMDOption(args,true)
	else
		char = mod:GetCMDOption(args,false)
	end
	
	if not char then
		return nil
	end
	local _,indx = string.find(args,mod.MCMOption.Name[char])
	indx = indx + 2
	if indx ~= string.len(args) then
		return nil
	end
	commandstr = mod.MCMOption.Name[char]
	
	if tonumber(indx) < 0 and tonumber(indx) > mod.MCMOption.OptionsMaxNum[char] then
		return nil
	end
	local num = nil
	for i = 1,mod.MCMOption.OptionsMaxNum[char] do
		if string.find(args,i) then
			num = tonumber(i)
			break
		end
	end
	if not num then
		return nil
	end
	local _,check = string.find(args,num)
	if not num or check ~= #args then
		return nil
	end
	mod.MCMOption.Settings[commandstr] = num
	local option = (mod.MCMOption.OptionsMaxNum[char] == 3 and num == 3) and (num + 1) or ((mod.MCMOption.OptionsMaxNum[char] == 2 and num == 2) and num + 2 or num)
	print("Changed "..commandstr.." Birthright to "..mod.MCMOption.Options[option])
end

function mod:helpCMD(args,s1,s2)
	if s2 == #args then
		print("Commands: \nchange [character] [option] - change Birthright effect\nget [character] - get current Birthright effect\ndefault [character] - set Birthright effect to 'Original Effect'")
		print("[character] - character's name, case sensetive. Use 'help charlist' for list of names")
		print("[option] - character's effect, enter number for:")
		print("1 - "..mod.MCMOption.Options[1]..", 2 - "..mod.MCMOption.Options[2]..", 3 - "..mod.MCMOption.Options[3].." or "..mod.MCMOption.Options[4].." (if max option is 3), 4 - "..mod.MCMOption.Options[4]..", 5 - "..mod.MCMOption.Options[5])
	end
	local check1,check2 = string.find(args,"charlist")
	if check1 == s2 + 2 and check2 == #args then
		for i = 1, 20, 5 do
			print(mod.MCMOption.Name[i]..", "..mod.MCMOption.Name[i+1]..", "..mod.MCMOption.Name[i+2]..", "..mod.MCMOption.Name[i+3]..", "..mod.MCMOption.Name[i+4]..",")
		end
		for i = 21, 35, 3 do
			print(mod.MCMOption.Name[i]..", "..mod.MCMOption.Name[i+1]..", "..mod.MCMOption.Name[i+2]..",")
		end
		print(mod.MCMOption.Name[36]..", "..mod.MCMOption.Name[37])
	end
end

function mod:getCMD(args,s1,s2)
	local commandstr = ""
	local tainted = string.find(args,"Tainted")
	local char
	if tainted == s2 + 2 then
		char = mod:GetCMDOption(args,true)
	else
		char = mod:GetCMDOption(args,false)
	end
	if not char then
		return nil
	end
	commandstr = commandstr..mod.MCMOption.Name[char]
	local check1,check2 = string.find(args,mod.MCMOption.Name[char])
	if check2 ~= #args then
		return nil
	end
	local num = mod.MCMOption.Settings[mod.MCMOption.Name[char]]
	local option = (mod.MCMOption.OptionsMaxNum[char] == 3 and num == 3) and (num + 1) or num
	print(commandstr.." Birthright effect current option is "..mod.MCMOption.Options[option])
	print("You can change effect from 1 to "..mod.MCMOption.OptionsMaxNum[char])
	print("Changing effect of The Forgotten or The Soul will change it for both of them")
end

function mod:defaultCMD(args,s1,s2)
	local commandstr = ""
	local tainted = string.find(args,"Tainted")
	local char
	if tainted == s2 + 2 then
		char = mod:GetCMDOption(args,true)
	else
		char = mod:GetCMDOption(args,false)
	end
	if not char then
		return nil
	end

	commandstr = commandstr..mod.MCMOption.Name[char]
	local check1,check2 = string.find(args,commandstr)
	if check2 ~= #args then
		return nil
	end
	mod.MCMOption.Settings[commandstr] = 1
	print(commandstr.." Birthright effect(s) is/are set to default")
end

function mod:CmdCommands(command,args)
	if command == "extrabirthright" then
		if string.find(args,"resetModConfig") == 1 then
			mod:ResetMCM()
			print("done")
			return nil
		end
		if string.find(args,"change") == 1 then
			mod:changeCMD(args,string.find(args,"change"))
		end
		if string.find(args,"help") == 1 then
			mod:helpCMD(args,string.find(args,"help"))
		end
		if string.find(args,"get") == 1 then
			mod:getCMD(args,string.find(args,"get"))
		end
		if string.find(args,"default") == 1 then
			mod:defaultCMD(args,string.find(args,"default"))
		end
		mod:BirthrightDesc()
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.CmdCommands)