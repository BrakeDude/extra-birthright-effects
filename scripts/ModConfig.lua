--#region Mod Config Menu
local mod = ExtraBirthright

local OptionsMaxNum = {
	3, --Isaac
	5, --Maggie
	5, --Cain
	5, --Judas
	3, --Blue Baby
	3, --Eve
	3, --Samson
	3, --Azazel
	3, --Lazarus
	3, --Eden
	3, --Lost
	3, --Lazarus Risen
	5, --Dark Judas
	3, --Lilith
	3, --Keeper
	3, --Apollyon
	3, --Forgotten
	3, --Soul
	3, --Bethany
	3, --Jacob
	3, --Esau
	3, --Tainted Isaac
	3, --Tainted Magdalene
	3, --Tainted Cain
	3, --Tainted Judas
	3, --Tainted Blue Baby
	3, --Tainted Eve
	3, --Tainted Samson
	3, --Tainted Azazel
	3, --Tainted Lazarus
	5, --Tainted Eden
	3, --Tainted Lost
	3, --Tainted Lilith
	3, --Tainted Keeper
	5, --Tainted Apollyon
	3, --Tainted Forgotten
	3, --Tainted Bethany
	5, --Tainted Jacob
	3, --Tainted Lazarus Dead
	3, --Tainted Jacob Lost
	3, --Tainted Soul
}

