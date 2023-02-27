if not Encyclopedia then return end
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")
local substituteDarkArts = Isaac.GetItemIdByName("Twisted Arts")
local wiki = {
    BIRTHRIGHT_ALT = {
        { -- Effects
        {str = "Effects", fsize = 2, clr = 3, halign = 0},
        {str = "Gives a alternative passive ability that varies from character to character. The effects are defined related to each character's feature."},
        {str = "- Isaac: D6 becomes pocket active. Can reroll into items from Treasure, Angel or Devil pools."},
        {str = "- Magdalene: "},
        {str = "--  1) Chance to charm nearby emenies. Yum Heart heals two red hearts instead of one;"},
        {str = "--  2) Speed is linked to number of red hearts. Gain 1 Soul Heart when entering new floor."},
        {str = "- Cain: "},
        {str = "--  1) Enemies drop random pickup on death. Bosses - chance for item from room's item pool; "},
        {str = "--  2) Cain always has golden key (Antibirth). "},
        {str = "- Judas: "},
        {str = "-- 1) 3 nickels. Chance to get on hit +5 damage and Brimsone effect for current room;"},
        {str = "-- 2) Using books activates Necronomicon effect (Antibirth)."},
        {str = "- Dark Judas: "},
        {str = "-- 1) Getting hit damages all enemies;"},
        {str = "-- 2) Using books activates Necronomicon effect (Antibirth)."},
        {str = "- ???: Soul hearts boost stats depending on their number. Non soul hearts become other pickup (cards, pills, keys, coins, batteries)."},
        {str = "- Eve: Getting hit will occasionally spawn additional Dead Birds that persist between rooms."},
        {str = "- Samson: Damage up. Samson can pick up and throw objects."},
        {str = "- Azazel: 20% chance to shoot in 8 directions on hit."},
        {str = "- Lazarus: Gives pocket item Haven's Call on pickup and on new floor. Using it will kill Lazarus and deal damage to enemies in the room."},
        {str = "- Lazarus Risen: Gives random 3 items from angel pool and Seraphim semi-transformation for the floor. Using Haven's Call will give 3 angel items for the current room."},
        {str = "- Eden: 25% chance get random passive item effect when entering room."},
        {str = "- The Lost: The Lost gets revived with copies of all of his items doubled (besides birthright, active and story items), but he can't have holy mantle effect. You can get mantle effect by using Holy Card but only for current room. After that effect disappears."},
        {str = "- Lilith: Spawns 2 mini Isaacs when entering hostile room, 4 - big room (L-shaped included). Box of Friends now affects mini Isaacs."},
        {str = "- Keeper: Effects of Silver Dollar and Rib of Greed. One free item per floor that costs money."},
        {str = "- Apollyon: Void becomes pocket active. Voiding passive items with quality higher then 0 will give random extra stat ups with higher quality items giving more stats. Extra stat ups will be given even before getting Birthright and will be added after getting it."},
        {str = "- The Forgotten: Loosing Bone heart will create from 6 to 9 bone orbitals."},
        {str = "- The Soul: Loosing Soul heart will create from 1 to 2 wisps."},
        {str = "- Bethany: Curses become blessings. 100% chance for blessing."},
        {str = "- Jacob: Esau gives half of his non story passive items to Jacob in exchange for Red Stew."},
        {str = "- Esau: 100% chance for rewards to spawn after clearing room. Only devil rooms can appear with 50% chance. Only items of quality 2 and 3 will appear"},
        {str = "- Tainted Isaac: Spindown dice becomes a pocket active and using it has 10% chance for Soul of Isaac effect to proc."},
        {str = "- Tainted Magdalene: Regenerates red heart after clearing room."},
        {str = "- Tainted Cain: Can pickup 1 item on current floor. If Tainted Cain doesn't have Birthright, he has chance to pickup Birthright without it reducing into pickups."},
        {str = "- Tainted Judas: Dark Arts become Twisted Arts. Using Twisted Arts will freeze time in a room. Longer duration compared to Dark Arts."},
        {str = "- Tainted ???: Chance to poop out friendly dip. Having special items have a chance to get different type of dip."},
        {str = "- Tainted Eve: Chance to spawn additional clot of the same type for free. Clots become more durable."},
        {str = "- Tainted Samson: Berserk charges faster and activates on player's command by pressing 'Drop' button."},
        {str = "- Tainted Azazel: Gets Brimstone effect and ability to fly."},
        {str = "- Tainted Lazarus + Dead Tainted Lazarus: Flip charges overtime."},
        {str = "- Tainted Eden: Comming soon."},
        {str = "- Tainted Lost: Comming soon."},
        {str = "- Tainted Lilith: Spawn red creep that deals 250% player's damage. Every time umbilical baby is shot spawns red creep that deals 150% player's damage."},
        {str = "- Tainted Keeper: Picking up coins gives temporary damage up that wears off over time."},
        {str = "- Tainted Apollyon: "},
        {str = "-- 1) Spawns 20 random harbinger locusts on pickup. Entering hostile room will spawn 2-5 random locusts;"},
        {str = "-- 2: Abyss locusts have small Godhead aura. "},
        {str = "- Tainted Forgotten: Comming soon."},
        {str = "- Tainted Bethany: Item wisps shoot homing tears. Tear rate is the same as player's. Wisp's tears deal 40% player's damage."},
        {str = "- Tainted Jacob: "},
        {str = "-- 1) +1 Health up, +50% Damage Multiplier, +1 Tears up and +0.3 Speed up. Dark Esau targets enemy that damaged Tainted Jacob, kills Tainted Jacob in one hit;"},
        {str = "-- 2: Dark Esau becomes friendly and targets enemies."},
        },
    }
}

if Encyclopedia then
	Encyclopedia.AddItem({
    ID = substituteBirthright,
    WikiDesc = wiki.BIRTHRIGHT_ALT,
    Pools = {
        Encyclopedia.ItemPools.POOL_SHOP,
        Encyclopedia.ItemPools.POOL_GREED_SHOP,
    },
})
end