--#region Mod Config Menu
local mod = ExtraBirthright
mod.MCMOption ={
	Name = {
		["1"] = "Isaac",
		["2"] = "Magdalene",
		["3"] = "Cain",
		["4"] = "Judas",
		["5"] = "Blue Baby", -- Blue Baby
		["6"] = "Eve",
		["7"] = "Samson",
		["8"] = "Azazel",
		["9"] = "Lazarus",
		["10"] = "Eden",
		["11"] = "The Lost",
		["12"] = "Lazarus Risen",
		["13"] = "Dark Judas",
		["14"] = "Lilith",
		["15"] = "Keeper",
		["16"] = "Apollyon",
		["17"] = "The Forgotten",
		["18"] = "The Soul",
		["19"] = "Bethany",
		["20"] = "Jacob",
		["21"] = "Esau",
		["22"] = "Tainted Isaac",
		["23"] = "Tainted Magdalene",
		["24"] = "Tainted Cain",
		["25"] = "Tainted Judas",
		["26"] = "Tainted Blue Baby",
		["27"] = "Tainted Eve",
		["28"] = "Tainted Samson",
		["29"] = "Tainted Azazel",
		["30"] = "Tainted Lazarus",
		["31"] = "Tainted Eden",
		["32"] = "Tainted Lost",
		["33"] = "Tainted Lilith",
		["34"] = "Tainted Keeper",
		["35"] = "Tainted Apollyon",
		["36"] = "Tainted Forgotten",
		["37"] = "Tainted Bethany",
		["38"] = "Tainted Jacob",
		["39"] = "Tainted Lazarus Dead",
		["40"] = "Tainted Jacob Lost",
		["41"] = "Tainted Soul"
	},
	Size = 41,
	OptionsMaxNum = {
		["1"] = 3, --Isaac
		["2"] = 5, --Maggie
		["3"] = 5, --Cain
		["4"] = 5, --Judas
		["5"] = 3, --Blue Baby
		["6"] = 3, --Eve
		["7"] = 3, --Samson
		["8"] = 3, --Azazel
		["9"] = 3, --Lazarus
		["10"] = 3, --Eden
		["11"] = 3, --Lost
		["12"] = 3, --Lazarus Risen
		["13"] = 5, --Dark Judas
		["14"] = 3, --Lilith
		["15"] = 3, --Keeper
		["16"] = 3, --Apollyon
		["17"] = 3, --Forgotten
		["18"] = 3, --Soul
		["19"] = 3, --Bethany
		["20"] = 3, --Jacob
		["21"] = 3, --Esau
		["22"] = 3, --Tainted Isaac
		["23"] = 3, --Tainted Magdalene
		["24"] = 3, --Tainted Cain
		["25"] = 3, --Tainted Judas
		["26"] = 3, --Tainted Blue Baby
		["27"] = 3, --Tainted Eve
		["28"] = 3, --Tainted Samson
		["29"] = 3, --Tainted Azazel
		["30"] = 3, --Tainted Lazarus
		["31"] = 3, --Tainted Eden
		["32"] = 1, --Tainted Lost
		["33"] = 3, --Tainted Lilith
		["34"] = 3, --Tainted Keeper
		["35"] = 5, --Tainted Apollyon
		["36"] = 3, --Tainted Forgotten
		["37"] = 3, --Tainted Bethany
		["38"] = 5, --Tainted Jacob
		["39"] = 3, --Tainted Lazarus Dead
		["40"] = 3, --Tainted Jacob Lost
		["41"] = 3, --Tainted Soul
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
		["1"] = {"1: D6 becomes pocket active. Can reroll into items from Treasure, Angel or Devil pools."}, -- Isaac
		["2"] = {"1: Yum Heart becomes pocket active. Chance to charm nearby emenies. Yum Heart heals two red hearts instead of one. 2: Speed is linked to number of red hearts. Gain 1 Soul Heart when entering new floor."}, -- Maggie
		["3"] = {"1: Enemies drop random pickup on death. Bosses - chance for item from room's item pool. 2: Cain always has golden key (Antibirth)."},--Cain
		["4"] = {"1: 3 random coins. Chance to get on hit +5 damage and Brimsone effect for current room. 2: Using books activates Necronomicon effect (Antibirth)."},--Judas
		["5"] = {"1: The Poop becomes pocket active. Soul hearts boost stats depending on their number. Non soul hearts become other pickup (cards, pills, keys, coins, batteries)."},--Blue Baby
		["6"] = {"1: Getting hit will occasionally spawn additional Dead Birds that persist between rooms."},--Eve
		["7"] = {"1: Damage up. Samson can pick up and throw objects."},--Samson
		["8"] = {"1: 20% chance to shoot in 8 directions on hit."},--Azazel
		["9"] = {"1: Gives pocket item Haven's Call on pickup and on new floor. Using it will kill Lazarus and deal damage to enemies in the room."},--Lazarus
		["10"] = {"1: 25% chance get random passive item effect when entering room."},--Eden
		["11"] = {"1: The Lost gets revived with copies of all of his items doubled (besides birthright, active and story items), but he can't have holy mantle effect. You can get mantle effect by using Holy Card but only for current room. After that effect disappears."},--Lost
		["12"] = {"1: Gives random 3 items from angel pool and Seraphim semi-transformation for the floor. Using Haven's Call will give 3 angel items for the current room."},--Lazarus Risen
		["13"] = {"1: Getting hit damages all enemies. 2: Same as Judas second effect."},--Dark Judas
		["14"] = {"1: Spawns 2 mini Isaacs when entering hostile room, 4 - big room (L-shaped included). Box of Friends now affects mini Isaacs."},--Lilith
		["15"] = {"1: Effects of Silver Dollar and Rib of Greed. One free item per floor that costs money."},--Keeper
		["16"] = {"1: Void becomes pocket active. If there cards and/or pills in room, they will be stored. If there're stored cards and/or pills, all of them will be used at the same time"},--Apollyon
		["17"] = {"1: Loosing Bone heart will create from 6 to 9 bone orbitals. Loosing Soul heart will create from 1 to 3 wisps."},--Forgotten
		["18"] = {"1: Loosing Bone heart will create from 6 to 9 bone orbitals. Loosing Soul heart will create from 1 to 3 wisps."},--Soul
		["19"] = {"1: Curses become blessings. 100% chance for blessing."},--Bethany
		["20"] = {"1: Esau gives half of his non story passive items to Jacob in exchange for Red Stew."},--Jacob
		["21"] = {"1: 100% chance for rewards to spawn after clearing room. Only devil rooms can appear with 50% chance. Only items of quality 2 and 3 will appear"},--Esau
		["22"] = {"1: Spindown dice becomes a pocket active and using it has 10% chance for Soul of Isaac effect to proc."},--Tainted Isaac
		["23"] = {"1: Regenerates red heart after clearing room."},--Tainted Magdalene
		["24"] = {"1: Can pickup 1 item on current floor. If Tainted Cain doesn't have Birthright, he has chance to pickup Birthright without it reducing into pickups."},--Tainted Cain
		["25"] = {"1: Dark Arts become Twisted Arts. Using Twisted Arts will freeze time in a room. Longer duration compared to Dark Arts."},--Tainted Judas
		["26"] = {"1: Chance to poop out friendly dip. Having special items have a chance to get different type of dip."},--Tainted BB
		["27"] = {"1: Chance to spawn additional clot of the same type for free. Clots become more durable."},--Tainted Eve
		["28"] = {"1: Berserk charges faster and activates on player's command by pressing 'Drop' button."},--Tainted Samson
		["29"] = {"1: Gets Brimstone effect and ability to fly."},--Tainted Azazel
		["30"] = {"1: Flip charges overtime."},--Tainted Lazarus
		["31"] = {"1: Random birhright effect of other characters. Changes on new room or when taking damage."},--Tainted Eden
		["32"] = {"Comming soon."},--Tainted Lost
		["33"] = {"1: Spawn red creep that deals 250% player's damage. Every time umbilical baby is shot spawns red creep that deals 150% player's damage."},--Tainted Lilith
		["34"] = {"1: Picking up coins gives temporary damage up that wears off over time."},--Tainted Keeper
		["35"] = {"1: Spawns 20 random harbinger locusts on pickup. Entering hostile room will spawn 2-5 random locusts. 2: Abyss locusts have small Godhead aura."},--Tainted Apollyon
		["36"] = {"1: Tainted Soul gets up to 5 defensive bone orbitals every room."},--Tainted Forgotten
		["37"] = {"1: Item wisps shoot homing tears. Tear rate is the same as player's. Wisp's tears deal 40% player's damage."},--Tainted Bethany
		["38"] = {"1: +1 Health up, +50% Damage Multiplier, +1 Tears up and +0.3 Speed up. Dark Esau targets enemy that damaged Tainted Jacob, kills Tainted Jacob in one hit. 2: Dark Esau becomes friendly and targets enemies."},--Tainted Jacob
		["39"] = {"1: Flip charges overtime."},--Tainted Lazarus Dead
		["40"] = {"1: +1 Health up, +50% Damage Multiplier, +1 Tears up and +0.3 Speed up. Dark Esau targets enemy that damaged Tainted Jacob, kills Tainted Jacob in one hit. 2: Dark Esau becomes friendly and targets enemies."},--Tainted Jacob Lost
		["41"] = {"1: Tainted Soul gets up to 5 defensive bone orbitals every room."},--Tainted Soul
	},
}

