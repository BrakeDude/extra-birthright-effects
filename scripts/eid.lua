local mod = ExtraBirthright

mod.FakeBirthrightDesc = {
	[1] = {"Pocket destiny"}, --Isaac
	[2] = {"Lovely looks","Script from the past"}, --Magdalene
	[3] = {"Bloody loot","Locks don't stand a chance"}, --Cain
	[4] = {"The inner demon","Knowledge is power"}, --Judas
	[5] = {"Soul power"}, --Blue Baby
	[6] = {"Your very own murder", "Birds of prey"}, --Eve
	[7] = {"Rock and throw"}, --Samson
	[8] = {"Hell circle"}, --Azazel
	[9] = {""}, --Lazarus
	[10] = {"Random effect"}, --Eden
	[11] = {""}, --The Lost
	[12] = {""}, -- Lazarus Risen
	[13] = {"Payback","Knowledge is power"}, --Dark Judas
	[14] = {"Motherhood"}, --Lilith
	[15] = {"Free deal"}, --Keeper
	[16] = {"Pocket void"}, --Apollyon
	[17] = {""}, --The Forgotten
	[18] = {""}, --The Soul
	[19] = {"Blessed"}, --Bethany
	[20] = {"Trade"}, --Jacob
	[21] = {""}, --Esau
	[22] = {""}, --Tainted Isaac
	[23] = {"Wounds heal"}, --Tainted Magdalene
	[24] = {"Destiny stealer"}, --Tainted Cain
	[25] = {"Master of shadows"}, --Tainted Judas
	[26] = {"Stinky friends"}, --Tainted Blue Baby
	[27] = {"Stronger clots"}, --Tainted Eve
	[28] = {"Close combat"}, --Tainted Samson
	[29] = {"Wings of destruction"}, --Tainted Azazel
	[30] = {"Alive and Dead"}, --Tainted Lazarus
	[31] = {""}, --Tainted Eden
	[32] = {""}, --Tainted Lost
	[33] = {"Hemorrhage"}, --Tainted Lilith
	[34] = {""}, --Tainted Keeper
	[35] = {"Locusts of apocalypse","God flies"}, --Tainted Apollyon
	[36] = {""}, --Tainted Forgotten
	[37] = {"Better wisps"}, --Tainted Bethany
	[38] = {"No mercy","Forgiven Soul"}, --Tainted Jacob
	[39] = {"Dead and Alive"}, --Tainted Dead Lazarus
	[40] = {"No mercy","Forgiven Soul"}, --Tainted Jacob Lost
	[41] = {""} --Tainted Soul
}