mod.MCMOption = mod.MCMOption or {
	Name = {
		"Isaac",
		"Magdalene",
		"Cain",
		"Judas",
		"Blue Baby", -- Blue Baby
		"Eve",
		"Samson",
		"Azazel",
		"Lazarus",
		"Eden",
		"The Lost",
		"Lazarus Risen",
		"Dark Judas",
		"Lilith",
		"Keeper",
		"Apollyon",
		"The Forgotten",
		"The Soul",
		"Bethany",
		"Jacob",
		"Esau",
		"Tainted Isaac",
		"Tainted Magdalene",
		"Tainted Cain",
		"Tainted Judas",
		"Tainted Blue Baby",
		"Tainted Eve",
		"Tainted Samson",
		"Tainted Azazel",
		"Tainted Lazarus",
		"Tainted Eden",
		"Tainted Lost",
		"Tainted Lilith",
		"Tainted Keeper",
		"Tainted Apollyon",
		"Tainted Forgotten",
		"Tainted Bethany",
		"Tainted Jacob",
		"Tainted Lazarus Dead",
		"Tainted Jacob Lost",
		"Tainted Soul"
	},
	OptionsMaxNum = {
		3, --Isaac
		5, --Maggie
		5, --Cain
		5, --Judas
		3, --Blue Baby
		3, --Eve
		3, --Samson
		3, --Azazel
		3, --Lazarus
		3, --Eden
		3, --Lost
		3, --Lazarus Risen
		5, --Dark Judas
		3, --Lilith
		3, --Keeper
		3, --Apollyon
		3, --Forgotten
		3, --Soul
		3, --Bethany
		3, --Jacob
		3, --Esau
		3, --Tainted Isaac
		3, --Tainted Magdalene
		3, --Tainted Cain
		3, --Tainted Judas
		3, --Tainted Blue Baby
		3, --Tainted Eve
		3, --Tainted Samson
		3, --Tainted Azazel
		3, --Tainted Lazarus
		5, --Tainted Eden
		3, --Tainted Lost
		3, --Tainted Lilith
		3, --Tainted Keeper
		5, --Tainted Apollyon
		3, --Tainted Forgotten
		3, --Tainted Bethany
		5, --Tainted Jacob
		3, --Tainted Lazarus Dead
		3, --Tainted Jacob Lost
		3, --Tainted Soul
	},
	Options = {
		"Original Effect",
		"Mod Effect 1",
		"Mod Effect 2",
		"Combined Effect 1",
		"Combined Effect 2"
	},
	Settings = {
		["Isaac"] = 1,
		["Magdalene"] = 1,
		["Cain"] = 1,
		["Judas"] = 1,
		["Blue Baby"] = 1, -- Blue Baby
		["Eve"] = 1,
		["Samson"] = 1,
		["Azazel"] = 1,
		["Lazarus"] = 1,
		["Eden"] = 1,
		["The Lost"] = 1,
		["Lazarus Risen"] = 1,
		["Dark Judas"] = 1,
		["Lilith"] = 1,
		["Keeper"] = 1,
		["Apollyon"] = 1,
		["The Forgotten"] = 1,
		["The Soul"] = 1,
		["Bethany"] = 1,
		["Jacob"] = 1,
		["Esau"] = 1,
		["Tainted Isaac"] = 1,
		["Tainted Magdalene"] = 1,
		["Tainted Cain"] = 1,
		["Tainted Judas"] = 1,
		["Tainted Blue Baby"] = 1,
		["Tainted Eve"] = 1,
		["Tainted Samson"] = 1,
		["Tainted Azazel"] = 1,
		["Tainted Lazarus"] = 1,
		["Tainted Eden"] = 1,
		["Tainted Lost"] = 1,
		["Tainted Lilith"] = 1,
		["Tainted Keeper"] = 1,
		["Tainted Apollyon"] = 1,
		["Tainted Forgotten"] = 1,
		["Tainted Bethany"] = 1,
		["Tainted Jacob"] = 1
	},
	Labels = {
		"1: D6 becomes pocket active. Can reroll into items from Treasure, Angel or Devil pools.", -- Isaac
		"1: Yum Heart becomes pocket active. Chance to charm nearby emenies. Yum Heart heals two red hearts instead of one. 2: Speed is linked to number of red hearts. Gain 1 Soul Heart when entering new floor.", -- Maggie
		"1: Enemies drop random pickup on death. Bosses - chance for item from room's item pool. 2: Cain always has golden key (Antibirth).",--Cain
		"1: 3 random coins. Chance to get on hit +5 damage and Brimsone effect for current room. 2: Using books activates Necronomicon effect (Antibirth).",--Judas
		"1: The Poop becomes pocket active. Soul hearts boost stats depending on their number. Non soul hearts become other pickup (cards, pills, keys, coins, batteries).",--Blue Baby
		"1: Getting hit will occasionally spawn additional Dead Birds that persist between rooms.",--Eve
		"1: Damage up. Samson can pick up and throw objects.",--Samson
		"1: 20% chance to shoot in 8 directions on hit.",--Azazel
		"1: Gives pocket item Haven's Call on pickup and on new floor. Using it will kill Lazarus and deal damage to enemies in the room.",--Lazarus
		"1: 25% chance get random passive item effect when entering room.",--Eden
		"1: The Lost gets revived with copies of all of his items doubled (besides birthright, active and story items), but he can't have holy mantle effect. You can get mantle effect by using Holy Card but only for current room. After that effect disappears.",--Lost
		"1: Gives random 3 items from angel pool and Seraphim semi-transformation for the floor. Using Haven's Call will give 3 angel items for the current room.",--Lazarus Risen
		"1: Getting hit damages all enemies. 2: Same as Judas second effect.",--Dark Judas
		"1: Spawns 2 mini Isaacs when entering hostile room, 4 - big room (L-shaped included). Box of Friends now affects mini Isaacs.",--Lilith
		"1: Effects of Silver Dollar and Rib of Greed. One free item per floor that costs money.",--Keeper
		"1: Void becomes pocket active. If there cards and/or pills in room, they will be stored. If there're stored cards and/or pills, all of them will be used at the same time",--Apollyon
		"1: Loosing Bone heart will create from 6 to 9 bone orbitals. Loosing Soul heart will create from 1 to 3 wisps.",--Forgotten
		"1: Loosing Bone heart will create from 6 to 9 bone orbitals. Loosing Soul heart will create from 1 to 3 wisps.",--Soul
		"1: Curses become blessings. 100% chance for blessing.",--Bethany
		"1: Esau gives half of his non story passive items to Jacob in exchange for Red Stew.",--Jacob
		"1: 100% chance for rewards to spawn after clearing room. Only devil rooms can appear with 50% chance. Only items of quality 2 and 3 will appear",--Esau
		"1: Spindown dice becomes a pocket active and using it has 10% chance for Soul of Isaac effect to proc.",--Tainted Isaac
		"1: Regenerates red heart after clearing room.",--Tainted Magdalene
		"1: Can pickup 1 item on current floor. If Tainted Cain doesn't have Birthright, he has chance to pickup Birthright without it reducing into pickups.",--Tainted Cain
		"1: Dark Arts become Twisted Arts. Using Twisted Arts will freeze time in a room. Longer duration compared to Dark Arts.",--Tainted Judas
		"1: Chance to poop out friendly dip. Having special items have a chance to get different type of dip.",--Tainted BB
		"1: Chance to spawn additional clot of the same type for free. Clots become more durable.",--Tainted Eve
		"1: Berserk charges faster and activates on player's command by pressing 'Drop' button.",--Tainted Samson
		"1: Gets Brimstone effect and ability to fly.",--Tainted Azazel
		"1: Flip charges overtime.",--Tainted Lazarus
		"1: Random birhright effect of other characters. Changes on new room or when taking damage. 2. Second modded effect.",--Tainted Eden
		"1. 50% chance for an uncleared room or 100% chance on Boss or Boss Rush room to add Holy Mantle effect to that room.",--Tainted Lost
		"1: Spawn red creep that deals 250% player's damage. Every time umbilical baby is shot spawns red creep that deals 150% player's damage.",--Tainted Lilith
		"1: Picking up coins gives temporary damage up that wears off over time.",--Tainted Keeper
		"1: Spawns 20 random harbinger locusts on pickup. Entering hostile room will spawn 2-5 random locusts. 2: Abyss locusts have small Godhead aura.",--Tainted Apollyon
		"1: Tainted Soul gets up to 5 defensive bone orbitals every room.",--Tainted Forgotten
		"1: Item wisps shoot homing tears. Tear rate is the same as player's. Wisp's tears deal 40% player's damage.",--Tainted Bethany
		"1: +1 Health up, +50% Damage Multiplier, +1 Tears up and +0.3 Speed up. Dark Esau targets enemy that damaged Tainted Jacob, kills Tainted Jacob in one hit. 2: Dark Esau becomes friendly and targets enemies.",--Tainted Jacob
		"1: Flip charges overtime.",--Tainted Lazarus Dead
		"1: +1 Health up, +50% Damage Multiplier, +1 Tears up and +0.3 Speed up. Dark Esau targets enemy that damaged Tainted Jacob, kills Tainted Jacob in one hit. 2: Dark Esau becomes friendly and targets enemies.",--Tainted Jacob Lost
		"1: Tainted Soul gets up to 5 defensive bone orbitals every room.",--Tainted Soul
	},
	PlayerType = {
		[1] = 0,
		[2] = 1,
		[3] = 2,
		[4] = 3,
		[5] = 4,
		[6] = 5,
		[7] = 6,
		[8] = 7,
		[9] = 8,
		[10] = 9,
		[11] = 10,
		[12] = 11,
		[13] = 12,
		[14] = 13,
		[15] = 14,
		[16] = 15,
		[17] = 16,
		[18] = 17,
		[19] = 18,
		[20] = 19,
		[21] = 20,
		[22] = 21,
		[23] = 22,
		[24] = 23,
		[25] = 24,
		[26] = 25,
		[27] = 26,
		[28] = 27,
		[29] = 28,
		[30] = 29,
		[31] = 30,
		[32] = 31,
		[33] = 32,
		[34] = 33,
		[35] = 34,
		[36] = 35,
		[37] = 36,
		[38] = 37,
		[39] = 38,
		[40] = 39,
		[41] = 40,
	}
}