mod.EBHeartsDrops ={
	Name = {
		"Scared Hearts",
		"Half Soul Hearts",
		"Golden Hearts",
		"Bone Hearts",
		"Rotten Hearts",
	},
	Settings = {
		["Scared Hearts"] = true,
		["Half Soul Hearts"] = true,
		["Golden Hearts"] = true,
		["Bone Hearts"] = true,
		["Rotten Hearts"] = true,
	}
}

mod.EBChestsDrops ={
	Name = {
		"Mega Chest",
	},
	Settings = {
		["Mega Chest"] = true,
	}
}

mod.EBBombsDrops ={
	Name = {
		"Golden Bomb",
	},
	Settings = {
		["Golden Bomb"] = true,
	}
}

mod.EBKeysDrops = {
	Name = {
		"Charged Key",
	},
	Settings = {
		["Charged Key"] = true,
	}
}

mod.EBBatteriesDrops = {
	Name = {
		"Golden Battery",
	},
	Settings = {
		["Golden Battery"] = true,
	}
}

mod.EBPillsDrops = {
	Name = {
		"Golden Pills",
		"Horse Pills"
	},
	Settings = {
		["Golden Pills"] = true,
		["Horse Pills"] = true
	}
}

mod.EBCoinsDrops = {
	Name = {
		"Lucky Penny",
		"Sticky Nickel",
		"Golden Penny",
	},
	Settings = {
		["Lucky Penny"] = true,
		["Sticky Nickel"] = true,
		["Golden Penny"] = true
	}
}

