local mod = ExtraBirthright

mod.FakeBirthrightDesc = {
	{en = {"Pocket destiny"}, ru = {"Судьба в кармане"}, es = {"Destino de bolsillp"}}, --Isaac
	{en = {"Lovely looks","Script from the past"}, ru = {"Прекрасная внешность", "Рукопись из прошлого"}, es = {"De apariencia bonita","Escritos del pasado"}}, --Magdalene
	{en = {"Bloody loot","Locks don't stand a chance"}, ru = {"Кровавая добыча", "У замков нет шанса"}, es = {"Botín sangriento","Maestro de las cerraduras"}}, --Cain
	{en = {"The inner demon","Knowledge is power"}, ru = {"Внутренний демон","Знание - сила"},es = {"Demonios internos","El conocimiento es poder"}}, --Judas
	{en = {"Soul power"}, ru = {"Сила души"},es = {"El poder de tu alma"}}, --Blue Baby
	{en = {"Your very own murder", "Birds of prey"}, ru = {"Твой личный убийца","Хищные птицы"},es = {"Tu propio asesinato","Aves de presa"}}, --Eve
	{en = {"Rock and throw"}, ru = {"Бери и бросай"}, es = {"¡A rockear!"}}, --Samson
	{en = {"Hell circle"}, ru = {"Адский круг"}, es = {"Círculo infernal"}}, --Azazel
	{en = {"Rebirth"}, ru = {"Перерождение"}, es = {"Renacimiento"}}, --Lazarus
	{en = {"Random effect"}, ru = {"Случайный эффект"}, es = {"Efecto aleatorio"}}, --Eden
	{en = {"Last chance"}, ru = {"Последний шанс"}, es = {"Una última oportunidad"}}, --The Lost
	{en = {"Rebirthed"}, ru = {"Перерожденный"}, es = {"Renacido"}}, -- Lazarus Risen
	{en = {"Payback","Knowledge is power"}, ru = {"Расплата","Знание - сила"}, es = {"Venganza","El conocimiento es poder"}}, --Dark Judas
	{en = {"Motherhood"}, ru = {"Материнство"}, es = {"Maternidad"}}, --Lilith
	{en = {"Free deal"}, ru = {"Сделка за бесплатно"}, es = {"Es un trato"}}, --Keeper
	{en = {"Stronger void"}, ru = {"Усиленная пустота"}, es = {"Vacío potenciado"}}, --Apollyon
	{en = {"You're falling apart..."}, ru = {"Ты рассыпаешься..."}, es = {"Te caes a pedazos..."}}, --The Forgotten
	{en = {"You're fading away..."}, ru = {"Ты исчезаешь..."}, es = {"Te estás desvaneciendo..."}}, --The Soul
	{en = {"Blessed"}, ru = {"Благословенная"}, es = {"Bendecida"}}, --Bethany
	{en = {"Trade"}, ru = {"Обмен"}, es = {"Intercambio"}}, --Jacob
	{en = {"Faithless reward"}, ru = {"Вероломный награда"}, es = {"Recompensa impía"}}, --Esau
	{en = {"Destiny-"}, ru = {"Судьба-"}, es = {"Destino-"}}, --Tainted Isaac
	{en = {"Wounds heal"}, ru = {"Раны заживают"}, es = {"Herir te curará"}}, --Tainted Magdalene
	{en = {"Destiny stealer"}, ru = {"Похититель судьбы"}, es = {"Ladrón del destino"}}, --Tainted Cain
	{en = {"Master of shadows"}, ru = {"Мастер теней"}, es = {"Maestro de las sombras"}}, --Tainted Judas
	{en = {"Stinky friends"}, ru = {"Вонючие друзья"}, es = {"Amigos apestosos"}}, --Tainted Blue Baby
	{en = {"Stronger clots"}, ru = {"Усиленные сгусточки"}, es = {"Coágulos fortalecidos"}}, --Tainted Eve
	{en = {"Controlled rage"}, ru = {"Контролируеммая ярость"}, es = {"Ira controlada"}}, --Tainted Samson
	{en = {"Wings of destruction"}, ru = {"Крылья разрушения"}, es = {"Alas de la destrucción"}}, --Tainted Azazel
	{en = {"Alive and Dead"}, ru = {"Живой и мёртвый"}, es = {"Vivo y muerto"}}, --Tainted Lazarus
	{en = {"Random effect?","Random effect?"}, ru = {"Случайный эффект?","Случайный эффект?"}, es = {"¿Efecto aleatorio?","¿Efecto aleatorio?"}}, --Tainted Eden
	{en = {"Holy protection"}, ru = {"Святая защита"}, es = {"Protección divina"}}, --Tainted Lost
	{en = {"Hemorrhage"}, ru = {"Кровотечение"}, es = {"Hemorragia"}}, --Tainted Lilith
	{en = {"Power of Greed"}, ru = {"Сила Жадности"}, es = {"El poder de la codicia"}}, --Tainted Keeper
	{en = {"Locusts of apocalypse","God flies"}, ru = {"Саранча апокалипсиса","Божественные мухи"}, es = {"Langostas del apocalipsis","Moscas angelicales"}}, --Tainted Apollyon
	{en = {"Bone shield"}, ru = {"Костяной щит"}, es = {"Escudo esquelético"}}, --Tainted Forgotten
	{en = {"Better wisps"}, ru = {"Огоньки получше"}, es = {"Mejores flamas"}}, --Tainted Bethany
	{en = {"No mercy","Forgiven Soul"}, ru = {"Без пощады","Прощённая душа"}, es = {"Sin piedad","Alma perdonada"}}, --Tainted Jacob
	{en = {"Dead and Alive"}, ru = {"Мёртвый и живой"}, es = {"Vivo y muerto"}}, --Tainted Dead Lazarus
	{en = {"No mercy","Forgiven Soul"}, ru = {"Без пощады","Прощённая душа"}, es = {"Sin piedad","Alma perdonada"}}, --Tainted Jacob Lost
	{en = {"Bone shield"}, ru = {"Костяной щит"}, es = {"Escudo esquelético"}} --Tainted Soul
}