mod.MCMTCainBirthright = mod.MCMTCainBirthright or {
	["BirthrightYoink"] = 0
}

local function AddMCM()
	if ModConfigMenu then
		local MCMExtraBirthright = "Birthright Effects"
		ModConfigMenu.UpdateCategory(MCMExtraBirthright, {
			Info = {"Birthright effects configuration.",}
		})
		ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Normal characters")
		for i = 1, #mod.MCMOption.Name do
			if i == 42 then
				ModConfigMenu.AddSpace(MCMExtraBirthright,"Settings")
				ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Modded characters")
			end
			if mod.MCMOption.Name[i] then
				if i ~= 18 and (i < 39 or i > 41) then
					
					if mod.MCMOption.Name[i] == "Tainted Isaac" then
						ModConfigMenu.AddSpace(MCMExtraBirthright,"Settings")
						ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Tainted characters")
					end

					ModConfigMenu.AddSetting(MCMExtraBirthright, "Settings",
					{
						Type = ModConfigMenu.OptionType.NUMBER,
						CurrentSetting = function()
							return mod.MCMOption.Settings[mod.MCMOption.Name[i]]
						end,
						Minimum = 1,
						Maximum = mod.MCMOption.OptionsMaxNum[i],
						Display = function()
							local option = mod.MCMOption.Settings[mod.MCMOption.Name[i]]
							if mod.MCMOption.OptionsMaxNum[i] == 3 then
								if mod.MCMOption.Settings[mod.MCMOption.Name[i]] == 3 then
									option = option + 1
								end
							end
							return mod.MCMOption.Name[i]..': ' .. mod.MCMOption.Options[option]
						end,
						OnChange = function(currentNum)
							mod.MCMOption.Settings[mod.MCMOption.Name[i]] = currentNum
						end,
						Info = type(mod.MCMOption.Labels[i]) == "string" and mod.MCMOption.Labels[i] or ""
					})
				end
			end
		end

		ModConfigMenu.AddSetting(MCMExtraBirthright, "T.Cain",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return mod.MCMTCainBirthright["BirthrightYoink"]
			end,
			Minimum = 0,
			Maximum = 100,
			Display = function ()
				return "Birthright pickup chance: " ..mod.MCMTCainBirthright["BirthrightYoink"].. "%"
			end,
			OnChange = function (value)
				mod.MCMTCainBirthright["BirthrightYoink"]= value
			end,
			Info = {"Chance for Tainted Cain to pickup Birthright"}
		})

	end