mod.EBCardsAndRunesDrops = {
	Name = {

		"Cracked Key",

		"Ace of Clubs",
		"Ace of Diamonds",
		"Ace of Spades",
		"Ace of Hearts",
		"Suicide King",
		"Queen of Hearts",

		"Chaos Card",
		"Huge Growth",
		"Ancient Recall",
		"Era Walk",

		"Credit Card",

		"Rules Card",

		"A Card Against Humanity",

		"Get out of Jail Free Card",

		"Holy Card",

		"Wild Card",
		
		"0 - The Fool?",
		"I - The Magician?",
		"II - The High Priestess?",
		"III - The Empress?",
		"IV - The Emperor?",
		"V - The Hierophant?",
		"VI - The Lovers?",
		"VII - The Chariot?",
		"VIII - Justice?",
		"IX - The Hermit?",
		"X - Wheel of Fortune?",
		"XI - Strength?",
		"XII - The Hanged Man?",
		"XIII - Death?",
		"XIV - Temperance?",
		"XV - The Devil?",
		"XVI - The Tower?",
		"XVII - The Stars?",
		"XVIII - The Moon?",
		"XIX - The Sun?",
		"XX - Judgement?",
		"XXI - The World?",

		"Hagalaz",
		"Jera",
		"Ehwaz",
		"Dagaz",
		"Ansuz",
		"Perthro",
		"Berkano",
		"Algiz",
		"Blank Rune",
		"Black Rune",

		"Soul of Isaac",
		"Soul of Magdalene",
		"Soul of Cain",
		"Soul of Judas",
		"Soul of ???",
		"Soul of Eve",
		"Soul of Samson",
		"Soul of Azazel",
		"Soul of Lazarus",
		"Soul of Eden",
		"Soul of the Lost",
		"Soul of Lilith",
		"Soul of the Keeper",
		"Soul of Apollyon",
		"Soul of the Forgotten",
		"Soul of Bethany",
		"Soul of Jacob and Esau",
	},

	ID = {
		[56] = "0 - The Fool?",
		[57] = "I - The Magician?",
		[58] = "II - The High Priestess?",
		[59] = "III - The Empress?",
		[60] = "IV - The Emperor?",
		[61] = "V - The Hierophant?",
		[62] = "VI - The Lovers?",
		[63] = "VII - The Chariot?",
		[64] = "VIII - Justice?",
		[65] = "IX - The Hermit?",
		[66] = "X - Wheel of Fortune?",
		[67] = "XI - Strength?",
		[68] = "XII - The Hanged Man?",
		[69] = "XIII - Death?",
		[70] = "XIV - Temperance?",
		[71] = "XV - The Devil?",
		[72] = "XVI - The Tower?",
		[73] = "XVII - The Stars?",
		[74] = "XVIII - The Moon?",
		[75] = "XIX - The Sun?",
		[76] = "XX - Judgement?",
		[77] = "XXI - The World?",

		[32] = "Hagalaz",
		[33] = "Jera",
		[34] = "Ehwaz",
		[35] = "Dagaz",
		[36] = "Ansuz",
		[37] = "Perthro",
		[38] = "Berkano",
		[39] = "Algiz",
		[40] = "Blank Rune",
		[41] = "Black Rune",

		[27] = "Ace of Clubs",
		[28] = "Ace of Diamonds",
		[29] = "Ace of Spades",
		[30] = "Ace of Hearts",
		[46] = "Suicide King",
		[79] = "Queen of Hearts",

		[42] = "Chaos Card",
		[52] = "Huge Growth",
		[53] = "Ancient Recall",
		[54] = "Era Walk",

		[43] = "Credit Card",

		[44] = "Rules Card",

		[45] = "A Card Against Humanity",

		[47] = "Get out of Jail Free Card",

		[51] = "Holy Card",

		[80] = "Wild Card",

		[78] = "Cracked Key",

		[81] = "Soul of Isaac",
		[82] = "Soul of Magdalene",
		[83] = "Soul of Cain",
		[84] = "Soul of Judas",
		[85] = "Soul of ???",
		[86] = "Soul of Eve",
		[87] = "Soul of Samson",
		[88] = "Soul of Azazel",
		[89] = "Soul of Lazarus",
		[90] = "Soul of Eden",
		[91] = "Soul of the Lost",
		[92] = "Soul of Lilith",
		[93] = "Soul of the Keeper",
		[94] = "Soul of Apollyon",
		[95] = "Soul of the Forgotten",
		[96] = "Soul of Bethany",
		[97] = "Soul of Jacob and Esau",
	},

	Settings = {

		["0 - The Fool?"] = true,
		["I - The Magician?"] = true,
		["II - The High Priestess?"] = true,
		["III - The Empress?"] = true,
		["IV - The Emperor?"] = true,
		["V - The Hierophant?"] = true,
		["VI - The Lovers?"] = true,
		["VII - The Chariot?"] = true,
		["VIII - Justice?"] = true,
		["IX - The Hermit?"] = true,
		["X - Wheel of Fortune?"] = true,
		["XI - Strength?"] = true,
		["XII - The Hanged Man?"] = true,
		["XIII - Death?"] = true,
		["XIV - Temperance?"] = true,
		["XV - The Devil?"] = true,
		["XVI - The Tower?"] = true,
		["XVII - The Stars?"] = true,
		["XVIII - The Moon?"] = true,
		["XIX - The Sun?"] = true,
		["XX - Judgement?"] = true,
		["XXI - The World?"] = true,

		["Hagalaz"] = true,
		["Jera"] = true,
		["Ehwaz"] = true,
		["Dagaz"] = true,
		["Ansuz"] = true,
		["Perthro"] = true,
		["Berkano"] = true,
		["Algiz"] = true,
		["Blank Rune"] = true,
		["Black Rune"] = true,

		["Ace of Clubs"] = true,
		["Ace of Diamonds"] = true,
		["Ace of Spades"] = true,
		["Ace of Hearts"] = true,
		["Suicide King"] = true,
		["Queen of Hearts"] = true,

		["Chaos Card"] = true,
		["Huge Growth"] = true,
		["Ancient Recall"] = true,
		["Era Walk"] = true,

		["Credit Card"] = true,

		["Rules Card"] = true,

		["A Card Against Humanity"] = true,
		["Get out of Jail Free Card"] = true,

		
		["Holy Card"] = true,

		["Wild Card"] = true,

		["Cracked Key"] = true,

		["Soul of Isaac"] = true,
		["Soul of Magdalene"] = true,
		["Soul of Cain"] = true,
		["Soul of Judas"] = true,
		["Soul of ???"] = true,
		["Soul of Eve"] = true,
		["Soul of Samson"] = true,
		["Soul of Azazel"] = true,
		["Soul of Lazarus"] = true,
		["Soul of Eden"] = true,
		["Soul of the Lost"] = true,
		["Soul of Lilith"] = true,
		["Soul of the Keeper"] = true,
		["Soul of Apollyon"] = true,
		["Soul of the Forgotten"] = true,
		["Soul of Bethany"] = true,
		["Soul of Jacob and Esau"] = true,

	}
}

