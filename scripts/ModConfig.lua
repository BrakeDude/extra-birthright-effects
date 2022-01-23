--#region Mod Config Menu
local mod = ExtraBirthright
mod.MCMOption ={
	Name = {
		"Isaac",
		"Magdalene",
		"Cain",
		"Judas",
		"Dark Judas",
		"Blue Baby", -- Blue Baby
		"Eve",
		"Samson",
		"Azazel",
		"Lazarus",
		"Lazarus Risen",
		"Eden",
		"The Lost",
		"Lilith",
		"Keeper",
		"Apollyon",
		"The Forgotten",
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
		"Tainted Jacob"
	},
	OptionsMaxNum = {
		3, --Isaac
		5, --Maggie
		5, --Cain
		5, --Judas
		5, --Dark Judas
		3, --Blue Baby
		1, --Eve
		3, --Samson
		3, --Azazel
		1, --Lazarus
		1, --Lazarus Risen
		3, --Eden
		1, --Lost
		3, --Lilith
		3, --Keeper
		3, --Apollyon
		1, --Forgotten
		3, --Bethany
		3, --Jacob
		1, --Esau
		1, --Tainted Isaac
		3, --Tainted Magdalene
		3, --Tainted Cain
		3, --Tainted Judas
		3, --Tainted Blue Baby
		3, --Tainted Eve
		3, --Tainted Samson
		3, --Tainted Azazel
		3, --Tainted Lazarus
		1, --Tainted Eden
		1, --Tainted Lost
		3, --Tainted Lilith
		1, --Tainted Keeper
		5, --Tainted Apollyon
		1, --Tainted Forgotten
		3, --Tainted Bethany
		5 --Tainted Jacob
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
		["Dark Judas"] = 1,
		["Blue Baby"] = 1, -- Blue Baby
		["Eve"] = 1,
		["Samson"] = 1,
		["Azazel"] = 1,
		["Lazarus"] = 1,
		["Lazarus Risen"] = 1,
		["Eden"] = 1,
		["The Lost"] = 1,
		["Lilith"] = 1,
		["Keeper"] = 1,
		["Apollyon"] = 1,
		["The Forgotten"] = 1,
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
		{"1: D6 becomes pocket active. Can reroll into items from Treasure, Angel or Devil pools."}, -- Isaac
		{"1: Chance to charm nearby emenies. Yum Heart heals two red hearts instead of one. 2: Speed is linked to number of red hearts. Gain 1 Soul Heart when entering new floor."}, -- Maggie
		{"1: Enemies drop random pickup on death. Bosses - chance for item from room's item pool. 2: Cain always has golden key (Antibirth)."},--Cain
		{"1: 3 nickels. Chance to get on hit +5 damage and Brimsone effect for current room. 2: Using books activates Necronomicon effect (Antibirth)."},--Judas
		{"1: Getting hit damages all enemies. 2: Same as Judas second effect."},--Dark Judas
		{"1: Soul hearts boost stats depending on their number. Non soul hearts become other pickup (cards, pills, keys, coins, batteries)."},--Blue Baby
		{"Comming soon."},--Eve
		{"1: Damage up. Samson can pick up and throw objects."},--Samson
		{"1: 20% chance to shoot in 8 directions on hit."},--Azazel
		{"Comming soon."},--Lazarus
		{"Comming soon."},--Lazarus Risen
		{"1: 25% chance get random passive item effect when entering room."},--Eden
		{"Comming soon."},--Lost
		{"1: Spawns 2 mini Isaacs when entering hostile room, 4 - big room (L-shaped included). Box of Friends now affects mini Isaacs."},--Lilith
		{"1: Effects of Silver Dollar and Rib of Greed. One free item per floor that costs money."},--Keeper
		{"1: Void becomes pocket active. Voiding passive items with quality higher then 0 will give random extra stat ups. Higher qulity items give more stats."},--Apollyon
		{"Comming soon."},--Forgotten
		{"1: Curses become blessings. 100% chance for blessing."},--Bethany
		{"1: Esau gives half of his non story passive items to Jacob in exchange for Red Stew."},--Jacob
		{"Comming soon."},--Esau
		{"Comming soon."},--Tainted Isaac
		{"1: Regenerates red heart after clearing room."},--Tainted Magdalene
		{"1: Can pickup 1 item on current floor. If Tainted Cain doesn't have Birthright, he has 25% chance to pickup Birthright without it reducing into pickups."},--Tainted Cain
		{"1: Dark Arts become Twisted Arts. Using Twisted Arts will freeze time in a room. Longer duration compared to Dark Arts."},--Tainted Judas
		{"1: Chance to poop out friendly dip. Having special items have a chance to get different type of dip."},--Tainted BB
		{"1: Chance to spawn additional clot of the same type for free. Clots become more durable."},--Tainted Eve
		{"1: Extra damage that changes depending of how many enemies in radius of 100 around Tainted Samson and how many times he got hit. Bonus from number of hits Tainted Samson recived lasts for currnet floor."},--Tainted Samson
		{"1: Gets Brimstone effect and ability to fly."},--Tainted Azazel
		{"1: Flip charges overtime."},--Tainted Lazarus
		{"Comming soon."},--Tainted Eden
		{"Comming soon."},--Tainted Lost
		{"1: Spawn red creep that deals 250% player's damage. Every time umbilical baby is shot spawns red creep that deals 150% player's damage."},--Tainted Lilith
		{"Comming soon."},--Tainted Keeper
		{"1: Spawns 20 random harbinger locusts on pickup. Entering hostile room will spawn 2-5 random locusts. 2: Abyss locusts have small Godhead aura."},--Tainted Apollyon
		{"Comming soon."},--Tainted Forgotten
		{"1: Item wisps shoot homing tears. Tear rate is the same as player's. Wisp's tears deal 40% player's damage."},--Tainted Bethany
		{"1: +1 Health up, +50% Damage Multiplier, +1 Tears up and +0.3 Speed up. Dark Esau targets enemy that damaged Tainted Jacob, kills Tainted Jacob in one hit. 2: Dark Esau becomes friendly and targets enemies."}--Tainted Jacob
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

if ModConfigMenu then
	local MCMExtraBirthright = "Birthright Effects"
	ModConfigMenu.UpdateCategory(MCMExtraBirthright, {
		Info = {"Birthright effects configuration.",}
	})
	ModConfigMenu.AddText(MCMExtraBirthright,"Settings","Normal characters")
	for i=1,#mod.MCMOption.Name do
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
					--if (mod.MCMOption.Name[i] == "Eden" or mod.MCMOption.Name[i] == "Tainted Bethany" or mod.MCMOption.Name[i] == "Tainted Magdalene") and mod.MCMOption.Settings[mod.MCMOption.Name[i]] == 2 then
					--	option = 4
					--end
					return mod.MCMOption.Name[i]..': ' .. mod.MCMOption.Options[option]
				end,
				OnChange = function(currentNum)
					mod.MCMOption.Settings[mod.MCMOption.Name[i]] = currentNum
				end,
				Info = mod.MCMOption.Labels[i]
			})
	end

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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn."
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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
			Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
				Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
			Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
			Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
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
			Info = "Configuration list of Cain's Birthright as workaround for people who don't want locked pickups to spawn.",
		})
	end
end
--#endregion