mod.EBEIDDesc = {}
if EID then
mod.EBEIDDesc = {
	en = {
		{"{{Collectible105}}D6 becomes pocket active#Has a chance to reroll into item from {{TreasureRoom}}Treasure, {{AngelRoom}}Angel or {{DevilRoom}}Devil pools"}, -- Isaac
		{"Chance to charm enemy in radius of 50#{{Collectible45}}Yum Heart heals 2 {{Heart}}red hearts instead of one", "↑Speed up. Speed is linked to number of {{HalfHeart}}red hearts#Speed = speed + ({{HalfHeart}} * 0.06)#Gains 1 {{SoulHeart}}soul heart when entering new level"}, -- Maggie
		{"Enemies have a chance to drop pickups#Champions drop 2 similar pickups#If there is boss in room, clearing it has a chance to spawn an item from room's item pool","Cain always has {{GoldenKey}}Golden Key"},--Cain
		{"Spawns 3 nickels on pickup#↑ +5.0 Damage up and {{Collectible118}}Brimstone effect when getting hit for current room. 20% chance to proc","Using books activates {{Collectible35}}Necronomicon effect"},--Judas
		{"↑{{SoulHeart}}Soul hearts give Damage up, Tears up, Speed up and Range up depending on their number#Non soul hearts become other pickups"},--Blue Baby
		{"Getting hit will occasionally spawn additional Dead Birds that persist between rooms"},--Eve
		{"↑ +4 Damage up#Gets ability to pick up and throw objects"},--Samson
		{"20% chance to shoot in 8 directions on hit"},--Azazel
		{"Gives pocket item Haven's Call on pickup and on new floor#Using Haven's Call will kill Lazarus and damage enemies in room"},--Lazarus
		{"33% chance get random passive item effect when entering room"},--Eden
		{"The Lost gets revived with copies of all of his items (besides birthright, active and story items), but he can't have {{Collectible313}}Holy Mantle effect. You can get mantle effect by using {{Card51}}Holy Card but only for current room. After that effect disappears"},--Lost
		{"Gives pocket item Haven's Call on pickup and on new floor#Gives 3 random Angel items (contributes to Seraphim) and Seraphim semi-transformation for the floor#Using Haven's Call gives 3 random Angel items for current room"},--Lazarus Risen
		{"Activates {{Collectible35}}Necronomicon effect when getting hit","Using books activates {{Collectible35}}Necronomicon effect"},--Dark Judas
		{"Spawns 2 mini Isaacs when entering hostile room, 4 - big room#All mini Isaac despawn when going to new level#{{Collectible357}}Box of Friends now duplicates mini Isaacs for current room"},--Lilith
		{"One item or pickup that costs money is free per level#Shops (and secret rooms) won't have Greed / Super Greed#Shops will spawn in Womb and Corpse"},--Keeper
		{"{{Collectible477}}Void becomes pocket active#If there're are cards and/or pills in room, they will be stored#If there're cards and/or pills stored, they will be used at the same time"},--Apollyon
		{"Loosing Bone heart will create 6-9 bone orbitals"},--Forgotten
		{"Loosing Soul heart will create 1-3 wisps"},--Soul
		{"Curses become blessings#100% chance to get a random blessing or curse's opposite"},--Bethany
		{"Esau gives half of his non story passive items to Jacob in exchange for {{Collectible621}}Red Stew"}, --Jacob
		{"100% chance for extra reward spawning after clearing room#Only items of quality 2 and 3 will appear# {{DevilRoom}}Devil rooms have flat 50% chance to spawn# {{AngelRoom}}Angel rooms can't appear"}, -- Esau
		{"{{Collectible723}}Spindown dice becomes a pocket active#On use 10% chance for Soul of Isaac effect to proc"}, -- Tainted Isaac
		{"Regenerates {{Heart}} red heart when room is cleared"}, -- Tainted Magdalene
		{"Tainted Cain can pick up 1 item on current floor#Chance to pick up {{Collectible619}}Birthright without reducing it into pickups, if Tainted Cain doesn't have one#!!! Chance can be modified in Mod Config Menu settings. By default value is 0"}, -- Tainted Cain
		{"{{Collectible705}}Dark Arts become Twisted Arts#Using Twisted Arts will freeze time in a room#Longer duration compared to Dark Arts"},--Tainted Judas
		{"Chance to poop out friendly dip#Having special items have a chance to get different type of dip"}, -- Tainted BB
		{"Chance to spawn additional clot for free#Сlot take more hits to be killed"},--Tainted Eve
		{"Berserk charges faster#Berserk activates on player's command (by pressing {{ButtonRT}} button)"}, -- Tainted Samson
		{"Gets {{Collectible118}}Brimstone effect and ability to fly"},--Tainted Azazel
		{"{{Collectible711}}Flip charges over time"},--Tainted Lazarus
		{"Every new room or on every hit changes to effect of one of the other characters","Every new room or on every hit changes to effect of one of the other characters (second effect)"}, -- Tainted Eden
		{"Has a 50% chance for an uncleared room or 100% chance for Boss or Boss Rush room to add {{Collectible313}}Holy Mantle effect to that room"}, -- Tainted Lost
		{"Spawn red creep that deals 250% damage#Every time Tainted Lilith shoots umbilical baby (fetus) spawns red creep trail that deals 150% damage"},--Tainted Lilith
		{"Picking up coins gives temporary damage that wears off over time"}, -- Tainted Keeper
		{"Spawns 20 random horsemen locusts on pickup#2-5 random horsemen locusts spawn when entering hostile room","Gives abyss locust a small {{Collectible331}}Godhead aura"},--Tainted Apollyon
		{"Soul gets up to 5 bone orbitals in every hostile room"}, -- Tainted Forgotten
		{"Item wisps shoot homing tears with Tainted Bethany's tear rate and deal 40% of her damage#Wisps take more hits to be destroyed"},--Tainted Bethany
		{"↑ {{Heart}} +1 Health up, {{Damage}} +50% Damage Multiplier, {{Tears}} +1 Tears up, {{Speed}} +0.3 Speed up#Dark Esau targets enemy that damaged Tainted Jacob until it's dead#{{TreasureRoom}}Treasure, {{SecretRoom}}Secret/{{SuperSecretRoom}}Super Secret and {{DevilRoom}}Devil rooms contain twise more items#Tainted Jacob dies in any form from Dark Esau's damage", "Dark Esau becomes friendly and targets enemies"},--Tainted Jacob
		{"{{Collectible711}}Flip charges over time"},--Tainted Dead Lazarus
		{"↑ {{Heart}} +1 Health up, {{Damage}} +50% Damage Multiplier, {{Tears}} +1 Tears up, {{Speed}} +0.3 Speed up#Dark Esau targets enemy that damaged Tainted Jacob until it's dead#{{TreasureRoom}}Treasure, {{SecretRoom}}Secret/{{SuperSecretRoom}}Super Secret and {{DevilRoom}}Devil rooms contain twise more items#Tainted Jacob dies in any form from Dark Esau's damage", "Dark Esau becomes friendly and targets enemies"},--Tainted Jacob Lost
		{"Soul gets up to 5 bone orbitals in every hostile room"}, -- Tainted Forgotten Soul
	},
	ru =
		{
		{"{{Collectible105}}D6 становится карманным предметом#Есть шанс поменять на предмет из пула {{TreasureRoom}}Комнаты Сокровищ, {{AngelRoom}}Комнаты Ангела или {{DevilRoom}}Комнаты Дьявола"}, -- Isaac
		{"Шанс очаровать врага в радиусе 50#{{Collectible45}}Ням сердце лечит 2 {{Heart}}красных сердца вместо одного","↑Увеличение скорости. Скорость привязана к {{HalfHeart}}красным сердцам#Скорость = скорость + ({{HalfHeart}} * 0.06)#Получает 1 {{SoulHeart}}синее сердце при переходе на новый уровень"}, -- Maggie
		{"Есть шанс, что из врагов выпадет подбираемый предмет#Из чемпионов выпадает 2 одинаковых предмета#Если в комнате был босс, зачистив её есть шанс на появление предмета из пула текущей комнаты","У Кайна всегда {{GoldenKey}}золотой ключ"},--Cain
		{"При подборе появляются 3 пятака#↑ +5.0 к урону и эффект {{Collectible118}}Серы при получении урона в данной комнате. 20% шанс на срабатывание","Использование книг активирует эффект {{Collectible35}}некрономикона"},--Judas
		{"↑{{SoulHeart}}Синие сердца увеличивают урон, скорострельность, скорость и дальность в зависимости от их количества#Не синие серца превращаются в другие предметы"},--Blue Baby
		{"Получение урона иногда порождает дополнительных мертвых птиц, которые остаются при переходе в другие комнаты"},--Eve
		{"↑ +4 к урону#Получает способность поднимать и кидать объекты"},--Samson
		{"20% шанс выстрелить в 8 направлениях при получении урона"},--Azazel
		{"Даёт карманный предмет Зов Небес при получении и на новом этаже#Используя Зов Небес Лазарь умрёт и нанесёт урон по врагам в комнате"},--Lazarus
		{"33% шанс получить эффект случайого пассивного предмета при входе в комнату"},--Eden
		{"Потерянный возрождается с копиями всех его предметов (кроме права первородства, активных и сюжетных предметов), но у него не может быть эффекта {{Collectible313}}Святой мантии. Вы можете получить эффект мантии, используя {{Card51}}Святую карту, но только для текущей комнаты. После этого эффект исчезает"},--Lost
		{"Даёт карманный предмет Зов Небес при получении и на новом этаже#Даёт 3 случайных ангельских предмета (которые дают Серафима) и полутрансформацию в Серафима на этаж#Используя Зов Небес даёт 3 случайных ангельских предмета на комнату"},--Lazarus Risen
		{"Активируется эффект {{Collectible35}}некрономикона при получении урона","Использование книг активирует эффект {{Collectible35}}некрономикона"},--Dark Judas
		{"Появляются 2 мини Исаака, когда заходите в комнату с врагами, 4 - в большую комнату#Все мини Исааки исчезают при переходе на новый уровень#{{Collectible357}}Коробка с друзьями теперь дублирует мини Исааков в текущей комнате"},--Lilith
		{"Один бесплатный предмет или подбираемый предмет на каждом уровене#В магазинах (и секретных комнатах) не будет Жадности / Супер Жадности#Магазины будут появлятся в Матке и Трупе"},--Keeper
		{"{{Collectible477}}Пустота становится карманным предметом#Если в комнате есть карты и/или пилюли, они будут поглащены#Если есть уже поглащенные карты и/или пилюли, они будут использованы одновременно"},--Apollyon
		{"Теряя костяное сердце создает 6-9 орбитальных костей"},--Forgotten
		{"Теряя синее сердце создает 1-3 виспа"},--Soul
		{"Проклятия становятся благословениями#100% шанс получить случайное благословение или противоположное проклятию"},--Bethany
		{"Исав отдает половину своих несюжетных пассивных предметов Якову в обмен на {{Collectible621}}Красною похлёбку"}, -- Jacob
		{"100% шанс появления дополнительной награды после зачистки комнаты#Только предметы качества 2 и 3 будут появляться# {{DevilRoom}}Дьявольские комнаты имеют постоянный 50% шанс появления# {{AngelRoom}}Ангельские комнаты не могут появиться"}, -- Esau
		{"{{Collectible723}}Кубик с вычетом становится карманным предметом#10% шанс еффекта Души Исаака при использовании"}, -- Tainted Isaac
		{"Восстанавливает {{Heart}}красное сердце когда комната зачищена"}, -- Tainted Magdalene
		{"Порченный Кайн может подобрать 1 предмет на текущем этаже#Шанс подобрать {{Collectible619}}Право первородства, не превращая его в подбираемые предметы, если у порченного Кайна его нет#!!! Шанс монжно изменить в настройках Mod Config Menu. По умолчанию значение 0"}, -- Tainted Cain
		{"{{Collectible705}}Тёмные силы становятся Twisted Arts#При использовании Twisted Arts время в комнате остановливается#Дольше длительность по сравнению с Тёмными силами"},--Tainted Judas
		{"Шанс выкакать дружественную какашку-дипа#Имея особые предметы есть шанс получить другой тип какашки"}, -- Tainted BB
		{"Шанс на появление дополнительного сгусточка#Сгусточкам нужно получить больше урона, чтобы умереть"},--Tainted Eve
		{"Берсерк заряжается быстрее#Берсерк активируется по команде игрока (нажав кнопку {{ButtonRT}})"}, -- Tainted Samson
		{"Получает эффект {{Collectible118}}Серы и способность летать"},--Tainted Azazel
		{"Заряд {{Collectible711}}Кувырка восстонавливается со временем"},--Tainted Lazarus
		{"Каждую новую комнату или при получении урона меняет эффект на эффект одного из персонажей","Каждую новую комнату или при получении урона меняет эффект на эффект одного из персонажей (второй эффкет)"}, -- Tainted Eden
		{"50% шанс для незачищенной комнаты или 100% шанс для комнат с боссами или комнаты Босс Раша дать эффект {{Collectible313}}Святой мантии для этой комнаты"}, -- Tainted Lost
		{"Создает красную лужу которая наносит 250% урона#Каждый раз когда Лилит выстреливает ребёнком с пуповиной (зародышем), создаётся след из кровавых луж, которые наносят 150% урона"},--Tainted Lilith
		{"Даёт временный урон при подборе монет, который уменьшается со временем"}, -- Tainted Keeper
		{"При подборе появляются 20 саранчи всадников#2-5 саранчи всадников появляются, когда заходите в комнату с врагами","Даёт саранче бездны маленькую ауру {{Collectible331}}Божественности"},--Tainted Apollyon
		{"У Души появляются до 5 костяных орбиталей в каждой враждебной комнате"}, -- Tainted Forgotten
		{"Огоньки предметов стреляют самонаводящимися слезами со скорострельностью Порченой Вифании и 40% её урона#Огонькам нужно получить больше урона, чтобы их уничтожить"},--Tainted Bethany
		{"↑ {{Heart}} +1 к здоровью, {{Damage}} +50% множитель урона, {{Tears}} +1 к скорострельности, {{Speed}} +0.3 к скорости#Тёмный Исав фокусируется на живом враге, который нанес урон Порченному Иакову#{{TreasureRoom}}В Комнатах Сокровищ, {{SecretRoom}}Секретных/{{SuperSecretRoom}}Супер Секретных и {{DevilRoom}}Дьявольских комнатах находятся в два раза больше предметов#Порченный Иаков умирает в любой форме от урона Тёмного Исава", "Тёмный Исав становится дружелюбным и преследует врагов"},--Tainted Jacob
		{"Заряд {{Collectible711}}Кувырка восстонавливается со временем"},--Tainted Dead Lazarus
		{"↑ {{Heart}} +1 к здоровью, {{Damage}} +50% множитель урона, {{Tears}} +1 к скорострельности, {{Speed}} +0.3 к скорости#Тёмный Исав фокусируется на живом враге, который нанес урон Порченному Иакову#{{TreasureRoom}}В Комнатах Сокровищ, {{SecretRoom}}Секретных/{{SuperSecretRoom}}Супер Секретных и {{DevilRoom}}Дьявольских комнатах находятся в два раза больше предметов#Порченный Иаков умирает в любой форме от урона Тёмного Исава", "Тёмный Исав становится дружелюбным и преследует врагов"},--Tainted Jacob Lost
		{"У Души появляются до 5 костяных орбиталей в каждой враждебной комнате"}, -- Tainted Forgotten Soul
	},
es = {
		{"{{Collectible105}} El D6 se convierte en un activo de bolsillo#Tiene la posibilidad de rerollear entre la pool del {{TreasureRoom}}Tesoro, {{AngelRoom}}Ángel o {{DevilRoom}}Diablo"}, -- Isaac
		{"Posibilidad de encantar enemigos en un radio de 50#{{Collectible45}}Delicioso Corazón cura 2 {{Heart}} corazones rojos en vez de 1", "↑ más velocidad. La velocidad está relacionada con los {{HalfHeart}} corazones rojos#Velocidad = velocidad + ({{HalfHeart}} * 0.06)#Ganas 1 {{SoulHeart}} corazón de alma al llegar a un nuevo piso"}, -- Maggie
		{"Los enemigos tienen la posibilidad de soltar un recolectable#Los enemigos campeones sueltan 2 recolectables similares#Si en la habitación hay un jefe, Limpiarla dará la posibilidad un objeto de la pool de la habitación actual","Cain siempre tendrá una {{GoldenKey}}llave dorada"},--Cain
		{"Genera 3 nickels#Judas has tiene 20% de posibilidad de obtener ↑ {{Damage}} daño +5.0 y {{Collectible118}} Azufre al recibir daño, dura toda la habitación","Usar libros activa el efecto de {{Collectible35}} El Necronomicón"},--Judas		
		{"↑ {{SoulHeart}} Los corazones de alma dan un aumento de: {{Damage}} daño, {{Tears}} lágrimas, {{Speed}} velocidad y {{Range}} alcance en base a cuantos tengas#Los otros corazones se convertirán en otros recolectables"},--Blue Baby
		{"Recibir golpes podrá generar Aves muertas que persisten entre salas"},--Eve
		{"↑ {{Damage}} Daño +4#Adquieres la capacidad de tomar y lanzar cosas"},--Samson
		{"20% de posibilidad de disparar en 8 direcciones al recibir daño"},--Azazel
		{"Recibe el objeto de bolsillo Llamada de los Cielos al tomar Primogenitura y al cambiar de piso#Llamada de los Cielos matará a Lázaro y dañará a los enemigos en la sala"},--Lazarus		
		{"33% de posibilidad de conseguir el efecto de un objeto pasivo aleatorio al entrar a una sala"},--Eden
		{"El perdido revivirá con una copia de sus objetos (excepto Primogenitura y los objetos de la historia), Pero no tendrá el efecto del {{Collectible313}} Manto Sagrado#{{Card51}} Puedes ganar el efeco del manto usando una Carta Sagrada pero sólo durante la sala, salir de ella hará que el efecto desaparezca"},--Lost
		{"Recibe el objeto de bolsillo Llamada de los Cielos al tomar Primogenitura y al cambiar de piso#{{AngelRoom}} Recibes tres objetos de la sala del angel y la transdormación de Serafín durante el piso#Usar Llamada de los Cielos dará 3 objetos aleatorios de la sala del angel durante la sala"},--Lazarus Risen
		{"Activas el efecto de {{Collectible35}} El Necronomicón al recibir daño","Usar libros activa el efecto de {{Collectible35}} El Necronomicón"},--Dark Judas
		{"Genera 2 mini Isaacs al entrar a una habitación hostil, 4 en habitaciones grandes#Todos los mini Isaacs desaparecen al avanzar al siguiente piso#{{Collectible357}}La Caja de Amigos ahora duplica a los mini Isaacs durante la habitación"},--Lilith
		{"Un objeto o recolectable que cueste dinero será gratis por nivel#Las tiendas (y salas secretas) no tendrán a Avaricia ni a Superavaricia, las tiendas aparecerán en la Matriz y el Cadaver"},--Keeper
		{"{{Collectible477}} Vacío será un objeto de bolsillo#Si hay cartas o píldoras en la habitación al usarlo, serán guardadas#Si hay cartas o píldoras guardadas, todas serán usadas al mismo tiempo"},--Apollyon
		{"{{EmptyBoneHeart}} Perder un corazón de hueso creará de 6 a 9 huesos orbitales"},--Forgotten
		{"{{SoulHeart}} Perder un corazón de alma generará de 1 a 3 flamas"},--Soul
		{"Las maldiciones se convierten en bendiciones#100% de posibilidad de tener una bendición o invertir una maldición"},--Bethany
		{"Esaú dará la mitad de sus objetos (no relacionados a la historia) a cambio del {{Collectible621}} Guisado Rojo"}, -- Jacob
		{"100% de posibilidad una recompensa extra al limpiar una sala#Sólo podrán aparecer objetos de calidad {{Quality2}} o {{Quality3}}#{{DevilChance}} La posibilidad de pacto con el Diablo se fijará en 50%#{{AngelChance}} Las Salas de Ángel no podrán aparecer"}, -- Esau
		{"{{Collectible723}} El Dado Reductor se convierte en un activo de bolsillo#{{Card81}} 10% de activar el efecto del Alma de Isaac al usarlo"}, -- Tainted Isaac
		{"Regenera {{Heart}} un corazón rojo al limpiar una habitación"}, -- Tainted Magdalene
		{"Caín contaminado podrá tomar un objeto por piso#Posibilidad de que {{Collectible619}} Primogenitura no se convierta en recolectables, en caso de que Caín contaminado no lo tenga#!!! Esta posibilidad se puede alterar en Mod Config Menu, por defecto está en 0"}, -- Tainted Cain
		{"{{Collectible705}} Artes Oscuras se convierte en Artes Retorcidas (Twisted Arts)#Usar Artes Retorcidas congelará el tiempo en la habitación#Mayor duración comparado a Artes Oscuras"},--Tainted Judas
		{"Posibilidad de cagar un dip amistoso#Tener ciertos objetos especiales pueden generar distintos tipos de Dips"}, -- Tainted BB
		{"Posibilidad de generar un bebé coágulo de forma gratuita#Los bebés coágulos tardan más en morir"},--Tainted Eve
		{"Berserk se cargará con mayor rapidez#Se podrá activar presionando el botón de soltar {{ButtonRT}}"}, -- Tainted Samson
		{"Recibes {{Collectible118}}Azufre y la capacida de volar"},--Tainted Azazel
		{"{{Collectible711}} Cambio se recarga con el tiempo"},--Tainted Lazarus
		{"Cada nueva sala o cada vez que recibas un golpe obtendrás el efecto de Primogenitura de cualquier otro personaje","Cada nueva sala o cada vez que recibas un golpe obtendrás el efecto de Primogenitura de cualquier otro personaje (2)"}, -- Tainted Eden
		{"50% de probabilidad en una sala sin limpiar, o 100% de probabilidad en sala de jefe o avalancha de jefes, de añadir el efecto del {{Collectible313}}Manto Sagrado durante esa sala"}, -- Tainted Lost
		{"Genera creep rojo que provoca el daño del jugador al 250%#Cada vez que Tainted Lilith lancé al bebé umbilical, este genera un rastro de creep rojo que provoca el daño del jugador al 150%"},--Tainted Lilith
		{"{{Damage}} Tomar monedas dará un aumento de daño que disminuye con el tiempo"}, -- Tainted Keeper
		{"Genera 20 langostas de los jinetes#Se generan 2-5 langostas de los jinetes en una habitación hostil","Otorga a las langostas de Abismo un aura de {{Collectible331}} Divinidad"},--Tainted Apollyon
		{"El alma recibe 5 orbitales de hueso en cada habitación hostil"}, -- Tainted Forgotten
		{"Los fuegos de objetos disparan lágrimas teledirigidas#Escalan con la cadencia de tiro de Bethany Contaminada, hacen el 40% de su daño#Toman más golpes en ser destruídos"},--Tainted Bethany		
		{"↑ {{Heart}} +1 corazón, {{Damage}} Daño x1.5, {{Tears}} Lágrimas +1, {{Speed}} Velocidad +0.3#Esaú Oscuro atacará a quienes dañaron a Jacob Contaminado#Se aplica el efecto de {{Collectible577}} Damocles reducido#Tainted Jacob morirá por cualquier daño de Dark Esau", "Dark Esau se vuelve amigable y apunta a los enemigos"},--Tainted Jacob
		{"{{Collectible711}} Cambio se recarga con el tiempo"},--Tainted Dead Lazarus
		{"↑ {{Heart}} +1 corazón, {{Damage}} Daño x1.5, {{Tears}} Lágrimas +1, {{Speed}} Velocidad +0.3#Esaú Oscuro atacará a quienes dañaron a Jacob Contaminado#Se aplica el efecto de {{Collectible577}} Damocles reducido#Tainted Jacob morirá por cualquier daño de Dark Esau", "Dark Esau se vuelve amigable y apunta a los enemigos"},--Tainted Jacob Lost
		{"El alma recibe 5 orbitales de hueso en cada habitación hostil"}, -- Tainted Forgotten Soul
	}
}
end