mod.EBEIDDesc = {}
if EID then
mod.EBEIDDesc = {
	EN = {
		{EID.descriptions["en_us"].birthright[1][3],"{{Collectible105}}D6 becomes pocket active#Has a chance to reroll into item from {{TreasureRoom}}Treasure, {{AngelRoom}}Angel or {{DevilRoom}}Devil pools",EID.descriptions["en_us"].birthright[1][3].."#{{ColorRainbow}}Extra effects:#{{Collectible105}}D6 becomes pocket active#Has a chance to reroll into item from Treasure, Angel or Devil pools"}, -- Isaac
		{EID.descriptions["en_us"].birthright[2][3],"Chance to charm enemy in radius of 50#{{Collectible45}}Yum Heart heals 2 {{Heart}}red hearts instead of one", "{{ArrowUp}}Speed up. Speed is linked to number of {{HalfHeart}}red hearts#Speed = speed + ({{HalfHeart}} * 0.06)#Gains 1 {{SoulHeart}}soul heart when entering new level",EID.descriptions["en_us"].birthright[2][3].."#{{ColorRainbow}}Extra effects:#Chance to charm enemy in radius of 50#{{Collectible45}}Yum Heart heals 2 {{Heart}}red hearts instead of one", EID.descriptions["en_us"].birthright[2][3].."#{{ColorRainbow}}Extra effects:#{{ArrowUp}}Speed up. Speed is linked to number of {{HalfHeart}}red hearts#Speed = speed + ({{HalfHeart}} * 0.06)#Gains 1 {{SoulHeart}}soul heart when entering new level"}, -- Maggie
		{EID.descriptions["en_us"].birthright[3][3],"Enemies have a chance to drop pickups#Champions drop 2 similar pickups#If there is boss in room, clearing it has a chance to spawn an item from room's item pool","Cain always has {{GoldenKey}}Golden Key",EID.descriptions["en_us"].birthright[3][3].."#{{ColorRainbow}}Extra effects:#Enemies have a chance to drop pickups#Champions drop 2 similar pickups#If there is boss in room, clearing it has a chance to spawn an item from room's item pool",EID.descriptions["en_us"].birthright[3][3].."#{{ColorRainbow}}Extra effects:#Cain always has {{GoldenKey}}Golden Key"},--Cain
		{EID.descriptions["en_us"].birthright[4][3],"Spawns 3 nickels on pickup#{{ArrowUp}} +5.0 Damage up and {{Collectible118}}Brimstone effect when getting hit for current room. 20% chance to proc","Using books activates {{Collectible35}}Necronomicon effect", EID.descriptions["en_us"].birthright[4][3].."#{{ColorRainbow}}Extra effects:#Spawns 3 nickels on pickup#{{ArrowUp}} +5.0 Damage up and {{Collectible118}}Brimstone effect when getting hit for current room. 20% chance to proc",EID.descriptions["en_us"].birthright[4][3].."#{{ColorRainbow}}Extra effects:#Using books activates {{Collectible35}}Necronomicon effect"},--Judas
		{EID.descriptions["en_us"].birthright[13][3],"Activates {{Collectible35}}Necronomicon effect when getting hit","Using books activates {{Collectible35}}Necronomicon effect", EID.descriptions["en_us"].birthright[13][3].."#{{ColorRainbow}}Extra effects:#Activates {{Collectible35}}Necronomicon effect when getting hit",EID.descriptions["en_us"].birthright[13][3].."#{{ColorRainbow}}Extra effects:#Using books activates {{Collectible35}}Necronomicon effect"},--Dark Judas
		{EID.descriptions["en_us"].birthright[5][3],"{{ArrowUp}}{{SoulHeart}}Soul hearts give Damage up, Tears up, Speed up and Range up depending on their number#Non soul hearts become other pickups", EID.descriptions["en_us"].birthright[5][3].."#{{ColorRainbow}}Extra effects:#{{ArrowUp}}{{SoulHeart}}Soul hearts give Damage up, Tears up, Speed up and Range up depending on their number#Non soul hearts become other pickups"},--Blue Baby
		{EID.descriptions["en_us"].birthright[6][3],"Getting hit will occasionally spawn additional Dead Birds that persist between rooms", EID.descriptions["en_us"].birthright[6][3].."#{{ColorRainbow}}Extra effects:#Getting hit will occasionally spawn additional Dead Birds that persist between rooms"},--Eve
		{EID.descriptions["en_us"].birthright[7][3],"{{ArrowUp}} +4 Damage up#Gets ability to pick up and throw objects", EID.descriptions["en_us"].birthright[7][3].."#{{ColorRainbow}}Extra effects:#{{ArrowUp}} +4 Damage up#Gets ability to pick up and throw objects"},--Samson
		{EID.descriptions["en_us"].birthright[8][3],"20% chance to shoot in 8 directions on hit", EID.descriptions["en_us"].birthright[8][3].."#{{ColorRainbow}}Extra effects:#20% chance to shoot in 8 directions on hit"},--Azazel
		{EID.descriptions["en_us"].birthright[9][3],"Coming soon", EID.descriptions["en_us"].birthright[9][3].."#{{ColorRainbow}}Extra effects:#Coming soon"},--Lazarus
		{EID.descriptions["en_us"].birthright[12][3],"Coming soon", EID.descriptions["en_us"].birthright[12][3].."#{{ColorRainbow}}Extra effects:#Coming soon"},--Lazarus Risen
		{EID.descriptions["en_us"].birthright[10][3], "25% chance get random passive item effect when entering room", EID.descriptions["en_us"].birthright[10][3].."#{{ColorRainbow}}Extra effects:#25% chance get random passive item effect when entering room"},--Eden
		{EID.descriptions["en_us"].birthright[11][3],"Coming soon", EID.descriptions["en_us"].birthright[11][3].."#{{ColorRainbow}}Extra effects:#Coming soon"},--Lost
		{EID.descriptions["en_us"].birthright[14][3],"Spawns 2 mini Isaacs when entering hostile room, 4 - big room#All mini Isaac despawn when going to new level#{{Collectible357}}Box of Friends now duplicates mini Isaacs for current room",EID.descriptions["en_us"].birthright[14][3].."#{{ColorRainbow}}Extra effects:#Spawns 2 mini Isaacs when entering hostile room, 4 - big room#All mini Isaac despawn when going to new level#{{Collectible357}}Box of Friends now duplicates mini Isaacs for current room"},--Lilith
		{EID.descriptions["en_us"].birthright[15][3],"One item or pickup that costs money is free per level#Shops (and secret rooms) won't have Greed / Super Greed#Shops will spawn in Womb and Corpse",EID.descriptions["en_us"].birthright[15][3].."#{{ColorRainbow}}Extra effects:#One item or pickup that costs money is free per level#Shops (and secret rooms) won't have Greed / Super Greed#Shops will spawn in Womb and Corpse"},--Keeper
		{EID.descriptions["en_us"].birthright[16][3],"{{Collectible477}}Void becomes pocket active#Voiding passive items with quality higher then 0 will give random extra stat ups#Higher quality items give more stats",EID.descriptions["en_us"].birthright[16][3].."#{{ColorRainbow}}Extra effects:#{{Collectible477}}Void becomes pocket active#Voiding passive items with quality higher then 0 will give random extra stat ups#Higher quality items give more stats"},--Apollyon
		{EID.descriptions["en_us"].birthright[17][3],"Coming soon", EID.descriptions["en_us"].birthright[17][3].."#Extra effects:{{CR}} Coming soon"},--Forgotten
		{EID.descriptions["en_us"].birthright[19][3],"Curses become blessings#100% chance to get a random blessing or curse's opposite", EID.descriptions["en_us"].birthright[19][3].."#{{ColorRainbow}}Extra effects:#Curses become blessings#100% chance to get a random blessing or curse's opposite"},--Bethany
		{EID.descriptions["en_us"].birthright[20][3],"Esau gives half of his non story passive items to Jacob in exchange for {{Collectible621}}Red Stew", EID.descriptions["en_us"].birthright[20][3].."#{{ColorRainbow}}Extra effects:#Esau gives half of his non story passive items to Jacob in exchange for {{Collectible621}}Red Stew"}, --Jacob
		{EID.descriptions["en_us"].birthright[21][3],"Coming soon", EID.descriptions["en_us"].birthright[21][3].."#{{ColorRainbow}}Extra effects:#Coming soon"}, -- Esau
		{EID.descriptions["en_us"].birthright[22][3],"Coming soon", EID.descriptions["en_us"].birthright[22][3].."#{{ColorRainbow}}Extra effects:#Coming soon"}, -- Tainted Isaac
		{EID.descriptions["en_us"].birthright[23][3],"Regenerates {{Heart}} red heart when room is cleared", EID.descriptions["en_us"].birthright[23][3].."#{{ColorRainbow}}Extra effects:#Regenerates {{Heart}} red heart when room is cleared"}, -- Tainted Magdalene
		{EID.descriptions["en_us"].birthright[24][3],"Tainted Cain can pick up 1 item on current floor#Chance to pick up {{Collectible619}}Birthright without reducing it into pickups, if Tainted Cain doesn't have one#!!! Chance can be modified in Mod Config Menu settings. By default value is 0", EID.descriptions["en_us"].birthright[24][3].."#{{ColorRainbow}}Extra effects:#Tainted Cain can pick up 1 item on current floor#Chance to pick up {{Collectible619}}Birthright without reducing it into pickups, if Tainted Cain doesn't have one#!!! Chance can be modified in Mod Config Menu settings. By default value is 0"}, -- Tainted Cain
		{EID.descriptions["en_us"].birthright[25][3],"{{Collectible705}}Dark Arts become Twisted Arts#Using Twisted Arts will freeze time in a room#Longer duration compared to Dark Arts",EID.descriptions["en_us"].birthright[25][3].."#{{ColorRainbow}}Extra effects:#{{Collectible705}}Dark Arts become Twisted Arts#Using Twisted Arts will freeze time in a room#Longer duration compared to Dark Arts"},--Tainted Judas
		{EID.descriptions["en_us"].birthright[26][3],"Chance to poop out friendly dip#Having special items have a chance to get different type of dip", EID.descriptions["en_us"].birthright[26][3].."#{{ColorRainbow}}Extra effects:#Chance to poop out friendly dip#Having special items have a chance to get different type of dip"}, -- Tainted BB
		{EID.descriptions["en_us"].birthright[27][3],"Chance to spawn additional clot for free#Сlot take more hits to be killed",EID.descriptions["en_us"].birthright[27][3].."#{{ColorRainbow}}Extra effects:#Chance to spawn additional clot for free#Сlot take more hits to be killed"},--Tainted Eve
		{EID.descriptions["en_us"].birthright[28][3],"{{ArrowUp}} Damage up#Damage changes depending of how many enemies in radius of 100 around Samson and how many times Samson got hit#Bonus damage recieved from enemies hitting Samson lasts for currnet floor", EID.descriptions["en_us"].birthright[28][3].."#{{ColorRainbow}}Extra effects:{{ArrowUp}} #Damage up#Damage changes depending of how many enemies in radius of 100 around Samson and how many times Samson got hit#Bonus damage recieved from enemies hitting Samson lasts for currnet floor"}, -- Tainted Samson
		{EID.descriptions["en_us"].birthright[29][3],"Gets {{Collectible118}}Brimstone effect and ability to fly",EID.descriptions["en_us"].birthright[29][3].."#{{ColorRainbow}}Extra effects:#Gets {{Collectible118}}Brimstone effect and ability to fly"},--Tainted Azazel
		{EID.descriptions["en_us"].birthright[30][3],"{{Collectible711}}Flip charges over time",EID.descriptions["en_us"].birthright[30][3].."#{{ColorRainbow}}Extra effects:#{{Collectible711}} Flip charges over time"},--Tainted Lazarus
		{EID.descriptions["en_us"].birthright[31][3],"Coming soon", EID.descriptions["en_us"].birthright[31][3].."#{{ColorRainbow}}Extra effects:#Coming soon"}, -- Tainted Eden
		{EID.descriptions["en_us"].birthright[32][3],"Coming soon", EID.descriptions["en_us"].birthright[32][3].."#{{ColorRainbow}}Extra effects:#Coming soon"}, -- Tainted Lost
		{EID.descriptions["en_us"].birthright[33][3],"Spawn red creep that deals 250% damage#Every time Tainted Lilith shoots umbilical baby (fetus) spawns red creep trail that deals 150% damage",EID.descriptions["en_us"].birthright[33][3].."#{{ColorRainbow}}Extra effects:#Spawns red creep that deals 250% damage#Every time Tainted Lilith shoots umbilical baby (fetus) spawns red creep trail that deals 150% damage"},--Tainted Lilith
		{EID.descriptions["en_us"].birthright[34][3],"Coming soon", EID.descriptions["en_us"].birthright[34][3].."#{{ColorRainbow}}Extra effects:#Coming soon"}, -- Tainted Keeper
		{EID.descriptions["en_us"].birthright[35][3],"Spawns 20 random horsemen locusts on pickup#2-5 random horsemen locusts spawn when entering hostile room","Gives abyss locust a small {{Collectible331}}Godhead aura",EID.descriptions["en_us"].birthright[35][3].."#{{ColorRainbow}}Extra effects:#Spawns 20 random horsemen locusts on pickup#2-5 random horsemen locusts spawn when entering hostile room",EID.descriptions["en_us"].birthright[35][3].."#{{ColorRainbow}}Extra effects:#Gives abyss locust a small {{Collectible331}} Godhead aura"},--Tainted Apollyon
		{EID.descriptions["en_us"].birthright[36][3],"Coming soon", EID.descriptions["en_us"].birthright[36][3].."#{{ColorRainbow}}Extra effects:#Coming soon"}, -- Tainted Forgotten
		{EID.descriptions["en_us"].birthright[37][3],"Item wisps shoot homing tears with Tainted Bethany's tear rate and deal 40% of her damage#Wisps take more hits to be destroyed",EID.descriptions["en_us"].birthright[37][3].."#{{ColorRainbow}}Extra effects:#Item wisps shoot homing tears with Tainted Bethany's tear rate and deal 40% of her damage#Wisps take more hits to be destroyed"},--Tainted Bethany
		{EID.descriptions["en_us"].birthright[38][3],"{{ArrowUp}} +1 Health up#{{ArrowUp}} +50% Damage Multiplier#{{ArrowUp}} +1 Tears up#{{ArrowUp}} +0.3 Speed up#Dark Esau targets enemy that damaged Tainted Jacob until it's dead#{{TreasureRoom}}Treasure, {{SecretRoom}}Secret/{{SuperSecretRoom}}Super Secret and {{DevilRoom}}Devil rooms contain twise more items#Tainted Jacob dies in any form from Dark Esau's damage", "Dark Esau becomes friendly and targets enemies", EID.descriptions["en_us"].birthright[38][3].."#{{ColorRainbow}}Extra effects:#{{ArrowUp}} +1 Health up#{{ArrowUp}} +50% Damage Multiplier#{{ArrowUp}} +1 Tears up#{{ArrowUp}} +0.3 Speed up#Dark Esau targets enemy that damaged Tainted Jacob until it's dead#{{TreasureRoom}}Treasure, {{SecretRoom}}Secret/{{SuperSecretRoom}}Super Secret and {{DevilRoom}}Devil rooms contain twise more items#Tainted Jacob dies in any form from Dark Esau's damage", EID.descriptions["en_us"].birthright[38][3].."#{{ColorRainbow}}Extra effects:#Dark Esau becomes friendly and targets enemies"}--Tainted Jacob
	},
	RU =
		{
		{EID.descriptions["ru"].birthright[1][3],"{{Collectible105}}D6 становится карманным предметом#Есть шанс поменять на предмет из пула {{TreasureRoom}}Комнаты Сокровищ, {{AngelRoom}}Комнаты Ангела или {{DevilRoom}}Комнаты Дьявола",EID.descriptions["ru"].birthright[1][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{Collectible105}}D6 становится карманным предметом#Есть шанс поменять на предмет из пула {{TreasureRoom}}Комнаты Сокровищ, {{AngelRoom}}Комнаты Ангела или {{DevilRoom}}Комнаты Дьявола"}, -- Isaac
		{EID.descriptions["ru"].birthright[2][3],"Шанс очаровать врага в радиусе 50#{{Collectible45}}Ням сердце лечит 2 {{Heart}}красных сердца вместо одного","{{ArrowUp}}Увеличение скорости. Скорость привязана к {{HalfHeart}}красным сердцам#Скорость = скорость + ({{HalfHeart}} * 0.06)#Получает 1 {{SoulHeart}}синее сердце при переходе на новый уровень",EID.descriptions["ru"].birthright[2][3].."#{{ColorRainbow}}Дополнительные еффекты:{{CR}} Шанс очаровать врага в радиусе 50#{{Collectible45}}Ням сердце лечит 2 {{Heart}}красных сердца вместо одного",EID.descriptions["ru"].birthright[2][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{ArrowUp}}Увеличение скорости. Скорость привязана к {{HalfHeart}}красным сердцам#Скорость = скорость + ({{HalfHeart}} * 0.06)#Получает 1 {{SoulHeart}}синее сердце при переходе на новый уровень"}, -- Maggie
		{EID.descriptions["ru"].birthright[3][3],"Есть шанс, что из врагов выпадет подбираемый предмет#Из чемпионов выпадает 2 одинаковых предмета#Если в комнате был босс, зачистив её есть шанс на появление предмета из пула текущей комнаты","У Кайна всегда {{GoldenKey}}золотой ключ", EID.descriptions["ru"].birthright[3][3].."#{{ColorRainbow}}Дополнительные еффекты:#Есть шанс, что из врагов выпадет подбираемый предмет#Из чемпионов выпадает 2 одинаковых предмета#Если в комнате был босс, зачистив её есть шанс на появление предмета из пула текущей комнаты",EID.descriptions["ru"].birthright[3][3].."#{{ColorRainbow}}Дополнительные еффекты:#У Кайна всегда {{GoldenKey}}золотой ключ"},--Cain
		{EID.descriptions["ru"].birthright[4][3],"При подборе появляются 3 пятака#{{ArrowUp}} +5.0 к урону и эффект {{Collectible118}}Серы при получении урона в данной комнате. 20% шанс на срабатывание","Использование книг активирует эффект {{Collectible35}}некрономикона", EID.descriptions["ru"].birthright[4][3].."#{{ColorRainbow}}Дополнительные еффекты:#При подборе появляются 3 пятака#{{ArrowUp}} +5.0 к урону и эффект {{Collectible118}}Серы при получении урона в данной комнате. 20% шанс на срабатывание",EID.descriptions["ru"].birthright[4][3].."#{{ColorRainbow}}Дополнительные еффекты:{{CR}} Использование книг активирует эффект {{Collectible35}}некрономикона"},--Judas
		{EID.descriptions["ru"].birthright[13][3],"Активируется эффект {{Collectible35}}некрономикона при получении урона","Использование книг активирует эффект {{Collectible35}}некрономикона", EID.descriptions["ru"].birthright[13][3].."#{{ColorRainbow}}Дополнительные еффекты:#Активируется эффект {{Collectible35}}некрономикона при получении урона",EID.descriptions["ru"].birthright[13][3].."#{{ColorRainbow}}Дополнительные еффекты:#Использование книг активирует эффект {{Collectible35}}некрономикона"},--Dark Judas
		{EID.descriptions["ru"].birthright[5][3],"{{ArrowUp}}{{SoulHeart}}Синие сердца увеличивают урон, скорострельность, скорость и дальность в зависимости от их количества#Не синие серца превращаются в другие предметы", EID.descriptions["ru"].birthright[5][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{ArrowUp}}{{SoulHeart}}Синие сердца увеличивают урон, скорострельность, скорость и дальность в зависимости от их количества#Не синие серца превращаются в другие предметы"},--Blue Baby
		{EID.descriptions["ru"].birthright[6][3],"Получение урона иногда порождает дополнительных мертвых птиц, которые остаются при переходе в другие комнаты", EID.descriptions["ru"].birthright[6][3].."#{{ColorRainbow}}Дополнительные еффекты:#Получение урона иногда порождает дополнительных мертвых птиц, которые остаются при переходе в другие комнаты"},--Eve
		{EID.descriptions["ru"].birthright[7][3],"{{ArrowUp}} +4 к урону#Получает способность поднимать и кидать объекты", EID.descriptions["ru"].birthright[7][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{ArrowUp}} +4 к урону#Получает способность поднимать и кидать объекты"},--Samson
		{EID.descriptions["ru"].birthright[8][3],"20% шанс выстрелить в 8 направлениях при получении урона", EID.descriptions["ru"].birthright[8][3].."#{{ColorRainbow}}Дополнительные еффекты:#20% шанс выстрелить в 8 направлениях при получении урона"},--Azazel
		{EID.descriptions["ru"].birthright[9][3],"Скоро", EID.descriptions["ru"].birthright[9][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"},--Lazarus
		{EID.descriptions["ru"].birthright[12][3],"Скоро", EID.descriptions["ru"].birthright[12][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"},--Lazarus Risen
		{EID.descriptions["ru"].birthright[10][3],"25% шанс получить эффект случайого пассивного предмета при входе в комнату", EID.descriptions["ru"].birthright[10][3].."#{{ColorRainbow}}Дополнительные еффекты:#25% шанс получить эффект случайого пассивного предмета при входе в комнату"},--Eden
		{EID.descriptions["ru"].birthright[11][3],"Скоро", EID.descriptions["ru"].birthright[11][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"},--Lost
		{EID.descriptions["ru"].birthright[14][3],"Появляются 2 мини Исаака, когда заходите в комнату с врагами, 4 - в большую комнату#Все мини Исааки исчезают при переходе на новый уровень#{{Collectible357}}Коробка с друзьями теперь дублирует мини Исааков в текущей комнате", EID.descriptions["ru"].birthright[14][3].."#{{ColorRainbow}}Дополнительные еффекты:#Появляются 2 мини Исаака, когда заходите в комнату с врагами, 4 - в большую комнату#Все мини Исааки исчезают при переходе на новый уровень#{{Collectible357}}Коробка с друзьями теперь дублирует мини Исааков в текущей комнате"},--Lilith
		{EID.descriptions["ru"].birthright[15][3],"Один бесплатный предмет или подбираемый предмет на каждом уровене#В магазинах (и секретных комнатах) не будет Жадности / Супер Жадности#Магазины будут появлятся в Матке и Трупе",EID.descriptions["ru"].birthright[15][3].."#{{ColorRainbow}}Дополнительные еффекты:#Один бесплатный предмет или подбираемый предмет на каждом уровене#В магазинах (и секретных комнатах) не будет Жадности / Супер Жадности#Магазины будут появлятся в Матке и Трупе"},--Keeper
		{EID.descriptions["ru"].birthright[16][3],"{{Collectible477}}Пустота становится карманным предметом#Поглащая пассивные предметы с качеством выше 0 дополнительно увеличиваются случайные характеристики#Предметы с качеством выше 0 дают больше характеристик",EID.descriptions["ru"].birthright[16][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{Collectible477}}Пустота становится карманным предметом#Поглащая пассивные предметы с качеством выше 0 дополнительно увеличиваются случайные характеристики#Предметы с качеством выше 0 дают больше характеристик"},--Apollyon
		{EID.descriptions["ru"].birthright[17][3],"Скоро", EID.descriptions["ru"].birthright[17][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"},--Forgotten
		{EID.descriptions["ru"].birthright[19][3],"Проклятия становятся благословениями#100% шанс получить случайное благословение или противоположное проклятию", EID.descriptions["ru"].birthright[19][3].."#{{ColorRainbow}}Дополнительные еффекты:#Проклятия становятся благословениями#100% шанс получить случайное благословение или противоположное проклятию"},--Bethany
		{EID.descriptions["ru"].birthright[20][3],"Исав отдает половину своих несюжетных пассивных предметов Якову в обмен на {{Collectible621}}Красною похлёбку",EID.descriptions["ru"].birthright[20][3].."#{{ColorRainbow}}Дополнительные еффекты:#Исав отдает половину своих несюжетных пассивных предметов Якову в обмен на {{Collectible621}}Красною похлёбку"}, -- Jacob
		{EID.descriptions["ru"].birthright[21][3],"Скоро", EID.descriptions["ru"].birthright[21][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"}, -- Esau
		{EID.descriptions["ru"].birthright[22][3],"Скоро", EID.descriptions["ru"].birthright[22][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"}, -- Tainted Isaac
		{EID.descriptions["ru"].birthright[23][3],"Восстанавливает {{Heart}}красное сердце когда комната зачищена", EID.descriptions["ru"].birthright[23][3].."#{{ColorRainbow}}Дополнительные еффекты:#Восстанавливает {{Heart}}красное сердце когда комната зачищена"}, -- Tainted Magdalene
		{EID.descriptions["ru"].birthright[24][3],"Порченный Кайн может подобрать 1 предмет на текущем этаже#Шанс подобрать {{Collectible619}}Право первородства, не превращая его в подбираемые предметы, если у порченного Кайна его нет#!!! Шанс монжно изменить в настройках Mod Config Menu. По умолчанию значение 0", EID.descriptions["ru"].birthright[24][3].."#{{ColorRainbow}}Дополнительные еффекты:#Порченный Кайн может подобрать 1 предмет на текущем этаже#Шанс подобрать {{Collectible619}}Право первородства, не превращая его в подбираемые предметы, если у порченного Кайна его нет#!!! Шанс монжно изменить в настройках Mod Config Menu. По умолчанию значение 0"}, -- Tainted Cain
		{EID.descriptions["ru"].birthright[25][3],"{{Collectible705}}Тёмные силы становятся Twisted Arts#При использовании Twisted Arts время в комнате остановливается#Дольше длительность по сравнению с Тёмными силами", EID.descriptions["ru"].birthright[25][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{Collectible705}}Тёмные силы становятся Twisted Arts#При использовании Twisted Arts время в комнате остановливается#Дольше длительность по сравнению с Тёмными силами"},--Tainted Judas
		{EID.descriptions["ru"].birthright[26][3],"Шанс выкакать дружественную какашку-дипа#Имея особые предметы есть шанс получить другой тип какашки", EID.descriptions["ru"].birthright[26][3].."#{{ColorRainbow}}Дополнительные еффекты:#Шанс выкакать дружественную какашку-дипа#Имея особые предметы есть шанс получить другой тип какашки"}, -- Tainted BB
		{EID.descriptions["ru"].birthright[27][3],"Шанс на появление дополнительного сгусточка#Сгусточкам нужно получить больше урона, чтобы умереть",EID.descriptions["ru"].birthright[27][3].."#{{ColorRainbow}}Дополнительные еффекты:#Шанс на появление дополнительного сгусточка#Сгусточкам нужно получить больше урона, чтобы умереть"},--Tainted Eve
		{EID.descriptions["ru"].birthright[28][3],"{{ArrowUp}} Увеличение урона#Урон меняется в зависимости от количества врагов возле Самсона в радиусе 100 и сколько раз Самсон получил урон#Бонусный урон, полученный от урона врагов по Самсону, длится на протяжении всего уровня", EID.descriptions["ru"].birthright[28][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{ArrowUp}} Увеличение урона#Урон меняется в зависимости от количества врагов возле Самсона в радиусе 100 и сколько раз Самсон получил урон#Бонусный урон, полученный от урона врагов по Самсону, длится на протяжении всего уровня"}, -- Tainted Samson
		{EID.descriptions["ru"].birthright[29][3],"Получает эффект {{Collectible118}}Серы и способность летать",EID.descriptions["ru"].birthright[29][3].."#{{ColorRainbow}}Дополнительные еффекты:#Получает эффект {{Collectible118}}Серы и способность летать"},--Tainted Azazel
		{EID.descriptions["ru"].birthright[30][3],"Заряд {{Collectible711}}Кувырка восстонавливается со временем",EID.descriptions["ru"].birthright[30][3].."#{{ColorRainbow}}Дополнительные еффекты:#Заряд {{Collectible711}}Кувырка восстонавливается со временем"},--Tainted Lazarus
		{EID.descriptions["ru"].birthright[31][3],"Скоро", EID.descriptions["ru"].birthright[31][3].."#{{ColorRainbow}}Дополнительные еффекты:{{CR}} Скоро"}, -- Tainted Eden
		{EID.descriptions["ru"].birthright[32][3],"Скоро", EID.descriptions["ru"].birthright[32][3].."#{{ColorRainbow}}Дополнительные еффекты:{{CR}} Скоро"}, -- Tainted Lost
		{EID.descriptions["ru"].birthright[33][3],"Создает красную лужу которая наносит 250% урона#Каждый раз когда Лилит выстреливает ребёнком с пуповиной (зародышем), создаётся след из кровавых луж, которые наносят 150% урона", EID.descriptions["ru"].birthright[33][3].."#{{ColorRainbow}}Дополнительные еффекты:#Создает красную лужу которая наносит 250% урона#Каждый раз когда Лилит выстреливает ребёнком с пуповиной (зародышем), создаётся след из кровавых луж, которые наносят 150% урона"},--Tainted Lilith
		{EID.descriptions["ru"].birthright[34][3],"Скоро", EID.descriptions["ru"].birthright[34][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"}, -- Tainted Keeper
		{EID.descriptions["ru"].birthright[35][3],"При подборе появляются 20 саранчи всадников#2-5 саранчи всадников появляются, когда заходите в комнату с врагами","Даёт саранче бездны маленькую ауру {{Collectible331}}Божественности",EID.descriptions["ru"].birthright[35][3].."#{{ColorRainbow}}Дополнительные еффекты:#При подборе появляются 20 саранчи всадников#2-5 саранчи всадников появляются, когда заходите в комнату с врагами",EID.descriptions["ru"].birthright[35][3].."#{{ColorRainbow}}Дополнительные еффекты:#Даёт саранче бездны маленькую ауру {{Collectible331}}Божественности"},--Tainted Apollyon
		{EID.descriptions["ru"].birthright[36][3],"Скоро", EID.descriptions["ru"].birthright[36][3].."#{{ColorRainbow}}Дополнительные еффекты:#Скоро"}, -- Tainted Forgotten
		{EID.descriptions["ru"].birthright[37][3],"Огоньки предметов стреляют самонаводящимися слезами со скорострельностью Порченой Вифании и 40% её урона#Огонькам нужно получить больше урона, чтобы их уничтожить", EID.descriptions["ru"].birthright[37][3].."#{{ColorRainbow}}Дополнительные еффекты:#Огоньки предметов стреляют самонаводящимися слезами со скорострельностью Порченой Вифании и 40% её урона#Огонькам нужно получить больше урона, чтобы их уничтожить"},--Tainted Bethany
		{EID.descriptions["ru"].birthright[38][3],"{{ArrowUp}} +1 к здоровью#{{ArrowUp}} +50% множитель урона#{{ArrowUp}} +1 к скорострельности#{{ArrowUp}} +0.3 к скорости#Тёмный Исав фокусируется на живом враге, который нанес урон Порченному Иакову#{{TreasureRoom}}В Комнатах Сокровищ, {{SecretRoom}}Секретных/{{SuperSecretRoom}}Супер Секретных и {{DevilRoom}}Дьявольских комнатах находятся в два раза больше предметов#Порченный Иаков умирает в любой форме от урона Тёмного Исава", "Тёмный Исав становится дружелюбным и преследует врагов", EID.descriptions["ru"].birthright[38][3].."#{{ColorRainbow}}Дополнительные еффекты:#{{ArrowUp}} +1 к здоровью#{{ArrowUp}} +50% множитель урона#{{ArrowUp}} +1 к скорострельности#{{ArrowUp}} +0.3 к скорости#Тёмный Исав фокусируется на живом враге, который нанес урон Порченному Иакову#{{TreasureRoom}}В Комнатах Сокровищ, {{SecretRoom}}Секретных/{{SuperSecretRoom}}Супер Секретных и {{DevilRoom}}Дьявольских комнатах находятся в два раза больше предметов#Порченный Иаков умирает в любой форме от урона Тёмного Исава", EID.descriptions["ru"].birthright[38][3].."#{{ColorRainbow}}Дополнительные еффекты:#Тёмный Исав становится дружелюбным и преследует врагов"}--Tainted Jacob
	},
SPA = {
		{EID.descriptions["spa"].birthright[1][3],"{{Collectible105}} El D6 se convierte en un activo de bolsillo#Tiene la posibilidad de rerollear entre la pool del {{TreasureRoom}}Tesoro, {{AngelRoom}}Ángel o {{DevilRoom}}Diablo",EID.descriptions["spa"].birthright[1][3].."#{{ColorRainbow}}Efecto extra:#{{Collectible105}}El D6 se convierte en un activo de bolsillo#Tiene la posibilidad de rerollear entre la pool del {{TreasureRoom}}Tesoro, {{AngelRoom}}Ángel o {{DevilRoom}}Diablo"}, -- Isaac
		{EID.descriptions["spa"].birthright[2][3],"Posibilidad de encantar enemigos en un radio de 50#{{Collectible45}}Delicioso Corazón cura 2 {{Heart}} corazones rojos en vez de 1", "{{ArrowUp}} más velocidad. La velocidad está relacionada con los {{HalfHeart}} corazones rojos#Velocidad = velocidad + ({{HalfHeart}} * 0.06)#Ganas 1 {{SoulHeart}} corazón de alma al llegar a un nuevo piso",EID.descriptions["spa"].birthright[2][3].."#{{ColorRainbow}}Efecto extra:#Posibilidad de encantar enemigos en un radio de 50#{{Collectible45}}Delicioso Corazón cura 2 {{Heart}} corazones rojos en vez de 1", EID.descriptions["spa"].birthright[2][3].."#{{ColorRainbow}}Efecto extra:#{{ArrowUp}}más velocidad. La velocidad está relacionada con los {{HalfHeart}} corazones rojos#Velocidad = velocidad + ({{HalfHeart}} * 0.06)#Ganas 1 {{SoulHeart}} corazón de alma al llegar a un nuevo piso"}, -- Maggie
		{EID.descriptions["spa"].birthright[3][3],"Los enemigos tienen la posibilidad de soltar un recolectable#Los enemigos campeones sueltan 2 recolectables similares#Si en la habitación hay un jefe, Limpiarla dará la posibilidad un objeto de la pool de la habitación actual","Cain siempre tendrá una {{GoldenKey}}llave dorada",EID.descriptions["spa"].birthright[3][3].."#{{ColorRainbow}}Efecto extra:#Los enemigos tienen la posibilidad de soltar un recolectable#Los enemigos campeones sueltan 2 recolectables similares#Si en la habitación hay un jefe, Limpiarla dará la posibilidad un objeto de la pool de la habitación actual",EID.descriptions["spa"].birthright[3][3].."#{{ColorRainbow}}Efecto extra:#Cain siempre tendrá una {{GoldenKey}}llave dorada"},--Cain
		{EID.descriptions["spa"].birthright[4][3],"Genera 3 nickels#Judas has tiene 20% de posibilidad de obtener {{ArrowUp}} {{Damage}} daño +5.0 y {{Collectible118}} Azufre al recibir daño, dura toda la habitación","Usar libros activa el efecto de {{Collectible35}} El Necronomicón", EID.descriptions["spa"].birthright[4][3].."#{{ColorRainbow}}Efecto extra:#Genera 3 nickels#Judas has tiene 20% de posibilidad de obtener {{ArrowUp}} {{Damage}} Daño +5.0 y {{Collectible118}} Azufre al recibir daño, dura toda la habitación",EID.descriptions["spa"].birthright[4][3].."#Efecto extra:{{CR}} Usar libros activa el efecto de {{Collectible35}} El Necronomicón"},--Judas
		{EID.descriptions["spa"].birthright[13][3],"Activas el efecto de {{Collectible35}} El Necronomicón al recibir daño","Usar libros activa el efecto de {{Collectible35}} El Necronomicón", EID.descriptions["spa"].birthright[13][3].."#{{ColorRainbow}}Efecto extra:#Activas el efecto de {{Collectible35}} El Necronomicón al recibir daño",EID.descriptions["spa"].birthright[13][3].."#{{ColorRainbow}}Efecto extra:#Usar libros activa el efecto de {{Collectible35}} El Necronomicón"},--Dark Judas
		{EID.descriptions["spa"].birthright[5][3],"{{ArrowUp}} {{SoulHeart}} Los corazones de alma dan un aumento de: {{Damage}} daño, {{Tears}} lágrimas, {{Speed}} velocidad y {{Range}} alcance en base a cuantos tengas#Los otros corazones se convertirán en otros recolectables",EID.descriptions["spa"].birthright[5][3].."#{{ColorRainbow}}Efecto extra:#{{ArrowUp}} {{SoulHeart}} Los corazones de alma dan un aumento de {{Damage}} daño, {{Tears}} lágrimas, {{Speed}} velocidad y {{Range}} alcance en base a cuantos tengas#Los otros corazones se convertirán en otros recolectables"},--Blue Baby
		{EID.descriptions["spa"].birthright[6][3],"Recibir golpes podrá generar Aves muertas que persisten entre salas", EID.descriptions["spa"].birthright[6][3].."#{{ColorRainbow}}Efecto extra:#Recibir golpes podrá generar Aves muertas que persisten entre salas"},--Eve
		{EID.descriptions["spa"].birthright[7][3],"{{ArrowUp}} {{Damage}} Daño +4#Adquieres la capacidad de tomar y lanzar cosas", EID.descriptions["spa"].birthright[7][3].."#{{ColorRainbow}}Efecto extra:#{{ArrowUp}} {{Damage}} Daño +4#Adquieres la capacidad de tomar y lanzar cosas"},--Samson
		{EID.descriptions["spa"].birthright[8][3],"20% de posibilidad de disparar en 8 direcciones al recibir daño", EID.descriptions["spa"].birthright[8][3].."#{{ColorRainbow}}Efecto extra:#20% de posibilidad de disparar en 8 direcciones al recibir daño"},--Azazel
		{EID.descriptions["spa"].birthright[9][3],"Pronto", EID.descriptions["spa"].birthright[9][3].."#{{ColorRainbow}}Efecto extra:#Pronto"},--Lazarus
		{EID.descriptions["spa"].birthright[12][3],"Pronto", EID.descriptions["spa"].birthright[12][3].."#{{ColorRainbow}}Efecto extra:#Pronto"},--Lazarus Risen
		{EID.descriptions["spa"].birthright[10][3],"25% de posibilidad de conseguir el efecto de un objeto pasivo aleatorio al entrar a una sala",EID.descriptions["spa"].birthright[10][3].."#{{ColorRainbow}}Efecto extra:#25% de posibilidad de conseguir el efecto de un objeto pasivo aleatorio al entrar a una sala"},--Eden
		{EID.descriptions["spa"].birthright[11][3],"Pronto", EID.descriptions["spa"].birthright[11][3].."#{{ColorRainbow}}Efecto extra:#Pronto"},--Lost
		{EID.descriptions["spa"].birthright[14][3],"Genera 2 mini Isaacs al entrar a una habitación hostil, 4 en habitaciones grandes#Todos los mini Isaacs desaparecen al avanzar al siguiente piso#{{Collectible357}}La Caja de Amigos ahora duplica a los mini Isaacs durante la habitación",EID.descriptions["spa"].birthright[14][3].."#{{ColorRainbow}}Efecto extra:#Genera 2 mini Isaacs al entrar a una habitación hostil, 4 en habitaciones grandes#Todos los mini Isaacs desaparecen al avanzar al siguiente piso#{{Collectible357}}La Caja de Amigos ahora duplica a los mini Isaacs"},--Lilith
		{EID.descriptions["spa"].birthright[15][3],"Un objeto o recolectable que cueste dinero será gratis por nivel#Las tiendas (y salas secretas) no tendrán a Avaricia ni a Superavaricia, las tiendas aparecerán en la Matriz y el Cadaver",EID.descriptions["spa"].birthright[15][3].."#{{ColorRainbow}}Efecto extra:#Un objeto o recolectable que cueste dinero será gratis por nivel#Las tiendas (y salas secretas) no tendrán a Avaricia ni a Superavaricia, las tiendas aparecerán en la Matriz y el Cadaver"},--Keeper
		{EID.descriptions["spa"].birthright[16][3],"{{Collectible477}} Vacío se convierte en un activo de bolsillo#Absorber objetos pasivos de calidad mayor a 0 dará aumentos de estadísticas aleatorios#Mayor Calidad = Más aumento de estadísticas",EID.descriptions["spa"].birthright[16][3].."{{ColorRainbow}}#Efecto extra:#{{Collectible477}} Vacío se convierte en un activo de bolsillo# Absorber objetos pasivos de calidad mayor a 0 dará aumentos de estadísticas aleatorios#Mayor Calidad = Más aumento de estadísticas"},--Apollyon
		{EID.descriptions["spa"].birthright[17][3],"Pronto", EID.descriptions["spa"].birthright[17][3].."#{{ColorRainbow}}Efecto extra:#Pronto"},--Forgotten
		{EID.descriptions["spa"].birthright[19][3],"Las maldiciones se convierten en bendiciones#100% de posibilidad de tener una bendición o invertir una maldición", EID.descriptions["spa"].birthright[19][3].."#{{ColorRainbow}}:#Las maldiciones se convierten en bendiciones#100% de posibilidad de tener una bendición o invertir una maldición"},--Bethany
		{EID.descriptions["spa"].birthright[20][3],"Esaú dará la mitad de sus objetos (no relacionados a la historia) a cambio del {{Collectible621}} Guisado Rojo", EID.descriptions["spa"].birthright[20][3].."#{{ColorRainbow}}Efecto extra:#Esaú dará la mitad de sus objetos (no relacionados a la historia) a cambio del {{Collectible621}} Guisado Rojo"}, -- Jacob
		{EID.descriptions["spa"].birthright[21][3],"Pronto", EID.descriptions["spa"].birthright[21][3].."#{{ColorRainbow}}Efecto extra:#Pronto"}, -- Esau
		{EID.descriptions["spa"].birthright[22][3],"Pronto", EID.descriptions["spa"].birthright[22][3].."#{{ColorRainbow}}Efecto extra:#Pronto"}, -- Tainted Isaac
		{EID.descriptions["spa"].birthright[23][3],"Regenera {{Heart}} un corazón rojo al limpiar una habitación",EID.descriptions["spa"].birthright[23][3].."#{{ColorRainbow}}Efecto extra:#Regenera {{Heart}} un corazón rojo al limpiar una habitación"}, -- Tainted Magdalene
		{EID.descriptions["spa"].birthright[24][3],"Caín contaminado podrá tomar un objeto por piso#Posibilidad de que {{Collectible619}} Primogenitura no se convierta en recolectables, en caso de que Caín contaminado no lo tenga#!!! Esta posibilidad se puede alterar en Mod Config Menu, por defecto está en 0", EID.descriptions["spa"].birthright[24][3].."#{{ColorRainbow}}Efecto extra:#Caín contaminado podrá tomar un objeto por piso#Posibilidad de que {{Collectible619}} Primogenitura no se convierta en recolectables, en caso de que Caín contaminado no lo tenga#!!! Esta posibilidad se puede alterar en Mod Config Menu, por defecto está en 0"}, -- Tainted Cain
		{EID.descriptions["spa"].birthright[25][3],"{{Collectible705}} Artes Oscuras se convierte en Artes Retorcidas (Twisted Arts)#Usar Artes Retorcidas congelará el tiempo en la habitación#Mayor duración comparado a Artes Oscuras", EID.descriptions["spa"].birthright[25][3].."#{{ColorRainbow}}Efecto extra:#{{Collectible705}} Artes Oscuras se convierte en Artes Retorcidas (Twisted Arts)#Usar Artes Retorcidas congelará el tiempo en la habitación#Mayor duración comparado a Artes Oscuras"},--Tainted Judas
		{EID.descriptions["spa"].birthright[26][3],"Posibilidad de cagar un dip amistoso#Tener ciertos objetos especiales pueden generar distintos tipos de Dips", EID.descriptions["spa"].birthright[26][3].."#{{ColorRainbow}}Efecto extra:#Posibilidad de cagar un dip amistoso#Tener ciertos objetos especiales pueden generar distintos tipos de Dips"}, -- Tainted BB
		{EID.descriptions["spa"].birthright[27][3],"Posibilidad de generar un bebé coágulo de forma gratuita#Los bebés coágulos tardan más en morir",EID.descriptions["spa"].birthright[27][3].."#{{ColorRainbow}}Efecto extra# Posibilidad de generar un bebé coágulo de forma gratuita#Los bebés coágulos tardan más en morir"},--Tainted Eve
		{EID.descriptions["spa"].birthright[28][3],"{{ArrowUp}} {{Damage}} Más daño#Los cambios de daño dependerán de cuantos enemigos haya cerca de Tainted Sansón en un radio de 100 Y en cuantas veces haya sido golpeado#La bonificación de daño por los golpes durará todo el piso", EID.descriptions["spa"].birthright[28][3].."#{{ColorRainbow}}Efecto extra:#{{ArrowUp}} {{Damage}} Más daño#Los cambios de daño dependerán de cuantos enemigos haya cerca de Tainted Sansón en un radio de 100 Y en cuantas veces haya sido golpeado#La bonificación de daño por los golpes durará todo el piso"}, -- Tainted Samson
		{EID.descriptions["spa"].birthright[29][3],"Recibes {{Collectible118}}Azufre y la capacida de volar",EID.descriptions["spa"].birthright[27][3].."#{{ColorRainbow}}Efecto extra:#Recibes {{Collectible118}}Azufre y la capacida de volar"},--Tainted Azazel
		{EID.descriptions["spa"].birthright[30][3],"{{Collectible711}} Cambio se recarga con el tiempo",EID.descriptions["spa"].birthright[30][3].."#{{ColorRainbow}}Efecto extra:#{{Collectible711}} Cambio se recarga con el tiempo"},--Tainted Lazarus
		{EID.descriptions["spa"].birthright[31][3],"Pronto", EID.descriptions["spa"].birthright[31][3].."#{{ColorRainbow}}Efecto extra:#Pronto"}, -- Tainted Eden
		{EID.descriptions["spa"].birthright[32][3],"Pronto", EID.descriptions["spa"].birthright[32][3].."#{{ColorRainbow}}Efecto extra:#Pronto"}, -- Tainted Lost
		{EID.descriptions["spa"].birthright[33][3],"Genera creep rojo que provoca el daño del jugador al 250%#Cada vez que Tainted Lilith lancé al bebé umbilical, este genera un rastro de creep rojo que provoca el daño del jugador al 150%",EID.descriptions["spa"].birthright[33][3].."#{{ColorRainbow}}Efecto extra#Genera creep rojo que provoca el daño del jugador al 250%#Cada vez que Tainted Lilith lancé al bebé umbilical, este genera un rastro de creep rojo que provoca el daño del jugador al 150%"},--Tainted Lilith
		{EID.descriptions["spa"].birthright[34][3],"Pronto", EID.descriptions["spa"].birthright[34][3].."#Efecto extra:{{CR}} Pronto"}, -- Tainted Keeper
		{EID.descriptions["spa"].birthright[35][3],"Genera 20 langostas de los jinetes#Se generan 2-5 langostas de los jinetes en una habitación hostil","Otorga a las langostas de Abismo un aura de {{Collectible331}} Divinidad",EID.descriptions["spa"].birthright[35][3].."#{{ColorRainbow}}Efecto extra:#Genera 20 langostas de los jinetes#Se generan 2-5 langostas de los jinetes en una habitación hostil",EID.descriptions["spa"].birthright[35][3].."{{ColorRainbow}}Efecto extra:#Otorga a las langostas de Abismo un aura de {{Collectible331}} Divinidad"},--Tainted Apollyon
		{EID.descriptions["spa"].birthright[36][3],"Pronto", EID.descriptions["spa"].birthright[36][3].."#{{ColorRainbow}}Efecto extra:#Pronto"}, -- Tainted Forgotten
		{EID.descriptions["spa"].birthright[37][3],"Los fuegos de objetos disparan lágrimas teledirigidas#Escalan con la cadencia de tiro de Bethany Contaminada, hacen el 40% de su daño#Toman más golpes en ser destruídos",EID.descriptions["spa"].birthright[37][3].."#{{ColorRainbow}}Efecto extra:#Los fuegos de objetos disparan lágrimas teledirigidas#Escalan con la cadencia de tiro de Bethany Contaminada, hacen el 40% de su daño#Toman más golpes en ser destruídos"},--Tainted Bethany		
		{EID.descriptions["spa"].birthright[38][3],"{{ArrowUp}} {{Heart}} +1 corazón#{{ArrowUp}} {Damage}} Daño x1.5#{{ArrowUp}} {{Tears}} Lágrimas +1#{{ArrowUp}} {{Speed}} Velocidad +0.3#Esaú Oscuro atacará a quienes dañaron a Jacob Contaminado#Se aplica el efecto de {{Collectible577}} Damocles reducido#Tainted Jacob morirá por cualquier daño de Dark Esau", "Dark Esau se vuelve amigable y apunta a los enemigos", EID.descriptions["spa"].birthright[38][3].."#{{ColorRainbow}}Efecto extra:#{{ArrowUp}} {{Heart}} +1 corazón#{{ArrowUp}} {Damage}} Daño x1.5#{{ArrowUp}} {{Tears}} Lágrimas +1#Dark Esau atacará a quienes dañaron a Tainted Jacob#Se aplica el efecto de {{Collectible577}} Damocles reducido#Tainted Jacob morirá por cualquier daño de Dark Esau", EID.descriptions["spa"].birthright[38][3].."#{{ColorRainbow}}Efecto extra:{{ColorReset}}#Dark Esau se vuelve amigable y apunta a los enemigos"}--Tainted Jacob
	}
}
end

function mod:BirthrightDesc()
	if EID then
		local EsauName = EID:getDescriptionEntry("birthright", PlayerType.PLAYER_ESAU+1)[1] or "Esau"
		local JandE_EN_EID = mod.EBEIDDesc.EN[19][mod.MCMOption.Settings["Jacob"]].."#{{Player"..PlayerType.PLAYER_ESAU.."}} {{ColorGray}}"..EsauName.."{{CR}}#"..mod.EBEIDDesc.EN[20][mod.MCMOption.Settings["Esau"]]
		local JandE_RU_EID = mod.EBEIDDesc.RU[19][mod.MCMOption.Settings["Jacob"]].."#{{Player"..PlayerType.PLAYER_ESAU.."}} {{ColorGray}}"..EsauName.."{{CR}}#"..mod.EBEIDDesc.RU[20][mod.MCMOption.Settings["Esau"]]
		local JandE_SPA_EID = mod.EBEIDDesc.SPA[19][mod.MCMOption.Settings["Jacob"]].."#{{Player"..PlayerType.PLAYER_ESAU.."}} {{ColorGray}}"..EsauName.."{{CR}}#"..mod.EBEIDDesc.SPA[20][mod.MCMOption.Settings["Esau"]]
		EID:addBirthright(PlayerType.PLAYER_ISAAC, mod.EBEIDDesc.EN[1][mod.MCMOption.Settings["Isaac"]])
		EID:addBirthright(PlayerType.PLAYER_MAGDALENA, mod.EBEIDDesc.EN[2][mod.MCMOption.Settings["Magdalene"]])
		EID:addBirthright(PlayerType.PLAYER_CAIN, mod.EBEIDDesc.EN[3][mod.MCMOption.Settings["Cain"]])
		EID:addBirthright(PlayerType.PLAYER_JUDAS, mod.EBEIDDesc.EN[4][mod.MCMOption.Settings["Judas"]])
		EID:addBirthright(PlayerType.PLAYER_BLACKJUDAS, mod.EBEIDDesc.EN[5][mod.MCMOption.Settings["Dark Judas"]])
		EID:addBirthright(PlayerType.PLAYER_XXX, mod.EBEIDDesc.EN[6][mod.MCMOption.Settings["Blue Baby"]])
		EID:addBirthright(PlayerType.PLAYER_EVE, mod.EBEIDDesc.EN[7][mod.MCMOption.Settings["Eve"]])
		EID:addBirthright(PlayerType.PLAYER_SAMSON, mod.EBEIDDesc.EN[8][mod.MCMOption.Settings["Samson"]])
		EID:addBirthright(PlayerType.PLAYER_AZAZEL, mod.EBEIDDesc.EN[9][mod.MCMOption.Settings["Azazel"]])
		EID:addBirthright(PlayerType.PLAYER_LAZARUS, mod.EBEIDDesc.EN[10][mod.MCMOption.Settings["Lazarus"]])
		EID:addBirthright(PlayerType.PLAYER_LAZARUS2, mod.EBEIDDesc.EN[11][mod.MCMOption.Settings["Lazarus Risen"]])
		EID:addBirthright(PlayerType.PLAYER_EDEN, mod.EBEIDDesc.EN[12][mod.MCMOption.Settings["Eden"]])
		EID:addBirthright(PlayerType.PLAYER_THELOST, mod.EBEIDDesc.EN[13][mod.MCMOption.Settings["The Lost"]])
		EID:addBirthright(PlayerType.PLAYER_LILITH, mod.EBEIDDesc.EN[14][mod.MCMOption.Settings["Lilith"]])
		EID:addBirthright(PlayerType.PLAYER_KEEPER, mod.EBEIDDesc.EN[15][mod.MCMOption.Settings["Keeper"]])
		EID:addBirthright(PlayerType.PLAYER_APOLLYON, mod.EBEIDDesc.EN[16][mod.MCMOption.Settings["Apollyon"]])
		EID:addBirthright(PlayerType.PLAYER_THEFORGOTTEN, mod.EBEIDDesc.EN[17][mod.MCMOption.Settings["The Forgotten"]])
		EID:addBirthright(PlayerType.PLAYER_THESOUL, mod.EBEIDDesc.EN[17][mod.MCMOption.Settings["The Forgotten"]])
		EID:addBirthright(PlayerType.PLAYER_BETHANY, mod.EBEIDDesc.EN[18][mod.MCMOption.Settings["Bethany"]])
		EID:addBirthright(PlayerType.PLAYER_JACOB, JandE_EN_EID)
		EID:addBirthright(PlayerType.PLAYER_ESAU, mod.EBEIDDesc.EN[20][mod.MCMOption.Settings["Esau"]])
		EID:addBirthright(PlayerType.PLAYER_ISAAC_B, mod.EBEIDDesc.EN[21][mod.MCMOption.Settings["Tainted Isaac"]])
		EID:addBirthright(PlayerType.PLAYER_MAGDALENA_B, mod.EBEIDDesc.EN[22][mod.MCMOption.Settings["Tainted Magdalene"]])
		EID:addBirthright(PlayerType.PLAYER_CAIN_B, mod.EBEIDDesc.EN[23][mod.MCMOption.Settings["Tainted Cain"]])
		EID:addBirthright(PlayerType.PLAYER_JUDAS_B, mod.EBEIDDesc.EN[24][mod.MCMOption.Settings["Tainted Judas"]])
		EID:addBirthright(PlayerType.PLAYER_XXX_B, mod.EBEIDDesc.EN[25][mod.MCMOption.Settings["Tainted Blue Baby"]])
		EID:addBirthright(PlayerType.PLAYER_EVE_B, mod.EBEIDDesc.EN[26][mod.MCMOption.Settings["Tainted Eve"]])
		EID:addBirthright(PlayerType.PLAYER_SAMSON_B, mod.EBEIDDesc.EN[27][mod.MCMOption.Settings["Tainted Samson"]])
		EID:addBirthright(PlayerType.PLAYER_AZAZEL_B, mod.EBEIDDesc.EN[28][mod.MCMOption.Settings["Tainted Azazel"]])
		EID:addBirthright(PlayerType.PLAYER_LAZARUS_B, mod.EBEIDDesc.EN[29][mod.MCMOption.Settings["Tainted Lazarus"]])
		EID:addBirthright(PlayerType.PLAYER_LAZARUS2_B, mod.EBEIDDesc.EN[29][mod.MCMOption.Settings["Tainted Lazarus"]])
		EID:addBirthright(PlayerType.PLAYER_EDEN_B, mod.EBEIDDesc.EN[30][mod.MCMOption.Settings["Tainted Eden"]])
		EID:addBirthright(PlayerType.PLAYER_THELOST_B, mod.EBEIDDesc.EN[31][mod.MCMOption.Settings["Tainted Lost"]])
		EID:addBirthright(PlayerType.PLAYER_LILITH_B, mod.EBEIDDesc.EN[32][mod.MCMOption.Settings["Tainted Lilith"]])
		EID:addBirthright(PlayerType.PLAYER_KEEPER_B, mod.EBEIDDesc.EN[33][mod.MCMOption.Settings["Tainted Keeper"]])
		EID:addBirthright(PlayerType.PLAYER_APOLLYON_B, mod.EBEIDDesc.EN[34][mod.MCMOption.Settings["Tainted Apollyon"]])
		EID:addBirthright(PlayerType.PLAYER_THEFORGOTTEN_B, mod.EBEIDDesc.EN[35][mod.MCMOption.Settings["Tainted Forgotten"]])
		EID:addBirthright(PlayerType.PLAYER_THESOUL_B, mod.EBEIDDesc.EN[35][mod.MCMOption.Settings["Tainted Forgotten"]])
		EID:addBirthright(PlayerType.PLAYER_BETHANY_B, mod.EBEIDDesc.EN[36][mod.MCMOption.Settings["Tainted Bethany"]])
		EID:addBirthright(PlayerType.PLAYER_JACOB_B, mod.EBEIDDesc.EN[37][mod.MCMOption.Settings["Tainted Jacob"]])
		EID:addBirthright(PlayerType.PLAYER_JACOB2_B, mod.EBEIDDesc.EN[37][mod.MCMOption.Settings["Tainted Jacob"]])

		EID:addBirthright(PlayerType.PLAYER_ISAAC, mod.EBEIDDesc.RU[1][mod.MCMOption.Settings["Isaac"]],EID.descriptions["ru"].birthright[1][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_MAGDALENA, mod.EBEIDDesc.RU[2][mod.MCMOption.Settings["Magdalene"]],EID.descriptions["ru"].birthright[2][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_CAIN, mod.EBEIDDesc.RU[3][mod.MCMOption.Settings["Cain"]],EID.descriptions["ru"].birthright[3][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_JUDAS, mod.EBEIDDesc.RU[4][mod.MCMOption.Settings["Judas"]],EID.descriptions["ru"].birthright[4][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_BLACKJUDAS, mod.EBEIDDesc.RU[5][mod.MCMOption.Settings["Dark Judas"]],EID.descriptions["ru"].birthright[13][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_XXX, mod.EBEIDDesc.RU[6][mod.MCMOption.Settings["Blue Baby"]],EID.descriptions["ru"].birthright[5][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_EVE, mod.EBEIDDesc.RU[7][mod.MCMOption.Settings["Eve"]],EID.descriptions["ru"].birthright[6][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_SAMSON, mod.EBEIDDesc.RU[8][mod.MCMOption.Settings["Samson"]],EID.descriptions["ru"].birthright[7][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_AZAZEL, mod.EBEIDDesc.RU[9][mod.MCMOption.Settings["Azazel"]],EID.descriptions["ru"].birthright[8][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS, mod.EBEIDDesc.RU[10][mod.MCMOption.Settings["Lazarus"]],EID.descriptions["ru"].birthright[9][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS2, mod.EBEIDDesc.RU[11][mod.MCMOption.Settings["Lazarus Risen"]],EID.descriptions["ru"].birthright[12][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_EDEN, mod.EBEIDDesc.RU[12][mod.MCMOption.Settings["Eden"]],EID.descriptions["ru"].birthright[10][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_THELOST, mod.EBEIDDesc.RU[13][mod.MCMOption.Settings["The Lost"]],EID.descriptions["ru"].birthright[11][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_LILITH, mod.EBEIDDesc.RU[14][mod.MCMOption.Settings["Lilith"]],EID.descriptions["ru"].birthright[14][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_KEEPER, mod.EBEIDDesc.RU[15][mod.MCMOption.Settings["Keeper"]],EID.descriptions["ru"].birthright[15][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_APOLLYON, mod.EBEIDDesc.RU[16][mod.MCMOption.Settings["Apollyon"]],EID.descriptions["ru"].birthright[16][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_THEFORGOTTEN, mod.EBEIDDesc.RU[17][mod.MCMOption.Settings["The Forgotten"]],EID.descriptions["ru"].birthright[17][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_THESOUL, mod.EBEIDDesc.RU[17][mod.MCMOption.Settings["The Forgotten"]],EID.descriptions["ru"].birthright[18][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_BETHANY, mod.EBEIDDesc.RU[18][mod.MCMOption.Settings["Bethany"]],EID.descriptions["ru"].birthright[1][19],"ru")
		EID:addBirthright(PlayerType.PLAYER_JACOB, JandE_RU_EID,EID.descriptions["ru"].birthright[20][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_ESAU, mod.EBEIDDesc.RU[20][mod.MCMOption.Settings["Esau"]],EID.descriptions["ru"].birthright[21][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_ISAAC_B, mod.EBEIDDesc.RU[21][mod.MCMOption.Settings["Tainted Isaac"]],EID.descriptions["ru"].birthright[22][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_MAGDALENA_B, mod.EBEIDDesc.RU[22][mod.MCMOption.Settings["Tainted Magdalene"]],EID.descriptions["ru"].birthright[23][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_CAIN_B, mod.EBEIDDesc.RU[23][mod.MCMOption.Settings["Tainted Cain"]],EID.descriptions["ru"].birthright[24][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_JUDAS_B, mod.EBEIDDesc.RU[24][mod.MCMOption.Settings["Tainted Judas"]],EID.descriptions["ru"].birthright[25][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_XXX_B, mod.EBEIDDesc.RU[25][mod.MCMOption.Settings["Tainted Blue Baby"]],EID.descriptions["ru"].birthright[26][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_EVE_B, mod.EBEIDDesc.RU[26][mod.MCMOption.Settings["Tainted Eve"]],EID.descriptions["ru"].birthright[27][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_SAMSON_B, mod.EBEIDDesc.RU[27][mod.MCMOption.Settings["Tainted Samson"]],EID.descriptions["ru"].birthright[28][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_AZAZEL_B, mod.EBEIDDesc.RU[28][mod.MCMOption.Settings["Tainted Azazel"]],EID.descriptions["ru"].birthright[29][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS_B, mod.EBEIDDesc.RU[29][mod.MCMOption.Settings["Tainted Lazarus"]],EID.descriptions["ru"].birthright[30][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS2_B, mod.EBEIDDesc.RU[29][mod.MCMOption.Settings["Tainted Lazarus"]],EID.descriptions["ru"].birthright[39][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_EDEN_B, mod.EBEIDDesc.RU[30][mod.MCMOption.Settings["Tainted Eden"]],EID.descriptions["ru"].birthright[31][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_THELOST_B, mod.EBEIDDesc.RU[31][mod.MCMOption.Settings["Tainted Lost"]],EID.descriptions["ru"].birthright[32][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_LILITH_B, mod.EBEIDDesc.RU[32][mod.MCMOption.Settings["Tainted Lilith"]],EID.descriptions["ru"].birthright[33][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_KEEPER_B, mod.EBEIDDesc.RU[33][mod.MCMOption.Settings["Tainted Keeper"]],EID.descriptions["ru"].birthright[34][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_APOLLYON_B, mod.EBEIDDesc.RU[34][mod.MCMOption.Settings["Tainted Apollyon"]],EID.descriptions["ru"].birthright[35][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_THEFORGOTTEN_B, mod.EBEIDDesc.RU[35][mod.MCMOption.Settings["Tainted Forgotten"]],EID.descriptions["ru"].birthright[36][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_THESOUL_B, mod.EBEIDDesc.RU[35][mod.MCMOption.Settings["Tainted Forgotten"]],EID.descriptions["ru"].birthright[41][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_BETHANY_B, mod.EBEIDDesc.RU[36][mod.MCMOption.Settings["Tainted Bethany"]],EID.descriptions["ru"].birthright[37][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_JACOB_B, mod.EBEIDDesc.RU[37][mod.MCMOption.Settings["Tainted Jacob"]],EID.descriptions["ru"].birthright[38][1],"ru")
		EID:addBirthright(PlayerType.PLAYER_JACOB2_B, mod.EBEIDDesc.RU[37][mod.MCMOption.Settings["Tainted Jacob"]],EID.descriptions["ru"].birthright[39][1],"ru")

		EID:addBirthright(PlayerType.PLAYER_ISAAC, mod.EBEIDDesc.SPA[1][mod.MCMOption.Settings["Isaac"]],EID.descriptions["spa"].birthright[1][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_MAGDALENA, mod.EBEIDDesc.SPA[2][mod.MCMOption.Settings["Magdalene"]],EID.descriptions["spa"].birthright[2][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_CAIN, mod.EBEIDDesc.SPA[3][mod.MCMOption.Settings["Cain"]],EID.descriptions["spa"].birthright[3][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_JUDAS, mod.EBEIDDesc.SPA[4][mod.MCMOption.Settings["Judas"]],EID.descriptions["spa"].birthright[4][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_BLACKJUDAS, mod.EBEIDDesc.SPA[5][mod.MCMOption.Settings["Dark Judas"]],EID.descriptions["spa"].birthright[13][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_XXX, mod.EBEIDDesc.SPA[6][mod.MCMOption.Settings["Blue Baby"]],EID.descriptions["spa"].birthright[5][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_EVE, mod.EBEIDDesc.SPA[7][mod.MCMOption.Settings["Eve"]],EID.descriptions["spa"].birthright[6][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_SAMSON, mod.EBEIDDesc.SPA[8][mod.MCMOption.Settings["Samson"]],EID.descriptions["spa"].birthright[7][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_AZAZEL, mod.EBEIDDesc.SPA[9][mod.MCMOption.Settings["Azazel"]],EID.descriptions["spa"].birthright[8][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS, mod.EBEIDDesc.SPA[10][mod.MCMOption.Settings["Lazarus"]],EID.descriptions["spa"].birthright[9][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS2, mod.EBEIDDesc.SPA[11][mod.MCMOption.Settings["Lazarus Risen"]],EID.descriptions["spa"].birthright[12][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_EDEN, mod.EBEIDDesc.SPA[12][mod.MCMOption.Settings["Eden"]],EID.descriptions["spa"].birthright[10][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_THELOST, mod.EBEIDDesc.SPA[13][mod.MCMOption.Settings["The Lost"]],EID.descriptions["spa"].birthright[11][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_LILITH, mod.EBEIDDesc.SPA[14][mod.MCMOption.Settings["Lilith"]],EID.descriptions["spa"].birthright[14][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_KEEPER, mod.EBEIDDesc.SPA[15][mod.MCMOption.Settings["Keeper"]],EID.descriptions["spa"].birthright[15][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_APOLLYON, mod.EBEIDDesc.SPA[16][mod.MCMOption.Settings["Apollyon"]],EID.descriptions["spa"].birthright[16][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_THEFORGOTTEN, mod.EBEIDDesc.SPA[17][mod.MCMOption.Settings["The Forgotten"]],EID.descriptions["spa"].birthright[17][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_THESOUL, mod.EBEIDDesc.SPA[17][mod.MCMOption.Settings["The Forgotten"]],EID.descriptions["spa"].birthright[18][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_BETHANY, mod.EBEIDDesc.SPA[18][mod.MCMOption.Settings["Bethany"]],EID.descriptions["spa"].birthright[1][19],"spa")
		EID:addBirthright(PlayerType.PLAYER_JACOB, JandE_SPA_EID,EID.descriptions["spa"].birthright[20][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_ESAU, mod.EBEIDDesc.SPA[20][mod.MCMOption.Settings["Esau"]],EID.descriptions["spa"].birthright[21][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_ISAAC_B, mod.EBEIDDesc.SPA[21][mod.MCMOption.Settings["Tainted Isaac"]],EID.descriptions["spa"].birthright[22][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_MAGDALENA_B, mod.EBEIDDesc.SPA[22][mod.MCMOption.Settings["Tainted Magdalene"]],EID.descriptions["spa"].birthright[23][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_CAIN_B, mod.EBEIDDesc.SPA[23][mod.MCMOption.Settings["Tainted Cain"]],EID.descriptions["spa"].birthright[24][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_JUDAS_B, mod.EBEIDDesc.SPA[24][mod.MCMOption.Settings["Tainted Judas"]],EID.descriptions["spa"].birthright[25][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_XXX_B, mod.EBEIDDesc.SPA[25][mod.MCMOption.Settings["Tainted Blue Baby"]],EID.descriptions["spa"].birthright[26][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_EVE_B, mod.EBEIDDesc.SPA[26][mod.MCMOption.Settings["Tainted Eve"]],EID.descriptions["spa"].birthright[27][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_SAMSON_B, mod.EBEIDDesc.SPA[27][mod.MCMOption.Settings["Tainted Samson"]],EID.descriptions["spa"].birthright[28][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_AZAZEL_B, mod.EBEIDDesc.SPA[28][mod.MCMOption.Settings["Tainted Azazel"]],EID.descriptions["spa"].birthright[29][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS_B, mod.EBEIDDesc.SPA[29][mod.MCMOption.Settings["Tainted Lazarus"]],EID.descriptions["spa"].birthright[30][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_LAZARUS2_B, mod.EBEIDDesc.SPA[29][mod.MCMOption.Settings["Tainted Lazarus"]],EID.descriptions["spa"].birthright[39][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_EDEN_B, mod.EBEIDDesc.SPA[30][mod.MCMOption.Settings["Tainted Eden"]],EID.descriptions["spa"].birthright[31][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_THELOST_B, mod.EBEIDDesc.SPA[31][mod.MCMOption.Settings["Tainted Lost"]],EID.descriptions["spa"].birthright[32][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_LILITH_B, mod.EBEIDDesc.SPA[32][mod.MCMOption.Settings["Tainted Lilith"]],EID.descriptions["spa"].birthright[33][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_KEEPER_B, mod.EBEIDDesc.SPA[33][mod.MCMOption.Settings["Tainted Keeper"]],EID.descriptions["spa"].birthright[34][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_APOLLYON_B, mod.EBEIDDesc.SPA[34][mod.MCMOption.Settings["Tainted Apollyon"]],EID.descriptions["spa"].birthright[35][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_THEFORGOTTEN_B, mod.EBEIDDesc.SPA[35][mod.MCMOption.Settings["Tainted Forgotten"]],EID.descriptions["spa"].birthright[36][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_THESOUL_B, mod.EBEIDDesc.SPA[35][mod.MCMOption.Settings["Tainted Forgotten"]],EID.descriptions["spa"].birthright[41][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_BETHANY_B, mod.EBEIDDesc.SPA[36][mod.MCMOption.Settings["Tainted Bethany"]],EID.descriptions["spa"].birthright[37][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_JACOB_B, mod.EBEIDDesc.SPA[37][mod.MCMOption.Settings["Tainted Jacob"]],EID.descriptions["spa"].birthright[38][1],"spa")
		EID:addBirthright(PlayerType.PLAYER_JACOB2_B, mod.EBEIDDesc.SPA[37][mod.MCMOption.Settings["Tainted Jacob"]],EID.descriptions["spa"].birthright[39][1],"spa")

		local stringEN,stringRU,stringSPA = {}, {}, {}
		for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
			player = player:ToPlayer()
			local playerID = player:GetPlayerType()
			local i,j,name = 1,2,1
			if playerID == PlayerType.PLAYER_ISAAC then i,j,name = 1,mod.MCMOption.Settings["Isaac"],1
			elseif playerID == PlayerType.PLAYER_MAGDALENA then i,j,name = 2,mod.MCMOption.Settings["Magdalene"],2
			elseif playerID == PlayerType.PLAYER_CAIN then i,j,name = 3,mod.MCMOption.Settings["Cain"],3
			elseif playerID == PlayerType.PLAYER_JUDAS then i,j,name = 4,mod.MCMOption.Settings["Judas"],4
			elseif playerID == PlayerType.PLAYER_BLACKJUDAS then i,j,name = 5,mod.MCMOption.Settings["Dark Judas"],13
			elseif playerID == PlayerType.PLAYER_XXX then i,j,name =6,mod.MCMOption.Settings["Blue Baby"],5
			elseif playerID == PlayerType.PLAYER_EVE then i,j,name =7,mod.MCMOption.Settings["Eve"],6
			elseif playerID == PlayerType.PLAYER_SAMSON then i,j,name =8,mod.MCMOption.Settings["Samson"],7
			elseif playerID == PlayerType.PLAYER_AZAZEL then i,j,name =9,mod.MCMOption.Settings["Azazel"],8
			elseif playerID == PlayerType.PLAYER_LAZARUS then i,j,name =10,mod.MCMOption.Settings["Lazarus"],9
			elseif playerID == PlayerType.PLAYER_LAZARUS2 then i,j,name =11,mod.MCMOption.Settings["Lazarus Risen"],12
			elseif playerID == PlayerType.PLAYER_EDEN then i,j,name =12,mod.MCMOption.Settings["Eden"],10
			elseif playerID == PlayerType.PLAYER_THELOST then i,j,name =13,mod.MCMOption.Settings["The Lost"],11
			elseif playerID == PlayerType.PLAYER_LILITH then i,j,name =14,mod.MCMOption.Settings["Lilith"],14
			elseif playerID == PlayerType.PLAYER_KEEPER then i,j,name =15,mod.MCMOption.Settings["Keeper"],15
			elseif playerID == PlayerType.PLAYER_APOLLYON then i,j,name =16,mod.MCMOption.Settings["Apollyon"],16
			elseif playerID == PlayerType.PLAYER_THEFORGOTTEN then i,j,name =17,mod.MCMOption.Settings["The Forgotten"],17
			elseif playerID == PlayerType.PLAYER_THESOUL then i,j,name =17,mod.MCMOption.Settings["The Forgotten"],18
			elseif playerID == PlayerType.PLAYER_BETHANY then i,j,name =18,mod.MCMOption.Settings["Bethany"],19
			elseif playerID == PlayerType.PLAYER_JACOB then i,j,name =19,mod.MCMOption.Settings["Jacob"],20
			elseif playerID == PlayerType.PLAYER_ESAU then i,j,name =20,mod.MCMOption.Settings["Esau"],21
			elseif playerID == PlayerType.PLAYER_ISAAC_B then i,j,name =21,mod.MCMOption.Settings["Tainted Isaac"],22
			elseif playerID == PlayerType.PLAYER_MAGDALENA_B then i,j,name =22,mod.MCMOption.Settings["Tainted Magdalene"],23
			elseif playerID == PlayerType.PLAYER_CAIN_B then i,j,name =23,mod.MCMOption.Settings["Tainted Cain"],24
			elseif playerID == PlayerType.PLAYER_JUDAS_B then i,j,name =24,mod.MCMOption.Settings["Tainted Judas"],25
			elseif playerID == PlayerType.PLAYER_XXX_B then i,j,name =25,mod.MCMOption.Settings["Tainted Blue Baby"],26
			elseif playerID == PlayerType.PLAYER_EVE_B then i,j,name =26,mod.MCMOption.Settings["Tainted Eve"],27
			elseif playerID == PlayerType.PLAYER_SAMSON_B then i,j,name =27,mod.MCMOption.Settings["Tainted Samson"],28
			elseif playerID == PlayerType.PLAYER_AZAZEL_B then i,j,name =28,mod.MCMOption.Settings["Tainted Azazel"],39
			elseif playerID == PlayerType.PLAYER_LAZARUS_B then i,j,name =29,mod.MCMOption.Settings["Tainted Lazarus"],30
			elseif playerID == PlayerType.PLAYER_LAZARUS2_B then i,j,name =29,mod.MCMOption.Settings["Tainted Lazarus"],39
			elseif playerID == PlayerType.PLAYER_EDEN_B then i,j,name =30,mod.MCMOption.Settings["Tainted Eden"],31
			elseif playerID == PlayerType.PLAYER_THELOST_B then i,j,name =31,mod.MCMOption.Settings["Tainted Lost"],32
			elseif playerID == PlayerType.PLAYER_LILITH_B then i,j,name =32,mod.MCMOption.Settings["Tainted Lilith"],33
			elseif playerID == PlayerType.PLAYER_KEEPER_B then i,j,name =33,mod.MCMOption.Settings["Tainted Apollyon"],34
			elseif playerID == PlayerType.PLAYER_APOLLYON_B then i,j,name = 34,mod.MCMOption.Settings["Tainted Apollyon"],35
			elseif playerID == PlayerType.PLAYER_THEFORGOTTEN_B then i,j,name =35,mod.MCMOption.Settings["Tainted Forgotten"],36
			elseif playerID == PlayerType.PLAYER_THESOUL_B then i,j,name =35,mod.MCMOption.Settings["Tainted Forgotten"],41
			elseif playerID == PlayerType.PLAYER_BETHANY_B then i,j,name =36,mod.MCMOption.Settings["Tainted Bethany"],37
			elseif playerID == PlayerType.PLAYER_JACOB_B then i,j,name = 37,mod.MCMOption.Settings["Tainted Jacob"],38
			elseif playerID == PlayerType.PLAYER_JACOB2_B then i,j,name = 37,mod.MCMOption.Settings["Tainted Jacob"],39 end
			local birthrightDesc = EID:getDescriptionEntry("birthright", playerID+1)
			local playerName = birthrightDesc[1] or player:GetName()
			local icon = EID:getIcon("Player"..playerID) ~= EID.InlineIcons["ERROR"] and "{{Player"..playerID.."}}" or "{{CustomTransformation}}"
			stringEN[i] = "#"..icon.." {{ColorGray}}"..playerName.."{{CR}}#"..mod.EBEIDDesc.EN[i][j]
			stringRU[i] = "#"..icon.." {{ColorGray}}"..playerName.."{{CR}}#"..mod.EBEIDDesc.RU[i][j]
			stringSPA[i] = "#"..icon.." {{ColorGray}}"..playerName.."{{CR}}#"..mod.EBEIDDesc.SPA[i][j]
			
		end
		local longStringEN,longStringRU,longStringSPA = "","",""
		for i = 1,37 do
			if stringEN[i] then
				longStringEN = longStringEN..stringEN[i]
				longStringRU = longStringRU..stringRU[i]
				longStringSPA = longStringSPA..stringSPA[i]
			end
		end
		EID:addCollectible(mod.substituteBirthright, longStringEN,"Birthright")
		EID:addCollectible(mod.substituteBirthright, longStringRU,"Право первородства","ru")
		EID:addCollectible(mod.substituteBirthright, longStringSPA,"Primogenitura","spa")
	
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.BirthrightDesc)