end

function mod:ResetMCM()
	if ModConfigMenu then
		ModConfigMenu.RemoveCategory("Birthright Effects")
		AddMCM()
	end
end

function mod:ReloadMCM()
	if ModConfigMenu then
		local mcmplayers = mod.MCMOption
		local birth = mod.MCMTCainBirthright
		mod:ResetMCM()
		for k,v in ipairs(mcmplayers.Name) do
			mod.MCMOption.Name[k] = v
		end
		for k,v in ipairs(mcmplayers.Settings) do
			mod.MCMOption.Settings[k] = v
		end
		for k,v in ipairs(mcmplayers.OptionsMaxNum) do
			mod.MCMOption.OptionsMaxNum[k] = v
		end
		for k,v in ipairs(mcmplayers.Labels) do
			mod.MCMOption.Labels[k] = v
		end

		mod.MCMTCainBirthright = birth
	end
end

AddMCM()

local function ResetOnReload(_,modd)
	mod.ResetMod = true
end
mod:AddCallback(ModCallbacks.MC_PRE_MOD_UNLOAD, ResetOnReload)

local function VanillaOptionReCheck()
	for index, option in pairs(OptionsMaxNum) do
		mod.MCMOption.OptionsMaxNum[index] = option
	end
end
mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, 300, VanillaOptionReCheck)
--#endregion