local function DoesPlayerApply(player, IsGhostJacob)
	local pType = player:GetPlayerType()
	pType = IsGhostJacob and PlayerType.PLAYER_JACOB_B or pType
	if mod.GetMCMValue(pType) then
		if player:GetMainTwin():GetPlayerType() ~= pType and pType == PlayerType.PLAYER_ESAU and mod.GetMCMValue(pType) == 1
		then
			return false
		end
		return player:GetMainTwin():GetPlayerType() == pType or IsGhostJacob or player:GetMainTwin():GetPlayerType() ~= pType and pType == PlayerType.PLAYER_ESAU and mod.GetMCMValue(pType) > 1
	end
	return false
end

local function BirthrightCondition(descObj)
    return descObj.ObjType == 5 and descObj.ObjVariant == 100 and descObj.ObjSubType == 619
end

local function BirthrightCallback(descObj)
	descObj.Description = ""
	local describedPlayerTypes = {}
	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local playerID = player:GetPlayerType()
		local IsGhostJacob = playerID == PlayerType.PLAYER_JACOB2_B
		playerID = IsGhostJacob and PlayerType.PLAYER_JACOB_B or playerID
		if not player:IsSubPlayer() and DoesPlayerApply(player, IsGhostJacob) and not describedPlayerTypes[playerID] then
			describedPlayerTypes[playerID] = true
			
			local birthrightDesc = EID:getDescriptionEntry("birthright", playerID+1)
			if birthrightDesc ~=nil then
				local playerName = birthrightDesc[1] or player:GetName()
				local birthrightFinalDesc = birthrightDesc[3]
				local mcmVal = mod.GetMCMValue(playerID)
				if mcmVal and mcmVal > 1 then
					local conv = {
						en_us = "en",
						ru = "ru",
						spa = "es"
					}
					local rainbowSeparator = {
						en = "#{{Blank}} {{ColorRainbow}}Extra effects:#",
						ru = "#{{Blank}} {{ColorRainbow}}Дополнительные еффекты:#",
						es = "#{{Blank}} {{ColorRainbow}}Efecto extra:#"
					}
					local maxMCMVal = mod.GetMaxMCMValue(playerID)
					if mcmVal == 2 or mcmVal == 3 and maxMCMVal == 5 then
						local lang = (conv[EID:getLanguage()] and mod.EBEIDDesc[conv[EID:getLanguage()]]) and conv[EID:getLanguage()] or "en"
						birthrightFinalDesc = mod.EBEIDDesc[lang][playerID + 1][mcmVal - 1]
					else
						local lang = (conv[EID:getLanguage()] and mod.EBEIDDesc[conv[EID:getLanguage()]]) and conv[EID:getLanguage()] or "en"
						local val = maxMCMVal == 5 and mcmVal - 3 or mcmVal - 2
						birthrightFinalDesc = birthrightFinalDesc..rainbowSeparator[lang]..mod.EBEIDDesc[lang][playerID + 1][val]
					end
				end
				EID:appendToDescription(descObj, EID:GetPlayerIcon(playerID) .. " {{ColorGray}}"..playerName.."{{CR}}#"..birthrightFinalDesc.."#")
			end
		end
	end
	return descObj
end
if EID then
	EID:addDescriptionModifier("ExtraBirthright Modifier", BirthrightCondition, BirthrightCallback)
end