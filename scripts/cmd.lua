local mod = ExtraBirthright
local cmd = {}

local function GetCharacterIndexByName(arg)
	for i = 1, #mod.MCMOption.Name do
		if arg == mod.MCMOption.Name[i] then
			if i == 18 then
				i = 17
			end
			if i == 39 then
				i = 30
			end
			if i == 40 then
				i = 38
			end
			if i == 41 then
				i = 36
			end
			return i
		end
	end
	return -1
end

local function splitArgs(args)
	local argsTab = {}
	-- Split command args by spaces and write them into a table
	for i in string.gmatch(args, "%S+") do
		table.insert(argsTab, i)
	end

	return argsTab
end

local function cgdCMD(command, args)
	local value = "1"
	if command == "change" then
		value = args[#args]
		if type(tonumber(value, 10)) ~= "number" then
			print("Invalid change [option] argument. Use 'extrabirthright help' for more command info")
			return
		end
		table.remove(args, #args)
	end
	value = tonumber(value, 10)
	local commandstr = ""
	for k,v in ipairs(args) do
		commandstr = commandstr..v
		if k < #args then
			commandstr = commandstr.." "
		end
	end
	if mod.MCMOption.Settings[commandstr] then
		local char = GetCharacterIndexByName(commandstr)
		if char == -1 then
			print("Invalid change [character] argument. Use 'extrabirthright help charlist' for available characters")
			return
		end
		if tonumber(value) < 1 and tonumber(value) > mod.MCMOption.OptionsMaxNum[char] then
			print("Invalid change [option] argument. It must be between 1 and "..mod.MCMOption.OptionsMaxNum[char])
			return
		end
		if command == "get" then
			local num = mod.MCMOption.Settings[commandstr]
			local option = (mod.MCMOption.OptionsMaxNum[char] == 3 and num == 3) and (num + 1) or num
			print(commandstr.." Birthright effect current option is "..mod.MCMOption.Options[option])
			print("You can change effect from 1 to "..mod.MCMOption.OptionsMaxNum[char])
			print("Changing effect of The Forgotten or The Soul will change it for both of them")
		end
		if command == "default" or command == "change" then
			mod.MCMOption.Settings[commandstr] = value
			local option = (mod.MCMOption.OptionsMaxNum[char] == 3 and value == 3) and (value + 1) or ((mod.MCMOption.OptionsMaxNum[char] == 2 and value == 2) and value + 2 or value)
			print("Changed "..commandstr.." Birthright to "..mod.MCMOption.Options[option])
		end
	else
		print("Invalid change [character] argument. Use 'extrabirthright help' for more command info")
		return
	end
end

local function helpCMD(args)
	if #args == 1 then
		print("Commands:\nmodconfig [reset|reload] - resets all values to default or reloads Mod Config Menu tab\nchange [character] [option] - change Birthright effect\nget [character] - get current Birthright effect\ndefault [character] - set Birthright effect to 'Original Effect'")
		print("[character] - character's name, case sensetive. Use 'help charlist' for list of names")
		print("[option] - character's effect, enter number for:")
		print("1 - "..mod.MCMOption.Options[1]..", 2 - "..mod.MCMOption.Options[2]..", 3 - "..mod.MCMOption.Options[3].." or "..mod.MCMOption.Options[4].." (if max option is 3), 4 - "..mod.MCMOption.Options[4]..", 5 - "..mod.MCMOption.Options[5])
	elseif #args == 2 and args[2] == "charlist" then
		local str = ""
		for i = 1, 37 do
			str = str..mod.MCMOption.Name[i]
			if i < 37 then
				str = str..", "
			end
		end
		if #mod.MCMOption.Name > 41 then
			str = str.."\n"
			for i = 42, #mod.MCMOption.Name do
				str = str..mod.MCMOption.Name[i]
				if i < #mod.MCMOption.Name then
					str = str..", "
				end
			end
		end
		print(str)
	end
end

function cmd:CmdCommands(command, args)
	if command ~= "extrabirthright" then
		return
	end
	local argsTab = splitArgs(args)

	if argsTab[1] == "modconfig" and #argsTab == 2 then
		if argsTab[2] == "reset" then
			mod:ResetMCM()
		elseif argsTab[2] == "reload" then
			mod:ReloadMCM()
		end
		print("done")		
		return nil
	end
	if argsTab[1] == "change" or argsTab[1] == "default" or argsTab[1] == "get" then
		local command = argsTab[1]
		table.remove(argsTab, 1)
		cgdCMD(command, argsTab)
	end
	if argsTab[1] == "help" then
		helpCMD(argsTab)
	end
	mod:BirthrightDesc()
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, cmd.CmdCommands)

if REPENTOGON then
	local commands = {}
	commands["help"] = {{"charlist", "Prints all characters names with modded birthright effects"}}
	commands["modconfig"] = {
		{"reset", "Resets Mod Config Menu and all values to default"},
		{"reload", "Reloads Mod Config Menu and all values to default"}
	}
	for k,v in ipairs({"get", "change", "default"}) do
		commands[v] = {}
		for i = 1, #mod.MCMOption.Name do
			if i ~= 18 and i ~= 39 and i ~= 40 and i ~= 41 then
				local name = mod.MCMOption.Name[i]
				local str = v:sub(0, 1):upper()..v:sub(2, #v).."s"
				commands[v][name] = {v.." "..name, str.." Birthright effect of "..name}
			end
		end
	end


	local function PutAutocomplete(tab, index, returnTable)
		returnTable = returnTable or {}
		
		if tab[index] ~= nil then
			for k, v in pairs(tab[index]) do
				if type(table.unpack(v, 1, 1)) == "string" then
					table.insert(returnTable, v)
				else
					returnTable = PutAutocomplete(v, k, returnTable)
				end
			end
		end
		return returnTable
	end
	
	local helpstr = "Commands:\nmodconfig [reset|reload] - resets all values to default or reloads Mod Config Menu tab\nchange [character] [option] - change Birthright effect\nget [character] - get current Birthright effect\ndefault [character] - set Birthright effect to 'Original Effect'\n"..
	"[character] - character's name, case sensetive. Use 'help charlist' for list of names\n"..
	"[option] - character's effect, enter number for:\n"..
	"1 - "..mod.MCMOption.Options[1]..", 2 - "..mod.MCMOption.Options[2]..", 3 - "..mod.MCMOption.Options[3].." or "..mod.MCMOption.Options[4].." (if max option is 3), 4 - "..mod.MCMOption.Options[4]..", 5 - "..mod.MCMOption.Options[5]
	Console.RegisterCommand("extrabirthright", "Extra Birthright effects commands", helpstr, true, AutocompleteType.CUSTOM)

	function cmd:RepentogonAutocomplete(command, args)
		if command:lower() ~= "extrabirthright" then
			return
		end

		local argsTab = splitArgs(args)
		local returnTable = {}
		if argsTab[1] ~= "change" and argsTab[1] ~= "get" and argsTab[1] ~= "default" and argsTab[1] ~= "help" and argsTab[1] ~= "modconfig" then
			table.insert(returnTable, {"help", "Prints description of commands"})
			table.insert(returnTable, {"change", "Change character's birthright option"})
			table.insert(returnTable, {"get", "Get character's current birthright option"})
			table.insert(returnTable, {"default", "Set character's current birthright option to default"})
			table.insert(returnTable, {"modconfig", "Option related to Mod Config Menu"})	
		else
			returnTable = PutAutocomplete(commands, argsTab[1])
		end

		return returnTable
	end

	mod:AddCallback(ModCallbacks.MC_CONSOLE_AUTOCOMPLETE, cmd.RepentogonAutocomplete)
end