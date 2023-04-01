local mod = ExtraBirthright
local ids = {1,2,3,5,6,8,12,13,14,20,21,29,31,55,57,67,70,71,73,88,91,94,95,96,98,99,100,108,110,112,113,114,115,117,118,120,121,122,128,131,143,144,150,155,163,167,170,172,174,178,187,188,
200,201,206,207,214,217,228,237,240,245,257,259,261,264,265,266,267,268,269,270,271,272,273,274,275,277,278,279,280,281,302,313,317,318,319,320,321,322,342,345,355,360,361,362,363,364,
365,372,374,384,385,387,388,389,390,403,404,411,415,417,418,426,429,430,431,435,436,442,467,468,469,470,471,472,473,491,492,493,496,497,500,508,509,511,518,519,526,528,537,539,542,543,
544,548,565,567,572,575,581,596,607,608,610,615,629,645,649,652,679,681,682,688,698,732}
local Eden = {}
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")
local game = Game()

local function newRoom(player,rng)
    local randItems = ids
    for item = 733, mod.GetMaxCollectibleID() do
        if Isaac.GetItemConfig():GetCollectible(item) then
            local itemConfig = Isaac.GetItemConfig():GetCollectible(item)
            if not player:HasCollectible(item) and itemConfig.Type ~= ItemType.ITEM_ACTIVE
            and itemConfig.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST
            and item ~= substituteBirthright and item ~= Isaac.GetItemIdByName("NOMARKSFORYA")
            then
                table.insert(randItems,item)
            end
        end
    end
    randItems = mod.Shuffle(randItems,rng)
    if #randItems > 0 and rng:RandomInt(100) < 25 then
        local randomItem = rng:RandomInt(#randItems)+1
        game:GetHUD():ShowItemText(player,Isaac.GetItemConfig():GetCollectible(randItems[randomItem]))
        player:UseActiveItem(randItems[randomItem])
    end
end

function Eden:EdenRandomItemEffect()
    if mod.MCMOption.Settings["Eden"] > 1 then
        for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN)) do
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eden"])
            if player:HasCollectible(collectible) then
                newRoom(player,mod.RNG)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Eden.EdenRandomItemEffect)

mod:AddPriorityCallback(mod.Callbacks.MC_POST_NEW_ROOM, PlayerType.PLAYER_EDEN, function()
    for _,player in ipairs(mod:GetPlayersByType(PlayerType.PLAYER_EDEN)) do
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Eden"])
        newRoom(player,mod.RNG)
    end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_EDEN and mod.MCMOption.Settings["Eden"] == 2
end)