mod.MCMTCainBirthright = {
	["BirthrightYoink"] = 0
}

local function AddMCM()
	if ModConfigMenu then
		local MCMExtraBirthright = "Birthright Effects"
		ModConfigMenu.UpdateCategory(MCMExtraBirthright, {
			Info = {"Birthright effects configuration.",}
		})
		ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Normal characters")
		for i = 1, mod.MCMOption.Size do
			local k = tostring(i)
			if i == 42 then
				ModConfigMenu.AddSpace(MCMExtraBirthright,"Settings")
				ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Modded characters")
			end
			if mod.MCMOption.Name[k] then
				if i ~= 18 and (i < 39 or i > 41) then
					
					if mod.MCMOption.Name[k] == "Tainted Isaac" then
						ModConfigMenu.AddSpace(MCMExtraBirthright,"Settings")
						ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Tainted characters")
					end

					ModConfigMenu.AddSetting(MCMExtraBirthright, "Settings",
					{
						Type = ModConfigMenu.OptionType.NUMBER,
						CurrentSetting = function()
							return mod.MCMOption.Settings[mod.MCMOption.Name[k]]
						end,
						Minimum = 1,
						Maximum = mod.MCMOption.OptionsMaxNum[k],
						Display = function()
							local option = mod.MCMOption.Settings[mod.MCMOption.Name[k]]
							if mod.MCMOption.OptionsMaxNum[k] == 3 then
								if mod.MCMOption.Settings[mod.MCMOption.Name[k]] == 3 then
									option = option + 1
								end
							end
							--if (mod.MCMOption.Name[i] == "Eden" or mod.MCMOption.Name[i] == "Tainted Bethany" or mod.MCMOption.Name[i] == "Tainted Magdalene") and mod.MCMOption.Settings[mod.MCMOption.Name[i]] == 2 then
							--	option = 4
							--end
							return mod.MCMOption.Name[k]..': ' .. mod.MCMOption.Options[option]
						end,
						OnChange = function(currentNum)
							mod.MCMOption.Settings[mod.MCMOption.Name[k]] = currentNum
							mod:BirthrightDesc()
						end,
						Info = mod.MCMOption.Labels[k] or ""
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

		ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				
				return mod.EBBombsDrops.Settings[mod.EBBombsDrops.Name[1]]
			end,
			Default = mod.EBBombsDrops.Settings[mod.EBBombsDrops.Name[1]],
			Display = function()
				local displaystring = mod.EBBombsDrops.Name[1]..' drops: '
				if mod.EBBombsDrops.Settings[mod.EBBombsDrops.Name[1]] then
					displaystring = displaystring.."Enabled"
				else
					displaystring = displaystring.."Disabled"
				end
				return displaystring
			end,
			OnChange = function(value)
				mod.EBBombsDrops.Settings[mod.EBBombsDrops.Name[1]] = value
			end,
			Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn."
		})

		ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				
				return mod.EBKeysDrops.Settings[mod.EBKeysDrops.Name[1]]
			end,
			Default = mod.EBKeysDrops.Settings[mod.EBKeysDrops.Name[1]],
			Display = function()
				local displaystring = mod.EBKeysDrops.Name[1]..' drops: '
				if mod.EBKeysDrops.Settings[mod.EBKeysDrops.Name[1]] then
					displaystring = displaystring.."Enabled"
				else
					displaystring = displaystring.."Disabled"
				end
				return displaystring
			end,
			OnChange = function(value)
				mod.EBKeysDrops.Settings[mod.EBKeysDrops.Name[1]] = value
			end,
			Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
		})
		ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				
				return mod.EBBatteriesDrops.Settings[mod.EBBatteriesDrops.Name[1]]
			end,
			Default = mod.EBBatteriesDrops.Settings[mod.EBBatteriesDrops.Name[1]],
			Display = function()
				local displaystring = mod.EBBatteriesDrops.Name[1]..' drops: '
				if mod.EBBatteriesDrops.Settings[mod.EBBatteriesDrops.Name[1]] then
					displaystring = displaystring.."Enabled"
				else
					displaystring = displaystring.."Disabled"
				end
				return displaystring
			end,
			OnChange = function(value)
				mod.EBBatteriesDrops.Settings[mod.EBBatteriesDrops.Name[1]] = value
			end,
			Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
		})
		
		ModConfigMenu.AddSpace(MCMExtraBirthright,"Reg. Drops")
		ModConfigMenu.AddText(MCMExtraBirthright,"Reg. Drops","Coins")
		for i=1,#mod.EBCoinsDrops.Name do
				ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
				{
					Type = ModConfigMenu.OptionType.BOOLEAN,
					CurrentSetting = function()
						return mod.EBCoinsDrops.Settings[mod.EBCoinsDrops.Name[i]]
					end,
					Default = mod.EBCoinsDrops.Settings[mod.EBCoinsDrops.Name[i]],
					Display = function()
						local displaystring = mod.EBCoinsDrops.Name[i]..' drops: '
						if mod.EBCoinsDrops.Settings[mod.EBCoinsDrops.Name[i]] then
							displaystring = displaystring.."Enabled"
						else
							displaystring = displaystring.."Disabled"
						end
						return displaystring
					end,
					OnChange = function(value)
						mod.EBCoinsDrops.Settings[mod.EBCoinsDrops.Name[i]] = value
					end,
					Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
				})
		end
		
		ModConfigMenu.AddSpace(MCMExtraBirthright,"Reg. Drops")
		ModConfigMenu.AddText(MCMExtraBirthright,"Reg. Drops","Pills")
		for i=1,#mod.EBPillsDrops.Name do
				ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
				{
					Type = ModConfigMenu.OptionType.BOOLEAN,
					CurrentSetting = function()
						return mod.EBPillsDrops.Settings[mod.EBPillsDrops.Name[i]]
					end,
					Default = mod.EBPillsDrops.Settings[mod.EBPillsDrops.Name[i]],
					Display = function()
						local displaystring = mod.EBPillsDrops.Name[i]..' drops: '
						if mod.EBPillsDrops.Settings[mod.EBPillsDrops.Name[i]] then
							displaystring = displaystring.."Enabled"
						else
							displaystring = displaystring.."Disabled"
						end
						return displaystring
					end,
					OnChange = function(value)
						mod.EBPillsDrops.Settings[mod.EBPillsDrops.Name[i]] = value
					end,
					Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
				})
		end

		ModConfigMenu.AddSpace(MCMExtraBirthright,"Reg. Drops")
		ModConfigMenu.AddText(MCMExtraBirthright,"Reg. Drops","Hearts")
		for i=1,#mod.EBHeartsDrops.Name do
				ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
				{
					Type = ModConfigMenu.OptionType.BOOLEAN,
					CurrentSetting = function()
						return mod.EBHeartsDrops.Settings[mod.EBHeartsDrops.Name[i]]
					end,
					Default = mod.EBHeartsDrops.Settings[mod.EBHeartsDrops.Name[i]],
					Display = function()
						local displaystring = mod.EBHeartsDrops.Name[i]..' drops: '
						if mod.EBHeartsDrops.Settings[mod.EBHeartsDrops.Name[i]] then
							displaystring = displaystring.."Enabled"
						else
							displaystring = displaystring.."Disabled"
						end
						return displaystring
					end,
					OnChange = function(value)
						mod.EBHeartsDrops.Settings[mod.EBHeartsDrops.Name[i]] = value
					end,
					Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
				})
		end

		ModConfigMenu.AddSpace(MCMExtraBirthright,"Reg. Drops")
		ModConfigMenu.AddText(MCMExtraBirthright,"Reg. Drops","Other")

		ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[1]]
			end,
			Default = mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[1]],
			Display = function()
				local displaystring = mod.EBCardsAndRunesDrops.Name[1]..': '
				if mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[1]] then
					displaystring = displaystring.."Enabled"
				else
					displaystring = displaystring.."Disabled"
				end
				return displaystring
			end,
			OnChange = function(value)
				mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[1]] = value
			end,
			Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
		})

		ModConfigMenu.AddSetting(MCMExtraBirthright, "Reg. Drops",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return mod.EBChestsDrops.Settings[mod.EBChestsDrops.Name[1]]
			end,
			Default = mod.EBChestsDrops.Settings[mod.EBChestsDrops.Name[1]],
			Display = function()
				local displaystring = mod.EBChestsDrops.Name[1]..': '
				if mod.EBChestsDrops.Settings[mod.EBChestsDrops.Name[1]] then
					displaystring = displaystring.."Enabled"
				else
					displaystring = displaystring.."Disabled"
				end
				return displaystring
			end,
			OnChange = function(value)
				mod.EBChestsDrops.Settings[mod.EBChestsDrops.Name[1]] = value
			end,
			Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
		})



		for i=2,17 do	
			ModConfigMenu.AddSetting(MCMExtraBirthright, "Cards",
			{
				Type = ModConfigMenu.OptionType.BOOLEAN,
				CurrentSetting = function()
					return mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]]
				end,
				Default = mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]],
				Display = function()
					local displaystring = mod.EBCardsAndRunesDrops.Name[i]..': '
					if mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] then
						displaystring = displaystring.."Enabled"
					else
						displaystring = displaystring.."Disabled"
					end
					return displaystring
				end,
				OnChange = function(value)
					mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] = value
				end,
				Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
			})
		end

		for i=18,39 do
			ModConfigMenu.AddSetting(MCMExtraBirthright, "Rev. Cards",
			{
				Type = ModConfigMenu.OptionType.BOOLEAN,
				CurrentSetting = function()
					return mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]]
				end,
				Default = mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]],
				Display = function()
					local displaystring = mod.EBCardsAndRunesDrops.Name[i]..': '
					if mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] then
						displaystring = displaystring.."Enabled"
					else
						displaystring = displaystring.."Disabled"
					end
					return displaystring
				end,
				OnChange = function(value)
					mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] = value
				end,
				Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
			})
		end

		for i=40,49 do

			ModConfigMenu.AddSetting(MCMExtraBirthright, "Runes",
			{
				Type = ModConfigMenu.OptionType.BOOLEAN,
				CurrentSetting = function()
					return mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]]
				end,
				Default = mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]],
				Display = function()
					local displaystring = mod.EBCardsAndRunesDrops.Name[i]..' drops: '
					if mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] then
						displaystring = displaystring.."Enabled"
					else
						displaystring = displaystring.."Disabled"
					end
					return displaystring
				end,
				OnChange = function(value)
					mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] = value
				end,
				Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
			})
		end

		for i=50,66 do

			ModConfigMenu.AddSetting(MCMExtraBirthright, "Soul Stones",
			{
				Type = ModConfigMenu.OptionType.BOOLEAN,
				CurrentSetting = function()
					return mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]]
				end,
				Default = mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]],
				Display = function()
					local displaystring = mod.EBCardsAndRunesDrops.Name[i]..' drops: '
					if mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] then
						displaystring = displaystring.."Enabled"
					else
						displaystring = displaystring.."Disabled"
					end
					return displaystring
				end,
				OnChange = function(value)
					mod.EBCardsAndRunesDrops.Settings[mod.EBCardsAndRunesDrops.Name[i]] = value
				end,
				Info = "Configuration list of Cain's and Esau's Birthrights as workaround for people who don't want locked pickups to spawn.",
			})
		end
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
		local heartsdrop = mod.EBHeartsDrops.Settings
		local chestdrop = mod.EBChestsDrops.Settings
		local batteriesdrop = mod.EBBatteriesDrops.Settings
		local bombsdrop = mod.EBBombsDrops
		local cardsdrop = mod.EBCardsAndRunesDrops
		local coinsdrop = mod.EBCoinsDrops
		local keysdrop = mod.EBKeysDrops
		local pillsdrop = mod.EBPillsDrops
		local birth = mod.MCMTCainBirthright
		mod:ResetMCM()
		for k,v in pairs(mcmplayers.Settings) do
			mod.MCMOption.Settings[k] = v
		end
		mod.MCMOption.Size = mcmplayers.Size
		mod.MCMOption.OptionsMaxNum = mcmplayers.OptionsMaxNum
		mod.MCMOption.Labels = mcmplayers.Labels
		mod.EBHeartsDrops.Settings = heartsdrop
		mod.EBChestsDrops.Settings = chestdrop
		mod.EBBatteriesDrops.Settings = batteriesdrop
		mod.EBBombsDrops = bombsdrop
		mod.EBCardsAndRunesDrops = cardsdrop
		mod.EBCoinsDrops = coinsdrop
		mod.EBKeysDrops = keysdrop
		mod.EBPillsDrops = pillsdrop
		mod.MCMTCainBirthright = birth
	end
end

AddMCM()

local function ResetOnReload(_,modd)
	mod:ReloadMCM()
end
mod:AddCallback(ModCallbacks.MC_PRE_MOD_UNLOAD, ResetOnReload)
--#endregion
